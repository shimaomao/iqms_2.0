var $newDialog;

$(function(){
	
	//form绑定验证框架
	 $("#dialog-new").find("form").validate({
		errorElement: 'div',   //错误信息包装元素
		errorClass: 'help-block', //错误的样式
		focusInvalid: false, //提交表单后未通过验证的表单会获得焦点
		ignore: "", //对某些元素不进行验证
		rules: { //验证规则
			custId: {   //验证的字段
				required: true, //必填
				zm_sz2:true,       //自定义中英文
			},
			custName:{
				required: true, //必填
				maxlength: 15,   //最多输入20个字符
				zh_ch:true  //自定义中英文
			},
			custLevel: {
				required: true //必填
			},
			isBankEftve: {
				required: true, //必填
			},
			custPdut:{
				maxlength: 10,
				zh_chint:true
			},
			custAd:{
				maxlength: 500,
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
	 
	 //客户类型查询
		$.ajax({
			url: contextPath+'/basicconfig/custtype?ftype=all&_method=get', 
			//type: "get",
			dataType: "json",
			contentType: "application/json",
			//data: '{}',
			traditional: true,
			success: function(data) {
				var $custLevel = $("#dialog-new").find("form").find("select[name=custLevel]");
				var $option = "";
				
				//遍历该数据，动态拼接成一个html样式
				for(var i in data) {
					$option = $('<option value=\"' + data[i].custLevel + '\">' + data[i].custName +'</option>');
					$option.appendTo($custLevel); //最后追加到父元素里面
				}
				//$custLevel.selectpicker('refresh');
			},
			error: function(msg) {
				alert("出错了！");
			}
		})
		
	 
});

/**
 * 新增本地客户
 */
function newCusInfo()
{
	
    //logBehavior("log.behavior.dialog.open", ["user.list", "new"]);
	//绑定对话框
	$newDialog = $("#dialog-new").removeClass("hide").dialog({
		modal: true, //模式对话框
		title: '<i class="ace-icon fa fa-pencil-square-o bigger-250"></i><span class="ui-jqdialog-title" style="float: left;"> 新增</span>',
		title_html: true,
		width:"500",
		height:"500",
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
			
			//清理数据之前，先记录原先的机构id和机构名称，清理之后，再填充回去
			var tmpOrgId = $("#dialog-new").find("form").find("input[name=orgId]").val();
			var tmpOrgName = $("#dialog-new").find("form").find("input[name=orgName]").val();

			//清除验证信息
			$("div").removeClass("has-error");
			$("div").remove(".help-block");

			//清空上一次的表单数据
			$("#dialog-new").find("form").clearForm(true);
			
			//回填值
			$("#dialog-new").find("form").find("input[name=orgId]").val(tmpOrgId);
			$("#dialog-new").find("form").find("input[name=orgName]").val(tmpOrgName);
		}
	});
}

/**
 * 保存记录
 */
function save(){
	 
	//1.验证失败
	 if (!$("#dialog-new").find("form").valid()){
		 return ;
	 }
	 
	 
	 var formjson = $("#dialog-new").find("form").serialize();
	 //alert(formjson);
	 var url = contextPath + "/basicconfig/cusinfo?dt="+(new Date().getTime());
     $.post(url, formjson, function(result)
     {
         if (result.errorCode == '0')
         {
        	//弹出对话框
         	$.alert({
                 title: '提示信息',
                 icon:'fa fa-info-circle blue',
                 theme:'bootstrap',
                 content: '本地客户增加成功',
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
         }else if(result.errorCode == '2'){
        	 $.alert({
                 title: '提示信息',
                 icon:'fa fa-info-circle red',
                 theme:'bootstrap',
                 content: '客户识别码已存在',
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
                 content: '本地客户增加失败',
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

/**
 * 
 */
function fillCustId (selNode){
	$("#dialog-new").find("form").find("input[name=custId]").val(selNode.orgCode);
}
