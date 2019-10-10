var newCount = 1;
var zNodes = null;
var $orgDialog;
var zTreeObj ;

/**
 * 选择机构组织树
 * @param input  触发组织树的元素
 * @param showOrgNameFlag   true-设置机构名称到文本框   false-不设置机构名称到文本框
 * 
 * @param defcallback   用户回调函数
 */
function selectOrgTree(input,showOrgNameFlag,defcallback){
	
	//获取下一个元素（固定机构id）
	var $name = $(input);  //当前元素
	var $id = $(input).next(); //下一个元素
	
	//1.定义ztree的配置
	var setting = {
            view: {
                selectedMulti: false  //没有多选
            },
            check: {
                enable: false  //没有复选框
            },
            data: {
            	key:{
            		name:"orgName"
            	},
                simpleData: {    //使用简单机构组织树
                    enable: true,  //是否启用
                    idKey:"orgId",  //元素id
                    pIdKey:"parentId"  //父元素id
                }
            },
            callback: {  //配置回调函数
        		onDblClick: function(event,treeId,treeNode){  //双击的回调
        			//alert("机构id："+treeNode.orgId+" 机构名称："+treeNode.orgName+" 排序："+treeNode.sortNum);
        			$id.val(selNode.orgId);
        			if (showOrgNameFlag) {
        				$name.val(selNode.orgName);
        			}
					//存在回调函数执行回调
					if (defcallback)
		            {
						defcallback(treeNode);
		            }
        			$orgDialog.dialog("close");
        		},
        		onClick:function(event,treeId,treeNode){  //双击的回调
        			if(!zTreeObj.expandNode(treeNode, true, false, false)){
        				zTreeObj.expandNode(treeNode, false, false, false);
        			}
        		}
        	}
        };
	
	//ajax请求加载数据
	 $.ajax({
         url : contextPath + "/basicconfig/parameter/ztree?dt="+(new Date().getTime()),
         type : "get",
         dataType : "json",
         data:{"orgId":orgIdTemp},
         contentType : "application/json",
         //data : $.toJSON(list),
         success : function(datas)
         {
        	 var zNodes = datas;
        	//初始化机构树
        	 zTreeObj = $.fn.zTree.init($("#orgTree"), setting, zNodes);
 			
 			//打开对话框
 			$orgDialog = $("#dialog-org").removeClass("hide").dialog({
				modal: true, //模式对话框
				title: '<i class="ace-icon fa fa-sitemap bigger-200 "></i><span class="ui-jqdialog-title" style="float: left;"> 机构选择</span>',
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
						//获取选中节点的值
						var selNodes = zTreeObj.getSelectedNodes();
						if (selNodes != null && selNodes.length > 0){
							//
							var selNode = selNodes[0];
							//设置选择的值
							$id.val(selNode.orgId);
							//s是否文本框中显示机构名称，调整柜员机构等是按钮触发时不需要
							if (showOrgNameFlag) {
		        				$name.val(selNode.orgName);
		        			}
							//存在回调函数执行回调
							if (defcallback)
				            {
								defcallback(selNode);
				            }
						}
						
						
						
						$(this).dialog("close");
					}
				}],
				open:function(){ //展示选中的节点
					
					//设置显示的位置
					var pDialog = $(this).closest(".ui-dialog").css("z-index",9999);
					//alert(pDialog);
					
					//打开选中的节点
					var selNodeId = $id.val();
					//alert("选中的节点值"+selNodeId);
					//查找树中的此节点
					var selNode = zTreeObj.getNodeByParam("orgId",selNodeId , null);
					//选中此节点
					if (selNode != null){
						zTreeObj.selectNode(selNode);
						//zTreeObj.expandNode(selNode, true, true, true);
					}
				}
			});
         }
	 });
}


