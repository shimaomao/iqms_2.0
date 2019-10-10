var $showDialog;

/**
 * 业务管理详情
 */
function showBusinessManage()
{
    //logBehavior("log.behavior.dialog.open", ["user.list", "new"]);

	//绑定对话框
	$showDialog = $("#dialog-show").removeClass("hide").dialog({
		modal: true, //模式对话框
		title: '<i class="ace-icon fa fa-pencil-square-o bigger-250"></i><span class="ui-jqdialog-title" style="float: left;"> 详情</span>',
		title_html: true,
		width:"500",
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
				//提交数据
				$(this).dialog("close");
			}
		}],
		open:function(){ //加载数据
			//获取选中的行的行号
			var selIds=$(grid_selector).jqGrid('getGridParam','selarrrow');
			if (selIds.length > 1){
				$.alert({
	                 title: '提示信息',
	                 icon:'fa fa-info-circle blue',
	                 theme:'bootstrap',
	                 content: '请选择一条记录进行查看！',
	                 closeIcon: true,
	                 buttons:{
	                 	 colseWin: {
	                      	text: '<i class="ace-icon fa fa-times"></i>关闭',
	                          btnClass: 'btn-info'
	                      }
	                 }
	             });
				$(this).dialog("close");
			} else {
				//从原始数据中获取行数据
				var rowData = dgDatas.rows[selIds[0]-1];
				//获取编辑表单的form
				var $showForm = $("#dialog-show").find("form");
				//自动填充到form
				$showForm.populateForm(rowData);
			}
		}
	});
}

