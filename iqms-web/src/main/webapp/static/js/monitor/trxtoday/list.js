//jqGrid
//数据表格
var grid_selector = "#grid-table"; 
//分页条
var pager_selector = "#grid-pager";

//定义不同业务类型占比的变量
var vipPer = "";
var privatePer = "";
var publicPer = "";
var otherPer = "";
var orgId;
//查询的原始json数据(在页面加载完成后初始化)
var dgDatas;
$(function()
{
	$(document).keyup(function (e) {//捕获文档对象的按键弹起事件  
    	if (window.event)//如果window.event对象存在，就以此事件对象为准  
            e = window.event;  
        var code = e.charCode || e.keyCode; 
        if (code == 13) {//按键信息对象以参数的形式传递进来了  
        	searchCondition();
        }  
    });
	//接收 list;
	var list;
	var parent_column = $(grid_selector).closest('[class*="col-"]');
	//resize to fit page size
	$(window).on('resize.jqGrid', function() {
		$(grid_selector).jqGrid('setGridWidth', parent_column.width());
	})
	//resize on sidebar collapse/expand  （左侧栏收缩，自动调整表格长度）
	$(document).on('settings.ace.jqGrid', function(ev, event_name, collapsed) {
		if(event_name === 'sidebar_collapsed' || event_name === 'main_container_fixed') {
			//setTimeout is for webkit only to give time for DOM changes and then redraw!!!
			setTimeout(function() {
				$(grid_selector).jqGrid('setGridWidth', parent_column.width());
			}, 20);
		}
	})
	orgId = jQuery("#searchFrom").find("input[name=orgId]").val();
	//初始化jqGrid
	jQuery(grid_selector).jqGrid({
		url:contextPath+'/monitor/trxtoday?dt='+(new Date().getTime()),
		datatype:'json',
		mtype: 'GET',
		postData:{'orgId':orgId},
		ajaxGridOptions: {contentType:'application/json; charset=utf-8' },//设置请求
		height: 'auto',
		colNames: ['机构编码', '机构名称', '设备号', '业务名称', '客户类型','排队号','号票状态','评价','办理窗口',
		           '取号时间','叫号时间','办理时间','办理完成时间'],
		colModel: [

			{name: 'orgCode',index: 'orgCode',width: 100,sortable: true}, 
			{name: 'orgName',index: 'orgName',width: 90,sortable: false}, 
			{name: 'deviceNo',index: 'deviceNo',width: 150,sortable: true},
			{name: 'businessName',index: 'businessName',width: 150,sortable: true},
			{name: 'custName',index: 'custName',width: 150,sortable: true},
			{name: 'ticketNo',index: 'ticketNo',width: 150,sortable: false},
			{name: 'trxStatus',index: 'trxStatus',width: 150,sortable: true,
			 formatter:function(value,grid,rows,state){
				 var innerHtml = '<span class="label label-warning"></span>';
			     if (value == '1') {innerHtml = '<span class="label label-info">正常等候</span>';}
			     else if(value=='2'){innerHtml = '<span class="label label-info">正在办理</span>';}
                 else if(value=='3'){innerHtml = '<span class="label label-success">完成</span>';}
                 else if(value=='4'){innerHtml = '<span class="label label-danger">弃号</span>';}
                 else if(value=='5'){innerHtml = '<span class="label label-warning">转移</span>';}
                 else if(value=='6'){innerHtml = '<span class="label label-warning">锁号</span>';}
                 else if(value=='7'){innerHtml = '<span class="label label-warning">延后</span>';}
                 else if(value=='8'){innerHtml = '<span class="label label-warning">插前</span>';}
				 return innerHtml;
			 }}, 
			{name: 'appValue',index: 'appValue',width: 150,sortable: true,
			 formatter:function(value,grid,rows,state){
				 var innerHtml = '<span class="label label-warning"></span>';
			     if (value == '1') {innerHtml = '<span class="label label-warning">不满意</span>';}
			     else if(value=='2'){innerHtml = '<span class="label label-info">一般</span>';}
                 else if(value=='3'){innerHtml = '<span class="label label-success">满意</span>';}
                 else if(value == '0'){innerHtml = '<span class="label label-danger">未评价</span>';};
				 return innerHtml;
			 }}, 
			{name: 'winNo',index: 'winNo',width: 150,sortable: true},
			{name: 'printTime',index: 'printTime',width: 150,sortable: true},
			{name: 'callTime',index: 'callTime',width: 150,sortable: true},
			{name: 'beginTime',index: 'beginTime',width: 150,sortable: true},
			{name: 'endTime',index: 'endTime',width: 150,sortable: true}
		],
		jsonReader: {   //返回的json数据定义
            root: "rows",  //行数据
            page: "pageNo",  //数据页码
            total: "totalPage", //数据总页码
            records: "total", //总记录数
            repeatitems: false
        },
        onSortCol: function (index, iCol, sortorder) { //点击排序时触发的事件
        	//获取参数（条件参数）
        	var reqParam = jQuery(grid_selector).jqGrid("getGridParam", "postData")
        	//添加排序参数
        	reqParam.sort = index;  //排序字段
        	reqParam.order = sortorder;  //排序方向
        	jQuery(grid_selector).setGridParam({postData:reqParam}).trigger("reloadGrid");
        },
        shrinkToFit:false,
		viewrecords: true,
		rowNum: 10,
		rowList: [5,10, 20, 30],
		pager: pager_selector, //分页条
		altRows: true,
		recordtext:'当前显示记录{0} - {1}条 ，总记录数： {2}条',

		multiselect: true, //开启多选
		//					multikey: "ctrlKey",  //按住ctrl进行多选
		multiboxonly: false, //只能使用复选框进行多选

		loadComplete: function(data) {
			//加载取号数，等候人数等等数据
			list = data.rows;
			loadData();
			//原始数据
			dgDatas = data;
			var table = this;
			setTimeout(function() {
				updatePagerIcons(table);
				enableTooltips(table);
			}, 0);
		},

		caption: '<i class="ace-icon fa fa-list"></i>  &nbsp;&nbsp;查询结果'

	});
	
	//加载取号数，等候人数等等数据
	function loadData(){
		orgId = $("#orgId").val();
		//ajax请求加载不同业务百分比
		 $.ajax({
	        url : contextPath + '/monitor/getCompare?dt='+(new Date().getTime()),
	        data :  {"orgId":orgId},
	        type : "GET",
	        dataType : "json",
	        contentType : "application/json; charset=utf-8",
	        success : function(result)
	        {
	        	list = result.rows;
	        	if(list.length >=3){
	       			//总取号数
	       			var total = list[list.length-3]["total"];
	       			$("#total").html(total);
	       			
	       			//等候人数
	       			var wait = list[list.length-3]["wait"];
	       			$("#wait").html(wait);
	       			
	       			//正在办理人数
	       			var doing = list[list.length-3]["doing"];
	       			$("#doing").html(doing);
	       			
	       			//vip总取号数
	       			var vipTotal = list[list.length-3]["vipTotal"];
	       			$("#vipTotal").html(vipTotal);
	       			//vip等候数
	       			var vipWait = list[list.length-3]["vipWait"];
	       			$("#vipWait").html(vipWait);
	       			
	       			//昨日总取号数
	       			var yesTotal = list[list.length-2]["yesTotal"];
	       			if(yesTotal == null){
	       				$("#yesTotal").html("昨日:"+"0");
	       			}else{
	       				$("#yesTotal").html("昨日:"+yesTotal);
	       			}
	       			
	       			//昨日vip总取号数
	       			var yesVipTotal = list[list.length-2]["yesVipTotal"];
	       			if(yesVipTotal == null){
	       				$("#yesVipTotal").html("昨日:"+"0");
	       			}else{
	       				$("#yesVipTotal").html("昨日:"+yesVipTotal);
	       			}
	       			
	       			//总取号数同昨日的百分比
	       			var totalPercent = list[list.length-1]["totalPercent"];
	       			$("#totalPercent").html(totalPercent);
	       			
	       			//vip总取号数同昨日百分比
	       			var vipPercent = list[list.length-1]["vipPercent"];
	       			$("#vipPercent").html(vipPercent);
	       			
	       			//总取号数 上升或下降
	       			var totalFlag = list[list.length-1]["totalFlag"];
	       			if(totalFlag == "down"){
	       				$("#totalPercent").removeClass('stat stat-success');
	       				$("#totalPercent").addClass('stat stat-important');
	       			}else{
	       				$("#totalPercent").removeClass('stat stat-important');
	       				$("#totalPercent").addClass('stat stat-success');
	       			}
	       			var vipTotalFlag = list[list.length-1]["vipTotalFlag"];
	       			if(vipTotalFlag == "down"){
	       				$("#vipPercent").removeClass('stat stat-success');
	       				$("#vipPercent").addClass('stat stat-important');
	       			}else{
	       				$("#vipPercent").removeClass('stat stat-important');
	       				$("#vipPercent").addClass('stat stat-success');
	       			}
	       		}else{
	       			//总取号数
	       			var total = list[list.length-2]["total"];
	       			$("#total").html("0");
	       			
	       			//等候人数
	       			var wait = list[list.length-2]["wait"];
	       			if(wait==null || wait == ""){
	       				$("#wait").html("0");
	       			}else{
	       				$("#wait").html(wait);
	       			}
	       			
	       			//正在办理人数
	       			var doing = list[list.length-2]["doing"];
	       			if(doing==null || doing == ""){
	       				$("#doing").html("0");
	       			}else{
	       				$("#doing").html(doing);
	       			}
	       			
	       			//vip总取号数
	       			var vipTotal = list[list.length-2]["vipTotal"];
	       			if(vipTotal==null || vipTotal == ""){
	       				$("#vipTotal").html("0");
	       			}else{
	       				$("#vipTotal").html(vipTotal);
	       			}
	       			//vip等候数
	       			var vipWait = list[list.length-2]["vipWait"];
	       			if(vipWait==null || vipWait == ""){
	       				$("#vipWait").html("0");
	       			}else{
	       				$("#vipWait").html(vipWait);
	       			}
	       			
	       			//昨日总取号数
	       			var yesTotal = list[list.length-1]["yesTotal"];
	       			if(yesTotal == null){
	       				$("#yesTotal").html("昨日:"+"0");
	       			}else{
	       				$("#yesTotal").html("昨日:"+yesTotal);
	       			}
	       			
	       			//昨日vip总取号数
	       			var yesVipTotal = list[list.length-1]["yesVipTotal"];
	       			if(yesVipTotal == null){
	       				$("#yesVipTotal").html("昨日:"+"0");
	       			}else{
	       				$("#yesVipTotal").html("昨日:"+yesVipTotal);
	       			}
	       			
	       			//总取号数同昨日的百分比
	       			$("#totalPercent").html("0%");
	       			
	       			//vip总取号数同昨日百分比
	       			$("#vipPercent").html("0%");
	       			
	       			//总取号数 上升或下降
	       			$("#totalPercent").removeClass('stat stat-important');
	       			$("#totalPercent").addClass('stat stat-success');
	       			$("#vipPercent").removeClass('stat stat-important');
	       			$("#vipPercent").addClass('stat stat-success');
	       		}
	        }
	       });
	}

	
	//显示水平滚动条
	$(".ui-jqgrid-bdiv").css("overflow-x","visible");
	$(window).triggerHandler('resize.jqGrid');
	
	function updatePagerIcons(table) {
		var replacement = {
			'ui-icon-seek-first': 'ace-icon fa fa-angle-double-left green bigger-140',
			'ui-icon-seek-prev': 'ace-icon fa fa-angle-left red bigger-140',
			'ui-icon-seek-next': 'ace-icon fa fa-angle-right red bigger-140',
			'ui-icon-seek-end': 'ace-icon fa fa-angle-double-right green bigger-140'
		};
		$('.ui-pg-table:not(.navtable) > tbody > tr > .ui-pg-button > .ui-icon').each(function() {
			var icon = $(this);
			var $class = $.trim(icon.attr('class').replace('ui-icon', ''));

			if($class in replacement) icon.attr('class', 'ui-icon ' + replacement[$class]);
		})
	}
	
	function enableTooltips(table) { //工具提示
		$('.navtable .ui-pg-button').tooltip({
			container: 'body'
		});
		$(table).find('.ui-pg-div').tooltip({
			container: 'body'
		});
	}
});

////查询
function searchCondition()
{
    loadDatas();
}
//
////执行查询方法
function loadDatas()
{	
	var reqParam = jQuery(grid_selector).jqGrid("getGridParam", "postData");
    orgId = jQuery("#searchFrom").find("input[name=orgId]").val();
    reqParam.orgId = orgId;
    jQuery(grid_selector).setGridParam({postData:reqParam,page:1}).trigger("reloadGrid");
    initPicture();
}





