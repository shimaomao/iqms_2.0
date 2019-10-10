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
		url:contextPath+'/basicconfig/custtype?dt='+(new Date().getTime()),
		datatype:'json',
		mtype: 'GET',
		//postData:{'custName':'贵宾客户'},
		ajaxGridOptions: {contentType:'application/json; charset=utf-8' },//设置请求
		height: 'auto',
		//emptyrecords:'抱歉！未能查询到任何数据。',
		colNames: ['类型编码', '类型名称', '等待超时（分钟）', '是否发短信', '是否送礼物','是否VIP','是否启用'],
		colModel: [

			{name: 'custLevel',index: 'custLevel',width: 100,sortable: true}, 
			{name: 'custName',index: 'custName',width: 90,sortable: false}, 
			{name: 'waitTimeout',index: 'waitTimeout',width: 150,sortable: false}, 
			{name: 'smsFlag',index: 'smsFlag',width: 150,sortable: false,
			 formatter:function(value,grid,rows,state){
				 var innerHtml = '<span class="label label-warning">不发送</span>';
			     if (value == '1') { //发送
			    	 innerHtml = '<span class="label label-success arrowed-in arrowed-in-right">发送</span>';
			     }
				 return innerHtml;
			 }}, 
			{name: 'presentFlag',index: 'presentFlag',width: 150,sortable: false,
			 formatter:function(value,grid,rows,state){
				 var innerHtml = '<span class="label label-warning">不送礼</span>';
			     if (value == '1') { //送礼物
			    	 innerHtml = '<span class="label label-success arrowed-in arrowed-in-right">送礼物</span>';
			     }
				 return innerHtml;
			 }}, 
			{name: 'vipFlag',index: 'vipFlag',width: 150,sortable: false,
				 formatter:function(value,grid,rows,state){
					 var innerHtml = '<span class="label label-warning">否</span>';
				     if (value == '1') { //vip
				    	 innerHtml = '<span class="label label-success arrowed-in arrowed-in-right">是</span>';
				     }
					 return innerHtml;
				 }},
			{name: 'isUse',index: 'isUse',width: 150,sortable: false,
			 formatter:function(value,grid,rows,state){
				 var innerHtml = '<span class="label label-warning">不启用</span>';
			     if (value == '1') { //是否启用
			    	 innerHtml = '<span class="label label-success arrowed-in arrowed-in-right">启用</span>';
			     }
				 return innerHtml;
			 }}
			
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
	
	
	$(window).triggerHandler('resize.jqGrid'); //trigger window resize to make the grid get the correct size

	//分页条上的增删改查按钮
	jQuery(grid_selector).jqGrid('navGrid', pager_selector, { //navbar options
			//编辑按钮
		    edit: functionJson[190103],
			editicon: 'ace-icon fa fa-pencil blue',
			editfunc: editCustType,  //

			//添加按钮
			add: functionJson[190102],
			addicon: 'ace-icon fa fa-plus-circle purple',
			addfunc: newCustType,

			//删除按钮
			del: functionJson[190104],
			delicon: 'ace-icon fa fa-trash-o red',
			delfunc: removeCustType,

			//搜索按钮
			search: false,
			searchicon: 'ace-icon fa fa-search orange',
			
			//刷新按钮
			refresh: true,
			refreshicon: 'ace-icon fa fa-refresh green',
			
			//详情按钮
			view: functionJson[180105],
			viewicon: 'ace-icon fa fa-search-plus grey',
			viewfunc:showCustType,

			alertcap: '提示',
			alerttext: '<span style="color:red">请选择记录</span>'

		}, {}, //prmEdit
		{}, //prmAdd
		{}, //prmdel
		{}, //prmsearch
		{} //prmView
	)

	

	//replace icons with FontAwesome icons like above
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

	//var selr = jQuery(grid_selector).jqGrid('getGridParam','selrow');

	$(document).one('ajaxloadstart.page', function(e) {
		$.jgrid.gridDestroy(grid_selector);
		$('.ui-jqdialog').remove();
	});
	
	
});

////查询
function searchCondition()
{
    //logBehavior("log.behavior.page.query", ["user.title","user.list"]);
    loadDatas();
}
//
////执行查询方法
function loadDatas()
{
	//获取参数对象
	var reqParam = jQuery(grid_selector).jqGrid("getGridParam", "postData");
	var custName = jQuery("#searchFrom").find("input[name=custName]").val();
	if(!/^[\u4e00-\u9fa5_a-zA-Z0-9]{0,10}$/i.test(custName)){
		alert('搜索的类型名称格式有误，允许中文或者英文、下划线、数字');
		return;
	}
	reqParam.custName = custName;
	
	//重新查询使用新的postData
	jQuery(grid_selector).setGridParam({postData:reqParam,page:1}).trigger("reloadGrid");
}





