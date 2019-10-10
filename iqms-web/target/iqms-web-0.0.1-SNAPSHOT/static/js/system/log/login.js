$(function()
{
    $oid = $("#oid");
    $uname = $("#uname");
    $containSub = $("#containSub");
    $beginDate = $("#beginDate");
    $endDate = $("#endDate");
    $dgLoginLog = $("#dgLoginLog");
    $seachFrom = $("#seachFrom");
});

function searchLoginLogs()
{
    logBehavior("log.behavior.page.query", ["log.login","log.login.list"]);
    $seachFrom.form("enableValidation");
    if (!$seachFrom.form("validate"))
    {
        return;
    }
    loadLoginLogs();
}

function loadLoginLogs()
{
	var uname = $uname.val();
	if(!/^[a-zA-Z0-9_]{0,16}$/i.test(uname)){
		alert('搜索的用户名不合法（0-16位，允许字母数字下划线）');
		return;
	}
    $dgLoginLog.datagrid("clearSelections");
    $dgLoginLog.datagrid("load",
    {
        username : uname,
        orgId : $oid.val(),
        containSub : $containSub.is(":checked"),
        beginDate : $beginDate.datebox("getValue"),
        endDate : $endDate.datebox("getValue")
    });
}

function showUser(userId)
{
    $dlgUser = $('<div style="width:600px;height:480px;padding: 15px 15px; overflow: hidden;"/>');
    $dlgUser.dialog(
    {
        closed : true,
        cache : true,
        modal : true,
        title : $.i18n.prop("user.detail"),
        href : contextPath + "/system/users/" + userId,
        buttons : [
        {
            text : $.i18n.prop("cancel"),
            iconCls : "icon-remove",
            handler : function()
            {
                $dlgUser.dialog("close");
            }
        }],
        onClose : function()
        {
            $dlgUser.dialog("destroy");
        }
    }).dialog("open");
}

function formatUsername(val, row, index)
{
    return "<a href='javascript:void(0);' onclick='showUser(" + row.userId + ");'>" + val + "</a>";
}