var orgId = "";
var deviceNo = "";
var $AdType;
var $acdAds;
var $compositeAds;
var $screenAds;
var $formAds;

$(function (){
	$AdType = $("#AdType");
	$acdAds = $("#acdAds");
	$compositeAds = $("#compositeAds");
	$screenAds = $("#screenAds");
	$formAds = $("#formAds");
	
	$("#SaveCompositeAds").click(function(){
		SaveAndSend('2');
	});
	$("#SaveScreenAds").click(function(){
		SaveAndSend('1');
	});
});
	
    
//查询
function searchCondition(){
	 orgId = $("#searchFrom").find("input[name=orgId]").val();
	 deviceNo = $("#searchFrom").find("input[name=deviceNo]").val();
	 if(orgId=="" || deviceNo==""){
		 qmsVld.showInfo("请先选择一个机构设备！!");
	 }else{
		 initPage();
	 }
}

function initPage(){
	var arg ={};
	arg.orgId = orgId ;
	arg.deviceNo = deviceNo ;
	
	$.ajax({
   		 url: contextPath+"/businessconfig/adpublish/selectByDeviceNo?dt="+(new Date().getTime()), 
   		 type : "post",
   		 dataType: "json",
   		 data :$.toJSON(arg),
   		 contentType: "application/json",
   		 success: function(data) {
   			 if(data.length==0){
   				qmsVld.showInfo("该机构设备无广告！");
				$compositeAds.val("") ; 
				$screenAds.val("") ; 
   			 }
   			 for(var i = 0; i < data.length; i++){
   				 item = data[i] ;
   				 if(item.advType=='1'){
   					$screenAds.val(item.advContent) ; 
				 }else{
					$compositeAds.val(item.advContent) ; 
				 }
   				 $("#ip").val(data[0].ipAddr);
   			 }
   			$AdType.show();
   		 },
   		 error: function(msg) {
   			alert("出错了！");
   		 } 
    })
}


function SaveAndSend(advType){
	orgId = $("#searchFrom").find("input[name=orgId]").val();
	deviceNo = $("#searchFrom").find("input[name=deviceNo]").val();
	var ip = $("#searchFrom").find("input[name=ip]").val();
	var compositeAds = $compositeAds.val();
	var screenAds = $screenAds.val();
	
	//先校验，过滤非法字符<>#'  by tianjm 20181113
	if(!/^[\u4e00-\u9fa5_a-zA-Z0-9,.，。【】[]\“\"]*$/i.test(compositeAds)){
		qmsVld.showError("综合屏广告内容不能包含非法字符！");
		return;
	}
	if(!/^[\u4e00-\u9fa5_a-zA-Z0-9,.，。【】[]\“\"]*$/i.test(screenAds)){
		qmsVld.showError("条屏广告内容不能包含非法字符！");
		return;
	}
	
	var arg = {};
	arg.orgId = orgId;
	arg.deviceNo = deviceNo;
	arg.advType = advType;
	arg.devName = $("#devName").val();
	if(advType == '1'){
		arg.advContent = screenAds;
	}else if(advType == '2'){
		arg.advContent = compositeAds;
	}
	arg.ip = ip;
	$.ajax({
  		 url: contextPath+"/businessconfig/adpublish/saveandsend?dt="+(new Date().getTime()), 
  		 type : "post",
  		 dataType: "json",
  		 data :$.toJSON(arg),
  		 contentType: "application/json",
  		 success: function(data) {
			 if(data.errorCode == 0){
				 qmsVld.showInfo("保存并发送成功！");
				 initPage();
			 }else{
				 qmsVld.showInfo("保存并发送失败！");
			 }
  		 },
  		 error: function(msg) {
  			alert("出错了！");
  		 } 
   })
}

    