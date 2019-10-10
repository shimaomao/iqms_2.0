var $newDialog;

$(function(){

	//form绑定验证框架
	 $("#dialog-new").find("form").validate({
		errorElement: 'div',   //错误信息包装元素
		errorClass: 'help-block', //错误的样式
		focusInvalid: false, //提交表单后未通过验证的表单会获得焦点
		ignore: "", //对某些元素不进行验证
		rules: { //验证规则
			hostName:{
				required: false,
				zh_ch:true,
				maxlength:20
			},
			ipAddr: {   //验证的字段
				required: true, //必填
				//zh_ch:true,       //自定义中英文
				ipv4:true
			},
			macAddr:{
				mac:true,
				maxlength:17
			},
			producer:{
				required: true
			},
			adminName:{
				zh_ch:true,
				maxlength:20
			},
			// tianjm 20181112
			installDate:{
				date:true
			},
			adminPhone:{
				phone:true
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
	//绑定时间空监控
	$("#dialog-new").find("form").find("input[name=installDate]").datetimepicker({
		  language: 'zh-CN',//显示中文
		  format: 'yyyy-mm-dd',//显示格式
		  minView: "month",//设置只显示到月份
		  initialDate: new Date(),//初始化当前日期
		  autoclose: true,//选中自动关闭
		  todayBtn: true//显示今日按钮
	 })
	 
	 /**
	  * 获取分辨率放入下拉框
	  */
	 $.ajax({
			url : contextPath + "/basicconfig/sysdic/screenResolution?_method=get&dt="
					+ (new Date().getTime()),
			type : "GET",
			contentType : "application/json; charset=utf-8",
			dataType : "json",
			success : function(result) {
				var list = result.rows;
				var map = "";
				var sel = $("#screenResolution");
				for (var i=0; i<list.length; i++){
					map = list[i]; 
					sel.append("<option id='"+map.key+"'value='"+map.key+"'>" + map.value + "</option>");
				}
			}
		});
});

/**
 * 新增客户类型
 */
function newDevice()
{

    //logBehavior("log.behavior.dialog.open", ["user.list", "new"]);
	//绑定对话框
	$newDialog = $("#dialog-new").removeClass("hide").dialog({
		modal: true, //模式对话框
		title: '<i class="ace-icon fa fa-pencil-square-o bigger-250"></i><span class="ui-jqdialog-title" style="float: left;"> 新增</span>',
		title_html: true,
		width:"400",
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
			
			//清理数据之前，先记录原先的机构id和机构名称，清理之后，再填充回去
			// var tmpOrgId = $("#dialog-new").find("form").find("input[name=orgId]").val();
			// var tmpOrgName = $("#dialog-new").find("form").find("input[name=orgName]").val();

			//清空上一次的表单数据
			$("#dialog-new").find("form").clearForm(true);

			//清除验证信息
			$("div").removeClass("has-error");
			$("div").remove(".help-block");
			//回填值
			$("#dialog-new").find("form").find("input[name=orgId]").val(1);
			$("#dialog-new").find("form").find("input[name=orgName]").val("总行");

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
	 var url = contextPath + "/businessconfig/bscdevice?dt="+(new Date().getTime());
     $.post(url, formjson, function(result)
     {
         if (result.errorCode == '0')
         {
        	//弹出对话框
         	$.alert({
                 title: '提示信息',
                 icon:'fa fa-info-circle blue',
                 theme:'bootstrap',
                 content: '网点设备增加成功',
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
         }
         else
         {
        	 $.alert({
                 title: '提示信息',
                 icon:'fa fa-info-circle red',
                 theme:'bootstrap',
                 content: '网点设备增加失败',
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
function fillDevNo (){
	//获取设备号 
	var url = contextPath + "/businessconfig/getDevice?dt="+(new Date().getTime());
	var formjson = $("#dialog-new").find("form").serialize();
    $.post(url, formjson, function(result)
    {
    	$("#dialog-new").find("form").find("input[name=deviceNo]").val(result.errorCode);
    }, "json");
//	$.ajax({
//		url : contextPath + "/businessconfig/getDeviceno?dt="
//				+ (new Date().getTime()),
//		type : "get",
//		data:{"orgId":orgId},
//		dataType : "json ",
//		contentType : "application/json",
//		success : function(datas) {
//			$("#dialog-new").find("form").find("input[name=deviceNo]").val(datas.errorCode);
//		}
//	});
}
