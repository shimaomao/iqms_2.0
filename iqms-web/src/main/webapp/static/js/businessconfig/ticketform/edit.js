 	var params ;
    var tktTmpId ;
    var tktTmpName ;
    //by hongxz  号票模板样式，不用单独去查一次
    var tktTmpStyle;
    var bizTypeId, index, busType, map, printConfig;
    var $offsetX, $offsetY;  //打印机偏移
    var $ticket ;
    var $tktFormatId;
    var $tktTmpName ;
    var $def;
    var tabIndex = 0;
    var printX ;
    var printY ;
    var maxY = 0;
    var $lastSpan = null;
    var $ctrList ;
    var $x ;
    var $y ;
    var app = appConfig;
    
    var screenResolution; //此设备配置的分辨率
    
    var tktFormatId;
    var $staticPath;
    var $selectedItem;
    var orgId = "";
    var deviceNo = "";
    var deviceName = "";
    $(function (){
    	
    	 params = $.string(decodeURI(window.location.href)).toQueryParams(); //获取请求地址栏上的参数
	     tktTmpId = params["tktTmpId"];  //号票模板ID
	     tktTmpName = params["tktTmpName"];  //号票模板名称
	     orgId=params["orgId"]; //列表页面传递的机构号
	     deviceNo=params["deviceNo"]; //列表页面传递的设备编码
	     deviceName=params["deviceName"]; //列表页面传递的设备编码
	     //alert("设备名称："+deviceName);
	     screenResolution= params["screenResolution"]; //设备分辨率，设备表中配置
	     $ticket = $("#ticket");             //号票模板设计区域
	     $tktFormatId = $("#tktFormatId");   //号码模板id
	     $tktTmpName = $("#tktTmpName");     //号票模板名称
	     $def = $("#def");                   //是否默认模板
	     printX = parseInt($ticket.get(0).getBoundingClientRect().left); //号票配置区左边距
	     printY = parseInt($ticket.get(0).getBoundingClientRect().top);  //号票配置区上边距
	     $ctrList = $("#ctrList");  //元素类表
	     $x = $("#x");  //右侧元素x坐标
	     $y = $("#y");  //右侧元素y坐标
	     $staticPath = $("#myhidden").val();  //静态图片地址
         
      $('[data-rel="chosen"],[rel="chosen"]').chosen();  //顶部的号码模板和右侧的下拉选择框，绑定chosen插件
      $.metadata.setType("attr", "validate");  //设置验证属性字段
      
      //表单绑定验证
      $("#frm").validate({
          errorElement: 'div',   //错误信息包装元素
          errorClass: 'help-block', //错误的样式
          focusInvalid: false, //提交表单后未通过验证的表单会获得焦点
          ignore: "", //对某些元素不进行验证
          rules: { //验证规则
              tktTmpName: {   //验证的字段
                  zh_ch:true,
                  required: true, //必填
                  maxlength:50
              }
          },
        onfocusout: function (element)
        {
          $(element).valid();
        },
        submitHandler: function (form)
        {
          saveConfig();
          return false;
        }
      });

     //绑定号票配置的工具层为可拖拽（且dragpanelTitle为可拖拽区域）
      $("#dragPanel").draggable({
        handle: "#dragPanelTitle"
      });

      //设置顶部号票模板名称
      $("label[name='tktName']").text(tktTmpName);

     //关闭号票工具面板
      $('.close').click(function (e)
      {
        e.preventDefault();
        $('#dragPanel').hide();
      });

      //中间模板配置的设置按钮，打开或关闭面板
      $('#showWin').click(function (e)
      {
        e.preventDefault();
        if ($("#dragPanel").is(":hidden"))
        {
          $('#dragPanel').show();
        } else
        {
          $('#dragPanel').hide();
        }
      });
      
      //返回号票列表按钮
      $("#cancelConfig").on("click", function(){
    	 /* window.location.href = contextPath+"/businessconfig/ticketform";*/
	      window.location.href = encodeURI(contextPath+"/businessconfig/ticketform?"
	      + "&orgId=" + orgId   //机构id
	      + "&deviceNo=" + deviceNo
	      + "&deviceName=" + deviceName);   //设备名称
      });

      //中间模板配置的号票模拟区域的长度
      $('#up').click(function (e)
      {
        e.preventDefault();
        var height = parseInt($("#ticket").css("height")) - 10;
        height < 0 ? 0 : height;
        $ticket.css("height", height + "px");
        map.innerMap.css("height", height + "px");
      });
      
      //中间模板配置的长度向下拉伸
      $('#down').click(function (e)
      {
        e.preventDefault();
        var height = parseInt($("#ticket").css("height")) + 10;
        $ticket.css("height", height + "px");
        map.innerMap.css("height", height + "px");
      });
      
      //最右边的号票设置页面上的 “ X ” 文本框，动态显示中间元素的X轴坐标信息（便选中元素的改变）
      $x.on("change", function ()
      {
        if (!$selectedItem) return;  //没有选中的元素
        if (!$.isNumeric(this.value)) { //填写的不是数字，就还原被选中元素的坐标值
          $(this).val($selectedItem.data("itemData").x);
        } else {  //改变被选中元素的元数据中的坐标值，同时修改样式
          $(this).val(parseInt(this.value));
          //改变dataItem值
          $selectedItem.data("itemData").x = parseInt(this.value);
          $selectedItem.css("left", this.value + "px");
          
          initItemStyle($selectedItem);
        }
      });

      //最右边的号票设置页面上的 “ Y ” 文本框，动态显示中间元素的Y轴坐标信息
      $y.on("change", function ()
      {
        if (!$selectedItem) return;
        if (!$.isNumeric(this.value))
        {
          $(this).val($selectedItem.data("itemData").y);
        } else
        {
          $(this).val(parseInt(this.value));
          //改变dataItem值
          $selectedItem.data("itemData").y = parseInt(this.value);
          $selectedItem.css("top", this.value + "px");
          //改变左边的显示效果
          initItemStyle($selectedItem);
        }
      });
      //初始化页面数据
      setTimeout(initPage, 0);
    });
    
    
    /**
     * 1、页面初始化：查询号票配置
     */
    function initPage(){
    
      maxY = 0;  //最大的元素坐标
      
      //获取号票模板数据
      $.ajax({
  		url: contextPath+"/businessconfig/ticketform/edit?ftype=select&_method=get", 
  		type : "get",
  		dataType: "json",
  		data:{"tktTmpId":tktTmpId,"orgId":orgId,"deviceNo":deviceNo},
  		contentType: "application/json",
  		success: function(data) {
  			//alert($.toJSON(data))
  			//----------------------------------------------------上面初始化 start--------------------------------------------
  			$tktTmpName.val(data.tktTmpName);  //设置号票模板名称
  			//设置是否默认模板
  			parseInt(data.def) ? $def.prop("checked", true) : $def.prop("checked", false);
  			//获取模板id
  			tktFormatId = data.tktFormatId;
  			
  			//获取号票样式
  			tktTmpStyle = data.tktTmpStyle;
  			//查询所有的号码模板
  			getTktFormats();
  		},
  		error: function(msg) {
  			qmsVld.showError("出错了！");
  		}
  	  })
    }
    
    /**
     * 查询所有的号码模板，同时设置号码模板的初始值
     */
    function getTktFormats(){
    	$.ajax({
      		url: contextPath+"/businessconfig/numberform?dt="+(new Date().getTime()), 
      		type : "get",
      		dataType: "json",
      		contentType: "application/json",
      		success: function(data) {
      			 //alert($.toJSON(data))
      			 if (data[0].tktFormats){ 
      				 chose_ini_tktFormat("#tktFormatId", data[0].tktFormats, tktFormatId);
      			 }
      			 
      			// 初始化：元素列表，模拟号票区域，右边属性区域
      	        getSettingsByType();
      		},
      		error: function(msg) {
      			qmsVld.showError("出错了！"+msg);
      		}
    	})
    }
    
    /**
     * 初始化select控件的方法，同时设置初始值
     * @param select  select元素id
     * @param jsonObj  select元素的option数据
     * @param iniValue  初始值
     */
    function chose_ini_tktFormat(select, jsonObj, iniValue)
    {
      $(select).empty().html("");
      $(select).append("<option value=''  style='font-family:SimHei;'>请选择一项</option>");
      var $option;
      $.each(jsonObj, function (index, item)
      {
        $option = $("<option value='" + item.tktFormatId + "'  style='font-family:SimHei;'>" + tktFormat2zhStr(item.tktFormat) + "</option>");
        $option.data("tktFormat", item.tktFormat);
        $(select).append($option);
      });
      if (iniValue) $(select).val(iniValue);
      $(select).trigger("chosen:updated");
    }
    
    /**
     * 展示界面元素：
     * 1、初始化右侧，号票元素列表
     * 2、初始化中间号票模拟区域
     * 3、初始化右边属性区域
     * 4、绑定元素列表拖拽事件，号票模拟区域单击事件，拖拽事件
     */
    function getSettingsByType(){
    	$ctrList.html("");
    	//查询号票元素类表
    	$.ajax({               
      		url: contextPath+"/basicconfig/sysdic/ticketElement?dt="+(new Date().getTime()), 
      		type : "get",
      		dataType: "json",
      		contentType: "application/json",
      		success: function(data) {
      			var settings = data.rows;
      			var widthStr = "";
      		    var xWidth = (screenResolution).split("x")[0];
      		    //alert(xWidth);
      		      if (xWidth <= 768)
      		      {
      		        widthStr = "width:130px;";
      		      }else{
		  	    	widthStr = "width:110px;";
		  	      }
      			var $li = null;
      			
      			//装载可拖拽控件
      			$.each(settings,function(index,item){
      				if(item.key == "logo"){
      					$li = $("<li id='" + item.key + "' style='" + widthStr + "display:inline-block;'><a class='ajax-link'   href='javascript:void(0);' style='width:100%;height:40px;background-size:100% 100%;background-image:url(" + $staticPath +"/static/components/ticket/images/logo2.png);'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a></li>");
      				}else{
      					$li = $("<li id='" + item.key + "' style='" + widthStr + "display:inline-block;'><a class='ajax-link'   href='javascript:void(0);'><i class='glyphicon glyphicon-font'></i><span>" + item.value + "</span></a></li>");
      				}
      				$li.appendTo($ctrList);
      			});
      			//----------------------------------------------------左边初始化 end--------------------------------------------
      			
      			//----------------------------------------------------中间初始化 start------------------------------------------
      			$offsetX = $("#offsetX");
      	    	$offsetY = $("#offsetY");
      	    	 if(!tktTmpStyle){
     				qmsVld.showInfo("该号票样式为空！");
     			 }
 				//初始化号票模拟区域内容
     			 preview(tktTmpStyle);
      	    	 
      	    	 
      			//----------------------------------------------------中间初始化 end--------------------------------------------
      			
      			//----------------------------------------------------右边初始化 start------------------------------------------
      	    	//初始化右边元素类型值
       			if (settings){
       				chose_ini("#ctrStyle", settings, null);
       			}
      			
      			//右边属性样式改变时，中间号票样式跟着改变
      			$("#ctrStyle").on("change", function (){
			        if (!$selectedItem) return;
			        $selectedItem.data("itemData").type = this.value;
			        initItemStyle($selectedItem);
			    });
	
			    $("#ctrText").on("change", function (){
			        if (!$selectedItem) return;
			        $selectedItem.data("itemData").text = this.value;
			        //add by tianjm 20181113
			        var regEn = /[`#$^&()+<>"{},.\/;'[\]]/im,
			        regCn = /[·#‘[\]]/im;
			        if(regEn.test(this.value) || regCn.test(this.value)) {
			        	qmsVld.showError('文字内容不能包含特殊字符');
				        return;
			        }
			        
		        	initItemStyle($selectedItem);
			      });
	
			    $("#fontFamily").on("change", function (){
			        if (!$selectedItem) return;
			        $selectedItem.data("itemData").family = this.value;
			        initItemStyle($selectedItem);
			      });
	
			    $("#fontStyle").on("change", function (){
			        if (!$selectedItem) return;
			        $selectedItem.data("itemData").style = this.value;
			        initItemStyle($selectedItem);
			      });
	
			    $("#fontSize").on("change", function (){
			        if (!$selectedItem) return;
			        $selectedItem.data("itemData").size = this.value;
			        initItemStyle($selectedItem);
			      });
			    
			    //上面号码模板单选框改变时
			    $tktFormatId.on("change", function (){
			        if ($tktFormatId.val())
			        {
			          qmsVld.removeErrorCss($tktFormatId.get(0));
			          $tktFormatId.parent().attr("data-content", "");
			          $tktFormatId.parent().popover('hide');
			        }
			      });
			   //----------------------------------------------------右边初始化 end--------------------------------------------  
			    
			    bindResize(document.getElementById('ticket'));
			    
			    //ticket号票鼠标移动事件
			    $("#ticket").mousemove(function (e){
	    	        if ($(this).attr('class') != 'selected' && $(".clone").length > 0)
	    	        {
	    	          $(this).addClass('over');
	    	        }
	    	      });
			    
			    //ticket号票模拟区域，鼠标移出事件
	    	    $("#ticket").mouseout(function (e){
	    	        if ($(this).attr('class') != 'selected')
	    	        {
	    	          $(this).removeClass('over');
	    	        }
	    	      });
	    	    
	    	    //当克隆元素移动到号票画板上，松开鼠标时，如果已经有克隆元素，就将克隆元添加到号票模拟区域，同时绑定事件
	    	    $("#ticket").mouseup(function (e){
	    	        if ($(this).attr('class') != 'selected' && $(".clone").length > 0)
	    	        {
	    	          var $spn = $(".clone");
	    	          $spn.attr("tabIndex", tabIndex);
	    	          tabIndex++;
	    	          initItemStyle($spn.get(0));
	    	          
	    	          //元素绑定鼠标按下事件
	    	          $spn.on("mousedown", function ()
	    	          {
	    	            map.moveImage = false;
	    	            $("#allItems")[0].checked = false;
	    	            $selectedItem = $(this);
	    	            //动态改变右边的属性值
	    	            initRightData(this);
	    	            this.focus();
	    	            $("span", map.innerMap).each(function (index, item)
	    	            {
	    	              $(this).css("border", "0px");
	    	            });
	    	            $(this).css("border", "1px dotted red");
	    	          });
	    	          
	    	          //元素绑定鼠标松开事件：重新计算坐标
	    	          $spn.on("mouseup", function ()
	    	          {
	    	            var x = parseInt($(this).css("left"));
	    	            var y = parseInt($(this).css("top"));
	    	            $x.val(x);
	    	            $y.val(y);
	    	            $(this).data("itemData").x = x;
	    	            $(this).data("itemData").y = y;
	    	            //动态改变右边的属性值
	    	            initRightData(this);
	    	          });
	    	          
	    	          //鼠标逝去焦点
	    	          $spn.on("blur", function ()
	    	          {
	    	            $("#allItems")[0].checked = false;
	    	            if (document.activeElement.tagName != "SPAN")
	    	            {
	    	              //map.moveImage = true;
	    	            }
	    	          });
	    	          
	    	          //绑定拖拽事件
	    	          $spn.draggable({ onDrag: onDrag });
	    	          $spn.appendTo(map.innerMap);
	    	          var left = parseInt($(".clone").css('left'));
	    	          var top = parseInt($(".clone").css('top'));
	    	          $spn.css('left', left - printX).css('top', top - printY);
	    	          $spn.attr('class', '');
	    	          $spn.data("itemData").x = left - printX;
	    	          $spn.data("itemData").y = top - printY;
	    	          $spn.mousedown();
	    	        }
	    	     });

	    	    
//----------------------------------------------------左边取号元素  绑定事件 start--------------------------------------------      	    
	    	    //鼠标按下左边元素后，鼠标变移动标志，克隆元素，并确定新克隆元素位置
	    	    $("#ctrList li").mousedown(function (e){
	    	        var $span = $("<span style='list-style:none;position:absolute;'></span>");
	    	        $span.addClass("clone").appendTo($("body"));//将克隆元素追加到body末尾
	    	        $("body").css('cursor', 'move');  //设置鼠标样式为移动的样式
	    	        $span.css('left', e.clientX + 1);//动态给克隆元素赋值坐标信息
	    	        $span.css('top', e.clientY + 1);

	    	        var itemData = {};
	    	        if ($(this).text())  //有文字内容就是一般元素
	    	        {
	    	          itemData.type = this.id;
	    	          itemData.text = $(this).text();
	    	          itemData.family = "SimSun";
	    	          itemData.style = "normal";
	    	          itemData.size = 14;
	    	        } else  //否则就是图片
	    	        {
	    	          itemData.type = "logo";
	    	        }
	    	        $span.data("itemData", itemData);

	    	     });
	    	    
	    	    //当有克隆数据，移动元素(拖拽元素拖动松开不会触发事件)
	    	    $(document).mousemove(function (e)
	    	      {
	    	        if ($(".clone").length > 0)
	    	        {
	    	          $(".clone").css('left', e.clientX + 1);
	    	          $(".clone").css('top', e.clientY + 1);
	    	          //console.info("克隆元素在移动x："+$(".clone").css('left')+" 克隆元素在移动y："+$(".clone").css('top'));
	    	        }
	    	      });
	    	    
	    	    //当松开鼠标时，移去之前新增的克隆元素（拖拽元素时松开，不会触发这个事件）
	    	    $(document).mouseup(function (e)
	    	      {
	    	        $(".clone").remove();
	    	        $("body").css('cursor', 'auto');
	    	      });
			    	    
      		},
      		error: function(msg) {
      			qmsVld.showError("出错了！"+msg);
      		}
       });
    }
    
    /**
     * 初始化号票模拟区域的元素值，及位置
     * @param data
     */
    function preview(data){
      $("#ticket").css("color", "blue");

      //function Map(id,width, height, src, backWidth, backHeight,backSrc,zoom)
      map = new Map("ticket", 310, 500, "images/sssss.jpg", null, null, null, 1);
      map.moveImage = false;
      if (data) {  //数据存在
    	  var rlt = JSON.parse(data) ;//json字符串转json对象
    	   printConfig = rlt.print;  //号票打印内容
    	  
            if (printConfig)
            {
              $offsetX.val(printConfig.offset.x); //设置打印机偏移量
              $offsetY.val(printConfig.offset.y); //设置打印机偏移量
              var $spn;
              $.each(printConfig.items, function (index, item) //循环遍历，创建各个元素项。
              {
            	//创建span元素，且设置坐标位置
                $spn = $("<span type='prt-" + item.type + "' tabindex='" + tabIndex + "'></span>").css("position", "absolute").css("top", item.y + "px").css("left", item.x + "px");
                tabIndex++;
                $spn.data("itemData", item); //设置span的元素数据
                //初始化中间元素
                initItemStyle($spn.get(0)); //转换成js对象
                
                //绑定鼠标按下事件:
                //1、配置工具所有项被选中变为false
                //2、设置被选中的项为点击项
                //3、右边元素展示被选中元素的值
                //4、调整其他span元素没有边框，被选中的元素有边框
                $spn.on("mousedown", function ()
                {
                  map.moveImage = false;
                  $("#allItems")[0].checked = false;
                  $selectedItem = $(this);
                  //动态改变右边的属性值
                  initRightData(this);
                  this.focus();
                  
                  //设置其他span元素没有边框
                  $("span", map.innerMap).each(function (index, item)
                  {
                    $(this).css("border", "0px");
                  });
                  //设置此元素有边框
                  $(this).css("border", "1px dotted red");
                });
                
                //鼠标抬起事件：
                //1、重新计算元素的位置，保存到元数据中，右边属性框
                //2、重新初始化右边属性值
                $spn.on("mouseup", function ()
                {
                  var x = parseInt($(this).css("left"));
                  var y = parseInt($(this).css("top"));
                  $x.val(x);
                  $y.val(y);
                  $(this).data("itemData").x = x;
                  $(this).data("itemData").y = y;
                  //动态改变右边的属性值
                  initRightData(this);
                });
                
                //span元素失去焦点
                $spn.on("blur", function ()
                {
                  $("#allItems")[0].checked = false;
                  if (document.activeElement.tagName != "SPAN")
                  {
                    //map.moveImage = true;
                  }
                });
                
                //设置span元素可拖拽，及拖拽时触发的事件
                $spn.draggable({ onDrag: onDrag });
                
                //保存span元素到map.innerMap中
                map.innerMap.append($spn);
                
                //设置最后一个元素
                if (maxY <= item.y)
                {
                  maxY = item.y;//最后一个元素的y坐标
                  $lastSpan = $spn;
                }
              });
            }
          //动态改变号票画板的高度
    	  changeTicketDivHeight();
    	    
          //选中第一个logo元素，这样右边的单选框就默认是logo
          $("span", map.innerMap).eq(0).mousedown();
        }
    }
    
    /**
     * 根据元素属性数据，调整元素在号票模拟区域中的样式，位置，等属性
     * @param obj  被选中的元素
     */
    function initItemStyle(obj)
    {
      var item = $(obj).data("itemData"); //被选中元素的原始数据
      //alert($.toJSON(item))
      var $spn = $(obj);   
      if (item.type == "logo")  //元素类型为logo
      {
        $spn.empty().html("<img style=\"width:183px;height:44px\" src='" + $staticPath +"/static/components/ticket/images/logo2.png'><button type='button' class='close' onclick='closeSpan(this)' data-dismiss='modal'>×</button>");
      } else if(item.type == "qrCode"){//二维码
    	  $spn.empty().html("<label>" + item.text + "</label><button style=\"width:180px;height:100px\" type='button' class='close' onclick='closeSpan(this)' data-dismiss='modal'>×</button>");
      }else  //非logo、二维码元素
      {
    	//非logo元素清空，重新生成元素 （标签+删除按钮的元素）
        $spn.empty().html("<label>" + item.text + "</label><button type='button' class='close' onclick='closeSpan(this)' data-dismiss='modal'>×</button>");
      }
      
      //设置标签元素的样式
      var $label = $spn.find("label");
      if (item.family) //字体
      {
        $spn.css("font-family", item.family);
      } else
      {
        $spn.css("font-family", "SimSun");
      }
      if (item.style) //正常，斜体，加粗，斜体加粗
      {
        if (item.style == "normal")
        {
          $label.css("font-style", "normal").css("font-weight", "normal");
        } else if (item.style == "italic")
        {
          $label.css("font-style", "italic").css("font-weight", "normal");
        } else if (item.style == "bold")
        {
          $label.css("font-style", "normal").css("font-weight", "bold");
        } else if (item.style == "boldAndItalic")
        {
          $label.css("font-style", "italic").css("font-weight", "bold");
        }
      } else
      {
        $label.css("font-style", "normal").css("font-weight", "normal");
      }

      if (item.size)  //字体大小
      {
        $label.css("font-size", item.size + "px");
      } else
      {
        $label.css("font-size", "14px");
      }

      if (item.width)  //元素长度
      {
        $spn.css("width", item.width + "px").css("word-break", "break-all");
      }
      else
      {
        $spn.css("width", item.width + "px").css("word-break", "keep-all");
      }

      if (item.x)   //元素 x坐标
      {
        $spn.css("left", item.x + "px");
      }

      if (item.y)  //元素y坐标
      {
        $spn.css("top", item.y + "px");
      }
    }
    
    /**
     * 展示被选中的元素，在右边属性里面显示的值
     * @param obj
     */
    function initRightData(obj)
    {
      var itemData = $(obj).data("itemData");

      $x.val(itemData.x);
      $y.val(itemData.y);
      chose_set_ini("#ctrStyle", itemData.type);
      $("#ctrText").val(itemData.text);
      chose_set_ini("#fontFamily", itemData.family);
      chose_set_ini("#fontStyle", itemData.style);
      chose_set_ini("#fontSize", itemData.size);
    }
    
    /**
     * 根据最后一个元素，改变号票模拟区域的高度
     */
    function changeTicketDivHeight(){
      var tmpHeight = 400;
      if ($lastSpan)
      {
        tmpHeight = maxY + 50 + $lastSpan.get(0).offsetHeight;//加上最后一个元素的offsetHeight
      }
      //alert(tmpHeight);
      $("#ticket").css("height", tmpHeight);
      map.innerMap.css("height", tmpHeight);
    }
    
    /**
     * 初始化右边元素类型
     * @param select
     * @param jsonObj
     * @param iniValue
     */
    function chose_ini(select, jsonObj, iniValue)
    {
      $(select).empty().html("");
      $.each(jsonObj, function (index, item)
      {
        $(select).append("<option value='" + item.key + "'  style='font-family:SimHei;'>" + item.value + "</option>");
      });
      if (iniValue) $(select).val(iniValue);
      $(select).trigger("chosen:updated");
    }

    //格式化转换为固定格式前台展示
    function tktFormat2zhStr(tktFormat)
    {
      var zhStr = "";
      var tktFormatArr = tktFormat.split("|");
      if (tktFormat.length > 1)
      {
        for (var i = 0; i < tktFormatArr.length; i++)
        {
          if (tktFormatArr[i] == "tktPrefix")
          {
            zhStr += "业务字头|";
          } else if (tktFormatArr[i] == "custPrefix")
          {
            zhStr += "等级字头|";
          } else
          {
            zhStr += tktFormatArr[i].length + "位流水";
          }
        }
      }
      return zhStr;
    }

    //单选select 值初始化
    function chose_set_ini(select, value)
    {
      $(select).val(value);
      $(select).trigger("chosen:updated");
    }

    //多选select 数据初始化
    function chose_mult_set_ini(select, values)
    {
      var arr = values.split(',');
      var length = arr.length;
      var value = '';
      for (i = 0; i < length; i++)
      {
        value = arr[i];
        $(select + " [value='" + value + "']").attr('selected', 'selected');
      }
      $(select).trigger("chosen:updated");
    }

    function closeSpan(obj)
    {
      var $span = $(obj).parent().remove();
    }

    function bindResize(el){
        //初始化参数
        var els = el.style,
        //alert(11)
        //鼠标的 X 和 Y 轴坐标
  		x = y = 0;
        //邪恶的食指
        
        $(el).mouseout(function (e)
        {
          if (Math.abs(e.clientY - (printY + el.offsetHeight)) > 2)
          {
            $(el).css("cursor", "default");
          } else
          {
            $(el).css("cursor", "ns-resize");
          }
        });
        $(el).mousedown(function (e)
        {
          //alert(Math.abs(e.clientY-(printY+el.offsetHeight)));
          if (Math.abs(e.clientY - (printY + el.offsetHeight)) > 2)
          {
            return;
          }
          //按下元素后，计算当前鼠标与对象计算后的坐标
          x = e.clientX - el.offsetWidth,
  		  y = e.clientY - el.offsetHeight;
          //在支持 setCapture 做些东东
          el.setCapture ? (
          //捕捉焦点
  				el.setCapture(),
          //设置事件
  				el.onmousemove = function (ev)
  				{
  				  mouseMove(ev || event);
  				},
  				el.onmouseup = mouseUp
  			) : (
          //绑定事件
  				el.onmouseup = mouseUp
          //$(document).bind("mousemove", mouseMove).bind("mouseup", mouseUp);
  			);
          //防止默认事件发生
          e.preventDefault();
        });
        
        //移动事件
        function mouseMove(e)
        {
          //宇宙超级无敌运算中...
          //els.width = e.clientX - x + 'px',
          els.height = e.clientY - y + 'px';
        }
        
        //停止事件
        function mouseUp()
        {
          //在支持 releaseCapture 做些东东
          el.releaseCapture ? (
          //释放焦点
  				el.releaseCapture(),
          //移除事件
  				el.onmousemove = el.onmouseup = null
  			) : (
          //卸载事件
  				$(document).unbind("mousemove", mouseMove).unbind("mouseup", mouseUp)
  			);
        }
    }
    
    //打印号票的样式
    function getPrintData(){
      var arg = {};
      if (!printConfig)
      {
        printConfig = {};
        printConfig.dpi = 100;
      }
      arg.dpi = printConfig.dpi;
      arg.family = "SimSun";
      arg.style = "normal";
      arg.size = 14;

      var list = [];
     
      $("span", map.innerMap).each(function (index, item){
    	 if(this.style.display != "none"){
	        //改变item位置
	        $(item).data("itemData").x = parseInt(this.style.left.replace("px", ""));
	        $(item).data("itemData").y = parseInt(this.style.top.replace("px", ""));
	        if ($(item).data("itemData").type == "logo")
	        {
	          $(item).data("itemData").width = 183;
	          $(item).data("itemData").height = 44;
	        }else if($(item).data("itemData").type == "qrCode"){
	        	$(item).data("itemData").width = 180;
		        $(item).data("itemData").height = 100;
	        }
	        list.push($(item).data("itemData"));
    	 }
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


    function up()
    {
      var all = $("#allItems")[0].checked;

      if (all)
      {
        $("span", map.innerMap).each(function (index, item)
        {
          upSingle($(this));
        });
      } else if (!all)
      {
        upSingle($selectedItem);
      }
    }

    function upSingle($spn)
    {
      if (0 == $spn.length)
      {
        return;
      }
      var t = parseInt($spn[0].style.top.replace("px", ""));
      var u = $("#moveUnit").val();
      var d = parseInt(u);
      var t1 = t - d;
      t1 = (t1 < 0) ? 0 : t1;
      $spn.css("top", t1 + "px")
    }

    function down()
    {
      var all = $("#allItems")[0].checked;

      if (map.front && all)
      {
        $("span", map.innerMap).each(function (index, item)
        {
          downSingle($(this));
        });
      }
      else if (!map.front && all)
      {
        $("span", map.innerBackMap).each(function (index, item)
        {
          downSingle($(this));
        });
      }
      else if (map.front && !all)
      {
        downSingle($selectedItem);
      }
      else if (!map.front && !all)
      {
        downSingle($selectedItem);
      }
    }

    function downSingle($spn)
    {
      if (0 == $spn.length)
      {
        return;
      }
      var t = parseInt($spn[0].style.top.replace("px", ""));
      var u = $("#moveUnit").val();
      var d = parseInt(u);
      var t1 = t + d;

      var h, s;

      if (map.front)
      {
        h = parseInt(map.innerMap.css("height").replace("px", ""));
      }
      else
      {
        h = parseInt(map.innerBackMap.css("height").replace("px", ""));
      }

      s = $spn.css("font-size").replace("px", "")
      var h1 = h - s;
      t1 = (t1 > h1) ? h1 : t1;
      $spn.css("top", t1 + "px")
    }

    function left()
    {
      var all = $("#allItems")[0].checked;

      if (all)
      {
        $("span", map.innerMap).each(function (index, item)
        {
          leftSingle($(this));
        });
      }
      else if (!all)
      {
        leftSingle($selectedItem);
      }
    }

    function leftSingle($spn)
    {
      if (0 == $spn.length)
      {
        return;
      }
      var l = parseInt($spn[0].style.left.replace("px", ""));
      var u = $("#moveUnit").val();
      var d = parseInt(u);
      var l1 = l - d;
      l1 = (l1 < 0) ? 0 : l1;
      $spn.css("left", l1 + "px")
    }

    function right()
    {
      var all = $("#allItems")[0].checked;
      if (all)
      {
        $("span", map.innerMap).each(function (index, item)
        {
          rightSingle($(this));
        });
      }
      else if (!all)
      {
        rightSingle($selectedItem);
      }
    }

    function rightSingle($spn)
    {
      if (0 == $spn.length)
      {
        return;
      }
      var l = parseInt($spn[0].style.left.replace("px", ""));
      var u = $("#moveUnit").val();
      var d = parseInt(u);
      var l1 = l + d;
      var w;

      if (map.front)
      {
        w = parseInt(map.innerMap.css("width").replace("px", ""));
      }
      else
      {
        w = parseInt(map.innerBackMap.css("width").replace("px", ""));
      }

      var s = parseInt($spn.css("width").replace("px", ""));
      var w1 = w - s;
      l1 = (l1 > w1) ? w1 : l1;
      $spn.css("left", l1 + "px");
    }

    /**
     * 号票保存
     */
    function saveConfig(){
        debugger
        var form = $("#frm");
        console.log(form);
        if (!form.valid()){
            return ;
        }
      var jo = {};
      jo.ticketTemplate = {};
      jo.ticketTemplate.tktTmpId = tktTmpId;  //号票模板id
      jo.ticketTemplate.tktTmpName = $tktTmpName.val();  //号票模板名称
      jo.ticketTemplate.def = $def.prop("checked");   //是否默认模板
      jo.ticketTemplate.tktFormatId = $tktFormatId.val();   //号码模板id
      jo.ticketTemplate.tktFormat = $tktFormatId.find("option:selected").data("tktFormat"); //号码模板格式
      // by hongxz 20170927 增加机构信息
      jo.ticketTemplate.orgId = orgId;  //机构id
      jo.ticketTemplate.deviceNo = deviceNo;  //机构id
      
      
      
      jo.print = getPrintData();  //模拟号票内容
      var myData = $.toJSON(jo);
      
      $.ajax({
    		url: contextPath+"/businessconfig/ticketform/saveconfig?dt="+(new Date().getTime()), 
    		type : "post",
    		dataType: "json",
    		data:myData,//json对象转json字符串
    		contentType: "application/json",
    		success: function(data) {
    			 //alert($.toJSON(data))
    			 if (data.errorCode == 0)
			      {
			        qmsVld.showInfo("修改号票模板成功！");
			      }
    			 else if (data.errorCode == 1)
			      {
			        qmsVld.showError("文本内容不能包含特殊符号");
			      }  
    			 else
			      {
			        qmsVld.showError("保存号票模板出现错误！");
			      }
    		},
    		error: function(msg) {
    			qmsVld.showError("出错了！"+msg);
    		}
  	  });
    }

    /**
     * 元素拖拽时，触发的事件。拖拽时设置元素坐标位置
     * @param e
     */
    function onDrag(e)
    {
      var d = e.data;  //获取拖拽元素的原始数据
      if (d.left < 0) { d.left = 0 }   //拖拽不超过边界
      if (d.top < 0) { d.top = 0 }    //拖拽不超过边界
      if (d.left + $(d.target).outerWidth() > $(d.parent).width())
      {
        d.left = $(d.parent).width() - $(d.target).outerWidth();
      }
      if (d.top + $(d.target).outerHeight() > $(d.parent).height())
      {
        d.top = $(d.parent).height() - $(d.target).outerHeight();
      }
    }

    function onDrag4Win(e)
    {
    }

