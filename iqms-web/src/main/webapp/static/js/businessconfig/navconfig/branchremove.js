/**
 * 删除节点
 */
function removeBranchBusiness(orgId,deviceNo,treeId){
	$newDialog = $("#dialog-remove").removeClass("hide").dialog({
		modal: true, //模式对话框
		title: '<i class="ace-icon fa fa-pencil-square-o bigger-250"></i><span class="ui-jqdialog-title" style="float: left;">删除</span>',
		title_html: true,
		width:"350",
		height:"200",
		buttons: [{
			html: '<i class="ace-icon fa fa-times"></i>取消', //按钮文本
			"class": "btn btn-minier",
			click: function() {
				//关闭窗口
				$(this).dialog("close");
				return false;
			}
		}, {
			html: '<i class="ace-icon fa fa-check"></i>确定',
			"class": "btn btn-primary btn-minier",
			click: function() {
				//保存数据
				$(this).dialog("close");
				if(typeof(orgId)!='undefined'){
					remove(orgId,deviceNo,treeId);
				}
//				searchCondition();
			}
		}],
//		open:function(){ //加载数据
////			//请空上一次的表单数据
////			$("#main-container").find("form").clearForm();
//			searchCondition();
//		}
	});
}

/**
 *删除 
 */
function remove(orgId,deviceNo,treeId){
	 
	 $.ajax({
         url : contextPath + "/businessconfig/branchRemove?_method=get&dt="+(new Date().getTime()),
         type : "GET",
         dataType : "json",
         contentType : "application/json",
         data : {"orgId":orgId,"deviceNo":deviceNo,"treeId":treeId},
         success : function()
         {
        	 if(treeId.indexOf("bus")<0){
					jQuery("#menuList").find("span[id="+treeId+"]").attr("class","label label-primary");
			 }else{
					jQuery("#busList").find("span[id="+treeId+"]").attr("class","label label-success");
			 }
             $.alert({
                 title: '提示信息',
                 icon:'fa fa-info-circle blue',
                 theme:'bootstrap',
                 content: '删除成功！',
                 closeIcon: true,
                 buttons:{
                 	 colseWin: {
                      	text: '<i class="ace-icon fa fa-times"></i>关闭',
                          btnClass: 'btn-info'
                      }
                 }
                
             });
             //重新加载数据
             loadDatas();
         }
});
}