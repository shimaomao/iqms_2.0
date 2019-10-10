var printConfig, map;

function createPreviewHtml()
{
    var rlt = $.pps.getPrintConfig(bizType, receiptType);
    var conf = rlt.printConfig;
    printConfig = rlt.printConfig;

    $("#divPreview").css("font-family", conf.family).css("font-size", conf.size);
    $divPrintCtrcol = $("<div id=\"divPrintCtrcol\">"
					+ "<div  style=\" 0 0 no-repeat;width: 50px; height: 50px;position: absolute; top: 100px; left: 1000px;\"><img src=\"../../images/fd.png\" alt='' onclick=\"map.shuofang('fd');\" /></div>"
					+ "<div  style=\" 0 0 no-repeat;width: 50px; height: 50px;position: absolute; top: 200px; left: 1000px;\"><img src=\"../../images/qp.png\" alt='' onclick=\"map.shuofang('qp');\" /></div>"
					+ "<div  style=\" 0 0 no-repeat;width: 50px; height: 50px;position: absolute; top: 300px; left: 1000px;\"><img src=\"../../images/yt.png\" alt='' onclick=\"map.shuofang('yt');\" /></div>"
					+ "<div  style=\" 0 0 no-repeat;width: 50px; height: 50px;position: absolute; top: 400px; left: 1000px;\"><img src=\"../../images/sx.png\" alt='' onclick=\"map.shuofang('sx');\" /></div>"
				+ "</div>");
    //$("#divPreview").after( $divPrintCtrcol );
    //$(".main").after($divPrintCtrcol);
	$("#divPreview").after( $divPrintCtrcol );
    if (conf.backImage)
    {
        map = new Map("divPreview", conf.image.width, conf.image.height, "../../images/" + bizType + "/" + receiptType + ".jpg", conf.backImage.width, conf.backImage.height, "../../images/" + bizType + "/" + receiptType + "_back.jpg");
    }
    else
    {
        map = new Map("divPreview", conf.image.width, conf.image.height, "../../images/" + bizType + "/" + receiptType + ".jpg");
    }

    var $spn;
    $.each(conf.items, function (index, item)
    {
        if(item.id=="receiptNo"){
			$spn = $("<span style='display:none' id='prt-" + item.id + "'></span>").css("position", "absolute").css("top", item.y + "px").css("left", item.x + "px");
		}else{
			$spn = $("<span id='prt-" + item.id + "'></span>").css("position", "absolute").css("top", item.y + "px").css("left", item.x + "px");
		}

        if (item.family)
        {
            $spn.css("font-family", item.family);
        }

        if (item.size)
        {
            $spn.css("font-size", item.size);
        }

        if (item.width)
        {
            $spn.css("width", item.width + "px").css("word-break", "break-all");
        }

        //$spn.text(item.text);

        map.innerMap.append($spn);
    });

    if (conf.backItems)
    {
        $.each(conf.backItems, function (index, item)
        {
            $spn = $("<span id='prt-" + item.id + "'></span>").css("position", "absolute").css("top", item.y + "px").css("left", item.x + "px");

            if (item.family)
            {
                $spn.css("font-family", item.family);
            }

            if (item.size)
            {
                $spn.css("font-size", item.size);
            }

            if (item.width)
            {
                $spn.css("width", item.width + "px").css("word-break", "break-all");
            }

            map.innerBackMap.append($spn);
        });
    }
}

function getPrintData()
{
    var arg = {};
    arg.family = printConfig.family;
    arg.size = printConfig.size; ;
    arg.dpi = printConfig.dpi;

    if (printConfig.landscape)
    {
        arg.landscape = printConfig.landscape;
        arg.image = map.front ? printConfig.image : printConfig.backImage;
    }

    var list = [];
    if (map.front)
    {
        arg.first = true;
        arg.offset = printConfig.offset;

        $("span", map.innerMap).each(function (index, item)
        {
            var spn = {};
            spn.x = parseInt(this.style.left.replace("px", ""));
            spn.y = parseInt(this.style.top.replace("px", ""));
            if (this.style.fontFamily)
            {
                spn.family = this.style.fontFamily;
            }
            if (this.style.fontSize)
            {
                spn.size = parseInt(this.style.fontSize.replace("px", ""));
            }
            if (this.style.width)
            {
                spn.width = parseInt(this.style.width.replace("px", ""));
            }
            spn.text = this.innerText;
			
			if(this.style.display == "none"){
				spn.disabled = true;
			}
            list.push(spn);
        });
    }
    else
    {
        if (printConfig.backOffset)
        {
            arg.backOffset = printConfig.backOffset;
        }
        else
        {
            arg.offset = printConfig.offset;
        }

        $("span", map.innerBackMap).each(function (index, item)
        {
            var spn = {};
            spn.x = parseInt(this.style.left.replace("px", ""));
            spn.y = parseInt(this.style.top.replace("px", ""));
            if (this.style.fontFamily)
            {
                spn.family = this.style.fontFamily;
            }
            if (this.style.fontSize)
            {
                spn.size = parseInt(this.style.fontSize.replace("px", ""));
            }
            if (this.style.width)
            {
                spn.width = parseInt(this.style.width.replace("px", ""));
            }
            spn.text = this.innerText;
            list.push(spn);
        });
    }

    arg.items = list;
    return arg;
}

function initSmartWizard(selected, enableAllSteps)
{
    $('#wizard').smartWizard({
        transitionEffect: 'none',
        selected: selected,
        enableAllSteps: enableAllSteps,
        enableFinishButton: true,
        labelPrevious: '上一步',
        labelNext: '下一步',
        labelFinish: '打印',
        onShowStep: showStep,
        onLeaveStep: leaveStep,
        onFinish: finish
    });
}

//显示遮罩层
function _showScreen(message)
{
    $("#screen").empty();
    var text = message ? message : " ";
    $("#screen").append("<span style='color:#fff;font-size:30px;line-height:1024px;'><img src='../../images/logo.png' style='vertical-align:middle' /> " + text + "</span>");
    $("#screen").css("width", 1366).css("height", 768).css("text-align", "center").show();
}
//隐藏遮罩层
function _hideScreen()
{
    $("#screen").hide();
}

function quit()
{
    //window.external.PaperBacking();
    //window.external.PlaySound("welcome.wav");
    window.location.href = "../welcome.html?toBiz=1";
	
}