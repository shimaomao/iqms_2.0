// 查询的原始json数据(在页面加载完成后初始化)
var dgDatas;
var num = 0;
var newCount = 1;
var zNodes = null;
var $orgDialog;
var zTreeObj;
var name;
var ename;
var params;
var orgName = "";
var devName = "";
var saveFlag = false;
var MoveTest = {
	errorMsg : "业务不可成为父节点！",
	domType:null, //点击的目标类型是 BUS还是MENU
	optClass:null, //移除或者增加的样式    label-primary  或  label-success
	curTarget: null,  // 当前节点
	curTmpTarget: null,  //临时节点
	bindDom:function(){
		//菜单列表绑定鼠标按下
		$("#menuList").bind("mousedown", MoveTest.bindMouseDown);
		//业务列表绑定鼠标按下
		$("#busList").bind("mousedown", MoveTest.bindMouseDown);
	},
	noSel: function() {
		try {
			window.getSelection ? window.getSelection().removeAllRanges() : document.selection.empty();
		} catch(e){}
	},
	/**
	 * 判断检测拖拽节点，到目标节点的前面  （目标节点必须是父节点，或者是菜单）
	 * @param treeId
	 * @param treeNodes
	 * @param targetNode
	 * @returns {Boolean}
	 */
	innerTree: function(treeId, treeNodes, targetNode) {//插入到节点上：目标节点不为空，目标节点是父节点，目标节点类型id和一致
		return targetNode!=null && (targetNode.isParent || targetNode.businessType=="0");
	},
	
	/**
	 * 菜单和业务标签绑定的鼠标按下事件：用于克隆标签元素，拖拽的时候如影随行
	 * @param e
	 */
	bindMouseDown: function(e) {  //鼠标按下，克隆出新的元素
		var target = e.target;
		
		//获取目标类型
		//判断目标元素所属的范围，是业务，还是菜单
		MoveTest.domType = $(target).parents("#menuList").length > 0 ? "0" :"1";
		
		//要移除或增加的样式
		MoveTest.optClass = MoveTest.domType=="0"?"label-primary":"label-success"
		 
		//按下的目标不为空，且目标的样式为lab
		if (target!=null && (target.className=="label label-primary" || target.className=="label label-success")) {
			var doc = $(document), target = $(target),
			docScrollTop = doc.scrollTop(), //文档滚动条的高度
			docScrollLeft = doc.scrollLeft(); 
			
			console.info("docScrollTop:"+docScrollTop);
			console.info("docScrollLeft:"+docScrollLeft);
			console.info("e.clientY:"+e.clientY);
			console.info("e.clientX:"+e.clientX);
			target.addClass("label-grey");  //添加灰色样式
			target.removeClass(MoveTest.optClass);  //移除主样式
			
			//创建一个绝对定位的临时节点
			curDom = $("<span class='label "+MoveTest.optClass+"' style='position:absolute;' id="+target.id+">"+target.text()+"</span>");
			curDom.appendTo("body");
			curDom.css({
				"top": (e.clientY + docScrollTop + 3) + "px",
				"left": (e.clientX + docScrollLeft + 3) + "px"
			});
			MoveTest.curTarget = target;
			MoveTest.curTmpTarget = curDom;

			doc.bind("mousemove", MoveTest.bindMouseMove);  //绑定鼠标移动
			doc.bind("mouseup", MoveTest.bindMouseUp);      //绑定鼠标松开
//			doc.bind("selectstart", MoveTest.docSelect);
		}
		if(e.preventDefault) {  //禁止事件冒泡
			e.preventDefault();
		}
	},
	
	/**
	 * dom元素：业务或者菜单随着鼠标移动
	 * @param e
	 * @returns {Boolean}
	 */
	bindMouseMove: function(e) { //控制克隆元素的移动
		MoveTest.noSel();  //取消选择元素
		var doc = $(document),   //获取doc
		docScrollTop = doc.scrollTop(),  //获取doc滚动条高度
		docScrollLeft = doc.scrollLeft(),  
		tmpTarget = MoveTest.curTmpTarget;   //获取临时元素
		if (tmpTarget) {   //临时元素存在
			tmpTarget.css({   //调整临时元素位置
				"top": (e.clientY + docScrollTop + 3) + "px",
				"left": (e.clientX + docScrollLeft + 3) + "px"
			});
		}
		return false;
	},
	
	/**
	 * dom元素：业务或者菜单，鼠标移动过程中松开（判断是否移动到树上，如果没有移动到树上，就还原节点样式）
	 * @param e
	 */
	bindMouseUp: function(e) {
		var doc = $(document);  //获取doc文档
		doc.unbind("mousemove", MoveTest.bindMouseMove);  //取消鼠标移动时间
		doc.unbind("mouseup", MoveTest.bindMouseUp);      //取消鼠标弹起时间
		//doc.unbind("selectstart", MoveTest.docSelect);    //取消文档选择事件
		
		
		//获取原目标元素和临时元素
		var target = MoveTest.curTarget, tmpTarget = MoveTest.curTmpTarget;
		if (tmpTarget) tmpTarget.remove();  //删除原临时元素

		//事件目标的父节点中没有branchBusTree，则原元素样式变为有效（目标是否是树）
		if ($(e.target).parents("#branchBusTree").length == 0) { 
			if (target) {
				target.removeClass("label-grey");
				target.addClass("label "+MoveTest.optClass);
			}
			MoveTest.curTarget = null;
			MoveTest.curTmpTarget = null;
			MoveTest.optClass = "";
			MoveTest.domType = "";
		}
	},
	
	/**
	 * 树形节点拖拽前检测 ： 如果不是根节点可以被拖拽
	 * @param treeId
	 * @param treeNodes
	 * @returns
	 */
	dragTree2Dom: function(treeId, treeNodes) {
		return !treeNodes[0].isParent;
	},
	
	/**
	 * 树形节点：ztree树上拖拽结束：可以用于ajax提交请求，保存节点数据（不用单独再去点击按钮保存）
	 * @param e          js事件对象
	 * @param treeId     树的treeId
	 * @param treeNodes     被拖拽的节点
	 * @param targetNode    拖拽结束的目标节点
	 * @param moveType      指定移动到目标节点的相对位置  inner-成为子节点   prev-同级前一个节点    next同级后一个节点
	 */
	dropTree2Dom: function(e, treeId, treeNodes, targetNode, moveType) {
		//执行数据保存
		var treePid = targetNode.busId;
		$("#treePid").val(treePid);
		
	},
	
	/**
	 * 树形节点：移动的过程
	 * @param e          事件对象
	 * @param treeId     树id
	 * @param treeNodes  要被拖拽的节点
	 */
	dragMove: function(e, treeId, treeNodes) {
		
	},
	
	/**
	 * ztree上的鼠标松开事件：用于将节点增加进来
	 * @param e  js事件对象
	 * @param treeId   ztree的treeId
	 * @param treeNode  鼠标松开时所在的节点，如果不再节点上就为null
	 */
	dom2Tree: function(e, treeId, treeNode) {  //将dom元素放倒树上
		//获取原dom元素，和临时dom元素
		var target = MoveTest.curTarget, tmpTarget = MoveTest.curTmpTarget;
		if (!target) return;  //原dom元素不存在就退出
		//获取ztree对象，定义父节点对象
		var zTree = $.fn.zTree.getZTreeObj("branchBusTree"), parentNode;
		var nodes = zTree.getNodes()[0].children;
		if(typeof(nodes) != 'undefined'){
			for(var j = 0; j<nodes.length; j++){
				if(typeof(nodes[j].orgId)=='undefined'){
					alert("节点"+nodes[j].branchName+"未保存，请先保存");
					target.removeClass("label-grey");
					//判断还原的样式类型
					target.addClass(MoveTest.optClass);
					MoveTest.curTarget = null;
					return;
				}
			}
		}
		//1.如果treeNode存在，且是跟节点，parentNode就是此节点
		if (treeNode != null ) { //放倒了目标节点上
			
			if (treeNode.isParent || treeNode.businessType=='0') { //根节点或者节点类型是菜单
				parentNode = treeNode; 
			} else {
				alert("业务节点上，不能放置节点");
				console.info("业务节点上，不能放置节点");
			} 
			
		}  else {  //如果节点为空，父节点就是根节点
			parentNode = zTree.getNodes()[0];
		}
		
		if (tmpTarget) tmpTarget.remove();
		if (!!parentNode) {  //找到父节点进行放置
			var nodes = zTree.addNodes(parentNode, {treeId:target.attr("id"), branchName: target.text(),businessType:MoveTest.domType});
			zTree.selectNode(nodes[0]);
		} else {  //没有找到节点就还原样式
			
			target.removeClass("label-grey");
			
			//判断还原的样式类型
			target.addClass(MoveTest.optClass);
		}
		MoveTest.curTarget = null;
		MoveTest.curTmpTarget = null;
		MoveTest.optClass = "";
		MoveTest.domType = "";
	},
};

var setting = {
	edit : {
		enable : true,
		drag: {
			inner: MoveTest.innerTree //拖拽到目标时，设置是否可以移动到目标节点里
		},
		showRemoveBtn : true,
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
		beforeRemove: zTreeOnClickRemove, //删除
		beforeDrag: MoveTest.dragTree2Dom,  //节点拖动之前
		onDrop: MoveTest.dropTree2Dom,  //ztree上上拖动结束（树形节点）
		onDragMove: MoveTest.dragMove,  //ztree树上拖动节点过程
		onMouseUp: MoveTest.dom2Tree,    //ztree树上鼠标松开（dom节点放倒树上）
		onNodeCreated: zTreeOnClick,
		onMouseDown: zTreeOnClick
	}
};
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

//按钮不可使用
function disabledButton()
{
  $("#CopyToOrg").attr('disabled', true);
  $("#saveConfig").attr('disabled', true);
}

//设置按钮可用
function abledButton()
{
  $("#CopyToOrg").attr('disabled', false);
  $("#saveConfig").attr('disabled', false);
}
//应用到下级机构
function copyToOrg(){
	if($("#orgDevicelist").val()!="" && $("#orgDevicelist").val()!=null){
		var jc = $.confirm({
	        title: '应用到下级机构',
	        icon: 'fa fa-warning red',
	        theme:'bootstrap',
	        content: '将清空所选下级机构的网点业务，确定要应用吗?',
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
	                	var orgId = jQuery("#searchFrom").find("input[name=orgId]").val();
	                	var deviceNo = jQuery("#searchFrom").find("input[name=deviceNo]").val();
	                	data.orgId = orgId;
	                	data.deviceNo = deviceNo;
	                	data.orgDevicelist = $("#orgDevicelist").val();
	                	var url = contextPath + "/businessconfig/copybranchbus?dt="+(new Date().getTime());
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
 * 加载机构组织树
 * 
 */
$(function() {
	params = $.string(decodeURI(window.location.href)).toQueryParams();
	orgName = params["orgName"];
	devName = params["devName"];
	$("#FormPost").validate({
		errorElement: 'div',   //错误信息包装元素
		errorClass: 'help-block', //错误的样式
		focusInvalid: false, //提交表单后未通过验证的表单会获得焦点
		ignore: "", //对某些元素不进行验证
		rules: { //验证规则
			businessCode: {   //验证的字段
				required:true, 
				zm_sz2:true, 
			    maxlength:5
			},
			callHead:{
				maxlength:5, 
				zm_sz2:true,
				required:true
			},
			priorTime:{
				digits:true, 
				maxlength:5
			},
			pickUpAdvice:{
				maxlength:30, 
				zh_ch:true
			},
			sortNum:{
				digits:true,
				maxlength:3
			},
			maxPickUp:{
				digits:true,
				maxlength:3
			}
		},
		highlight: function (e) { //未通过验证的元素增加效果
			$(e).closest('.form-group').removeClass('has-info').addClass('has-error');
		},
		success: function (e) { //验证成功需要执行的函数
			$(e).closest('.form-group').removeClass('has-error');//.addClass('has-info');
			$(e).remove();
		},
		onfocusout : function(element) {
			$(element).valid();
		},
		submitHandler : function(form) {
			newBscBranchBus();
			return false;
		}
	});
	var zNodes =[
	 			/*{ treeId:"1", treePid:"0", branchName:"业务类型", orgId:"",deviceNo:"",
	 				busCode:"",callHead:"",priorTime:"",isSwipe:"",isShowEn:"",
	 				pickUpAdvice:"",maxPickUp:"",sortNum:"",businessType:"",busId:"",
	 				isParent: true, open:true},*/
	 		];
	
	
	zTreeObj = $.fn.zTree.init($("#branchBusTree"), setting,zNodes);
	zTreeObj.expandAll(true); 
	MoveTest.bindDom();
	// ajax请求加载数据
	$.ajax({
		url : contextPath + "/businessconfig/bscbranchbus/getMenuBusiness?dt="
				+ (new Date().getTime()),
		type : "get",
		dataType : "json",
		contentType : "application/json",
		success : function(datas) {
			var list = datas.rows;
			loadData(list);
			loadDatas();
		}
	});
});

/**
 * 展示菜单和业务
 */
function loadData(list){
	var menuHtml ="";
	var busHtml ="";
	var n1 = 0;  // 业务显示的当前个数
	var n2 = 0;  // 菜单当前加载个数
	for (var i = 0; i < list.length; i++) {
		var data = list[i];
		if(data.treePid == 'p1'){
			
			menuHtml += '<span class="label label-primary" style="margin: 10px 10px" id='+data.treeId+'>'+data.branchName;
			menuHtml += '</span>';
			
			if (n1%4==3){
				menuHtml += '<div class="space-6"></div>';
			}
			n1++;
			
			
		}else{
			busHtml += '<span class="label label-success" style="margin: 10px 10px" id='+data.treeId+'>'+data.branchName;
			busHtml += '</span>';
			
			if (n2%4==3){
				busHtml += '<div class="space-6"></div>';
			}
			
			n2++;
		}
	}
	$('#menuList').append(menuHtml);
	$('#busList').append(busHtml);
}

/**
 * 1.删除树形机构面的节点
 * 2.删除数据库里面的此节点
 * 3.左侧对应标签变为激活状态。
 */
function zTreeOnClickRemove(treeId, treeNode){
	if(treeNode.treeId=='1'){
		$.alert({
            title: '提示信息',
            icon:'fa fa-info-circle blue',
            theme:'bootstrap',
            content: '根节点不可删除',
            closeIcon: true,
            buttons:{
            	 colseWin: {
                 	text: '<i class="ace-icon fa fa-times"></i>关闭',
                     btnClass: 'btn-info'
                 }
            }
        });
		return false;
	}else{
		var orgId = $("#orgId").val();
		var deviceNo = $("#deviceNo").val();
		var businessId = treeNode.treeId;
		if(!removeBranchBusiness(treeNode.orgId,deviceNo,businessId)){
			return false;
		}else{
			return true;
		}
	}
}
/**
 * 返回上一步 窗口配置
 * @param orgId
 */
function backPrev(){
 	window.location.href = encodeURI(contextPath + "/businessconfig/navconfig/winconfig?dt="+(new Date().getTime())
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
	}
}

/**
 * branchBusTree 添加点击事件
 */
function zTreeOnClick(event, treeId, treeNode) {
	if (treeId == 'branchBusTree') {
			$("#levelNum").val(treeNode.level);
			var businessId = treeNode.treeId; 
			var treePid = treeNode.treePid; 
			$("#treeId").val(businessId);
			$("#treePid").val(treePid);
			var orgId = $("#orgId").val();
			var deviceNo = $("#deviceNo").val();
			if(treeNode.businessType == '0'){
				$("#businessType").val("0");
				$("#branchName").attr("disabled","disabled");
				$("#businessEnName").attr("disabled","disabled");
//				$("#businessCode").attr("disabled","disabled");
				$("#callHead").attr("disabled","disabled");
				$("#priorTime").attr("disabled","disabled");
				$("#pickUpAdvice").attr("disabled","disabled");
				$("#sortNum").attr("disabled","disabled");
				$("#maxPickUp").attr("disabled","disabled");
				$("#swipe").attr("disabled",false);
				$("#showEn").attr("disabled",false);
				
				$("#branchName").val(treeNode.branchName);
				$("#businessEnName").val(treeNode.businessEnName);
				$("#businessCode").val("");
				$("#callHead").val("");
				$("#priorTime").val("");
				$("#pickUpAdvice").val("");
				$("#sortNum").val("");
				$("#maxPickUp").val("");
				if(treeNode.isSwipe=='0'){
					$("#swipe").prop("checked",true);
					$("#isSwipe").val("0");
				}else{
					$("#swipe").prop("checked",false);
					$("#isSwipe").val("1");
				}
				if(treeNode.isShowEn=='0'){
					$("#showEn").prop("checked",true);
					$("#isShowEn").val("0");
				}else{
					$("#swipe").prop("checked",false);
					$("#isShowEn").val("1");
				}
//				$("#swipe").prop("checked",false);
//				$("#showEn").prop("checked",false);
//				return;
			}else{
				$("#businessType").val("1");
//				$("#branchName").removeAttr("disabled");
//				$("#businessEnName").removeAttr("disabled");
				$("#businessCode").removeAttr("disabled");
				$("#callHead").removeAttr("disabled");
				$("#priorTime").removeAttr("disabled");
				$("#pickUpAdvice").removeAttr("disabled");
				$("#sortNum").removeAttr("disabled");
				$("#maxPickUp").removeAttr("disabled");
				$("#swipe").attr("disabled",false);
				$("#showEn").attr("disabled",false);
				$("#swipe").prop("checked",false);
				$("#showEn").prop("checked",false);
				$("#businessCode").val("");
				$("#callHead").val("");
				$("#priorTime").val("");
				$("#pickUpAdvice").val("");
				$("#sortNum").val("");
				
			}
			$.ajax({
				url : contextPath + "/businessconfig/bscbranchbus?dt="
						+ (new Date().getTime()),
				type : "get",
				data :{"orgId":orgId,"deviceNo":deviceNo,"treeId":businessId},
				dataType : "json",
				contentType : "application/json",
				success : function(datas) {
					var list = datas.rows;
					$("#branchName").attr("disabled","disabled");
					$("#businessEnName").attr("disabled","disabled");
					var map = list[0];
					var flag = "1";
					if(map["businessType"]=="0"){
						$("#businessCode").val(map["businessCode"]);
					}else{
						
						for(var key in map){
							if(key == "branchName"){
								$("#branchName").val(map[key]);
								flag = "2";
							}
							if(key == "businessEnName"){
								$("#businessEnName").val(map[key]);
							}
							if(key == "businessCode"){
								$("#businessCode").val(map[key]);
							}
							if(key == "callHead"){
								$("#callHead").val(map[key]);
							}
							if(key == "priorTime"){
								$("#priorTime").val(map[key]);
							}
							if(key == "pickUpAdvice"){
								$("#pickUpAdvice").val(map[key]);
							}
							if(key == "sortNum"){
								$("#sortNum").val(map[key]);
							}
							if(key == "maxPickUp"){
								$("#maxPickUp").val(map[key]);
							}
							if(key == "isSwipe"){
								if(map[key]=='0'){
									$("#swipe").prop("checked",true);
									$("#isSwipe").val("0");
								}else{
									$("#swipe").prop("checked",false);
									$("#isSwipe").val("1");
								}
							}
							if(key == "isShowEn"){
								if(map[key]=='0'){
									$("#showEn").prop("checked",true);
									$("#isShowEn").val("0");
								}else{
									$("#showEn").prop("checked",false);
									$("#isShowEn").val("1");
								}
							}
						}
						if(flag=='1'){
							var map = list[0];
							for(var key in map){
								if(key == "businessName"){
									$("#branchName").val(map[key]);
								}
								if(key == "businessEName"){
									$("#businessEnName").val(map[key]);
								}
							}
							$("#businessCode").val("");
							$("#callHead").val("");
							$("#priorTime").val("");
							$("#pickUpAdvice").val("");
							$("#sortNum").val("");
							$("#maxPickUp").val("");
						}
					}
					
				}
			});
			
	}
};

/**
 * 新增
 */
function newBscBranchBus(){
	 var form = $("#FormPost");
		//1.验证失败
		 if (!form.valid()){
			 return ;
		 }
	$newDialog = $("#dialog-new").removeClass("hide").dialog({
		modal: true, //模式对话框
		title: '<i class="ace-icon fa fa-pencil-square-o bigger-250"></i><span class="ui-jqdialog-title" style="float: left;"> 保存</span>',
		title_html: true,
		width:"350",
		height:"200",
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
 * 点击下一步
 */
function nextStep(){
	if(saveFlag){
		window.location.href = encodeURI(contextPath + "/businessconfig/navconfig/showtime?dt="+(new Date().getTime())
	 	+"&deviceNo="+$("#deviceNo").val()+"&orgId="+$("#orgId").val()+"&devName="+devName
	 	+"&orgName="+orgName);
	}else{
		qmsVld.showError("请先配置网点业务并保存");
	}
}

/**
 * 保存记录
 */
function save(){
	if($("#swipe").is(':checked')){
		$("#isSwipe").val("0");
	}else{
		$("#isSwipe").val("1");
	}
	if($("#showEn").is(':checked')){
		$("#isShowEn").val("0");
	}else{
		$("#isShowEn").val("1");
	}
	if($("#maxPickUp").val()==''){
		$("#maxPickUp").val(999);
	}
	 var form = $("#main-container").find("form");
	 
	 var formjson = form.serialize();
	 var url = contextPath + "/businessconfig/bscbranchbus?dt="+(new Date().getTime());
     $.post(url, formjson, function(result)
     {
         if (result.errorCode == '0')
         {
        	//弹出对话框
         	$.alert({
                 title: '提示信息',
                 icon:'fa fa-info-circle blue',
                 theme:'bootstrap',
                 content: '业务属性保存成功',
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
         }else if(result.errorCode == '2')
         {
        	 $.alert({
                 title: '提示信息',
                 icon:'fa fa-info-circle red',
                 theme:'bootstrap',
                 content: '业务代码已经存在',
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
                 content: '业务属性保存失败',
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

/*function zip(){
	// 获取参数对象
	var orgId = jQuery("#searchFrom").find("input[name=orgId]").val();
	var deviceNo = jQuery("#searchFrom").find("input[name=deviceNo]").val();
	$.ajax({
		url : contextPath + "/businessconfig/getBuzListZip?dt="
				+ (new Date().getTime()),
		type : "get",
		data :{"orgId":orgId,"deviceNo":deviceNo},
		dataType : "json",
		contentType : "application/json",
		success : function(datas) {
		}
	});
}*/

 //查询
function searchCondition() {
	 loadDatas();
}


// //执行查询方法
function loadDatas() {
	// 获取参数对象
	var orgId = $("#orgId").val();
	var deviceNo = $("#deviceNo").val();
	/*var nodes ={ treeId:"0", treePid:"", branchName:"业务配置", orgId:"",deviceNo:"",
			businessType:"0",isParent: true, open:true};*/
	var nodes;
	$.ajax({
		url : contextPath + "/businessconfig/branchBusTree?dt="
				+ (new Date().getTime()),
		type : "get",
		data :{"orgId":orgId,"deviceNo":deviceNo},
		dataType : "json",
		contentType : "application/json",
		success : function(datas) {
			var zNodes = datas.rows;
			if(zNodes.length>1){
				saveFlag = true;
			}
			jQuery("#menuList").find("span").attr("class","label label-primary");
			jQuery("#busList").find("span").attr("class","label label-success");
			for (var i =0; i<zNodes.length; i++){
				if(zNodes[i].treePid == '0'){
					zNodes[i].isParent=true;
				}
				if(zNodes[i].businessType == '0'){
					jQuery("#menuList").find("span[id="+zNodes[i].treeId+"]").attr("class","label label-grey");
				}else{
					jQuery("#busList").find("span[id="+zNodes[i].treeId+"]").attr("class","label label-grey");
				}
			}
//			zNodes.push(nodes);
			// 初始化网点业务组织树
			zTreeObj = $.fn.zTree.init($("#branchBusTree"), setting, zNodes);
			zTreeObj.expandAll(true); 
			abledButton();
		}
	});
}
