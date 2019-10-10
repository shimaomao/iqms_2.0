$(document).on("contextmenu", function (e)
{
    return false;
});

$(document).on("selectstart", function (e)
{
    return false;
});

$(document).mousemove(function(e) {
  return false;
});

var $showTime, $rtnHome, relativePath, htmlRelativePath, timingSecond;
var app = $.pps.getAppConfig().appConfig;

function resetTiming()
{
    if (app && app.timeout)
    {
        timingSecond = app.timeout + 1;
    }
}

$(function ()
{
    var scripts = document.getElementsByTagName("script");
    var src = scripts[0].src;
    relativePath = src.substring(0, src.indexOf("js"));
    //var idx = relativePath.lastIndexOf("../");
    //htmlRelativePath = (0 >= idx) ? "" : relativePath.substring(0, idx);
	htmlRelativePath = relativePath+"html/";
	
    $showTime = $("#showTime");
    $rtnHome = $("#rtnHome");
	
    getTime();
    timingSecond = app.timeout + 1;
    timing();

    setInterval(function ()
    {
        getTime();
        timing();
    }, 1000);

    $(document).on("click", function (e)
    {
        timingSecond = app.timeout + 1;
    });
});

function getTime()
{
    if (0 == $showTime.length)
    {
        return;
    }

    var now = Date.now();
    var text = now.toString("yyyy年MM月dd日 HH:mm:ss") + " " + now.getDayName();
    $showTime.html(text);
}

function getCurrentTime()
{
    var now = Date.now();
    var text = now.toString("yyyy-MM-dd HH:mm:ss");
	return text;
}

function timing()
{
    if (0 == $rtnHome.length)
    {
        return;
    }

    if ("none" == $rtnHome.css("display"))
    {
        return;
    }

    timingSecond -= 1;
    var s = timingSecond.toString();
    if (2 == s.length)
    {
        s = "0" + s;
    }
    else if (1 == s.length)
    {
        s = "00" + s;
    }
    var text = "系统将于 <b style='color:#eeeeee;'>" + s + "</b> 秒后回到首页";
    $rtnHome.html(text);

    if (timingSecond < 1)
    {
        window.external.PaperBacking();
        window.location.href = htmlRelativePath + "welcome.html";
    }
}