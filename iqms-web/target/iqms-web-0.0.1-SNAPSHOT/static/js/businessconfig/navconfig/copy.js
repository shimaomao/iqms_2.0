var params, bizTypeId, index, busType;
var $rowNum = 0;
var $winNum = 0;
var index = 0;
var $tbody = $("#ccc tbody");
var delRowidArr = [];
var orgId = "";
var deviceNo = "";
var orgName = "";
var saveFlag = false;

$(function() {
	params = $.string(decodeURI(window.location.href)).toQueryParams();
	orgId = $("#orgId").val();
	deviceNo = $("#deviceNo").val();
	orgName = params["orgName"];
	if(params["devName"]!="undefined"){
		$("#devName").val(params["devName"]);
	}
});
/**
 * 返回上一步
 * @param orgId
 */
function back(){
	//跳转到创建设备
 	window.location.href = encodeURI(contextPath + "/businessconfig/navconfig/backdevice?dt="+(new Date().getTime())
 	+"&deviceNo="+deviceNo+"&devName="+$("#devName").val());
}

/**
 * 点击下一步
 */
function next(){
	//跳转到窗口配置
 	window.location.href = encodeURI(contextPath + "/businessconfig/navconfig/winconfig?dt="+(new Date().getTime())
 	+"&deviceNo="+deviceNo+"&orgId="+orgId+"&devName="+$("#devName").val()+"&orgName="+orgName);
}

/**
 * 点击向导栏图标跳转到指定页面
 * @param e
 */
function redirect(e){
	if(e.getAttribute("data-step")=='1'){
		//跳转到创建设备
	 	window.location.href = encodeURI(contextPath + "/businessconfig/navconfig/backdevice?dt="+(new Date().getTime())
	 	+"&deviceNo="+$("#deviceNo").val()+"&devName="+$("#devName").val());
	}
}

function orgDeviceTree(orgId){
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
        url : contextPath + "/businessconfig/ztreefastcopy?dt="+(new Date().getTime()),
        type : "get",
        dataType : "json",
        contentType : "application/json",
        data : {"orgId":orgId,"deviceNo":deviceNo},
        success : function(datas)
        {
         
       	 var zNodes = datas.rows;
       	 var hasDeviceFlag = false;
       	 for(var i = 0; i < zNodes.length; i++){
       		 var nodeJson = zNodes[i];
       		 
       		 if(nodeJson.deviceNo != null && nodeJson.deviceNo != "" && nodeJson.deviceNo != "null"){
       			 hasDeviceFlag = true;
       		 }
       		 
       	 }
       	 
       	 
       	 if(!hasDeviceFlag){
       	//弹出对话框
	         	$.alert({
	                 title: '提示信息',
	                 icon:'fa fa-info-circle blue',
	                 theme:'bootstrap',
	                 content: '未找到相同分辨率的设备',
	                 closeIcon: true,
	                 buttons:{
	                 	 colseWin: {
	                      	text: '<i class="ace-icon fa fa-times"></i>关闭',
	                          btnClass: 'btn-info'
	                      }
	                 }
	             });
	         	return;
       	 }
       	 
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
			var title = "";
			
			title = '<i class="ace-icon fa fa-sitemap bigger-200 "></i><span class="ui-jqdialog-title" style="float: left;"> 设备选择</span>';
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
						if (selNodes != null && selNodes.length > 0){
							var selNode = selNodes[0];
							var orgDevicelist = '';
							for(var i=0;i<selNodes.length;i++){
								orgDevicelist += selNodes[i].devName + ","+selNodes[i].cId+","+selNodes[i].pId+";"
								$("#devName").val(selNodes[i].devName);
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
		var jc = $.confirm({
	        title: '快速应用',
	        icon: 'fa fa-warning red',
	        theme:'bootstrap',
	        content: '将清空设备号为'+deviceNo+'的所有配置，确定要应用吗?',
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
	                	var url = contextPath + "/businessconfig/bscdevice/fastcopy?dt="+(new Date().getTime());
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
		           	         else if(result.errorCode == '2'){
		           	        	$.alert({
		           	                 title: '提示信息',
		           	                 icon:'fa fa-info-circle red',
		           	                 theme:'bootstrap',
		           	                 content: '请先保存配置',
		           	                 closeIcon: true,
		           	                 buttons:{
		           	                 	 colseWin: {
		           	                      	text: '<i class="ace-icon fa fa-times"></i>关闭',
		           	                          btnClass: 'btn-info'
		           	                      }
		           	                 }
		           	             });
		           	         }else
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
}
