var $newDialog;
var strXML;
/**
 * 加载3d堆栈图
 */
function  getZhuData(){
	$newDialog = $("#dialog-new").removeClass("hide").dialog({
		modal: true, //模式对话框
		title: '<i class="ace-icon fa fa-bar-chart-o orange"></i><span class="ui-jqdialog-title" style="float: left;">3D堆叠柱状图</span>',
		title_html: true,
		width:"1000",
		height:"460",
		buttons: [{
			html: '<i class="ace-icon fa fa-check"></i>关闭', //按钮文本
			"class": "btn btn-primary btn-minier",
			click: function() {
				//关闭窗口
				$(this).dialog("close");
			}
		}],
		open:function(){ //加载数据
			//请求的url
			var url = contextPath + "/report/businessstatistics/graphic?orgId="+$orgId.val()+
				"&busType="+$busType.find("option:selected").val()+
				"&startDate="+$startDate.val()+
				"&endDate="+$endDate.val()+
				"&page=-1&rows=-1&_="+new Date().getTime();
			var myChart = echarts.init(document.getElementById('chartdiv_01'),'macarons');
			myChart.setOption({
			    title: {
			        text: ''
			    },
			    tooltip: {},
			    legend: {
			        data:['']
			    },
			    xAxis: {
			        data: []
			    },
			    yAxis: {},
			    series: [{
			        name: '',
			        type: 'bar',
			        barMaxWidth : 50,
			        label:{normal:{
			        	show:true,
			        	position:'top'
			        }},
			        data: []
			    }]
			});
			myChart.showLoading();

			//ajax请求图形报表数据
			$.get(url,function(data){
				var areaObject= data.rows; //获取数据 存入对象
				var length= data.rows.length; //记录数量
				var categories = new Array();
				var value = new Array();
				for (var i = 0 ; i < length; i++){
					//加上机构信息 20181205 tianjm
					categories[i] = areaObject[i].orgName+"-"+areaObject[i].businessName;
					value[i] = areaObject[i].dealCount;
				}
				myChart.hideLoading();
				myChart.setOption({
					title: {
				        text: "【"+" " +	 			
			 			""+$startDate.val()+"至" +
			 			""+$endDate.val()+"】-业务统计情况"
				    },
					dataZoom: [
					           {   // 这个dataZoom组件，默认控制x轴。
					               type: 'slider', // 这个 dataZoom 组件是 slider 型 dataZoom 组件
					               start: 0,      // 左边在 10% 的位置。
					               end: 100         // 右边在 30% 的位置。
					           },
					           {   // 这个dataZoom组件，也控制x轴。
					               type: 'inside', // 这个 dataZoom 组件是 inside 型 dataZoom 组件
					               start: 0,      // 左边在 10% 的位置。
					               end: 100         // 右边在 30% 的位置。
					           }
					          ],
					tooltip: {trigger : 'item',  
				              show:true,  
				              showDelay: 0,  
				              hideDelay: 0,  
				              transitionDuration:0,   
				              borderRadius : 8,  
				              borderWidth: 2,  
				              padding: 10,    
				              formatter: function (params,ticket,callback) {
				            	 var res = "等待超时:"+areaObject[params.dataIndex].waitCount+"人次"
				            		 +'<br/>'+"等待未超时:"+areaObject[params.dataIndex].notwaitCount+"人次"
				            		 +'<br/>'+"办理超时:"+areaObject[params.dataIndex].dealwaitCount+"人次"
				            		 +'<br/>'+"办理未超时:"+areaObject[params.dataIndex].waitCount+"人次"
				            		 +'<br/>'+"客户类型:"+areaObject[params.dataIndex].custName
				            		 +'<br/>'+areaObject[params.dataIndex].orgName
				                 return res;  
				             }  },
			        xAxis: {
			            data: categories
			        },
			        yAxis: [
			                {
			                    type: 'value',
			                    show: true,    //显示纵轴false-不显示，true-显示
			                    name:'单位/件数'   //这里是纵轴标题
			                }
			            ],
			        series: [{
			            // 根据名字对应到相应的系列
			            name: '总受理量',
			            data: value
			        }]
				});
			});
		}
	});
}

