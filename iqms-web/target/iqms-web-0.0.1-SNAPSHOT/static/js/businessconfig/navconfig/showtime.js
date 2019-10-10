var zNodes = null;
var $orgDialog;
var zTreeObj;

var rowNum1 = 0;
var tbody1 = $("#ccc1").children().eq(1);
var $rowNum2 = 0;
var $tbody2 = $("#ccc2").children().eq(1);
var delRowidArr = [];
var sltId;
var busId = "";
var orgId = "";
var deviceNo = "";
var delFlag = false;
var params;
var orgName = "";
var devName = "";
var setting = {
	edit : {
		enable : true,
		showRemoveBtn : false,
		showRenameBtn : false
	},
	view : {
		selectedMulti : false
	// 没有多选
	},
	check : {
		enable : false
	// 没有复选框
	},
	data : {
		key : {
			name : "branchName"
		},
		simpleData : { // 使用简单机构组织树
			enable : true, // 是否启用
			idKey : "treeId", // 元素id
			pIdKey : "treePid" // 父元素id
		}
	},
	callback : { // 配置回调函数
		onClick: zTreeOnClick,
//		onRemove: zTreeOnClickRemove
	}
};

$(function() {
	params = $.string(decodeURI(window.location.href)).toQueryParams();
	orgName = params["orgName"];
	devName = params["devName"];
    $("#frm").validate({
      onfocusout: function (element)
      {
        //alert(element.value);
        //$(element).valid(); 
      },
      submitHandler: function (form)
      {
        saveConfig();
        return false;
      }
    });
    $("#addBtn1").on("click", function ()
    {
      initTr1();
    });
    $("#addBtn2").on("click", function ()
    {
      initTr2();
    });
    $("input[name= 'beginTime1']").datetimepicker({
        format: 'hh:ii',
        language: 'zh-CN',
        minuteStep: 1,
        maxView: 0,
        autoclose: true,
        startView: 1,
        todayBtn: 1,
        todayHighlight: 1
      });


      $("input[name='endTime1']").datetimepicker({
        format: 'hh:ii',
        language: 'zh-CN',
        minuteStep: 1,
        maxView: 0,
        autoclose: true,
        startView: 1,
        todayBtn: 1,
        todayHighlight: 1
      });
      $("input[name= 'beginTime2']").datetimepicker({
          format: 'hh:ii',
          language: 'zh-CN',
          minuteStep: 1,
          maxView: 0,
          autoclose: true,
          startView: 1,
          todayBtn: 1,
          todayHighlight: 1
        });


        $("input[name='endTime2']").datetimepicker({
          format: 'hh:ii',
          language: 'zh-CN',
          minuteStep: 1,
          maxView: 0,
          autoclose: true,
          startView: 1,
          todayBtn: 1,
          todayHighlight: 1
        });
        loadDatas();
});

//弹出组织树 选择要应用的设备
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
	        content: '将清空所选下级机构的业务显示数据，确定要应用吗?',
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
	                	var url = contextPath + "/businessconfig/copyshowtime?dt="+(new Date().getTime());
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

var $org = $("#showTimeTree");

//初始化行和序号
function initRow()
{
  rowNum1 = 0;
  $rowNum2 = 0;
  $("#ccc1").children().eq(1).find("tr").remove();
  $("#ccc2").children().eq(1).find("tr").remove();
}
//按钮不可使用
function disabledButton()
{
  $("#CopyToOrg").attr('disabled', true);
  $("#addBtn1").attr('disabled', true);
  $("#addBtn2").attr('disabled', true);
  $("#saveConfig").attr('disabled', true);
}
//设置按钮可用
function abledButton()
{
  $("#CopyToOrg").attr('disabled', false);
  $("#addBtn1").attr('disabled', false);
  $("#addBtn2").attr('disabled', false);
  $("#saveConfig").attr('disabled', false);
}
/**
 * 添加 平日时间
 * @param itemData
 */
function initTr1(itemData)
{
  //取到最大序号+1
  if (tbody1.find("tr:last"))
  {
	  rowNum1 =$.trim ($("#ccc1").find("tr:last").find("td").eq(0).text());
     
  }
  rowNum1++;
  var $tr;

  if (itemData!=null)
  {
    $tr = "<tr>" +
				"<td>" + rowNum1 + "</td>" +
				"<td class=\"center\"><div class=\"controls\"><input readonly name='beginTime" + rowNum1 + "' validate='{required:true,time:true}' class=\"form-control\" value = '" + itemData['beginTime'] + "' placeholder=\"请输入时间(hh:mm)\"></div></td>" +
				"<td class=\"center\"><div class=\"controls\"><input readonly name='endTime" + rowNum1 + "' validate='{required:true,time:true}' class=\"form-control\" value = '" + itemData['endTime'] + "' placeholder=\"请输入时间(hh:mm)\"></div></td>" +
				"<td class=\"center\"><div class=\"controls\"><input  name='maxNum" + rowNum1 + "' maxlength='4' digits='true' class=\"form-control\" value = '" + itemData['maxNum'] + "' placeholder=\"请输入整数\"></div></td>" +
				"<td class=\"center\"><a class=\"btn btn-danger\" href=\"#\" onclick='delTr(this);'><i class=\"glyphicon glyphicon-trash icon-white\"></i>删除</a></td>" +
		  "</tr>";
  } else
  {
    $tr = "<tr>" +
				"<td>" + rowNum1 + "</td>" +
				"<td class=\"center\"><div class=\"controls\"><input  readonly name='beginTime" + rowNum1 + "' validate='{required:true,time:true}' class=\"form-control\" value=\"08:00\" placeholder=\"请输入时间(hh:mm)\"></div></td>" +
				"<td class=\"center\"><div class=\"controls\"><input  readonly name='endTime" + rowNum1 + "' validate='{required:true,time:true}' class=\"form-control\"  value=\"18:00\" placeholder=\"请输入时间(hh:mm)\"></div></td>" +
				"<td class=\"center\"><div class=\"controls\"><input  name='maxNum" + rowNum1 + "' maxlength='4' digits='true' class=\"form-control\" value = \"0\" placeholder=\"请输入整数\"></div></td>" +
				"<td class=\"center\"><a class=\"btn btn-danger\" href=\"#\" onclick='delTr(this);'><i class=\"glyphicon glyphicon-trash icon-white\"></i>删除</a></td>" +
			"</tr>";
  }
  $("#tbody1").append($tr);
  $("input[name= 'beginTime" + rowNum1 + "']").datetimepicker({
    format: 'hh:ii',
    language: 'zh-CN',
    minuteStep: 1,
    maxView: 0,
    autoclose: true,
    startView: 1,
    todayBtn: 1,
    todayHighlight: 1
  });


  $("input[name='endTime" + rowNum1 + "']").datetimepicker({
    format: 'hh:ii',
    language: 'zh-CN',
    minuteStep: 1,
    maxView: 0,
    autoclose: true,
    startView: 1,
    todayBtn: 1,
    todayHighlight: 1
  });
}
/**
 * 添加假日时间
 * @param itemData
 */
function initTr2(itemData)
{
	//取到最大序号+1
	  if ($tbody2.find("tr:last"))
	  {
		  rowNum2 =$.trim ($("#ccc2").find("tr:last").find("td").eq(0).text());
	     
	  }
	  rowNum2++;
	  var $tr;

	  if (itemData!=null)
	  {
	    $tr = "<tr>" +
					"<td>" + rowNum2 + "</td>" +
					"<td class=\"center\"><div class=\"controls\"><input readonly name='beginTime" + rowNum2 + "' validate='{required:true,time:true}' class=\"form-control\" value = '" + itemData['beginTime'] + "' placeholder=\"请输入时间(hh:mm)\"></div></td>" +
					"<td class=\"center\"><div class=\"controls\"><input readonly name='endTime" + rowNum2 + "' validate='{required:true,time:true}' class=\"form-control\" value = '" + itemData['endTime'] + "' placeholder=\"请输入时间(hh:mm)\"></div></td>" +
					"<td class=\"center\"><div class=\"controls\"><input  name='maxNum" + rowNum2 + "' maxlength='4' digits='true' class=\"form-control\" value = '" + itemData['maxNum'] + "' placeholder=\"请输入整数\"></div></td>" +
					"<td class=\"center\"><a class=\"btn btn-danger\" href=\"#\" onclick='delTr(this);'><i class=\"glyphicon glyphicon-trash icon-white\"></i>删除</a></td>" +
				"</tr>";
	  } else
	  {
	    $tr = "<tr>" +
					"<td>" + rowNum2 + "</td>" +
					"<td class=\"center\"><div class=\"controls\"><input  readonly name='beginTime" + rowNum2 + "' validate='{required:true,time:true}' class=\"form-control\" value=\"08:00\" placeholder=\"请输入时间(hh:mm)\"></div></td>" +
					"<td class=\"center\"><div class=\"controls\"><input  readonly name='endTime" + rowNum2 + "' validate='{required:true,time:true}' class=\"form-control\"  value=\"18:00\" placeholder=\"请输入时间(hh:mm)\"></div></td>" +
					"<td class=\"center\"><div class=\"controls\"><input  name='maxNum" + rowNum2 + "' maxlength='4' digits='true' class=\"form-control\" value = \"0\" placeholder=\"请输入整数\"></div></td>" +
					"<td class=\"center\"><a class=\"btn btn-danger\" href=\"#\" onclick='delTr(this);'><i class=\"glyphicon glyphicon-trash icon-white\"></i>删除</a></td>" +
				"</tr>";
	  }
	  $("#tbody2").append($tr);
	  $("input[name= 'beginTime" + rowNum2 + "']").datetimepicker({
	    format: 'hh:ii',
	    language: 'zh-CN',
	    minuteStep: 1,
	    maxView: 0,
	    autoclose: true,
	    startView: 1,
	    todayBtn: 1,
	    todayHighlight: 1
	  });


	  $("input[name='endTime" + rowNum2 + "']").datetimepicker({
	    format: 'hh:ii',
	    language: 'zh-CN',
	    minuteStep: 1,
	    maxView: 0,
	    autoclose: true,
	    startView: 1,
	    todayBtn: 1,
	    todayHighlight: 1
	  });
}


/**
 * 删除
 */
function delTr(obj)
{
  var $tr = $(obj).parent().parent();
  var itemData = $tr.data("itemData");
  delFlag = true;
  var $tbody = $tr.parent();
  $tr.remove();
  //重新计算序号
  var $trs = $tbody.find("tr");
  $.each($trs, function (index, item)
  {
    $(item).find("td").eq(0).text(index + 1);
  });
}

/**
 * showTimeTree 添加点击事件
 */
function zTreeOnClick(event, treeId, treeNode) {
	initRow();
	var businessType = treeNode.businessType; 
	var levelNum = treeNode.LEVELNUM; 
//	if(businessType == '0'){
//		disabledButton();
//		return;
//	}
	// tianjm  根业务不能配置 20181127
	if (levelNum == '0') {
		disabledButton();
		return;
	}
	
	
	busId = treeNode.busId;
	orgId = treeNode.orgId;
	deviceNo = treeNode.deviceNo;
	$.ajax({
		url : contextPath + "/businessconfig/bscshowtime?dt="
				+ (new Date().getTime()),
		type : "get",
		data :{"orgId":orgId,"deviceNo":deviceNo,"businessId":busId},
		dataType : "json",
		contentType : "application/json",
		success : function(datas) {
			var list = datas.rows;
			for(var i=0; i<list.length; i++){
				var map = list[i];
				if(map["dateType"]=='N'){
					//初始化信息  json对象    平日
					initTr1(list[i]);
				}
				if(map["dateType"]=='H'){
					//初始化信息  json对象  假 日
					initTr2(list[i]);
				}
			}
		}
	});
	abledButton();
};


function validateInfo(obj, str)
{

  var isVaild = true;
  var beginTime, endTime, beginTime2, endTime2,maxNum;
  for (var i = 0; i < obj.length; i++)
  {
    beginTime = obj.eq(i).find("input").eq(0).val();
    endTime = obj.eq(i).find("input").eq(1).val();
    maxNum = obj.eq(i).find("input").eq(2).val();
    if(maxNum<0 || maxNum =="" || maxNum==null){
    	qmsVld.showError("取号数量必须大于等于0且不能为空");
    	return false;
    }
    isVaild = endTime >= beginTime;
    if (!isVaild)
    {
      qmsVld.showError(str + "第" + (i + 1) + "行结束日期必须大于开始日期");
      return false;
    }
    
    for (var j = i + 1; j < obj.length; j++)
    {
      beginTime2 = obj.eq(j).find("input").eq(0).val();
      endTime2 = obj.eq(j).find("input").eq(1).val();
      if (beginTime < beginTime2)
      {
        if (endTime >= beginTime2)
        {
          qmsVld.showError(str + "第" + (i + 1) + "行与第" + (j + 1) + "行日期范围重复");
          return false;
        }
      } else if (beginTime > beginTime2)
      {
        if (beginTime <= endTime2)
        {
          qmsVld.showError(str + "第" + (i + 1) + "行与第" + (j + 1) + "行日期范围重复");
          return false;
        }
      } else
      {
        qmsVld.showError(str + "第" + (i + 1) + "行与第" + (j + 1) + "行日期范围重复");
        return false;
      }
    }
  }
  return true;
}

/**
 * 点击下一步 进入号票模板
 */
function next(){
	window.location.href = encodeURI(contextPath + "/businessconfig/navconfig/ticketform?dt="+(new Date().getTime())
 	+"&deviceNo="+$("#deviceNo").val()+"&orgId="+$("#orgId").val()+"&devName="+devName
 	+"&orgName="+orgName);
}

/**
 * 返回上一步 进入网点业务
 * @param orgId
 */
function back(){
	//跳转到快速应用
 	window.location.href = encodeURI(contextPath + "/businessconfig/navconfig/branchbus?dt="+(new Date().getTime())
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
	}
}

function saveConfig()
{
  var $trs1 = $("#ccc1 tbody tr");
  var $trs2 = $("#ccc2 tbody tr");
  if (!validateInfo($trs1, "平日")) return;
  if (!validateInfo($trs2, "假日")) return;

  var list = [];
  var jo;
  var $tds = null;
  if(delFlag){
	jo = {};
	jo.orgId = orgId;
    jo.deviceNo = deviceNo;
    jo.businessId = busId;
    jo.saveStatus = "deleted";
    list.push(jo); 
  }
  $.each($trs1, function (index, item)
  {
    jo = {};
    $tds = $(item).find("td");
    jo.orgId = orgId;
    jo.deviceNo = deviceNo;
    jo.businessId = busId;
    jo.dateType = 'N';
    jo.beginTime = $tds.eq(1).find("input").eq(0).val();
    jo.endTime = $tds.eq(2).find("input").eq(0).val();
    jo.maxNum =  $tds.eq(3).find("input").eq(0).val();
    jo.rowId = $tds.eq(0).text();
    jo.saveStatus = "inserted";
    list.push(jo);
  });
  $.each($trs2, function (index, item)
		  {
		    jo = {};
		    $tds = $(item).find("td");
		    jo.orgId = orgId;
		    jo.deviceNo = deviceNo;
		    jo.businessId = busId;
		    jo.dateType = 'H';
		    jo.beginTime = $tds.eq(1).find("input").eq(0).val();
		    jo.endTime = $tds.eq(2).find("input").eq(0).val();
		    jo.rowId = $tds.eq(0).text();
		    jo.maxNum =  $tds.eq(3).find("input").eq(0).val();
		    jo.saveStatus = "inserted";
		    list.push(jo);
		  });
  $.ajax({
		url : contextPath + "/businessconfig/bscshowtime?_method=delete&dt="
				+ (new Date().getTime()),
		type : "post",
		data :$.toJSON(list),
		dataType : "json",
		contentType : "application/json",
		success : function(result) {
			if (result.errorCode == '0')
	         {
				$.alert({
	                 title: '提示信息',
	                 icon:'fa fa-info-circle blue',
	                 theme:'bootstrap',
	                 content: '业务显示保存成功',
	                 closeIcon: true,
	                 buttons:{
	                 	 colseWin: {
	                      	text: '<i class="ace-icon fa fa-times"></i>关闭',
	                          btnClass: 'btn-info'
	                      }
	                 }
	             });
	         }
	         else if(result.errorCode == '1')
	         {
	        	 $.alert({
	                 title: '提示信息',
	                 icon:'fa fa-info-circle red',
	                 theme:'bootstrap',
	                 content: '业务显示保存失败',
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

 //查询
function searchCondition() {
	 loadDatas();
}


// //执行查询方法
function loadDatas() {
	// 获取参数对象
	var orgId = $("#orgId").val();
	var deviceNo = $("#deviceNo").val();
	var nodes ={ treeId:"0", treePid:"", branchName:"业务配置", orgId:"",deviceNo:"",businessType:"0",isParent: true, open:true};
	$.ajax({
		url : contextPath + "/businessconfig/branchBusTree?dt="
				+ (new Date().getTime()),
		type : "get",
		data :{"orgId":orgId,"deviceNo":deviceNo},
		dataType : "json",
		contentType : "application/json",
		success : function(datas) {
			 var zNodes = datas.rows;
			 for (var i =0; i<zNodes.length; i++){
					if(zNodes[i].treePid == '0'){
						zNodes[i].isParent=true;
					}
				}
			// 初始化网点业务组织树
			zTreeObj = $.fn.zTree.init($("#showTimeTree"), setting, zNodes);
			zTreeObj.expandAll(true); 
		}
	});
}
