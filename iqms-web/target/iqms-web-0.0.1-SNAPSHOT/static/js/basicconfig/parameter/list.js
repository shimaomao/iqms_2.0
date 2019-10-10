$(function() {
	//form绑定验证框架
	 $("#main").find("form").validate({
		errorElement: 'div',   //错误信息包装元素
		errorClass: 'help-block', //错误的样式
		focusInvalid: false, //提交表单后未通过验证的表单会获得焦点
		ignore: "", //对某些元素不进行验证
		rules: { //验证规则
			hbInterval: {   //验证的字段
				required: true, //必填
			},
			authenticationType:{
				required: true,
			},
			flowPort:{
				required: true,
				port:true
			},
			identPort:{
				required: true,
				port:true
			},
			httpPort:{
				required: true,
				port:true
			},
			appRoot:{
				required: true,
				appRoot:true
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
	//获取bc_parameter的参数
	$.ajax({
		url : contextPath + "/basicconfig/parameter?_method=get&dt="
				+ (new Date().getTime()),
		type : "GET",
		contentType : "application/json; charset=utf-8",
		dataType : "json",
		success : function(result) {
			if(result.errorCode == "0"){
				$('#hbInterval').ace_spinner({
					value : 0,
					min : 0,
					max : 20,
					step : 1,
					btn_up_class : 'btn-info',
					btn_down_class : 'btn-info'
				});
			}else{
				var hb = result.hbInterval;
				var type = result.authenticationType;
				var httpPort = result.httpPort;
				var flowPort = result.flowPort;
				var identPort = result.identPort;
				var appRoot = result.appRoot;
				//获取鉴权模式到下拉框
				$.ajax({
					/*url : contextPath + "/basicconfig/authentication?_method=get&dt="
							+ (new Date().getTime()),*/
					url : contextPath + "/basicconfig/sysdic/recognitionType?_method=get&dt="
							+ (new Date().getTime()),
					type : "GET",
					contentType : "application/json; charset=utf-8",
					dataType : "json",
					success : function(result) {
						var list = result.rows;
						var map = "";
						var sel = $("#authenticationType");
						for (var i=0; i<list.length; i++){
							map = list[i]; 
							if(type == map.key){
								sel.append("<option id='"+map.key+"'value='"+map.key+"' selected='selected'>" 
										+ map.value + "</option>");
							}else{
								sel.append("<option id='"+map.key+"'value='"+map.key+"'>" + map.value + "</option>");
							}
						}
					}
				});
				$("#authenticationType").val(type);
				$("#httpPort").val(httpPort);
				$("#flowPort").val(flowPort);
				$("#identPort").val(identPort);
				$("#appRoot").val(appRoot);
				if (hb != "" || hb != null) {
					$('#hbInterval').ace_spinner({
						value : hb,
						min : 0,
						max : 20,
						step : 1,
						btn_up_class : 'btn-info',
						btn_down_class : 'btn-info'
					});
				}else{
					$('#hbInterval').ace_spinner({
						value : 0,
						min : 0,
						max : 20,
						step : 1,
						btn_up_class : 'btn-info',
						btn_down_class : 'btn-info'
					});
				}
			}
		}
	});
});


/**
 * 新增或更新参数
 */
function newParameter(){
	$newDialog = $("#dialog-new").removeClass("hide").dialog({
		modal: true, //模式对话框
		title: '<i class="ace-icon fa fa-pencil-square-o bigger-250"></i><span class="ui-jqdialog-title" style="float: left;"> 保存</span>',
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
				save();
			}
		}],
		open:function(){ //加载数据
			//请空上一次的表单数据
			$("#dialog-new").find("form").clearForm();
			
		}
	});
}


/**
 * 保存记录
 */
function save(){
	 var form = $("#main").find("form");
		//1.验证失败
		 if (!form.valid()){
			 return ;
		 }
	 var formjson = form.serialize();
	 //alert(formjson);
	 var url = contextPath + "/basicconfig/parameter?dt="+(new Date().getTime());
     $.post(url, formjson, function(result)
     {
         if (result.errorCode == '0')
         {
        	//弹出对话框
         	$.alert({
                 title: '提示信息',
                 icon:'fa fa-info-circle blue',
                 theme:'bootstrap',
                 content: '参数保存成功',
                 closeIcon: true,
                 buttons:{
                 	 colseWin: {
                      	text: '<i class="ace-icon fa fa-times"></i>关闭',
                          btnClass: 'btn-info'
                      }
                 }
             });
            //刷新列表
            $newDialog.dialog("close");//关闭窗口
         }
         else 
         {
        	 $.alert({
                 title: '提示信息',
                 icon:'fa fa-info-circle red',
                 theme:'bootstrap',
                 content: '参数保存失败',
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