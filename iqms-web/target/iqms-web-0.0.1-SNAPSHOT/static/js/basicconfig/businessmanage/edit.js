var $editDialog;

$(function(){
	//form绑定验证框架
	$("#dialog-edit").find("form").validate({
		errorElement: 'div',   //错误信息包装元素
		errorClass: 'help-block', //错误的样式
		focusInvalid: false, //提交表单后未通过验证的表单会获得焦点
		ignore: "", //对某些元素不进行验证
		rules: { //验证规则
			businessName: {   //验证的字段
				required: true, //必填
				maxlength: 10,
				zh_chint:true
			},
			businessEName:{
				required: true, //必填
				maxlength: 20, 
				en:true
			},
			averageTime:{
				required: true, //必填
				maxlength: 3,
				digits:true  //只能填数字
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
});


/**
 * 业务管理编辑
 */
function editBusinessManage()
{
    //logBehavior("log.behavior.dialog.open", ["user.list", "new"]);

	//绑定对话框
	$editDialog = $("#dialog-edit").removeClass("hide").dialog({
		modal: true, //模式对话框
		title: '<i class="ace-icon fa fa-pencil-square-o bigger-250"></i><span class="ui-jqdialog-title" style="float: left;"> 编辑</span>',
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
				saveEdit();
			}
		}],
		open:function(){ //加载数据
			
			//请空上一次的表单数据
			$("#dialog-edit").find("form").clearForm();

			//清除验证信息
			$("div").removeClass("has-error");
			$("div").remove(".help-block");

			//获取选中的行的行号
			var selIds=$(grid_selector).jqGrid('getGridParam','selarrrow');
			if (selIds.length > 1){
				
				$.alert({
	                 title: '提示信息',
	                 icon:'fa fa-info-circle blue',
	                 theme:'bootstrap',
	                 content: '请选择一条记录进行编辑！',
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
				var $editform = $("#dialog-edit").find("form");
				//自动填充到form
				$editform.populateForm(rowData);
			}
		}
	});
}

/**
 * 保存修改
 */
function saveEdit(){
	 var form = $("#dialog-edit").find("form");
	 var formjson = form.serialize();
	 
	 //1.验证失败
	 if (!form.valid()){
		 return ;
	 }
	 
	 //2.验证成功
	 var url = contextPath + "/basicconfig/businessmanage?_method=put&dt="+(new Date().getTime());
     $.post(url, formjson, function(result)
     {
         if (result.errorCode == '0')
         {
        	 $.alert({
                 title: '提示信息',
                 icon:'fa fa-info-circle blue',
                 theme:'bootstrap',
                 content: '业务类型编辑成功',
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
            $editDialog.dialog("close");//关闭窗口
         }else if(result.errorCode == '2')
         {
        	 $.alert({
                 title: '提示信息',
                 icon:'fa fa-info-circle red',
                 theme:'bootstrap',
                 content: '业务名称已经存在',
                 closeIcon: true,
                 buttons:{
                 	 colseWin: {
                      	text: '<i class="ace-icon fa fa-times"></i>关闭',
                          btnClass: 'btn-info'
                      }
                 }
             });
         }else if(result.errorCode == '3'){
        	 $.alert({
                 title: '提示信息',
                 icon:'fa fa-info-circle red',
                 theme:'bootstrap',
                 content: '业务英文名已经存在',
                 closeIcon: true,
                 buttons:{
                 	 colseWin: {
                      	text: '<i class="ace-icon fa fa-times"></i>关闭',
                          btnClass: 'btn-info'
                      }
                 }
             });
         }
         else
         {
        	 $.alert({
                 title: '提示信息',
                 icon:'fa fa-info-circle red',
                 theme:'bootstrap',
                 content: '业务类型编辑失败',
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
