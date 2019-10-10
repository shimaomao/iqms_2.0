var newCount = 1;
var zNodes = null;
var $orgDialog;
var zTreeObj ;


/**
 * 选择机构组织树
 * @param input  触发组织树的元素
 * @param showOrgNameFlag   true-设置机构名称到文本框   false-不设置机构名称到文本框
 * @param isCheckBox true-设置多选复选框 false-设置单选且只要设备节点可选 机构不可选
 * @param isButton true-存在查询按钮 false-不存在 点击确定 直接查询
 * @param defcallback   用户回调函数
 */
function selectOrgDeviceTree(orgId,showOrgNameFlag,isCheckBox,isButton,defcallback){
	//1.定义ztree的配置
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
									jQuery("#searchFrom").find("input[name=devName]").val(selNode.devName);
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


