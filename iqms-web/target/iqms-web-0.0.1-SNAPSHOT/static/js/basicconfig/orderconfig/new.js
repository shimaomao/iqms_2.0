var $newDialog;

$(function(){
	
	//form绑定验证框架
	 $("#dialog-new").find("form").validate({
		errorElement: 'div',   //错误信息包装元素
		errorClass: 'help-block', //错误的样式
		focusInvalid: false, //提交表单后未通过验证的表单会获得焦点
		ignore: "", //对某些元素不进行验证
		rules: { //验证规则
			devName:{
				required: true
			},
			beginTime:{
				required: true
			},
			endTime: {   //验证的字段
				required: true
			},
			orderCount:{
				required: true,
				maxlength: 3,
				sz:true
			}
		},

		highlight: function (e) { //未通过验证的元素增加效果
			$(e).closest('.form-group').removeClass('has-info').addClass('has-error');
		},

		success: function (e) { //验证成功需要执行的函数
			$(e).closest('.form-group').removeClass('has-error');//.addClass('has-info');
			$(e).remove();
		},

		errorPlacement: function (error, element) { //指定错误信息存放位置
			if(element.is('input[type=checkbox]') || element.is('input[type=radio]')) {
				var controls = element.closest('div[class*="col-"]');
				if(controls.find(':checkbox,:radio').length > 1) controls.append(error);
				else error.insertAfter(element.nextAll('.lbl:eq(0)').eq(0));
			}
			else if(element.is('.select2')) {
				error.insertAfter(element.siblings('[class*="select2-container"]:eq(0)'));
			}
			else if(element.is('.chosen-select')) {
				error.insertAfter(element.siblings('[class*="chosen-container"]:eq(0)'));
			} else {
				error.insertAfter(element.parent());
			}
				
		}

	});
	
	 $("input[name= 'beginTime']").datetimepicker({
	        format: 'hh:ii',
	        language: 'zh-CN',
	        minuteStep: 1,
	        maxView: 0,
	        autoclose: true,
	        startView: 1,
	        todayBtn: 1,
	        todayHighlight: 1
	      });


	      $("input[name='endTime']").datetimepicker({
	        format: 'hh:ii',
	        language: 'zh-CN',
	        minuteStep: 1,
	        maxView: 0,
	        autoclose: true,
	        startView: 1,
	        todayBtn: 1,
	        todayHighlight: 1
	      });
});

/**
 * 生成设备选择树
 * @param input  触发组织树的元素
 * @param showOrgNameFlag   true-设置机构名称到文本框   false-不设置机构名称到文本框
 * @param isCheckBox true-设置多选复选框 false-设置单选且只要设备节点可选 机构不可选
 * @param isButton true-存在查询按钮 false-不存在 点击确定 直接查询
 * @param defcallback   用户回调函数
 */
function createDevTree(orgId,showOrgNameFlag,isCheckBox,isButton,defcallback){
	var setting = {
            view: {
                selectedMulti: true  //没有多选
            },
            check: {
            	enable: true,
        		chkStyle: "checkbox",
        		chkboxType: { "Y": "s", "N": "s" },
        		radioType: "all" //设置单选
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
            },
            callback: { 
            	onClick: function (e, treeId, treeNode, clickFlag) { 
            		zTreeObj.checkNode(treeNode, !treeNode.checked, true); 
            		//展开、折叠节点
            		if(!zTreeObj.expandNode(treeNode, true, false, false)){
        				zTreeObj.expandNode(treeNode, false, false, false);
        			}
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
        	 
        	//初始化机构树
        	 if(!isCheckBox){
        		 setting.check.chkStyle="radio";
        		 zTreeObj = $.fn.zTree.init($("#orgTree"), setting, zNodes);
        		 var selNodes = zTreeObj.getCheckedNodes(false);
        		 for (var i = 0; i < selNodes.length; i++) {
        			 var node = selNodes[i];
        			 if((JSON.stringify(node.cId)).indexOf("D")>0){
        				 node.nocheck = false;
        			 }else{
        				 node.nocheck = true;
        			 }
        			 zTreeObj.updateNode(node);
        		 }
        	 }else{
        		 zTreeObj = $.fn.zTree.init($("#orgTree"), setting, zNodes);
        	 }
 			var title = "";
 			if(!isCheckBox){
 				title = '<i class="ace-icon fa fa-sitemap bigger-200 "></i><span class="ui-jqdialog-title" style="float: left;"> 设备选择</span>';
 			}else{
 				title = '<i class="ace-icon fa fa-sitemap bigger-200 "></i><span class="ui-jqdialog-title" style="float: left;"> 机构选择</span>';
 			}
 			//打开对话框
 			$orgDialog = $("#dialog-org").removeClass("hide").dialog({
				modal: true, //模式对话框
				title: title,
				title_html: true,
				width:"450",
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
						if(!isCheckBox){
							if(selNodes == null || selNodes.length == 0){
								$.alert({
					                 title: '提示信息',
					                 icon:'fa fa-info-circle red',
					                 theme:'bootstrap',
					                 content: '请选择设备！',
					                 closeIcon: true,
					                 buttons:{
					                 	 colseWin: {
					                      	text: '<i class="ace-icon fa fa-times"></i>关闭',
					                          btnClass: 'btn-info'
					                      }
					                 }
					             });
							}
						}
						if (selNodes != null && selNodes.length > 0){
							var selNode = selNodes[0];
							for(var i = 0; i<zNodes.length; i++){
								if(selNode.pId == zNodes[i].cId){
									$("#orgName").val(zNodes[i].devName);
								}
							}
							if (showOrgNameFlag) {
								if(!isCheckBox){
									$("#devName").val(selNode.devName);
									jQuery("#new").find("input[name=devName]").val(selNode.devName);
									jQuery("#new").find("input[name=orgId]").val(selNode.pId);
									jQuery("#new").find("input[name=deviceNo]").val(selNode.deviceNo);
								}else{
									if($("#devName1").length > 0){
										$("#devName1").val(selNode.devName);
										jQuery("#searchFrom").find("input[name=devName1]").val(selNode.devName);
									}
								}
		        			}
							if(!isCheckBox){
								$("#orgId").val(selNode.pId);
								jQuery("#searchFrom").find("input[name=deviceNo]").val(selNode.deviceNo);
							}
							var orgDevicelist = '';
							for(var i=0;i<selNodes.length;i++){
								orgDevicelist += selNodes[i].devName + ","+selNodes[i].cId+","+selNodes[i].pId+";"
							}
							if(showOrgNameFlag&&isCheckBox){
								//选中的节点的值赋到new.jsp里
								$("#orgDevicelist").val(orgDevicelist);
							}
							if (defcallback)
				            {
								defcallback();
				            }
							//searchCondition();
						}
						$(this).dialog("close");
					}
				}]
			});
         }
	 });
}

/**
 * 新增客户类型
 */
function newOrder()
{
	
	//绑定对话框
	$newDialog = $("#dialog-new").removeClass("hide").dialog({
		modal: true, //模式对话框
		title: '<i class="ace-icon fa fa-pencil-square-o bigger-250"></i><span class="ui-jqdialog-title" style="float: left;"> 新增</span>',
		title_html: true,
		width:"400",
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
				//保存数据
				save();
			}
		}],
		open:function(){ //加载数据
			
			//清理数据之前，先记录原先的机构id和机构名称，清理之后，再填充回去
//			var tmpOrgId = $("#dialog-new").find("form").find("input[name=orgId]").val();
//			var tmpOrgName = $("#dialog-new").find("form").find("input[name=orgName]").val();

			//清除验证信息
			$("div").removeClass("has-error");
			$("div").remove(".help-block");


			//清空上一次的表单数据
			$("#dialog-new").find("form").clearForm(true);
			
			//回填值
//			$("#dialog-new").find("form").find("input[name=orgId]").val(tmpOrgId);
//			$("#dialog-new").find("form").find("input[name=orgName]").val(tmpOrgName);
		}
	});
}

/**
 * 保存记录
 */
function save(){
	 
	//1.验证失败
	 if (!$("#dialog-new").find("form").valid()){
		 return ;
	 }
	 
	 
	 var formjson = $("#dialog-new").find("form").serialize();
	 var url = contextPath + "/basicconfig/orderconfig?dt="+(new Date().getTime());
     $.post(url, formjson, function(result)
     {
         if (result.errorCode == '0')
         {
        	//弹出对话框
         	$.alert({
                 title: '提示信息',
                 icon:'fa fa-info-circle blue',
                 theme:'bootstrap',
                 content: '预约配置添加成功',
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
         else if (result.errorCode == '1')
         {
        	 $.alert({
                 title: '提示信息',
                 icon:'fa fa-info-circle red',
                 theme:'bootstrap',
                 content: '开始时间已存在',
                 closeIcon: true,
                 buttons:{
                 	 colseWin: {
                      	text: '<i class="ace-icon fa fa-times"></i>关闭',
                          btnClass: 'btn-info'
                      }
                 }
             });
         }
         else if (result.errorCode == '2')
         {
        	 $.alert({
                 title: '提示信息',
                 icon:'fa fa-info-circle red',
                 theme:'bootstrap',
                 content: '结束时间已存在',
                 closeIcon: true,
                 buttons:{
                 	 colseWin: {
                      	text: '<i class="ace-icon fa fa-times"></i>关闭',
                          btnClass: 'btn-info'
                      }
                 }
             });
         }
         else if (result.errorCode == '3')
         {
        	 $.alert({
                 title: '提示信息',
                 icon:'fa fa-info-circle red',
                 theme:'bootstrap',
                 content: '时间段重叠',
                 closeIcon: true,
                 buttons:{
                 	 colseWin: {
                      	text: '<i class="ace-icon fa fa-times"></i>关闭',
                          btnClass: 'btn-info'
                      }
                 }
             });
         }else if (result.errorCode == '5')
         {
        	 $.alert({
                 title: '提示信息',
                 icon:'fa fa-info-circle red',
                 theme:'bootstrap',
                 content: '开始时间必须小于结束时间',
                 closeIcon: true,
                 buttons:{
                 	 colseWin: {
                      	text: '<i class="ace-icon fa fa-times"></i>关闭',
                          btnClass: 'btn-info'
                      }
                 }
             });
         }else{
        	 $.alert({
                 title: '提示信息',
                 icon:'fa fa-info-circle red',
                 theme:'bootstrap',
                 content: '预约配置添加失败',
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
