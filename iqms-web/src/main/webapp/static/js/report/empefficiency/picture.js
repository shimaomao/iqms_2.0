var $newDialog;
var strXML;
/**
 * 加载3d柱形图
 */
function  getZhuData(){
	$newDialog = $("#dialog-new").removeClass("hide").dialog({
		modal: true, //模式对话框
		title: '<i class="ace-icon fa fa-bar-chart-o orange"></i><span class="ui-jqdialog-title" style="float: left;">柱状图</span>',
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
			var url = contextPath + "/report/empefficiency/graphic?orgId="+$orgId.val()+
				"&workName="+$workName.val()+
				"&startDate="+$startDate.val()+
				"&endDate = "+$endDate.val()+
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
				var areaObject= data.rows; //记录数组
				var length= data.rows.length; //记录数量
				var categories = new Array();
				var value = new Array();
				for (var i = 0 ; i < length; i++){
					categories[i] = areaObject[i].orgName+"-"+areaObject[i].workName;
					value[i] = areaObject[i].dealCount;
				}
				myChart.hideLoading();
				myChart.setOption({
					title: {
				        text: "【"+" " +	 			
			 			""+$startDate.val()+"至" +
			 			""+$endDate.val()+"】-柜员效率情况"
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
			             padding: 10,    // [5, 10, 15, 20]  
			             formatter: function (params,ticket,callback) {
			            	 var res = "平均办理时长"+areaObject[params.dataIndex].avgDeal+"分钟，"
			            		 +'<br/>'+"最大办理时长"+areaObject[params.dataIndex].maxDeal+"分钟，"
			            		 +'<br/>'+"最小办理时长"+areaObject[params.dataIndex].minDeal+"分钟";
			                 return res;  
			             }  },
			        xAxis: {
			            data: categories
			        },
			        yAxis: [
			                {
			                    type: 'value',
			                    show: true,    //显示纵轴false-不显示，true-显示
			                    name:'总受理量（单位/件数）'   //这里是纵轴标题
			                }
			            ],
			        series: [{
			            // 根据名字对应到相应的系列
			            name: '总受理量',
			            data: value
			        }]
				});
			});
			/*$.get(url,function(data,status){
				
		 		var length= data.rows.length; //记录数量
			 	var areaObject= data.rows; //记录数组
			 	
			 	//拼接XMlengthL数据源的相关描述
			 	var strXML = "<chart caption='【"+" " +	 			
			 			""+$startDate.val()+"至" +
			 			""+$endDate.val()+"】-柜员效率情况' " +
			 			"yAxisName='单位/件数' " +
				        "showNames='1' palette='5' numberSuffix='件'" +
				        "animation='1' showValues='1'  " +
				        "outCnvBaseFontSize='14' baseFontSize='14' chartRightMargin='40'>";	 		 	
			 	
			 	//拼接横坐标的属性列（多条折线需要用到categories和dataset组合使用）
			 	strXML += "<categories> " +   
						 	  "<category label='总受理量' /> " +   
						  "</categories>  " ;
			 	
			   //拼接通过遍历不同的机构编码对应不同指标的情况
			 	for (var i = 0 ; i < length; i++){
			 		strXML +=  "<dataset seriesName='"+areaObject[i].orgName +"："+ areaObject[i].workName +"' >" +
							 		"<set value='"+areaObject[i].dealCount+"' /> " +
					 		   "</dataset>";
			 	}
			 	   strXML += "</chart>";

			 	//遍历数据
			 	for (var i = 0 ; i < length; i++){
			 		strXML +=  "<set name='"+areaObject[i].orgName+"-"+areaObject[i].workName+"' value='"+areaObject[i].dealCount+"'" +
			 					" toolText='平均办理时长"+areaObject[i].avgDeal+"分钟，\n最大办理时长"+areaObject[i].maxDeal+"分钟，\n最小办理时长"+areaObject[i].minDeal+"分钟'/>";
			 	}
			 	 strXML += "</chart>";
			 	 
				//创建图形
			    width = $("#fushioncharts").width() ;
				var chart1 = new FusionCharts(contextPath+"/static/lib/Charts/Column3D.swf", "chartdiv_01", "960","380");
			        chart1.setDataXML(strXML);//加载上面动态拼接的数据
			        chart1.render("chartdiv_01");//指定图形渲染的位置,即jsp文件中div元素的id
			});*/
		}
	});
}

