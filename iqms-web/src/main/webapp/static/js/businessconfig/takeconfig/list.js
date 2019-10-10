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
var deviceName = "";
$(function (){
	//编辑页面点击返回时，带过来的参数，通过参数查询设备的票号信息   
	params = $.string(decodeURI(window.location.href)).toQueryParams(); //获取请求地址栏上的参数
	orgId = params["orgId"];  
	deviceNo = params["deviceNo"];
	deviceName = params["deviceName"];
	if((orgId != '' && orgId != null) &&
			(deviceNo != '' && deviceNo != null)
			&&((deviceName != '' && deviceName != null))){
		 jQuery("#searchFrom").find("input[name=orgId]").val(orgId);
    	 jQuery("#searchFrom").find("input[name=deviceNo]").val(deviceNo);
    	 jQuery("#searchFrom").find("input[name=devName]").val(deviceName);
    	 searchCondition();
	}
	
	
	
    $modalTitle = $("#modalTitle");  //操作对户口标题
    $styleId = $("#styleId");   //取号模板id
    $styleName = $("#styleName");  //取号模板名称
    $actionType = $("#actionType");  //操作方式
    $myModal = $('#myModal');   //模式对话框
    $def = $("#def");   //是否默认模板

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

    /**
     * 新增模板
     */
    $("#addBtn").click(function (e)
    {
        e.preventDefault();
        var itemData = {};
        showModal("new", itemData);
    });
    
    disabledButton();
    
});

/**
 * 控制按钮不可用
 */
function disabledButton()
{
  $("#addBtn").attr('disabled', true);
  $("#CopyToOrg").attr('disabled', true);
}

/**
 * 控制按钮可用
 */
function abledButton()
{
  $("#addBtn").attr('disabled', false);
  $("#CopyToOrg").attr('disabled', false);
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
	        content: '将清空所选下级机构的取号配置，确定要应用吗?',
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
	                	var url = contextPath + "/businessconfig/copytakeconfig?dt="+(new Date().getTime());
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
/**
 * 查询数据
 */
function searchCondition(){
	 orgId = $("#searchFrom").find("input[name=orgId]").val();
	 deviceNo = $("#searchFrom").find("input[name=deviceNo]").val();
	 if(orgId=="" || deviceNo==""){
		 qmsVld.showInfo("请先选择一个机构设备！!");
	 }else{
		 $.ajax({
		        url: contextPath+"/businessconfig/takeconfig/BydeviceNo?dt="+(new Date().getTime()),
		        type : "get",
		        dataType: "json",
		        data:{"orgId":orgId,"deviceNo":deviceNo},
		        contentType: "application/json",
		        success: function(data) {
		        	initPageBydeviceNo(data);
		        	 //按钮可用
		            abledButton();
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
      		url: contextPath+"/businessconfig/takeconfig?ftype=delete&_method=get",
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
	deviceName  = jQuery("#searchFrom").find("input[name=devName]").val();
    var itemData = $(obj).parent().parent().data("itemData");
    window.location.href = encodeURI(contextPath+"/businessconfig/takeconfig/edit?styleId=" 
    + itemData.styleId 
    +"&styleName=" + itemData.styleName
    +"&orgId=" + itemData.orgId
    +"&deviceNo=" + itemData.deviceNo
    +"&screenResolution=" + itemData.screenResolution
    +"&deviceName=" + deviceName
    +"&def=" + itemData.def);
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
            url: contextPath+"/businessconfig/takeconfig?ftype=add&_method=get",
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

/**
 * 初始化列表数据
 * @param data
 */
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
         } else {
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
     });
}

