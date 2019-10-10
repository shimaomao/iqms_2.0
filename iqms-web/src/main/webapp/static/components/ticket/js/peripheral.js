var isPlaySoundCustMgr = false;

$.qms =
{
	swipeAllCardStart: function ()
    {
    	//一体机点击取号时初始化刷卡设备 add by fdw 20170401
        $.gecko.invoke("scriptInvoker", "InitSwipe", "InitSwipeCallback", {});
    },
    swipeAllCardStop: function ()
    {
    	//返回主界面取消初始化刷卡设备 add by fdw 20170401
        $.gecko.invoke("scriptInvoker", "CancelSwipe", "CancelSwipeCallback", {});
    },
    createTktFormat: function (args)
    {
        $.gecko.invoke("ticketTemplateService", "CreateTktFormat", "ifrm.contentWindow.createTktFormatCallback", args);
    },

    updateTktFormat: function (args)
    {
        $.gecko.invoke("ticketTemplateService", "UpdateTktFormat", "ifrm.contentWindow.updateTktFormatCallback", args);
    },

    removeTktFormat: function (args)
    {
        $.gecko.invoke("ticketTemplateService", "RemoveTktFormat", "ifrm.contentWindow.removeTktFormatCallback", args);
    },

    getTktFormat: function (args)
    {
        return $.parseJSON(windowExternalPluginInvoke("ticketTemplateService", "GetTktFormat", $.toJSON(args)));
    },

    getTktFormats: function ()
    {
        $.gecko.invoke("ticketTemplateService", "GetTktFormats", "ifrm.contentWindow.getTktFormatsCallback", {});
    },
    getBackgroundImgs: function (args)
    {
        $.gecko.invoke("queueTemplateService", "GetBackgroundImgs", "ifrm.contentWindow.getBackgroundImgsCallback", {});
    },
    getVideoList: function (args)
    {
        var c = args.callback ? args.callback : "getVideoListCallback";
        $.gecko.invoke("queueTemplateService", "GetVideoList", c, args);
    },
    getMusicList: function (args)
    {
        var c = args.callback ? args.callback : "getMusicListCallback";
        $.gecko.invoke("queueTemplateService", "GetMusicList", c, args);
    },
    getCouponImgs: function (args)
    {
        $.gecko.invoke("queueTemplateService", "GetCouponImgs", "getCouponImgsCallback", args);
    },
    getSettingsByType: function (args)
    {
        $.gecko.invoke("settingService", "GetSettingsByType", args.callback, args);
    },
    getQueueCtrlsByType: function (args)
    {
        $.gecko.invoke("settingService", "GetQueueCtrlsByType", args.callback, args);
    },
    getQueueCtrls: function (args)
    {
        $.gecko.invoke("settingService", "GetQueueCtrls", args.callback, args);
    },
    copyTicketTemplate: function (args)
    {
        $.gecko.invoke("ticketTemplateService", "CopyTicketTemplate", "ifrm.contentWindow.copyTicketTemplateCallback", args);
    },
    createTicketTemplate: function (args)
    {
        $.gecko.invoke("ticketTemplateService", "CreateTicketTemplate", args.callback, args);
    },

    updateTicketTemplate: function (args)
    {
        $.gecko.invoke("ticketTemplateService", "UpdateTicketTemplate", args.callback, args);
    },

    selectCustLevel4DeleteTicketTemplate: function (args)
    {
        $.gecko.invoke("ticketTemplateService", "SelectCustLevel4DeleteTicketTemplate", args.callback, args);
    },

    removeTicketTemplate: function (args)
    {
        $.gecko.invoke("ticketTemplateService", "RemoveTicketTemplate", args.callback, args);
    },

    getTicketTemplate: function (args)
    {
        $.gecko.invoke("ticketTemplateService", "GetTicketTemplate", "ifrm.contentWindow.getTicketTemplateCallback", args);
    },

    getTicketTemplates: function ()
    {
        $.gecko.invoke("ticketTemplateService", "GetTicketTemplates", "ifrm.contentWindow.getTicketTemplatesCallback", {});
    },

    saveTicketTemplateJsonFile: function (args)
    {
        $.gecko.invoke("ticketTemplateService", "SaveTicketTemplateJsonFile", args.callback, args);
    },

    getTicketTemplateJsonFile: function (args)
    {
        $.gecko.invoke("ticketTemplateService", "GetTicketTemplateJsonFile", args.callback, args);
    },

    createTeller: function (args)
    {
        return $.parseJSON(windowExternalPluginInvoke("tellerService", "CreateTeller", $.toJSON(args)));
    },

    getTeller: function (rowid)
    {
        var args = {};
        args.teller = {};
        args.teller.rowid = rowid;
        return $.parseJSON(windowExternalPluginInvoke("tellerService", "GetTeller", $.toJSON(args)));
    },
    //------------------------------------------窗口------------------------------------------------------
    saveCounters: function (args)
    {
        $.gecko.invoke("counterService", "SaveCounters", args.callback, args);
    },
    createCounter: function (args)
    {
        return $.parseJSON(windowExternalPluginInvoke("counterService", "CreateCounter", $.toJSON(args)));
    },

    updateCounter: function (args)
    {
        return $.parseJSON(windowExternalPluginInvoke("counterService", "UpdateCounter", $.toJSON(args)));
    },

    removeCounter: function (args)
    {
        return $.parseJSON(windowExternalPluginInvoke("counterService", "RemoveCounter", $.toJSON(args)));
    },

    getCounter: function (args)
    {
        return $.parseJSON(windowExternalPluginInvoke("counterService", "GetCounter", $.toJSON(args)));
    },
    getCounters: function (args)
    {
        var a = args ? args : {};
        $.gecko.invoke("counterService", "GetCounters", "ifrm.contentWindow.getCountersCallback", a);
    },
    //------------------------------------------客户等级------------------------------------------------------	
    createCustLevel: function (jo)
    {
        var args = {};
        args.custLevel = jo;
        return $.parseJSON(windowExternalPluginInvoke("counterService", "CreateCustLevel", $.toJSON(args)));
    },

    updateCustLevel: function (jo)
    {
        var args = {};
        args.custLevel = jo;
        return $.parseJSON(windowExternalPluginInvoke("counterService", "UpdateCustLevel", $.toJSON(args)));
    },

    removeCounter: function (rowid)
    {
        var args = {};
        args.custLevel.rowid = rowid;
        return $.parseJSON(windowExternalPluginInvoke("counterService", "RemoveCustLevel", $.toJSON(args)));
    },

    getCustLevel: function (rowid)
    {
        var args = {};
        args.custLevel.rowid = rowid;
        return $.parseJSON(windowExternalPluginInvoke("counterService", "GetCustLevel", $.toJSON(args)));
    },

    getCustLevels: function ()
    {
        $.gecko.invoke("counterService", "GetCustLevels", "ifrm.contentWindow.getCustLevelsCallback", {});
    },
    //------------------------------------------业务类型------------------------------------------------------
    ordernumber: function (args)//20160712根据预约码获取客户级别
    {
		//alert($.toJSON(args));
		$.gecko.invoke("ticketService", "Ordernumber", "",args);
    },
    createBuzType: function (args)
    {
        $.gecko.invoke("buzTypeService", "CreateBuzType", "ifrm.contentWindow.createBuzTypeCallback", args);
    },

    updateBuzType: function (args)
    {
        $.gecko.invoke("buzTypeService", "UpdateBuzType", "ifrm.contentWindow.updateBuzTypeCallback", args);
    },

    moveBuzType: function (args)
    {
        $.gecko.invoke("buzTypeService", "MoveBuzType", args.callback, args);
    },

    selectBuzTypeRef4Delete: function (args)
    {
        $.gecko.invoke("buzTypeService", "SelectBuzTypeRef4Delete", args.callback, args);
    },

    removeBuzType: function (args)
    {
        $.gecko.invoke("buzTypeService", "RemoveBuzType", args.callback, args);
    },

    getBuzTypesForTree: function (args)
    {
        $.gecko.invoke("buzTypeService", "GetBuzTypesForTree", args.callback, args);
    },

    getBuzTypesForTreeByDateTypeId: function (args)
    {
        $.gecko.invoke("buzTypeService", "GetBuzTypesForTreeByDateTypeId", args.callback, args);
    },

    getLeafBuzTypes: function ()
    {
        $.gecko.invoke("buzTypeService", "GetLeafBuzTypes", "ifrm.contentWindow.getLeafBuzTypesCallback", {});
    },

    getBuzTypeCount: function (args)
    {
        return $.parseJSON(windowExternalPluginInvoke("buzTypeService", "GetBuzTypeCount", $.toJSON(args)));
    },
    getBuzTypes: function ()
    {
        $.gecko.invoke("buzTypeService", "GetBuzTypes", "ifrm.contentWindow.getBuzTypesCallback", {});
    },

    printCoupon: function (args)
    {
        return $.parseJSON(windowExternalPluginInvoke("buzTypeService", "PrintCoupon", $.toJSON(args)));
    },
    //------------------------------------------业务显示时间------------------------------------------------------
    createBuzTime: function (jo)
    {
        var args = {};
        args.buzTime = jo;
        return $.parseJSON(windowExternalPluginInvoke("buzTypeService", "CreateBuzTime", $.toJSON(args)));
    },

    updateBuzTime: function (jo)
    {
        var args = {};
        args.buzTime = jo;
        return $.parseJSON(windowExternalPluginInvoke("buzTypeService", "UpdateBuzTime", $.toJSON(args)));
    },

    removeBuzTime: function (rowid)
    {
        var args = {};
        args.buzTime.rowid = rowid;
        return $.parseJSON(windowExternalPluginInvoke("buzTypeService", "RemoveBuzTime", $.toJSON(args)));
    },

    getBuzTimes: function (buzType, dateType)
    {
        var args = {};
        args.buzTime.buzType = buzType;
        args.buzTime.dateType = dateType;
        return $.parseJSON(windowExternalPluginInvoke("buzTypeService", "GetBuzTimes", $.toJSON(args)));
    },
    //------------------------------------------窗口业务------------------------------------------------------
    createCounterBuz: function (args)
    {
        return $.parseJSON(windowExternalPluginInvoke("counterService", "CreateCounterBuz", $.toJSON(args)));
    },


    removeBuzTime: function ()
    {
        var args = {};
        return $.parseJSON(windowExternalPluginInvoke("counterService", "RemoveAllCounterBuz", $.toJSON(args)));
    },

    getCounterBuzsByCounterId: function (args)
    {
        $.gecko.invoke("counterService", "GetCounterBuzsByCounterId", "ifrm.contentWindow.getCounterBuzsByCounterIdCallback", args);
    },

    getMrCounterBuzs: function ()
    {
        $.gecko.invoke("counterService", "GetMrCounterBuzs", "ifrm.contentWindow.getMrCounterBuzsCallback", {});
    },

    saveCounterBuzs: function (args)
    {
        $.gecko.invoke("counterService", "SaveCounterBuzs", "ifrm.contentWindow.saveCounterBuzsCallback", args);
    },



    //--------------------------------客户级别-------------------------------
    getCustLevels: function ()
    {
        $.gecko.invoke("customerService", "GetCustLevels", "ifrm.contentWindow.getCustLevelsCallback", {});
    },
    saveCustLevels: function (args)
    {
        $.gecko.invoke("customerService", "SaveCustLevels", "ifrm.contentWindow.saveCustLevelsCallback", args);
    },
    //--------------------------------特殊日期-------------------------------
    getSpecialDates: function ()
    {
        $.gecko.invoke("settingService", "GetSpecialDates", "ifrm.contentWindow.getSpecialDatesCallback", {});
    },

    saveSpecialDates: function (args)
    {
        $.gecko.invoke("settingService", "SaveSpecialDates", "ifrm.contentWindow.saveSpecialDatesCallback", args);
    },
    //--------------------------------柜员设置-------------------------------
    getTellers: function (args)
    {
        $.gecko.invoke("tellerService", "GetTellers", "ifrm.contentWindow.getTellersCallback", args);
    },

    saveTellers: function (args)
    {
        $.gecko.invoke("tellerService", "SaveTellers", "ifrm.contentWindow.saveTellersCallback", args);
    },
    //--------------------------------特殊客户-------------------------------
    getSpecialCusts: function ()
    {
        $.gecko.invoke("customerService", "GetSpecialCusts", "ifrm.contentWindow.getSpecialCustsCallback", {});
    },
    saveSpecialCusts: function (args)
    {
        $.gecko.invoke("customerService", "SaveSpecialCusts", "ifrm.contentWindow.saveSpecialCustsCallback", args);
    },

    //--------------------------------业务显示-------------------------------
    getDateTypeIdByToday: function ()
    {
        $.gecko.invoke("settingService", "GetDateTypeIdByToday", "getDateTypeIdByTodayCallback", {});
    },
    getBuzTypesForTree: function (args)
    {
        $.gecko.invoke("buzTypeService", "GetBuzTypesForTree", args.callback, args);
    },

    getCurrBuzTypesForTree: function (args)
    {
        $.gecko.invoke("buzTypeService", "GetCurrBuzTypesForTree", "getCurrBuzTypesForTreeCallback", args);
    },
    getBuzTimeByBuzTypeId: function (args)
    {
        $.gecko.invoke("buzTypeService", "GetBuzTimeByBuzTypeId", "ifrm.contentWindow.getBuzTimeByBuzTypeIdCallback", args);
    },
    saveBizTimes: function (args)
    {
        $.gecko.invoke("buzTypeService", "SaveBizTimes", "ifrm.contentWindow.saveBizTimesCallback", args);
    },
    sendMessage: function (args)
    {
        $.gecko.invoke("ticketService", "SendMessage", "ifrm.contentWindow.sendMessageCallback", args);
    },
    //--------------------------------单据业务-------------------------------
    getBusTypesExceptEnabled: function ()
    {
        //alert("getBusTypesExceptEnabled");
        var args = {};
        return $.parseJSON(windowExternalPluginInvoke("buzTypeService", "GetBusTypesExceptEnabled", $.toJSON(args)));
    },
    getBusTypesIdByBuzTypeId: function (args)
    {
        //alert("getBusTypesIdByBuzTypeId");
        return $.parseJSON(windowExternalPluginInvoke("buzTypeService", "GetBusTypesIdByBuzTypeId", $.toJSON(args)));
    },
    saveBuzBuses: function (args)
    {
        return $.parseJSON(windowExternalPluginInvoke("buzTypeService", "SaveBuzBuses", $.toJSON(args)));
    },
    //--------------------------------本地识别-------------------------------
    getCustRecs: function ()
    {
        $.gecko.invoke("customerService", "GetCustRecs", "ifrm.contentWindow.getCustRecsCallback", {});
    },
    saveCustRecs: function (args)
    {
        $.gecko.invoke("customerService", "SaveCustRecs", "ifrm.contentWindow.saveCustRecsCallback", args);
    },
    getTicket: function (args)
    {
        $.gecko.invoke("ticketService", "GetTicket", "getTicketCallback", args);
    },
    getWaitings: function (args)
    {
        $.gecko.invoke("ticketService", "GetWaitingCount", "getWaitingsCallback", args);
    },
    callTicket: function (args)
    {
        return $.parseJSON(windowExternalPluginInvoke("ticketService", "CallTicket", $.toJSON(args)));
    },
    setPopEvent: function (args)
    {
        $.gecko.invoke("peripheralManager", "SetPopEvent", "", args);
    },
    cancelSwipeAllCard: function ()
    {
        var args = {};
        windowExternalPluginInvoke("peripheralManager", "Cancel", $.toJSON(args));
    },
    playSoundCustMgr: function ()
    {
        if (isPlaySoundCustMgr)
        {
            return;
        }

        isPlaySoundCustMgr = true;
        $.gecko.invoke("ticketService", "PlaySoundCustMgr", "", {});
        setTimeout(function () { isPlaySoundCustMgr = false; }, 1500);
    },
    lockTicket: function (args)
    {
		//alert($.toJSON(args));
		$.gecko.invoke("ticketService", "LockTicket", "", args);
    },
    unlockTicket: function (args)
    {
        //return $.parseJSON(windowExternalPluginInvoke("ticketService", "UnlockTicket", $.toJSON(args)));
		$.gecko.invoke("ticketService", "UnlockTicket", "", args);
    },
    isEffectQueueNo: function (args)
    {
        //return $.parseJSON(windowExternalPluginInvoke("ticketService", "IsEffectQueueNo", $.toJSON(args)));
		$.gecko.invoke("ticketService", "IsEffectQueueNo", "isEffectQueueNoCallback", args);
    },
    yesterdayBizReport: function ()
    {
        $.gecko.invoke("ticketService", "YesterdayBizReport", "", {});
    },
    todayBizReport: function ()
    {
        $.gecko.invoke("ticketService", "TodayBizReport", "", {});
    }
};

$.pps =
{
	objId: "",
    toPinyin: function (val)
    {
        return window.external.ToPinyin(val);
    },
    toPinyins: function (val)
    {
        return window.external.ToPinyins(val);
    },
    login: function (username, password)
    {
        var args = {};
        args.admin = {};
        args.admin.username = username;
        args.admin.password = password;
        $.gecko.invoke("adminService", "Login", "loginCallback", args);
    },
    log: function (message, type)
    {
        var args = {};
        args.log = {};
        args.log.operationData = message;
        args.log.operationType = type;

        windowExternalPluginInvoke("logService", "CreateLogAsync", $.toJSON(args));
    },
    setVolume: function (val)
    {
        var args = {};
        args.settings = {};
        args.settings.volume = val;
        $.gecko.invoke("systemService", "SetVolume", "setVolumeCallback", args);
    },
    setMute: function (val)
    {
        var args = {};
        args.settings = {};
        args.settings.isMute = val;
        $.gecko.invoke("systemService", "SetMute", "", args);
    },
    shutdown: function ()
    {
        $.gecko.invoke("systemService", "Shutdown", "", {});
    },
    restart: function ()
    {
        $.gecko.invoke("systemService", "Restart", "", {});
    },
    appRestart: function ()
    {
        $.gecko.invoke("systemService", "AppRestart", "", {});
    },
    getBusType: function (busTypeId)
    {
        //alert("getBusType");
        var args = {};
        args.busType = {};
        args.busType.busTypeId = busTypeId;
		args.callback = "getBusTypeCallback";
		$.gecko.invoke("busTypeService", "GetBusType", args.callback, args);
        //return $.parseJSON(windowExternalPluginInvoke("busTypeService", "GetBusType", $.toJSON(args)));
    },
    getBusTypes: function ()
    {
        $.gecko.invoke("busTypeService", "GetBusTypes", "getBusTypesCallback", {});
    },
    getBusTypesByBuzTypeId: function (buzTypeId)
    {
        var args = {};
        args.buzTypeId = buzTypeId;

        $.gecko.invoke("busTypeService", "GetBusTypesByBuzTypeId", "", args);
    },
    getSettings: function (c)
    {
        var callback;
        if (c)
        {
            callback = c;
        }
        else
        {
            callback = "getSettingsCallback";
        }

        $.gecko.invoke("settingService", "GetSettings", callback, {});
    },
    saveSettings: function (args)
    {
        var c = args.callback ? args.callback : "saveSettingsCallback";
        $.gecko.invoke("settingService", "SaveSettings", c, args);
    },
    getStyles: function (args)
    {
        var c = args.callback ? args.callback : "getStylesCallback";
        $.gecko.invoke("styleService", "GetStylesByPage", c, args);
    },
    getCurrStyle: function (args)
    {
        var c = args.callback ? args.callback : "getCurrStyleCallback";
        $.gecko.invoke("styleService", "GetCurrStyle", c, args);
    },
    saveStyles: function (args)
    {
        $.gecko.invoke("styleService", "SaveStyles", "saveStylesCallback", args);
    },
    removeStyle: function (args)
    {
        $.gecko.invoke("styleService", "RemoveStyle", args.callback, args);
    },
    updateStyle: function (args)
    {
        $.gecko.invoke("styleService", "UpdateStyle", args.callback, args);
    },
    createStyle: function (args)
    {
        $.gecko.invoke("styleService", "CreateStyle", args.callback, args);
    },
    copyStyle: function (args)
    {
        $.gecko.invoke("styleService", "CopyStyle", args.callback, args);
    },
    getQueueTemplateJsonFile: function (args)
    {
        var c = args.callback ? args.callback : "getQueueTemplateJsonFileCallback";
        $.gecko.invoke("styleService", "GetQueueTemplateJsonFile", c, args);
    },
    getAppState: function ()
    {
    	//return $.parseJSON(windowExternalPluginInvoke("scriptInvoker", "GetAppState", {}));
        $.gecko.invoke("scriptInvoker", "GetAppState", "getAppStateCallback", {});
    },
    getAdvConfig: function ()
    {
        $.gecko.invoke("scriptInvoker", "GetAdvConfig", "getAdvConfigCallback", {});
    },
    getAppConfig: function ()
    {
        $.gecko.invoke("scriptInvoker", "GetAppConfig", "getAppConfigCallback", {});
    },
    saveAppConfig: function (args)
    {
        $.gecko.invoke("scriptInvoker", "SaveAppConfig", "saveAppConfigCallback", args);
    },
    getPrintConfig: function (args)
    {
		$.gecko.invoke("scriptInvoker", "GetPrintConfig", "getPrintConfigCallback", args);
    },
    saveAndPrintConfig: function (groupType, receiptType, jo)
    {
        var args = {}
        args.mask = {};
        args.mask.message = "正在打印，请稍候...";
        args.sound = ";10:preparation.wav";
        args.groupType = groupType;
        args.receiptType = receiptType;
        args.print = jo;
		$.gecko.invoke("scriptInvoker", "SaveAndPrintConfig", "", args);
        //window.external.SaveAndPrintConfig($.toJSON(args));
    },
    saveAndPrintReceipt: function (args)
    {
        args.mask = {};
        args.mask.message = "正在打印，请稍候...";
        args.sound = ";10:preparation.wav";
		$.gecko.invoke("receiptService", "SaveAndPrintReceiptAsync", args.callback, args);
        //windowExternalPluginInvoke("receiptService", "SaveAndPrintReceiptAsync", $.toJSON(args));
    },
    getLastReceipt: function (receiptType, certType, certNo, cardType, cardNo)
    {
        var args = {};
        args.query = {};
        args.query.receiptType = receiptType;
        args.query.certType = certType;
        args.query.certNo = certNo;
        args.query.cardType = cardType;
        args.query.cardNo = cardNo;
		args.callback = "getLastReceiptCallback";
		$.gecko.invoke("receiptService", "GetLastReceipt", args.callback, args);
        //return $.parseJSON(windowExternalPluginInvoke("receiptService", "GetLastReceipt", $.toJSON(args)));
    },
    getReceiptStatListByPage: function (beginDate, endDate, rows, page)
    {
        var args = {};
        args.query = {};
        args.query.beginDate = beginDate;
        args.query.endDate = endDate;
        args.query.rows = rows;
        args.query.page = page;
		args.callback = "getReceiptStatByPageCallback";
		$.gecko.invoke("receiptService", "GetReceiptStatByPage", args.callback, args);
        //return $.parseJSON(windowExternalPluginInvoke("receiptService", "GetReceiptStatByPage", $.toJSON(args)));
    },
    getCustomer: function (certType, certNo)
    {
        var args = {};
        args.customer = {};
        args.customer.certType = certType;
        args.customer.certNo = certNo;
		args.callback = "GetCustomerByCertCallback";
		$.gecko.invoke("customerService", "GetCustomerByCert", args.callback, args);
        //return $.parseJSON(windowExternalPluginInvoke("customerService", "GetCustomerByCert", $.toJSON(args)));
    },
    playSound: function (wav)
    {
        var args = {};
        args.wav = wav;
        $.gecko.invoke("scriptInvoker", "PlaySound", "", args);
    },
	//1  2  3（银行卡）  4（身份证） 
	swipeCard: function (objId,callback,type) {
		//alert(type);
		//this.objId = objId;
		swipeCard(3);
		var args = {};
        args.objId = objId;
        args.callback = callback;
        args.type = 3;
        args.tag = "A";
        $.gecko.invoke("scriptInvoker", "SwipeCardtd", args.callback, args);
	},
	//add by fdw  刷身份证
	swipeIDCard: function (objId,callback,type) {
		//alert(type);
		//this.objId = objId;
		swipeCard(4);
		var args = {};
        args.objId = objId;
        args.callback = callback;
        args.type = 4;
        args.tag = "A";
        $.gecko.invoke("scriptInvoker", "SwipeCardtd", args.callback, args);
	},
	 getMachineCode: function ()
    {
		
		var args = {};
        $.gecko.invoke("registerService", "GetLocalMachineCode", "getMachineCodeCallback", args);
    },
	register: function (args)
    {
		
		
        $.gecko.invoke("registerService", "AnalysisRegistrationCode", "registerCallback", args);
    },
	checkReg: function ()
    {
		//alert(2);
		var args = {};
        $.gecko.invoke("registerService", "CheckRegistratinCode", "registerCallback", args);
    },
	/*setSwipeType: function (swipeType) {
		//alert(swipeType);
        var args = {};
        args.swipeType = swipeType;
		$.gecko.invoke("peripheralManager", "SetSwipeType", "", args);
        //window.external.PluginInvoke("peripheralManager", "SetSwipeType", $.toJSON(args));
    },
    //flag == true 表示登录页面的刷卡身份证(自定义刷卡页面)  false 表示单据内容中的刷身份证
    swipeIDCard: function (objId, flag) {
        this.objId = objId;
        if (!flag){
            swipeCard("idCard");
		}
		this.jumpPage = flag;	
        var args = {};
        //args.sound = "idcard.wav;1:swipeIDCardfail.wav,4:swipeIDCardover.wav";
        args.swipeType = 4;
		//args.callback = "swipeIDCardCallback";
		$.gecko.invoke("peripheralManager", "SetSwipeType", "", args);
        //window.external.PluginInvoke("peripheralManager", "SetSwipeType", $.toJSON(args));
    },
    swipeCard: function (objId, flag) {
        this.objId = objId;
        if (!flag) {
            swipeCard("bankCard");
        }
		this.jumpPage = flag;	
        var args = {};
        //args.sound = "bankcard.wav;1:bankcarfail.wav,4:bankcarover.wav";
        args.swipeType = 3;
		//args.callback = "swipeMagneticCardCallback";
		$.gecko.invoke("peripheralManager", "SetSwipeType", "", args);
        //window.external.PluginInvoke("peripheralManager", "SetSwipeType", $.toJSON(args));
    },
    swipeAllCard: function (objId, flag) {
        this.objId = objId;
        swipeCard("all");
        var args = {};
        args.sound = "all.wav;1:allfail.wav,4:allover.wav";
        args.swipeType = true;
		$.gecko.invoke("peripheralManager", "SetSwipeType", "", args);
        window.external.PluginInvoke("peripheralManager", "SetSwipeType", $.toJSON(args));
    },
    cancelSwipeAllCard: function () {
        this.setSwipeType(0);
    },*/
	
	
    /*swipeIDCard: function (objId, callback, skipText)
    {
        var args = {};
        args.mask = {};
        args.mask.timeout = 10;
        args.mask.skipText = skipText;
        args.mask.message = "请刷身份证...";
        args.objId = objId;
        args.sound = "idcard.wav;1:swipeIDCardfail.wav,4:swipeIDCardover.wav";
        args.callback = callback;
        args.type = 4;
		//alert($.toJSON(args));
		$.gecko.invoke("peripheralManager", "SwipeCard", args.callback, args);
        //windowExternalPluginInvoke("peripheralManager", "SwipeCard", $.toJSON(args));
    },
    swipeCard: function (objId, callback, skipText)
    {
        var args = {};
        args.mask = {};
        args.mask.timeout = 10;
        args.mask.message = "请刷银行卡...";
        args.mask.skipText = skipText;
        args.objId = objId;
        args.sound = "bankcard.wav;1:bankcarfail.wav,4:bankcarover.wav";
        args.callback = callback;
        args.type = 3;
        args.tag = "A";
		$.gecko.invoke("peripheralManager", "SwipeCard", args.callback, args);
        //windowExternalPluginInvoke("peripheralManager", "SwipeCard", $.toJSON(args));
    },
    swipeEleCard: function (objId, callback, skipText)
    {
        var args = {};
        args.mask = {};
        args.mask.timeout = 10;
        args.mask.skipText = skipText;
        args.mask.message = "请刷电子结算证...";
        args.objId = objId;
        args.sound = "insertcard.wav;1:insertcarfail.wav,4:insertcarover.wav";
        args.callback = callback;
        args.type = 2;
        args.tag = "J";
        windowExternalPluginInvoke("icCardReaderWriter", "ReadAsync", $.toJSON(args));
    },*/
    loadKeyboard: function (obj, keyboardType, maxLen, format)
    {
		var text = document.getElementById(obj.id).value;
		var args = {};
		args.id=obj.id;
		args.text=text;
		args.maxLen=maxLen;
		args.keyboardType=keyboardType;
		args.format=format;
		args.callback = "keyboardCallback";
		$.gecko.invoke("scriptInvoker", "ShowKeyboard", args.callback, args);
    },
    updateFromUsb: function ()
    {
        windowExternalPluginInvoke("systemService", "UpdateFromUsbAsync", "");
    }
};

$.gecko =
{
    invoke: function (componentName, entryPoint, callback, args)
    {
        args.componentName = componentName;
        args.entryPoint = entryPoint;
        args.callback = callback;

        var event = new MessageEvent('callNetMethodEvent', {
            'view': window.top,
            'bubbles': false,
            'cancelable': false,
            'data': $.toJSON(args)
        });

        window.top.document.dispatchEvent(event);
    }
};

/*
result : Success = 0;Failure = 1;Busy = 2;Cancelled = 3;Timeout = 4;

// ------------记录用操作日志 $.pps.log(message)--------------//
// ---input----
message:string

// ---output---
{"result":0}

// ----code----
$.pps.log("用户点击了保存按钮");

// ------------设置操作系统音量 $.pps.setVolume(val)--------------
// ---input
val:int

// ---output
{"result":0}

// ---code
$.pps.setVolume(50);

// ------------获取系统设置默认值 $.pps.getSettings()--------------
// ---output
{
"result" : 0,
"settings":{
"openBank": "板桥区建设支行2",
"bankCode": "NB20023",
"province": "江苏4",
"city": "苏州5",
"volume": "25"
}
}
// ---code
var json = $.pps.getSettings();
var jo = $.parseJSON(json);
alert(jo.result);
alert(jo.settings.openBank);

// ------------保存系统设置默认值 $.pps.saveSettings(args)--------------
// ---input
{
"mask": {"message" : "正在保存，请稍候..."},
"sound": "d.wav;1:a.wav,2:b.wav,3:c.wav",
"callback" : "callback",
"settings":{
"openBank": "板桥区建设支行2",
"bankCode": "NB20023",
"province": "江苏4",
"city": "苏州5",
"volume": "25"
}
}

// ---output
{"result" : 0}

// ---code
var args = {};
var mask = {};
var settings = {};

// 遮罩层，提示信息，可选
mask.message = "正在保存，请稍候...";
args.mask = mask;

// 输入输出播放语言，可选
// ;前是输入语音文件名不加后缀，;后是输出语音，输出语音格式(返回值:语音文件,返回值:语音文件,...)，返回值参照result
args.sound = "a;0:b,1:c,2:d";

// 回调js函数，可选
args.callback = "callback";

// 可以赋值一个或多个
settings.openBank =  "板桥区建设支行8";
settings.bankCode =  "NB20028";
settings.province =  "江苏8";
settings.city =  "苏州8";
settings.volume = "28";
args.settings = settings;

var json = $.pps.saveSettings(args);
var jo = $.parseJSON(json);
alert(jo.result);

// ------------获取主题样式列表 $.pps.getStylesByPage(args)--------------
// ---input
{
"mask": {"message" : "正在查询，请稍候..."},
"sound": "d;1:a,2:b,3:c",
"callback" : "callback",
"query":{
"page": 1,
"rows": 10,
}
}

// ---output
{
"result" : 0,
"total" : 2,
"rows": [{
"styleId": 1,
"styleName": "标准版（蓝）",
"beginDate": "20150101",
"endDate": "20150105",
"checked": true,
"def": false
},
{
"styleId": 2,
"styleName": "标准版（红）",
"beginDate": "20150106",
"endDate": "20150107",
"checked": false,
"def": true
}]
}

// ---code
var args = {};
var mask = {};
var query = {};

// 遮罩层，提示信息，可选
mask.message = "正在查询，请稍候...";
args.mask = mask;

// 输入输出播放语言，可选
// ;前是输入语音文件名不加后缀，;后是输出语音，输出语音格式(返回值:语音文件,返回值:语音文件,...)，返回值参照result
args.sound = "a;0:b,1:c,2:d";

// 回调js函数，可选
args.callback = "callback";

// 分页查询条件，page当前页从1开发，rows每页多少行
query.page =  1;
query.rows =  10;
args.query = query;

var json = $.pps.getStylesByPage(args);
var jo = $.parseJSON(json);
alert(jo.result);
alert(jo.total);
alert(jo.rows);

// ------------保存设置主题样式 $.pps.saveStyles(args)--------------
// ---input
{
"mask": {"message" : "正在保存，请稍候..."},
"sound": "d;1:a,2:b,3:c",
"callback" : "callback",
"styles": [
{
"styleId": 1,
"styleName": "标准版（蓝）",
"beginDate": "20150101",
"endDate": "20150105",
"checked": true,
"def": false
},
{
"styleId": 2,
"styleName": "标准版（红）",
"beginDate": "20150106",
"endDate": "20150107",
"checked": false,
"def": true
}]
}
// ---output
{"result" : 0}

// ---code
var args = {};
var mask = {};
var styles = [];

// 遮罩层，提示信息，可选
mask.message = "正在查询，请稍候...";
args.mask = mask;

// 输入输出播放语言，可选
// ;前是输入语音文件名不加后缀，;后是输出语音，输出语音格式(返回值:语音文件,返回值:语音文件,...)，返回值参照result
args.sound = "a;0:b,1:c,2:d";

// 回调js函数，可选
args.callback = "callback";

// 获取页面主题信息，多个装载到数组当中
var item = {};
item.styleId = 1;
item.styleName = "标准版（蓝）";
item.beginDate = "20150101";
item.endDate = "20150105";
item.checked = true;
item.def = false;
styles.push(item);
styles.push(item1);
styles.push(item2);
args.styles = styles;

var json = $.pps.saveStyles(args);
var jo = $.parseJSON(json);
alert(jo.result);

// ------------获取系统配置信息 $.pps.getAppConfig()--------------
// ---output
{
"result":0,
"appConfig":{
orgCode = "10011001",
deviceNo =  "101010190",
webServerHost = "localhost",
webServerPort = 8080
}
}

// ---code
var json = $.pps.getAppConfig();
var jo = $.parseJSON(json);
alert(jo.orgCode);

// ------------保存系统配置信息 $.pps.saveAppConfig(args)--------------
// ---input
{
"mask": {"message" : "正在保存，请稍候..."},
"sound": "d;1:a,2:b,3:c",
"callback" : "callback",
"appConfig":{
orgCode = "10011001",
deviceNo =  "101010190",
webServerHost = "localhost",
webServerPort = 8080
}
}

// ---output
{"result":0}

// ---code
var json = $.pps.saveAppConfig(args);
var jo = $.parseJSON(json);
alert(jo.result);

// ------------获取单据打印配置信息 $.pps.getPrintConfig(args)--------------
// ---input
{"query" : {"busGroupCode":"personal", "busTypeCode":"withdraw"}}

// ---output
{
"family": "sans-serif",
"size": 24,
"dpi": 200,
"image": {"width":1877,"height":739},
"backImage":{"width":1827,"height":739},
"offset": {
"x": 1,
"y": 1
},
"items": [
{
"id": "receiptNo",
"text": "002AEX",
"x": 950,
"y": 80
},
{
"id": "accountNo",
"text": "002521466332",
"x": 300,
"y": 470
},
{
"id": "accountName",
"text": "张三",
"x": 720,
"y": 470
}]
}

// ---code
var json = $.pps.getPrintConfig(args);
var jo = $.parseJSON(json);

// ------------保存并打印配置信息 $.pps.saveAndPrintConfig(args)--------------
// ---input
{
"family": "sans-serif",
"size": 24,
"dpi": 200,
"image": {"width":1877,"height":739},
"backImage":{"width":1827,"height":739},
"offset": {
"x": 1,
"y": 1
},
"items": [
{
"id": "receiptNo",
"text": "002AEX",
"x": 950,
"y": 80
},
{
"id": "accountNo",
"text": "002521466332",
"x": 300,
"y": 470
},
{
"id": "accountName",
"text": "张三",
"x": 720,
"y": 470
}]
}

// ---output
{"result":0}

// ---code
var json = $.pps.saveAndPrintConfig(args);
var jo = $.parseJSON(json);

// ------------保存并打印单据信息 $.pps.saveAndPrintReceipt(args)--------------
// ---input
{
"mask": {"message" : "正在打印，请稍候..."},
"sound": "d.wav;0:d.wav;1:a.wav,2:b.wav,3:c.wav",
"callback" : "aaa",
"receipt":{
"busType":4,
"receiptType":4,
"certType":1,
"certNo":"420830198412211560",
"cardType":1,
"cardNo":"123456789012345678",
"content":"",
"queueNo":"Na0001",
"beginDate":"2015-01-01 12:30:34",
"endDate":"2015-01-01 12:32:12",
},
"customer":{
"customerName":"张三",
"certNo":"420830198412211560",
"certType":1,
"address":"南京雨花区板桥新村510",
"mailbox":"456@qq.com",
"phone":"18319821450",
"job":"教师",
"nationality":"中国"
},
"print" : {}
}

// ---output
{"result":0,"receiptNo":"MO0001"}

// ---code
var json = $.pps.saveAndPrintReceipt(args);
var jo = $.parseJSON(json);

// ------------获取最后填写的单据信息 $.pps.getLastReceipt(args)--------------
// ---input
{
"query":{
"receiptType":4,
"certType":1,
"certNo":"420830198412211560",
"cardType":1,
"cardNo":"123456789012345678"
}
}

// ---output
{
"result": 0,
"receipt":{
"busType":4,
"receiptType":4,
"certType":1,
"certNo":"420830198412211560",
"cardType":1,
"cardNo":"123456789012345678",
"content":"",
"queueNo":"Na0001",
"beginDate":"2015-01-01 12:30:34",
"endDate":"2015-01-01 12:32:12",
}
}

// ---code
var json = $.pps.getLastReceipt(args);
var jo = $.parseJSON(json);

// ------------获取客户信息 $.pps.getCustomer(args)--------------
// ---input
{
"query":{
"certType":1,
"certNo":"420830198412211560",
}
}

// ---output
{
"result": 0,
"customer":{
"customerName":"ddd",
"certType":1,
"certNo":"420830198412211560",
"address":"",
"mailbox":"123456789012345678",
"phone":"1232423434",
"job":"职员",
"nationality":"中国",
}
}

// ---code
var json = $.pps.getCustomer(args);
var jo = $.parseJSON(json);

// ------------播放声音 $.pps.playSound(wav)--------------
// ---input
wav:string

// ---code
$.pps.playSound("a.wav");

// ------------刷身份证 $.pps.swipeIDCard(args)--------------
// ---input
{
"mask": {"message" : "请刷身份证..."},
"sound": "d.wav;1:a.wav,4:c.wav",
"callback" : "aaa",
"objId": "certNo"
}

// ---output
{
"result": 0,
"objId": "certNo",
"certName":"ddd",
"gender":"男",
"nationality":"420830198412211560",
"birthday":"19881010",
"address":"南京市广州路",
"certNo":"420830198412211560",
"issuedBy":"南京市公安局",
"expDate":"20101231",
"certType":"中国"
}

// ---code
var json = $.pps.swipeIDCard(args);
var jo = $.parseJSON(json);

// ------------刷卡 $.pps.swipeCard(args)--------------
// type
// 001：磁条卡启用
// 010：IC卡启用
// 011：磁条卡、IC卡启用
// 100：吸卡器启用
// 101：吸卡器、磁条卡启用
// 110：IC卡启用、吸卡器启用
// 111：IC卡启用、吸卡器、磁条卡启用

// tag
//A： 帐号	19位
//B： 姓名
//C： 证件类型，值: 00：身份证 01：军官证 02：护照 03：入境证 04：临时身份证 05：其它
//D： 证件号码
//E： 二磁道信息（可选）	Ans
//F： 一磁道信息（可选）	Ans
//G： 余额	Ans,不带小数点
//H： 余额上限	Ans,不带小数点
//I： 应用失效日期
//J： IC卡序列号
// ---input
{
"mask": {"message" : "请刷银行卡..."},
"sound": "d.wav;0:d.wav;1:a.wav,2:b.wav,3:c.wav",
"callback" : "aaa",
"objId": "cardNo",
"type" : 1
"tag" : "A"
}

// ---output
{
"result": 0,
"objId": "certNo",
"serialNo" : "fewrwew",     // 序列号
"cardNo" = "3242345235435"  // 卡号
}

// ---code
var json = $.pps.swipeCard(args);
var jo = $.parseJSON(json);
*/
