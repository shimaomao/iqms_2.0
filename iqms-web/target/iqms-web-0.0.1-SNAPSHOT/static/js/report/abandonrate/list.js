//jqGrid
//数据表格
var grid_selector = "#grid-table"; 
//分页条
var pager_selector = "#grid-pager";
//查询的原始json数据(在页面加载完成后初始化)
var dgDatas;
var $orgId;
var $custLevel;
var $startDate;
var $endDate;

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
	$orgId = $("#searchFrom").find("input[name=orgId]");
	$busType = $("#searchFrom").find("select[name=busType]");
	$startDate = $("#searchFrom").find("input[name=startDate]");
	$endDate = $("#searchFrom").find("input[name=endDate]");
	//mycustLevel = $("#searchFrom").find("select[name=custLevel]").find("option:selected");
	
	/**
	 * 日期格式化
	 */
	Date.prototype.Format = function(formatStr){   
	    var str = formatStr;   
	    var Week = ['日','一','二','三','四','五','六'];  
	  
	    str=str.replace(/yyyy|YYYY/,this.getFullYear());   
	    str=str.replace(/yy|YY/,(this.getYear() % 100)>9?(this.getYear() % 100).toString():'0' + (this.getYear() % 100));   
	  
	    str=str.replace(/MM/,(this.getMonth()+1)>9?(this.getMonth()+1).toString():'0' + (this.getMonth()+1));   
	    str=str.replace(/M/g,this.getMonth());   
	  
	    str=str.replace(/w|W/g,Week[this.getDay()]);   
	  
	    str=str.replace(/dd|DD/,this.getDate()>9?this.getDate().toString():'0' + this.getDate());   
	    str=str.replace(/d|D/g,this.getDate());   
	  
	    str=str.replace(/hh|HH/,this.getHours()>9?this.getHours().toString():'0' + this.getHours());   
	    str=str.replace(/h|H/g,this.getHours());   
	    str=str.replace(/mm/,this.getMinutes()>9?this.getMinutes().toString():'0' + this.getMinutes());   
	    str=str.replace(/m/g,this.getMinutes());   
	  
	    str=str.replace(/ss|SS/,this.getSeconds()>9?this.getSeconds().toString():'0' + this.getSeconds());   
	    str=str.replace(/s|S/g,this.getSeconds());   
	  
	    return str;   
	};
	
	//设置默认日期
	 var start = new Date();
	 var end = new Date();
	 
	 start.setDate(start.getDate()-7);
	 end.setDate(end.getDate());
	 
	 startday = start.Format("yyyy-MM-dd");
	 endday = end.Format("yyyy-MM-dd");
     //$startDate.value = nowday;  //注意：这种写法是原生js的，此处是jquery，应该使用的是其基于value属性而定义的方法val()，否则赋值会失败。
     $startDate.val(startday);
     $endDate.val(endday);
	
	//日历选择器
	$startDate.datepicker({
		closeText: "关闭", 
		prevText: "&#x3C;上月", 
		nextText: "下月&#x3E;", 
		currentText: "今天", 
		//defaultDate: new Date(),//设置默认时间，貌似不起作用不知为何
		showButtonPanel:false,//是否显示按钮面板  
		changeMonth:true,//下拉框选择月份
		changeYear:true,//下拉框选择年份
		yearRange:"-10:+10",//下拉框年份显示范围，以今年为基点0
		numberOfMonths:1,//一次显示几个月份
		autoSize:false,//自动调整大小
		monthNames: ["一月","二月","三月","四月","五月","六月","七月","八月","九月","十月","十一月","十二月"],
		monthNamesShort: ["一月","二月","三月","四月","五月","六月","七月","八月","九月","十月","十一月","十二月"], 
		dayNames: ["星期日", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六"],
		dayNamesShort: ["周日", "周一", "周二", "周三", "周四", "周五", "周六"], 
		dayNamesMin: ["日","一","二","三","四","五","六"], 
		weekHeader: "周", 
		dateFormat: "yy-mm-dd", 
		firstDay: 1, 
		isRTL: false, 
		showMonthAfterYear: true, 
		yearSuffix: "年" 
	});
	
	$endDate.datepicker({
		closeText: "关闭", 
		prevText: "&#x3C;上月", 
		nextText: "下月&#x3E;", 
		currentText: "今天", 
		showButtonPanel:false,//是否显示按钮面板  
		changeMonth:true,//下拉框选择月份
		changeYear:true,//下拉框选择年份
		yearRange:"-10:+10",//下拉框年份显示范围，以今年为基点0
		numberOfMonths:1,//一次显示几个月份
		autoSize:false,//自动调整大小
		monthNames: ["一月","二月","三月","四月","五月","六月","七月","八月","九月","十月","十一月","十二月"],
		monthNamesShort: ["一月","二月","三月","四月","五月","六月","七月","八月","九月","十月","十一月","十二月"], 
		dayNames: ["星期日", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六"],
		dayNamesShort: ["周日", "周一", "周二", "周三", "周四", "周五", "周六"], 
		dayNamesMin: ["日","一","二","三","四","五","六"], 
		weekHeader: "周", 
		dateFormat: "yy-mm-dd", 
		firstDay: 1, 
		isRTL: false, 
		showMonthAfterYear: true, 
		yearSuffix: "年" 
	});
	
	var parent_column = $(grid_selector).closest('[class*="col-"]');
	$(window).on('resize.jqGrid', function() {
		$(grid_selector).jqGrid('setGridWidth', parent_column.width());
	})

	//resize on sidebar collapse/expand  （左侧栏收缩，自动调整表格长度）
	$(document).on('settings.ace.jqGrid', function(ev, event_name, collapsed) {
		if(event_name === 'sidebar_collapsed' || event_name === 'main_container_fixed') {
			setTimeout(function() {
				$(grid_selector).jqGrid('setGridWidth', parent_column.width());
			}, 20);
		}
	})
	
	//获取查询条件的值
	var orgId = $orgId.val();
	var busType = "";
	var startDate = $startDate.val();
	var endDate = $endDate.val();
	
	//初始化jqGrid
	jQuery(grid_selector).jqGrid({
		url:contextPath+'/report/abandonrate?dt='+(new Date().getTime()),
		datatype:'json',
		mtype: 'GET',
		postData:{  //此参数值内容会直接赋值到url地址上，然后传给后台
					'orgId':orgId,
					'busType':busType,
					'startDate':startDate,
					'endDate':endDate
				 },
		ajaxGridOptions: {contentType:'application/json; charset=utf-8' },//设置请求
		height: 'auto',
		//emptyrecords:'抱歉！未能查询到任何数据。',
		colNames: ['机构编码', '机构名称', '业务名称', '总取票量', '未受理量','受理量','弃票量','弃票率'],
		colModel: [
			{name: 'orgCode',index: 'orgCode',width: 120,sortable: true}, 
			{name: 'orgName',index: 'orgName',width: 120,sortable: true}, 
			{name: 'businessName',index: 'businessName',width: 120,sortable: true}, 
			{name: 'totalCount',index: 'totalCount',width: 120,sortable: true}, 
			{name: 'totalWait',index: 'totalWait',width: 120,sortable: true}, 
			{name: 'totalDeal',index: 'totalDeal',width: 120,sortable: true},
			{name: 'totalAbandon',index: 'totalAbandon',width: 120,sortable: true}, 
			{name: 'abandonRate',index: 'abandonRate',width: 120,sortable: true}
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
		shrinkToFit:false, //false时依据colModel列数宽度自动调整宽度
		multiselect: true, //开启多选
		//multikey: "ctrlKey",  //按住ctrl进行多选
		multiboxonly: false, //只能使用复选框进行多选
		
		//服务端返回后会执行的方法
		loadComplete: function(data) {
			//原始数据
			dgDatas = data;
			var table = this;
			setTimeout(function() {
				updatePagerIcons(table);//更新页码导航按钮的图标
				enableTooltips(table);
			}, 0);
		},

		caption: '<i class="ace-icon fa fa-list"></i>  &nbsp;&nbsp;查询结果' ,
		
	});
	
	//将隐藏的水平滚动条显示出来
	$(".ui-jqgrid-bdiv").css("overflow-x","visible");
	
	//给日历样式赋z-index值
	$(".ui-widget-content").css("z-index","1");
	
	//业务类型查询
	$.ajax({
		url: contextPath+'/basicconfig/selectBusinessmanage?ftype=all&_method=get', 
		dataType: "json",
		contentType: "application/json",
		async:false,
		traditional: true,
		success: function(data) {
			var $option = "";
			
			//遍历该数据，动态拼接成一个html样式
			for(var i=0; i<data.length; i++) {
				$option = $('<option value=\"' + data[i].businessId + '\">' + data[i].businessName +'</option>');
				$option.appendTo($busType); //最后追加到父元素里面
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
		    edit: false,
			editicon: 'ace-icon fa fa-pencil blue',

			//添加按钮
			add: false,
			addicon: 'ace-icon fa fa-plus-circle purple',

			//删除按钮
			del: false,
			delicon: 'ace-icon fa fa-trash-o red',

			//搜索按钮
			search: false,
			searchicon: 'ace-icon fa fa-search orange',
			
			//刷新按钮
			refresh: true,
			refreshicon: 'ace-icon fa fa-refresh green',
			
			//详情按钮
			view: false,
			viewicon: 'ace-icon fa fa-search-plus grey',

		}, {}, //prmEdit
		{}, //prmAdd
		{}, //prmdel
		{}, //prmsearch
		{} //prmView
	)
	
	//自定义添加新的按钮
	jqnav.navButtonAdd(pager_selector,{
		caption : '',
		title : '导出EXCEL',
		buttonicon : 'ace-icon fa  fa-file-excel-o blue',
		onClickButton : btnExportAll, //单击后触发该方法打开对话框
		position : 'last',
	})
	//自定义添加新的按钮
	jqnav.navButtonAdd(pager_selector,{
		caption : '',
		title : '柱状图',
		buttonicon : 'ace-icon fa fa-bar-chart-o orange',
		onClickButton : openOrClose3D, //单击后触发该方法打开对话框
		position : 'last',
	})
	function openOrClose3D(){
		getZhuData();
	}
	//更新页码导航按钮的图标
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
	
	//工具提示
	function enableTooltips(table) { 
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
	
	//加载图形报表
//	initFushioncharts();
});


/**
 * FusionCharts初始化
 */
function  initFushioncharts(){
	//创建图形
 	width = $("#fushioncharts").width() ;
	var chart1 = new FusionCharts(contextPath+"/static/lib/Charts/Column3D.swf", "chartdiv_01", width,"560");
        chart1.setDataXML(strXML);//加载上面动态拼接的数据
        chart1.render("chartdiv_01");//指定图形渲染的位置,即jsp文件中div元素的id
}


//查询
function searchCondition()
{
    loadDatas();
}

//执行查询方法
function loadDatas()
{
	//校验查询时间
	if(!validateTime()) return;
	
	//获取查询参数对象
	var reqParam = $(grid_selector).jqGrid("getGridParam", "postData");
	
	var orgId = $orgId.val();
	var busType = $busType.find("option:selected").val();//选中的值
	var startDate = $startDate.val();
	var endDate = $endDate.val();

	reqParam.orgId = orgId;
	reqParam.busType = busType;
	reqParam.startDate = startDate;
	reqParam.endDate = endDate;
	
	//重新查询使用新的postData
	jQuery(grid_selector).setGridParam({postData:reqParam,page:1}).trigger("reloadGrid");
	
	//单击查询按钮后同步执行显示图形报表
	//getZheData();
	
}

/**
 * 验证时间条件
 */
function validateTime(){
	var startDate = $startDate.val();
	var endDate = $endDate.val();
	if (startDate == null || startDate == ''){
		confirm('查询的开始日期不能为空');
		return false;
	}
	if (endDate == null || endDate == ''){
		confirm('查询的结束日期不能为空');
		return false;
	}
	var sDate = new Date(startDate);
	var eDate = new Date(endDate);
	var diffMills = eDate.getTime()-sDate.getTime();
	if (diffMills < 0){
		confirm('查询的开始日期不能大于结束日期');
		return false;
	}
	return true;
}

//导出EXCEL表格
function btnExportAll(){
	window.location=contextPath+"/report/abandonrate/excel?orgId="+$orgId.val()+
	"&busType="+$busType.find("option:selected").val()+
	"&startDate="+$startDate.val()+
	"&endDate="+$endDate.val()+
	"&page=-1&rows=-1&_="+new Date().getTime();
}


