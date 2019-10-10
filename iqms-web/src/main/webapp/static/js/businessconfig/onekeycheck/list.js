    var $info; //提示信息
    var $progressbar; //进度条
    var $progressbarSpan; //百分比
    var winList = "";
    $(function(){
    	initProgressBar();
    });
    
    
    /**
     * 初始化进度条
     * 1、清空提示信息
     * 2、清空进度条
     */
    function initProgressBar(){
    	$info.empty().html("");
        $progressbar.css("width", "0%");
        $progressbarSpan.text("0%");
        $progressbar.removeClass("progress-bar-danger");
    }
    
    /**
     * 设置进度条百分比
     * @param percent 百分比
     * @param isPass  true-通过   false-建议失败
     */
    function setProgressBar(percent,isPass){
    	$progressbar.css("width", percent);
    	
    	if (!isPass){ //检测失败
    		$progressbar.addClass("progress-bar-danger");
    	}
    	
        $progressbarSpan.text(percent);
    }
    
    /**
     * 一键检测的方法
     */
    function check()
    {
    	$info = $("#info"); //提示信息
    	$progressbar = $("#progressbar"); //进度条
    	$progressbarSpan = $("#progressbar span"); //百分比
    	
    	//重置进度条
    	initProgressBar();
    	
    	//查询条件
    	var jo = {};
        jo.deviceNo = $("#deviceNo").val();
    	
    	//1、检测是否创建窗口,检测是否所有窗口都没有开启
    	$.ajax({
    		url: contextPath+"/businessconfig/onekeycheck/winNo?dt="+new Date().getTime(),
    		type : "get",
    		dataType: "json",
    		contentType: "application/json",
    		data:jo,
    		success: function(data) {
    			winList = data.rows;
    			if (winList != null && winList.length > 0){
    				
    				var winOpenFlag = false; //没有启用窗口
    				setProgressBar("10%",true);
    				var openWin = "";
    				for (var i = 0 ; i < winList.length; i++){
    					
    					var winObj = winList[i];
    					if (winObj.isStart == 1) {
    						winOpenFlag = true;
    						openWin += winObj.winNo+"&nbsp;&nbsp;"
    					}
    				}
    				
    				if (winOpenFlag) {
    					$info.append('<div class="alert-success"><span class="ace-icon fa fa-check"></span>窗口配置检测：【通过】-开启窗口：'+openWin+'</div>');
    					//检测叫号策略
//        				checkWinBuz(winList);
        				//检测业务显示和网点业务
    					checkBuzShow();
    				} else {
    					setProgressBar("100%",false);
        				$info.append('<div class="alert-danger"><span class="ace-icon fa fa-times red2" />窗口配置检测：【未通过】-配置了窗口，但是没有启用窗口!</div>');
    				}
    				
    			} else {
    				//没有配置窗口号（给出检测失败信息）
    				setProgressBar("100%",false);
    				$info.append('<div class="alert-danger"><span class="ace-icon fa fa-times red2" />窗口配置检测：【未通过】-未检测到窗口配置!</div>');
    			}
    		},
    		error: function(msg) {
    			//数据查询失败
    			setProgressBar("100%",false);
				$info.append('<div class="alert-danger">窗口配置检测：【未通过】-检测出现异常!</div>');
    		}
	      });
    }
    
    /**
     * 2、检测叫号策略
     * a-检测窗口是否配置叫号策略
     * b-检测窗口是否配置平日叫号策略
     * c-检测窗口是否配置假日叫号策略
     * @param winList(开启，未开启的窗口号)
     */
    function checkWinBuz(){
    	var jo = {};
        jo.deviceNo = $("#deviceNo").val();
    	$.ajax({
    		url: contextPath+"/businessconfig/onekeycheck/winNoBuz?dt="+new Date().getTime(),
    		type : "get",
    		dataType: "json",
    		contentType: "application/json",
    		data:jo,
    		success: function(data) {
    			var winBuzList = data.rows;  //窗口号+平日假日
    			if (winBuzList != null && winBuzList.length > 0){
    				setProgressBar("30%",true);
    				$info.append('<div class="alert-success"><span class="ace-icon fa fa-check"></span>叫号策略检测：【通过】-叫号策略配置成功</div>');
    				//遍历所有窗口(开启的窗口)
    				for (var i = 0; i < winList.length ; i++){
    					var winNoObj = winList[i];
    					var prFlag = false; //平日未配置
    					var jrFlag = false; //假日未配置未配置
    					if (winNoObj.isStart == 1){  //开放的窗口检测平日，假日配置
    						//遍历窗口业务
        					for (var j = 0; j < winBuzList.length; j++){
        						var winBuz = winBuzList[j];
        						var winBuzNo = winBuz.counterId; // 窗口业务中的窗口号
        						var winBuzDateType = winBuz.dateTypeId; // 窗口业务中的日期类型
        						//窗口平日有配置
        						if (winBuzNo == winNoObj.winNo && winBuzDateType == 1) {
        							prFlag = true;
        						}
        						//窗口假日有配置
        						if (winBuzNo == winNoObj.winNo && winBuzDateType == 2) {
        							jrFlag = true;
        						}
        					}
        					//展示信息
        					if (prFlag && jrFlag) { //窗口配置成功
        						$info.append('<div class="alert-success" style="margin-left:20px"><span class="ace-icon fa fa-check"></span>'+winNoObj.winNo+'号窗口叫号策略配置成功</div>');
        					} else if (!prFlag && !jrFlag) {  //
        						$info.append('<div class="alert-warning" style="margin-left:20px"><span class="fa fa-exclamation-triangle"></span>'+winNoObj.winNo+'号窗口叫号策略未配置（根据实际情况是否需要对此窗口的叫号策略进行配置，此窗口无法叫号）</div>');
        					} else if (!prFlag && jrFlag) { //平日未配置
        						$info.append('<div class="alert-warning" style="margin-left:20px"><span class="ace-icon fa fa-exclamation-triangle"></span>'+winNoObj.winNo+'号窗口平日叫号策略未配置（根据实际情况是否需要对平日进行配置，此窗口平日无法叫号）</div>');
        					} else if (prFlag && !jrFlag) { //假日未配置
        						$info.append('<div class="alert-warning" style="margin-left:20px"><span class="ace-icon fa fa-exclamation-triangle"></span>'+winNoObj.winNo+'号窗口假日叫号策略未配置（根据实际情况是否需要对假日进行配置，此窗口假日无法叫号）</div>');
        					}
    					}
    				}
    				
    				//检测号票模板
    				checkTicketModel();
    			} else {
    				//没有为窗口配置叫号策略
    				setProgressBar("100%",false);
    				$info.append('<div class="alert-danger"><span class="ace-icon fa fa-times red2" />叫号策略检测：【未通过】-未检测到窗口叫号策略的配置!</div>');
    				
    			}
    		},
    		error: function(msg) {
    			//数据查询失败
    			setProgressBar("100%",false);
				$info.append('<div class="alert-danger">叫号策略检测：【未通过】-检测出现异常!</div>');
    		}
	      });
    }
    
    /**
     * 3、检测号票模板
     * a-检测是否配置了号票模板
     * b-检测号票模板是否有模板配制
     */
    function checkTicketModel(){
    	var jo = {};
        jo.deviceNo = $("#deviceNo").val();
    	$.ajax({
    		url: contextPath+"/businessconfig/onekeycheck/ticketModel?dt="+new Date().getTime(),
    		type : "get",
    		dataType: "json",
    		contentType: "application/json",
    		data:jo,
    		success: function(data) {
    			var ticketForms = data.rows;  //
    			if (ticketForms != null && ticketForms.length > 0){
    				var styleFlag = false;
    				//检测模板是否配置成功
    				for (var i = 0; i < ticketForms.length; i++){
    					var ticketForm = ticketForms[i];
    					
    					//展示信息
    					if (ticketForm.ticketSytelFlag == 1) { //
    						styleFlag = true; //有模板内容
    					}  
    				}
    				
    				if (styleFlag) { //号票配置成功
    					setProgressBar("60%",true);
    					$info.append('<div class="alert-success"><span class="ace-icon fa fa-check"></span>号票检测：【通过】号票模板配置成功</div>');
    					//展示没有配置号票内容的模板
    					for (var i = 0; i < ticketForms.length; i++){
        					var ticketForm = ticketForms[i];
        					//展示信息
        					if (ticketForm.ticketSytelFlag == 0) { //多个号票模板，警告没有配置号票内容的模板
        						$info.append('<div class="alert-warning" style="margin-left:20px"><span class="ace-icon fa fa-exclamation-triangle"></span>模板名称【'+ticketForm.tktTmpName+'】的模板未配置号票内容</div>');
        					}  
        				}
    					//检测业务及显示时间
//    				    checkBuzShow();
    					// 检测取号界面
    					checkQueueface();
    					
    				} else { //号票配置失败
    					setProgressBar("100%",false);
    					$info.append('<div class="alert-danger"><span class="ace-icon fa fa-times red2" />号票模板检测：【未通过】-号票模板存在，但是模板没有进行号票内容配置，客户取票打印小票内容为空白</div>');
    				}
    				
    			} else {
    				//号票配置失败
    				setProgressBar("100%",false);
    				$info.append('<div class="alert-danger"><span class="ace-icon fa fa-times red2" />号票模板检测：【未通过】-未检测到号票模板配制记录!</div>');
    				
    			}
    		},
    		error: function(msg) {
    			//数据查询失败
    			setProgressBar("100%",false);
				$info.append('<div class="alert-danger">号票模板检测：【未通过】-检测出现异常!</div>');
    		}
	      });
    }
    
    /**
     * 4、业务显示检测
     * a-检测是不是所有的业务都没有配置显示时间
     * b-警告业务没有配置时间显示的
     */
    function checkBuzShow(){
    	var jo = {};
        jo.deviceNo = $("#deviceNo").val();
    	$.ajax({
    		url: contextPath+"/businessconfig/onekeycheck/buztime?dt="+new Date().getTime(),
    		type : "get",
    		dataType: "json",
    		contentType: "application/json",
    		data:jo,
    		success: function(data) {
    			var buzTimes = data.rows;  //业务及业务显示时间
    			if (buzTimes != null && buzTimes.length > 0){
    				
    				$info.append('<div class="alert-success"><span class="ace-icon fa fa-check"></span>网点业务检测：【通过】-网点业务配置成功</div>');
    				
    				var buzFlag = false;
    				//检测是否有业务配置了时间
    				for (var i = 0; i < buzTimes.length; i++){
    					var buzTime = buzTimes[i];
    					
    					//展示信息
    					if (buzTime.cnt != null && parseInt(buzTime.cnt, 10) > 0) { //有业务显示时间
    						buzFlag = true;
    					}  
    				}
    				
    				if (buzFlag) { //业务时间配置成功
    					setProgressBar("70%",true);
    					$info.append('<div class="alert-success"><span class="ace-icon fa fa-check"></span>业务显示时间检测：【通过】-业务显示时间配置成功</div>');
    					//检测业务显示时间配置详情
    					var buzArr = [];
    					for (var i = 0; i < buzTimes.length; i++){
        					var buzObj = buzTimes[i];
        					var nflag = false;  //平日时间是否存在
        					var hflag = false; // 假日时间是否存在
        					
        					//如果这个业务类型已经检测过了，就跳过，否则保存到数据里面
        					if (buzArr.contains(buzObj.busId)) {
        						continue;
        					} else {
        						buzArr.push(buzObj.busId);
        					}
        					
        					for (var j = 0; j < buzTimes.length; j++){
        						var buzTimeObj = buzTimes[j];
        						
        						if (buzObj.busId == buzTimeObj.busId && buzTimeObj.dateType == 'H'){
        							hflag = true;
        						}
        						
        						if (buzObj.busId == buzTimeObj.busId && buzTimeObj.dateType == 'N'){
        							nflag = true;
        						}
        						
        					}
        					//打印业务平日假日时间显示情况
        					if (!nflag && !hflag) { //业务一直不显示
        						$info.append('<div class="alert-warning" style="margin-left:20px"><span class="ace-icon fa fa-exclamation-triangle"></span>业务显示时间检测：【'+buzObj.businessName+'】在取号界面不显示</div>');
        					} else if (!nflag && hflag) {
        						$info.append('<div class="alert-warning" style="margin-left:20px"><span class="ace-icon fa fa-exclamation-triangle"></span>业务显示时间检测：【'+buzObj.businessName+'】业务平日不显示</div>');
        					} else if (nflag && !hflag) {
        						$info.append('<div class="alert-warning" style="margin-left:20px"><span class="ace-icon fa fa-exclamation-triangle"></span>业务显示时间检测：【'+buzObj.businessName+'】业务假日不显示</div>');
        					}
        				}
    					
    					// 检测取号界面
//    					checkQueueface();
    					//检测叫号策略
    					checkWinBuz();
    				} else { //没有配置业务显示时间
    					setProgressBar("100%",false);
    					$info.append('<div class="alert-danger"><span class="ace-icon fa fa-times red2" />业务显示时间检测：【未通过】-没有配置业务显示时间，取号界面不会显示任何业务，影响客户取号</div>');
    				}
    			} else {
    				//没有配置
    				setProgressBar("100%",false);
    				$info.append('<div class="alert-danger"><span class="ace-icon fa fa-times red2" />业务显示时间检测：【未通过】-未能检测到网点业务配置，请配置网点业务，否则影响客户取号!</div>');
    				
    			}
    		},
    		error: function(msg) {
    			//数据查询失败
    			setProgressBar("100%",false);
				$info.append('<div class="alert-danger">业务显示时间检测：【未通过】-检测出现异常!</div>');
    		}
	      });
    }
    
    
    /**
     * 5、取号界面检测
     * a-取号模板是否存在
     * b-是否有默认模板
     * c-默认模板的分辨率样式是否存在
     */
    function checkQueueface(){
    	var jo = {};
        jo.deviceNo = $("#deviceNo").val();
    	$.ajax({
    		url: contextPath+"/businessconfig/onekeycheck/queueface?dt="+new Date().getTime(),
    		type : "get",
    		dataType: "json",
    		contentType: "application/json",
    		data:jo,
    		success: function(data) {
    			var queuefaces = data.rows;  //取号界面列表数据，（至少会有设备信息）
    			if (queuefaces != null && queuefaces.length > 0){
    				var defModelAttr = [];  //保存所有的默认模板
    				var norModelAtrr = [] ; //没有勾选默认膜拜
    				
    				//找出所有的默认模板
    				for (var i = 0; i < queuefaces.length; i++){
    					var queuefaceObj = queuefaces[i];
    					
    					//默认模板不为空，
    					if (queuefaceObj.def == 1) { //默认模板
    						defModelAttr.push(queuefaceObj);
    					}  
    					
    					if (queuefaceObj.def == 0) { //非默认模板
    						norModelAtrr.push(queuefaceObj);
    					}  
    				}
    				
    				var queuefaceFlag = false;  //
    				
    				//默认模板为空，但是普通默认模板不为空
    				if (defModelAttr.length == 0 && norModelAtrr.length > 0) {
    					setProgressBar("100%",false);
    					$info.append('<div class="alert-danger"><span class="ace-icon fa fa-times red2" />取号界面检测：【未通过】-取号界面模板存在，但是没有默认模板，只有默认取号界面才会下发给排队机</div>');
    					
    				} else if (defModelAttr.length == 0 && norModelAtrr.length == 0)  {
    					setProgressBar("100%",false);
    					$info.append('<div class="alert-danger"><span class="ace-icon fa fa-times red2" />取号界面检测：【未通过】-未配置取号界面模板</div>');
    				} else if (defModelAttr.length > 0){  //默认模板存在，需要检测取号界面是否存在
    					//没有设计取号界面，将没有样式
    					var qfprFlag = false;  //平日
    					var qfjrFlag = false;  //假日
    					for (var i = 0; i < defModelAttr.length; i++){
    						var defModelObj = defModelAttr[i];
    						
    						if (defModelObj.copyStatus == '1') { //节假日相同
    							qfprFlag = true;
    							qfjrFlag = true;
    						}
    						
    						if (defModelObj.dateTypeId == '1') { //平日
    							qfprFlag = true;
    						}
    						
    						if (defModelObj.dateTypeId == '2') { //假日
    							qfjrFlag = true;
    						}
    						
    					}
    					
    					 if (qfprFlag && qfjrFlag) {
     						setProgressBar("90%",true);
         					$info.append('<div class="alert-success"><span class="ace-icon fa fa-check"></span>取号界面检测：【通过】</div>');
     					}
    					
    					//展示检测信息
    					if (!qfprFlag && !qfjrFlag) {
    						setProgressBar("100%",false);
        					$info.append('<div class="alert-danger"><span class="ace-icon fa fa-times red2" />取号界面检测：【未通过】-取号界面配置了默认模板，未检测到设计取号界面</div>');
    					} 
    					
    					if (!qfprFlag && qfjrFlag){
    						setProgressBar("90%",true);
         					$info.append('<div class="alert-success"><span class="ace-icon fa fa-check"></span>取号界面检测：【通过】</div>');
    						$info.append('<div class="alert-warning" style="margin-left:20px"><span class="ace-icon fa fa-exclamation-triangle"></span>未检测到平日的取号界面设计，星期一至星期五排队机上将没有取号界面（可以在取号界面配置勾选平日同假日）</div>');
    					} 
    					
    					if (qfprFlag && !qfjrFlag) {
    						setProgressBar("90%",true);
         					$info.append('<div class="alert-success"><span class="ace-icon fa fa-check"></span>取号界面检测：【通过】</div>');
    						$info.append('<div class="alert-warning" style="margin-left:20px"><span class="ace-icon fa fa-exclamation-triangle"></span>未检测到假日的取号界面设计，星期六至星期天排队机上将没有取号界面（可以在取号界面配置勾选平日同假日）</div>');
    					}
    					//检测客户级别
     					checkCustLevel();
    				}
    				
    			} else {
    				//连设备都没有查询到（肯定不会存在）
    				setProgressBar("100%",false);
    				$info.append('<div class="alert-danger"><span class="ace-icon fa fa-times red2" />取号界面检测：【不通过】-设备信息未查询到（检测不通过）!</div>');
    			}
    		},
    		error: function(msg) {
    			//数据查询失败
    			setProgressBar("100%",false);
				$info.append('<div class="alert-danger">取号界面检测：【不通过】-检测出现异常!</div>');
    		}
	      });
    }
    
    /**
     * 6、检测客户级别
     * a-客户级别是否存在
     * b-客户级别0是否配置了号票模板
     */
    function checkCustLevel(){
    	var jo = {};
        jo.deviceNo = $("#deviceNo").val();
    	$.ajax({
    		url: contextPath+"/businessconfig/onekeycheck/custlevel?dt="+new Date().getTime(),
    		type : "get",
    		dataType: "json",
    		contentType: "application/json",
    		data:jo,
    		success: function(data) {
    			var custlevels = data.rows;  //所有的客户级别信息
    			if (custlevels != null && custlevels.length > 0){
    				
    				var custFlag = false;
    				var ncust0Attr = [];
    				
    				//找到客户级别为0的，
    				for (var i = 0; i < custlevels.length; i++){
    					var custlevelObj = custlevels[i];
    					if (custlevelObj.custLevel == '0' && custlevelObj.ticketTemplate != null && custlevelObj.ticketTemplate != ''){
    						custFlag = true;
    					} else {
    						ncust0Attr.push(custlevelObj);
    					}
    				}
    				
    				if (custFlag) {  //客户级别配置成功
    					setProgressBar("100%",true);
    					$info.append('<div class="alert-success"><span class="ace-icon fa fa-check"></span>客户等级检测：【通过】</div>');
    					
    					//查询告警信息
    					for (var j = 0; j < ncust0Attr.length; j++) {
    						var ncust0Obj = ncust0Attr[j];
    						if (ncust0Obj.ticketTemplate == null || ncust0Obj.ticketTemplate == '' || ncust0Obj.ticketTemplate == '0'){
    							$info.append('<div class="alert-warning" style="margin-left:20px"><span class="ace-icon fa fa-exclamation-triangle"></span>【客户等级'+ncust0Obj.custLevel+'】未关联号票模板，此级别客户无法打印号票</div>');
    						}
    					}
    				
    				} else {
    					setProgressBar("100%",false);
    					$info.append('<div class="alert-danger"><span class="ace-icon fa fa-times red2" />客户等级检测：【不通过】-级别为0的必须配置号票模板，否则取号无法打印号票。</div>');
    				}
    			} else {
    				//客户级别配置错误
    				setProgressBar("100%",false);
    				$info.append('<div class="alert-danger"><span class="ace-icon fa fa-times red2" />客户等级检测：【不通过】-未能查询到客户级别的配置!</div>');
    			}
    		},
    		error: function(msg) {
    			//数据查询失败
    			setProgressBar("100%",false);
				$info.append('<div class="alert-danger">客户等级检测：【不通过】-检测出现异常!</div>');
    		}
	      });
    }
    
    
    
    
    
    
    
    
    
    	
    	
    	
    	
    	
    	
