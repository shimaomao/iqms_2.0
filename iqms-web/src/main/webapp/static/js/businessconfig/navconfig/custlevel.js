var $rowNum = 0;
var level = -1;
var jobuzType = null;
var joTmp = null;
var businessList = null;
var ticketList = null;
var custTypeList = null;//sys_dic 表客户类型
var orgId = "";
var deviceNo = "";
var params;
var orgName = "";
var devName = "";
$(function() {
	params = $.string(decodeURI(window.location.href)).toQueryParams();
	orgName = params["orgName"];
	devName = params["devName"];
	$("#frm").validate({
		onfocusout : function(element) {
			$(element).valid();
		},
		submitHandler : function(form) {
			saveConfig();
			return false;
		}
	});
	searchCondition();
});
// -----------------------------------------------------------------------------------------------------------------------------------------------------------------------
//按钮不可使用
function disabledButton()
{
  $("#addBtn").attr('disabled', true);
  $("#CopyToOrg").attr('disabled', true);
  $("#saveConfig").attr('disabled', true);
}

//设置按钮可用
function abledButton()
{
  $("#addBtn").attr('disabled', false);
  $("#CopyToOrg").attr('disabled', false);
  $("#saveConfig").attr('disabled', false);
}

function orgDeviceTree(orgId){
	//1.定义ztree的配置
	var setting = {
            view: {
                selectedMulti: true  //没有多选
            },
            check: {
            	enable: true,
        		chkStyle: "checkbox",
        		chkboxType: { "Y": "s", "N": "s" }
            },
            data: {
            	key:{
            		name:"devName"
            	},
                simpleData: {    //使用简单机构组织树
                    enable: true,  //是否启用
                    idKey:"cId",  //元素id
                    pIdKey:"pId"  //父元素id
                }
            }
        };
	//ajax请求加载数据
	 $.ajax({
        url : contextPath + "/businessconfig/ztreeorgdevice?dt="+(new Date().getTime()),
        type : "get",
        dataType : "json",
        contentType : "application/json",
        data : {"orgId":orgId},
        success : function(datas)
        {
       	 var zNodes = datas.rows;
       	 
       	 zTreeObj = $.fn.zTree.init($("#orgTree"), setting, zNodes);
			var title = "";
			
			title = '<i class="ace-icon fa fa-sitemap bigger-200 "></i><span class="ui-jqdialog-title" style="float: left;"> 机构选择</span>';
			//打开对话框
			$orgDialog = $("#dialog-org").removeClass("hide").dialog({
				modal: true, //模式对话框
				title: title,
				title_html: true,
				width:"380",
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
						//获取被勾选的节点的值
						var selNodes = zTreeObj.getCheckedNodes(true);
						if (selNodes != null && selNodes.length > 0){
							var selNode = selNodes[0];
							var orgDevicelist = '';
							for(var i=0;i<selNodes.length;i++){
								orgDevicelist += selNodes[i].devName + ","+selNodes[i].cId+","+selNodes[i].pId+";"
							}
							$("#orgDevicelist").val(orgDevicelist);
						}
						$(this).dialog("close");
						copyToOrg();
					}
				}]
			});
        }
	 });
	 
}
//应用到下级机构
function copyToOrg(){
	if($("#orgDevicelist").val()!="" && $("#orgDevicelist").val()!=null){
		var jc = $.confirm({
	        title: '应用到下级机构',
	        icon: 'fa fa-warning red',
	        theme:'bootstrap',
	        content: '将清空所选下级机构的客户等级设置，确定要应用吗?',
	        draggable: true,
	        closeIcon: true,
	        offsetTop: 150,
	        columnClass: 'col-md-6 col-md-offset-2 col-xs-4 col-xs-offset-8',
	        buttons:{
	            cancel: {
	                text: '<i class="ace-icon fa fa-times"></i>取消',
	                btnClass: 'btn-default'
	            },
	            ok: {
	                text: '<i class="ace-icon fa fa-check"></i>确定',
	                btnClass: 'btn-info',
	                action: function(){
	                	var data = {};
	                	data.orgId = orgId;
	                	data.deviceNo = deviceNo;
	                	data.orgDevicelist = $("#orgDevicelist").val();
	                	var url = contextPath + "/businessconfig/copycustLevel?dt="+(new Date().getTime());
		           	     $.post(url, data, function(result)
		           	     {
		           	         if (result.errorCode == '0')
		           	         {
		           	        	//弹出对话框
		           	         	$.alert({
		           	                 title: '提示信息',
		           	                 icon:'fa fa-info-circle blue',
		           	                 theme:'bootstrap',
		           	                 content: '应用到下级机构成功',
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
		           	         else if(result.errorCode == '2'){
		           	        	$.alert({
		           	                 title: '提示信息',
		           	                 icon:'fa fa-info-circle red',
		           	                 theme:'bootstrap',
		           	                 content: '请先保存配置',
		           	                 closeIcon: true,
		           	                 buttons:{
		           	                 	 colseWin: {
		           	                      	text: '<i class="ace-icon fa fa-times"></i>关闭',
		           	                          btnClass: 'btn-info'
		           	                      }
		           	                 }
		           	             });
		           	         }else
		           	         {
		           	        	 $.alert({
		           	                 title: '提示信息',
		           	                 icon:'fa fa-info-circle red',
		           	                 theme:'bootstrap',
		           	                 content: '应用到下级机构失败',
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
	            }
	        }
	    });
	}else{
		qmsVld.showError("请先选择要应用的下级机构");
	    return false;
	}
}

function initData2(){
	// 取到最大序号+1
	$tbody = $("#ccc tbody");
	if ($tbody.find("tr:last")) {
		var num = $tbody.find("tr:last").find("td").eq(0).text();
		if (num) {
			level = num;
			num++;
			$rowNum = num;
		}
	}
	$rowNum++;
	level++;
	var $tr;
	var  isStart= "";
	
	$tr = $("<tr>" + "<td>"
			+ level
			+ "</td>"
			+ "<td><div class=\"controls\"><input name='levelName"
			+ $rowNum
			+ "'  'required='true' maxlength='10' zh_chint ='true'  validate='{required:true,byteRangeLength:[0,20]}' class=\"form-control\" value = '"
			+ '级别'+custTypeList[$rowNum-1]["custLevel"]
			+ "' id='"+custTypeList[$rowNum-1]["custLevel"]+"' placeholder=\"请输入等级名称\"></div></td>"
			+ "<td><div class=\"controls\"><select  name='businessId"
			+ $rowNum
			+ "' validate='{required:false}'  data-rel=\"chosen\" style=\"width: 80%;\" >"
			+ init_select_Buz(businessList, '')
			+ "</select></div></td>"
			+ "<td><div class=\"controls\"><input  name='priorTime"
			+ $rowNum
			+ "' maxlength='5' digits='true' validate='{required:false,digits:true,range:[0,999]}' class=\"form-control\" value = '' placeholder=\"请输入优先时间\"></div></td>"
			+ "<td><div class=\"controls\"><input  name='callHead"
			+ $rowNum
			+ "'  maxlength='5' zm_sz2='true' required='true' validate='{required:true,maxlength:2,chrnum:true}'  class=\"form-control\" value = '' placeholder=\"请输入呼叫字头\"></div></td>"
			+ "<td><div class=\"controls\"><input  name='maxWaitTime"
			+ $rowNum
			+ "'  maxlength='5' digits='true' validate='{required:false,digits:true,range:[0,999]}'  class=\"form-control\" value = '' placeholder=\"请输入最大等候时间\"></div></td>"
			+ "<td><div class=\"controls\"><select  name='ticketTemplate"
			+ $rowNum
			+ "' validate='{required:false}'  data-rel=\"chosen\" style=\"width: 80%;\" >"
			+ init_select_Temp(ticketList, '')
			+ "</select></div></td>"
			+ "<td><div class=\"controls\"><input data-no-uniform=\"true\" checked type=\"checkbox\" class=\"iphone-toggle\"></div></td>" + "</tr>");
	$("#tbody").append($tr);
}
function initData(itemData) {
	// 取到最大序号+1
	$tbody = $("#ccc tbody");
	if ($tbody.find("tr:last")) {
		var num = $tbody.find("tr:last").find("td").eq(0).text();
		if (num) {
			level = num;
			num++;
			$rowNum = num;
		}
	}
	$rowNum++;
	level++;
	var $tr;
	var  isStart= "";
	if (itemData.isStart=='1') {
		isStart = "checked";
	}

	if (itemData) {
		$tr = $("<tr>" + "<td>"
				+ level
				+ "</td>"
				+ "<td><div class=\"controls\"><input name='levelName"
				+ $rowNum
				+ "'  required='true' maxlength='10' zh_chint ='true'  validate='{required:true,byteRangeLength:[0,20]}' class=\"form-control\" value = '"
				+ itemData.levelName
				+ "' id='"+itemData.custLevel+"' placeholder=\"请输入等级名称\"></div></td>"
				+ "<td><div class=\"controls\"><select  name='businessId"
				+ $rowNum
				+ "' validate='{required:false}'  data-rel=\"chosen\" style=\"width: 80%;\" >"
				+ init_select_Buz(businessList, itemData.businessId)
				+ "</select></div></td>"
				+ "<td><div class=\"controls\"><input  name='priorTime"
				+ $rowNum
				+ "' maxlength='5' digits='true'  validate='{required:false,digits:true,range:[0,999]}' class=\"form-control\" value = '"
				+ (itemData.priorTime==null?'':itemData.priorTime)
				+ "' placeholder=\"请输入优先时间\"></div></td>"
				+ "<td><div class=\"controls\"><input  name='callHead"
				+ $rowNum
				+ "'  maxlength='5' zm_sz2='true' required='true' validate='{required:true,maxlength:2,chrnum:true}'  class=\"form-control\" value = '"
				+ (itemData.callHead==null?'':itemData.callHead)
				+ "' placeholder=\"请输入呼叫字头\"></div></td>"
				+ "<td><div class=\"controls\"><input  name='maxWaitTime"
				+ $rowNum
				+ "'  maxlength='5' digits='true'  validate='{required:false,digits:true,range:[0,999]}'  class=\"form-control\" value = '"
				+ (itemData.maxWaitTime==null?'':itemData.maxWaitTime)
				+ "' placeholder=\"请输入最大等候时间\"></div></td>"
				+ "<td><div class=\"controls\"><select  name='ticketTemplate"
				+ $rowNum
				+ "' validate='{required:false}'  data-rel=\"chosen\" style=\"width: 80%;\" >"
				+ init_select_Temp(ticketList, itemData.ticketTemplate)
				+ "</select></div></td>"
				+ "<td><div class=\"controls\"><input data-no-uniform=\"true\" type=\"checkbox\"  "
				+ isStart + " class=\"iphone-toggle\"></div></td>" + "</tr>");
	}
	 $("#tbody").append($tr);
}

function checkData()
{
  var $trs = $("#ccc tbody tr");
  var size = $trs.length;
  var levelName, callHead, levelName2;
  for (var i = 0; i < size; i++)
  {
	levelName = $trs.eq(i).find("input").eq(0).val();
	callHead = $trs.eq(i).find("input").eq(2).val();
    if(levelName == ""){
    	qmsVld.showError("请输入客户等级名称");
        return false;
    }
    if(callHead == ""){
    	qmsVld.showError("请输入呼叫字头");
        return false;
    }
    for (var j = (i + 1); j < size; j++){
    	levelName2 = $trs.eq(j).find("input").eq(0).val();
    	if(levelName == levelName2){
    		qmsVld.showError("第" + (i + 1) + "行与第" + (j + 1) + "行客户等级名称重复,请重新输入", $trs.eq(i).find("input").eq(0).get(0));
            return false;
    	}
    }
  }
  return true;
}	
/**
 * 点击下一步 进入客户识别
 */
function next(){
 	saveConfig();
}

/**
 * 返回上一步 进入业务显示
 * @param orgId
 */
function back(){
	//跳转到快速应用
 	window.location.href = encodeURI(contextPath + "/businessconfig/navconfig/ticketform?dt="+(new Date().getTime())
 	+"&deviceNo="+$("#deviceNo").val()+"&orgId="+$("#orgId").val()+"&devName="+devName
 	+"&orgName="+orgName);
}

/**
 * 点击向导栏图标跳转到指定页面
 * @param e
 */
function redirect(e){
	if(e.getAttribute("data-step")=='1'){
		//跳转到创建设备
	 	window.location.href = encodeURI(contextPath + "/businessconfig/navconfig/backdevice?dt="+(new Date().getTime())
	 	+"&deviceNo="+$("#deviceNo").val()+"&devName="+devName);
	}else if(e.getAttribute("data-step")=='2'){
		//跳转到快速应用
     	window.location.href = encodeURI(contextPath + "/businessconfig/navconfig/copyToOrg?dt="+(new Date().getTime())
     	+"&deviceNo="+$("#deviceNo").val()+"&orgId="+$("#orgId").val()+"&devName="+devName
     	+"&orgName="+orgName);
	}else if(e.getAttribute("data-step")=='3'){
		//跳转到窗口配置
	 	window.location.href = encodeURI(contextPath + "/businessconfig/navconfig/winconfig?dt="+(new Date().getTime())
	 	+"&deviceNo="+$("#deviceNo").val()+"&orgId="+$("#orgId").val()+"&devName="+devName
     	+"&orgName="+orgName);
	}else if(e.getAttribute("data-step")=='4'){
		//跳转到网点业务
	 	window.location.href = encodeURI(contextPath + "/businessconfig/navconfig/branchbus?dt="+(new Date().getTime())
	 	+"&deviceNo="+$("#deviceNo").val()+"&orgId="+$("#orgId").val()+"&devName="+devName
     	+"&orgName="+orgName);
	}else if(e.getAttribute("data-step")=='5'){
		window.location.href = encodeURI(contextPath + "/businessconfig/navconfig/showtime?dt="+(new Date().getTime())
		+"&deviceNo="+$("#deviceNo").val()+"&orgId="+$("#orgId").val()+"&devName="+devName
     	+"&orgName="+orgName);
	}else if(e.getAttribute("data-step")=='6'){
		window.location.href = encodeURI(contextPath + "/businessconfig/navconfig/ticketform?dt="+(new Date().getTime())
		+"&deviceNo="+$("#deviceNo").val()+"&orgId="+$("#orgId").val()+"&devName="+devName
     	+"&orgName="+orgName);
	}
}

// 保存
function saveConfig() {
	if (!checkData()) return;
	var $trs = $("#ccc tbody tr");
	var $tds = null;
	var joArr = [];
	$.each($trs, function(index, item) {
		$tds = $(item).find("td");
		var jo = {};
		jo.orgId = orgId;
		jo.deviceNo = deviceNo;
		jo.rowId = $tds.eq(0).text();
		jo.custLevel = $tds.eq(1).find("input").eq(0).attr('id');
		jo.levelName = $tds.eq(1).find("input").eq(0).val();
		jo.businessId = $tds.eq(2).find("select option:selected").val();
		jo.priorTime = $tds.eq(3).find("input").eq(0).val();
		jo.callHead = $tds.eq(4).find("input").eq(0).val();
		jo.maxWaitTime = $tds.eq(5).find("input").eq(0).val();
		jo.ticketTemplate = $tds.eq(6).find("select option:selected").val();
		jo.isStart = ($tds.eq(7).find("input").eq(0).prop("checked") ? "1" : "0");
		joArr.push(jo);
	});
	$.ajax({
  		url : contextPath + "/businessconfig/bsccustlevel/saveBscCustlevel?_method=delete&dt="
  				+ (new Date().getTime()),
  		type : "post",
  		data :$.toJSON(joArr),
  		dataType : "json",
  		contentType : "application/json",
  		success : function(result) {
  			if (result.errorCode == '0')
  	         {
  	        	//弹出对话框
  	         	/*$.alert({
  	                 title: '提示信息',
  	                 icon:'fa fa-info-circle blue',
  	                 theme:'bootstrap',
  	                 content: '客户等级配置保存成功',
  	                 closeIcon: true,
  	                 buttons:{
  	                 	 colseWin: {
  	                      	text: '<i class="ace-icon fa fa-times"></i>关闭',
  	                          btnClass: 'btn-info'
  	                      }
  	                 }
  	             });*/
  				window.location.href = encodeURI(contextPath + "/businessconfig/navconfig/recognition?dt="+(new Date().getTime())
  			 	+"&deviceNo="+$("#deviceNo").val()+"&orgId="+$("#orgId").val()+"&devName="+devName
  			 	+"&orgName="+orgName);
  	         }
  	         else
  	         {
  	        	 $.alert({
  	                 title: '提示信息',
  	                 icon:'fa fa-info-circle red',
  	                 theme:'bootstrap',
  	                 content: '客户等级配置保存失败',
  	                 closeIcon: true,
  	                 buttons:{
  	                 	 colseWin: {
  	                      	text: '<i class="ace-icon fa fa-times"></i>关闭',
  	                          btnClass: 'btn-info'
  	                      }
  	                 }
  	             });
  	         }
  		}
  	});
}

//获取业务名称
function getBusinessName(){
  	$.ajax({
  		url : contextPath + "/businessconfig/getBusiness?_method=get&dt="
  				+ (new Date().getTime()),
  		type : "GET",
  		data:{"orgId":orgId,"deviceNo":deviceNo},
  		contentType : "application/json; charset=utf-8",
  		dataType : "json",
  		success : function(result) {
  			businessList = result.rows;
  			getTicketFormName();
  		}
  	});
}

function init_select_Buz(jo, initValue) {
	var selectorsBuz = "<option value=\"\">不绑定</option>";
	$.each(jo, function(index, item) {
		if (initValue == item.busId) {
			selectorsBuz += "<option selected value=" + item.busId + ">"
					+ item.branchName + "</option>";
		} else {
			selectorsBuz += "<option value=" + item.busId + ">"
					+ item.branchName + "</option>";
		}
	});
	return selectorsBuz;
}
//获取号票模板名称
function getTicketFormName(){
  	$.ajax({
  		url : contextPath + "/businessconfig/ticketform?_method=get&dt="
  				+ (new Date().getTime()),
  		type : "GET",
  		contentType : "application/json; charset=utf-8",
  		data:{"orgId":orgId,"deviceNo":deviceNo},
  		dataType : "json",
  		success : function(result) {
  			ticketList = result[0].tktFormats;
  			for (var i=0; i<custTypeList.length; i++){
				 if(custTypeList[i].levelName == null || custTypeList[i].levelName == ""){
					 initData2(custTypeList[i]);
				 }else{
					 initData(custTypeList[i]);
				 }
			 }
  		}
  	});
}
function init_select_Temp(jo, initValue) {
	var selectorsTicket = "<option value=\"\">请选择一项</option>";
	$.each(jo, function(index, item) {
		if (initValue == item.tktTmpId) {
			selectorsTicket += "<option selected value=" + item.tktTmpId + ">"
					+ item.tktTmpName + "</option>";
		} else {
			selectorsTicket += "<option value=" + item.tktTmpId + ">"
					+ item.tktTmpName + "</option>";
		}
	});
	return selectorsTicket;
}


// 查询
function searchCondition() {
	$rowNum = 0;
    $("#ccc").children().eq(1).find("tr").remove();
    level = -1;
	loadDatas();
}
// 执行查询方法
function loadDatas() {
	// 获取参数对象
	 orgId = $("#orgId").val();
	 deviceNo = $("#deviceNo").val();
	$.ajax({
		url : contextPath + "/businessconfig/bsccustlevel?dt="
				+ (new Date().getTime()),
		type : "get",
		data :{"orgId":orgId,"deviceNo":deviceNo},
		dataType : "json ",
		contentType : "application/json",
		success : function(datas) {
			custTypeList = datas.rows;
			getBusinessName();
		}
	});
}
