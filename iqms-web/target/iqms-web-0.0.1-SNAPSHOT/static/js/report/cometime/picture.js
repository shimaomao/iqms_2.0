var $newDialog;
var strXML;
/**
 * 加载3d折线图
 */
function  getZheData(){
	$newDialog = $("#dialog-new").removeClass("hide").dialog({
		modal: true, //模式对话框
		title: '<i class="ace-icon fa fa-bar-chart-o green"></i><span class="ui-jqdialog-title" style="float: left;">折线图</span>',
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
			var url = contextPath + "/report/cometime/graphic?orgId="+$orgId.val()+
				"&startDate="+$startDate.val()+
				"&endDate = "+$endDate.val()+
				"&page=-1&rows=-1&_="+new Date().getTime();
			var myChart = echarts.init(document.getElementById('chartdiv_02'),'macarons');
			myChart.showLoading();
			//ajax请求图形报表数据
			$.get(url,function(data){
				var areaObject= data.rows; //记录数组
				var length= data.rows.length; //记录数量
				var legends = new Array();
				var value = new Array();
				var series = new Array();
				for (var i = 0 ; i < length; i++){
					legends[i] = areaObject[i].orgName;
					value[i] = areaObject[i].dealCount;
					series.push({
						name:areaObject[i].orgName,
						type:'line',
						data:[areaObject[i].sevenCount,areaObject[i].eightCount,areaObject[i].nineCount,
						      areaObject[i].tenCount,areaObject[i].elevenCount,areaObject[i].twelveCount,areaObject[i].thirteenCount,
						      areaObject[i].fourteenCount,areaObject[i].fifteenCount,areaObject[i].sixteenCount,areaObject[i].seveteenCount,
						      areaObject[i].eighteeCount]
						});               
				}
				myChart.hideLoading();
				myChart.setOption({
					title: {
				        text: "【"+" " +	 			
			 			""+$startDate.val()+"至" +
			 			""+$endDate.val()+"】-客户来行时间段"
				    },
				    tooltip: {
				        trigger: 'axis'
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
					legend: {data:legends},
					grid: {
					       left: '3%',
					       right: '4%',
					       bottom: '3%',
					       containLabel: true
					      },
					toolbox:{
					          feature: {
					            saveAsImage: {}
					         }
					        },				
			        xAxis: {
			            data: ['7点到8点','8点到9点','9点到10点','10点到11点','11点到12点','12点到13点',
			                   '13点到14点','14点到15点','15点到16点','16点到17点','17点到18点','18点到19点']
			        },
			        yAxis: {
			            type: 'value'
			        },
			        series: series
				});
			});
		}
	});
}

