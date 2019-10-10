if (window.top != window)
{
    window.top.location = window.location;
}

function GetQueryString(name)
{
     var reg = new RegExp("(^|&)"+ name +"=([^&]*)(&|$)");
     var r = window.location.search.substr(1).match(reg);
     if(r!=null)return  unescape(r[2]); return null;
}

$(function()
{
	$spnError = $("#spnErr");
	if(GetQueryString("msg")=='nomatch'){
		$spnError.text("验证码错误");
	}
	changeImg();//生成验证码图片
	$veryCode = $("#veryCode");
    $username = $("#username");
    $password = $("#password");
    $frmLogin = $("#loginForm");
    focus();
    
    loadLoginFormValidator();
    
    $veryCode.keydown(function(event){
    	if (event.keyCode == 13){
    		sub_login();
    	}
    });
    
});

function changeImg(){    
	   $("#imgObj").attr("src","DrawImage?"+Math.random()); //给验证码一个随机数  
	}  

function focus()
{
    var username = $.trim($username.val());

    if (0 == username.length)
    {
        $username.focus();
        return;
    }

    var password = $password.val();

    if (0 == password.length)
    {
        $password.focus();
        return;
    }
    
    var veryCode = $veryCode.val();

    if (0 == veryCode.length)
    {
    	$veryCode.focus();
        return;
    }
}

var loadLoginFormValidator = function() {
	$('#loginForm').bootstrapValidator({
		excluded: [':disabled'],
	    feedbackIcons: {
	        valid: 'glyphicon glyphicon-ok',
	        invalid: 'glyphicon glyphicon-remove',
	        validating: 'glyphicon glyphicon-refresh'
	    },
	    fields: {
	    	j_username: {	            
	            validators: {
	                notEmpty: {
	                    message: '该项为必输项'
	                },
	                /*regexp: {
	                	regexp: /^[a-zA-Z0-9]{1,16}$/,	                    
	                    message: '用户名不合法（允许字母数字，1-16字符）'
	                }*/
	                callback: {
	                    message: '用户名由4-16位长度的字母数字下划线组成，不得使用root、admin、姓名简拼等 ',
	                    callback: function(value, validator) {//这里可以自定义value的判断规则
	                    	if(value=='root' || value=='administrator' || value=='guanliyuan'){
	//                    		if(value=='root' || value=='admin' || value=='administrator' || value=='guanliyuan'){
	                    		return false;
	                        } else {
	                            return /^[a-zA-Z0-9_]{4,16}$/i.test(value);
	                        }
	                    }
	                }
	            }
	        },
	        j_password: {
	            validators: {
	                notEmpty: {
	                    message: '该项为必输项'
	                },
	              /*  regexp: {
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
	        j_veryCode: {
	        	validators: {
	                notEmpty: {
	                    message: '该项为必输项'
	                },
	                regexp: {
	                	regexp: /^[a-zA-Z0-9]{4}$/,	                    
	                    message: '验证码不合法'
	                }
	            }
	        },
	        
	    }
	});
}

function sub_login()
{
   
    /*$frmLogin.form("enableValidation");//启用验证
    if ($frmLogin.form("validate")){  //做表单字段验证
    	
    	var form=document.forms[0];
        document.getElementById("username").value = encode64($username.val());  //加密
        document.getElementById("password").value = encode64($password.val());  //加密
        form.submit();
//    	$frmLogin.submit(); //做完上面的验证后提交
    }*/
    
    $("#loginForm").data("bootstrapValidator").validate();
	var flag = $("#loginForm").data("bootstrapValidator").isValid();
	if (!flag) {
		logBehavior("log.behavior.modal.client.invaild", ["user.login"]);
		return;
	}
	
	document.getElementById("username").value = encode64($username.val());  //加密
    document.getElementById("password").value = encode64($password.val());  //加密
	$("#loginForm")[0].submit();
}

var keyStr = "ABCDEFGHIJKLMNOP" + "QRSTUVWXYZabcdef" + "ghijklmnopqrstuv"  
+ "wxyz0123456789+/" + "=";  

function encode64(input) {

	var output = "";
	var chr1, chr2, chr3 = "";
	var enc1, enc2, enc3, enc4 = "";
	var i = 0;
	do {
		chr1 = input.charCodeAt(i++);
		chr2 = input.charCodeAt(i++);
		chr3 = input.charCodeAt(i++);
		enc1 = chr1 >> 2;
		enc2 = ((chr1 & 3) << 4) | (chr2 >> 4);
		enc3 = ((chr2 & 15) << 2) | (chr3 >> 6);
		enc4 = chr3 & 63;
		if (isNaN(chr2)) {
			enc3 = enc4 = 64;
		} else if (isNaN(chr3)) {
			enc4 = 64;
		}
		output = output + keyStr.charAt(enc1) + keyStr.charAt(enc2)
				+ keyStr.charAt(enc3) + keyStr.charAt(enc4);
		chr1 = chr2 = chr3 = "";
		enc1 = enc2 = enc3 = enc4 = "";
	} while (i < input.length);

	return output;
} 