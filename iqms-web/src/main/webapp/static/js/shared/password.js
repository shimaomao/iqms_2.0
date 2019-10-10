if (window.top != window)
{
    window.top.location = window.location;
}

var refreshCount = 0;
/**
*  by hongxz 20170821 iframe自适应高度
*/
function reinitIframe(){
	refreshCount++;
	var iframe = document.getElementById("mainframe");
	try{
		var bHeight = iframe.contentWindow.document.body.scrollHeight;
		var dHeight = iframe.contentWindow.document.documentElement.scrollHeight;
		var height = Math.max(bHeight, dHeight) < 500 ? 500 : Math.max(bHeight, dHeight);
		//如果是系统功能，高度固定设置为500
		$("#breadcrumbId li").each(function(){
			if($(this).text()=='系统'){
				height = 500;
			}
		});
		
		iframe.height =  height;
		
		//$("#iframeheight").text(height);
		
		//获取文档的高度
		//docheight = document.body.scrollHeight;
		$("body").height(height);
		
		//$("#docheight").text(document.body.scrollHeight+"  - "+document.documentElement.scrollHeight+"-刷新次数："+refreshCount+"-请求地址："+iframe.location);
		
	}catch (ex){}
			
}

$(function()
{
    
		$("#changeFailed").css({'display':'none'});
		$("#changeSuccess").css({'display':'none'});
/*		$('#changePasswordForm').data('bootstrapValidator').destroy();
	    $('#changePasswordForm').data('bootstrapValidator', null);*/
		clearForm($('#changePasswordForm'));
		loadChangePasswordFormValidator();
});

var clearForm = function(form) {
    $(':input', form).each(function () {
        var type = this.type;
        var tag = this.tagName.toLowerCase();
        if (type == 'text' || type == 'password' || tag == 'textarea'){
            this.value = "";
        }
        else if (tag == 'select'){
            this.selectedIndex = -1;
        }
    });
};


var loadChangePasswordFormValidator = function() {
	$('#changePasswordForm').bootstrapValidator({
		excluded: [':disabled'],
	    feedbackIcons: {
	        valid: 'glyphicon glyphicon-ok',
	        invalid: 'glyphicon glyphicon-remove',
	        validating: 'glyphicon glyphicon-refresh'
	    },
	    fields: {
	    	oldpass: {	           
	            validators: {
	                notEmpty: {
	                    message: '该项为必输项'
	                }/*,  //不做格式校验 by tianjm 20181126
	                regexp: {
	                    regexp: /^\w{6,}$/,
	                    message: '密码格式不正确，格式为字母、数字、下划线且至少6位'
	                }*/
	            }
	        },
	        newpass: {
	            validators: {
	                notEmpty: {
	                    message: '该项为必输项'
	                },
	                /*regexp: {
	                    regexp: /^\w{6,}$/,
	                    message: '密码格式不正确，格式为字母、数字、下划线且至少6位'
	                }*/
	                callback: {  //使用callback 自定义校验方式
                        message: '用户密码至少包含大写字母、小写字母、数字、特殊字符中的 3类且至少8位',
                        callback: function(value, validator) {//这里可以自定义value的判断规则
                        	
                        	var regx1 = /[A-Z]/g;
                        	var regx2 = /[a-z]/g;
                        	var regx3 = /[0-9]/g;
                        	var regx4 = /[~!@#$%^&*()><?]/g;
                        	
                        	var result1 = regx1.test(value)==true?1:0;
                        	var result2 = regx2.test(value)==true?1:0;
                        	var result3 = regx3.test(value)==true?1:0;
                        	var result4 = regx4.test(value)==true?1:0;
                        	
                        	var sumary = result1 + result2 + result3 +result4;
                        	if (sumary >= 3 && value.length>7){
                        			return true;
                        	} else {
                        		return false;
                        	}
                        	
                        }
                    }
	            }
	        },
	        newpassAgain: {
	            validators: {
	                notEmpty: {
	                    message: '该项为必输项'
	                },
	               /* regexp: {
	                    regexp: /^\w{6,}$/,
	                    message: '密码格式不正确，格式为字母、数字、下划线且至少6位'
	                },*/
	                callback: {  //使用callback 自定义校验方式
                        message: '用户密码至少包含大写字母、小写字母、数字、特殊字符中的 3类且至少8位',
                        callback: function(value, validator) {//这里可以自定义value的判断规则
                        	
                        	var regx1 = /[A-Z]/g;
                        	var regx2 = /[a-z]/g;
                        	var regx3 = /[0-9]/g;
                        	var regx4 = /[~!@#$%^&*()><?]/g;
                        	
                        	var result1 = regx1.test(value)==true?1:0;
                        	var result2 = regx2.test(value)==true?1:0;
                        	var result3 = regx3.test(value)==true?1:0;
                        	var result4 = regx4.test(value)==true?1:0;
                        	
                        	var sumary = result1 + result2 + result3 +result4;
                        	if (sumary >= 3 && value.length>7){
                        			return true;
                        	} else {
                        		return false;
                        	}
                        	
                        }
                    },
	                identical: {
	                	field:"newpass",
	                	message: '两次输入密码不一致'
	                }
	            }
	        }
	    }
	});
}

var saveUpdate = function(){
	$("#changePasswordForm").data("bootstrapValidator").validate();
	var flag = $("#changePasswordForm").data("bootstrapValidator").isValid();
	if (!flag) {
		logBehavior("log.behavior.modal.client.invaild", ["user.changePassword"]);
		return;
	}
	
	var data =
    {
        oldPassword : $("#oldpass").val(),
        newPassword : $("#newpass").val()
    };	
	$.ajax({
        url : contextPath + "/system/users/" + currentUserId + "/password?_method=put",
        type : "post",
        dataType : "json",
        data : data,
        success : function(result)
        {
            if ($.string(result.errorCode).blank())
            {
            	$("#changeFailed").css({'display':'none'});
                $("#changeSuccess").css({'display':'inline','font-size':'20px','height':'30px','display':'block'});
                $("#changeSuccess").text($.i18n.prop("submit.success")+'，选择【关闭】重新登录');
                clearForm($('#changePasswordForm'));//清除掉，防止再次点击提交
                logBehavior("log.behavior.modal.server.submit", ["user.changePassword"]);
            }
            else
            {
            	$("#changeSuccess").css({'display':'none'});
            	$("#changeFailed").css({'display':'inline','font-size':'20px','height':'30px','display':'block'});
            	$("#changeFailed").text($.i18n.prop(result.errorCode));
            	logBehavior("log.behavior.modal.server.invaild", ["user.changePassword"]);
            }
        }
    });
}

var logout=function(){
	window.location.href=contextPath+'/logout';
}

