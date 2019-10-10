	var params, bizTypeId, index, busType, map, printConfig;
    var $offsetX, $offsetY;
    var $ticket ;
    var groupType ;
    var $innerMap = null;
    var tabIndex = 0;
    var printX ;  //号票预览区域相对于视窗的左边距
    var printY ;  //号票预览区域相对于视窗的上边距
    var maxY = 0;
    var $lastSpan = null;
    var tktFormats = null;
    var $modalTitle ;
    var $tktFormatId ;
    var $tktTmpName ;
    var $def ;
    var $actionType ;
    var $tktTmpId ;
    var $myModal ;
    var $staticPath;
    var orgId = "";
    var deviceNo = "";
    var deviceName = "";
	$(function ()
    {	 
		
		//编辑页面点击返回时，带过来的参数，通过参数查询设备的票号信息   
		params = $.string(decodeURI(window.location.href)).toQueryParams(); //获取请求地址栏上的参数
		orgId = params["orgId"];  
		deviceNo = params["deviceNo"];
		deviceName = params["deviceName"];
		if((orgId != '' && orgId != null) &&
				(deviceNo != '' && deviceNo != null)
				&&((deviceName != '' && deviceName != null))){
			 jQuery("#searchFrom").find("input[name=orgId]").val(orgId);
	    	 jQuery("#searchFrom").find("input[name=deviceNo]").val(deviceNo);
	    	 jQuery("#searchFrom").find("input[name=devName]").val(deviceName);
	    	 searchCondition();
		}
		
		
		
		$ticket = $("#ticket");  //号票预览模板
	    groupType = "tickets";
	    printX = $ticket.get(0).getBoundingClientRect().left;  //获取号票预览区域相对于视窗的左边距
	    printY = $ticket.get(0).getBoundingClientRect().top;   //号票预览区域相对于视窗的上边距
	    $modalTitle = $("#modalTitle");  //模式对话框标题
	    $tktFormatId = $("#tktFormatId");  //号码模板id（select）
	    $tktTmpName = $("#tktTmpName"); //号码模板名称
	    $def = $("#def");              //是否默认模板
	    $actionType = $("#actionType");  //模式对话框的操作方式  （增删改查）
	    $tktTmpId = $("#tktTmpId");      //号票模板id
	    $myModal = $('#myModal');        //模式对话框id

	    $staticPath = $("#myhidden").val();  //static里面的地址
		
      $.metadata.setType("attr", "validate");  //设置验证规则的字段
      
      //表单绑定验证
      $("#frm").validate({
        onfocusout: function (element)
        {
          $(element).valid();
        },
        submitHandler: function (form)
        {
          modelSubmit();
          return false;
        }
      });

      //新增按钮
      $("#addBtn").click(function (e)
      {
        e.preventDefault();
        var itemData = {};
        showModal("new", itemData);
      });

      //关闭按钮(bootstrap 使用属性data-dismiss="modal"去关闭窗口)
      
      //按钮不可用
      disabledButton();
    });
	
	/**
	 * 设置新增按钮不可用
	 */
    function disabledButton()
    {
      $("#addBtn").attr('disabled', true);
      $("#CopyToOrg").attr('disabled', true);
    }
    
    /**
     * 设置新增按钮可用
     */
    function abledButton()
    {
      $("#addBtn").attr('disabled', false);
      $("#CopyToOrg").attr('disabled', false);
    }
    
    function orgDeviceTree(orgId){
		//清除验证信息
		$("div").removeClass("has-error");
		$("div").remove(".help-block");
    	//1.定义ztree的配置
    	var setting = {
                view: {
                    selectedMulti: true  //没有多选
                },
                check: {
                	enable: true,
            		chkStyle: "checkbox",
            		chkboxType: { "Y": "s", "N": "s" }
                },
                data: {
                	key:{
                		name:"devName"
                	},
                    simpleData: {    //使用简单机构组织树
                        enable: true,  //是否启用
                        idKey:"cId",  //元素id
                        pIdKey:"pId"  //父元素id
                    }
                }
            };
    	//ajax请求加载数据
    	 $.ajax({
            url : contextPath + "/businessconfig/ztreeorgdevice?dt="+(new Date().getTime()),
            type : "get",
            dataType : "json",
            contentType : "application/json",
            data : {"orgId":orgId},
            success : function(datas)
            {
           	 var zNodes = datas.rows;
           	 
           	 zTreeObj = $.fn.zTree.init($("#orgTree"), setting, zNodes);
    			var title = "";
    			
    			title = '<i class="ace-icon fa fa-sitemap bigger-200 "></i><span class="ui-jqdialog-title" style="float: left;"> 机构选择</span>';
    			//打开对话框
    			$orgDialog = $("#dialog-org").removeClass("hide").dialog({
    				modal: true, //模式对话框
    				title: title,
    				title_html: true,
    				width:"380",
    				height:"450",
    				buttons: [{
    					html: '<i class="ace-icon fa fa-times"></i>取消', //按钮文本
    					"class": "btn btn-minier",
    					click: function() {
    						//关闭窗口
    						$(this).dialog("close");
    					}
    				}, {
    					html: '<i class="ace-icon fa fa-check"></i>确定',
    					"class": "btn btn-primary btn-minier",
    					click: function() {
    						//获取被勾选的节点的值
    						var selNodes = zTreeObj.getCheckedNodes(true);
    						if (selNodes != null && selNodes.length > 0){
    							var selNode = selNodes[0];
    							var orgDevicelist = '';
    							for(var i=0;i<selNodes.length;i++){
    								orgDevicelist += selNodes[i].devName + ","+selNodes[i].cId+","+selNodes[i].pId+";"
    							}
    							$("#orgDevicelist").val(orgDevicelist);
    						}
    						$(this).dialog("close");
    						copyToOrg();
    					}
    				}]
    			});
            }
    	 });
    	 
    }
    //应用到下级机构
    function copyToOrg(){
    	if($("#orgDevicelist").val()!="" && $("#orgDevicelist").val()!=null){
    		var jc = $.confirm({
    	        title: '应用到下级机构',
    	        icon: 'fa fa-warning red',
    	        theme:'bootstrap',
    	        content: '将清空所选下级机构的号票模板，确定要应用吗?',
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
    	                	var data = {};
    	                	data.orgId = orgId;
    	                	data.deviceNo = deviceNo;
    	                	data.orgDevicelist = $("#orgDevicelist").val();
    	                	var url = contextPath + "/businessconfig/copyticketform?dt="+(new Date().getTime());
    		           	     $.post(url, data, function(result)
    		           	     {
    		           	         if (result.errorCode == '0')
    		           	         {
    		           	        	//弹出对话框
    		           	         	$.alert({
    		           	                 title: '提示信息',
    		           	                 icon:'fa fa-info-circle blue',
    		           	                 theme:'bootstrap',
    		           	                 content: '应用到下级机构成功',
    		           	                 closeIcon: true,
    		           	                 buttons:{
    		           	                 	 colseWin: {
    		           	                      	text: '<i class="ace-icon fa fa-times"></i>关闭',
    		           	                          btnClass: 'btn-info'
    		           	                      }
    		           	                 }
    		           	             });
    		           	            //刷新列表
    		           	            searchCondition();
    		           	            $newDialog.dialog("close");//关闭窗口
    		           	         }
    		           	         else
    		           	         {
    		           	        	 $.alert({
    		           	                 title: '提示信息',
    		           	                 icon:'fa fa-info-circle red',
    		           	                 theme:'bootstrap',
    		           	                 content: '应用到下级机构失败',
    		           	                 closeIcon: true,
    		           	                 buttons:{
    		           	                 	 colseWin: {
    		           	                      	text: '<i class="ace-icon fa fa-times"></i>关闭',
    		           	                          btnClass: 'btn-info'
    		           	                      }
    		           	                 }
    		           	             });
    		           	         }
    		           	     }, "json");
    	                }
    	            }
    	        }
    	    });
    	}else{
    		qmsVld.showError("请先选择要应用的下级机构");
    	    return false;
    	}
    }
    
    /**
     * 拷贝配置
     * @param obj
     */
	function copyTr(obj)
    {
      $tr = $(obj).parent().parent();
      showModal("copy", $tr.data("itemData"));
    }
	
	/**
	 * 编辑
	 * @param obj
	 */
    function editTr(obj)
    {
      $tr = $(obj).parent().parent();
      showModal("update", $tr.data("itemData"));

    }

    /**
     * 删除号票模板
     * @param obj
     */
    function delTr(obj){
    	 var jc = $.confirm({
 	        title: '号票模板删除',
 	        icon: 'fa fa-warning red',
 	        theme:'bootstrap',
 	        content: '确定要删除该号码模板吗？引用此号码模板的关联配置也将删除',
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
	 	                  args.tktTmpId = $tr.data("itemData").tktTmpId;
	 	                  var tktTmpId = args.tktTmpId;
	 	                   
	 	                  $.ajax({
	 	              		url: contextPath+"/businessconfig/ticketform?ftype=delete&_method=get",
	 	              		type : "get",
	 	              		dataType: "json",
	 	              		contentType: "application/json",
	 	              		data:{
	 	              			  "tktTmpId":tktTmpId,
	 	              			  "orgId":orgId,
	 	            			  "deviceNo":deviceNo
	 	              			 },
	 	              		success: function(data) {
	 	          			      if (data.errorCode == 0)
	 	          			      {
	 	          			        qmsVld.showInfo("删除号票模板成功！");
	 	          			        initPage();//新增、拷贝、编辑完成后关闭模态框，查询号码模板，然后展示
	 	          			      }else if (data.errorCode == 1){
	 	          			    	qmsVld.showError("默认号票模板不可删除！");
	 	          			      } else
	 	          			      {
	 	          			        qmsVld.showError("删除号票模板失败！");
	 	          			      }
	 	              		},
	 	              		error: function(msg) {
	 	              			qmsVld.showError("出错了！"+msg);
	 	              		}
	 	          	      });
 	                    
 	                }
 	            }
 	        }
 	    });
    }
    
    /**
     * 
     * @param select
     * @param jsonObj
     * @param iniValue
     */
    function chose_ini_tktFormat(select, jsonObj, iniValue)
    {
      //alert($.toJSON(jsonObj));
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
     * 增删改,对话框  
     * @param type
     * @param itemData
     */
    function showModal(type, itemData)
    {
      $("#frm input").popover('hide');
      $("#frm input").parent().removeClass("has-error");

		//清除验证信息
		$("div").removeClass("has-error");
		$("div").remove(".help-block");


      var tktFormatId = null;  //号票模板id

      if (itemData && itemData.tktFormatId)
      {
        $tktFormatId.val(itemData.tktFormatId);  //设置号票模板id
      }

      if (type == "new")
      {
        $modalTitle.text("模板新增");
        $tktTmpId.val(0);
        $tktTmpName.val("");//设置默认模板名称为空
        getNumberForm();//ajxa获取号码模板,生成号码模板select元素
      } else if (type == "copy")
      {
        $modalTitle.text("模板复制");
        $tktTmpId.val(itemData.tktTmpId);
        $tktTmpName.val(itemData.tktTmpName);
        parseInt(itemData.def) ? $def.prop("checked", true) : $def.prop("checked", false);
        getNumberForm2(itemData);
      } else if (type == "update")
      {
        $modalTitle.text("模板修改");
        $tktTmpId.val(itemData.tktTmpId);
        $tktTmpName.val(itemData.tktTmpName);
        parseInt(itemData.def) ? $def.prop("checked", true) : $def.prop("checked", false);
        getNumberForm2(itemData);
      }
      $actionType.val(type);
      $myModal.modal('show');
    }
    
    /**
     * 查询所有的号码模板，生成号码模板select项
     */
    function getNumberForm(){
    	$tktFormatId.empty().html("");
    	$.ajax({
	   		url: contextPath+"/businessconfig/numberform?dt="+(new Date().getTime()), 
	   		type : "get",
	   		dataType: "json",
	   		contentType: "application/json",
	   		success: function(data) {
	   			var tktFormats = data[0].tktFormats ;
	   			var $fristoption = $('<option value="" >请选择一个号码模板</option>');
   				$fristoption.appendTo($tktFormatId);
   				
   				//遍历号码模板
	   			$.each(tktFormats,function(index,item){
	   				var NewtktFormat = tktFormat2zhStr(item.tktFormat);  //转换号码模板内容，
	   				var tktFormat = NewtktFormat;
	   				var tktFormatId =item.tktFormatId;
	   				var $option = $('<option value=\" '+ tktFormatId +'\">' + tktFormat +'</option>' );
	   				$option.appendTo($tktFormatId); 
	   			})
	   		},
	   		error: function(msg) {
	   			qmsVld.showError("出错了！");
	   		} 
	   	})
    }
    
    /**
     * 加载弹出框中号码模板，同时设置初始值
     * @param itemData
     */
    function getNumberForm2(itemData){
    	$tktFormatId.empty().html("");
    	$.ajax({
	   		url: contextPath+"/businessconfig/numberform?dt="+(new Date().getTime()), 
	   		type : "get",
	   		dataType: "json",
	   		//data :{"orgId":orgId,"deviceNo":deviceNo},
	   		contentType: "application/json",
	   		success: function(data) {
	   			var tktFormats = data[0].tktFormats ;
	   			var $fristoption = $('<option value="" >请选择一个号码模板</option>');
   				$fristoption.appendTo($tktFormatId);
   				
	   			$.each(tktFormats,function(index,item){
	   				var NewtktFormat = tktFormat2zhStr(item.tktFormat);
	   				var tktFormat = NewtktFormat;
	   				var tktFormatId =item.tktFormatId;
	   				var $option = $('<option value=\" '+ tktFormatId +'\">' + tktFormat +'</option>' );
	   				$option.appendTo($tktFormatId);
	   			})
	   			
	   			//给对应的option赋属性selected:selected
	   			$("#tktFormatId option").each(function(){ 
		        	if($.trim($(this).val())== itemData.tktFormatId){
		        		$(this).attr("selected",true);
		        	}else{
		        		$(this).attr("selected",false);
		        	}
		        })
	   		},
	   		error: function(msg) {
	   			qmsVld.showError("出错了！");
	   		} 
	   	})
    }
    
    /**
     * 提交保存
     * @param obj
     */
    function modelSubmit(obj)
    {
      $("#myModal input").parent().removeClass("has-error");
      var type = $actionType.val();  //操作类型
      var jo = {};
      jo.tktTmpName = $tktTmpName.val();//模板名称
      jo.def = $def.prop("checked");//复选框选择是否为默认模板
      jo.tktFormatId = $tktFormatId.val();//选中的号码模板字符串值的ID号
      var tktFormatId = $.trim(jo.tktFormatId);
      jo.tktFormat = $tktFormatId.find("option:selected").text();///选中的号码模板的字符串值
      var tktFormat = zhStr2tktFormat(jo.tktFormat);//号码模板中文内容
      
      if (type == "new")
      {
        jo.tktTmpId = "";//给号票模板设置一个默认id为空
        
        $.ajax({
    		url: contextPath+"/businessconfig/ticketform?ftype=add&_method=get",
    		type : "get",
    		dataType: "json",
    		contentType: "application/json",
    		data:{"tktTmpId": jo.tktTmpId,
    			  "tktTmpName": jo.tktTmpName,
    			  "def":jo.def,
    			  "tktFormatId":tktFormatId,
    			  "tktFormat":tktFormat,
    			  "orgId":orgId,
      			  "deviceNo":deviceNo
    			 },
    		success: function(data) {
    			  //alert($.toJSON(data));
			      if (data.errorCode == 0)
			      {
			        qmsVld.showInfo("新增号票模板成功");
			        initPage();//新增、拷贝、编辑完成后关闭模态框，查询号码模板，然后展示
			      } else
			      {
			        qmsVld.showError("新增号票模板失败！已存在相同名称的模板,请重新添加");
			      }
    		},
    		error: function(msg) {
    			qmsVld.showError("出错了！"+msg);
    		}
	      })

      } else if (type == "copy") {  //拷贝新增
        var tmpTktTmpId = $tktTmpId.val();
        
        $.ajax({
    		url: contextPath+"/businessconfig/ticketform?ftype=add&_method=get",
    		type : "get",
    		dataType: "json",
    		contentType: "application/json",
    		data:{"tktTmpId": jo.tktTmpId,
    			  "tktTmpName": jo.tktTmpName,
    			  "def":jo.def,
    			  "tktFormatId":tktFormatId,
    			  "tktFormat":tktFormat
    			 },
    		success: function(data) {
    			  //alert($.toJSON(data));
			      if (data.errorCode == 0)
			      {
			        qmsVld.showInfo("复制新增号票模板成功");
			        initPage();//新增、拷贝、编辑完成后关闭模态框，查询号码模板，然后展示
			      } else
			      {
			        qmsVld.showError("复制新增号票模板失败！已存在相同名称的模板！");
			      }
    		},
    		error: function(msg) {
    			qmsVld.showError("出错了！"+msg);
    		}
	      })

      } else if (type == "update")  //更新
      {
        jo.tktTmpId = $tktTmpId.val();  //号票id

        $.ajax({
    		url: contextPath+"/businessconfig/ticketform?ftype=update&_method=get",
    		type : "get",
    		dataType: "json",
    		contentType: "application/json",
    		data:{"tktTmpId": jo.tktTmpId,
  			  	  "tktTmpName": jo.tktTmpName,
  			      "def":jo.def,
  			      "tktFormatId":tktFormatId,
  			      "tktFormat":tktFormat,
  			      "orgId":orgId,
    			  "deviceNo":deviceNo
  			     },
    		success: function(data) {
    			  //alert($.toJSON(data));
			      if (data.errorCode == 0)
			      {
			        qmsVld.showInfo("修改号票模板成功");
			        initPage();//新增、拷贝、编辑完成后关闭模态框，查询号码模板，然后展示
			      } else
			      {
			        qmsVld.showError("修改号票模板失败！已存在相同名称的模板,请重新修改");
			      }
    		},
    		error: function(msg) {
    			qmsVld.showError("出错了！"+msg);
    		}
	      })
      }
    }

    
    /**
     * 初始化号票模板界面
     */
    function initPage()
    {
      $('#myModal').modal('hide');  //隐藏弹出框
      $("#ccc").find("tbody").empty().html("");  //清空号票模板界面
      
      $.ajax({
  		url: contextPath+"/businessconfig/ticketform?dt="+(new Date().getTime()),
  		type : "get",
  		dataType: "json",
  		data :{"orgId":orgId,"deviceNo":deviceNo},
  		contentType: "application/json",
  		success: function(data) {
  			abledButton();  //按钮激活
			var tktFormats = data[0].tktFormats ;  //号票模板
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
	  	        $tr = $("<tr onclick='preview(this);'>" +  //点击就是玉兰
	  					"<td>" + $windowNum + "</td>" +    //序号
	  					"<td>" + item.tktTmpName + "</td>" +  //号票模板名称
	  					"<td>" + (parseInt(item.def) ? "是" : "否") + "</td>" +   //是否默认模板
	  					"<td>" +
	  						"<a class='btn btn-info' href='#' name='editBtn' onclick='editTr(this);'><i class='glyphicon glyphicon-edit icon-white'></i> 编辑</a> " +
	  						"<a class='btn btn-danger' href='#' name='delBtn' onclick='delTr(this);'><i class='glyphicon glyphicon-trash icon-white'></i> 删除</a>&nbsp;" +
	  						"<a class='btn btn-inverse' href='#' name='infoBtn' onclick='infoTr(this);'><i class='glyphicon glyphicon-list-alt icon-white'></i> 配置</a>&nbsp;" +
	  					"</td>" +	
	  				   "</tr>");
	  	      } else{  //无数据项的时候
	  	        $tr = $("<tr onclick='preview(this);'>" +
	  					"<td>" + $windowNum + "</td>" +
	  					"<td>D</td>" +
	  					"<td>否</td>" +
	  					"<td>"+ 
	  					"<a class='btn btn-info' href='#' name='editBtn' onclick='editTr(this);'><i class='glyphicon glyphicon-edit icon-white'></i> 编辑</a> " +
	  					"<a class='btn btn-danger' href='#' name='delBtn' onclick='delTr(this);'><i class='glyphicon glyphicon-trash icon-white'></i> 删除</a>&nbsp;" +
	  					"<a class='btn btn-inverse' href='#' name='infoBtn' onclick='infoTr(this);'><i class='glyphicon glyphicon-list-alt icon-white'></i> 配置</a>&nbsp;" +
	  				"</tr>");
	  	      }
	  	      $tr.data("itemData", item);  //原始数据
	  	      $tr.appendTo($tbody);
	        });
	        
	        //加载第一个号票模板
	        var $trs = $("#ccc").find("tr");
	        if ($trs)
	        {
	          preview($trs.eq(1).get(0));
	        }
  		},
  		error: function(msg) {
  			qmsVld.showError("出错了！"+msg);
  		}
	    })
    }
    
    /**
     * 号票预览
     * @param obj
     */
    function preview(obj)
    {
      var jo = {};
      var itemData = $(obj).data("itemData");  //号票里面一行的数据
      
      if (itemData){
	        $("#tktName").text(itemData.tktTmpName);
	        jo.tktTmpId = itemData.tktTmpId;
	        
	        var tktTmpStyle = itemData.tktTmpStyle;
	        if (tktTmpStyle){  //号票模板样式
	    	  var rlt = JSON.parse(tktTmpStyle) ;//json字符串转json对象
		      printConfig = rlt.print;  //号票模板内容
		      var $spn = null;
		      $ticket.empty().html("");
		      $innerMap = null;
		      if (printConfig)
		      {
		        $innerMap = $("<div></div>");
		        //var src = null;
		        //$innerMap.css("position", "absolute").css("width", 310).css("height", 500).css("background-image", "url(" + src + ")");
		        $innerMap.css("position", "absolute").css("width", 310).css("height", 500);
	
		        $innerMap.appendTo($ticket);
		        //初始化预览页
		        $.each(printConfig.items, function (index, item)
		        {
		          $spn = $("<span type='prt-" + item.type + "' tabindex='" + tabIndex + "'></span>").css("position", "absolute").css("top", item.y + "px").css("left", item.x + "px");
		          tabIndex++;
		          $spn.data("itemData", item);
		          initItemStyle($spn.get(0));
	
		          if (maxY < item.y)
		          {
		            maxY = item.y;//最后一个元素的y坐标
		            $lastSpan = $spn;
		          }
	
		          $spn.appendTo($innerMap);
		        });
		      }
		      changeTicketDivHeight();
	        } else {
	          qmsVld.showInfo("该号票样式为空！");
	          //by hongxz 20170928清空预览内容
	          $ticket.empty().html("");
	        }
        }
    }
    
    
    /**
     * 进入编辑详情页面
     * @param obj
     */
    function infoTr(obj){
    	
    	 deviceName  = jQuery("#searchFrom").find("input[name=devName]").val();
    	 
    	 //alert(deviceName);
    	
	      var itemData = $(obj).parent().parent().data("itemData");
	      window.location.href = encodeURI(contextPath+"/businessconfig/ticketform/edit?" 
	      +"tktTmpId=" + itemData.tktTmpId    //模板id
	      + "&tktTmpName=" + itemData.tktTmpName   //模板名称
	      + "&orgId=" + itemData.orgId   //机构id
	      + "&deviceNo=" + itemData.deviceNo   //设备编号
	      + "&deviceName=" + deviceName   //设备名称
	      + "&screenResolution=" + itemData.screenResolution);   //设备分辨率
    }

  
    /**
     * 转换号码模板内容
     * @param tktFormat
     * @returns {String}
     */
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
    
    //中文转英文
    function zhStr2tktFormat(tktFormat)
    {
      var zhStr = "";
      var tktFormatArr = tktFormat.split("|");
      
      //最后一位肯定是流水(不能固定是2) by hongxz 20171212
      var liushui = tktFormatArr[tktFormatArr.length-1].substring(0,1); //获取流水位数
      
      if (tktFormat.length > 1)
      {
        for (var i = 0; i < tktFormatArr.length; i++)
        {
          if (tktFormatArr[i] == "业务类型")
          {
            zhStr += "tktPrefix|";
          } else if (tktFormatArr[i] == "客户等级")
          {
            zhStr += "custPrefix|";
          } else
          {
            for (var i = 0; i < liushui; i++) {
            	zhStr += "0"*i;
			}
          }
        }
      }
      return zhStr;
    }
    
    function initItemStyle(obj)
    {
      var item = $(obj).data("itemData");
      var $spn = $(obj);
      if (item.type == "logo")
      {
        $spn.empty().html("<img style=\"display:block;width:183px;height:44px;\" src=' " + $staticPath +"/static/components/ticket/images/logo2.png'>");
      } else
      {
        $spn.empty().html("<label>" + item.text + "</label>");
      }
      var $label = $spn.find("label");
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
        $spn.css("width", item.width + "px").css("word-break", "break-all");
      }
      else
      {
        $spn.css("width", item.width + "px").css("word-break", "keep-all");
      }
    }

    //动态改变号票画板的高度
    function changeTicketDivHeight()
    {

      var tmpHeight = maxY + 50;//最后一个元素的y坐标+50
      if ($lastSpan)
      {
        tmpHeight = tmpHeight + $lastSpan.get(0).offsetHeight;//加上最后一个元素的offsetHeight
      }
      $ticket.css("height", tmpHeight);
      if ($innerMap) $innerMap.css("height", tmpHeight);
    }

 // 查询
    function searchCondition() {
    	loadDatas();
    }
 // 执行查询方法
    function loadDatas() {
    	// 获取参数对象
    	 orgId = jQuery("#searchFrom").find("input[name=orgId]").val();
    	 deviceNo = jQuery("#searchFrom").find("input[name=deviceNo]").val();
    	 initPage();
    }
