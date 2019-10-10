var newCount = 1;
var zNodes = null;
var $orgDialog;
var zTreeObj ;

//1.定义ztree的配置
var setting = {
		async: {
			 enable: true,
			 url: contextPath + "/basicconfig/fileTree?dt="+(new Date().getTime()),//异步加载时的请求地址
			 autoParam: ["dirPath","cId"],//提交参数
			 type: 'get',
			 dataFilter: filter
		},
        view: {
            selectedMulti: true  //没有多选
        },
        check: {
        	enable: false,
    		chkStyle: "checkbox",
    		chkboxType: { "Y": "s", "N": "s" },
    		radioType: "all" //设置单选
        },
        data: {
        	key:{
        		name:"dirName"
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
        		/*if(treeNode.isParent){  
                    //alert("treeId自动编号：" + treeNode.tId + ", 节点id是：" + treeNode.id + ", 节点文本是：" + treeNode.name);  
                    $.ajax({
                        url: contextPath + "/basicconfig/fileTree?dt="+(new Date().getTime()),//请求的action路径
                        data:{"dirPath":treeNode.dirPath,"cId":treeNode.cId},
                        error: function () {//请求失败处理函数
                            alert('请求失败');
                        },
                        success:function(data)
                            { //添加子节点到指定的父节点
                                var jsondata= data.rows;
                                if(jsondata == null || jsondata == ""){
                                    //末节点的数据为空   所以不再添加节点  这里可以根据业务需求自己写
                                    //$("#treeFrame").attr("src",treeNode.url);
                                    }
                                else{
                                        var treeObj = $.fn.zTree.getZTreeObj("orgTree");
                                        //treeNode.halfCheck = false;
                                        var parentZNode = treeObj.getNodeByParam("cId", treeNode.cId, null);//获取指定父节点
                                        for (var i=0, l=jsondata.length; i<l; i++) {
                                        	array[i] = {cId:jsondata[i].cId,pId:jsondata[i].pId,dirName:jsondata[i].dirName,isParent:false};//将后台传过来的参数拼接成json格式，并放在数组中，如果有必要需要对其是否为父节点做处理
                                        	}
                                        newNode = treeObj.addNodes(parentZNode,jsondata, false);
                                    }
                            }
                        });
                }*/
        	}
        } 
    };
/**
 * 选择机构组织树
 * @param isUpload false-预览 true-上传
 * @param showNameFlag   true-设置文件名称到文本框   false-不设置文件名称到文本框
 * @param isButton true-存在查询按钮 false-不存在 点击确定 直接查询
 * @param defcallback   用户回调函数
 */
function selectFileTree(isUpload,showNameFlag,isButton,defcallback){
	
	//ajax请求加载数据
	 $.ajax({
         url : contextPath + "/basicconfig/fileTree?dt="+(new Date().getTime()),
         type : "get",
         dataType : "json",
         contentType : "application/json",
         data : "",
         success : function(datas)
         {
        	 var zNodes = datas.rows;
        	 
        	//初始化机构树
        	 setting.check.chkStyle="radio";
    		 zTreeObj = $.fn.zTree.init($("#orgTree"), setting, zNodes);
 			 var	title = '<i class="ace-icon fa fa-sitemap bigger-200 "></i><span class="ui-jqdialog-title" style="float: left;">目录选择</span>';
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
						var selNodes = zTreeObj.getSelectedNodes();
						if(selNodes == null || selNodes.length == 0){
							$.alert({
				                 title: '提示信息',
				                 icon:'fa fa-info-circle red',
				                 theme:'bootstrap',
				                 content: '请选择目录！',
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
							if(!isUpload){
								jQuery("#searchFrom").find("input[name=dirPath]").val(selNode.dirPath);
								jQuery("#searchFrom").find("input[name=dirName]").val(selNode.dirName);
								if (defcallback)
								{
									defcallback();
								}
							}else{
								jQuery("#uploadForm").find("input[name=filePath]").val(selNode.dirPath);
							}
						}
						$(this).dialog("close");
					}
				}]
			});
         }
	 });
}

function filter(treeId, parentNode, responseData) {
	var array = [];
	if (!responseData) return null;
	var data = JSON.stringify(responseData);
	data = responseData.rows;
//	alert(data[0].dirName);
	for (var i=0, l=data.length; i<l; i++) {
	array[i] = {cId:data[i].cId,pId:data[i].pId,dirName:data[i].dirName,dirPath:data[i].dirPath,isParent:data[i].isParent};//将后台传过来的参数拼接成json格式，并放在数组中，如果有必要需要对其是否为父节点做处理
	}
	return array;
}

/*function ztreeOnAsyncSuccess(event, treeId, treeNode){
	var url = contextPath + "/basicconfig/fileTree?dt="+(new Date().getTime());
	$.ajax({
		type : "post",
		url : url,
		data : "",
		dataType : "json",
		async : true,
		success : function(jsonData) {				
			if (jsonData != null) {	
				alert($.toJSON(jsonData));
				var data = jsonData.unitList;
				if(data != null && data.length != 0){
					if(treeNode == undefined){
						treeObj.addNodes(null,data,true);// 如果是根节点，那么就在null后面加载数据
					}
					else{
						treeObj.addNodes(treeNode,data,true);//如果是加载子节点，那么就是父节点下面加载
					}
				}
				treeObj.expandNode(treeNode,true, false, false);// 将新获取的子节点展开
			}
		},
		error : function() {
			alert("请求错误！");
		}
	});
	
};*/

