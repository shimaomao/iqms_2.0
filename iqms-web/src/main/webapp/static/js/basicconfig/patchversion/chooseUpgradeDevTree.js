var $chooseUpgradeDevDialog;
var zTreeDevObj ;

/**
 * 选择可升级的设备
 * @param patchId
 */
function chooseUpgradeDevTree(patchId){
	
	//1.定义ztree的配置
	var setting = {
            view: {
                selectedMulti: true  //多选
            },
            check: {
                enable: true  //没有复选框
            },
            data: {
            	key:{
            		name:"devName"
            	},
                simpleData: {    //使用简单机构组织树
                    enable: true,  //是否启用
                    idKey:"id",  //元素id
                    pIdKey:"pid"  //父元素id
                }
            }
        };
	
	//获取当前用户的id
	var userOrgId = $("#userOrgId").val();
	
	//ajax请求加载数据
	 $.ajax({
         url : contextPath + "/businessconfig/deviceconfig/devtree?orgId="+userOrgId+"&patchId="+patchId+"&dt="+(new Date().getTime()),
         type : "get",
         dataType : "json",
         contentType : "application/json",
         //data : $.toJSON(jsonData),
         success : function(datas)
         {
        	 var zNodes = datas;
        	//初始化机构树
        	 zTreeDevObj = $.fn.zTree.init($("#devUpgradeTree"), setting, zNodes);
 			
 			//打开对话框
 			$chooseUpgradeDevDialog = $("#dialog-devtree").removeClass("hide").dialog({
				modal: true, //模式对话框
				title: '<i class="ace-icon fa fa-sitemap bigger-200 "></i><span class="ui-jqdialog-title" style="float: left;"> 设备选择</span>',
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
						//获取checked的节点
						var selNodes = zTreeDevObj.getCheckedNodes(true);
						if (selNodes != null && selNodes.length > 0){
							
							var list = [];
							for (var i = 0 ; i < selNodes.length; i++){
								var selNode = selNodes[i];
								if (selNode.deviceNo != null){
									list.push(selNode.deviceNo);
								}
							}
							
							//封装完成设备编码，提交到后台进行升级
							var postData = $.toJSON(list);

						    $.ajax(
						    {
						        url : contextPath + "/basicconfig/patchdeviceapply/"+patchId+"?tt="+(new Date().getTime()),
						        type : "post",
						        dataType : "json",
						        contentType : "application/json",
						        data : postData,
						        success : function(data)
						        {
						        	var tip = data.errorCode;
						        	if (tip == null || tip == ''){
						        		 //应用到设备成功
						        		//弹出对话框
						             	$.alert({
						                     title: '提示信息',
						                     icon:'fa fa-info-circle blue',
						                     theme:'bootstrap',
						                     content: '版本应用到设备成功',
						                     closeIcon: true,
						                     buttons:{
						                     	 colseWin: {
						                          	text: '<i class="ace-icon fa fa-times"></i>关闭',
						                              btnClass: 'btn-info'
						                          }
						                     }
						                 });
						        	} else {
						        		//应用到设备失败
						        		 $.alert({
						                     title: '提示信息',
						                     icon:'fa fa-info-circle red',
						                     theme:'bootstrap',
						                     content: '版本应用到设备失败',
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
						    });
							
						}
						$(this).dialog("close");
					}
				}],
				open:function(){ //展示选中的节点
					
					//设置显示的位置
					var pDialog = $(this).closest(".ui-dialog").css("z-index",9999);
				}
			});
         }
	 });
}


