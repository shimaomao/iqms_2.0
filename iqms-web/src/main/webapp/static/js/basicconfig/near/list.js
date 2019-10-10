var newCount = 1;
var zNodes = null;
var $orgDialog;
var zTreeNear ;
var selNode;

var setting = {
        view: {
            selectedMulti: false  //没有多选
        },
        check: {
            enable: false  //没有复选框
        },
        data: {
        	key:{
        		name:"orgName"
        	},
            simpleData: {    //使用简单机构组织树
                enable: true,  //是否启用
                idKey:"orgId",  //元素id
                pIdKey:"parentId"  //父元素id
            }
        },
        callback: {  //配置回调函数
        	onClick: zTreeOnClick
        }
    };
/**
 * 加载机构组织树
 * 
 */
$(function(){
	//获取下一个元素（固定机构id）
//	var $name = $(input);  //当前元素
//	var $id = $(input).next(); //下一个元素
	
	//1.定义ztree的配置
	
	
	//ajax请求加载数据
	 $.ajax({
         url : contextPath + "/basicconfig/parameter/ztree?dt="+(new Date().getTime()),
         type : "get",
         dataType : "json",
         data:{"orgId":orgIdTemp},
         contentType : "application/json",
         //data : $.toJSON(list),
         success : function(datas)
         {
        	 var zNodes = datas;
        	//初始化机构树
        	 zTreeNear = $.fn.zTree.init($("#orgTree1"), setting, zNodes);
			}
         });
})
function zTreeOnClick(event, treeId, treeNode) {
	var selNodes = zTreeNear.getSelectedNodes();
	if (selNodes != null && selNodes.length > 0){
		selNode = selNodes[0];
		$("#orgId").val(selNode.orgId);
		//获取选中节点的临近网点信息
		getNearInfo(selNode.orgId);
	}
    
};

/**
 * 获取选中节点的临近网点信息
 */
function getNearInfo(orgId){
	$.ajax({
		url : contextPath + "/basicconfig/near?_method=get&dt="
				+ (new Date().getTime()),
		data :  {"orgId":orgId},
		type : "GET",
		contentType : "application/json; charset=utf-8",
		dataType : "json",
		success : function(result) {
			var list = result.rows;
			if(list.length==2){
				var map = list[0];
				var orgMap = list[1];
				for(var key in map){
					if(key == "ORG_ID1"){
						if(map[key] != ""|| map[key]!= null){
							$("#orgId1").val(map[key]);
							$("#orgName1").val(orgMap[map[key]]);
						}else{
							$("#orgId1").val("");
							$("#orgName1").val("");
						}
					}
					if(key == "ORG_ID2"){
						if(map[key] != ""|| map[key]!= null){
							$("#orgId2").val(map[key]);
							$("#orgName2").val(orgMap[map[key]]);
						}else{
							$("#orgId2").val("");
							$("#orgName2").val("");
						}
					}
					if(key == "ORG_ID3"){
						if(map[key] != ""|| map[key]!= null){
							$("#orgId3").val(map[key]);
							$("#orgName3").val(orgMap[map[key]]);
						}else{
							$("#orgId3").val("");
							$("#orgName3").val("");
						}
					}
					if(key == "ORG_ID4"){
						if(map[key] != ""|| map[key]!= null){
							$("#orgId4").val(map[key]);
							$("#orgName4").val(orgMap[map[key]]);
						}else{
							$("#orgId4").val("");
							$("#orgName4").val("");
						}
					}
				}
			}else{
				$("#orgId1").val("");
				$("#orgName1").val("");
				$("#orgId2").val("");
				$("#orgName2").val("");
				$("#orgId3").val("");
				$("#orgName3").val("");
				$("#orgId4").val("");
				$("#orgName4").val("");
			}
		}
	});
}
/**
 * 新增或更新临近网点信息
 */
function newNear(){
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
	 
	 var formjson = form.serialize();
	 var url = contextPath + "/basicconfig/near?dt="+(new Date().getTime());
     $.post(url, formjson, function(result)
     {
         if (result.errorCode == '0')
         {
        	//弹出对话框
         	$.alert({
                 title: '提示信息',
                 icon:'fa fa-info-circle blue',
                 theme:'bootstrap',
                 content: '临近网点保存成功',
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
                 content: '存在重复添加的临近网点',
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
                 content: '临近网点保存失败',
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

function searchCondition() {
	 $.ajax({
         url : contextPath + "/basicconfig/parameter/ztree?dt="+(new Date().getTime()),
         type : "get",
         dataType : "json",
         contentType : "application/json",
         data :{"orgId":orgIdTemp},
         success : function(datas)
         {
        	 var zNodes = datas;
        	//初始化机构树
        	 zTreeNear = $.fn.zTree.init($("#orgTree1"), setting, zNodes);
        	 zTreeNear.expandAll(true);
			}
         });
}





