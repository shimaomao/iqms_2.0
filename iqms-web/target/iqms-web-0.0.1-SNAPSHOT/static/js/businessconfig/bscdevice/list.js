﻿//jqGrid
//数据表格
var grid_selector = "#grid-table"; 
//分页条
var pager_selector = "#grid-pager";
//查询的原始json数据(在页面加载完成后初始化)
var dgDatas;
var userOrgId = "";
//应用到下级机构
function copyToOrg(){
	//获取选中的行的行号
	var selIds=$(grid_selector).jqGrid('getGridParam','selarrrow');
	if (selIds.length > 1 || selIds.length == 0){  //展示选中记录的信息
		$.alert({
             title: '提示信息',
             icon:'fa fa-info-circle blue',
             theme:'bootstrap',
             content: '请选择一条记录！',
             closeIcon: true,
             buttons:{
             	 colseWin: {
                  	text: '<i class="ace-icon fa fa-times"></i>关闭',
                      btnClass: 'btn-info'
                  }
             }
         });
		$(this).dialog("close");
	}else{
		if($("#orgDevicelist").val()!="" && $("#orgDevicelist").val()!=null){
			var rowData = dgDatas.rows[selIds[0]-1];
			//获取主键值
			var json={};
			json.orgId=rowData.orgId;
			json.deviceNo=rowData.deviceNo;
			json.orgDevicelist = $("#orgDevicelist").val();
			var jc = $.confirm({
		        title: '应用到下级机构',
		        icon: 'fa fa-warning red',
		        theme:'bootstrap',
		        content: '确定要应用到下级机构吗?',
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
		        			//将数据提交到后台
		                	
		                	var url = contextPath + "/businessconfig/bscdevice/copy?dt="+(new Date().getTime());
		                	$.post(url, json, function(result)
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
		   		           	         }
		   		           	         else
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
			$.alert({
 	                 title: '提示信息',
 	                 icon:'fa fa-info-circle red',
 	                 theme:'bootstrap',
 	                 content: '请先选择要应用的下级机构',
 	                 closeIcon: true,
 	                 buttons:{
 	                 	 colseWin: {
 	                      	text: '<i class="ace-icon fa fa-times"></i>关闭',
 	                          btnClass: 'btn-info'
 	                      }
 	                 }
 	             });
		    return false;
		}
		/*var rowData = dgDatas.rows[selIds[0]-1];
		//获取主键值
		var json={};
		json.orgId=rowData.orgId;
		json.deviceNo=rowData.deviceNo;
		var orgId = $("#orgId").val();
		json.targetId=orgId;
		var jc = $.confirm({
	        title: '应用到下级机构',
	        icon: 'fa fa-warning red',
	        theme:'bootstrap',
	        content: '确定要应用到下级机构吗?',
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
	        			//将数据提交到后台
	                	
	                	var url = contextPath + "/businessconfig/copy?dt="+(new Date().getTime());
	                	$.post(url, json, function(result)
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
	   		           	         }
	   		           	         else
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
	    });*/
	}
}

function orgDeviceTree(){
	//获取选中的行的行号
	var selIds=$(grid_selector).jqGrid('getGridParam','selarrrow');
	if (selIds.length > 1 || selIds.length == 0){  //展示选中记录的信息
		$.alert({
             title: '提示信息',
             icon:'fa fa-info-circle blue',
             theme:'bootstrap',
             content: '请选择一条记录！',
             closeIcon: true,
             buttons:{
             	 colseWin: {
                  	text: '<i class="ace-icon fa fa-times"></i>关闭',
                      btnClass: 'btn-info'
                  }
             }
         });
		return;
	}
	var orgId = $("#orgId").val();
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
            },
            callback: { 
            	onClick: function (e, treeId, treeNode, clickFlag) { 
            		zTreeObj.checkNode(treeNode, !treeNode.checked, true); 
            	} 
            	} 
        };
	//ajax请求加载数据
	 $.ajax({
        url : contextPath + "/businessconfig/ztreeorgdevice?dt="+(new Date().getTime()),
        type : "get",
        dataType : "json",
        contentType : "application/json",
        data : {"orgId":userOrgId},
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

	var orgId = jQuery("#searchFrom").find("input[name=orgId]").val();
	userOrgId = orgId;
	//初始化jqGrid
	jQuery(grid_selector).jqGrid({
		url:contextPath+'/businessconfig/bscdevice?dt='+(new Date().getTime()),
		datatype:'json',
		mtype: 'GET',
		postData:{'orgId':orgId},
		ajaxGridOptions: {contentType:'application/json; charset=utf-8' },//设置请求
		height: 'auto',
		
		//emptyrecords:'抱歉！未能查询到任何数据。',
		colNames: ['机构编码', '机构名称', '设备编号', '主机名称', 'IP地址','分辨率','当前版本','最新版本','在线时间','上线模式','条屏上号'],
		colModel: [
            /*{name: 'orgId',index: 'orgId',width: 100,sortable: true}, */
			{name: 'orgCode',index: 'orgCode',width: 100,sortable: true}, 
			{name: 'orgName',index: 'orgName',width: 180,sortable: false}, 
			{name: 'deviceNo',index: 'deviceNo',width: 120,sortable: false}, 
			{name: 'hostName',index: 'hostName',width: 150,sortable: false}, 
			{name: 'ipAddr',index: 'ipAddr',width: 100,sortable: false}, 
			{name: 'screenResolution',index: 'screenResolution',width: 120,sortable: false}, 
			{name: 'currtVer',index: 'currtVer',width: 80,sortable: false}, 
			{name: 'lastVer',index: 'lastVer',width: 80,sortable: false}, 
			{name: 'onlineTime',index: 'onlineTime',width: 180,sortable: false},
			{name: 'onlineModel',index: 'onlineModel',width: 80,sortable: false,
				 formatter:function(value,grid,rows,state){
					 var innerHtml = '';
				     if (value == '1') { //发送
				    	 innerHtml = '<span class="label label-success arrowed-in arrowed-in-right">联网</span>';
				     }
				     if(value == '0'){
				    	 innerHtml = '<span class="label label-warning">单机</span>';
				     }
					 return innerHtml;
				 }},
				 {name: 'tpscrollFlag',index: 'tpscrollFlag',sortable: false,
					 formatter:function(value,grid,rows,state){
						 var innerHtml = '';
					     if (value == '1') { //发送
					    	 innerHtml = '<span class="label label-success arrowed-in arrowed-in-right">条屏滚动</span>';
					     }
					     if(value == '0'){
					    	 innerHtml = '<span class="label label-warning">直接显示</span>';
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
		autoScroll:true,
		
		caption: '<i class="ace-icon fa fa-list"></i>  &nbsp;&nbsp;查询结果'

	});
	
	/**
	  * 获取厂家放入下拉框
	  */
	 $.ajax({
			url : contextPath + "/basicconfig/sysdic/suppliers?_method=get&dt="
					+ (new Date().getTime()),
			type : "GET",
			contentType : "application/json; charset=utf-8",
			dataType : "json",
			success : function(result) {
				var list = result.rows;
				var map = "";
				var sel = $("#producer");
				sel.append("<option id='"+map.key+"'value=''>请选择</option>");
				for (var i=0; i<list.length; i++){
					map = list[i]; 
					sel.append("<option id='"+map.key+"'value='"+map.key+"'>" + map.value + "</option>");
				}
			}
		});
	$(window).triggerHandler('resize.jqGrid'); //trigger window resize to make the grid get the correct size
	//显示水平滚动条
//	$(".ui-jqgrid-bdiv").css("overflow-x","scroll");
	//分页条上的增删改查按钮
	var jqnav = jQuery(grid_selector).jqGrid('navGrid', pager_selector, { //navbar options
			//编辑按钮
		    edit: functionJson[200103],
			editicon: 'ace-icon fa fa-pencil blue',
			editfunc: editDevice,  //

			//添加按钮
			add: functionJson[200102],
			addicon: 'ace-icon fa fa-plus-circle purple',
			addfunc: newDevice,

			//删除按钮
			del: functionJson[200104],
			delicon: 'ace-icon fa fa-trash-o red',
			delfunc: removeDevice,

			//搜索按钮
			search: false,
			searchicon: 'ace-icon fa fa-search orange',
			
			//刷新按钮
			refresh: true,
			refreshicon: 'ace-icon fa fa-refresh green',
			
			//详情按钮
			view: functionJson[200105],
			viewicon: 'ace-icon fa fa-search-plus grey',
			viewfunc:showDevice,

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
		title : '应用到下级机构',
		buttonicon : 'ace-icon fa fa-share',
		onClickButton : orgDeviceTree, //单击后触发该方法打开对话框
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
    //logBehavior("log.behavior.page.query", ["user.title","user.list"]);
    loadDatas();
}
//
////执行查询方法
function loadDatas()
{
	//获取参数对象
	var reqParam = jQuery(grid_selector).jqGrid("getGridParam", "postData");
	var orgId = jQuery("#searchFrom").find("input[name=orgId]").val();
	reqParam.orgId = orgId;
	
	//重新查询使用新的postData
	jQuery(grid_selector).setGridParam({postData:reqParam,page:1}).trigger("reloadGrid");
}





