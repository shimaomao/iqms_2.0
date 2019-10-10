var $newDialog;

$(function(){
	
	//form绑定验证框架
	 $("#dialog-new").find("form").validate({
		errorElement: 'div',   //错误信息包装元素
		errorClass: 'help-block', //错误的样式
		focusInvalid: false, //提交表单后未通过验证的表单会获得焦点
		ignore: "", //对某些元素不进行验证
		rules: { //验证规则
			businessId:{
				required: true,
				ch_digst:true
			},
			businessName: {   //验证的字段
				required: true, //必填
				maxlength: 20,  //最多输入10个字符
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
 * 业务管理新增
 */
function newBusinessManage()
{
	
    //logBehavior("log.behavior.dialog.open", ["user.list", "new"]);
	//绑定对话框
	$newDialog = $("#dialog-new").removeClass("hide").dialog({
		modal: true, //模式对话框
		title: '<i class="ace-icon fa fa-pencil-square-o bigger-250"></i><span class="ui-jqdialog-title" style="float: left;"> 新增</span>',
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
				//保存数据
				save();
			}
		}],
		open:function(){ //加载数据
			//请空上一次的表单数据
			$("#dialog-new").find("form").clearForm();
			//清除验证信息
			$("div").removeClass("has-error");
			$("div").remove(".help-block");

		}
	});
}

/**
 * 保存记录
 */
function save(){
	 var form = $("#dialog-new").find("form");
	 
	//1.验证失败
	 if (!form.valid()){
		 return ;
	 }
	 
	 
	 var formjson = form.serialize();
	 //alert(formjson);
	 var url = contextPath + "/basicconfig/businessmanage?dt="+(new Date().getTime());
     $.post(url, formjson, function(result)
     {
		 console.log(result);
         if (result.errorCode == '0')
         {
        	//弹出对话框
         	$.alert({
                 title: '提示信息',
                 icon:'fa fa-info-circle blue',
                 theme:'bootstrap',
                 content: '业务类型增加成功',
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
         }else if (result.errorCode == '2')
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
             })
         }else if (result.errorCode == '3')
         {
        	 $.alert({
                 title: '提示信息',
                 icon:'fa fa-info-circle red',
                 theme:'bootstrap',
                 content: '业务英文名称已经存在',
                 closeIcon: true,
                 buttons:{
                 	 colseWin: {
                      	text: '<i class="ace-icon fa fa-times"></i>关闭',
                          btnClass: 'btn-info'
                      }
                 }
             })
         }
         else
         {
        	 $.alert({
                 title: '提示信息',
                 icon:'fa fa-info-circle red',
                 theme:'bootstrap',
                 content: '业务类型增加失败',
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
