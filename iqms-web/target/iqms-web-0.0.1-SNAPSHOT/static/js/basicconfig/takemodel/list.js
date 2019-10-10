var params, bizTypeId, index, busType, map, printConfig;
var $offsetX, $offsetY;
var groupType = "tickets";
var $innerMap = null;
var tabIndex = 0;
var maxY = 0;
var $lastSpan = null;
var tktFormats = null;
var $modalTitle = null;
var $styleId = null;
var $styleName = null;
var $actionType = null;
var $myModal = null;
var $def ;
var orgId = "";
var deviceNo = "";

$(function (){
    $modalTitle = $("#modalTitle");
    $styleId = $("#styleId");
    $styleName = $("#styleName");
    $actionType = $("#actionType");
    $myModal = $('#myModal');
    $def = $("#def");

    $.metadata.setType("attr", "validate");
    $("#frm").validate({
        onfocusout: function (element)
        {
            $(element).valid();
        },
        submitHandler: function (form)
        {
            modelSubmit();
            return false;
        }
    });

    $("#addBtn").click(function (e)
    {
        e.preventDefault();
        var itemData = {};
        showModal("new", itemData);
    });

    $('.close').click(function (e)
    {
        e.preventDefault();
        $('#dragPanel').hide();
    });
    
    disabledButton();
    //判断是否是配置界面返回的
    /*params = $.string(window.location.href).toQueryParams();
    orgId = params["orgId"];
    deviceNo = params["deviceNo"];
    if(orgId!=null && deviceNo!=null){
    	searchCondition();
    }*/
});

//按钮不可使用
function disabledButton()
{
  $("#addBtn").attr('disabled', true);
  $("#editBtn").attr('disabled', true);
}

//设置按钮可用
function abledButton()
{
  $("#addBtn").attr('disabled', false);
  $("#editBtn").attr('disabled', false);
}

//查询
function searchCondition(){
	 orgId = $("#searchFrom").find("input[name=orgId]").val();
	 deviceNo = $("#searchFrom").find("input[name=deviceNo]").val();
	 if(orgId=="" || deviceNo==""){
		 qmsVld.showInfo("请先选择一个机构设备！!");
	 }else{
		 $.ajax({
		        url: contextPath+"/basicconfig/takemodelBydeviceNo?dt="+(new Date().getTime()),
		        type : "get",
		        dataType: "json",
		        data:{"orgId":orgId,"deviceNo":deviceNo},
		        contentType: "application/json",
		        success: function(data) {
		        	initPageBydeviceNo(data);
		        },
		        error: function(msg) {
		            alert("出错了！");
		        }
		 })
	 }
}

function onDrag(e)
{
    var d = e.data;
    if (d.left < 0) { d.left = 0 }
    if (d.top < 0) { d.top = 0 }
    if (d.left + $(d.target).outerWidth() > $(d.parent).width())
    {
        d.left = $(d.parent).width() - $(d.target).outerWidth();
    }
    if (d.top + $(d.target).outerHeight() > $(d.parent).height())
    {
        d.top = $(d.parent).height() - $(d.target).outerHeight();
    }
}


function delTr(obj){
    if (window.confirm("确定要删除该模板吗?"))
    {
        var $tr = $(obj).parent().parent();
        var styleId = $tr.data("itemData").styleId;
        
        $.ajax({
      		url: contextPath+"/basicconfig/takemodel?ftype=delete&_method=get",
      		type : "get",
      		dataType: "json",
      		contentType: "application/json",
      		data:{
      			  "styleId":styleId
      			 },
      		success: function(data) {
  			      if (data.errorCode == 0)
  			      {
  			        qmsVld.showInfo("删除取号模板成功！");
  			        searchCondition();//新增、拷贝、编辑完成后关闭模态框，查询号码模板，然后展示
  			      } else
  			      {
  			        qmsVld.showError("删除取号模板失败！");
  			      }
      		},
      		error: function(msg) {
      			alert("出错了！");
      		}
  	      })
    }
}

function editTr(obj){
    var itemData = $(obj).parent().parent().data("itemData");
    window.location.href = contextPath+"/basicconfig/takemodeledit?styleId=" + itemData.styleId + "&styleName=" + itemData.styleName + "&orgId=" + itemData.orgId+"&deviceNo=" + itemData.deviceNo;
}

function showModal(type, itemData) {
    $("#frm input").popover('hide');
    $("#frm input").parent().removeClass("has-error");

    if (type == "new")
    {
        $modalTitle.text("模板新增");
        $styleId.val(0);
        $styleName.val("");
    }
    $actionType.val(type);
    $myModal.modal('show');
}


//新增模板
function modelSubmit(obj){
    $("#myModal input").parent().removeClass("has-error");
    var type = $actionType.val();
    var jo = {};
    jo.styleName = $styleName.val();
    jo.def = $def.prop("checked");//复选框选择是否为默认模板
    jo.styleType = 3;
    
    if (type == "new"){
        jo.styleId = "";

        $.ajax({
            url: contextPath+"/basicconfig/takemodel?ftype=add&_method=get",
            type : "get",
            dataType: "json",
            contentType: "application/json",
            data:{"styleId": jo.styleId,
                  "styleName": jo.styleName,
                  "def":jo.def,
                  "styleType":jo.styleType,
                  "orgId":orgId,
                  "deviceNo":deviceNo
            },
            success: function(data) {
                //alert($.toJSON(data));
                if (data.errorCode == 0)
                {
                    qmsVld.showInfo("新增取号模板成功");
                    searchCondition();//新增、拷贝、编辑完成后关闭模态框，查询模板，然后展示
                } else
                {
                    qmsVld.showError("新增取号模板失败！已存在相同名称的模板,请重新添加");
                }
            },
            error: function(msg) {
                alert("出错了！");
            }
        })

    }
}

function initPageBydeviceNo(data){
	 $('#myModal').modal('hide');
	 $("#ccc").find("tbody").empty().html("");
	 var takeModels = data[0].takeModels ;
     $.each(takeModels, function(index, item){
         //表格序号自动递增
         $windowNum = 0;
         $tbody = $("#ccc tbody");
         if ($tbody.find("tr:last"))
         {
             var num = $tbody.find("tr:last").find("td").eq(0).text();
             if (num)
             {
                 $windowNum = num;
             }
         }
         $windowNum++;

         //返回的数据动态拼接到table中去
         var $tr;
         if (item){
             $tr = $("<tr '>" +
                 "<td>" + $windowNum + "</td>" +
                 "<td>" + item.styleName + "</td>" +
                 "<td>" + (parseInt(item.def) ? "是" : "否") + "</td>" +
                 "<td>" +
                 "<a class='btn btn-info' href='#' name='editBtn' onclick='editTr(this);'><i class='glyphicon glyphicon-edit icon-white'></i> 配置</a> " +
                 "<a class='btn btn-danger' href='#' name='delBtn' onclick='delTr(this);'><i class='glyphicon glyphicon-trash icon-white'></i> 删除</a>&nbsp;" +
                 "</td>" +
                 "</tr>");
         } else{
             $tr = $("<tr '>" +
                 "<td>" + $windowNum + "</td>" +
                 "<td>D</td>" +
                 "<td>否</td>" +
                 "<a class='btn btn-info' href='#' name='editBtn' onclick='editTr(this);'><i class='glyphicon glyphicon-edit icon-white'></i> 配置</a> " +
                 "<a class='btn btn-danger' href='#' name='delBtn' onclick='delTr(this);'><i class='glyphicon glyphicon-trash icon-white'></i> 删除</a>&nbsp;" +
                 "</tr>");
         }
         $tr.data("itemData", item);
         $tr.appendTo($tbody);
         abledButton();
     });
}

