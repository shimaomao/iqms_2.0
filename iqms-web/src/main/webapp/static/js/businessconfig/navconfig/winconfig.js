var params, bizTypeId, index, busType;
var $rowNum = 0;
var $winNum = 0;
var index = 0;
var $tbody = $("#ccc tbody");
var delRowidArr = [];
var orgId = "";
var deviceNo = "";
var orgName = "";
var delFlag = false;
var devName = "";

$(function() {
	params = $.string(decodeURI(window.location.href)).toQueryParams();
	orgId = $("#orgId").val();
	deviceNo = $("#deviceNo").val();
	orgName = params["orgName"];
	devName = params["devName"];
	$rowNum = 0;
    $("#ccc").children().eq(1).find("tr").remove();
    $.ajax({
		url : contextPath + "/businessconfig/bscwinconfig?dt="
				+ (new Date().getTime()),
		type : "get",
		data :{"orgId":orgId,"deviceNo":deviceNo},
		dataType : "json",
		contentType : "application/json",
		success : function(datas) {
			 var list = datas.rows;
			 for(var i=0; i<list.length; i++){
				 addTr(list[i]);
			 }
		}
	});
	$("#sample-form").validate({
		onfocusout : function(element) {
			$(element).valid();
		},
		submitHandler : function(form) {
			saveConfig();
			return false;
		}
	});
	$("#addBtn").on("click", function() {
		addTr();
	});

});

/**
 * 点击向导栏图标跳转到指定页面
 * @param e
 */
function redirect(e){
	if(e.getAttribute("data-step")=='1'){
		//跳转到创建设备
	 	window.location.href = encodeURI(contextPath + "/businessconfig/navconfig/backdevice?dt="+(new Date().getTime())
	 	+"&deviceNo="+deviceNo+"&devName="+devName);
	}else if(e.getAttribute("data-step")=='2'){
		//跳转到快速应用
     	window.location.href = encodeURI(contextPath + "/businessconfig/navconfig/copyToOrg?dt="+(new Date().getTime())
     	+"&deviceNo="+deviceNo+"&orgId="+orgId+"&devName="+devName
     	+"&orgName="+orgName);
	}
}

/**
 * 返回上一步
 * @param orgId
 */
function back(){
	//跳转到快速应用
 	window.location.href = encodeURI(contextPath + "/businessconfig/navconfig/copyToOrg?dt="+(new Date().getTime())
 	+"&deviceNo="+deviceNo+"&orgId="+orgId+"&devName="+devName
 	+"&orgName="+orgName);
}

/**
 * 点击下一步
 */
function next(){
 	saveConfig();
}
//特殊日期组校验
function checkData()
{
  if(orgId ==null || orgId==""){
	  qmsVld.showError("请先选择机构和设备");
      return false;
  }
  var $trs = $("#ccc tbody tr");
  var size = $trs.length;
  var counterNo1, counterNo2,barscn,cmpscn;
  for (var i = 0; i < size; i++)
  {
    counterNo1 = $trs.eq(i).find("input").eq(1).val();
    barscn = $trs.eq(i).find("input").eq(4).val();
    cmpscn = $trs.eq(i).find("input").eq(5).val();
    if(counterNo1 ==null || counterNo1==""){
    	qmsVld.showError("窗口号不能为空");
        return false;
    }
    if(barscn ==null || barscn==""){
    	qmsVld.showError("窗口屏不能为空");
        return false;
    }
    if(cmpscn ==null || cmpscn==""){
    	qmsVld.showError("综合屏不能为空");
        return false;
    }
    for (var j = (i + 1); j < size; j++)
    {
      counterNo2 = $trs.eq(j).find("input").eq(1).val();
      if(counterNo2 ==null || counterNo2==""){
      	qmsVld.showError("窗口号不能为空");
        return false;
      }
      if (counterNo1 == counterNo2)
      {
        qmsVld.showError("第" + (i + 1) + "行与第" + (j + 1) + "行窗口号重复,请重新输入", $trs.eq(i).find("input").eq(1).get(0));
        return false;
      }
    }
  }
  return true;
}

function saveConfig()
{
  if (!checkData()) return;

  var joArr = [];
  //遍列tbody tr
  var $trs = $("#ccc tbody tr");
  var $tds = null;
  var jo;
  if(delFlag){
	  jo = {};
	  $.each(delRowidArr, function (index, item)
			  {
		  		jo.winNo = delRowidArr[index].winNo;
		  		jo.orgId = orgId;
		  		jo.deviceNo = deviceNo;
		  		jo.saveStatus = "deleted";
		  		joArr.push(jo);
			  });
  }
  $.each($trs, function (index, item)
  {
    /*  caller   呼叫器
    evaluator 评价器
    barscn  窗口屏
    cmpscn  综合屏
    {"caller":1,"evaluator":1,"barscn":"1|2|5","cmpscn":"2|8"}*/
    jo = {};
    $tds = $(item).find("td");
    jo.saveStatus = "inserted";
    jo.orgId = orgId;
    jo.deviceNo = deviceNo;
    jo.rowId = $tds.eq(0).text();
    jo.winNo = $tds.eq(2).find("input").eq(0).val();
    jo.isStart = ($tds.eq(7).find("input").eq(0).prop("checked")?"1":"0");
    jo.isCall = ($tds.eq(3).find("input").eq(0).prop("checked") ? "1" : "0");
    jo.isJudge = ($tds.eq(4).find("input").eq(0).prop("checked") ? "1" : "0");
    jo.winScreen = $tds.eq(5).find("input").eq(0).val();
    jo.multipleScreen = $tds.eq(6).find("input").eq(0).val();
    joArr.push(jo);
  });

  $.ajax({
		url : contextPath + "/businessconfig/bscwinconfig/saveWinConfig?_method=delete&dt="
				+ (new Date().getTime()),
		type : "post",
		data :$.toJSON(joArr),
		dataType : "json",
		contentType : "application/json",
		success : function(result) {
			if (result.errorCode == '0')
	         {
	         	//跳转到网点业务
	         	window.location.href = encodeURI(contextPath + "/businessconfig/navconfig/branchbus?dt="+(new Date().getTime())
	         	+"&deviceNo="+deviceNo+"&orgId="+orgId+"&devName="+devName
	         	+"&orgName="+orgName);
	         }
	         else
	         {
	        	 $.alert({
	                 title: '提示信息',
	                 icon:'fa fa-info-circle red',
	                 theme:'bootstrap',
	                 content: '窗口配置不能为空',
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

function delTr(winNo,obj)
{
	var jc = $.confirm({
        title: '窗口删除',
        icon: 'fa fa-warning red',
        theme:'bootstrap',
        content: '将级联删除叫号策略所对应的窗口，确定要删除吗?',
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
                	delFlag = true;
                	  var $tr = $(obj).parent().parent();
                	  var $tbody = $tr.parent();
                	  var $trs = $tbody.find("tr");
                	  var del = {};
                	  del.winNo = winNo;
                	  delRowidArr.push(del);
                	  $tr.remove();
                	  if($rowNum>0){
                		  $rowNum--;
                	  }
                	  //重新计算行号
                	  $.each($trs, function (index, item)
                	  {
                	    $(item).find("td").eq(0).text(index + 1);
                	  });
                }
            }
        }
    });
  
}

function addTr(itemData)
{
  //取到最大序号+1
  index++;
  var $trLast = $tbody.find("tr:last");
  if ($trLast)
  {
    var num = $trLast.find("td").eq(0).text();
    var tmpNum = $trLast.find("td").eq(3).text();
    if (num)
    {
      $rowNum = num;
      $winNum = tmpNum;
    }
  }
  $rowNum++;
  $winNum++;
  var $tr;

  var checked1 = "";
  var checked2 = "";
  var checked3 = "";
  if (itemData)
  {
    //呼叫器	评价器	窗口屏	综合屏
	  
	  if (itemData && itemData.isCall == '1')
      {
        checked1 = "checked";
      } 
	  if (itemData && itemData.isJudge == '1')
      {
        checked2 = "checked";
      } 

	  if (itemData && itemData.isStart == '1')
      {
        checked3 = "checked";
      } 


    $tr = $("<tr>" +
			"<td class=\"center\"><div class=\"controls\">" + $rowNum + "</div></td>" +
			"<td class=\"center\"><div class=\"controls\"><input readonly  name='orgName" + index + "'  class=\"form-control\" value='" + itemData.orgName + "'  placeholder=\"\"></div></td>" +
			"<td class=\"center\"><div class=\"controls\"><input  name='winNo" + index + "' maxlength='5' zm_sz2='true' required='true'  class=\"form-control\" value='" + itemData.winNo + "' placeholder=\"窗口号\"></div></td>" +
			"<td class=\"center\"><div class=\"controls\"><input  type=\"checkbox\" " + checked1 + " ></div></td>" +
			"<td class=\"center\"><div class=\"controls\"><input  type=\"checkbox\"  " + checked2 + "></div></td>" +
			"<td class=\"center\"><div class=\"controls\"><input  name='winScreen" + index + "' maxlength='5' required='true' zm_sz2='true' validate='{formatDevice:true,maxlength:20}' class=\"form-control\" value='" + itemData.winScreen + "'  placeholder=\"条屏地址,多个用'|'隔开\"></div></td>" +
			"<td class=\"center\"><div class=\"controls\"><input  name='multipleScreen" + index + "' maxlength='5' zm_sz2='true' validate='{formatDevice:true,maxlength:20}'  class=\"form-control\" value='" + itemData.multipleScreen+ "' placeholder=\"综合屏地址,多个用'|'隔开\"></div></td>" +
			"<td><div class=\"controls\"><input data-no-uniform=\"true\" type=\"checkbox\"  " + checked3 + " class=\"iphone-toggle\"></div></td>" +
			"<td><a class=\"btn btn-danger\" href=\"#\" onclick='delTr("+itemData.winNo+",this);'><i class=\"glyphicon glyphicon-trash icon-white\"></i>删除</a></td>" +
		"</tr>");

  } else
  {
    $tr = $("<tr>" +
			"<td class=\"center\"><div class=\"controls\">" + $rowNum + "</div></td>" +
			"<td class=\"center\"><div class=\"controls\"><input readonly  name='orgName" + index + "'  class=\"form-control\" value='" + orgName + "'  placeholder=\"\"></div></td>" +
			"<td class=\"center\"><div class=\"controls\"><input value=\"" + $rowNum + "\"  name='winNo" + index + "' maxlength='5' zm_sz2='true' required='true'  class=\"form-control\" value='" + $winNum + "' placeholder=\"窗口号\"></div></td>" +
			"<td class=\"center\"><div class=\"controls\"><input  type=\"checkbox\"  ></div></td>" +
			"<td class=\"center\"><div class=\"controls\"><input  type=\"checkbox\"  ></div></td>" +
			"<td class=\"center\"><div class=\"controls\"><input value=\"" + $rowNum + "\"  name='winScreen" + index + "' maxlength='5' required='true' zm_sz2='true' validate='{formatDevice:true,maxlength:20}' class=\"form-control\" placeholder=\"条屏地址,多个用'|'隔开\"></div></td>" +
			"<td class=\"center\"><div class=\"controls\"><input value=\"1\" name='multipleScreen" + index + "' maxlength='5' zm_sz2='true' validate='{formatDevice:true,maxlength:20}'  class=\"form-control\" placeholder=\"综合屏地址,多个用'|'隔开\"></div></td>" +
			"<td><div class=\"controls\"><input data-no-uniform=\"true\" type=\"checkbox\"  class=\"iphone-toggle\"></div></td>" +
			"<td><a class=\"btn btn-danger\" href=\"#\" onclick='delTr(0,this);'><i class=\"glyphicon glyphicon-trash icon-white\"></i>删除</a></td>" +
		"</tr>");

  }
  $("#tbody").append($tr);
}

// //查询
function searchCondition() {
	$rowNum = 0;
    $("#ccc").children().eq(1).find("tr").remove();
	loadDatas();
}

//执行查询方法
function loadDatas() {
	// 获取参数对象
	orgId = jQuery("#searchFrom").find("input[name=orgId]").val();
	deviceNo = jQuery("#searchFrom").find("input[name=deviceNo]").val();
	
}
