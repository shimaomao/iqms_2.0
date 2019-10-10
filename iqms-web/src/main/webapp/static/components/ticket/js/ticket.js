var heightHashMap ;
var widthTimes ;
var heightTimes ;
var params ;
var bizTypeId, index, busType, map, printConfig;
var $offsetX ;
var $offsetY ;
var $ticket;
var $tktTmpName ;
var $def ;
var tabIndex ;
var printX ;
var printY;
var maxRowNum;
var maxY;
var $lastSpan;
var $ctrList;
var $x;
var $y;
var $width;
var $height;
var printJo;
var $align;
var $fontFamily;
var $fontStyle;
var $scale;
var $saveAndPrint;
var $saveConfig;
var defaultFontSize;
var $selectedItem;
	
$(function (){
	 heightHashMap = null;
	 widthTimes = 8;
	 heightTimes = 24;
	 params = $.string(window.location.href).toQueryParams();
	 bizTypeId, index, busType, map, printConfig;
	 $offsetX = $("#offsetX");
	 $offsetY = $("#offsetY");
	 $ticket = $("#ticket");
	 $tktTmpName = $("#tktTmpName");
	 $def = $("#def");
	 tabIndex = 0;
	 printX = parseInt($ticket.get(0).getBoundingClientRect().left);
	 printY = parseInt($ticket.get(0).getBoundingClientRect().top);
	//alert(printX+"   "+printY);
	 maxRowNum = 0;
	 maxY = 0;
	 $lastSpan = null;
	 $ctrList = $("#ctrList");
	 $x = $("#x");
	 $y = $("#y");
	 $width = $("#width");
	 $height = $("#height");
	 printJo = null;
	//align  fontFamily  fontStyle  scale
	 $align = $("#align");
	 $fontFamily = $("#fontFamily");
	 $fontStyle = $("#fontStyle");
	 $scale = $("#scale");
	 $saveAndPrint = $("#saveAndPrint");
	 $saveConfig = $("#saveConfig");
	 defaultFontSize = 12;
	
	initPage();

});

function initPage(){
	dragPanelConfig();
	elementInit();
}

//中间和右边及打开的面板三者中的一些按钮和属性的初始化
function dragPanelConfig(){
	maxY = 0;
	$('[data-rel="chosen"],[rel="chosen"]').chosen();
	$.metadata.setType("attr", "validate");
	$("#frm").validate({
		onfocusout: function (element){
			$(element).valid();
		},
		submitHandler: function (form){
			return false;
		}
	});
	
	//面板指定可拖拽区域
	$("#dragPanel").draggable({
		handle: "#dragPanelTitle"
	});

	//面板关闭
	$('.close').click(function (e){
		e.preventDefault();
		$('#dragPanel').hide();
	});

	//中间模板配置的设置按钮，打开或关闭面板
	$('#showWin').click(function (e){
		e.preventDefault();
		if ($("#dragPanel").is(":hidden")){
			$('#dragPanel').show();
		} else{
			$('#dragPanel').hide();
		}
	});
	
	//中间模板配置的按钮，返回配置列表页
	$("#cancelConfig").click(function(){
	  	window.location.href = "ticket.html";
	});

	//中间模板配置的长度向上拉伸
	$('#up').click(function (e){
		e.preventDefault();
		var height = parseInt($("#ticket").css("height")) - heightTimes;
		height < 0 ? 0 : height;
		$ticket.css("height", height + "px");
		map.innerMap.css("height", height + "px");
		alert(1)
		var table = $("#ticket").find("table").eq(0).get(0);
		alert(table)
		table.deleteRow(0);
		$("#line_divH").css("height",height + "px");
	});
	
	//中间模板配置的长度向下拉伸
	$('#down').click(function (e){
		e.preventDefault();
		var height = parseInt($("#ticket").css("height")) + heightTimes;
		$ticket.css("height", height + "px");
		map.innerMap.css("height", height + "px");
		addTr();
		$("#line_divH").css("height",height + "px");
	});
	
	//最右边的号票设置页面上的 “ 列X ” 文本框，动态显示中间元素的X轴坐标信息
	$x.on("change", function (){
		if (!$selectedItem) return;
		if (!$.isNumeric(this.value)){
			$(this).val($selectedItem.data("itemData").x);
		} else{
			$(this).val(parseInt(this.value));
			//改变dataItem值
			$selectedItem.data("itemData").x = parseInt(this.value);
			$selectedItem.css("left", parseInt(this.value)*widthTimes + "px");			
			//改变左边的显示效果
			initItemStyle($selectedItem);
		}
		editLinePosition();
	});

	//最右边的号票设置页面上的 “ 行Y ” 文本框，动态显示中间元素的Y轴坐标信息
	$y.on("change", function (){
		if (!$selectedItem) return;
		if (!$.isNumeric(this.value)){
			$(this).val($selectedItem.data("itemData").y);
		} else{
			$(this).val(parseInt(this.value));
			//改变dataItem值
			$selectedItem.data("itemData").y = parseInt(this.value);
			$selectedItem.css("top",  parseInt(this.value)*heightTimes + "px");
			//改变左边的显示效果
			initItemStyle($selectedItem);
		}		
		editLinePosition();
	});

	//最右边的号票设置页面上的 “ 宽 ” 文本框，动态显示中间元素的宽度信息
	$("#width").on("change", function (){
		if (!$selectedItem) return;
		if(this.value){
			if (!$.isNumeric(this.value)){
				$(this).val($selectedItem.data("itemData").width);
			} else{
				if(parseInt(this.value)>40) this.value = 40;
				$(this).val(parseInt(this.value));
				//改变dataItem值
				$selectedItem.data("itemData").width = parseInt(this.value);
				$selectedItem.css("width", parseInt(this.value)*widthTimes + "px");
				//改变左边的显示效果
				initItemStyle($selectedItem);
			}
		}else{
			//改变dataItem值
			$selectedItem.data("itemData").width = "";
			$selectedItem.css("width", "auto");
			//改变左边的显示效果
			initItemStyle($selectedItem);
		}
		
	});

	//最右边的号票设置页面上的 “ 高 ” 文本框，动态显示中间元素的高度信息
	$("#height").on("change", function (){
		if (!$selectedItem) return;
		if (!$.isNumeric(this.value)){
			$(this).val($selectedItem.data("itemData").height);
		} else{
			$(this).val(parseInt(this.value));
			//改变dataItem值
			$selectedItem.data("itemData").height = parseInt(this.value);
			$selectedItem.css("height", parseInt(this.value)*heightTimes + "px");
			//改变左边的显示效果
			initItemStyle($selectedItem);
		}
	});

	//最右边的号票设置页面上的 “ 对齐方式 ” 按钮单击触发的事件
	$('#align button').on('click', function (e){
		if (!$selectedItem) return;
		$selectedItem.css("text-align",$(this).val());
		$selectedItem.data("itemData").align = $(this).val();
	});
}

//初始化
function elementInit(){
	//----------------------------------------------------左边元素列表，初始化开始--------------------------------------------
	
	var $ctrList = $("#ctrList");
	$ctrList.html("");
	var rlt = {"settings":[	{"key":"logo","value":"logo"},
							{"key":"text","value":"固定文本"},
							{"key":"orgCode","value":"机构代码"},
							{"key":"orgName","value":"机构名称"},
							{"key":"buzCnname","value":"业务名称"},
							{"key":"ticketNo","value":"号票号码"},
							{"key":"buzWaitingCount","value":"业务等候人数"},
							{"key":"orgWaitingCount","value":"网点等候人数"},
							{"key":"fetchedTime","value":"取号时间"},
							{"key":"planWaitTime","value":"预计等候时间"},
							{"key":"tickeAd","value":"号票广告"},
							{"key":"dealWindows","value":"办理窗口"},
							{"key":"warmPrompt","value":"温馨提示"},
							{"key":"qrCode","value":"二维码"},
							{"key":"custName","value":"客户姓名"},
							{"key":"custNo","value":"客户身份证号"},
							{"key":"custCardNo","value":"客户卡号"}
						],
			   "result":0
			 };

	var settings = null;
	var widthStr = "width:99%;";
	  
	if (rlt.result == 0){
		settings = rlt.settings;
		var $li = null;
		$.each(settings, function (index, item){
			if (item.key == "logo"){
				$li = $("<li id='" + item.key + "' style='" + widthStr + "display:inline-block;'><a class='ajax-link'   href='#' style='width:100%;height:48px;background-size:100% 100%;background-image:url(images/logo2.png);'><span></span></a></li>");
			} else{
				$li = $("<li id='" + item.key + "' style='" + widthStr + "display:inline-block;'><a class='ajax-link'   href='#'><i class='glyphicon glyphicon-font'></i><span>" + item.value + "</span></a></li>");
			}
			
			$li.appendTo($ctrList);
		});
	}

//----------------------------------------------------左边元素列表，初始化结束--------------------------------------------

//----------------------------------------------------右边模板号票设置，初始化开始----------------------------------------

	//单选框里面内容初始化
	if (settings){
		$("#ctrStyle").empty().html("");
		$.each(settings, function (index, item){
			$("#ctrStyle").append("<option value='" + item.key + "'  style='font-family:SimHei;color: blue;'>" + item.value + "</option>");
		});
		$("#ctrStyle").trigger("chosen:updated");
	} ;

	//选择上面单选框后，文本框显示的内容
	$("#ctrStyle").on("change", function (){
		if (!$selectedItem) {
			return;
		}
		//改变dataItem值
		$selectedItem.data("itemData").type = this.value;
		//改变左边的显示效果
		if(this.value == "logo"){
			$("#ctrText").val("图片路径");
		}else if(this.value == "qrCode"){
			$("#ctrText").val("二维码图片路径");
		}else{
			$("#ctrText").val("文字内容");
		}
		initItemStyle($selectedItem);
		$selectedItem.mousedown();
	});

	$("#ctrText").on("change", function (){
		if (!$selectedItem) return;
		//改变dataItem值
		$selectedItem.data("itemData").text = this.value;
		//改变左边的显示效果
		initItemStyle($selectedItem);
	});

	$("#fontFamily").on("change", function (){
		if (!$selectedItem) return;
		//改变dataItem值
		$selectedItem.data("itemData").family = this.value;
		//改变左边的显示效果
		initItemStyle($selectedItem);
	});

	$("#fontStyle").on("change", function (){
		if (!$selectedItem) return;
		//改变dataItem值
		$selectedItem.data("itemData").style = this.value;
		//改变左边的显示效果
		initItemStyle($selectedItem);
	});


	$("#scale").on("change", function (){
		//上下移动 normal down  up 
		var type = "normal";
		var oldScale = $selectedItem.data("itemData").scale ? $selectedItem.data("itemData").scale:"normal";
		if (!$selectedItem) return;
		//改变dataItem值
		$selectedItem.data("itemData").scale = this.value;

		if(oldScale.indexOf("doubleHeight")>=0&&this.value.indexOf("doubleHeight")<0){
			type = "up";
		}else if(oldScale.indexOf("doubleHeight")<0&&this.value.indexOf("doubleHeight")>=0){
			type = "down";
		}
		
		var rowNum = $selectedItem.data("itemData").y;
		//倍高的时候重新计算位置
		if(this.value.indexOf("doubleHeight")>=0){
			//双倍高
			heightHashMap.put(rowNum,2*heightTimes);
		}else{
			var countDoubleHeight=0;
			//取到本行是否还存在一个双倍高的
			$("span", map.innerMap).each(function (index, item){
				itemData = $(item).data("itemData");
				if(itemData.y==rowNum){
					if(itemData.scale.indexOf("doubleHeight")>=0){
						countDoubleHeight++;
					}
				}
			});
			//单倍高
			if(heightHashMap.containsKey(rowNum)&&countDoubleHeight==0){
				heightHashMap.remove(rowNum);
			}
		}
		
		//改变左边的显示效果
		initItemStyle($selectedItem);
		
		var values = heightHashMap.values(); 
		//alert("tmpY="+tmpY+" type="+type+"   "+values.join(","));

		//如果变成 倍高 
		if(type!="normal"){
			resetPosition(rowNum,type);
		}
	});
	//----------------------------------------------------右边模板号票设置，初始化结束----------------------------------------
}


//返回配置列表页
function cancelConfig(){
  window.location.href = "ticket.html";
}

function bindResize(el) {
	// 初始化参数
	var els = el.style,
	// 鼠标的 X 和 Y 轴坐标
	x = y = 0;
	// 邪恶的食指

	$(el).mouseout(function(e) {
		if (Math.abs(e.clientY - (printY + el.offsetHeight)) > 2) {
			$(el).css("cursor", "default");
		} else {
			$(el).css("cursor", "ns-resize");
		}
	});
	$(el).mousedown(function(e) {
		// alert(Math.abs(e.clientY-(printY+el.offsetHeight)));
		if (Math.abs(e.clientY - (printY + el.offsetHeight)) > 2) {
			return;
		}
		// 按下元素后，计算当前鼠标与对象计算后的坐标
		x = e.clientX - el.offsetWidth, y = e.clientY - el.offsetHeight;
		// 在支持 setCapture 做些东东
		el.setCapture ? (
				// 捕捉焦点
				el.setCapture(),
				// 设置事件
				el.onmousemove = function(ev) {
					mouseMove(ev || event);
				}, el.onmouseup = mouseUp)
				: (
				// 绑定事件
				el.onmouseup = mouseUp
				// $(document).bind("mousemove",
				// mouseMove).bind("mouseup", mouseUp);
				);
		// 防止默认事件发生
		e.preventDefault();
	});
	// 移动事件
	function mouseMove(e) {
		// els.width = e.clientX - x + 'px',
		els.height = e.clientY - y + 'px';
	}
	// 停止事件
	function mouseUp() {
		// 在支持 releaseCapture 
		el.releaseCapture ? (
				// 释放焦点
				el.releaseCapture(),
				// 移除事件
				el.onmousemove = el.onmouseup = null) : (
				// 卸载事件
				$(document).unbind("mousemove", mouseMove).unbind("mouseup",mouseUp));
	}
}
//-----------------------------------------------------------------------------------------------------------------------------------------------------------------------

function getSettingsByTypeCallback(){
	$ctrList.html("");
	var rlt = {"settings":[{"key":"logo","value":"logo"},
						 {"key":"text","value":"固定文本"},
						 {"key":"ticketNo","value":"号票号码"},
						 {"key":"buzWaitingCount","value":"业务等候人数"},
						 {"key":"buzCnname","value":"业务类别"},
						 {"key":"fetchedDate","value":"取票时间"},
						 {"key":"orgName","value":"授权网点名称"},
						 {"key":"warmPrompt","value":"温罄提示"},
						 {"key":"vldCode","value":"验证码"},
						 {"key":"star","value":"星级"},
						 {"key":"secretCode","value":"暗码"}
						],"result":0};
	var settings = null;
	var widthStr = "width:99%;";
	  
	if (rlt.result == 0){
		settings = rlt.settings;
		var $li = null;
		$.each(settings, function (index, item){
			if (item.key == "logo"){
				$li = $("<li id='" + item.key + "' style='" + widthStr + "display:inline-block;'><a class='ajax-link'   href='#' style='width:100%;height:48px;background-size:100% 100%;background-image:url(../../../images/logo2.png);'><span></span></a></li>");
			} else{
				$li = $("<li id='" + item.key + "' style='" + widthStr + "display:inline-block;'><a class='ajax-link'   href='#'><i class='glyphicon glyphicon-font'></i><span>" + item.value + "</span></a></li>");
			}
			$li.appendTo($ctrList);
		});
	}
	//----------------------------------------------------左边初始化 end--------------------------------------------

	//----------------------------------------------------右边初始化 start--------------------------------------------
	if (settings) chose_ini("#ctrStyle", settings, null);

	$("#ctrStyle").on("change", function (){
		if (!$selectedItem) return;
		//改变dataItem值
		$selectedItem.data("itemData").type = this.value;
		//改变左边的显示效果
		if(this.value == "logo"){
			$("#ctrText").parent().prev().text("图片路径");
		}else{
			$("#ctrText").parent().prev().text("文字内容");
		}
		initItemStyle($selectedItem);
		$selectedItem.mousedown();
	});

	$("#ctrText").on("change", function (){
		if (!$selectedItem) return;
		//改变dataItem值
		$selectedItem.data("itemData").text = this.value;
		//改变左边的显示效果
		initItemStyle($selectedItem);
	});

	$("#fontFamily").on("change", function (){
		if (!$selectedItem) return;
		//改变dataItem值
		$selectedItem.data("itemData").family = this.value;
		//改变左边的显示效果
		initItemStyle($selectedItem);
	});

	$("#fontStyle").on("change", function (){
		if (!$selectedItem) return;
		//改变dataItem值
		$selectedItem.data("itemData").style = this.value;
		//改变左边的显示效果
		initItemStyle($selectedItem);
	});


	$("#scale").on("change", function (){
		//上下移动 normal down  up 
		var type = "normal";
		var oldScale = $selectedItem.data("itemData").scale ? $selectedItem.data("itemData").scale:"normal";
		if (!$selectedItem) return;
		//改变dataItem值
		$selectedItem.data("itemData").scale = this.value;

		if(oldScale.indexOf("doubleHeight")>=0&&this.value.indexOf("doubleHeight")<0){
			type = "up";
		}else if(oldScale.indexOf("doubleHeight")<0&&this.value.indexOf("doubleHeight")>=0){
			type = "down";
		}
		
		var rowNum = $selectedItem.data("itemData").y;
		//倍高的时候重新计算位置
		if(this.value.indexOf("doubleHeight")>=0){
			//双倍高
			heightHashMap.put(rowNum,2*heightTimes);
		}else{
			var countDoubleHeight=0;
			//取到本行是否还存在一个双倍高的
			$("span", map.innerMap).each(function (index, item){
				itemData = $(item).data("itemData");
				if(itemData.y==rowNum){
					if(itemData.scale.indexOf("doubleHeight")>=0){
						countDoubleHeight++;
					}
				}
			});
			//单倍高
			if(heightHashMap.containsKey(rowNum)&&countDoubleHeight==0){
				heightHashMap.remove(rowNum);
			}
		}
		
		
		//改变左边的显示效果
		initItemStyle($selectedItem);
		
		var values = heightHashMap.values(); 
		//alert("tmpY="+tmpY+" type="+type+"   "+values.join(","));

		//如果变成 倍高 
		if(type!="normal"){
			resetPosition(rowNum,type);
		}
	});
	//----------------------------------------------------右边初始化 end--------------------------------------------
	//bindResize(document.getElementById('ticket'));

	$("#ticket").mousemove(function (e){
		if ($(this).attr('class') != 'selected' && $(".clone").length > 0){
			$(this).addClass('over');
		}
	});
	$("#ticket").mouseout(function (e){
		if ($(this).attr('class') != 'selected'){
			$(this).removeClass('over');
		}
	});
	
	$("#ticket").mouseup(function (e){
		if ($(this).attr('class') != 'selected' && $(".clone").length > 0){
			var $spn = $(".clone");

			$spn.attr("tabIndex", tabIndex);
			tabIndex++;
			initItemStyle($spn.get(0));
			$spn.on("mousedown", function (){
				map.moveImage = false;
				$("#allItems")[0].checked = false;
				$selectedItem = $(this);
				
				var x = Math.round(parseInt($(this).css("left"))/widthTimes);
				var y = getRowNum(Math.round(parseInt($(this).css("top"))));
				$(this).css("left",x*widthTimes);
				$(this).css("top",getPositionY(y));
				$x.val(x);
				$y.val(y);
				$(this).data("itemData").x = x;
				$(this).data("itemData").y = y;
				//动态改变右边的属性值
				initRightData(this);

				this.focus();
				$("span", map.innerMap).each(function (index, item){
					//$(this).css("border", "0px");
					$(this).css("border", "1px solid  #4875f7");
				});
				$(this).css("border", "1px dotted red");
				editLinePosition();
			});

			//$spn.on("mouseup", function (){
			//});

			$spn.on("blur", function (){
				$("#allItems")[0].checked = false;
				if (document.activeElement.tagName != "SPAN"){
					//map.moveImage = true;
				}
			});


			$spn.draggable({ 
				onDrag: onDrag, 
				onStartDrag: function(event,ui) { 
					var rowNum = $(this).data("itemData").y;
					var doubleHeightCount=0;
					var itemData = null;
					if($(this).data("itemData").scale&&$(this).data("itemData").scale.indexOf("doubleHeight")>=0){
						$("span", map.innerMap).each(function (index, item){
							itemData = $(item).data("itemData");
							if(itemData.y==rowNum&&itemData.scale&&itemData.scale.indexOf("doubleHeight")>=0){
								doubleHeightCount++;
							}
						});
						//本行只有 这一个元素是倍高的
						if(doubleHeightCount==1){
							heightHashMap.remove(rowNum); 
							//上移所有元素
							resetPositionQZ(rowNum,"up");
						}
					}
				}, 
				onStopDrag:function(event,ui){ 
					if($selectedItem){
						//alert("stop");
						var x = Math.round(parseInt($selectedItem.css("left"))/widthTimes);
						var y = getRowNum(Math.round(parseInt($selectedItem.css("top"))));
						
						$selectedItem.css("left",x*widthTimes);
						$selectedItem.css("top",getPositionY(y));
						$x.val(x);
						$y.val(y);
						$selectedItem.data("itemData").x = x;
						$selectedItem.data("itemData").y = y;
						//动态改变右边的属性值
						initRightData($selectedItem.get(0));
						
						var rowNum = $selectedItem.data("itemData").y;
						var doubleHeightCount=0;
						var itemData = null;
						if($selectedItem.data("itemData").scale&&$selectedItem.data("itemData").scale.indexOf("doubleHeight")>=0){
							$("span", map.innerMap).each(function (index, item){
								itemData = $(item).data("itemData");
								if(itemData.y==rowNum&&itemData.scale&&itemData.scale.indexOf("doubleHeight")>=0){
									doubleHeightCount++;
								}
							});
							//本行只有 这一个元素是倍高的
							if(doubleHeightCount==1){
								heightHashMap.put(rowNum,2*heightTimes); 
								//上移所有元素
								resetPositionQZ(rowNum,"down");
							}
						}
						editLinePosition();
					}
				} 	
			});
			$spn.appendTo(map.innerMap);
			var left = parseInt($(".clone").css('left'));
			var top = parseInt($(".clone").css('top'));

			printX = parseInt($ticket.get(0).getBoundingClientRect().left);
			printY = parseInt($ticket.get(0).getBoundingClientRect().top);
			
			var x = Math.round((left - printX)/widthTimes);
			var y = getRowNum(Math.round(top - printY));			
			$spn.css("left",x<0? 0:x*widthTimes +"px");
			$spn.css("top",y<0? 0:getPositionY(y) +"px");

			$spn.attr('class', '');
			$spn.data("itemData").x = x;
			$spn.data("itemData").y = y;
			$spn.mousedown();

		}
	});
	//鼠标按下，鼠标变移动标志，克隆元素，并确定新克隆元素位置
	$("#ctrList li").mousedown(function (e){
		var $span = $("<span style='list-style:none;position:absolute;'></span>");

		$span.addClass("clone").appendTo($("body"));
		$("body").css('cursor', 'move');
		$span.css('left', e.clientX + 1);
		$span.css('top', e.clientY + 1);

		var itemData = {};
		if ($(this).text()){
			itemData.type = this.id;
			itemData.text = $(this).text();
			itemData.family = "SimSun";
			itemData.style = "normal";
			itemData.scale = "normal";
			itemData.size = defaultFontSize;
			itemData.height = 1;
		}else{
			itemData.type = "logo";
			itemData.width = 40;
			itemData.height = 2;
		}
		$span.data("itemData", itemData);

	});

	$(document).mousemove(function (e){
		if ($(".clone").length > 0){
			$(".clone").css('left', e.clientX + 1);
			$(".clone").css('top', e.clientY + 1);
		}
	});

	$(document).mouseup(function (e){
		$(".clone").remove();
		$("body").css('cursor', 'auto');
	});
	
	//----------------------------------------------------中间初始化 start--------------------------------------------
	$saveConfig.on("click", saveConfig);
	$saveAndPrint.on("click", saveAndPrint);
	createPreviewHtml();
	//----------------------------------------------------中间初始化 end--------------------------------------------
}

function getLastType(rowNum,type){
	var itemData = null;
	var countDoubleHeight = 0;
	var countNormalHeight = 0;
	$("span", map.innerMap).each(function (index, item){
		itemData = $(item).data("itemData");
		if(itemData.y==rowNum){
			if(itemData.scale.indexOf("doubleHeight")>=0){
				countDoubleHeight++;
			}else{
				countNormalHeight++;
			}
		}
	});
	
	if(type=="down"){
		if(countDoubleHeight>1){
			type = "normal";
		}
	}else if(type=="up"){
		if(countDoubleHeight>0){
			type = "normal";
		}
	}
	return type;
}

//根据现有行号重置本行以下的行的位置
function resetPosition(rowNum,type){
	if(type&&(type=="down"||type=="up")){
		var itemData = null;
		//根据type 与本行元素情况决定 向下平移 或者向上平移
		type = getLastType(rowNum,type);
		$("span", map.innerMap).each(function (index, item){
			itemData = $(item).data("itemData");
			if(itemData.y>rowNum){
				//alert(0);
				//向下平移 或者向上平移
				if(type=="down"){
					$(item).css('top', (parseInt($(item).css('top'))+heightTimes)+"px");
				}else if(type=="up"){
					$(item).css('top', (parseInt($(item).css('top'))-heightTimes)+"px");
				}
			}
		});
	}
}
//强制
function resetPositionQZ(rowNum,type){
	if(type&&(type=="down"||type=="up")){
		$("span", map.innerMap).each(function (index, item){
			itemData = $(item).data("itemData");
			if(itemData.y>rowNum){
				//alert(0);
				//向下平移 或者向上平移
				if(type=="down"){
					$(item).css('top', (parseInt($(item).css('top'))+heightTimes)+"px");
				}else if(type=="up"){
					$(item).css('top', (parseInt($(item).css('top'))-heightTimes)+"px");
				}
			}
		});
	}
}
    


function getHeight(obj){
	var $spn = $(obj);
	var itemData = $spn.data(itemData);
	var height = heightTimes;
	if(itemData.scale&&itemData.scale.indexOf("doubleHeight")>=0){
		height = heightTimes*2;
	}
	return height;
}

function changeTicketDivHeight(){
	var tmpHeight = 482;
	if ($lastSpan){
		tmpHeight = maxY + heightTimes + getHeight($lastSpan.get(0));
	}
	//alert(tmpHeight);
	$("#ticket").css("height", tmpHeight+2);
	map.innerMap.css("height", tmpHeight+2);
}

//单选select html初始化
function chose_ini(select, jsonObj, iniValue){
	/*
		//jquery移除所有option
		$("option",$(select)).remove();

		jsonObj = [];
		var tmpItem;
		for(var i=0;i<10;i++){
		tmpItem = {};
		tmpItem.value=i;
		tmpItem.text=i+"  文本啊";
		jsonObj.push(tmpItem);
		}
		alert($.toJSON(jsonObj));
	*/
	$(select).empty().html("");
	$.each(jsonObj, function (index, item){
		$(select).append("<option value='" + item.key + "'  style='font-family:SimHei;'>" + item.value + "</option>");
	});
	if (iniValue) $(select).val(iniValue);
	$(select).trigger("chosen:updated");
}


function chose_mult_ini(select, jsonObj, iniValues){

}

//单选select 值初始化
function chose_set_ini(select, value){
	$(select).val(value);
	$(select).trigger("chosen:updated");
}

//多选select 数据初始化
function chose_mult_set_ini(select, values){
	var arr = values.split(',');
	var length = arr.length;
	var value = '';
	for (i = 0; i < length; i++){
		value = arr[i];
		$(select + " [value='" + value + "']").attr('selected', 'selected');
	}
	$(select).trigger("chosen:updated");
}

function closeSpan(obj){
	var $span = $(obj).parent();
	var rowNum = $span.data("itemData").y;
	var doubleHeightCount=0;
	if($span.data("itemData").scale&&$span.data("itemData").scale.indexOf("doubleHeight")>=0){
		$("span", map.innerMap).each(function (index, item){
			itemData = $(item).data("itemData");
			if(itemData.y==rowNum&&itemData.scale&&itemData.scale.indexOf("doubleHeight")>=0){
				doubleHeightCount++;
			}
		});
		//本行只有 这一个元素是倍高的
		if(doubleHeightCount==1){
			heightHashMap.remove(rowNum); 
			//上移所有元素
			resetPosition(rowNum,"up");
		}
	}
	$span.remove();
}

function initItemStyle(obj){
	var item = $(obj).data("itemData");
	var $spn = $(obj);
	if (item.type == "logo"){
		$spn.empty().html("<img style=\"width:100%;height:100%\" src='images/logo2.png'><button type='button'  class='close'  ondblclick='closeSpan(this)' data-dismiss='modal'></button>");
	} else{
		$spn.empty().html("<label style='line-height:"+heightTimes+"px;'>" + item.text + "</label><button type='button' class='close'  ondblclick='closeSpan(this)' data-dismiss='modal'></button>");
	}
	var $label = $spn.find("label");
	if (item.family){
		$spn.css("font-family", item.family);
	} else{
		$spn.css("font-family", "SimSun");
	}
	if (item.style){
		if (item.style == "normal"){
			$label.css("font-style", "normal").css("font-weight", "normal");
		} else if (item.style == "italic"){
			$label.css("font-style", "italic").css("font-weight", "normal");
		} else if (item.style == "bold"){
			$label.css("font-style", "normal").css("font-weight", "bold");
		} else if (item.style == "boldAndItalic"){
			$label.css("font-style", "italic").css("font-weight", "bold");
		}
	} else{
		$label.css("font-style", "normal").css("font-weight", "normal");
	}

	$label.css("font-size", "12px");

	if (item.align){
		$spn.css("text-align", item.align);
	}else{
		$spn.css("text-align", "left");
	}

	if (item.width){
		$spn.css("width", item.width*widthTimes + "px").css("word-break", "break-all");
	}else{
		//$spn.css("width", item.width*widthTimes + "px").css("word-break", "keep-all");
		$spn.css("width", "auto").css("word-break", "keep-all");
	}

	if (item.height){
		$spn.css("height", item.height*heightTimes + "px");
	}

	if (item.x){
		$spn.css("left", item.x*widthTimes + "px");
	}

	if (item.y){
		$spn.css("top", getPositionY(item.y) + "px");
	}

	$spn.css("transform-origin","0 0");
	if (item.scale){
		if (item.scale == "normal"){
			$spn.css("transform", "scale(1,1)");
		} else if (item.scale == "doubleHeight"){
			$spn.css("transform",  "scale(1,2)");
		} else if (item.scale == "doubleWidth"){
			$spn.css("transform", "scale(2,1)");
		} else if (item.scale == "doubleHeightAndWidth"){
			$spn.css("transform", "scale(2,2)");
		}
	} else{
		$spn.css("transform", "scale(1,1)");
	}
}


//添加栅格 
function addTable(){
	var table = document.createElement("table");
	var tbody = document.createElement("tbody");
	table.style.borderCollapse = "collapse";
	var rows = Math.round(parseInt($("#ticket").css("height"))/heightTimes);
	var cols = 40;
	for(var i = 0;i<rows;i++){
		var tr = document.createElement("tr");
		for(var j = 0;j<40;j++){
			var td = document.createElement("td");
			var text = document.createTextNode("");
			td.style.border = "1px solid #CDCDCD";
			td.style.height = heightTimes + "px";
			td.style.width = widthTimes + "px";
			td.style.padding = "0";
			td.style.margin = "0";
			td.appendChild(text);
			tr.appendChild(td);
		}
		table.appendChild(tr);
	}
	document.getElementById("ticket").appendChild(table);
}

function addLine(){
	 var left = $selectedItem? parseInt($selectedItem.css('left')):0;
	 var top = $selectedItem? parseInt($selectedItem.css('top')):0;
	 var divH=document.createElement("div");
	 divH.innerHTML=' <div id="line_divH" style="width:'+1+'px;height:'+parseInt($("#ticket").css("height"))+'px;position:absolute;visibility:visible;left:'+left+'px;top:'+0+'px;border-left:1px solid #000000;border-top:1px solid #000000;"></div>';
	 document.getElementById("ticket").appendChild(divH);
	 
	 var divV=document.createElement("div");
	 divV.innerHTML=' <div id="line_divV" style="width:'+40*widthTimes+'px;height:'+1+'px;position:absolute;visibility:visible;left:'+0+'px;top:'+top+'px;border-left:1px solid #000000;border-top:1px solid #000000;"></div>';
	 document.getElementById("ticket").appendChild(divV);
	 //坐标跟随移动
	 var divPosition=document.createElement("div");
	 divPosition.innerHTML=' <div id="divPosition" style="white-space:nowrap;position:absolute;color:#000000;visibility:visible;left:'+left+'px;top:'+(top-20)+'px;">&nbsp;坐标&nbsp;('+Math.floor(left/widthTimes)+','+Math.floor(top/heightTimes)+')</div>';
	 document.getElementById("ticket").appendChild(divPosition);
}

function editLinePosition(){
	var left = $selectedItem? parseInt($selectedItem.css('left')):0;
	var top = $selectedItem? parseInt($selectedItem.css('top')):0;
	$("#line_divH").css("left",left+"px");
	$("#line_divV").css("top",top+"px");
	$("#divPosition").css("left",left+"px").css("top",(top-20)+"px");
	$("#divPosition").empty().html('&nbsp;坐标&nbsp;('+Math.floor(left/widthTimes)+','+Math.floor(top/heightTimes)+')');
}

function addTr(){
	var table = $("#ticket").find("table").eq(0).get(0);
	var tr = document.createElement("tr");
	for(var j = 0;j<40;j++){
		var td = document.createElement("td");
		var text = document.createTextNode("");
		td.style.border = "1px solid #CDCDCD";
		td.style.height = heightTimes + "px";
		td.style.width = widthTimes + "px";
		td.style.padding = "0";
		td.style.margin = "0";
		td.appendChild(text);
		tr.appendChild(td);
	}
	table.appendChild(tr);
}

function delTr(){
	alert(1)
	var table = $("#ticket").find("table").eq(0).get(0);
	alert(table)
	table.deleteRow(0);
}

function getTicketTemplateJsonFileCallback(jsonString){
	/*
		var printJo = {
						  "dpi": 100,
						  "family": "SimSun",
						  "style": "normal",
						  "size": 12,
						  "offset": {
							"x": 0,
							"y": 0
						  },
						  "items": [
							{
							  "type": "buzWaitingCount",
							  "text": "4",
							  "size": "12",
							  "x": 13,
							  "y": 5,
							  "family": "SimSun"
							}
						  ]
						};
	var args = {};
	args.biom = {};
	args.biom.head = {};
	args.biom.head.retCode = "0";
	args.biom.head.retMsg = "0";
	args.biom.body = {};
	args.biom.body.ticketPrintJson = $.toJSON(printJo);
	jsonString = $.toJSON(args);
	*/	
		
	//jsonString = "{\"biom\":{\"head\":{\"retCode\":\"0\",\"retMsg\":\"成功\"},\"body\":{\"tickePrintForm\":\"XFSMEDIA 'Blank'BEGINUNIT MM, 1, 1SIZE 300, 300ENDXFSMEDIA 'ReceiptMedia'BEGINUNIT MM, 1, 1SIZE 300, 300ENDXFSFORM 'Queue7'BEGINSIZE      40, 14UNIT     ROWCOLUMN, 1, 1ALIGNMENT TOPLEFT, 1, 0LANGUAGE 2052XFSFIELD 'logo'BEGINPOSITION    0, 2SIZE        40,2HORIZONTAL  LEFTSTYLE       NORMALINITIALVALUE 'D:/client/web/images/logo.bmp'ENDXFSFIELD 'text1'BEGINPOSITION    9, 6SIZE        40,1HORIZONTAL  LEFTSTYLE       NORMALINITIALVALUE '固定文本'ENDXFSFIELD 'field1'BEGINPOSITION    9, 9SIZE        40,1HORIZONTAL  LEFTSTYLE       NORMALINITIALVALUE '业务等候人数'ENDEND\",\"tickePrintFormat\":\"buzWaitingCount\",\"tickePrintModTime\":\"\",\"ticketPrintJson\":\"{'dpi':100,'family':'SimSun','style':'normal','size':12,'offset':{'x':0,'y':0},'items':[{'type':'logo','width':40,'height':2,'x':0,'y':2,'text':'D:/client/web/images/logo.bmp'},{'type':'text','text':'固定文本','family':'SimSun','style':'normal','scale':'normal','size':12,'height':1,'x':9,'y':6},{'type':'buzWaitingCount','text':'业务等候人数','family':'SimSun','style':'normal','scale':'normal','size':12,'height':1,'x':9,'y':19}]}\"}}}";	 

	if(jsonString){
		//alert(jsonString);
		var rtn = $.parseJSON(jsonString);
		var body = rtn.biom.body;
		var retCode = rtn.biom.head.retCode;
		var retMsg = rtn.biom.head.retMsg;

		//alert($.toJSON(rtn));
		$("#ticket").css("color", "blue");
		map = new Map("ticket", 322, 482, "../../images/sssss.jpg", null, null, null, 1);
		map.moveImage = false;
		
		heightHashMap = new HashMap(); 

		if (retCode == "0"){
			var conf = "";
			//alert(body.ticketPrintJson);
			if(body.ticketPrintJson){
				conf = $.parseJSON(body.ticketPrintJson.replace(/'/g,"\""));
				printConfig = conf;
			}
			
			if (conf){
				$offsetX.val(conf.offset.x);
				$offsetY.val(conf.offset.y);
				var $spn;
				$.each(conf.items, function (index, item){
					if(item.scale&&item.scale.indexOf("doubleHeight")>=0){
						heightHashMap.put(item.y,2*heightTimes);
					}
					
					if(item.y>maxRowNum){
						maxRowNum = item.y;
					}
				});
				$.each(conf.items, function (index, item){
					$spn = $("<span type='prt-" + item.type + "' tabindex='" + tabIndex + "'></span>").css("position", "absolute").css("top", item.y + "px").css("left", item.x + "px");
					tabIndex++;
					$spn.data("itemData", item);
					initItemStyle($spn.get(0));
					$spn.on("mousedown", function (){
						map.moveImage = false;
						$("#allItems")[0].checked = false;
						$selectedItem = $(this);
						//动态改变右边的属性值
						initRightData(this);
						this.focus();
						$("span", map.innerMap).each(function (index, item){
							//$(this).css("border", "0px");
							$(this).css("border", "1px solid  #4875f7");
						});
						$(this).css("border", "1px dotted red");	
						editLinePosition();
					});
					//有时不执行
					//$spn.on("mouseup", function (){
					
					//});

					$spn.on("blur", function (){
						$("#allItems")[0].checked = false;
						if (document.activeElement.tagName != "SPAN"){
						//map.moveImage = true;
						}
					});

					$spn.draggable({ 
						onDrag: onDrag,
						onStartDrag: function(event,ui) { 
							var rowNum = $(this).data("itemData").y;
							var doubleHeightCount=0;
							var itemData = null;
							if($(this).data("itemData").scale&&$(this).data("itemData").scale.indexOf("doubleHeight")>=0){
								$("span", map.innerMap).each(function (index, item){
									itemData = $(item).data("itemData");
									if(itemData.y==rowNum&&itemData.scale&&itemData.scale.indexOf("doubleHeight")>=0){
										doubleHeightCount++;
									}
								});
								//本行只有 这一个元素是倍高的
								if(doubleHeightCount==1){
									//alert(heightHashMap.toString());
									heightHashMap.remove(rowNum); 
									//alert(heightHashMap.toString());
									//上移所有元素
									resetPositionQZ(rowNum,"up");
								}
							}
						}, 
						
						onStopDrag:function(event,ui){ 
							if($selectedItem){
								var x = Math.round(parseInt($selectedItem.css("left"))/widthTimes);
								var y = getRowNum(Math.round(parseInt($selectedItem.css("top"))));
								
								//alert(y+" mouseup "+$selectedItem.data("itemData").text);
								$selectedItem.css("left",x*widthTimes);
								$selectedItem.css("top",getPositionY(y));
								
								$x.val(x);
								$y.val(y);
								$selectedItem.data("itemData").x = x;
								$selectedItem.data("itemData").y = y;
								//动态改变右边的属性值
								initRightData(this);
								//alert(1111);
								var rowNum = $selectedItem.data("itemData").y;
								var doubleHeightCount=0;
								var itemData = null;
								
								if($selectedItem.data("itemData").scale&&$selectedItem.data("itemData").scale.indexOf("doubleHeight")>=0){
									$("span", map.innerMap).each(function (index, item){
										itemData = $(item).data("itemData");
										if(itemData.y==rowNum&&itemData.scale&&itemData.scale.indexOf("doubleHeight")>=0){
											doubleHeightCount++;
										}
									});
									//本行只有 这一个元素是倍高的
									if(doubleHeightCount==1){
										heightHashMap.put(rowNum,2*heightTimes); 
										//alert(heightHashMap.toString());
										//上移所有元素
										resetPositionQZ(rowNum,"down");
									}
								}
								
								editLinePosition();
								//alert($selectedItem.data("itemData").text + "    "+ y+"   "+getPositionY(y)+ "   " +parseInt($selectedItem.css("top")));
							}
						} 	
					});
					map.innerMap.append($spn);
					
					if (maxY < getPositionY(item.y)){
						maxY = getPositionY(item.y);
						$lastSpan = $spn;
					}
				});
			}

		}else{
			//跳转错误页面
			window.location.href = "timeout.html?retMsg="+retMsg;		
		}
		
		setTimeout(function(){
			//alert(getRowNum(200));
			//选中第一个logo元素
			$("span", map.innerMap).eq(0).mousedown();
			changeTicketDivHeight();
			addTable();
			addLine();
			closeLoading();
		},500);
		
		
	}	
}

function getPositionY(rowNum){
	var y = 0;
	for(var i=0;i<rowNum;i++){
		y+=(heightHashMap.get(i) ? heightHashMap.get(i):heightTimes);
	}
	return y;
	
}

//根据y坐标获得行号  从0 开始的行号
function getRowNum(y){
	var rowNum = 0;
	//各行坐标数组
	var heightArr = new Array();
	var trHeight = heightTimes;
	
	for(var i=0;i<=maxRowNum+1;i++){
		//本行y坐标
		if(i==0){
			heightArr.push(0);
		}else{
			heightArr.push(heightArr[i-1]+trHeight);
		}
		//本行行高
		if(heightHashMap.containsKey(i)){
			trHeight = heightHashMap.get(i);
		}else{
			trHeight = heightTimes;
		}
	}
	
	var flag = false;
	for(var i=0;i<heightArr.length;i++){
		if(y<heightArr[i]){
			rowNum = i-1;
			flag = true;
			break;
		}
	}
	if(!flag){
		if(heightHashMap.get(heightArr.length-1)){
			rowNum = heightArr.length + Math.floor((y-heightArr[heightArr.length-1])/heightTimes);
		}else{
			rowNum = heightArr.length -1 + Math.floor((y-heightArr[heightArr.length-1])/heightTimes);
		}
	}
	
	return rowNum;
}

function createPreviewHtml(){
	/*
	//old  备份代码
	var jo = {};
	jo.ticketTemplate = {};
	jo.ticketTemplate.tktTmpId = tktTmpId;
	jo.callback = "ifrm.contentWindow.getTicketTemplateJsonFileCallback";
	$.qms.getTicketTemplateJsonFile(jo);*/

	 
	var args = {};
	args.biom = {};
	args.biom.head = {};
	args.biom.head.tradeCode = "ticketsconfig2select";
	args.biom.head.qmsIp = $.qms.getCache("qmsIp");
	args.biom.body = {};
	args.command=34;	
	args.callback = "getTicketTemplateJsonFileCallback";
	//alert($.toJSON(args));
	$.qms.getTicketsconfig(args);
	//getTicketTemplateJsonFileCallback();
}

function initRightData(obj)
{
	var itemData = $(obj).data("itemData");
	if(itemData.type == "logo"){
		$fontFamily.parent().parent().parent().hide();
		$fontStyle.parent().parent().parent().hide();
		$scale.parent().parent().parent().hide();
		$("#ctrText").parent().prev().text("图片路径");
	}else{
		$fontFamily.parent().parent().parent().show();
		$fontStyle.parent().parent().parent().show();
		$scale.parent().parent().parent().show();
		$("#ctrText").parent().prev().text("文字内容");
	}
	$x.val(itemData.x);
	$y.val(itemData.y);
	$width.val(itemData.width);
	$height.val(itemData.height);
	chose_set_ini("#ctrStyle", itemData.type);
	$("#ctrText").val(itemData.text);
	chose_set_ini("#fontFamily", itemData.family);
	chose_set_ini("#fontStyle", itemData.style);
	chose_set_ini("#scale", itemData.scale);
	//$('[data-rel="chosen"],[rel="chosen"]').trigger("chosen:updated");
}

function getPrintData(){
	var arg = {};
	if (!printConfig){
		printConfig = {};
		printConfig.dpi = 100;
	}
	arg.dpi = printConfig.dpi;
	arg.family = "SimSun";
	arg.style = "normal";
	arg.size = defaultFontSize;

	var list = [];

	$("span", map.innerMap).each(function (index, item){
		//改变item位置
		$(item).data("itemData").x = parseInt(this.style.left.replace("px", ""))/widthTimes;
		$(item).data("itemData").y = getRowNum(parseInt(this.style.top.replace("px", "")));
		if ($(item).data("itemData").type == "logo"){
			//$(item).data("itemData").width = 30;
			//$(item).data("itemData").height = 2;
			if(!$(item).data("itemData").text){
				$(item).data("itemData").text = "D:/client/web/images/logo.bmp";
			} 
		}
		
		if(!$(item).data("itemData").align){
			$(item).data("itemData").align = "left";
		}
		
		//alert($(item).data("itemData").text);
		list.push($(item).data("itemData"));
	});

	var offX, offY, fx, fy;


	offX = $offsetX.val();
	offY = $offsetY.val();

	fx = $.isNumeric(offX) ? parseFloat(offX) : 0;
	fy = $.isNumeric(offY) ? parseFloat(offY) : 0;

	arg.offset = { "x": fx, "y": fy };
	arg.items = list;
	//alert($.toJSON(arg));
	return arg
}



function up(){
	var all = $("#allItems")[0].checked;
	if (all){
		$("span", map.innerMap).each(function (index, item){
			upSingle($(this));
		});
	} else if (!all){
		upSingle($selectedItem);
	}
}

function upSingle($spn){
	if (0 == $spn.length){
		return;
	}
	//移除该节点
	var oldRowNum = $spn.data("itemData").y;
	var newRowNum = $spn.data("itemData").y -  parseInt($("#moveUnit").val());
	if(newRowNum<0){
		return;
	}
	var doubleHeightCount=0;
	var itemData = null;
	if($spn.data("itemData").scale&&$spn.data("itemData").scale.indexOf("doubleHeight")>=0){
		$("span", map.innerMap).each(function (index, item){
			itemData = $(item).data("itemData");
			if(itemData.y==oldRowNum&&itemData.scale&&itemData.scale.indexOf("doubleHeight")>=0){
				doubleHeightCount++;
			}
		});
		//本行只有 这一个元素是倍高的
		if(doubleHeightCount==1){
			//alert(heightHashMap.toString());
			heightHashMap.remove(oldRowNum); 
			//alert(heightHashMap.toString());
			//上移所有元素
			resetPositionQZ(oldRowNum,"up");
		}
	}
	
	$y.val(newRowNum);
	$spn.data("itemData").y = newRowNum;
	//动态改变右边的属性值
	initRightData($spn.get(0));
	$spn.css("top", getPositionY(newRowNum) + "px");
	
	//移入该节点   上移单位数量
	doubleHeightCount=0;
	itemData = null;
	if($spn.data("itemData").scale&&$spn.data("itemData").scale.indexOf("doubleHeight")>=0){
		$("span", map.innerMap).each(function (index, item){
			itemData = $(item).data("itemData");
			if(itemData.y==newRowNum&&itemData.scale&&itemData.scale.indexOf("doubleHeight")>=0){
				doubleHeightCount++;
			}
		});
		//本行只有 这一个元素是倍高的
		if(doubleHeightCount==1){
			heightHashMap.put(newRowNum,2*heightTimes); 
			//alert(heightHashMap.toString());
			//上移所有元素
			resetPositionQZ(newRowNum,"down");
		}
	}
}

function down(){
	var all = $("#allItems")[0].checked;

	if (map.front && all){
		$("span", map.innerMap).each(function (index, item){
			downSingle($(this));
		});
	}else if (!map.front && all){
		$("span", map.innerBackMap).each(function (index, item){
			downSingle($(this));
		});
	}else if (map.front && !all){
		downSingle($selectedItem);
	}else if (!map.front && !all){
		downSingle($selectedItem);
	}
}

function downSingle($spn){
	if (0 == $spn.length){
		return;
	}
	//移除该节点
	var oldRowNum = $spn.data("itemData").y;
	var newRowNum = $spn.data("itemData").y +  parseInt($("#moveUnit").val());
	if(newRowNum<0){
		return;
	}
	var doubleHeightCount=0;
	var itemData = null;
	if($spn.data("itemData").scale&&$spn.data("itemData").scale.indexOf("doubleHeight")>=0){
		$("span", map.innerMap).each(function (index, item){
			itemData = $(item).data("itemData");
			if(itemData.y==oldRowNum&&itemData.scale&&itemData.scale.indexOf("doubleHeight")>=0){
				doubleHeightCount++;
			}
		});
		//本行只有 这一个元素是倍高的
		if(doubleHeightCount==1){
			//alert(heightHashMap.toString());
			heightHashMap.remove(oldRowNum); 
			//alert(heightHashMap.toString());
			//上移所有元素
			resetPositionQZ(oldRowNum,"up");
		}
	}
	$y.val(newRowNum);
	$spn.data("itemData").y = newRowNum;
	//动态改变右边的属性值
	initRightData($spn.get(0));
	$spn.css("top", getPositionY(newRowNum) + "px");
	
	//移入该节点   上移单位数量
	doubleHeightCount=0;
	itemData = null;
	if($spn.data("itemData").scale&&$spn.data("itemData").scale.indexOf("doubleHeight")>=0){
		$("span", map.innerMap).each(function (index, item){
			itemData = $(item).data("itemData");
			if(itemData.y==newRowNum&&itemData.scale&&itemData.scale.indexOf("doubleHeight")>=0){
				doubleHeightCount++;
			}
		});
		//本行只有 这一个元素是倍高的
		if(doubleHeightCount==1){
			heightHashMap.put(newRowNum,2*heightTimes); 
			//alert(heightHashMap.toString());
			//上移所有元素
			resetPositionQZ(newRowNum,"down");
		}
	}
}

function left(){
	var all = $("#allItems")[0].checked;

	if (all){
		$("span", map.innerMap).each(function (index, item){
			leftSingle($(this));
		});
	}else if (!all){
		leftSingle($selectedItem);
	}
}

function leftSingle($spn){
	if (0 == $spn.length){
		return;
	}
	var newCNum = $spn.data("itemData").x - parseInt($("#moveUnit").val());
	if(newCNum<0){
		return;
	}
	$x.val(newCNum);
	$spn.data("itemData").x = newCNum;
	//动态改变右边的属性值
	initRightData($spn.get(0));
	$spn.css("left", newCNum*widthTimes + "px");
}

function right(){
	var all = $("#allItems")[0].checked;
	if (all){
		$("span", map.innerMap).each(function (index, item){
			rightSingle($(this));
		});
	}else if (!all){
		rightSingle($selectedItem);
	}
}

function rightSingle($spn){
	if (0 == $spn.length){
		return;
	}
	var newCNum = $spn.data("itemData").x + parseInt($("#moveUnit").val());
	if(newCNum>39){
		return;
	}
	$x.val(newCNum);
	$spn.data("itemData").x = newCNum;
	//动态改变右边的属性值
	initRightData($spn.get(0));
	$spn.css("left", newCNum*widthTimes + "px");
}
	
	
function saveAndPrint(){
	saveConfig();
	var testString = getTickePrintFormatTest(printJo);
	$.qms.printTest(testString);
}

function getTickePrintFormatTest(printJo){
	var tickePrintFormat = new Array();
	$.each(printJo.items, function (index, item){
		if(item.type != "text" && item.type != "logo"){
			tickePrintFormat.push(item.type+"="+item.text);
		}
	});	
	return tickePrintFormat.join("|");
}

function getTickePrintFormat(printJo){
	var tickePrintFormat = new Array();
	$.each(printJo.items, function (index, item){
		if(item.type != "text" && item.type != "logo"){
			tickePrintFormat.push(item.type);
		}
	});	
	return tickePrintFormat.join("|");
}
//把json  转成  from 字符串
var brString = '\r\n';
function getTickePrintForm(printJo){
	var maxHeight = 0;
	var itemHeight = 1;
	$.each(printJo.items, function (index, item){
		if(maxHeight<item.y){
			maxHeight = item.y;
			if(item.height) itemHeight = item.height;
		}
	});
	
	maxHeight += itemHeight;
	var tickePrintForm = 'XFSMEDIA "Blank"' + brString
							+'BEGIN' + brString
							   +'UNIT MM, 1, 1' + brString
							   +'SIZE 300, 300' + brString
							+'END' + brString
							+'XFSMEDIA "ReceiptMedia"' + brString
							+'BEGIN' + brString
							   +'UNIT MM, 1, 1' + brString
							   +'SIZE 300, 300' + brString
							+'END' + brString
							+'XFSFORM "Queue7"' + brString
							+'BEGIN' + brString
							   +'SIZE      40, '+ maxHeight + brString
							   +'UNIT     ROWCOLUMN, 1, 1' + brString
							   +'ALIGNMENT TOPLEFT, 1, 0' + brString
							   +'LANGUAGE 2052' + brString;
					   
							   
	var count = 0;
	var name = "";
	var align = "LEFT";
	var style = "NORMAL";
	//alert($.toJSON(printJo.items));
	var textCount = 0;
	var logoCount = 0;
	$.each(printJo.items, function (index, item){
		if(item.type == "text"){
			textCount++;
			name = 'text'+textCount;
		}else if(item.type=="logo"){
			logoCount++;
			name = "logo"+logoCount;
		}else{
			count++;
			name = 'field'+count;		
		}
		//align 对齐方式
		if(item.align){
			if(item.align == "left"){
				align = "LEFT";
			}else if(item.align == "center"){
				align = "CENTER";
			}else{
				align = "RIGHT";
			}
		}
		
		style = "NORMAL";
		//style  scale
		if(item.style){
			if(item.style == "bold"){
				style = "BOLD";
			}
		}
		
		if(item.scale){
			if(item.scale == "doubleWidth"){
				if(style=="NORMAL"){
					style = "DOUBLE";
				}else{
					style += "|DOUBLE";
				}
			}else if(item.scale == "doubleHeight"){   
				if(style=="NORMAL"){
					style = "DOUBLEHIGH";
				}else{
					style += "|DOUBLEHIGH";
				}doubleHeightAndWidth
			}else if(item.scale == "doubleHeightAndWidth"){
				if(style=="NORMAL"){
					style = "DOUBLE|DOUBLEHIGH";
				}else{
					style += "|DOUBLE|DOUBLEHIGH";
				}
			}
		}
		
		/* 
		XFSFIELD "LOGO"
		BEGIN
		  POSITION    0,0
		  SIZE        46,1
		  HORIZONTAL    CENTER
		  STYLE       BOLD|DOUBLE|DOUBLEHIGH
		  INITIALVALUE "中国工商银行"
		END

		
			XFSFIELD "Graphic"
			 BEGIN
			 POSITION	0, 0
			 SIZE	30, 1
			 TYPE	GRAPHIC
			 HORIZONTAL  LEFT	
			 INITIALVALUE "C:\\logo\\101.bmp"
			 END
		
		
		
		
		   XFSFIELD "field2"
		   BEGIN
			POSITION    30, 0
			SIZE        12, 1
			HORIZONTAL  LEFT
			STYLE       BOLD
			INITIALVALUE "测试业务1"
		   END
		   */
		if(item.type == "logo"){
			tickePrintForm +=  'XFSFIELD "'+name+'"' + brString
								+'BEGIN' + brString
								+'POSITION    '+item.x+', '+ item.y + brString
								+'SIZE        '+(item.width? item.width:40)+',' + (item.height? item.height:1) + brString
								+'HORIZONTAL  '+ align + brString
								+'TYPE       GRAPHIC '+ brString
								+'INITIALVALUE "'+item.text+'"' + brString
								+'END' + brString;
		}else{
			tickePrintForm +=  'XFSFIELD "'+name+'"' + brString
								+'BEGIN' + brString
								+'POSITION    '+item.x+', '+ item.y + brString
								+'SIZE        '+(item.width? item.width:40)+',' + (item.height? item.height:1) + brString
								+'HORIZONTAL  '+ align + brString
								+'STYLE       '+ style + brString
								+'INITIALVALUE "'+item.text+'"' + brString
								+'END' + brString;
		}
			
	});	
	
	tickePrintForm += 'END';
	//alert(tickePrintForm.replace(/\"/g,"'"));
	return tickePrintForm.replace(/\"/g,"'");
}
	
function saveConfig(){
	printJo = getPrintData();
	//alert("打印printJo==="+$.toJSON(printJo));
	var args = {};
	args.biom = {};
	args.biom.head = {};
	args.biom.head.tradeCode = "ticketsconfig2update";
	args.biom.head.qmsIp = $.qms.getCache("qmsIp");
	args.biom.body = {};
	args.biom.body.tickePrintFormat = getTickePrintFormat(printJo);
	args.biom.body.tickePrintForm = getTickePrintForm(printJo);
	//alert(getTickePrintForm(printJo));
	args.biom.body.ticketPrintJson = $.toJSON(printJo).replace(/\"/g,"'");
	args.command=33;	
	args.callback = "updateTicketTemplateCallback";
	
	//alert("请求参数==="+$.toJSON(args));
	$.qms.getTicketsconfig(args);
	
	  /*var jo = {};
	  jo.ticketTemplate = {};
	  //alert(tktTmpId);
	  jo.ticketTemplate.tktTmpId = tktTmpId;
	  jo.ticketTemplate.tktFormat = 1;
	  jo.ticketTemplate.tktFormatId = 1;
	  jo.ticketTemplate.tktTmpName = $tktTmpName.val();
	  jo.ticketTemplate.def = $def.prop("checked");
	  jo.print = getPrintData();
	  jo.callback = "ifrm.contentWindow.updateTicketTemplateCallback";
	  //alert($.toJSON(jo));
	  $.qms.updateTicketTemplate(jo);*/
}

function updateTicketTemplateCallback(jsonString)
{
	if(jsonString){
		var rtn = $.parseJSON(jsonString);
		var body = rtn.biom.body;
		var retCode = rtn.biom.head.retCode;
		var retMsg = rtn.biom.head.retMsg;
		var retMsgArr = retMsg.split("|");
		var cnRetMsg = retMsgArr[0];
		var enRetMsg = retMsgArr.length>1 ? retMsgArr[1]:"";
		if(retCode == "0"){
			qmsVld.showInfo("修改号票模板成功");
		}else{
			qmsVld.showError(rtn.cnRetMsg ? rtn.cnRetMsg : "修改号票模板失败");
		}
	} 
	
}

function onDrag(e){
	var d = e.data;
	if (d.left < 0) { d.left = 0; }
	if (d.top < 0) { d.top = 0; }
	if(d.left > 40*widthTimes){ d.left = 40*widthTimes;}
	/*if (d.left + $(d.target).outerWidth() > $(d.parent).width()){
		d.left = $(d.parent).width() - $(d.target).outerWidth();
	}
	if (d.top + $(d.target).outerHeight()-2 > $(d.parent).height()){
		d.top = $(d.parent).height() - $(d.target).outerHeight();
	}*/

	var x = Math.round(parseInt(d.left)/widthTimes);
	var y = getRowNum(Math.round(parseInt(d.top)));
	d.left = x*widthTimes;
	d.top = getPositionY(y);
	
	
	$("#divPosition").css("left",d.left+"px").css("top",(d.top-20)+"px");
	$("#divPosition").empty().html('&nbsp;坐标&nbsp;('+Math.floor(d.left/widthTimes)+','+Math.floor(d.top/heightTimes)+')');
}

function onDrag4Win(e){
	/*var d = e.data;
	if (d.left < 0) { d.left = 0 }
	if (d.top < 0) { d.top = 0 }
	if (d.left + $(d.target).outerWidth() > $(d.parent).width()){
		d.left = $(d.parent).width() - $(d.target).outerWidth();
	}
	if (d.top + $(d.target).outerHeight() > $(d.parent).height()){
		d.top = $(d.parent).height() - $(d.target).outerHeight();
	}*/
}