var $tagli, $bizName, $divAgent, $divCorporate, $username, $password, $spnError, $divLogin;
var $welcomeMain, $bizMain, $perpMain, $imgTel,$telNo, $logout, $toggleBtn,$ppsMain,$adv;

$(function ()
{
	//初始页面判断是否
   
    $username = $("#username");
    $password = $("#password");
    $spnError = $("#spnError");
    $divLogin = $("#divLogin");

    $welcomeMain = $("#welcomeMain");
    $bizMain = $("#bizMain");
    $perpMain = $("#perpMain");
    $imgTel = $("#imgTel");
    $telNo = $("#telNo");
    $logout = $("#logout");
    $toggleBtn = $(".tit_02 .fr");

    $tagli = $("#tags li");
    $bizName = $("#bizName");
    $divAgent = $("#divAgent");
    $divCorporate = $("#divCorporate");
	
	$ppsMain = $("#ppsMain");
	$adv = $("#adv");

    var $liContent1 = $("#liContent1");
    var $liContent2 = $("#liContent2"); 
	var $liContent3 = $("#liContent3");

	var rtn = $.pps.getAdvConfig();
	
	if (0 == rtn.result)
	{
		var $advContent = $("#advContent");
        var html = "";
        $.each(rtn.advConfig, function (index, img)
        {
		    //html +="<a id='" + img.id + "' href='javascript:goBiz(true);'>";
            html += "<img id='" + img.id + "' src='../images/advs/" + img.name + img.ext + "' />";
		//	html +="</a>";
        });

        $advContent.append(html).cycle(
        {
            fx: "fade,wipe,uncover",
            timeout: 3000,
            timeoutFn: function calculateTimeout(currElement, nextElement, opts, isForward)
            {
                var i = parseInt(currElement.id.replace("pict", ""), 10) - 1;
                return rtn.advConfig[i].timeout;
            }
        });
		
	}
	
    var rlt = $.pps.getBusTypes();

    if (0 == rlt.result)
    {
        var phtml = "";
        var chtml = "";
		var lchtml = "";
        var t;
		
        for (var i = 0; i < rlt.busTypes.length; i++)
        {
            t = rlt.busTypes[i];

            if (1 == t.busGroupId)
            {
                phtml += "<a class='btn' href=\"javascript:goPerp(" + t.canAgent + "," + t.busTypeId + "," + t.busTypeId + ",\'" + t.busGroupCode + "\',\'" + t.busTypeCode + "\',\'" + t.busTypeName + "\')\">" + t.busTypeName + "</a>";
            }
            else if (2 == t.busGroupId)
            {
                chtml += "<a class='btn' href=\"javascript:goPerp(" + t.canAgent + "," + t.busTypeId + "," + t.busTypeId + ",\'" + t.busGroupCode + "\',\'" + t.busTypeCode + "\',\'" + t.busTypeName + "\')\">" + t.busTypeName + "</a>";
            }else{

				lchtml += "<a class='btn' href=\"javascript:goPerp(" + t.canAgent + "," + t.busTypeId + "," + t.busTypeId + ",\'" + t.busGroupCode + "\',\'" + t.busTypeCode + "\',\'" + t.busTypeName + "\')\">" + t.busTypeName + "</a>";
            }

            $liContent1.html(phtml);
            $liContent2.html(chtml);
			$liContent3.html(lchtml);
        }
    }
	
	//setCurrWaitingNum();
	
	/*
	//$ppsMain.hide();
	//判断URL参数
    var toBiz=UrlGetParm("toBiz");  
    if(1==toBiz)
	{
	   goBiz(true);
	}*/
    $.pps.playSound("welcome.wav");
	   
});

function login(username, password)
{
    var username = $username.val();
    var password = $password.val();

    if (0 == $.trim(username).length)
    {
        $spnError.text("请输入用户名");
        return;
    }

    if (0 == $.trim(password).length)
    {
        $spnError.text("请输入密码");
        return;
    }

    var jo = $.pps.login(username, password);

    if (0 == jo.result)
    {
	   window.location.href = "admin/welcome_admin.html";
    }
    else
    {
        $spnError.text("用户名或密码错误");
    }
}

var adminStr = "";

function showLogin(i)
{

    adminStr += i;

    if (adminStr.length < 3)
    {
        return;
    }

    if (adminStr.length > 3)
    {
        adminStr = "";
        return;
    }

    var s = adminStr.substring(adminStr.length - 3);
    if ("111" == s)
    {
        adminStr = "";
	goWelcome();
	
	
        $divLogin.show();
		
    }
}

function closeLogin()
{
    $divLogin.hide();
	//goBiz(true);
    adminStr = '';
}

function goWelcome()
{
    $bizMain.hide();
    $perpMain.hide();
    $welcomeMain.show();
    $imgTel.show();
	$telNo.show();	
    $rtnHome.hide();
    $logout.hide();
    $.pps.playSound("welcome.wav");
}

function goBiz(reset)
{	
	if (reset)
    {
        selectTag(reset);
    }
	//$ppsMain.show();
	//$adv.hide();
    $divAgent.hide();
    $divCorporate.hide();
    $welcomeMain.hide();
    $perpMain.hide();
    $bizMain.show();
    $imgTel.hide();
	$telNo.hide();	
    $rtnHome.show();
    $logout.show();
    $.pps.playSound("biz.wav");
}

var receiptConfig = {};

function goPerp(canAgent, bizId, receiptId, bizType, receiptType, bizName)
{
    receiptConfig.canAgent = canAgent;
    receiptConfig.bizId = bizId;
    receiptConfig.receiptId = receiptId;
    receiptConfig.bizType = bizType;
    receiptConfig.receiptType = receiptType;

    $bizName.text(bizName);

    var rlt = $.pps.getPrintConfig(bizType, receiptType);
    conf = rlt.printConfig;

    if (conf.backImage)
    {
        map = new Map("previewImg", conf.image.width, conf.image.height, "../images/" + bizType + "/" + receiptType + ".jpg", conf.backImage.width, conf.backImage.height, "../images/" + bizType + "/" + receiptType + "_back.jpg");
        $toggleBtn.html("<img class='toggleimg' src='../images/back.gif' alt='翻面' onclick='map.toggle();'/>");
    }
    else
    {
        map = new Map("previewImg", conf.image.width, conf.image.height, "../images/" + bizType + "/" + receiptType + ".jpg");
        $toggleBtn.html("");
    }

    $welcomeMain.hide();
    $bizMain.hide();
    $perpMain.show();
    $.pps.playSound("preparation.wav");
}

// biz
function selectTag(id)
{
    $.each($tagli, function (index, item)
    {
        if (id == item.id)
        {
            item.className = "selectTag";
            $("#tagContent" + item.id).css("display", "block");
            $("#busiName" + item.id).css("color", "#FFFFFF");
        }
        else 
        {
            item.className = "";
            $("#tagContent" + item.id).css("display", "none");
            $("#busiName" + item.id).css("color", "#000000");
        }
    });
	$("#busName").empty().html($("#busiName" + id).html());
}

// prep
function fill()
{
    if ("personal" == receiptConfig.bizType && receiptConfig.canAgent)
    {
        $divAgent.show();
        $.pps.playSound("selfOrAgent.wav");
    }
    else if ("corporate" == receiptConfig.bizType)
    {
        //if (receiptConfig.bizId == "56" || receiptConfig.bizId == "60")
       // {
            swipe(2);
       // } else
       // {
       //     $divCorporate.show();
       // }
    }
    else
    {
        start('self');
    }
}

function start(transactor)
{
    var url = receiptConfig.bizType + "/" + receiptConfig.receiptType + ".html";
    url += "?transactor=" + transactor + "&bizTypeId=" + receiptConfig.bizId + "&receiptTypeId=" + receiptConfig.receiptId + "&bizType=" + receiptConfig.bizType + "&receiptType=" + receiptConfig.receiptType + "&index=0";

    window.location.href = url;
}

function swipe(id)
{
    var url = receiptConfig.bizType + "/" + receiptConfig.receiptType + ".html";
    url += "?swipe=" + id + "&bizTypeId=" + receiptConfig.bizId + "&receiptTypeId=" + receiptConfig.receiptId + "&bizType=" + receiptConfig.bizType + "&receiptType=" + receiptConfig.receiptType + "&index=0";

    window.location.href = url;
};
function loadKeyboard(obj, keyboardType, maxLen)
{
    var text = document.getElementById(obj.id).value;
    window.external.ShowKeyboard(obj.id, text, maxLen, keyboardType);
}

function keyboardCallBack(id, text)
{
    document.getElementById(id).value = text;
}
function getTicket()
{
	var rtn = $.pps.getTicket();
	if (0 == rtn.result)
	{
		$("#waitingNum").empty().html(rtn.waiting);
		//alert(rtn.waiting);
		//alert(rtn.ticketNo);
	}
}
function waitingCallback(jsonString)
{
	var jo = $.parseJSON(jsonString);
    $("#waitingNum").empty().html(jo.waiting);
}

function setCurrWaitingNum(){
	var rtn = $.pps.getWaiting();
	if (0 == rtn.result)
	{
		$("#waitingNum").empty().html(rtn.waiting);
	}
}
function UrlGetParm()
{
urlinfo=window.location.href; //获取当前页面的url 
len=urlinfo.length;//获取url的长度 
offset=urlinfo.indexOf("?");//设置参数字符串开始的位置 
newsidinfo=urlinfo.substr(offset,len)//取出参数字符串 这里会获得类似“id=1”这样的字符串 
newsids=newsidinfo.split("=");//对获得的参数字符串按照“=”进行分割 
newsid=newsids[1];//得到参数值 
//alert("您要传递的参数值是"+newsid);  
return  newsid;
}