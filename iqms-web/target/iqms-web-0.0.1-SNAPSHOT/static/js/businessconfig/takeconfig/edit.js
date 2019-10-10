	var params ;
    var styleId ;  
    var styleName ;  
    var $styleName ;
    var bizTypeId, index, busType, map, printConfig;
    var $offsetX, $offsetY;
    var $screenResolution ;
    var $dateTypeId ;
    var $copyStatus ;
    var app = appConfig;
    var jplayerIndex = 0;
    var tabIndex = 0;
    var maxY = 0;
    var $lastSpan = null;
    var $ctrList ;
    var backgroundImgList = null;
    var $myModal ;
    var $objId ;
    var $myImagePicker ;
    var $icon ;
    var $ctrText ;
    var $effect;
    var $scrollAmount ;
    var $direction ;
    var $backgroundColor ;
    var $backgroundImage ;
    var $fontFamily;
    var $fontStyle ;
    var $fontSize ;
    var $fontColor;
    var $ctrText ;
    var $shadow ;
    var $shadowH;
    var $shadowV ;
    var $shadowBlur;
    var $rotate ;
    var $angleOfRotationX ;
    var $angleOfRotationY ;
    var $angleOfRotationZ ;

    var $shape ;
    var $skew ;
    var $skewH ;
    var $skewV ;

    var $borderRadius;
    var $topLeft1;
    var $topRight1 ;
    var $bottomRight1 ;
    var $bottomLeft1 ;
    var $selectedItem;
    var $topLeft2 ;
    var $topRight2 ;
    var $bottomRight2 ;
    var $bottomLeft2 ;
	var $isMute ;
	var videoList = [];
	var musicList = [];
	var settings = null;
	var bizDatas;
	var $staticPath;
	var $def ;
	var orgId;
	var deviceNo;
	var volume;
	var isMute;
	//20171008 by hongxz  设备表里面配置的分辨率
	var screenResolution;
	var $ads;
	var deviceName;
//-----------------------------------------1、初始化加载   start---------------------------------------
	$(function(){
		 //console.info("取号界面：页面初始化");
		 params = $.string(decodeURI(window.location.href)).toQueryParams();  //获取请求地址上的参数
	     styleId = params["styleId"];   //获取模板的id
	     styleName = params["styleName"];  //获取模板的名称
	     orgId = params["orgId"];    //获取机构id
	     deviceNo = params["deviceNo"];  //获取设备编码
	     deviceName=params["deviceName"]; //列表页面传递的设备编码
	     screenResolution = params["screenResolution"]; // 获取设备的分辨率
	     //alert("设备分辨率："+screenResolution);
	     $def = $("#def");       //是否默认
	     //设置是否是默认模板
	     var def = params["def"];
	     parseInt(def) ? $def.prop("checked", true) : $def.prop("checked", false);	
	     
	     $styleName = $("#styleName");   //页面模板名称元素
	     $screenResolution = $("#screenResolution");  //元素控件：屏幕分辨率下拉框元素
	     $dateTypeId = $("#dateTypeId");  //日期类型下来框元素
	     $copyStatus = $("#copyStatus");  //是否假日，平日，相同
	     $ctrList = $("#ctrList");        //右边拖拽元素列表
	     $myModal = $('#myModal');        //背景图片选择对话框
	     $objId = $("#objId");            //
	     $myImagePicker = $("#myImagePicker");  //取号界面：背景图片选择层元素
	     $icon = $("#icon");                  //小图标选择元素
	     $effect = $("#effect");              //右侧效果
	     $scrollAmount = $("#scrollAmount");  //右侧效果：动画速度
	     $direction = $("#direction");        //右侧效果：动画方向
	     $backgroundColor = $("#backgroundColor");  //右侧：背景色
	     $backgroundImage = $("#backgroundImage");  //右侧：背景图片
	     $fontFamily = $("#fontFamily");            //右侧：字体
	     $fontStyle = $("#fontStyle");      //右侧：字形
	     $fontSize = $("#fontSize");        //右侧：字体大小
	     $fontColor = $("#fontColor");      //右侧：字体颜色
	     $ctrText = $("#ctrText");            //右侧：文本内容
	     $shadow = $("#shadow");              //右侧：
	     $shadowH = $("#shadowH");//右侧阴影：水平阴影
	     $shadowV = $("#shadowV");//右侧阴影：垂直阴影
	     $shadowBlur = $("#shadowBlur");//右侧阴影：距离
	     $rotate = $("#rotate");//右侧：旋转
	     $angleOfRotationX = $("#angleOfRotationX");  //右侧：X旋转
	     $angleOfRotationY = $("#angleOfRotationY");  //右侧：Y旋转
	     $angleOfRotationZ = $("#angleOfRotationZ");  //右侧：Z旋转
	     $shape = $("#shape");   //右侧：形状
	     $skew = $("#skew");     //右侧：倾斜
	     $skewH = $("#skewH");   //右侧倾斜：水平倾斜
	     $skewV = $("#skewV");   //右侧倾斜：垂直倾斜
	     $borderRadius = $("#borderRadius");  //右侧：圆角
	     $topLeft1 = $("#topLeft1");          //右侧圆角：左上1
	     $topRight1 = $("#topRight1");  //右侧圆角：右上1
	     $bottomRight1 = $("#bottomRight1");  //右侧圆角：右下1
	     $bottomLeft1 = $("#bottomLeft1");    //右侧圆角：左下1
	     $topLeft2 = $("#topLeft2");          //右侧圆角：左上2
	     $topRight2 = $("#topRight2"); //右侧圆角：右上2
	     $bottomRight2 = $("#bottomRight2");  //右侧圆角：右下2
	     $bottomLeft2 = $("#bottomLeft2");    //右侧圆角：左上2
		 $isMute = $("#isMute");             //右侧静音
		 $staticPath = $("#myhidden").val();  //静态资源地址
		 
		  
	      $styleName.val(styleName);    //设置模板名称
	      $('[data-rel="chosen"],[rel="chosen"]').chosen();  //下拉select元素绑定chosen控件
	      $.metadata.setType("attr", "validate");   //配置验证字段
	      //表单绑定验证
	      $("#frm").validate({
	        onfocusout: function (element)
	        {
	          $(element).valid();
	        },
	        submitHandler: function (form)
	        {
	          saveAndPrintConfig();
	          return false;
	        }
	      });
	     
		  //返回号票列表按钮
	      $("#cancelConfig").on("click", function(){
	    	  window.location.href =   encodeURI(contextPath+"/businessconfig/takeconfig?"
		      + "&orgId=" + orgId   //机构id
		      + "&deviceNo=" + deviceNo
		      + "&deviceName=" +deviceName);   //设备名称
	    	  
	      });
	      
	     //查询图片轮播广告
	      $.ajax({
		    	url: contextPath+"/businessconfig/takeconfig/getPicture?dt="+(new Date().getTime()), 
		  		type : "get",
		  		dataType: "json",
		  		data:{},
		  		contentType: "application/json",
		  		success: function(data) {
		  			$ads = data;
		  		},
		  		error: function(msg) {
		  			alert("出错了！");
		  		}
		  });
	      
	      
	     //------------------------------2、查询音量和是否静音  start ---------------------------------
	      $.ajax({
	    	url: contextPath+"/basicconfig/sysdic/deviceElement?dt="+(new Date().getTime()), 
	  		type : "get",
	  		dataType: "json",
	  		data:{},
	  		contentType: "application/json",
	  		success: function(data) {
	  			var list =  data.rows;
	  			$.each(list,function(index, item){
	  				if(item.key == "volume" ){
	  					volume = item.value;
	  				}
	  				if(item.key == "isMute" ){
	  					isMute = item.value;
	  				}
	  			});
	  			//查询视频列表
	  			getVideoList();
	  		},
	  		error: function(msg) {
	  			alert("出错了！");
	  		}
	  	  });
	    //------------------------------2、查询音量和是否静音  end ---------------------------------
	});
	//-----------------------------------------1、初始化加载   end---------------------------------------
	
	
	//---------------------------------3、查询视频广告列表（ajax 返回的list<map>  key-视频文件名，  value-视屏文件路径）----------------------------------------
    /**
     * 查询视频列表，然后在查音乐列表
     */
	function getVideoList(){
    	$.ajax({
	    	url: contextPath+"/businessconfig/takeconfig/getVideoList?dt="+(new Date().getTime()), 
	  		type : "get",
	  		dataType: "json",
	  		data:{},
	  		contentType: "application/json",
	  		success: function(data) {
	  			var tmpItem;
		        $.each(data, function (index, item)
		        {
		          tmpItem = {};
		          tmpItem.title = item.fileName;   //标题
		          tmpItem.m4v = $staticPath +"/static/lib2/media/video/"+item.fileName;  //m4v 路径  
		          tmpItem.ogv = $staticPath +"/static/lib2/media/video/"+item.fileName;  //ogv 路径
		          tmpItem.webmv = $staticPath +"/static/lib2/media/video/"+item.fileName;  // webmv 路径
		          videoList.push(tmpItem);   //加入到视频列表
		        });
		        
		        //查询音乐列表
	  			getMusicList();
	  		},
	  		error: function(msg) {
	  			alert("出错了！");
	  		}
	  	});
    }
	
	//---------------------------------4、查询音乐列表（ajax 返回的list<map>  key-音乐文件名，  value-音乐文件路径）----------------------------------------
    /**
     * 查询音乐列表，保存列表信息
     */
	function getMusicList(){
		$.ajax({
	    	url: contextPath+"/businessconfig/takeconfig/getMusicList?dt="+(new Date().getTime()), 
	  		type : "get",
	  		dataType: "json",
	  		data:{},
	  		contentType: "application/json",
	  		success: function(data) {
	  			var tmpItem;
		        $.each(data, function (index, item)
		        {
		        	tmpItem = {};
		            tmpItem.title = item.fileName;
		            tmpItem.mp3 = item.fullPath;
		            musicList.push(tmpItem);
		        });
		        
		        //查询背景图片
		        getBackgroundImgs();
	  		},
	  		error: function(msg) {
	  			alert("出错了！");
	  		}
	  	});
      }

	//---------------------------------5、查询背景图片（图片长，高，名，位置）----------------------------------------
    /**
     *  a-加载背景图片，初始化图片选择层
     *  b-绑定右侧属性事件
     *  c-调用initPage
     */
	function getBackgroundImgs(){
    	$.ajax({
	    	url: contextPath+"/businessconfig/takeconfig/getBackgroundImgs?dt="+(new Date().getTime()), 
	  		type : "get",
	  		dataType: "json",
	  		data:{},
	  		contentType: "application/json",
	  		success: function(data) {
	  		  //alert($.toJson(data))
	  		  backgroundImgList = data;

	  	      $myImagePicker = $("#myImagePicker");  //图片选择
	  	      $myImagePicker.empty().html("");
	  	      
	  	      //初始化图片list
	  	      $.each(backgroundImgList, function (index, item)
	  	      {
	  	        $("<option data-img-src='" + item.fullPath + "' value='" +  item.fullPath + "'>" + item.imgName + "</option>").data("data", item).appendTo($myImagePicker);
	  	      });
	  	      
	  	      //图片展示插件绑定
	  	      $("select.image-picker.show-labels").imagepicker({
	  	        hide_select: true,
	  	        show_label: true
	  	      });

	  	      $myTab = $("#myTab");  //tab标签，业务组织的层级
	  	      $myTabContent = $("#myTabContent");  //每个层级里面的内容
	  	      $x = $("#x");   
	  	      $y = $("#y");   
	  	      $backgroundColor = $("#backgroundColor");
	  	      $fontColor = $("#fontColor");
	  	      $width = $("#width");
	  	      $height = $("#height");
	  	      
	  	      
	  	      $('.close').click(function (e)
	  	      {
	  	        e.preventDefault();
	  	        $('#dragPanel').hide();
	  	      });
	  	      
	  	      //绑定小图标控件
	  	      $('#icon').iconpicker({
	  	        rows: 4,
	  	        cols: 4,
	  	        align: 'left'
	  	      });
	  	      
	  	      //小图标内容改变后，同步修改被选中元素
	  	      $('#icon').on('change', function (e)
	  	      {
	  	        if (!$selectedItem) return;
	  	        $('a > i', $selectedItem).attr('class', 'fa ' + e.icon);
	  	        $selectedItem.data("itemData").icon = e.icon;
	  	      });
	  	      
	  	      //形状选项被改变，设置被选中的形状值，normal-显示阴影   其他形状-隐藏阴影（不过形状无法选中）
	  	      $shape.on('change', function (e)
	  	      {
	  	        if (!$selectedItem) return;
	  	        $selectedItem.data("itemData").shape = $(this).val();
	  	        if ($(this).val() == "normal")
	  	        {
	  	          $shadow.parent().parent().parent().show();
	  	          if ($shadow.val() == "normal")
	  	          {
	  	            $shadowH.parent().parent().hide();
	  	          } else
	  	          {
	  	            $shadowH.parent().parent().show();
	  	          }
	  	        } else
	  	        {
	  	          $shadow.parent().parent().parent().hide();
	  	          $shadowH.parent().parent().hide();
	  	        }
	  	        initItemStyle($selectedItem);
	  	      });
	  	      
	  	      //阴影选项被改变，设置被选中的形状值，normal-隐藏阴影参数   shadow-显示阴影参数
	  	      $shadow.on('change', function (e)
	  	      {
	  	        if (!$selectedItem) return;
	  	        $selectedItem.data("itemData").shadow = $(this).val();
	  	        if ($(this).val() == "shadow")
	  	        {
	  	          $shadowH.parent().parent().show();
	  	        } else
	  	        {
	  	          $shadowH.parent().parent().hide();
	  	        }
	  	        initItemStyle($selectedItem);
	  	      });

	  	      $shadowH.on("change", function ()
	  	      {
	  	        if (!$selectedItem) return;
	  	        if (this.value)
	  	        {
	  	          if (!$.isNumeric(this.value))
	  	          {
	  	            $(this).val($selectedItem.data("itemData").shadowH);
	  	          } else
	  	          {
	  	            $(this).val(parseInt(this.value));
	  	            $selectedItem.data("itemData").shadowH = parseInt(this.value);
	  	            initItemStyle($selectedItem);
	  	          }
	  	        } else
	  	        {
	  	          $(this).val(0);
	  	          $selectedItem.data("itemData").shadowH = 0;
	  	          initItemStyle($selectedItem);
	  	        }

	  	      });

	  	      $shadowV.on("change", function ()
	  	      {
	  	        if (!$selectedItem) return;
	  	        if (this.value)
	  	        {
	  	          if (!$.isNumeric(this.value))
	  	          {
	  	            $(this).val($selectedItem.data("itemData").shadowV);
	  	          } else
	  	          {
	  	            $(this).val(parseInt(this.value));
	  	            $selectedItem.data("itemData").shadowV = parseInt(this.value);
	  	            initItemStyle($selectedItem);
	  	          }
	  	        } else
	  	        {
	  	          $(this).val(0);
	  	          $selectedItem.data("itemData").shadowV = 0;
	  	          initItemStyle($selectedItem);
	  	        }
	  	      });

	  	      $shadowBlur.on("change", function ()
	  	      {
	  	        if (!$selectedItem) return;
	  	        if (this.value)
	  	        {
	  	          if (!$.isNumeric(this.value))
	  	          {
	  	            $(this).val($selectedItem.data("itemData").shadowBlur);
	  	          } else
	  	          {
	  	            $(this).val(parseInt(this.value));
	  	            $selectedItem.data("itemData").shadowBlur = parseInt(this.value);
	  	            initItemStyle($selectedItem);
	  	          }
	  	        } else
	  	        {
	  	          $(this).val(0);
	  	          $selectedItem.data("itemData").shadowBlur = 0;
	  	          initItemStyle($selectedItem);
	  	        }
	  	      });
	  	      
	  	      //圆角选项被改变
	  	      $borderRadius.on('change', function (e)
	  	      {
	  	        if (!$selectedItem) return;
	  	        $selectedItem.data("itemData").borderRadius = $(this).val();
	  	        if ($(this).val() == "borderRadius")
	  	        {
	  	          $topLeft1.parent().parent().show();
	  	        } else
	  	        {
	  	          $topLeft1.parent().parent().hide();
	  	        }
	  	        initItemStyle($selectedItem);
	  	      });
	  	      $topLeft1.on("change", function ()
	  	      {
	  	        if (!$selectedItem) return;
	  	        if (!$.isNumeric(this.value))
	  	        {
	  	          $(this).val($selectedItem.data("itemData").topLeft1);
	  	        } else
	  	        {
	  	          $(this).val(parseInt(this.value) % 100);
	  	          $selectedItem.data("itemData").topLeft1 = parseInt(this.value) % 100;
	  	          initItemStyle($selectedItem);
	  	        }
	  	      });
	  	      $topLeft2.on("change", function ()
	  	      {
	  	        if (!$selectedItem) return;
	  	        if (!$.isNumeric(this.value))
	  	        {
	  	          $(this).val($selectedItem.data("itemData").topLeft2);
	  	        } else
	  	        {
	  	          $(this).val(parseInt(this.value) % 100);
	  	          $selectedItem.data("itemData").topLeft2 = parseInt(this.value) % 100;
	  	          initItemStyle($selectedItem);
	  	        }
	  	      });
	  	      $topRight1.on("change", function ()
	  	      {
	  	        if (!$selectedItem) return;
	  	        if (!$.isNumeric(this.value))
	  	        {
	  	          $(this).val($selectedItem.data("itemData").topRight1);
	  	        } else
	  	        {
	  	          $(this).val(parseInt(this.value) % 100);
	  	          $selectedItem.data("itemData").topRight1 = parseInt(this.value) % 100;
	  	          initItemStyle($selectedItem);
	  	        }
	  	      });
	  	      $topRight2.on("change", function ()
	  	      {
	  	        if (!$selectedItem) return;
	  	        if (!$.isNumeric(this.value))
	  	        {
	  	          $(this).val($selectedItem.data("itemData").topRight2);
	  	        } else
	  	        {
	  	          $(this).val(parseInt(this.value) % 100);
	  	          $selectedItem.data("itemData").topRight2 = parseInt(this.value) % 100;
	  	          initItemStyle($selectedItem);
	  	        }
	  	      });
	  	      $bottomRight1.on("change", function ()
	  	      {
	  	        if (!$selectedItem) return;
	  	        if (!$.isNumeric(this.value))
	  	        {
	  	          $(this).val($selectedItem.data("itemData").bottomRight1);
	  	        } else
	  	        {
	  	          $(this).val(parseInt(this.value) % 100);
	  	          $selectedItem.data("itemData").bottomRight1 = parseInt(this.value) % 100;
	  	          initItemStyle($selectedItem);
	  	        }
	  	      });
	  	      $bottomRight2.on("change", function ()
	  	      {
	  	        if (!$selectedItem) return;
	  	        if (!$.isNumeric(this.value))
	  	        {
	  	          $(this).val($selectedItem.data("itemData").bottomRight2);
	  	        } else
	  	        {
	  	          $(this).val(parseInt(this.value) % 100);
	  	          $selectedItem.data("itemData").bottomRight2 = parseInt(this.value) % 100;
	  	          initItemStyle($selectedItem);
	  	        }
	  	      });
	  	      $bottomLeft1.on("change", function ()
	  	      {
	  	        if (!$selectedItem) return;
	  	        if (!$.isNumeric(this.value))
	  	        {
	  	          $(this).val($selectedItem.data("itemData").bottomLeft1);
	  	        } else
	  	        {
	  	          $(this).val(parseInt(this.value) % 100);
	  	          $selectedItem.data("itemData").bottomLeft1 = parseInt(this.value) % 100;
	  	          initItemStyle($selectedItem);
	  	        }
	  	      });
	  	      $bottomLeft2.on("change", function ()
	  	      {
	  	        if (!$selectedItem) return;
	  	        if (!$.isNumeric(this.value))
	  	        {
	  	          $(this).val($selectedItem.data("itemData").bottomLeft2);
	  	        } else
	  	        {
	  	          $(this).val(parseInt(this.value) % 100);
	  	          $selectedItem.data("itemData").bottomLeft2 = parseInt(this.value) % 100;
	  	          initItemStyle($selectedItem);
	  	        }
	  	      });
	  	  
	  	      //倾斜选项被改变
	  	      $skew.on('change', function (e)
	  	      {
	  	        if (!$selectedItem) return;
	  	        $selectedItem.data("itemData").skew = $(this).val();
	  	        if ($(this).val() == "normal")
	  	        {
	  	          $skewH.parent().parent().hide();
	  	        } else
	  	        {
	  	          $skewH.parent().parent().show();
	  	        }
	  	        initItemStyle($selectedItem);
	  	      });

	  	      $skewH.on("change", function ()
	  	      {
	  	        if (!$selectedItem) return;
	  	        if (!$.isNumeric(this.value))
	  	        {
	  	          $(this).val($selectedItem.data("itemData").skewH);
	  	        } else
	  	        {
	  	          $(this).val(parseInt(this.value) % 360);
	  	          $selectedItem.data("itemData").skewH = parseInt(this.value) % 360;
	  	          initItemStyle($selectedItem);
	  	        }
	  	      });

	  	      $skewV.on("change", function ()
	  	      {
	  	        if (!$selectedItem) return;
	  	        if (!$.isNumeric(this.value))
	  	        {
	  	          $(this).val($selectedItem.data("itemData").skewV);
	  	        } else
	  	        {
	  	          $(this).val(parseInt(this.value) % 360);
	  	          $selectedItem.data("itemData").skewV = parseInt(this.value) % 360;
	  	          initItemStyle($selectedItem);
	  	        }
	  	      });
	  	  
	  	      //旋转选项被改变
	  	      $rotate.on('change', function (e)
	  	      {
	  	        if (!$selectedItem) return;
	  	        $selectedItem.data("itemData").rotate = $(this).val();
	  	        if ($(this).val() == "normal")
	  	        {
	  	          $angleOfRotationZ.parent().parent().hide();
	  	        } else
	  	        {
	  	          $angleOfRotationZ.parent().parent().show();
	  	        }
	  	        initItemStyle($selectedItem);
	  	      });

	  	      $angleOfRotationX.on("change", function ()
	  	      {
	  	        if (!$selectedItem) return;
	  	        if (!$.isNumeric(this.value))
	  	        {
	  	          $(this).val($selectedItem.data("itemData").angleOfRotationX);
	  	        } else
	  	        {
	  	          $(this).val(parseInt(this.value) % 360);
	  	          $selectedItem.data("itemData").angleOfRotationX = parseInt(this.value) % 360;
	  	          initItemStyle($selectedItem);
	  	        }
	  	      });

	  	      $angleOfRotationY.on("change", function ()
	  	      {
	  	        if (!$selectedItem) return;
	  	        if (!$.isNumeric(this.value))
	  	        {
	  	          $(this).val($selectedItem.data("itemData").angleOfRotationY);
	  	        } else
	  	        {
	  	          $(this).val(parseInt(this.value) % 360);
	  	          $selectedItem.data("itemData").angleOfRotationY = parseInt(this.value) % 360;
	  	          initItemStyle($selectedItem);
	  	        }
	  	      });

	  	      $angleOfRotationZ.on("change", function ()
	  	      {
	  	        if (!$selectedItem) return;
	  	        if (!$.isNumeric(this.value))
	  	        {
	  	          $(this).val($selectedItem.data("itemData").angleOfRotationZ);
	  	        } else
	  	        {
	  	          $(this).val(parseInt(this.value) % 360);
	  	          $selectedItem.data("itemData").angleOfRotationZ = parseInt(this.value) % 360;
	  	          initItemStyle($selectedItem);
	  	        }
	  	      });
	  	  
	  	      //特效选项被改变
	  	      $effect.on('change', function (e)
	  	      {
	  	        if (!$selectedItem) return;
	  	        $selectedItem.data("itemData").effect = $(this).val();
	  	        if ($(this).val() == "normal")
	  	        {
	  	          $scrollAmount.parent().parent().parent().hide();
	  	          $direction.parent().parent().parent().hide();
	  	        } else
	  	        {
	  	          if (!$scrollAmount.val())
	  	          {
	  	            chose_set_ini("#scrollAmount", "15");
	  	            $selectedItem.data("itemData").scrollAmount = "15";
	  	          }
	  	          if (!$direction.val())
	  	          {
	  	            chose_set_ini("#direction", "left");
	  	            $selectedItem.data("itemData").direction = "left";
	  	          }
	  	          $scrollAmount.parent().parent().parent().show();
	  	          $direction.parent().parent().parent().show();
	  	        }
	  	        initItemStyle($selectedItem);
	  	      });

	  	      $scrollAmount.on('change', function (e)
	  	      {
	  	        if (!$selectedItem) return;
	  	        $selectedItem.data("itemData").scrollAmount = $(this).val();
	  	        initItemStyle($selectedItem);
	  	      });

	  	      $direction.on('change', function (e)
	  	      {
	  	        if (!$selectedItem) return;
	  	        $selectedItem.data("itemData").direction = $(this).val();
	  	        initItemStyle($selectedItem);
	  	      });

	  	      //元素类型选项被改变
	  	      $("#ctrStyle").on("change", function ()
	  	      {
	  	        if (!$selectedItem) return;
	  	        //改变dataItem值
	  	        $selectedItem.data("itemData").type = this.value;
	  	        //改变左边的显示效果
	  	        initItemStyle($selectedItem);
	  	      });
	  	      
	  	      //文本内容选项被改变
	  	      $("#ctrText").on("change", function ()
	  	      {
	  	        if (!$selectedItem) return;
	  	    //add by tianjm 20181113 
	  	      var regEn = /[`#$^&()+<>"{},.\/;'[\]]/im,
		        regCn = /[·#‘[\]]/im;
		        if(regEn.test(this.value) || regCn.test(this.value)) {
		        	qmsVld.showError('文字内容不能包含特殊字符');
			        return;
		        }
	  	        //改变dataItem值
	  	        $selectedItem.data("itemData").text = this.value;
	  	        //改变左边的显示效果
	  	        initItemStyle($selectedItem);
	  	      });
	  	  
	  	      //字体选项被改变
	  	      $("#fontFamily").on("change", function ()
	  	      {
	  	        if (!$selectedItem) return;
	  	        //改变dataItem值
	  	        $selectedItem.data("itemData").family = this.value;
	  	        //改变左边的显示效果
	  	        initItemStyle($selectedItem);
	  	      });
	  	  
	  	      //字形内容选项被改变
	  	      $("#fontStyle").on("change", function ()
	  	      {
	  	        if (!$selectedItem) return;
	  	        //改变dataItem值
	  	        $selectedItem.data("itemData").style = this.value;
	  	        //改变左边的显示效果
	  	        initItemStyle($selectedItem);
	  	      });
	  	  
	  	      //字体大小选项被改变
	  	      $("#fontSize").on("change", function ()
	  	      {
	  	        if (!$selectedItem) return;

	  	        //改变dataItem值
	  	        $selectedItem.data("itemData").size = this.value;
	  	        //改变左边的显示效果
	  	        initItemStyle($selectedItem);
	  	      });
	  	      
	  	      //x选项被改变
	  	      $x.on("change", function ()
	  	      {
	  	        if (!$selectedItem) return;
	  	        if (!$.isNumeric(this.value))
	  	        {
	  	          $(this).val($selectedItem.data("itemData").x);
	  	        } else
	  	        {
	  	          $(this).val(parseInt(this.value));
	  	          //改变dataItem值
	  	          $selectedItem.data("itemData").x = parseInt(this.value);
	  	          $selectedItem.css("left", this.value + "px");
	  	          //改变左边的显示效果
	  	          initItemStyle($selectedItem);
	  	        }
	  	      });
	  	      //Y选项被改变
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
	  	  
	  	      //width选项被改变
	  	      $("#width").on("change", function ()
	  	      {
	  	        if (!$selectedItem) return;
	  	        if (!$.isNumeric(this.value))
	  	        {
	  	          $(this).val($selectedItem.data("itemData").width);
	  	        } else
	  	        {
	  	          $(this).val(parseInt(this.value));
	  	          //改变dataItem值
	  	          $selectedItem.data("itemData").width = parseInt(this.value);
	  	          $selectedItem.css("width", this.value + "px");
	  	          //改变左边的显示效果
	  	          initItemStyle($selectedItem);
	  	        }
	  	      });

	  	      //height选项被改变
	  	      $("#height").on("change", function ()
	  	      {
	  	        if (!$selectedItem) return;
	  	        if (!$.isNumeric(this.value))
	  	        {
	  	          $(this).val($selectedItem.data("itemData").height);
	  	        } else
	  	        {
	  	          $(this).val(parseInt(this.value));
	  	          //改变dataItem值
	  	          $selectedItem.data("itemData").height = parseInt(this.value);
	  	          $selectedItem.css("height", this.value + "px");
	  	          //改变左边的显示效果
	  	          initItemStyle($selectedItem);
	  	        }
	  	      });

	  	      //分辨率改变
	  	      $screenResolution.on("change", function ()
	  	      {
	  	        createPreviewHtml();
	  	      });

	  	      //切换日期类型
	  	      $dateTypeId.on("change", function ()
	  	      {
	  	        createPreviewHtml();
	  	      });
	  	      
	  	      //小图标位置（左，右按钮点击）
	  	      $('#btn-icon-positions button').on('click', function (e)
	  	      {
	  	        if (!$selectedItem) return;
	  	        var icon = $('a > i', $selectedItem);
	  	        var text = $('a > li', $selectedItem);
	  	        $('a', $selectedItem).empty();
	  	        if ($(this).val() == 'left')
	  	        {
	  	          $('a', $selectedItem).append(icon).append(text);
	  	        }
	  	        else
	  	        {
	  	          $('a', $selectedItem).append(text).append(icon);
	  	        }
	  	        $selectedItem.data("itemData").iconPosition = $(this).val();
	  	      });
	  		  
	  	      //是否静音
	  		  $("#isMute").on('click', function (e)
	  		  {
	  				if (!$selectedItem) return;
	  				if ($(this).attr("src").indexOf("jy.png") >= 0){
	  					$(this).attr("src", $staticPath +"/static/components/ticket/images/voice/yl.png");
	  					$selectedItem.data("itemData").isMute = false;
	  				} else{
	  					this.src = $staticPath +"/static/components/ticket/images/voice/jy.png";
	  					$(this).attr("src", $staticPath +"/static/components/ticket/images/voice/jy.png");
	  					$selectedItem.data("itemData").isMute = true;
	  				}
	  				initItemStyle($selectedItem);
	  		  });

	  		  //文字颜色旋转器
	  	      $("#fontColor").spectrum({
	  	        allowEmpty: true,
	  	        color: "",
	  	        showInput: true,
	  	        containerClassName: "full-spectrum",
	  	        showInitial: true,
	  	        showPalette: true,
	  	        showSelectionPalette: true,
	  	        showAlpha: true,
	  	        maxPaletteSize: 10,
	  	        preferredFormat: "hex",
	  	        localStorageKey: "spectrum.demo",
	  	        move: function (color)
	  	        {
	  	          updateFontColor(color);
	  	        },
	  	        show: function ()
	  	        {

	  	        },
	  	        beforeShow: function ()
	  	        {

	  	        },
	  	        hide: function (color)
	  	        {
	  	          updateFontColor(color);
	  	        },
	  	        palette: [
	  					["rgb(0, 0, 0)", "rgb(67, 67, 67)", "rgb(102, 102, 102)",
	  					"rgb(204, 204, 204)", "rgb(217, 217, 217)", "rgb(255, 255, 255)"],
	  					["rgb(152, 0, 0)", "rgb(255, 0, 0)", "rgb(255, 153, 0)", "rgb(255, 255, 0)", "rgb(0, 255, 0)",
	  					"rgb(0, 255, 255)", "rgb(74, 134, 232)", "rgb(0, 0, 255)", "rgb(153, 0, 255)", "rgb(255, 0, 255)"],
	  					["rgb(230, 184, 175)", "rgb(244, 204, 204)", "rgb(252, 229, 205)", "rgb(255, 242, 204)", "rgb(217, 234, 211)",
	  					"rgb(208, 224, 227)", "rgb(201, 218, 248)", "rgb(207, 226, 243)", "rgb(217, 210, 233)", "rgb(234, 209, 220)",
	  					"rgb(221, 126, 107)", "rgb(234, 153, 153)", "rgb(249, 203, 156)", "rgb(255, 229, 153)", "rgb(182, 215, 168)",
	  					"rgb(162, 196, 201)", "rgb(164, 194, 244)", "rgb(159, 197, 232)", "rgb(180, 167, 214)", "rgb(213, 166, 189)",
	  					"rgb(204, 65, 37)", "rgb(224, 102, 102)", "rgb(246, 178, 107)", "rgb(255, 217, 102)", "rgb(147, 196, 125)",
	  					"rgb(118, 165, 175)", "rgb(109, 158, 235)", "rgb(111, 168, 220)", "rgb(142, 124, 195)", "rgb(194, 123, 160)",
	  					"rgb(166, 28, 0)", "rgb(204, 0, 0)", "rgb(230, 145, 56)", "rgb(241, 194, 50)", "rgb(106, 168, 79)",
	  					"rgb(69, 129, 142)", "rgb(60, 120, 216)", "rgb(61, 133, 198)", "rgb(103, 78, 167)", "rgb(166, 77, 121)",
	  					"rgb(91, 15, 0)", "rgb(102, 0, 0)", "rgb(120, 63, 4)", "rgb(127, 96, 0)", "rgb(39, 78, 19)",
	  					"rgb(12, 52, 61)", "rgb(28, 69, 135)", "rgb(7, 55, 99)", "rgb(32, 18, 77)", "rgb(76, 17, 48)"]
	  				]
	  	      });

	  	      //背景颜色旋转器
	  	      $("#backgroundColor").spectrum({
	  	        allowEmpty: true,
	  	        color: "",
	  	        showInput: true,
	  	        containerClassName: "full-spectrum",
	  	        showInitial: true,
	  	        showPalette: true,
	  	        showSelectionPalette: true,
	  	        showAlpha: true,
	  	        maxPaletteSize: 10,
	  	        preferredFormat: "hex",
	  	        localStorageKey: "spectrum.demo",
	  	        move: function (color)
	  	        {
	  	          updateBackground(color);
	  	        },
	  	        show: function ()
	  	        {

	  	        },
	  	        beforeShow: function ()
	  	        {

	  	        },
	  	        hide: function (color)
	  	        {
	  	          updateBackground(color);
	  	        },

	  	        palette: [
	  					["rgb(0, 0, 0)", "rgb(67, 67, 67)", "rgb(102, 102, 102)",
	  					"rgb(204, 204, 204)", "rgb(217, 217, 217)", "rgb(255, 255, 255)"],
	  					["rgb(152, 0, 0)", "rgb(255, 0, 0)", "rgb(255, 153, 0)", "rgb(255, 255, 0)", "rgb(0, 255, 0)",
	  					"rgb(0, 255, 255)", "rgb(74, 134, 232)", "rgb(0, 0, 255)", "rgb(153, 0, 255)", "rgb(255, 0, 255)"],
	  					["rgb(230, 184, 175)", "rgb(244, 204, 204)", "rgb(252, 229, 205)", "rgb(255, 242, 204)", "rgb(217, 234, 211)",
	  					"rgb(208, 224, 227)", "rgb(201, 218, 248)", "rgb(207, 226, 243)", "rgb(217, 210, 233)", "rgb(234, 209, 220)",
	  					"rgb(221, 126, 107)", "rgb(234, 153, 153)", "rgb(249, 203, 156)", "rgb(255, 229, 153)", "rgb(182, 215, 168)",
	  					"rgb(162, 196, 201)", "rgb(164, 194, 244)", "rgb(159, 197, 232)", "rgb(180, 167, 214)", "rgb(213, 166, 189)",
	  					"rgb(204, 65, 37)", "rgb(224, 102, 102)", "rgb(246, 178, 107)", "rgb(255, 217, 102)", "rgb(147, 196, 125)",
	  					"rgb(118, 165, 175)", "rgb(109, 158, 235)", "rgb(111, 168, 220)", "rgb(142, 124, 195)", "rgb(194, 123, 160)",
	  					"rgb(166, 28, 0)", "rgb(204, 0, 0)", "rgb(230, 145, 56)", "rgb(241, 194, 50)", "rgb(106, 168, 79)",
	  					"rgb(69, 129, 142)", "rgb(60, 120, 216)", "rgb(61, 133, 198)", "rgb(103, 78, 167)", "rgb(166, 77, 121)",
	  					"rgb(91, 15, 0)", "rgb(102, 0, 0)", "rgb(120, 63, 4)", "rgb(127, 96, 0)", "rgb(39, 78, 19)",
	  					"rgb(12, 52, 61)", "rgb(28, 69, 135)", "rgb(7, 55, 99)", "rgb(32, 18, 77)", "rgb(76, 17, 48)"]
	  				]
	  	      });
	  	      //初始换页面
	  	      setTimeout(initPage, 0);
	  		},
	  		error: function(msg) {
	  			alert("出错了！");
	  		}
	  	});
    }	
	
	function updateChildrenPageColor(color, obj)
    {
      if (color)
      {
        //改变背景图片
        var objId = (obj.id).replace("childrenPageColor", "")
        $("#buzType" + objId).data("backgroundColor", color.toRgbString());
        $("#buzType" + objId).css("backgroundColor", color.toRgbString());
        $("#buzType" + objId).data("backgroundImage", "");
        $("#buzType" + objId).css("backgroundImage", "");
        $("#childrenPageImg" + objId).attr("src", "");
      }
    }

    function updateBackground(color)
    {
      if (!$selectedItem) return;
      //改变dataItem值
      if (color)
      {
        $selectedItem.data("itemData").backgroundColor = color.toRgbString();
        delete $selectedItem.data("itemData").backgroundImage;
        //改变左边的显示效果
        initItemStyle($selectedItem);
        $("#backgroundImage").attr("src", "");
      }
    }

    function updateFontColor(color)
    {
      if (!$selectedItem) return;
      //改变dataItem值
      if (color)
      {
        $selectedItem.data("itemData").fontColor = color.toRgbString();
        //改变左边的显示效果
        initItemStyle($selectedItem);
      }
    }
    
    //打开背景图片模态框
    function showModal(obj)
    {
      $myModal.data("itemData", obj);
      $myModal.modal('show');
    }

    //确定选择图片改变一样式
    function modelSubmit(){
      $myModal.modal('hide');
      var obj = $myModal.data("itemData");
      $("#" + obj.id).attr("src", $myImagePicker.val());
      var objId = (obj.id).replace("childrenPageImg", "");
      if (obj.name == "childrenPageImg"){
        //改变背景图片
        $("#buzType" + objId).data("backgroundImage", $myImagePicker.val());
        $("#buzType" + objId).data("backgroundColor", "");
        $("#buzType" + objId).css("backgroundImage", "url(" + $myImagePicker.val() + ")");
        $("#buzType" + objId).css("backgroundColor", "");
        $("#childrenPageColor" + objId).spectrum("set", null);
      } else{
        if (!$selectedItem) return;
        //改变dataItem值
        $selectedItem.data("itemData").backgroundImage = $myImagePicker.val();
        delete $selectedItem.data("itemData").backgroundColor;
        //改变左边的显示效果
        initItemStyle($selectedItem);
        initRightData($selectedItem);
      }
   }

  //---------------------------------6、执行initPage方法----------------------------------------
    /**
     * 初始化界面()
     * 1、查询字典数据中，左侧能够拖拽的元素
     * 2、
     */
    function initPage(){
      //----------------------------------------------------左边初始化 start--------------------------------------------
      $ctrList.html("");
      //查询左侧能够拖拽的元素
      $.ajax({
	    	url: contextPath+"/basicconfig/sysdic/takeElement?dt="+(new Date().getTime()), 
	  		type : "get",
	  		dataType: "json",
	  		//async : false,
	  		data:{},
	  		contentType: "application/json",
	  		success: function(data) {
	  			  //alert($.toJSON(data))
	  			  var queueCtrls = null;
		  	      var widthStr = "";
		  	      //配置文件中的分辨率（需要改成从设备中去取）
//		  	      alert("设备的分辨率："+screenResolution);
		  	      var xWidth = (screenResolution).split("x")[0];
		  	      if (xWidth <= 768)
		  	      {
		  	        widthStr = "width:130px;";
		  	      }else{
		  	    	widthStr = "width:110px;";
		  	      }
		  	        queueCtrls = data.rows;
		  	        //右边属性列表元素类型
		  	        if (queueCtrls) chose_ini("#ctrStyle", queueCtrls, null);
		  	        var $li = null;
		  	        //左侧元素列表
		  	        $.each(queueCtrls, function (index, item)
		  	        {
		  	          if (item.key != "buzType")
		  	          {
		  	            $li = $("<li id='" + item.key + "' style='" + widthStr + "display:inline-block;'><a class='ajax-link' href='javascript:void(0);'><i class='glyphicon glyphicon-font'></i><span>" + item.value + "</span></a></li>");
		  				$li.data("itemData",item);
		  				$li.appendTo($ctrList);
		  	          }
		  	        });
		  	      //console.info("添加玩左侧元素后的数量："+$("#ctrList li").length);
		  	      
		  	      //鼠标按下，鼠标变移动标志，克隆元素，并确定新克隆元素位置
		  	      //以及根据不同类型，确定不同的右边属性
		  	      //console.info("左侧元素数量："+$("#ctrList li").length);
		  	      $("#ctrList li").mousedown(function (e)
		  	      {
		  			  var $span = $("<div style='list-style:none;position:absolute;'>&nbsp;</div>");

		  			  $span.addClass("clone").appendTo($("body"));
		  			  $("body").css('cursor', 'move');
		  			  $span.css('left', e.clientX + 1);
		  			  $span.css('top', e.clientY + 1);
		  			  var data = $(this).data("itemData");
		  			  
		  			  //console.info("克隆元素的位置left："+$span.css("left")+" top:"+$span.css("top"));
		  			  
		  			  var itemData = {};
		  			  if ($(this).text())
		  			  {
		  				  itemData.type = data.key;
		  				  itemData.orgType = data.type;
		  				  if (itemData.type == "textAdv" || itemData.type == "systemTime")
		  				  {
		  					itemData.effect = "normal";
		  				  }

		  				  if (itemData.type == "lobbyManager" || itemData.type == "coupon" || itemData.type=="validate")
		  				  {
		  					  itemData.width = 100;
		  					  itemData.height = 50;
		  				  } else if (itemData.type == "picAdv")
		  				  {
		  					  itemData.width = 256;
		  					  itemData.height = 144;
		  				  } else if (itemData.type == "videoAdv")
		  				  {
		  					  itemData.width = 256;
		  					  itemData.height = 144;
		  					  itemData.volume = volume;
		  					  itemData.isMute = false;
		  				  }  else if (itemData.type == "music")
		  				  {
		  					  itemData.width = 50;
		  					  itemData.height = 50;
		  					  itemData.volume = volume;
		  					  itemData.isMute = false;
		  				  } else
		  				  {
		  					  itemData.width = 300;
		  					  itemData.height = 50;
		  				  }
		  				  itemData.family = "Microsoft YaHei";
		  				  itemData.style = "normal";
		  				  itemData.size = "16";
		  				  itemData.backgroundColor = "#b6d7a8";
		  				  itemData.fontColor = "#FFFFFF";
		  				  if (itemData.type == "systemTime")
		  				  {
		  					itemData.text = "2015年01月01日 12:12:12 星期三";
		  				  } else
		  				  {
		  					itemData.text = $(this).text();
		  				  }
		  			  }
		  			  $span.data("itemData", itemData);

		  	      });
		  	      
	  		},
	  		error: function(msg) {
	  			alert("出错了！");
	  		}
	  	  });
	  	  
	  //查询所有的分辨率，并加载
	 /* var arg ={};
      arg.type = 6;*/
	  $.ajax({
	    	url: contextPath+"/basicconfig/sysdic/screenResolution?dt="+(new Date().getTime()), 
	  		type : "get",
	  		dataType: "json",
	  		//data: $.toJSON(arg),
	  		async : false,
	  		contentType: "application/json",
	  		success: function(data) {
	  			  //alert($.toJSON(data))
	  			var screenResolutionSettings = data.rows;
	  			//初始化分辨率下拉框，并设置默认值
	  			if (screenResolutionSettings){
	  				chose_ini("#screenResolution", screenResolutionSettings, screenResolution); 
	  			}
	  		},
	  		error: function(msg) {
	  			alert("出错了！");
	  		}
	  	  });	 
     
	  //----------------------------------------------------左边初始化 end--------------------------------------------
	  	  
	  //----------------------------------------------------中间初始化 start------------------------------------------ 
      $offsetX = $("#offsetX");
      $offsetY = $("#offsetY");
      createPreviewHtml();
      //----------------------------------------------------中间初始化 end--------------------------------------------

      

      $(document).mousemove(function (e){
		  if ($(".clone").length > 0){
			  $(".clone").css('left', e.clientX + 1);
			  $(".clone").css('top', e.clientY + 1);
		  }
      });

      $(document).mouseup(function (e)
      {
		  $(".clone").remove();
		  $("body").css('cursor', 'auto');
      });


      $("#backgroundImage").click(function (e)
      {
        e.preventDefault();
        showModal(this);
      });


      //closeLoading();
      

    }
    
    /**
     * select 元素初始化公用方法
     * @param select
     * @param jsonObj
     * @param iniValue
     */
    function chose_ini(select, jsonObj, iniValue)
    {
      $.each(jsonObj, function (index, item)
      {
        $(select).append("<option value='" + item.key + "'  style='font-family:SimHei;'>" + item.value + "</option>");
      });

      if (iniValue) $(select).val(iniValue);//设置默认分辨率
      $(select).trigger("chosen:updated");
    }

    
    /**
     * 初始化多选
     * @param select
     * @param jsonObj
     * @param iniValues
     */
    function chose_mult_ini(select, jsonObj, iniValues)
    {

    }

    /**
     * select元素设置值
     * @param select
     * @param value
     */
    function chose_set_ini(select, value)
    {
      $(select).val(value);
      $(select).trigger("chosen:updated");
    }

    /**
     * 多选select元素设置值
     * @param select
     * @param values
     */
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

    /**
     * 取号界面元素删除，同时更新元素样式
     * @param obj
     */
    function closeSpan(obj)
    {
      var $spn = $(obj).parent();
	  //动态改变控件的显示隐藏
	  updateQueueCtrlStyle($spn.data("itemData"),"del");
	  $spn.remove();
    }
	
    /**
     * 设置元素的显示的z-index的值，根据元素的orgType值进行确定
     * @param obj
     */
	function setIndex(obj){
		var itemData = $(obj).data("itemData");
		var orgType = itemData.orgType? itemData.orgType:2;
		if(orgType==1){
			$(obj).css("z-index", 10);
		}else if(orgType == 2){
			if(itemData.type=="buzType"){
				$(obj).css("z-index", 1);
			}else{
				$(obj).css("z-index", 5);
			}
		}
	}

	/**
	 * 初始化取号界面各类型元素样式
	 * @param obj
	 */
    function initItemStyle(obj){
      var item = $(obj).data("itemData");
      var $spn = $(obj);
      var shape = "normal";
      if (item.shape)
      {
        shape = item.shape;
      }

      if (item.type == "textAdv" || item.type == "systemTime")
      {
        if (item.effect == "marquee")
        {
          $spn.empty().html('<label style="display:table-cell;vertical-align:middle; background-size:100% 100%;left:0px;top:0px;width:100%;height:100%;"><marquee width=100% height=100% scrollAmount=' + item.scrollAmount + '  scrollDelay=200 behavior="scroll" direction="' + item.direction + '" >' + item.text + '</marquee></label><button class = "close" ondblclick = "closeSpan(this)" type="button" data-dismiss="modal"></button>');
        } else
        {
          $spn.empty().html('<label style="display:table-cell;vertical-align:middle; background-size:100% 100%;left:0px;top:0px;width:100%;height:100%;">' + item.text + '</label><button class = "close" ondblclick = "closeSpan(this)" type="button" data-dismiss="modal"></button>');
        }
		setIndex($spn.get(0));

      } else if (item.type == "message" ||  item.type == "MessRemind" || item.type == 'nearbyNet')
      {
        $spn.empty().html('<label  style="display:table-cell;vertical-align:middle; background-size:100% 100%;left:0px;top:0px;width:100%;height:100%;">' + item.text + '</label><button class = "close" ondblclick = "closeSpan(this)" type="button" data-dismiss="modal"></button>');
        setIndex($spn.get(0));
      } else if (item.type == "OrderRange" ){
    	$spn.empty().html('<label  style="display:table-cell;vertical-align:middle; background-size:100% 100%;left:0px;top:0px;width:100%;height:100%;">' + item.text + '</label><button class = "close" ondblclick = "closeSpan(this)" type="button" data-dismiss="modal"></button>');
        setIndex($spn.get(0)); 
      } 
      else if (item.type == "lobbyManager")
      {
        $spn.empty().html('<label  style="cursor:pointer;display:table-cell;vertical-align:middle; background-size:100% 100%;left:0px;top:0px;width:100%;height:100%;">' + item.text + '</label><button class = "close" ondblclick = "closeSpan(this)" type="button" data-dismiss="modal"></button>');
        setIndex($spn.get(0));
      } else if (item.type == "coupon")
      {//优惠券
        $spn.empty().html('<a href="javascript:void(0);"><li style="display:inline-block;vertical-align: middle;">' + item.text + '</li></a><button class = "close" ondblclick = "closeSpan(this)" type="button" data-dismiss="modal"></button>');
		setIndex($spn.get(0));
	  }else if (item.type == "validate")
      {//输入验证
        $spn.empty().html('<a href="javascript:void(0);"><li style="display:inline-block;vertical-align: middle;">' + item.text + '</li></a><button class = "close" ondblclick = "closeSpan(this)" type="button" data-dismiss="modal"></button>');
		setIndex($spn.get(0));
	  }else if (item.type == "picAdv")//图片广告
      {
        $spn.empty().html('<label  style="display:table-cell;vertical-align:middle; background-size:100% 100%;left:0px;top:0px;width:100%;height:100%;">' + item.text + '</label><button class = "close" ondblclick = "closeSpan(this)" type="button" data-dismiss="modal"></button>');
        setIndex($spn.get(0));

        if ($ads && $ads.length > 0)
        {
          var $advContent = $spn.find("label");
          var html = "";
          $.each($ads, function (index, img)
          {
            html += "<img id='" + img.id + "' src='"+ $staticPath +"/static/components/ticket/images/advs/" + img.id +"_" + img.name  +"_" + img.timeout  +"_" + img.ext + "' style='width:" + item.width + "px;height:" + item.height + "px' />";
          });
          $advContent.empty().html(html);
          $advContent.cycle(
				{
				  fx: "fade,wipe,uncover",
				  timeout: 3000,
				  /*timeoutFn: function calculateTimeout(currElement, nextElement, opts, isForward)
				  {
				    var i = parseInt(currElement.id.replace("pict", ""), 10) - 1;
				    return $ads[i].timeout;
				  }*/
				});
        }

      } else if (item.type == "videoAdv")//视频广告
      {
			setIndex($spn.get(0));
			if(!item.volume) item.volume = volume;
			if(!item.isMute) item.isMute = (isMute == 'true'? true:false);
			if($spn.find(".jp-jplayer").length>0){
				var $jp = $spn.find(".jp-jplayer").eq(0);
				var $jpList = $spn.find(".jp-video").eq(0);
				if(item.isMute){
					$jp.jPlayer('mute');  
				}else{
					$jp.jPlayer('unmute');  
				}
				$jp.jPlayer('volume',item.volume/100);  
				$jpList.css({"width":item.width,"height":item.height});
			}else{
				//视频广告	
				jplayerIndex++;
				var videoAdvHTML = '<div id="jp_container_' + jplayerIndex + '" class="jp-video" style="width:' + item.width + 'px;border:0;" role="application" aria-label="media player">'
						+ '<div class="jp-type-playlist">'
							+ '<div id="jquery_jplayer_' + jplayerIndex + '" class="jp-jplayer"></div>'
							+ '<div class="jp-playlist" style="display:none;"><ul><li>&nbsp;</li></ul></div>'
							+ '<div class="jp-no-solution"><span>Update Required</span>To play the media you will need to either update your browser to a recent version or update your <a href="http://get.adobe.com/flashplayer/" target="_blank">Flash plugin</a>.</div>'
						+ '</div>'
					+ '</div><button class = "close" ondblclick = "closeSpan(this)" type="button" data-dismiss="modal"></button>';
				$spn.empty().html(videoAdvHTML);
				new jPlayerPlaylist({
				  jPlayer: "#jquery_jplayer_" + jplayerIndex,
				  cssSelectorAncestor: "#jp_container_" + jplayerIndex
				}, videoList, {
				  ready: function () { $(this).jPlayer("play").jPlayer("repeat"); },
				  //playlistOptions: {    autoPlay: true,    enableRemoveControls: true  },
				  size: {
					width: "100%",
					height: "100%"
				  },
				  swfPath:  $staticPath +"/static/components/ticket/js",
				  volume: item.volume/100, 
				  muted: item.isMute,
				  supplied: "webmv, ogv, m4v",
				  useStateClassSkin: true,
				  autoBlur: false,
				  smoothPlayBar: true,
				  keyEnabled: true
				});
			}
		
      }else if (item.type == "music"){//音乐	
			setIndex($spn.get(0));
			if(!item.volume) item.volume = volume;
			if(!item.isMute) item.isMute = (isMute == 'true'? true:false);
			if($spn.find(".jp-jplayer").length>0){
				var $jp = $spn.find(".jp-jplayer").eq(0);
				var $jpList = $spn.find(".jp-video").eq(0);
				if(item.isMute){
					$jp.jPlayer('mute');  
				}else{
					$jp.jPlayer('unmute');  
				}
				$jp.jPlayer('volume',item.volume/100);  
				$jpList.css({"width":item.width,"height":item.height});
			}else{
				jplayerIndex++;
				var videoAdvHTML = '<div id="jp_container_' + jplayerIndex + '" class="jp-video" style="width:' + item.width + 'px;border:0;" role="application" aria-label="media player">'
						+ '<div class="jp-type-playlist">'
							+ '<div id="jquery_jplayer_' + jplayerIndex + '" class="jp-jplayer"></div>'
							+ '<div class="jp-playlist" style="display:none;"><ul><li>&nbsp;</li></ul></div>'
							+ '<div class="jp-no-solution"><span>Update Required</span>To play the media you will need to either update your browser to a recent version or update your <a href="http://get.adobe.com/flashplayer/" target="_blank">Flash plugin</a>.</div>'
						+ '</div>'
					+ '</div><button class = "close" ondblclick = "closeSpan(this)" type="button" data-dismiss="modal"></button>';
				$spn.empty().html(videoAdvHTML);
				new jPlayerPlaylist({
				  jPlayer: "#jquery_jplayer_" + jplayerIndex,
				  cssSelectorAncestor: "#jp_container_" + jplayerIndex
				}, musicList, {
				  ready: function () { $(this).jPlayer("play").jPlayer("repeat"); },
				  //playlistOptions: {    autoPlay: true,    enableRemoveControls: true  },
				  size: {
					width: "100%",
					height: "100%"
				  },
				  swfPath: $staticPath +"/static/components/ticket/js",
				  supplied: "mp3",
				  volume: item.volume/100, 
				  muted: item.isMute,
				  useStateClassSkin: true,
				  autoBlur: false,
				  smoothPlayBar: true,
				  keyEnabled: true
				});
			}	

      } 
	  
      var $label = $spn.find("a");
      if ($label.length <= 0)
      {
        $label = $spn.find("label");
      }
      //transform: skew(30deg, 30deg);
      var transform = "skew(0deg,0deg)";
      if (item.skew && item.skew == "skew")
      {
        var skewH = item.skewH ? item.skewH : 0;
        var skewV = item.skewV ? item.skewV : 0;
        transform = "skew(" + skewH + "deg," + skewV + "deg)";
      }

      if (item.shadow && item.shadow == "shadow")
      {
        $spn.css("box-shadow", item.shadowH + "px " + item.shadowV + "px " + item.shadowBlur + "px #333");
      } else
      {
        $spn.css("box-shadow", "none");
      }

      if (item.borderRadius && item.borderRadius == "borderRadius")
      {
        var topLeft1 = item.topLeft1 ? item.topLeft1 : 0;
        var topRight1 = item.topRight1 ? item.topRight1 : 0;
        var bottomRight1 = item.bottomRight1 ? item.bottomRight1 : 0;
        var bottomLeft1 = item.bottomLeft1 ? item.bottomLeft1 : 0;

        var topLeft2 = item.topLeft2 ? item.topLeft2 : 0;
        var topRight2 = item.topRight2 ? item.topRight2 : 0;
        var bottomRight2 = item.bottomRight2 ? item.bottomRight2 : 0;
        var bottomLeft2 = item.bottomLeft2 ? item.bottomLeft2 : 0;

        $spn.css("border-radius", topLeft1 + "% " + topRight1 + "%  " + bottomRight1 + "% " + bottomLeft1 + "%  / " + topLeft2 + "% " + topRight2 + "%  " + bottomRight2 + "% " + bottomLeft2 + "%");
      } else
      {
        $spn.css("border-radius", "0% 0%  0% 0%  / 0% 0%  0% 0%");
      }


      var labelFlag = false;
      if (item.type == "buzType" || item.type == "lobbyManager")
      {
        labelFlag = true;
      }
      if (item.rotate && item.rotate == "rotate")
      {
        var angleOfRotationX = item.angleOfRotationX ? item.angleOfRotationX : 0;
        var angleOfRotationY = item.angleOfRotationY ? item.angleOfRotationY : 0;
        var angleOfRotationZ = item.angleOfRotationZ ? item.angleOfRotationZ : 0;
        transform += " rotateX(" + angleOfRotationX + "deg)";
        transform += " rotateY(" + angleOfRotationY + "deg)";
        transform += " rotateZ(" + angleOfRotationZ + "deg)";
        $spn.css("transform-origin", "50% 50%");
        if (labelFlag) $label.css("transform", "rotateZ(" + (0 - item.angleOfRotationZ) + "deg)");
        if (labelFlag) $label.css("transform-origin", "50% 50%");

      } else
      {
        transform += " rotateZ(0deg)";
        if (labelFlag) $label.css("transform", "rotateZ(0deg)");
      }
      $spn.css("transform", transform);

      if (item.family)
      {
        $spn.css("font-family", item.family);
      }
      if (item.style)
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

      if (item.size)
      {
        $label.css("font-size", item.size + "px");
        if(item.size<12){
        	var size = item.size/12;
        	size = toDecimal(size);
        	$label.css("-webkit-transform", "scale("+size+")");
        }
      }

      if (item.width)
      {
        $spn.css("width", item.width + "px");
      }

      if (item.height)
      {
        $spn.css("height", item.height + "px");
      }

      if (item.x)
      {
        $spn.css("left", item.x + "px");
      }

      if (item.y)
      {
        $spn.css("top", item.y + "px");
      }

      //alert(item.backgroundColor+"  ==== "+item.backgroundImage);
      if (item.backgroundColor)
      {
        $spn.css("backgroundColor", item.backgroundColor);
      } else
      {
        $spn.css("backgroundColor", "");
      }

      if (item.fontColor)
      {
        $label.css("color", item.fontColor);
      }

      if (item.backgroundImage)
      {
        $spn.css("backgroundImage", "url(" + item.backgroundImage + ")");
      } else
      {
        $spn.css("backgroundImage", "");
      }

      if (item.type == "buzType" || item.type=="validate")
      {
        var $icon = $label.find("i");
        if (item.icon && item.icon != "empty")
        {
          $icon.attr("class", "").addClass("fa " + item.icon);
        } else
        {
          $icon.attr("class", "").addClass("fa ");
        }
        if (item.iconPosition == "right")
        {
          var icon = $('a > i', $(obj));
          var text = $('a > li', $(obj));
          $('a', $(obj)).empty();
          $('a', $(obj)).append(text).append(icon);
        }
      }

      $spn.css("overflow", "hidden");
    }
	/**
	 * 保留两位小数
	 * @param x
	 * @returns
	 */
    function toDecimal(x) {
    	var f = parseFloat(x);      
    	if (isNaN(f)) {   
    	 return false;     
    	}          
    	var f = Math.round(x*100)/100;  
    	var s = f.toString();       
    	var rs = s.indexOf('.');      
    	if (rs < 0) {   
    	 rs = s.length;      
    	 s += '.';   
    	            }       
    	while (s.length <= rs + 1) {   
    	 s += '0';       
    	}            
    	return s;   
    	}
    
    /**
     * 1、界面模拟区域：创建取号界面预览图(查询业务数据)
     */
    function createPreviewHtml(){
        $myTab.html("");
        $myTabContent.html("");
        
        var args = {};
        args.deviceNo = deviceNo;
        
        //查询出业务树
        $.ajax({
  	    	url: contextPath+"/businessconfig/takeconfig/bustree?dt="+(new Date().getTime()), 
  	  		type : "post",
  	  		dataType: "json",
  	  		data:$.toJSON(args),
  	  		contentType: "application/json",
  	  		success: function(data) {
  	  			//alert($.toJSON(data))
  	  			getBuzTypesForTreeByDateTypeId(data);
  	  		},
  	  		error: function(msg) {
  	  			alert("出错了！");
  	  		}
  	  	  });
    }
    
    /**
     * 2、界面模拟区域：根据机构编码，设备编号，日期类型，分辨率查询这个网点的取号界面配置
     * @param rlt
     */
    function getBuzTypesForTreeByDateTypeId(rlt){
      //全部初始化好
      if (rlt.length > 0){
        bizDatas = rlt[0];
        if (bizDatas.state == "closed"){
          var args = {};
          args.styleId = styleId;
          //20171008 by hongxz 使用设备的分辨率
          args.screenResolution = screenResolution;
          args.dateTypeId = $dateTypeId.val();
          args.stylePath = "1";
          args.orgId = orgId;
          args.deviceNo = deviceNo;
          
          $.ajax({
    	    	url: contextPath+"/businessconfig/takeconfig/getStyle?dt="+(new Date().getTime()), 
    	  		type : "post",
    	  		dataType: "json",
    	  		async : false,
    	  		data:$.toJSON(args),
    	  		contentType: "application/json",
    	  		success: function(data) {
    	  			//alert($.toJSON(data))
		  		      var styleData;
		  		      //获取界面元素
		  		      styleData = data.queueTemplate.print;
		  		      //加载是否平日假日相同
		  		      data.queueTemplate.copyStatus?$copyStatus.prop("checked",true):$copyStatus.prop("checked",false);
		  		      //设置日期类型
		  		      //chose_set_ini("#dateTypeId",data.queueTemplate.dateTypeId);
		  			  addSingleLevelBuz(bizDatas, styleData);
		  		      
		  			  $(".site").each(function (index, item){
		  				updateQueueCtrlStyle($(item).data("itemData"),"add");//动态改变控件的显示隐藏
		  		      });
    	  		},
    	  		error: function(msg) {
    	  			alert("出错了！");
    	  		}
    	  });
        }
      }
      
      $("img[name='childrenPageImg']").click(function (e){
	        e.preventDefault();
	        showModal(this);
	      });
	      //jQuery颜色选择器spectrum
	      $("input[name='childrenPageColor']").spectrum({
	        allowEmpty: true,
	        color: "",
	        showInput: true,
	        containerClassName: "full-spectrum",
	        showInitial: true,
	        showPalette: true,
	        showSelectionPalette: true,
	        showAlpha: true,
	        maxPaletteSize: 10,
	        preferredFormat: "hex",
	        localStorageKey: "spectrum.demo",
	        move: function (color)
	        {
	          updateChildrenPageColor(color, this);
	        },
	        show: function ()
	        {

	        },
	        beforeShow: function ()
	        {

	        },
	        hide: function (color)
	        {
	          updateChildrenPageColor(color, this);
	        },

	        palette: [
					["rgb(0, 0, 0)", "rgb(67, 67, 67)", "rgb(102, 102, 102)", 
					"rgb(204, 204, 204)", "rgb(217, 217, 217)", "rgb(255, 255, 255)"],
					["rgb(152, 0, 0)", "rgb(255, 0, 0)", "rgb(255, 153, 0)", "rgb(255, 255, 0)", "rgb(0, 255, 0)",
					"rgb(0, 255, 255)", "rgb(74, 134, 232)", "rgb(0, 0, 255)", "rgb(153, 0, 255)", "rgb(255, 0, 255)"],
					["rgb(230, 184, 175)", "rgb(244, 204, 204)", "rgb(252, 229, 205)", "rgb(255, 242, 204)", "rgb(217, 234, 211)",
					"rgb(208, 224, 227)", "rgb(201, 218, 248)", "rgb(207, 226, 243)", "rgb(217, 210, 233)", "rgb(234, 209, 220)",
					"rgb(221, 126, 107)", "rgb(234, 153, 153)", "rgb(249, 203, 156)", "rgb(255, 229, 153)", "rgb(182, 215, 168)",
					"rgb(162, 196, 201)", "rgb(164, 194, 244)", "rgb(159, 197, 232)", "rgb(180, 167, 214)", "rgb(213, 166, 189)",
					"rgb(204, 65, 37)", "rgb(224, 102, 102)", "rgb(246, 178, 107)", "rgb(255, 217, 102)", "rgb(147, 196, 125)",
					"rgb(118, 165, 175)", "rgb(109, 158, 235)", "rgb(111, 168, 220)", "rgb(142, 124, 195)", "rgb(194, 123, 160)",
					"rgb(166, 28, 0)", "rgb(204, 0, 0)", "rgb(230, 145, 56)", "rgb(241, 194, 50)", "rgb(106, 168, 79)",
					"rgb(69, 129, 142)", "rgb(60, 120, 216)", "rgb(61, 133, 198)", "rgb(103, 78, 167)", "rgb(166, 77, 121)",
					"rgb(91, 15, 0)", "rgb(102, 0, 0)", "rgb(120, 63, 4)", "rgb(127, 96, 0)", "rgb(39, 78, 19)",
					"rgb(12, 52, 61)", "rgb(28, 69, 135)", "rgb(7, 55, 99)", "rgb(32, 18, 77)", "rgb(76, 17, 48)"]
				]
	      });
    }
    
    /**
     * 3、界面模拟区域：初始化取号界面内容
     * a-根据业务类型 每个菜单形成一个单独的取号界面，然后填充取号界面里面的元素。
     * b-根据设置的分辨率，按比例缩小取号界面大小
     * @param itemData   业务列表
     * @param styleData  取号界面配置的元素
     */
    function addSingleLevelBuz(itemData, styleData)
    {
      var screenResolution = $screenResolution.val();
      var screenResolutionArr = screenResolution.split("x");
      var myWidth = parseInt(screenResolutionArr[0] / 3) + 2;
      var myHeight = parseInt(screenResolutionArr[1] / 3) + 2;
      
      //如果是个菜单
      //1.创建tab
      //2.查看这个菜单以前的取号界面配置中的背景配置
      //3.创建这个菜单的取号界面
      if (itemData && itemData.children && itemData.children.length > 0) 
      {
        //初始化中间画板
        var $div, $li, $btn, waitingNum, args, rlt, $buzTypeDiv;
        if ($("#level" + parseInt(itemData.attributes.levelNum)).length <= 0)//如果这个层级的tab不存在，就创建。
        {
          if (parseInt(itemData.attributes.levelNum) == 0)  //第一个层级就处于激活状态，tab属于激活的
          {
        
            $li = $("<li id=\"#tabHeadLevel" + parseInt(itemData.attributes.levelNum) + "\" class=\"active\"><a href=\"#level" + parseInt(itemData.attributes.levelNum) + "\" data-toggle=\"tab\">第" + (parseInt(itemData.attributes.levelNum) + 1) + "层</a></li>");
            $div = $("<div class=\"tab-pane fade in active\" id=\"level" + parseInt(itemData.attributes.levelNum) + "\"   style=\"width:100%;overflow:auto;min-height:" + (myHeight + 80) + "px;text-align:center;\"></div>");

          } else
          {
            $li = $("<li id=\"#tabHeadLevel" + parseInt(itemData.attributes.levelNum) + "\" ><a href=\"#level" + parseInt(itemData.attributes.levelNum) + "\" data-toggle=\"tab\">第" + (parseInt(itemData.attributes.levelNum) + 1) + "层</a></li>");
            $div = $("<div class=\"tab-pane fade in\" id=\"level" + parseInt(itemData.attributes.levelNum) + "\" style=\"width:100%;overflow:auto;max-height:500px;text-align:center;\"></div>");
          }

          $li.appendTo($myTab);
          $div.appendTo($myTabContent);
        }
        
        //如果这个菜单的界面没有生成，就先生成这个菜单的模拟界面
        if ($("#buzType" + itemData.id).length <= 0)
        {
          var childrenPageImg = "";  //背景图片
          var childrenPageColor = ""; //背景色
          //查看配置界面中是否有这个菜单的背景配置
          if (styleData && styleData.items && styleData.items.length > 0)  
          {
            $.each(styleData.items, function (index, item)
            {
              if (item.type == "buzType" && item.buzTypeId == itemData.id)
              {
                if (item.childrenPageImg && item.childrenPageImg.length > 0)
                {
                  childrenPageImg = item.childrenPageImg;
                } else if (item.childrenPageColor && item.childrenPageColor.length > 0)
                {
                  childrenPageColor = item.childrenPageColor;
                }
              }
            });
          }
          
          //生成菜单的取号界面
          //alert(childrenPageImg+"  "+childrenPageColor);
          $buzTypeDivHead = $('<div style="display:block;background-color:#6fa8dc;padding:0px;margin-top:10px;width:' + myWidth + 'px;border:0px #6fa8dc solid;height:50px;color:#FFFFFF;margin-right:auto; margin-left:auto;"><span style="line-height:50px;margin-left:10px;">业务类型:' + itemData.text + '</span><div style="margin-top:5px;margin-right:5px;float:right;"><input value="' + childrenPageColor + '" name="childrenPageColor" id="childrenPageColor' + itemData.id + '"></div><img style="cursor: pointer;margin-top:5px;margin-right:5px;float:right;width:40px;height:30px;border: 1px solid #dddddd;" id="childrenPageImg' + itemData.id + '" name="childrenPageImg" src="' + childrenPageImg + '" /></div>');
          $buzTypeDivHead.appendTo($("#level" + parseInt(itemData.attributes.levelNum)));
          $buzTypeDiv = $("<div id=\"buzType" + itemData.id + "\" style=\"display:block;background-size:100% 100%;position:relative;padding:0px;margin-top:0px;width:" + myWidth + "px;border:1px #6fa8dc solid;height:" + myHeight + "px;margin-right:auto; margin-left:auto;\"></div>");
          $buzTypeDiv.appendTo($("#level" + parseInt(itemData.attributes.levelNum)));

          if (childrenPageImg)
          {
            $buzTypeDiv.data("backgroundImage", childrenPageImg);
            $buzTypeDiv.data("backgroundColor", "");
            $buzTypeDiv.css("backgroundImage", "url(" + childrenPageImg + ")");
            $buzTypeDiv.css("backgroundColor", "");
          } else if (childrenPageColor)
          {
            $buzTypeDiv.data("backgroundImage", "");
            $buzTypeDiv.data("backgroundColor", childrenPageColor);
            $buzTypeDiv.css("backgroundImage", "");
            $buzTypeDiv.css("backgroundColor", childrenPageColor);
          }

        }
        
        //菜单的模拟取号区域绑定事件
        $buzTypeDiv = $("#buzType" + itemData.id);
        $buzTypeDiv.mousemove(function (e)
        {
          if ($(this).attr('class') != 'selected' && $(".clone").length > 0)
          {
            $(this).addClass('over');
          }
        });
        $buzTypeDiv.mouseout(function (e)
        {
          if ($(this).attr('class') != 'selected')
          {
            $(this).removeClass('over');
          }
        });
        //$buzTypeDiv.contextmenu(option);
        $buzTypeDiv.mouseup(function (e)  //取号界面鼠标松开事件，将克隆元素加入到取号界面中，同时给元素绑定事件
        {
          //alert(itemData.id);
          if ($(this).attr('class') != 'selected' && $(".clone").length > 0)
          {
        	  
            var $spn = $(".clone");
            $spn.attr("tabIndex", tabIndex);
            tabIndex++;

            $spn.on("mousedown", function ()
            {
              eval("map" + itemData.id + ".moveImage = false;");
              $("#allItems")[0].checked = false;
              $selectedItem = $(this);
              //动态改变右边的属性值
              initRightData(this);
              this.focus();
              $("div", eval("map" + itemData.id + ".innerMap")).each(function (index, item)
              {
                $(this).css("border", "0px");
              });
              $(this).css("border", "1px dotted red");
            });

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

            $spn.on("blur", function ()
            {
              $("#allItems")[0].checked = false;
              if (document.activeElement.tagName != "DIV")
              {
                //map.moveImage = true;
              }
            });
            $spn.draggable({
              onDrag: function (e)
              {
                var d = e.data;
                if (d.left < 0)
                {
                  d.left = 0;
                }
                if (d.top < 0)
                {
                  d.top = 0;
                }
                if (d.left + $(d.target).outerWidth() > $(d.parent).width())
                {
                  d.left = $(d.parent).width() - $(d.target).outerWidth();
                }
                if (d.top + $(d.target).outerHeight() > $(d.parent).height())
                {
                  d.top = $(d.parent).height() - $(d.target).outerHeight();
                }
              }

            });

            initItemStyle($spn.get(0));
            $spn.appendTo(eval("map" + itemData.id + ".innerMap"));
            var left = parseInt($(".clone").css('left'));
            var top = parseInt($(".clone").css('top'));
            var printX = parseInt($(this).get(0).getBoundingClientRect().left);
            var printY = parseInt($(this).get(0).getBoundingClientRect().top);
            $spn.css('left', left - printX).css('top', top - printY);
            $spn.attr('class', 'site');
            var spanData = $spn.data("itemData");
            
            spanData.buzTypeId = itemData.id;
            spanData.x = left - printX;
            spanData.y = top - printY;
            $spn.data("itemData", spanData);
            //alert($buzTypeDiv.html());
			//动态改变控件的显示隐藏
			updateQueueCtrlStyle(spanData,"add");
			//alert($.toJSON(spanData));		
            $spn.mousedown();

          }
        });

        //创建一个内部缩略图层，用于存放界面元素
        eval("map" + itemData.id + " = new Map(\"buzType" + itemData.id + "\", " + myWidth + ", " + myHeight + ", \"../../images/sssss.jpg\", null, null, null, 1)");
        eval("map" + itemData.id).moveImage = false;
        if (styleData)
        {
          $offsetX.val(styleData.offset.x);
          $offsetY.val(styleData.offset.y);
        }

        //加载取号界面配置中的元素（非业务类型的元素）
        if (styleData && styleData.items && styleData.items.length > 0)
        {
          $.each(styleData.items, function (index, item)
          {
            if (item.type != "buzType" && item.buzTypeId == itemData.id)
            {
              tabIndex++;
              $spn = $('<div class="site" style="background-size: 100% 100%;left:0px;top:0px;width:100px;height:50px;" tabindex="' + tabIndex + '"><label style="background-size:100% 100%;left:0px;top:0px;width:100%;height:100%;">' + item.text + '</label><button class = "close" onclick = closeSpan(this) type="button" data-dismiss="modal"></button></div>');
              $spn.data("itemData", item);
              $spn.appendTo($buzTypeDiv);
              initItemStyle($spn.get(0));

              $spn.on("mousedown", function ()
              {
                eval("map" + itemData.id + ".moveImage = false");
                $("#allItems")[0].checked = false;
                $selectedItem = $(this);
                //动态改变右边的属性值
                initRightData(this);
                this.focus();
                $("div", eval("map" + itemData.id).innerMap).each(function (index, item)
                {
                  $(item).css("border", "0px");
                });
                $(this).css("border", "1px dotted red");
              });

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

              $spn.on("blur", function ()
              {
                $("#allItems")[0].checked = false;
                if (document.activeElement.tagName != "SPAN")
                {
                }
              });

              $spn.draggable({
                onDrag: function (e)
                {
                  var d = e.data;
                  if (d.left < 0)
                  {
                    d.left = 0;
                  }
                  if (d.top < 0)
                  {
                    d.top = 0;
                  }
                  if (d.left + $(d.target).outerWidth() > $(d.parent).width())
                  {
                    d.left = $(d.parent).width() - $(d.target).outerWidth();
                  }
                  if (d.top + $(d.target).outerHeight() > $(d.parent).height())
                  {
                    d.top = $(d.parent).height() - $(d.target).outerHeight();
                  }
                }

              });
            }
          });
        }

        //加一条竖线
        $spn = $('<div style="position: absolute;z-index:12;text-align:center;border-left:1px dashed rgba(0,0,255,0.5);left:' + myWidth / 2 + 'px;top:0px;width:1px;height:100%;"></div>');
        $spn.appendTo($buzTypeDiv);
        //加一条横线
        $spn = $('<div style="position: absolute;z-index:12;text-align:center;border-top:1px dashed rgba(0,0,255,0.5);left:0px;top:' + myHeight / 2 + 'px;width:100%;height:1px;"></div>');
        $spn.appendTo($buzTypeDiv);

        //加载这个业务的子业务，加载到这个菜单的取号界面中去
        $.each(itemData.children, function (index, item)
        {
          if (item.state == "closed")
          {
            addSingleLevelBuz(item, styleData);
          }
          //20171129 改为真实的英文
//          $spn = $("<div class=\"site\" style=\"background-size:100% 100%;left:0px;top:0px;width:100px;height:50px;\" tabindex='" + tabIndex + "' id=\"item" + item.id + "\"><a href=\"javascript:void(0);\"><i style='display:inline-block;vertical-align: middle;'  class=\"fa fa-angle-up\"></i><li style='display:inline-block;vertical-align: middle;'>" + item.text + "<div style=\"font-size:5px;line-height:8px;\">specialCust</div><div style=\"font-size:5px;line-height:8px;\">等候人数：<span name=\"waitingNum\">0</span></div></li></a></div>");
          
          var busDivContent = "<div class=\"site\" style=\"background-size:100% 100%;left:0px;top:0px;width:100px;height:50px;\" tabindex='" + tabIndex + "' id=\"item" + item.id + "\"><a href=\"javascript:void(0);\"><i style='display:inline-block;vertical-align: middle;'  class=\"fa fa-angle-up\"></i><li style='display:inline-block;vertical-align: middle;'>" + item.text ;
          if (item.attributes.businessEnName != null) {
        	  busDivContent+="<div style=\"font-size:5px;line-height:8px;\">"+item.attributes.businessEnName+"</div>";
          }
          busDivContent += "<div style=\"font-size:5px;line-height:8px;\">等候人数：<span name=\"waitingNum\">0</span></div></li></a></div>";
          
          $spn = $(busDivContent);
          
          var defData = {
            "type": "buzType",
			"orgType":2,
            "x": 100,
            "y": 0,
            "width": 100,
            "height": 50,
            "family": "Microsoft YaHei",
            "style": "normal",
            "backgroundColor": "#b6d7a8",
            "fontColor": "#FFFFFF",
            "size": "16"
          };
          defData.buzTypeId = item.id;
          //alert($.toJSON(defData));
          $spn.data("itemData", defData);
          tabIndex++;
          if (styleData && styleData.items && styleData.items.length > 0)
          {
            $.each(styleData.items, function (index1, item1)
            {
              if (item1.type == "buzType")
              {
                if (item1.buzTypeId == item.id)
                {
                  $spn.data("itemData", item1);
                  return false;
                }
              }
            });
          }
          //alert($.toJSON($spn.data("itemData")));
          initItemStyle($spn.get(0));
          $spn.on("mousedown", function ()
          {
            eval("map" + itemData.id + ".moveImage = false");
            $("#allItems")[0].checked = false;
            $selectedItem = $(this);
            //动态改变右边的属性值
            initRightData(this);
            this.focus();
            $("div", eval("map" + itemData.id).innerMap).each(function (index, item)
            {
              $(item).css("border", "0px");
            });
            $(this).css("border", "1px dotted red");
          });

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

          $spn.on("blur", function ()
          {
            $("#allItems")[0].checked = false;
            if (document.activeElement.tagName != "SPAN")
            {
              //map.moveImage = true;
            }
          });

          $spn.draggable({
            onDrag: function (e)
            {
              var d = e.data;
              if (d.left < 0)
              {
                d.left = 0;
              }
              if (d.top < 0)
              {
                d.top = 0;
              }
              if (d.left + $(d.target).outerWidth() > $(d.parent).width())
              {
                d.left = $(d.parent).width() - $(d.target).outerWidth();
              }
              if (d.top + $(d.target).outerHeight() > $(d.parent).height())
              {
                d.top = $(d.parent).height() - $(d.target).outerHeight();
              }
            }
          });
          eval("map" + itemData.id + ".innerMap.append($spn)");
          $spn.appendTo($buzTypeDiv);
        });
      }
    }
    
    /**
     * 控制左侧元素，如果取号界面添加的这个元素已经超过了元素的最大数目则，则左侧列表的这个元素就隐藏起来，不让在继续增加
     * @param itemData
     * @param flag
     */
    function updateQueueCtrlStyle(itemData,flag){
		var type = itemData.type;
		var data,count,max;
		//遍历左侧元素
		$("#ctrList li").each(function (index, item){
			data = $(this).data("itemData");
			if(data.key == type){
				count = (data.count ? data.count:0);
				if(flag=="add"){
					count ++;
				}else{
					count --;
				}
				data.count = count;
				$(this).data("itemData",data);
				if(data.max&&count>=data.max){
					$(this).css("display","none");
				}else{
					$(this).css("display","block");
				}
			}
		});
	}
    
    /**
     * 初始化对象右边的属性
     * @param obj
     */
    function initRightData(obj)
    {
      var itemData = $(obj).data("itemData");
      if (!itemData) return;
      var type = itemData.type;

      $borderRadius.parent().parent().parent().show();
      if (type == "textAdv" || type == "systemTime")
      {
	    $isMute.parent().parent().parent().hide();
        $effect.parent().parent().parent().show();
        if ($effect.val() == "normal")
        {
          $scrollAmount.parent().parent().parent().hide();
          $direction.parent().parent().parent().hide();
        } else
        {
          $scrollAmount.parent().parent().parent().show();
          $direction.parent().parent().parent().show();
        }
        //图标  图标位置
        $icon.parent().parent().hide();
        $("#btn-icon-positions").parent().parent().hide();
        $ctrText.parent().parent().show();

        $backgroundColor.parent().parent().show();
        $backgroundImage.parent().parent().show();
        $fontFamily.parent().parent().parent().show();
        $fontStyle.parent().parent().parent().show();
        $fontSize.parent().parent().parent().show();
        $fontColor.parent().parent().show();
      } else if (type == "message" || type == "lobbyManager" || type == "coupon"||type=="validate")
      {
	    $isMute.parent().parent().parent().hide();
        $effect.parent().parent().parent().hide();
        $scrollAmount.parent().parent().parent().hide();
        $direction.parent().parent().parent().hide();
        //图标  图标位置
        $icon.parent().parent().hide();
        $("#btn-icon-positions").parent().parent().hide();
        $ctrText.parent().parent().show();


        $backgroundColor.parent().parent().show();
        $backgroundImage.parent().parent().show();
        $fontFamily.parent().parent().parent().show();
        $fontStyle.parent().parent().parent().show();
        $fontSize.parent().parent().parent().show();
        $fontColor.parent().parent().show();
      } else if (type == "buzType")
      {
	    $isMute.parent().parent().parent().hide();
        $effect.parent().parent().parent().hide();
        $scrollAmount.parent().parent().parent().hide();
        $direction.parent().parent().parent().hide();
        //文字内容
        $icon.parent().parent().show();
        $("#btn-icon-positions").parent().parent().show();
        $ctrText.parent().parent().hide();

        $backgroundColor.parent().parent().show();
        $backgroundImage.parent().parent().show();
        $fontFamily.parent().parent().parent().show();
        $fontStyle.parent().parent().parent().show();
        $fontSize.parent().parent().parent().show();
        $fontColor.parent().parent().show();
      } else if (type == "picAdv" )
      {
	    $isMute.parent().parent().parent().hide();
        $borderRadius.parent().parent().parent().hide();
        $topLeft1.parent().parent().hide();

        $effect.parent().parent().parent().hide();
        $scrollAmount.parent().parent().parent().hide();
        $direction.parent().parent().parent().hide();
        //文字内容
        $icon.parent().parent().hide();
        $("#btn-icon-positions").parent().parent().hide();
        $ctrText.parent().parent().hide();


        $backgroundColor.parent().parent().hide();
        $backgroundImage.parent().parent().hide();
        $fontFamily.parent().parent().parent().hide();
        $fontStyle.parent().parent().parent().hide();
        $fontSize.parent().parent().parent().hide();
        $fontColor.parent().parent().hide();
      }else if( type == "videoAdv"||type=="music"){
	    $isMute.parent().parent().parent().show();
        $borderRadius.parent().parent().parent().hide();
        $topLeft1.parent().parent().hide();

        $effect.parent().parent().parent().hide();
        $scrollAmount.parent().parent().parent().hide();
        $direction.parent().parent().parent().hide();
        //文字内容
        $icon.parent().parent().hide();
        $("#btn-icon-positions").parent().parent().hide();
        $ctrText.parent().parent().hide();


        $backgroundColor.parent().parent().hide();
        $backgroundImage.parent().parent().hide();
        $fontFamily.parent().parent().parent().hide();
        $fontStyle.parent().parent().parent().hide();
        $fontSize.parent().parent().parent().hide();
        $fontColor.parent().parent().hide();
	  }

      chose_set_ini("#ctrStyle", itemData.type);
      $x.val(itemData.x);
      $y.val(itemData.y);
      $backgroundColor.spectrum("set", itemData.backgroundColor);
      $width.val(itemData.width);
      $height.val(itemData.height);
      $ctrText.val(itemData.text);
      chose_set_ini("#fontFamily", itemData.family);
      chose_set_ini("#fontStyle", itemData.style);
      chose_set_ini("#fontSize", itemData.size);
      $fontColor.spectrum("set", itemData.fontColor);
      if (itemData.backgroundImage)
      {
        $("#backgroundImage").attr("src", itemData.backgroundImage);
      } else
      {
        $("#backgroundImage").attr("src", "");
      }
      if (itemData.icon && itemData.icon != "empty")
      {
        $icon.iconpicker('setIcon', itemData.icon);
      } else
      {
        $icon.iconpicker('setIcon', ' ');
      }
      chose_set_ini("#shadow", itemData.shadow);
      if (itemData.shadow && itemData.shadow == "shadow")
      {
        $shadowH.parent().parent().show();
      } else
      {
        $shadowH.parent().parent().hide();
      }
      $shadowH.val(itemData.shadowH);
      $shadowV.val(itemData.shadowV);
      $shadowBlur.val(itemData.shadowBlur);
      chose_set_ini("#rotate", itemData.rotate);
      if (itemData.rotate && itemData.rotate == "rotate")
      {
        $angleOfRotationZ.parent().parent().show();
      } else
      {
        $angleOfRotationZ.parent().parent().hide();
      }
      $angleOfRotationZ.val(itemData.angleOfRotationZ);

      chose_set_ini("#skew", itemData.skew);
      if (itemData.skew && itemData.skew == "skew")
      {
        $skewH.parent().parent().show();
      } else
      {
        $skewH.parent().parent().hide();
      }
      $skewH.val(itemData.skewH);
      $skewV.val(itemData.skewV);

      chose_set_ini("#borderRadius", itemData.borderRadius);
      if (itemData.borderRadius && itemData.borderRadius == "borderRadius")
      {
        $topLeft1.parent().parent().show();
      } else
      {
        $topLeft1.parent().parent().hide();
      }
      $topLeft1.val(itemData.topLeft1);
      $topRight1.val(itemData.topRight1);
      $bottomRight1.val(itemData.bottomRight1);
      $bottomLeft1.val(itemData.bottomLeft1);

      $topLeft2.val(itemData.topLeft2);
      $topRight2.val(itemData.topRight2);
      $bottomRight2.val(itemData.bottomRight2);
      $bottomLeft2.val(itemData.bottomLeft2);

      chose_set_ini("#effect", itemData.effect);
      chose_set_ini("#scrollAmount", itemData.scrollAmount);
      chose_set_ini("#direction", itemData.direction);
      //$('[data-rel="chosen"],[rel="chosen"]').trigger("chosen:updated");
	  
	  if (itemData.isMute && itemData.isMute == true)
      {
			$("#isMute").attr("src", $staticPath+"/static/components/ticket/images/voice/jy.png");
      } else
      {
			$("#isMute").attr("src", $staticPath+"/static/components/ticket/images/voice/yl.png");
      }
	  if(itemData.volume){
			setVoiceValue(itemData.volume);
	  }else{
			setVoiceValue(volume);
	  }
    }
	
    /**
     * 设置音量值
     * @param value
     */
	function setVoiceValue(value){
		if (value == 10)
		{
			expicState(2);
		} else if (value == 20)
		{
			expicState(3);
		} else if (value  == 40)
		{
			expicState(4);
		} else if (value  == 60)
		{
			expicState(5);
		} else if (value  == 80)
		{
			expicState(6);
		} else if (value  == 100)
		{
			expicState(7);
		}
		
		$("#volume").text(value);
	}

    function getImgRelitivePath(path)
    {
      return $staticPath + "/static/components/ticket/" + path.substr(path.indexOf("images"));
    }

    /**
     * 获取要保存的数据（将所有的界面元素的属性都获取提交）
     * @returns {___anonymous83776_83777}
     */
    function getPrintData()
    {
      var arg = {};
      if (!printConfig)
      {
        printConfig = {};
        printConfig.dpi = 100;
      }
      arg.dpi = printConfig.dpi;
      var list = [];

      var tmpItemData = {};
      tmpItemData.buzTypeId = 1;
      tmpItemData.type = "buzType";
      var childrenPageColor = $("#buzType1").data("backgroundColor");
      var childrenPageImg = $("#buzType1").data("backgroundImage");
      //alert(childrenPageColor+"  ========  "+childrenPageImg);
      if (childrenPageColor) tmpItemData.childrenPageColor = childrenPageColor;
      if (childrenPageImg) tmpItemData.childrenPageImg = getImgRelitivePath(childrenPageImg);//获取图片路径
      //alert($(item).data("itemData").text);
      list.push(tmpItemData);

      $(".site").each(function (index, item)
      {
        //改变item位置
        $(item).data("itemData").x = parseInt(this.style.left.replace("px", ""));
        $(item).data("itemData").y = parseInt(this.style.top.replace("px", ""));
        $(item).data("itemData").width = parseInt(this.style.width.replace("px", ""));
        $(item).data("itemData").height = parseInt(this.style.height.replace("px", ""));
        if ($(item).data("itemData").backgroundImage) $(item).data("itemData").backgroundImage = getImgRelitivePath($(item).data("itemData").backgroundImage);

        childrenPageColor = $("#buzType" + $(item).data("itemData").buzTypeId).data("backgroundColor");
        childrenPageImg = $("#buzType" + $(item).data("itemData").buzTypeId).data("backgroundImage");

        if (childrenPageColor)
        {
          $(item).data("itemData").childrenPageColor = childrenPageColor;
        } else
        {
          delete $(item).data("itemData").childrenPageColor;
        }
        if (childrenPageImg && $(item).data("itemData").type == "buzType")
        {
          $(item).data("itemData").childrenPageImg = getImgRelitivePath(childrenPageImg);
        } else
        {
          delete $(item).data("itemData").childrenPageImg;
        }
        //alert(childrenPageColor+"  ==== "+childrenPageImg);
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

    //保存配置
    function saveAndPrintConfig(){
      var args = {};
      args.styleId = styleId;
      args.styleName = $styleName.val();
      args.styleType = 3;
      args.screenResolution = $screenResolution.val();//屏幕分辨率
      args.dateTypeId = $dateTypeId.val();//日期类型（平日、假日）
      args.copyStatus = $copyStatus.prop("checked");//平日和假日复选框是否选中
      args.stylePath = "1";
      args.print = getPrintData();//配置的数据
      args.def =  $def.prop("checked");
      args.orgId = orgId;
      args.deviceNo = deviceNo;

      var dataTypeStr = (args.dateTypeId == "1" ? "平日" : "假日");

      if (args.copyStatus)
      {
        if (!window.confirm("确定要复制该模板到" + dataTypeStr + "模板," + dataTypeStr + "模板会被覆盖,是否继续?")) return;
      }
    
      $.ajax({
    	url: contextPath+"/businessconfig/takeconfig/saveConfig?dt="+(new Date().getTime()), 
  		type : "post",
  		dataType: "json",
  		data:$.toJSON(args),
  		contentType: "application/json",
  		success: function(data) {
  			 //alert($.toJSON(data))
  			 if (data.errorCode == 0)
		      {
		        qmsVld.showInfo("保存取号模板成功");
		      }
  			 else if (data.errorCode == 1)//20181114 by tianjm
		      {
 		        qmsVld.showError("文本内容不能含有特殊字符");
 		      }
  			 else
		      {
		        qmsVld.showError("保存取号模板失败！已存在相同名称的模板,请重新修改");
		      }
  		},
  		error: function(msg) {
  			alert("出错了！");
  		}
  	  })
    }

    function onDrag(e)
    {
      var d = e.data;
      if (d.left < 0) { d.left = 0 }
      if (d.top < 0) { d.top = 0 }
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
	
  // 设置声音，保存音量
  function setVoice(value, index)
  {
    $("#isMute").attr("src", $staticPath+"/static/components/ticket/images/voice/yl.png");
    $("#volume").text(value);
    expicState(index);
	
	if (!$selectedItem) return;
	$selectedItem.data("itemData").isMute = false;
	$selectedItem.data("itemData").volume = value;
	initItemStyle($selectedItem);
	
  }
  
  // 修改不同音量时的图片样式
  function expicState(index)
  {
    var $imgs = $("#voiceTr img");
	//alert($imgs.length);
    for (var i = 0; i < $imgs.length; i++)
    {
      if (i >= 1)
      {
        if (index > i)
        {
          $imgs.eq(i).attr("src", $staticPath+"/static/components/ticket/images/voice/voice" + (i) + "_selected.png");
        } else
        {
          $imgs.eq(i).attr("src", $staticPath+"/static/components/ticket/images/voice/voice" + (i) + ".png");
        }
      }
    }
  }