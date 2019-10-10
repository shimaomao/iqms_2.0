/**
 * 删除临近网点信息
 */
function removeNear(){
	$newDialog = $("#dialog-remove").removeClass("hide").dialog({
		modal: true, //模式对话框
		title: '<i class="ace-icon fa fa-pencil-square-o bigger-250"></i><span class="ui-jqdialog-title" style="float: left;">删除</span>',
		title_html: true,
		width:"200",
		height:"150",
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
				$(this).dialog("close");
				remove();
			}
		}],
		open:function(){ //加载数据
			//请空上一次的表单数据
			$("#dialog-new").find("form").clearForm();
			
		}
	});
}

/**
 *删除 
 */
function remove(){
	 
	 var orgId = $("#orgId").val();
	 $.ajax({
         url : contextPath + "/basicconfig/nearRemove?_method=delete&dt="+(new Date().getTime()),
         type : "post",
         dataType : "json",
         contentType : "application/json",
         data : $.toJSON(orgId),
         success : function()
         {
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
             getNearInfo(orgId);
         }
});
}