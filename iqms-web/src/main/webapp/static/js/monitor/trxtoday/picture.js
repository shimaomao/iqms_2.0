//定义不同业务类型占比的变量
//var vipPer = "";
var privatePer = "";
//var publicPer = "";
var otherPer = "";
function initPicture(){
	var list;
	var orgId = $("#orgId").val();
	//ajax请求加载不同业务百分比
	 $.ajax({
        url : contextPath + '/monitor/getTrxTodayBus?dt='+(new Date().getTime()),
        data :  {"orgId":orgId},
        type : "GET",
        dataType : "json",
        contentType : "application/json; charset=utf-8",
        success : function(result)
        {
        	list = result.rows;
//    		//个人业务百分比
//    		privatePer = list[0]["privatePer"];
//    		//公共业务百分比
//    		publicPer = list[0]["publicPer"];
//    		//vip业务百分比
//    		vipPer = list[0]["vipPer"];
//    		//其他业务百分比
//    		otherPer = list[0]["otherPer"];
          var data = [];
//          var businessName = "";
          for (var i = 0; i < list.length; i++) {
        	  	var jo = {};
//        		var businessName = "\""+list[i]["businessName"]+"\"";
//        		var privatePer = "\""+list[i]["privatePer"]+"\"";
        		var businessName = list[i]["businessName"];
        		var privatePer = list[i]["privatePer"];
         		if(i==0){
         			jo.label = businessName;
	        		jo.data = privatePer;
         			jo.color = "#68BC31";
//         			data[i]='{label:businessName,data:privatePer,color:"#68BC31"}';
         		}
         		else if(i==1){
         			jo.label = businessName;
	        		jo.data = privatePer;
         			jo.color = "#2091CF";
//         			data[i]='{label:businessName,data:privatePer,color:"#2091CF"}';
         		}
         		else if(i==2){
         			jo.label = businessName;
	        		jo.data = privatePer;
         			jo.color = "#AF4E96";
//         			data[i]='{label:businessName,data:privatePer,color:"#AF4E96"}';
         		}
         		else if(i==3){
         			jo.label = businessName;
	        		jo.data = privatePer;
         			jo.color = "#DA5430";
//         			data[i]='{label:businessName,data:privatePer,color:"#DA5430"}';
         		}
         		else if(i==4){
         			jo.label = businessName;
	        		jo.data = privatePer;
         			jo.color = "#AE0000";
//         			data[i]='{label:businessName,data:privatePer,color:"#AE0000"}';
         		}
         		if(i==5){
//         			var otherName = "\""+list[i]["otherName"]+"\"";
//           			otherPer = "\""+list[i]["otherPer"]+"\"";
         			var otherName = list[i]["otherName"];
           			otherPer = list[i]["otherPer"];
           			jo.label = otherName;
	        		jo.data = otherPer;
	        		jo.color = "#F9F900";
//         			data[i]='{label:otherName,data:otherPer,color:"#F9F900"}';
         		}
         		data.push(jo);
         	}
//		  var name = "\""+list[0]["businessName"]+"\"";
//		  var name1 = "\""+list[1]["businessName"]+"\"";
//		  var name2 = "\""+list[2]["businessName"]+"\"";
//		  var name3 = "\""+list[3]["businessName"]+"\"";
//		  var name4 = "\""+list[4]["businessName"]+"\"";
//		  if(list.length>5){
//			  var name5 = "\""+list[5]["otherName"]+"\"";
//			  var per5 = list[5]["otherPer"];
//		  }
//		  var per = list[0]["privatePer"];
//		  var per1 = list[1]["privatePer"];
//		  var per2 = list[2]["privatePer"];
//		  var per3 = list[3]["privatePer"];
//		  var per4 = list[4]["privatePer"];
//		  if(list.length>5){
//			  var data1 = [
//			              { label: name,  data: per, color: "#68BC31"},
//			              { label: name1,  data: per1, color: "#2091CF"},
//			              { label: name2,  data: per2, color: "#AF4E96"},
//			              { label: name3,  data: per3, color: "#DA5430"},
//			              { label: name4,  data: per4, color: "#DA5430"},
//			              { label: name5,  data: per5, color: "#F9F900"},
//			              ]
//		  }else{
//			  var data1 = [
//			              { label: name,  data: per, color: "#68BC31"},
//			              { label: name1,  data: per1, color: "#2091CF"},
//			              { label: name2,  data: per2, color: "#AF4E96"},
//			              { label: name3,  data: per3, color: "#DA5430"},
//			              { label: name4,  data: per4, color: "#DA5430"},
//			              ]
//		  }
//		  alert(data1);
          var placeholder = $('#piechart-placeholder').css({'width':'90%' , 'min-height':'150px'});

		  function drawPieChart(placeholder, data, position) {
		 	  $.plot(placeholder, data, {
				series: {
					pie: {
						show: true,
						tilt:0.8,
						highlight: {
							opacity: 0.25
						},
						stroke: {
							color: '#fff',
							width: 2
						},
						startAngle: 2
					}
				},
				legend: {
					show: true,
					position: position || "ne", 
					labelBoxBorderColor: null,
					margin:[-30,15]
				}
				,
				grid: {
					hoverable: true,
					clickable: true
				}
			 })
		 }
		 drawPieChart(placeholder, data);
		
		 /**
		 we saved the drawing function and the data to redraw with different position later when switching to RTL mode dynamically
		 so that's not needed actually.
		 */
		 placeholder.data('chart', data);
		 placeholder.data('draw', drawPieChart);
		
		
		  //pie chart tooltip example
		  var $tooltip = $("<div class='tooltip top in'><div class='tooltip-inner'></div></div>").hide().appendTo('body');
		  var previousPoint = null;
		
		  placeholder.on('plothover', function (event, pos, item) {
			if(item) {
				if (previousPoint != item.seriesIndex) {
					previousPoint = item.seriesIndex;
					var tip = item.series['label'] + " : " + item.series['percent']+'%';
					$tooltip.show().children(0).text(tip);
				}
				$tooltip.css({top:pos.pageY + 10, left:pos.pageX + 10});
			} else {
				$tooltip.hide();
				previousPoint = null;
			}
			
		 });
		
			$(document).one('ajaxloadstart.page', function(e) {
				$tooltip.remove();
			});
		
		
		
		
			var d1 = [];
			for (var i = 0; i < Math.PI * 2; i += 0.5) {
				d1.push([i, Math.sin(i)]);
			}
		
			var d2 = [];
			for (var i = 0; i < Math.PI * 2; i += 0.5) {
				d2.push([i, Math.cos(i)]);
			}
		
			var d3 = [];
			for (var i = 0; i < Math.PI * 2; i += 0.2) {
				d3.push([i, Math.tan(i)]);
			}
			
		
			var sales_charts = $('#sales-charts').css({'width':'100%' , 'height':'20px'});
			$.plot("#sales-charts", [
				{ label: "Domains", data: d1 },
				{ label: "Hosting", data: d2 },
				{ label: "Services", data: d3 }
			], {
				hoverable: true,
				shadowSize: 0,
				series: {
					lines: { show: true },
					points: { show: true }
				},
				xaxis: {
					tickLength: 0
				},
				yaxis: {
					ticks: 10,
					min: -2,
					max: 2,
					tickDecimals: 3
				},
				grid: {
					backgroundColor: { colors: [ "#fff", "#fff" ] },
					borderWidth: 1,
					borderColor:'#555'
				}
			});
		
        }
       });
}
$(function(){
	initPicture();
			
			})
