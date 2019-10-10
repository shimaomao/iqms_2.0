function initUserSelector(url, params)
{
    $surlName = $("#surlName");
    $dgUnselectedUser = $("#dgUnselectedUser");
    $dgSelectedUser = $("#dgSelectedUser").datagrid(
    {
        url : url,
        method : "get",
        queryParams : params,
        onLoadSuccess : function(data)
        {
            var excepted = "";
            if (data.rows.length > 0)
            {
                $.each(data.rows, function(index, item)
                {
                    excepted += item.urlId + ",";
                });
            }
            
            loadUsers();
        }
    });
}

function searchUrls()
{
    logBehavior("log.behavior.page.query1", ["url.select","url.list"]);
    loadUsers();
}

function loadUsers()
{
    var selectedRows = $dgSelectedUser.datagrid("getRows");
    var excepted = "";

    var surlName = $surlName.val();
    if(!/^[\u4e00-\u9fa5_a-zA-Z0-9]{0,32}$/i.test(surlName)){
    	alert('搜索的路径名格式有误，字母数字下划线或者中文');
    	return;
    }
    $.each(selectedRows, function(index, item)
    {
        excepted += item.urlId + ",";
    });
    
    $dgUnselectedUser.datagrid("clearSelections");
    $dgUnselectedUser.datagrid("load",{
        excepted : excepted,
        urlName : surlName
    });
}

function moveRight()
{
    logBehavior("log.behavior.fun.action2");
    var checkedRows = $dgUnselectedUser.datagrid("getChecked");
	//alert(checkedRows.length);
    if (0 == checkedRows.length)
    {
        return;
    }

    $.each(checkedRows, function(index, item)
    {
        $dgSelectedUser.datagrid("appendRow", item);
    });

    loadUsers();
}

function moveLeft()
{
    logBehavior("log.behavior.fun.action3");
    
    var checkedRows = $dgSelectedUser.datagrid("getChecked");

    if (0 == checkedRows.length)
    {
        return;
    }

    var list = [];

    $.each(checkedRows, function(index, item)
    {
        list.push(item.urlId);
    });

    var rowIndex;

    $.each(list, function(index, item)
    {
        rowIndex = $dgSelectedUser.datagrid("getRowIndex", item);
        $dgSelectedUser.datagrid("deleteRow", rowIndex);
    });

    loadUsers();
}