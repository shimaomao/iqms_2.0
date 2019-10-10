//jqGrid
//数据表格
var grid_selector = "#grid-table"; 
//分页条
var pager_selector = "#grid-pager";
//查询的原始json数据(在页面加载完成后初始化)
var dgDatas;
var $custLevel;
var $orgId;

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
	$custLevel = $("#searchFrom").find("select[name=custLevel]");
	$orgId = $("#searchFrom").find("input[name=orgId]");
	
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

	var orgId = $orgId.val();
	var custId = null;
	var custName = null;
	var custLevel = null;
	
	//初始化jqGrid
	jQuery(grid_selector).jqGrid({
		url:contextPath+'/basicconfig/cusinfo?dt='+(new Date().getTime()),
		datatype:'json',
		mtype: 'GET',
		postData:{'orgId':orgId,
				  'custId':custId,
				  'custName':custName,
				  'custLevel':custLevel
				 },
		ajaxGridOptions: {contentType:'application/json; charset=utf-8' },//设置请求
		height: 'auto',
		//emptyrecords:'抱歉！未能查询到任何数据。',
		colNames: ['机构编码', '机构名称', '客户识别码', '客户姓名', '客户类型','是否全行生效','推荐产品','精准广告'],
		colModel: [
			{name: 'orgCode',index: 'orgCode',width: 100,sortable: true}, 
			{name: 'orgName',index: 'orgName',width: 120,sortable: true}, 
			{name: 'custId',index: 'custId',width: 150,sortable: true}, 
			{name: 'custName',index: 'custName',width: 150,sortable: true}, 
			{name: 'cusName',index: 'cusName',width: 150,sortable: true}, 
			{name: 'isBankEftve',index: 'isBankEftve',width: 150,sortable: true,
			 formatter:function(value,grid,rows,state){
				 var innerHtml = '<span class="label label-warning">否</span>';
			     if (value == '1') { //是
			    	 innerHtml = '<span class="label label-success arrowed-in arrowed-in-right">是</span>';
			     }
				 return innerHtml;
			 }},
			{name: 'custPdut',index: 'custPdut',width: 150,sortable: true}, 
			{name: 'custAd',index: 'custAd',width: 150,sortable: true}
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
	
    //客户类型查询
	$.ajax({
		url: contextPath+'/basicconfig/custtype?ftype=all&_method=get', 
		dataType: "json",
		contentType: "application/json",
		traditional: true,
		success: function(data) {
			var $option = "";
			
			//遍历该数据，动态拼接成一个html样式
			for(var i=0; i<data.length; i++) {
				$option = $('<option value=\"' + data[i].custLevel + '\">' + data[i].custName +'</option>');
				$option.appendTo($custLevel); //最后追加到父元素里面
			}
		},
		error: function(msg) {
			alert("出错了！");
		}
	})
	
				
	
    
	$(window).triggerHandler('resize.jqGrid'); //trigger window resize to make the grid get the correct size

	//分页条上默认的增删改查按钮
	var jqnav = jQuery(grid_selector).jqGrid('navGrid', pager_selector, { //navbar options
			//编辑按钮
		    edit: functionJson[190903],
			editicon: 'ace-icon fa fa-pencil blue',
			editfunc: editCusInfo,  //

			//添加按钮
			add: functionJson[190902],
			addicon: 'ace-icon fa fa-plus-circle purple',
			addfunc: newCusInfo,

			//删除按钮
			del: functionJson[190904],
			delicon: 'ace-icon fa fa-trash-o red',
			delfunc: removeCusInfo,

			//搜索按钮
			search: false,
			searchicon: 'ace-icon fa fa-search orange',
			
			//刷新按钮
			refresh: true,
			refreshicon: 'ace-icon fa fa-refresh green',
			
			//详情按钮
			view: functionJson[190905],
			viewicon: 'ace-icon fa fa-search-plus grey',
			viewfunc: showCusInfo,

			alertcap: '提示',
			alerttext: '<span style="color:red">请选择记录</span>'

		}, {}, //prmEdit
		{}, //prmAdd
		{}, //prmdel
		{}, //prmsearch
		{} //prmView
	)
	
	//自定义添加新的按钮
	jqnav.navButtonAdd(pager_selector,{
		caption : '',
		title : '导入本地文件',
		buttonicon : 'ace-icon fa  fa-file-excel-o blue',
		onClickButton : importExcelfFile, //单击后触发该方法打开对话框
		position : 'last',
	})

	

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
    loadDatas();
}
//
////执行查询方法
function loadDatas()
{
	//获取参数对象
	var reqParam = $(grid_selector).jqGrid("getGridParam", "postData");
	var orgId = $("#searchFrom").find("input[name=orgId]").val();
	var custId = $("#searchFrom").find("input[name=custId]").val();
	var custName = $("#searchFrom").find("input[name=custName]").val();
	var custLevel = $custLevel.find("option:selected").val();//选中的值
	
	// add by tianjm 20181112
	if(!/^[-?\da-zA-Z]{0,15}$/i.test(custId)){
		alert('搜索的客户识别码格式有误，允许字母或者数字');
		return;
	}
	if(!/^[\u4e00-\u9fa5_a-zA-Z0-9]{0,15}$/i.test(custName)){
		alert('搜索的客户识别码格式有误，允许中文或者英文、下划线、数字');
		return;
	}
	
	reqParam.orgId = orgId;
	reqParam.custId = custId;
	reqParam.custName = custName;
	reqParam.custLevel = custLevel;
	
	//重新查询使用新的postData
	jQuery(grid_selector).setGridParam({postData:reqParam,page:1}).trigger("reloadGrid");
}
