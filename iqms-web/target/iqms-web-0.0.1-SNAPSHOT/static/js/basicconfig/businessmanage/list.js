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
	$("#searchFrom").validate({
		errorElement: 'div',   //错误信息包装元素
		errorClass: 'help-block', //错误的样式
		focusInvalid: false, //提交表单后未通过验证的表单会获得焦点
		ignore: "", //对某些元素不进行验证
		rules: { //验证规则
			businessName: {   //验证的字段
				zh_chint:true
			}
		},

		highlight: function (e) { //未通过验证的元素增加效果
			$(e).closest('.form-group').removeClass('has-info').addClass('has-error');
		},

		success: function (e) { //验证成功需要执行的函数
			$(e).closest('.form-group').removeClass('has-error');//.addClass('has-info');
			$(e).remove();
		},

		errorPlacement: function (error, element) { //指定错误信息存放位置
			if(element.is('input[type=checkbox]') || element.is('input[type=radio]')) {
				var controls = element.closest('div[class*="col-"]');
				if(controls.find(':checkbox,:radio').length > 1) controls.append(error);
				else error.insertAfter(element.nextAll('.lbl:eq(0)').eq(0));
			}
			else if(element.is('.select2')) {
				error.insertAfter(element.siblings('[class*="select2-container"]:eq(0)'));
			}
			else if(element.is('.chosen-select')) {
				error.insertAfter(element.siblings('[class*="chosen-container"]:eq(0)'));
			} else {
				error.insertAfter(element.parent());
			}
				
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
		url:contextPath+'/basicconfig/businessmanage?dt='+(new Date().getTime()),
		datatype:'json',
		mtype: 'GET',
		ajaxGridOptions: {contentType:'application/json; charset=utf-8' },//设置请求
		height: 'auto',
		//emptyrecords:'抱歉！未能查询到任何数据。',
		colNames: ['业务ID', '业务名称','业务英文名', '业务平均办理时长（分钟）', '是否可预约'],
		colModel: [
			{name: 'businessId',index: 'businessId',width: 100,sortable: true}, 
			{name: 'businessName',index: 'businessName',width: 90,sortable: true}, 
			{name: 'businessEName',index: 'businessEName',width: 90,sortable: true}, 
			{name: 'averageTime',index: 'averageTime',width: 150,sortable: true}, 
			{name: 'orderFlag',index: 'orderFlag',width: 150,sortable: true,
			 formatter:function(value,grid,rows,state){
				 var innerHtml = '<span class="label label-warning">不可预约</span>';
			     if (value == '1') { //可预约
			    	 innerHtml = '<span class="label label-success arrowed-in arrowed-in-right">可预约</span>';
			     }
				 return innerHtml;
			 }}, 
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
	//jQuery(grid_selector).jqGrid('navGrid', pager_selector, { //navbar options
		$(grid_selector).navGrid(pager_selector,{
			
			//新增按钮
			add: functionJson[190702],
			addicon: 'ace-icon fa fa-plus-circle purple',
			addfunc: newBusinessManage,
			
			//编辑按钮
		    edit: functionJson[190703],
			editicon: 'ace-icon fa fa-pencil blue',
			editfunc: editBusinessManage,  

			//删除按钮
			del: functionJson[190704],
			delicon: 'ace-icon fa fa-trash-o red',
			delfunc: removeBusinessManage,
			
			//详情按钮
			view: false,
			viewicon: 'ace-icon fa fa-search-plus grey',
			viewfunc: showBusinessManage,
			
			//查询按钮
			search: false,
			searchicon: 'ace-icon fa fa-search orange',
			
			//刷新按钮
			refresh: false,
			refreshicon: 'ace-icon fa fa-refresh green',

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


	$(document).one('ajaxloadstart.page', function(e) {
		$.jgrid.gridDestroy(grid_selector);
		$('.ui-jqdialog').remove();
	});
});

//查询
function searchCondition()
{
	var form = $("#searchFrom");
	 
	//1.验证失败
	 if (!form.valid()){
		 return ;
	 }
    loadDatas();
}

//执行查询方法
function loadDatas()
{
	//获取参数对象
	var reqParam = jQuery(grid_selector).jqGrid("getGridParam", "postData");
	var businessName = jQuery("#searchFrom").find("input[name=businessName]").val();
	reqParam.businessName = businessName;
	
	//重新查询使用新的postData
	jQuery(grid_selector).setGridParam({postData:reqParam,page:1}).trigger("reloadGrid");
}




