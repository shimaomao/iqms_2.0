var params, bizTypeId, index, busType;
var $rowNum = 0;
var $winNum = 0;
var index = 0;
var $tbody = $("#ccc tbody");
var delRowidArr = [];
var orgId = "";
var deviceNo = "";
var orgName = "";
var devName = "";
$(function() {
	params = $.string(decodeURI(window.location.href)).toQueryParams();
	devName = params["devName"];
	if(ndeviceNo!='' && ndeviceNo != null){
		$("#orgName").attr('disabled',true);
//		$("#deviceNo").attr('disabled',true);
		$("#orgName").val(norgName);
		$("#orgId").val(norgId);
		$("#deviceNo").val(ndeviceNo);
		$("#orderFlag").val(norderFlag);
		$("#onlineModel").val(nonlineModel);
		$("#tpscrollFlag").val(ntpscrollFlag);
	}
	$("#prev").attr('disabled', true);
	//form绑定验证框架
	 $("#step").find("form").validate({
		errorElement: 'div',   //错误信息包装元素
		errorClass: 'help-block', //错误的样式
		focusInvalid: false, //提交表单后未通过验证的表单会获得焦点
		ignore: "", //对某些元素不进行验证
		rules: { //验证规则
			deviceNo:{
				required: true
			},
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
				
		},
		submitHandler: function (form) {
		},
		invalidHandler: function (form) {
		}
	});
	//绑定时间空监控
	$("#step").find("form").find("input[name=installDate]").datetimepicker({
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
					if(nscreenResolution==map.key){
						sel.append("<option selected='selected' id='"+map.key+"'value='"+map.key+"'>" + map.value + "</option>");
					}else{
						sel.append("<option  id='"+map.key+"'value='"+map.key+"'>" + map.value + "</option>");
					}
//					sel.append("<option id='"+map.key+"'value='"+map.key+"'>" + map.value + "</option>");
				}
			}
		});
	/**
	  * 获取厂家放入下拉框
	  */
	 $.ajax({
			url : contextPath + "/basicconfig/sysdic/suppliers?_method=get&dt="
					+ (new Date().getTime()),
			type : "GET",
			contentType : "application/json; charset=utf-8",
			dataType : "json",
			success : function(result) {
				var list = result.rows;
				var map = "";
				var sel = $("#producer");
				sel.append("<option id='"+map.key+"'value=''>请选择</option>");
				for (var i=0; i<list.length; i++){
					map = list[i]; 
					if(nproducer==map.key){
						sel.append("<option selected='selected' id='"+map.key+"'value='"+map.key+"'>" + map.value + "</option>");
					}else{
						sel.append("<option  id='"+map.key+"'value='"+map.key+"'>" + map.value + "</option>");
					}
				}
			}
		});
});

/**
 * 点击下一步
 */
function next(){
	save();
}

/**
 * 保存记录
 */
function save(){
	//1.验证失败
	 if (!$("#step").find("form").valid()){
		 return;
	 }
	 
	 
	 var formjson = $("#step").find("form").serialize();
	 var url = contextPath + "/businessconfig/bscdevice/navcreate?dt="+(new Date().getTime());
     $.post(url, formjson, function(result)
     {
         if (result.errorCode == '0' || result.errorCode == '2')
         {
         	//跳转到快速应用
         	window.location.href = encodeURI(contextPath + "/businessconfig/navconfig/copyToOrg?dt="+(new Date().getTime())
         	+"&deviceNo="+$("#deviceNo").val()+"&orgId="+$("#orgId").val()+"&devName="+devName+"&orgName="+$("#orgName").val());
         }
         else if(result.errorCode == '3')
         {
        	 $.alert({
                 title: '提示信息',
                 icon:'fa fa-info-circle red',
                 theme:'bootstrap',
                 content: 'ip地址已存在',
                 closeIcon: true,
                 buttons:{
                 	 colseWin: {
                      	text: '<i class="ace-icon fa fa-times"></i>关闭',
                          btnClass: 'btn-info'
                      }
                 }
             });
         }else{
        	 $.alert({
                 title: '提示信息',
                 icon:'fa fa-info-circle red',
                 theme:'bootstrap',
                 content: '网点设备创建失败',
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
	if(ndeviceNo!='' && ndeviceNo != null){
		return;
	}
	//获取设备号 
	var url = contextPath + "/businessconfig/getDevice?dt="+(new Date().getTime());
	var formjson = $("#step").find("form").serialize();
    $.post(url, formjson, function(result)
    {
    	$("#step").find("form").find("input[name=deviceNo]").val(result.errorCode);
    }, "json");
}
