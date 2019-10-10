//jqGrid
//数据表格
var grid_selector = "#grid-table"; 
//分页条
var pager_selector = "#grid-pager";


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
	
	//初始化jqGrid
	jQuery(grid_selector).jqGrid({
		url:contextPath+'/monitor/winmonitor?dt='+(new Date().getTime()),
		datatype:'json',
		mtype: 'GET',
		ajaxGridOptions: {contentType:'application/json; charset=utf-8' },//设置请求
		height: 'auto',
		colNames: ['机构编码', '机构名称', '设备号', '办理窗口','柜员号', '排队号','评价',
		           '窗口状态'],
		colModel: [

			{name: 'orgCode',index: 'orgCode',width: 100,sortable: true}, 
			{name: 'orgName',index: 'orgName',width: 90,sortable: false}, 
			{name: 'deviceNo',index: 'deviceNo',width: 150,sortable: false},
			{name: 'winNo',index: 'winNo',width: 150,sortable: false},
			{name: 'tellerNo',index: 'tellerNo',width: 150,sortable: false},
			{name: 'ticketNo',index: 'ticketNo',width: 150,sortable: false},
			{name: 'app',index: 'app',width: 150,sortable: false,
			 formatter:function(value,grid,rows,state){
				
				 var innerHtml = value;
			     if (value == '1') {innerHtml = '<span class="label label-warning">不满意</span>';}
			     else if(value=='2'){innerHtml = '<span class="label label-success">一般</span>';}
                 else if(value=='3'){innerHtml = '<span class="label label-success">满意</span>';}
                 else if(value=='0'){innerHtml = '<span class="label label-success">未评价</span>';}
				 return innerHtml;
			 }}, 
			{name: 'winStatus',index: 'winStatus',width: 150,sortable: false}
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
	
	//显示水平滚动条
	//$(".ui-jqgrid-bdiv").css("overflow-x","visible");
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
    var orgId = jQuery("#searchFrom").find("input[name=orgId]").val();
    reqParam.orgId = orgId;
    jQuery(grid_selector).setGridParam({postData:reqParam,page:1}).trigger("reloadGrid");
}





