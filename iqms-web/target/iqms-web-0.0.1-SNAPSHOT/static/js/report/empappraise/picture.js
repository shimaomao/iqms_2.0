var $newDialog;
var strXML;
/**
 * 加载3d堆栈图
 */
function  getZhuData(){
	$newDialog = $("#dialog-new").removeClass("hide").dialog({
		modal: true, //模式对话框
		title: '<i class="ace-icon fa fa-bar-chart-o orange"></i><span class="ui-jqdialog-title" style="float: left;">堆叠柱状图</span>',
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
			var url = contextPath + "/report/empappraise/graphic?orgId="+$orgId.val()+
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
				var legends = ['满意', '一般','未评价','不满意'];
				var value = new Array();
				var series = new Array();
				for (var i = 0 ; i < length; i++){
					categories[i] = areaObject[i].orgName+"-"+areaObject[i].workName;
				}
				for(var j = 0; j < legends.length; j++){
					var value = new Array();
					for(var h = 0 ; h < length; h++){
						if(j == 0){
							value[h]=areaObject[h].appContent;//+":"+areaObject[h].rateContent;
						}else if(j == 1){
							value[h]=areaObject[h].appSoso;//+":"+areaObject[h].rateSoso;
						}else if(j == 2){
							value[h]=areaObject[h].appNonapp;//+":"+areaObject[h].rateNonapp;
						}else{
							value[h]=areaObject[h].appDiscontent;//+":"+areaObject[h].rateDiscontent;
						}
					}
					series.push({
						name:legends[j],
						type:'bar',
						stack:'总量',
						label: {
							normal: {
								show: true,
								position: 'insideRight'
							}
						},
						data:value
					}); 
				}
				myChart.hideLoading();
				
				myChart.setOption({
					title: {
				        text: "【"+" " +	 			
			 			""+$startDate.val()+"至" +
			 			""+$endDate.val()+"】-柜员评价"
				    },
					dataZoom: [
					           {   // 这个dataZoom组件，默认控制x轴。
					               type: 'slider', // 这个 dataZoom 组件是 slider 型 dataZoom 组件
					               show: true,
					               start: 0,      // 左边在 10% 的位置。
					               end: 100         // 右边在 30% 的位置。
					           },
					           {   // 这个dataZoom组件，也控制x轴。
					               type: 'inside', // 这个 dataZoom 组件是 inside 型 dataZoom 组件
					               show: true,
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
				         axisPointer : {            // 坐标轴指示器，坐标轴触发有效
				         type : 'line'        // 默认为直线，可选为：'line' | 'shadow'
				         },
			             formatter: function (params,ticket,callback) {
			            	 var res = "满意"+areaObject[params.dataIndex].appContent+" "+areaObject[params.dataIndex].rateContent+"%"
			            		 +'<br/>'+"一般"+areaObject[params.dataIndex].appSoso+" "+areaObject[params.dataIndex].rateSoso+"%"
			            		 +'<br/>'+"未评价"+areaObject[params.dataIndex].appNonapp+" "+areaObject[params.dataIndex].rateNonapp+"%"
			            		 +'<br/>'+"不满意"+areaObject[params.dataIndex].appDiscontent+" "+areaObject[params.dataIndex].rateDiscontent+"%";
			                 return res;  
			             }  },
					  tooltip : {
					         trigger: 'axis',
					         axisPointer : {            // 坐标轴指示器，坐标轴触发有效
					         type : 'line'        // 默认为直线，可选为：'line' | 'shadow'
					         }
					  },
					  legend: {
						   orient: 'horizontal', 
						   x: 'right',
					       data: legends
					  },
					  grid: {
					         left: '3%',
					         right: '4%',
					         bottom: '3%',
					         containLabel: true
					  },
			        xAxis: {
			        	type: 'category',
			            data: categories
			        },
			        yAxis: [
			                {
			                    type: 'value',
			                    show: true,    //显示纵轴false-不显示，true-显示
			                    name:'单位/件数'   //这里是纵轴标题
			                }
			            ],
			        series: series
				});
			});
			/*$.get(url,function(data,status){
				
		 		var length= data.rows.length; //记录数量
			 	var areaObject= data.rows; //记录数组
			 	
			 	//拼接XMlengthL数据源的相关描述
			 	var strXML = "<chart caption='【"+" " +	 			
			 			""+$startDate.val()+"至" +
			 			""+$endDate.val()+"】-柜员评价情况' " +
			 			"yAxisName='单位/件数' " +
				        "showNames='1' palette='5' numberSuffix='件'" +
				        "animation='1' showValues='1'  " +
				        "outCnvBaseFontSize='14' baseFontSize='14' chartRightMargin='40'>";	 		 	
			 	
			 	//拼接横坐标的属性列（多条折线需要用到categories和dataset组合使用）
			 	strXML += "<categories> " +   
						 	  "<category label='满意' /> " +   
						 	  "<category label='一般满意' /> " +
						 	  "<category label='不满意' /> " +
						 	  "<category label='未评价' /> " +
						  "</categories>  " ;
			 	
			 	for (var i = 0 ; i < length; i++){
			 		strXML += "<categories> " +   
							 	  "<category label='"+areaObject[i].orgName+"-"+areaObject[i].workName+"' /> " +   
							  "</categories>  " ;
			 	}
			 	   
			 	//满意
			 	strXML += "<dataset seriesName='满意' color='00FF33' showValues='0'>";
			 	for (var i = 0 ; i < length; i++){
			 		strXML +=  "<set value='"+areaObject[i].appContent+"' toolText='满意数："+areaObject[i].appContent+",满意率："+areaObject[i].rateContent+"' />";
			 	}
			 	strXML += "</dataset>";
			 	
			 	//一般
			 	strXML += "<dataset seriesName='一般' color='FFCC00' showValues='0'>";
			 	for (var i = 0 ; i < length; i++){
			 		strXML +=  "<set value='"+areaObject[i].appSoso+"' toolText='一般满意数："+areaObject[i].appSoso+",一般满意率："+areaObject[i].rateSoso+"'/>";
			 	}
			 	strXML += "</dataset>";
			 	
			 	//未评价
			 	strXML += "<dataset seriesName='未评价' color='CCFFCC' showValues='0'>";
			 	for (var i = 0 ; i < length; i++){
			 		strXML +=  "<set value='"+areaObject[i].appNonapp+"' toolText='未评价数："+areaObject[i].appNonapp+",未评价率："+areaObject[i].rateNonapp+"' />";
			 	}
			 	strXML += "</dataset>";
			 	
			 	//不满意
			 	strXML += "<dataset seriesName='不满意' color='FF3333' showValues='0'>";
			 	for (var i = 0 ; i < length; i++){
			 		strXML +=  "<set value='"+areaObject[i].appDiscontent+"' toolText='不满意数："+areaObject[i].appDiscontent+",不满意率："+areaObject[i].rateDiscontent+"' />";
			 	}
			 	strXML += "</dataset>";
			 	
			 	strXML += "</chart>";
			 	   
				//创建图形
			 	width = $("#fushioncharts").width() ;
				var chart1 = new FusionCharts(contextPath+"/static/lib/Charts/StackedColumn3D.swf", "chartdiv_01", "960","380");
			        chart1.setDataXML(strXML);//加载上面动态拼接的数据
			        chart1.render("chartdiv_01");//指定图形渲染的位置,即jsp文件中div元素的id
			});*/
		}
	});
}

