var $newDialog;

$(function(){
	
	//form绑定验证框架
	 $("#dialog-patchinfo").find("form").validate({
		errorElement: 'div',   //错误信息包装元素
		errorClass: 'help-block', //错误的样式
		focusInvalid: false, //提交表单后未通过验证的表单会获得焦点
		ignore: "", //对某些元素不进行验证
		rules: { //验证规则
			patchVerno: {   //验证的字段
				required: true, //必填
				maxlength: 10,   //最多输入10个字符
				patch:true       //版本：字母和.和数字   by tianjm 20181112
			},
			patchRemark: {
				 required: false, //非必填
				 maxlength: 50,   //最多输入10个字符
				 zh_chint:true
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
 * 新增客户类型
 */
function addtionalInfo(file)
{
    //logBehavior("log.behavior.dialog.open", ["user.list", "new"]);
	//绑定对话框
	$newDialog = $("#dialog-patchinfo").removeClass("hide").dialog({
		modal: true, //模式对话框
		title: '<i class="ace-icon fa fa-pencil-square-o bigger-250"></i><span class="ui-jqdialog-title" style="float: left;"> 补充信息</span>',
		title_html: true,
		width:"400",
		height:"420",
		buttons: [{
			html: '<i class="ace-icon fa fa-times"></i>取消', //按钮文本
			"class": "btn btn-minier",
			click: function() {
				//删除待上传的文件
				myDropzone.removeFile(file);
				//关闭窗口
				$(this).dialog("close");
			}
		}, {
			html: '<i class="ace-icon fa fa-check"></i>上传',
			"class": "btn btn-primary btn-minier",
			click: function() {
				var form = $("#dialog-patchinfo").find("form");
				//1.验证失败
				 if (form.valid()){
					//上传数据
					myDropzone.processQueue();
				 }
			}
		}],
		open:function(){ //加载数据
			//请空上一次的表单数据
			$("#dialog-patchinfo").find("form").clearForm();
			//设置值
			var fileName = file.name;
			var patchName = fileName.substring(0,fileName.lastIndexOf("."));
			$("#dialog-patchinfo").find("#patchName").val(patchName);
		}
	});
}

/**
 * 保存记录
 */
function save(){
	 var form = $("#dialog-patchinfo").find("form");
	 
	//1.验证失败
	 if (!form.valid()){
		 return ;
	 }
	 
	 
	 //提交信息
	 
	 return ;
}
