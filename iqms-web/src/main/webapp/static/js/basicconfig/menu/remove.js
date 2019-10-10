var msg = '确定要删除这些菜单吗?';
function queryMenu(list){
	$.ajax({
        url : contextPath + "/basicconfig/menuQuery?_method=delete&dt="+(new Date().getTime()),
        type : "post",
        dataType : "json",
        contentType : "application/json",
        data : $.toJSON(list),
        success : function(errorCode)
        {
            if(errorCode.errorCode != '0'){
            	msg = errorCode.errorCode;
            }
            remove(list);
        }
});
}
function remove(list){
	var jc = $.confirm({
        title: '菜单删除',
        icon: 'fa fa-warning red',
        theme:'bootstrap',
        content: msg,
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
        			//将删除数据提交到后台
        			 $.ajax({
        		                url : contextPath + "/basicconfig/menu?_method=delete&dt="+(new Date().getTime()),
        		                type : "post",
        		                dataType : "json",
        		                contentType : "application/json",
        		                data : $.toJSON(list),
        		                success : function()
        		                {
        		                    $.alert({
        		                        title: '提示信息',
        		                        icon:'fa fa-info-circle blue',
        		                        theme:'bootstrap',
        		                        content: '删除成功！',
        		                        closeIcon: true,
        		                        buttons:{
        		                        	 colseWin: {
             		                        	text: '<i class="ace-icon fa fa-times"></i>关闭',
             		                            btnClass: 'btn-info'
             		                        }
        		                        }
        		                       
        		                    });
        		                    //重新加载数据
        		                    searchCondition();
        		                }
        		      });
                	
                }
            }
        }
    });
}
function removeMenu()
{
	//获取要删除元素的id
	//获取选中的行的行号
	var selIds=$(grid_selector).jqGrid('getGridParam','selarrrow');
	var list = [];
	for (var i = 0; i < selIds.length; i++){
		var rowData = dgDatas.rows[selIds[i]-1];
		//获取主键值
		var menuId = rowData.menuId;
		list.push(menuId);
	}
	queryMenu(list);
}