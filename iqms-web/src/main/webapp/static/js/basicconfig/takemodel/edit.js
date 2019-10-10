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
	
	$(function(){
		 params = $.string(window.location.href).toQueryParams();
	     styleId = params["styleId"];
	     styleName = params["styleName"];
	     orgId = params["orgId"];
	     deviceNo = params["deviceNo"];
	     $styleName = $("#styleName");
	     $screenResolution = $("#screenResolution");
	     $dateTypeId = $("#dateTypeId");
	     $copyStatus = $("#copyStatus");
	     $ctrList = $("#ctrList");
	     $myModal = $('#myModal');
	     $objId = $("#objId");
	     $myImagePicker = $("#myImagePicker");
	     $icon = $("#icon");
	     $ctrText = $("#ctrText");
	     $effect = $("#effect");
	     $scrollAmount = $("#scrollAmount");
	     $direction = $("#direction");
	     $backgroundColor = $("#backgroundColor");
	     $backgroundImage = $("#backgroundImage");
	     $fontFamily = $("#fontFamily");
	     $fontStyle = $("#fontStyle");
	     $fontSize = $("#fontSize");
	     $fontColor = $("#fontColor");
	     $ctrText = $("#ctrText");
	     $shadow = $("#shadow");
	     $shadowH = $("#shadowH");
	     $shadowV = $("#shadowV");
	     $shadowBlur = $("#shadowBlur");
	     $rotate = $("#rotate");
	     $angleOfRotationX = $("#angleOfRotationX");
	     $angleOfRotationY = $("#angleOfRotationY");
	     $angleOfRotationZ = $("#angleOfRotationZ");
	     $shape = $("#shape");
	     $skew = $("#skew");
	     $skewH = $("#skewH");
	     $skewV = $("#skewV");
	     $borderRadius = $("#borderRadius");
	     $topLeft1 = $("#topLeft1");
	     $topRight1 = $("#topRight1");
	     $bottomRight1 = $("#bottomRight1");
	     $bottomLeft1 = $("#bottomLeft1");
	     $topLeft2 = $("#topLeft2");
	     $topRight2 = $("#topRight2");
	     $bottomRight2 = $("#bottomRight2");
	     $bottomLeft2 = $("#bottomLeft2");
		 $isMute = $("#isMute");
		 $staticPath = $("#myhidden").val();
		 $def = $("#def");
		  
	      $styleName.val(styleName);
	      $('[data-rel="chosen"],[rel="chosen"]').chosen();
	      $.metadata.setType("attr", "validate");
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
	    	  window.location.href = contextPath+"/basicconfig/takemodel" ;
	      });
	      
	     //获取样式
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
	  			})
	  			getVideoList();
	  		},
	  		error: function(msg) {
	  			alert("出错了！");
	  		}
	  	  })
	});
	
	//获取视频
    function getVideoList(){
    	$.ajax({
	    	url: contextPath+"/basicconfig/getVideoList?dt="+(new Date().getTime()), 
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
		          tmpItem.m4v = item.fullPath;
		          tmpItem.ogv = item.fullPath;
		          tmpItem.webmv = item.fullPath;
		          videoList.push(tmpItem);
		        });
		        
	  			getMusicList();
	  		},
	  		error: function(msg) {
	  			alert("出错了！");
	  		}
	  	})
    }
	
    //获取音乐
	function getMusicList(){
		$.ajax({
	    	url: contextPath+"/basicconfig/getMusicList?dt="+(new Date().getTime()), 
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
		        
		        getBackgroundImgs();
	  		},
	  		error: function(msg) {
	  			alert("出错了！");
	  		}
	  	})
      }

	//获取背景图片
    function getBackgroundImgs(){
    	$.ajax({
	    	url: contextPath+"/basicconfig/getBackgroundImgs?dt="+(new Date().getTime()), 
	  		type : "get",
	  		dataType: "json",
	  		data:{},
	  		contentType: "application/json",
	  		success: function(data) {
	  		  //alert($.toJson(data))
	  		  backgroundImgList = data;

	  	      $myImagePicker = $("#myImagePicker");
	  	      $myImagePicker.empty().html("");

	  	      $.each(backgroundImgList, function (index, item)
	  	      {
	  	        $("<option data-img-src='" + item.fullPath + "' value='" +  item.fullPath + "'>" + item.imgName + "</option>").data("data", item).appendTo($myImagePicker);
	  	      });

	  	      $("select.image-picker.show-labels").imagepicker({
	  	        hide_select: true,
	  	        show_label: true
	  	      });

	  	      $myTab = $("#myTab");
	  	      $myTabContent = $("#myTabContent");
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

	  	      $('#icon').iconpicker({
	  	        rows: 4,
	  	        cols: 4,
	  	        align: 'left'
	  	      });

	  	      $('#icon').on('change', function (e)
	  	      {
	  	        if (!$selectedItem) return;
	  	        $('a > i', $selectedItem).attr('class', 'fa ' + e.icon);
	  	        $selectedItem.data("itemData").icon = e.icon;
	  	      });

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


	  	      $("#ctrStyle").on("change", function ()
	  	      {
	  	        if (!$selectedItem) return;
	  	        //改变dataItem值
	  	        $selectedItem.data("itemData").type = this.value;
	  	        //改变左边的显示效果
	  	        initItemStyle($selectedItem);
	  	      });

	  	      $("#ctrText").on("change", function ()
	  	      {
	  	        if (!$selectedItem) return;
	  	        //改变dataItem值
	  	        $selectedItem.data("itemData").text = this.value;
	  	        //改变左边的显示效果
	  	        initItemStyle($selectedItem);
	  	      });

	  	      $("#fontFamily").on("change", function ()
	  	      {
	  	        if (!$selectedItem) return;
	  	        //改变dataItem值
	  	        $selectedItem.data("itemData").family = this.value;
	  	        //改变左边的显示效果
	  	        initItemStyle($selectedItem);
	  	      });

	  	      $("#fontStyle").on("change", function ()
	  	      {
	  	        if (!$selectedItem) return;
	  	        //改变dataItem值
	  	        $selectedItem.data("itemData").style = this.value;
	  	        //改变左边的显示效果
	  	        initItemStyle($selectedItem);
	  	      });

	  	      $("#fontSize").on("change", function ()
	  	      {
	  	        if (!$selectedItem) return;

	  	        //改变dataItem值
	  	        $selectedItem.data("itemData").size = this.value;
	  	        //改变左边的显示效果
	  	        initItemStyle($selectedItem);
	  	      });

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

	  	      //切换分辨率
	  	      $screenResolution.on("change", function ()
	  	      {
	  	        createPreviewHtml();
	  	      });

	  	      //切换日期类型
	  	      $dateTypeId.on("change", function ()
	  	      {
	  	        createPreviewHtml();
	  	      });

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
	  		  
	  	      //音量调节
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

	  		  //文字颜色
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

	  	      //背景颜色
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

	  	      setTimeout(initPage, 0);
	  		},
	  		error: function(msg) {
	  			alert("出错了！");
	  		}
	  	})
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


    function initPage(){
      //----------------------------------------------------左边初始化 start--------------------------------------------
      $ctrList.html("");
      //查询小表
      $.ajax({
	    	url: contextPath+"/basicconfig/sysdic/takeElement?dt="+(new Date().getTime()), 
	  		type : "get",
	  		dataType: "json",
	  		async : false,
	  		data:{},
	  		contentType: "application/json",
	  		success: function(data) {
	  			  //alert($.toJSON(data))
	  			  var queueCtrls = null;
		  	      var widthStr = "";
		  	      var xWidth = (app.screenResolution).split("x")[0];
		  	      if (xWidth <= 768)
		  	      {
		  	        widthStr = "width:130px;";
		  	      }
		  	        queueCtrls = data.rows;
		  	        if (queueCtrls) chose_ini("#ctrStyle", queueCtrls, null);
		  	        var $li = null;
		  	        $.each(queueCtrls, function (index, item)
		  	        {
		  	          if (item.key != "buzType")
		  	          {
		  	            $li = $("<li id='" + item.key + "' style='" + widthStr + "display:inline-block;'><a class='ajax-link' href='#'><i class='glyphicon glyphicon-font'></i><span>" + item.value + "</span></a></li>");
		  				$li.data("itemData",item);
		  				$li.appendTo($ctrList);
		  	          }
		  	        });
	  		},
	  		error: function(msg) {
	  			alert("出错了！");
	  		}
	  	  })
	  	  
	  //根据type查询大表
	  /*var arg ={};
      arg.type = 6;*/
	  $.ajax({
	    	url:  contextPath+"/basicconfig/sysdic/screenResolution?dt="+(new Date().getTime()), 
	  		type : "get",
	  		dataType: "json",
	  		//data: $.toJSON(arg),
	  		async : false,
	  		contentType: "application/json",
	  		success: function(data) {
	  			  //alert($.toJSON(data))
	  			var screenResolutionSettings = data.rows;
	  			if (screenResolutionSettings){
	  				chose_ini("#screenResolution", screenResolutionSettings, app.screenResolution); 
	  			}
	  		},
	  		error: function(msg) {
	  			alert("出错了！");
	  		}
	  	  })	 
     
	  //----------------------------------------------------左边初始化 end--------------------------------------------
	  	  
	  //----------------------------------------------------中间初始化 start------------------------------------------ 
      $offsetX = $("#offsetX");
      $offsetY = $("#offsetY");
      createPreviewHtml();
      //----------------------------------------------------中间初始化 end--------------------------------------------

      //鼠标按下，鼠标变移动标志，克隆元素，并确定新克隆元素位置
      $("#ctrList li").mousedown(function (e)
      {
		  var $span = $("<div style='list-style:none;position:absolute;'>&nbsp;</div>");

		  $span.addClass("clone").appendTo($("body"));
		  $("body").css('cursor', 'move');
		  $span.css('left', e.clientX + 1);
		  $span.css('top', e.clientY + 1);
		  var data = $(this).data("itemData");
		  
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


    closeLoading();
      

    }
    //单选select html初始化
    function chose_ini(select, jsonObj, iniValue)
    {
      $.each(jsonObj, function (index, item)
      {
        $(select).append("<option value='" + item.key + "'  style='font-family:SimHei;'>" + item.value + "</option>");
      });

      if (iniValue) $(select).val(iniValue);//设置默认分辨率
      $(select).trigger("chosen:updated");
    }

    function chose_mult_ini(select, jsonObj, iniValues)
    {

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

    //双击关闭元素
    function closeSpan(obj)
    {
      var $spn = $(obj).parent();
	  //动态改变控件的显示隐藏
	  updateQueueCtrlStyle($spn.data("itemData"),"del");
	  $spn.remove();
    }
	
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

      } else if (item.type == "message")
      {
        $spn.empty().html('<label  style="display:table-cell;vertical-align:middle; background-size:100% 100%;left:0px;top:0px;width:100%;height:100%;">' + item.text + '</label><button class = "close" ondblclick = "closeSpan(this)" type="button" data-dismiss="modal"></button>');
        setIndex($spn.get(0));
      } else if (item.type == "lobbyManager")
      {
        $spn.empty().html('<label  style="cursor:pointer;display:table-cell;vertical-align:middle; background-size:100% 100%;left:0px;top:0px;width:100%;height:100%;">' + item.text + '</label><button class = "close" ondblclick = "closeSpan(this)" type="button" data-dismiss="modal"></button>');
        setIndex($spn.get(0));
      } else if (item.type == "coupon")
      {//优惠券
        $spn.empty().html('<a href="#"><li style="display:inline-block;vertical-align: middle;">' + item.text + '</li></a><button class = "close" ondblclick = "closeSpan(this)" type="button" data-dismiss="modal"></button>');
		setIndex($spn.get(0));
	  }else if (item.type == "validate")
      {//输入验证
        $spn.empty().html('<a href="#"><li style="display:inline-block;vertical-align: middle;">' + item.text + '</li></a><button class = "close" ondblclick = "closeSpan(this)" type="button" data-dismiss="modal"></button>');
		setIndex($spn.get(0));
	  }else if (item.type == "picAdv")//图片广告
      {
        $spn.empty().html('<label  style="display:table-cell;vertical-align:middle; background-size:100% 100%;left:0px;top:0px;width:100%;height:100%;">' + item.text + '</label><button class = "close" ondblclick = "closeSpan(this)" type="button" data-dismiss="modal"></button>');
        setIndex($spn.get(0));

        if (advConfig && advConfig.length > 0)
        {
          var $advContent = $spn.find("label");
          var html = "";
          $.each(advConfig, function (index, img)
          {
            html += "<img id='" + img.id + "' src='"+ $staticPath +"/static/components/ticket/images/advs/" + img.name + img.ext + "' style='width:" + item.width + "px;height:" + item.height + "px' />";
          });
          $advContent.empty().html(html);
          $advContent.cycle(
				{
				  fx: "fade,wipe,uncover",
				  timeout: 3000,
				  timeoutFn: function calculateTimeout(currElement, nextElement, opts, isForward)
				  {
				    var i = parseInt(currElement.id.replace("pict", ""), 10) - 1;
				    return advConfig[i].timeout;
				  }
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
	
    function createPreviewHtml(){
        $myTab.html("");
        $myTabContent.html("");
        //查询出业务树
        $.ajax({
  	    	url: contextPath+"/basicconfig/buztime?dt="+(new Date().getTime()), 
  	  		type : "get",
  	  		dataType: "json",
  	  		data:{},
  	  		contentType: "application/json",
  	  		success: function(data) {
  	  			//alert($.toJSON(data))
  	  			getBuzTypesForTreeByDateTypeId(data);
  	  		},
  	  		error: function(msg) {
  	  			alert("出错了！");
  	  		}
  	  	  })
    }
    
    function getBuzTypesForTreeByDateTypeId(rlt){
      //全部初始化好
      if (rlt.length > 0){
        bizDatas = rlt[0];
        if (bizDatas.state == "closed"){
          var args = {};
          args.styleId = styleId;
          args.screenResolution = $screenResolution.val();
          args.dateTypeId = $dateTypeId.val();
          args.stylePath = "1";
          args.orgId = orgId;
          args.deviceNo = deviceNo;
          
          $.ajax({
    	    	url: contextPath+"/basicconfig/getStyle?dt="+(new Date().getTime()), 
    	  		type : "post",
    	  		dataType: "json",
    	  		async : false,
    	  		data:$.toJSON(args),
    	  		contentType: "application/json",
    	  		success: function(data) {
    	  			//alert($.toJSON(data))
		  		      var styleData;
		  		      styleData = data.queueTemplate.print;
		  			  parseInt(data.def) ? $def.prop("checked", true) : $def.prop("checked", false);
		  		      addSingleLevelBuz(bizDatas, styleData);
		  		      
		  			  $(".site").each(function (index, item){
		  				updateQueueCtrlStyle($(item).data("itemData"),"add");//动态改变控件的显示隐藏
		  		      });
    	  		},
    	  		error: function(msg) {
    	  			alert("出错了！");
    	  		}
    	  })
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
    
    //递归方法
    function addSingleLevelBuz(itemData, styleData)
    {
      var screenResolution = $screenResolution.val();
      var screenResolutionArr = screenResolution.split("x");
      var myWidth = parseInt(screenResolutionArr[0] / 3) + 2;
      var myHeight = parseInt(screenResolutionArr[1] / 3) + 2;
      if (itemData && itemData.children && itemData.children.length > 0)
      {
        //初始化中间画板
        var $div, $li, $btn, waitingNum, args, rlt, $buzTypeDiv;
        if ($("#level" + parseInt(itemData.attributes.levelNum)).length <= 0)
        {
          if (parseInt(itemData.attributes.levelNum) == 0)
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

        if ($("#buzType" + itemData.id).length <= 0)
        {
          var childrenPageImg = "";
          var childrenPageColor = "";
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
        $buzTypeDiv.mouseup(function (e)
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

        eval("map" + itemData.id + " = new Map(\"buzType" + itemData.id + "\", " + myWidth + ", " + myHeight + ", \"../../images/sssss.jpg\", null, null, null, 1)");
        eval("map" + itemData.id).moveImage = false;
        if (styleData)
        {
          $offsetX.val(styleData.offset.x);
          $offsetY.val(styleData.offset.y);
        }

        //type != "buzType"
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

        //业务类型 type=="buzType"
        $.each(itemData.children, function (index, item)
        {
          if (item.state == "closed")
          {
            addSingleLevelBuz(item, styleData);
          }
          //可显示但不在 json中
          $spn = $("<div class=\"site\" style=\"background-size:100% 100%;left:0px;top:0px;width:100px;height:50px;\" tabindex='" + tabIndex + "' id=\"item" + item.id + "\"><a href=\"#\"><i style='display:inline-block;vertical-align: middle;'  class=\"fa fa-angle-up\"></i><li style='display:inline-block;vertical-align: middle;'>" + item.text + "<div style=\"font-size:5px;line-height:8px;\">specialCust</div><div style=\"font-size:5px;line-height:8px;\">等候人数：<span name=\"waitingNum\">0</span></div></li></a></div>");
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
    
    function updateQueueCtrlStyle(itemData,flag){
		var type = itemData.type;
		var data,count,max;
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
    	url: contextPath+"/basicconfig/saveConfig?dt="+(new Date().getTime()), 
  		type : "post",
  		dataType: "json",
  		data:$.toJSON(args),
  		contentType: "application/json",
  		success: function(data) {
  			 //alert($.toJSON(data))
  			 if (data.errorCode == 0)
		      {
		        qmsVld.showInfo("保存取号模板成功");
		      } else
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