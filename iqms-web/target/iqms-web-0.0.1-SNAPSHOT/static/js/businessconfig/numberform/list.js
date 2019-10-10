    var $modalTitle ;  
    var $tktFormat ;
    var $actionType ;
    var $tktFormatId ;
    var $sortable2 ;
    var $myModal ;
    var $tktPrefix ;
    var $custPrefix ;
    var $lsws ;
    var $lswsNum ;
    $(function (){
    	$modalTitle = $("#modalTitle");//模态框的标题“模板新增”
        $tktFormat = $("#tktFormat");//业务类型、客户等级、流水位数、提示的父标签前面的兄弟标签隐藏域（号码模板格式）

        $actionType = $("#actionType");//操作类型（新增，删除、复制）的隐藏域
        $tktFormatId = $("#tktFormatId");//操作类型（新增，删除、复制）ID 的隐藏域
        $sortable2 = $("#sortable2");//业务类型和客户等级的父标签
        $myModal = $('#myModal');//新增时打开的模态框

        $tktPrefix = $("#tktPrefix");//业务类型前面的复选框按钮
        $custPrefix = $("#custPrefix");//客户等级前面的复选框按钮
        $lsws = $("#lsws");//流水位数前面的复选框按钮
        $lswsNum = $("#lswsNum");//流水位数的文本框
        
    	
	  //定义验证规则在控件的那个属性上
      $.metadata.setType("attr", "validate");
      $("#frm").validate({
        onfocusout: function (element) //控件即将逝去焦点时处理
        {
          $(element).valid();
        },
        submitHandler: function (form)
        {
          modelSubmit();
          return false;
        }
      });
	
	//单击新增按钮会打开模态框，同时初始化里面的内容
      $("#addBtn").click(function (e)
      {
        e.preventDefault();
        var itemData = {};
        showModal("new", itemData);
      });
      
      //by hongxz 查询所有的号码模板
      initPage();
      
    });
    
    //编辑号码模板
    function editTr(obj){
      $tr = $(obj).parent().parent();
      showModal("update", $tr.data("itemData"));
    }
    
    //复制号码模板
    function copyTr(obj){
   	  $tr = $(obj).parent().parent();
      showModal("copy", $tr.data("itemData"));
    }
	
    //删除号码模板
    function delTr(obj){
    	 var jc = $.confirm({
    	        title: '号码模板删除',
    	        icon: 'fa fa-warning red',
    	        theme:'bootstrap',
    	        content: '确定要删除此号码模板吗？引用此号码模板的关联配置也将删除',
    	        draggable: true,
    	        closeIcon: true,
    	        offsetTop: 150,
    	        columnClass: 'col-md-6 col-md-offset-2 col-xs-4 col-xs-offset-8',
    	        buttons:{
    	            cancel: {
    	                text: '<i class="ace-icon fa fa-times"></i>取消',
    	                btnClass: 'btn-default'
    	            },
    	            ok: {
    	                text: '<i class="ace-icon fa fa-check"></i>确定',
    	                btnClass: 'btn-info',
    	                action: function(){
    	                    var $tr = $(obj).parent().parent();
    	                    var args = {};
    	                    args.tktFormatId = $tr.data("itemData").tktFormatId; //提交的参数
    	                    $.ajax({
    	                		url: contextPath+"/businessconfig/numberform?_method=delete",
    	                		type : "post",
    	                		dataType: "json",
    	                		contentType: "application/json",
    	                		data:$.toJSON(args),
    	                		success: function(data) {
    	            			      if (data.errorCode == 0)
    	            			      {
    	            			        qmsVld.showInfo("删除号码模板成功！");
    	            			        initPage();//新增、拷贝、编辑完成后关闭模态框，查询号码模板，然后展示
    	            			      } else
    	            			      {
    	            			        qmsVld.showError("删除号码模板失败！");
    	            			      }
    	                		},
    	                		error: function(msg) {
    	                			qmsVld.showError("删除号码模板异常！");
    	                		}
    	            	      });
    	                }
    	            }
    	        }
    	    });
    }
    
    //打开模态框
    function showModal(type, itemData)
    {
      $("#frm input").popover('hide');
      $("#frm input").parent().removeClass("has-error");
      var tktFormat = null;
      console.log(itemData);
      if (itemData && itemData.tktFormat)
      {
        tktFormat = itemData.tktFormat;
      }
	
	//根据按钮类型来创建不同的内容，但实际上只有新增按钮
      if (type == "new"){
        $modalTitle.text("模板新增");
        $tktFormatId.val(0); //给隐藏域ID赋值,操作类型（新增，删除、复制）ID 的隐藏域
        $lswsNum.val(3); //给流水位数赋3位默认值
      } else if (type == "copy"){
        $modalTitle.text("模板复制");
        $tktFormatId.val(itemData.tktFormatId);
        $tktFormat.val(itemData.tktFormat);//业务类型、客户等级、流水位数、提示的父标签前面的兄弟标签隐藏域
      } else if (type == "update"){
        $modalTitle.text("模板修改");
        $tktFormatId.val(itemData.tktFormatId);
        $tktFormat.val(itemData.tktFormat);
      }
      $actionType.val(type);
      initSortableUL(tktFormat);//初始化模态框里的内容
      
      //设置列表可排序
      $sortable2.sortable({
        revert: true
      });
      //清除选择项
      $sortable2.find("li").disableSelection();
      //鼠标移入移出的样式改变
      $sortable2.find("li").bind({
        mouseover: function () { $(this).css("background-color", "rgba(221, 221, 221, 0.6)"); },
        mouseout: function () { $(this).css("background-color", "#fbf9ee"); }
      });
      $myModal.modal('show');//手动打开模态框
    }
	
	//初始化打开后的模态框里的内容
    function initSortableUL(tktFormat)
    {
      $sortable2.empty().html("");
      //为空时意味着新增，新增时的样式
      if (!tktFormat)
      {
        var $li = $("<li class='ui-state-highlight' style='border:1.5px rgba(221, 221, 221, 0.6) solid;margin: 5px; padding: 5px; text-align:left;font-family:Arial Negreta,Arial;font-size:12px;line-height:30px;background-color: rgb(251, 249, 238);'></li>");
        var $span = $("<span class='ui-state-highlight'><input  type='checkbox' checked id='tktPrefix'><label style='margin-left: 5px;margin-right: 5px;'>业务类型</label></span>");
        $span.appendTo($li);
        $li.appendTo($sortable2);

        $li = $("<li class='ui-state-highlight' style='border:1.5px rgba(221, 221, 221, 0.6) solid;margin: 5px; padding: 5px; text-align:left;font-family:Arial Negreta,Arial;font-size:12px;line-height:30px;background-color: rgb(251, 249, 238);'></li>");
        $span = $("<span class='ui-state-highlight'><input  type='checkbox' checked id='custPrefix'><label style='margin-left: 5px;margin-right: 5px;'>客户等级</label></span>");
        $span.appendTo($li);
        $li.appendTo($sortable2);
        return;
      }
	
      //不为空，意味着编辑时的样式
      var tktFormatArr = tktFormat.split("|");
      if (tktFormat.length > 1){
        var $li = null;
        var $span = null;
       
        for (var i = 0; i < tktFormatArr.length - 1; i++){  //按顺序打印勾选的内容
          if (tktFormatArr[i].length > 0){
            $li = $("<li class='ui-state-highlight' style='border:1.5px rgba(221, 221, 221, 0.6) solid;margin: 5px; padding: 5px; text-align:left;font-family:Arial Negreta,Arial;font-size:12px;line-height:30px;background-color: rgb(251, 249, 238);'></li>");
            if (tktFormatArr[i] == "tktPrefix")
            {
              $span = $("<span class='ui-state-highlight'><input  type='checkbox' checked id='tktPrefix'><label style='margin-left: 5px;margin-right: 5px;'>业务类型</label></span>");
              $span.appendTo($li);
              $li.appendTo($sortable2);
            } else if (tktFormatArr[i] == "custPrefix")
            {
              $span = $("<span class='ui-state-highlight'><input  type='checkbox' checked id='custPrefix'><label style='margin-left: 5px;margin-right: 5px;'>客户等级</label></span>");
              $span.appendTo($li);
              $li.appendTo($sortable2);
            }
          }
        }
      } else{  //没勾选客户登记几业务类型，默认显示没勾选
        $li = $("<li class='ui-state-highlight' style='border:1.5px rgba(221, 221, 221, 0.6) solid;margin: 5px; padding: 5px; text-align:left;font-family:Arial Negreta,Arial;font-size:12px;line-height:30px;background-color: rgb(251, 249, 238);'></li>");
        $span = $("<span class='ui-state-highlight'><input  type='checkbox' checked id='tktPrefix'><label style='margin-left: 5px;margin-right: 5px;'>业务类型</label></span>");
        $span.appendTo($li);
        $li.appendTo($sortable2);

        $li = $("<li class='ui-state-highlight' style='border:1.5px rgba(221, 221, 221, 0.6) solid;margin: 5px; padding: 5px; text-align:left;font-family:Arial Negreta,Arial;font-size:12px;line-height:30px;background-color: rgb(251, 249, 238);'></li>");
        $span = $("<span class='ui-state-highlight'><input  type='checkbox' checked id='custPrefix'><label style='margin-left: 5px;margin-right: 5px;'>客户等级</label></span>");
        $span.appendTo($li);
        $li.appendTo($sortable2);
      }
      $lswsNum.val((tktFormatArr[tktFormatArr.length - 1]).length);
    }
    
    //单击“确认”按钮提交时触发
    function modelSubmit(obj)
    {
      $("#myModal input").parent().removeClass("has-error");
      var type = $actionType.val();//隐藏域中获取请求类型（新增、拷贝、更新、删除）
      var jo = {};
      jo.tktFormat = $tktFormat.val();

      var $inputs = $sortable2.find("input[type=checkbox]:checked");
      var tktFormatStr = "";  //号码模板格式
      var tktFormatTypeId = "";
	
	//将复选框中的内容，使用“|”拼接起来，作为参数传入后台
      $.each($inputs, function (index, item)
      {
        tktFormatTypeId = $(item).attr("id"); //获取选中的类型
        if (tktFormatTypeId == "tktPrefix") //业务类型
        {
          tktFormatStr += "tktPrefix|";
        } else if (tktFormatTypeId == "custPrefix")  //客户等级
        {
          tktFormatStr += "custPrefix|";
        }
      });
	
	 //流水位数的值
      var lsStr = "";
      if ($lswsNum.val()) //根据流水位数补0
      {
        for (var i = 0; i < $lswsNum.val(); i++)
        {
          lsStr += "0";												
        }
      }
      tktFormatStr += lsStr;   //格式    XXX|xxxx|0000
      jo.tktFormat = tktFormatStr;

      //1、新增时提交数据到后台
      if (type == "new"){
          jo.tktFormatId = "";
          var tktFormat = jo.tktFormat ;
          var tktFormatId = jo.tktFormatId ;
          
	      $.ajax({
    		url: contextPath+"/businessconfig/numberform?ftype=add&_method=get",
    		type : "get",
    		dataType: "json",
    		contentType: "application/json",
    		data:jo,
    		success: function(data) {
			      if (data.errorCode == 0)
			      {
			        qmsVld.showInfo("新增号码模板成功");
			        initPage();//新增、拷贝、编辑完成后关闭模态框，查询号码模板，然后展示
			      } else
			      {
			        qmsVld.showError("新增号码模板失败！已存在相同格式的模板,请重新添加");
			      }
    		},
    		error: function(msg) {
    			qmsVld.showError("新增号码模板失败异常！"+msg);
    		}
	      })
      } else if (type == "copy")  {  //2、复制后提交数据到后台
        jo.tktFormatId = 0;
        var tktFormat = jo.tktFormat ;
        var tktFormatId = jo.tktFormatId ;
        
        $.ajax({
    		url: contextPath+"/businessconfig/numberform?ftype=add&_method=get",
    		type : "get",
    		dataType: "json",
    		contentType: "application/json",
    		data:{"tktFormat": tktFormat,
    			  "tktFormatId":tktFormatId
    			 },
    		success: function(data) {
			      if (data.errorCode == 0)
			      {
			        qmsVld.showInfo("复制新增号码模板成功");
			        initPage();//新增、拷贝、编辑完成后关闭模态框，查询号码模板，然后展示
			      } else
			      {
			        qmsVld.showError("复制新增号码模板失败！已存在相同格式的模板！");
			      }
    		},
    		error: function(msg) {
    			qmsVld.showError("复制号码模板失败异常！"+msg);
    		}
	      })
      } else if (type == "update"){  //3、修改后提交数据到后台
        jo.tktFormatId = $tktFormatId.val();
        var tktFormat = jo.tktFormat ;
        var tktFormatId = jo.tktFormatId ;
        
        $.ajax({
    		url: contextPath+"/businessconfig/numberform?ftype=update&_method=get",
    		type : "get",
    		dataType: "json",
    		contentType: "application/json",
    		data:{"tktFormat": tktFormat,
    			  "tktFormatId":tktFormatId
    			 },
    		success: function(data) {
			      if (data.errorCode == 0)
			      {
			        qmsVld.showInfo("修改号码模板成功");
			        initPage();//新增、拷贝、编辑完成后关闭模态框，查询号码模板，然后展示
			      } else
			      {
			        qmsVld.showError("修改号码模板失败！已存在相同格式的模板,请重新修改");
			      }
    		},
    		error: function(msg) {
    			qmsVld.showError("修改号码模板失败异常！"+msg);
    		}
	      })
      }
   }
	
    //展示号码模板
    function initPage()
    {
      $('#myModal').modal('hide');  //模式对话框隐藏
      $("#ccc").find("tbody").empty().html("");  //清空列表数据
      
      $.ajax({
  		url: contextPath+"/businessconfig/numberform?dt="+(new Date().getTime()),
  		type : "get",
  		dataType: "json",
  		contentType: "application/json",
  		success: function(data) {
			var tktFormats = data[0].tktFormats ;  //获取号码模板里面的list值
	        $.each(tktFormats, function(index, item){
	          //表格序号自动递增
	  	      $windowNum = 0;
	  	      $tbody = $("#ccc tbody");
	  	      if ($tbody.find("tr:last"))
	  	      {
	  	        var num = $tbody.find("tr:last").find("td").eq(0).text();
	  	        if (num)
	  	        {
	  	          $windowNum = num;
	  	        }
	  	      }
	  	      $windowNum++;
	  	      
	  	      //返回的数据动态拼接到table中去
	  	      var $tr;
	  	      if (item){
	  	        $tr = $("<tr'>" +
	  					"<td>" + $windowNum + "</td>" +
	  					"<td>" + tktFormat2zhStr(item.tktFormat) + "</td>" +
	  					"<td>" +
	  						"<a class='btn btn-success' href='#' name='copyBtn' onclick='copyTr(this);'><i class='glyphicon glyphicon-zoom-in icon-white'></i> 复制</a> " +
	  						"<a class='btn btn-info' href='#' name='editBtn' onclick='editTr(this);'><i class='glyphicon glyphicon-edit icon-white'></i> 编辑</a> " +
	  						"<a class='btn btn-danger' href='#' name='delBtn' onclick='delTr(this);'><i class='glyphicon glyphicon-trash icon-white'></i> 删除</a>&nbsp;" +
	  					"</td>" +	
	  				   "</tr>");
	  	      } else{
	  	        $tr = $("<tr'>" +
	  					"<td>" + $windowNum + "</td>" +
	  					"<td>D</td>" +
	  					"<td><a class='btn btn-success' href='#' name='copyBtn' onclick='copyTr(this);'><i class='glyphicon glyphicon-zoom-in icon-white'></i> 复制</a> " +
	  					"<a class='btn btn-info' href='#' name='editBtn' onclick='editTr(this);'><i class='glyphicon glyphicon-edit icon-white'></i> 编辑</a> " +
	  					"<a class='btn btn-danger' href='#' name='delBtn' onclick='delTr(this);'><i class='glyphicon glyphicon-trash icon-white'></i> 删除</a>&nbsp;" +
	  				"</tr>");
	  	      }
	  	      $tr.data("itemData", item);
	  	      $tr.appendTo($tbody);
	        });
  		},
  		error: function(msg) {
  			qmsVld.showError("查询号码模板失败异常！"+msg);
  		}
	    })
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
            zhStr += "业务类型|";
          } else if (tktFormatArr[i] == "custPrefix")
          {
            zhStr += "客户等级|";
          } else
          {
            zhStr += tktFormatArr[i].length + "位流水";
          }
        }
      }
      return zhStr;
    }
 // 查询
    function searchCondition() {
    	loadDatas();
    }
 // 执行查询方法
    function loadDatas() {
    	 initPage();
    }
