window.setInterval(function()
{
    $.post(contextPath + "/system/logs/heartbeat?_method=put");
}, heartbeatInterval);


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
    
	$("#myModal").on("hidden.bs.modal", function() {
		$("#changeFailed").css({'display':'none'});
		$("#changeSuccess").css({'display':'none'});
		$('#changePasswordForm').data('bootstrapValidator').destroy();
	    $('#changePasswordForm').data('bootstrapValidator', null);
		clearForm($('#changePasswordForm'));
		loadChangePasswordFormValidator();
	});
	
	/**
	 * by hongxz 20170821 使用新的方式，让iframe自动适应   定时更新高度
	 */
	window.setInterval("reinitIframe()", 200);
//	$(window.parent.document).find("#mainframe").load(function(){	
//	    var main = $(window.parent.document).find("#mainframe");
//	    var thisheight = $(document).height()-$("#breadcrumbs").outerHeight()-$("#navbar").outerHeight()-6;
//	    main.height(thisheight);
//	});
	
	$wnav = $("#wnav");
	
	$.ajax({
        type: "GET",
        url: contextPath + "/system/my/menus",
        dataType: "json",
        cache: false,
        headers: {
            Accept: "application/json; charset=utf-8"
        },
        success: function(menu) {
            initMenu(menu);
        }
    });
	
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

var initMenu = function(menu)
{    
    var html = "";
    $.each(menu, function(i, m) {
        html += "<li><a id='menu"+ m.id +"' class='dropdown-toggle' href='javascript:void(0);'><i class='" 
        	+ (null==m.attributes.icon ? "icon-desktop" : m.attributes.icon) 
        	+ "'></i><span class='menu-text'>" + m.text 
        	+ "</span><b class='arrow icon-angle-down'></b></a></li>";
    });   
    
    $wnav.append(html);    
    
    $('#wnav li a').click(function()
    {    	
        var id = this.id;

        $.each(menu, function(i, m) {
            if (("menu" + m.id) == id)
            {            	
                logBehavior("log.behavior.menu.action" + m.id);
                addNav(id,m.children);
                return;
            }
        });
    });
}

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
var addNav = function(id,data)
{	
	if (data.length == 0) {   	 
		return;
	}
	
	$("#" + id).prevAll("ul").remove();
	$("#" + id).nextAll("ul").remove();
	$("#" + id).parent().append("<ul class='submenu'></ul>");
		
    $.each(data, function(i, sm)
    {
    	if (null != sm.attributes.menuUrl) {
	        $("#" + id).next("ul").append("<li><a id='menu" + sm.id 
	        		+ "' class='dropdown-toggle' target='mainframe' href='" 
	        		+ contextPath + sm.attributes.menuUrl + "' ><i class='" + (null==sm.attributes.icon ? "icon-double-angle-right" : sm.attributes.icon) + "'></i><span class='menu-text'>" 
	        		+ sm.text + "</span></a></li>");
	        $("#menu" + sm.id).click(function(){
	        	logBehavior("log.behavior.menu.action" + sm.id);
	        	$('#wnav li').removeClass('active');
	        	$(this).parent().addClass("active");
	        	$(this).parents('li').each(function(i){
	        		if (i == 0){
	        			$("#breadcrumbId").empty();
	        			$("#breadcrumbId").prepend("<li class='active'>" + $(this).children("a").children("span").text() + "</li>");
	        		}
	        		else{
	        			$("#breadcrumbId").prepend("<li>" + $(this).children("a").children("span").text() + "</li>");
	        		}
	        	});
	        });
    	}
    	else {
    		$("#" + id).next("ul").append("<li><a id='menu" + sm.id 
	        		+ "' class='dropdown-toggle' href='javascript:void(0);'><i class='" + (null==sm.attributes.icon ? "icon-double-angle-right" : sm.attributes.icon) + "'></i><span class='menu-text'>" 
	        		+ sm.text + "</span></a></li>");
    		$("#menu" + sm.id).click(function(){
	        	logBehavior("log.behavior.menu.action" + sm.id);	        	
	        });
    	}
        
    	if (sm.children.length > 0) {
    		addNav("menu" + sm.id, sm.children);
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
