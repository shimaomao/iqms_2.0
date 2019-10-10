var orgId = "";
var deviceNo = "";
var params;
var orgName = "";
var devName = "";
$(function (){
	  params = $.string(decodeURI(window.location.href)).toQueryParams();
	  orgName = params["orgName"];
	  devName = params["devName"];
	  $counterList = $("#counterList");//左边的窗口列表
      $checkbox1 = $("#checkbox1");//平时的复选框
      $checkbox2 = $("#checkbox2");//假日的复选框
      $checkboxModal = $("#checkboxModal");//打开的模态框中的复选框
      $myWinNum = $('#myWinNum');//窗口信息中用于显示的复选框
      $myModal = $("#myModal");//打开的模态框
      
      $.metadata.setType("attr", "validate");
      $("#frm").validate({
        onfocusout: function (element)
        {
          $(element).valid();
        },
        submitHandler: function (form)
        {
          saveConfig();
          return false;
        }
      });

      $("#frmModal").validate({
        onfocusout: function (element)
        {
          $(element).valid();
        },
        submitHandler: function (form)
        {
          modelSubmit();
          return false;
        }
      });
      
      //表格标题处的复选框是全选
      $checkbox1.on("click", function ()
      {
        checkAll(this);
      });

      $checkbox2.on("click", function ()
      {
        checkAll(this);
      });

      $checkboxModal.on("click", function ()
      {
        checkAll(this);
      });

      //表格内容中的复选框是单选
      $("input[name='checkbox1']").on("click", function ()
      {
        checkChild(this);
      });

      $("input[name='checkbox2']").on("click", function ()
      {
        checkChild(this);
      });

      $("input[name='checkboxModal']").on("click", function ()
      {
        checkChild(this);
      });

     //窗口信息中用于显示的复选框
      $myWinNum.on("change", function (){
        if ($myWinNum.val()){
          qmsVld.removeErrorCss($myWinNum.get(0));
          $myWinNum.parent().attr("data-content", "");
          $myWinNum.parent().popover('hide');
        }
      });
      
      //初始化页面
      //setTimeout(initPage, 0);
      searchCondition();
      
});
	
    //1、查询窗口列表数据
	function initPage(){
		var arg ={};
		arg.orgId = orgId ;
		arg.deviceNo = deviceNo ;
		
		$.ajax({
	   		 url: contextPath+"/businessconfig/callstrategy/selectWinConfig?dt="+(new Date().getTime()), 
	   		 type : "post",
	   		 dataType: "json",
	   		 data :$.toJSON(arg),
	   		 contentType: "application/json",
	   		 success: function(data) {
	   			//alert($.toJSON(data))
	   			getCounters(data);
	   		 },
	   		 error: function(msg) {
	   			alert("出错了！");
	   		 } 
	    })
	}

	//查询
    function searchCondition(){
    	 orgId = $("#orgId").val();
    	 deviceNo = $("#deviceNo").val();
    	 if(orgId=="" || deviceNo==""){
    		 qmsVld.showInfo("请先选择一个机构设备！!");
    	 }else{
    		 initPage();
    	 }
    	 
    }
    
	//全选
    function checkAll(obj){
      if ($(obj).prop("checked") == true)
      { 
        $("input[name='" + obj.id + "']").each(function ()
        {
          $(this).prop("checked", true);
        });
      } else
      {
        $("input[name='" + obj.id + "']").each(function ()
        {
          $(this).prop("checked", false);
        });
      }
    }
    
    //单选
    function checkChild(obj){
      if ($(obj).prop("checked") == true)
      { 
        var flag = true;
        $("input[name='" + obj.name + "']").each(function ()
        {
          if (!$(this).prop("checked"))
          {
            flag = false;
            return false;
          }
        });
        if (flag) $("#" + obj.name).prop("checked", true);
      } else
      {
        var flag = false;
        $("input[name='" + obj.name + "']").each(function ()
        {
          if ($(this).prop("checked"))
          {
            flag = true;
            return false;
          }
        });
        if (!flag) $("#" + obj.name).prop("checked", false);
      }
    }

    //--------------------------------------------------------左边初始化 start------------------------------------------------------------------------------------------------------
    
    /**
     * 1、初始化左侧窗口列表
     * 2、初始化右侧窗口下拉框
     */
    function getCounters(rlt){
      var selectorsTemp = init_select(rlt.counters);//获取右边窗口信息中的复选框数据
      //alert(selectorsTemp)
      $myWinNum.empty().html(selectorsTemp);//初始化样式

      $myWinNum.val(1);//默认第一个
      $myWinNum.multiselect({
        includeSelectAllOption: true,
        enableFiltering: true,
        numberDisplayed: 10,
        maxHeight: 500,
        nonSelectedText: '请选择窗口',
        allSelectedText: '全部窗口',
        selectAllText: '全部窗口',
        nSelectedText: '个窗口被选中'
      });
      
      //显示左边窗口号页面
      $counterList.html("");
      var firstli, $li;
      $.each(rlt.counters, function (index, item)
      {
        $li = $("<li id='" + item.winId + "' onclick='initRightData(this);'><a href='javascript:void(0);'><i class='glyphicon glyphicon-home'></i><span>" + item.winNo + "号窗口</span></a></li>");
        $li.appendTo($counterList);
        if (index == 0){
          firstli = $li.get(0);
        }
      });
      //----------------------------------------------------左边初始化 end--------------------------------------------

      //----------------------------------------------------右边初始化 start--------------------------------------------
      if (firstli){
    	  initRightData(firstli);
      }
      //----------------------------------------------------右边初始化 end--------------------------------------------

    }
    
    /**
     * 初始化右边页面
     * 方法一 :1 查询出业务 (初始化tr)   2 查询出保存过的业务   3 根据业务查等级 (初始化tr) 4 给等级赋值
     * 方法二 :1 查询出业务及等级的笛卡尔乘积     2 根据业务等级表  给1的结果赋值 3 初始化tr
     * 方法三 :1 查询出业务 (初始化tr)
     */
    function initRightData(obj){
      
      //改变左侧窗口按钮列表按扭状态
      $('#counterList li.active').removeClass('active');
      //修改左侧按钮列表参数对象的按钮为active激活样式
      $(obj).addClass("active");

      //设置右侧窗口下拉框的值
      $myWinNum.val(obj.id);
      //刷新窗口下拉框
      $myWinNum.multiselect('refresh');
      
      //给平日list添加数据：窗口号
      $("#prList").data("counterId", obj.id);
      
      //清空平日假日列表
      $("#prList tbody").empty().html("");
      $("#jrList tbody").empty().html("");
      
      var arg2 ={};
	  arg2.orgId = orgId ;
	  arg2.deviceNo = deviceNo ;
	  
      //2、查询此网点的业务
      $.ajax({
	   		 url: contextPath+"/businessconfig/callstrategy/selectBuzType?dt="+(new Date().getTime()), 
	   		 type : "post",
	   		 dataType: "json",
	   		 data : $.toJSON(arg2),
	   		 contentType: "application/json",
	   		 success: function(data) {
	   			//alert($.toJSON(data))
	   			getLeafBuzTypes(data);//初始化页面数据
	   		 },
	   		 error: function(msg) {
	   			alert("出错了！");
	   		 } 
	    })
    }

    //result1:网点所有业务    result2网点业务+客户等级的笛卡尔积
    var result1, result2;
    
    /**
     * 1、查询窗口的业务配置信息
     * @param rlt  网点的所有业务
     */
    function getLeafBuzTypes(rlt){
      result1 = rlt;
      var arg3 ={};
	  arg3.orgId = orgId ;
	  arg3.deviceNo = deviceNo ;
	  
      //查询业务类型与客户等级的笛卡尔乘积（查询启用的业务和启用的窗口的笛卡尔积，查询出的结果：每个业务都有所有启用的等级。）
      $.ajax({
	   		 url: contextPath+"/businessconfig/callstrategy/selectCounterBuz?dt="+(new Date().getTime()), 
	   		 type : "post",
	   		 dataType: "json",
	   		 data:$.toJSON(arg3),
	   		 contentType: "application/json",
	   		 success: function(data) {
	   			//alert($.toJSON(data))
	   			getMrCounterBuzs(data);;//初始化页面数据
	   		 },
	   		 error: function(msg) {
	   			alert("出错了！");
	   		 } 
	    })
    }

    /**
     * 
     * @param rlt  网点业务和所有启用的等级的笛卡尔积
     */
    function getMrCounterBuzs(rlt){
      result2 = rlt;
      var args = {};
      args.winId = $("#prList").data("counterId");//根据不同窗口查询窗口数据
      
      var arg4 ={};
	  arg4.orgId = orgId ;
	  arg4.deviceNo = deviceNo ;
	  arg4.winId = args.winId;
	  
      //窗口业务配置信息（查询出窗口能够办理的业务及等级）
      $.ajax({
	   		 url: contextPath+"/businessconfig/callstrategy/selectCounterBuzsByWinId?dt="+(new Date().getTime()), 
	   		 type : "post",
	   		 dataType: "json",
	   		 contentType: "application/json",
	   		 data:$.toJSON(arg4),
	   		 success: function(data) {
	   			//alert($.toJSON(data))
	   			getCounterBuzsByWinId(data);;//初始化页面数据
	   		 },
	   		 error: function(msg) {
	   			alert("出错了！");
	   		 } 
	    })
    }

    //注意：rlt2是窗口策略的配置的表中获取到的值，result2是网点所有业务+开通的等级数据
    /**
     * 参数rlt2：窗口能够办理的业务及能够办理的等级，优先时间情况
     */
    function getCounterBuzsByWinId(rlt2){
    	
      //平日和节日数据
      var prItemData, jrItemData;
      var prIsNoCheck = true;
      var prItemDataArr = $.extend(true, [], result2.counterBuzs); //深度拷贝，将result2.counterBuzs和[]合并变为一个数组
      var jrIsNoCheck = true;
      var jrItemDataArr = $.extend(true, [], result2.counterBuzs);
      //平日数据初始化  （使用窗口配置的数据去修改，网点业务+等级的笛卡尔积数据）
      $.each(prItemDataArr, function (index1, item1)//笛卡尔乘积的值（所有的业务+等级信息）
      {
        $.each(rlt2.counterBuzs, function (index2, item2)//窗口策略信息
        {
          //如果等级相同，业务id也相同，且窗口策略配置的日期类型是平日，那么久将窗口策略配置的数据复制给（业务+等级），同时设置他的等级是被勾选的状态
          if (item1.custLevel == item2.custLevel && item1.busId == item2.busId && item2.dateTypeId == 1)
          {
            item1.buzPriorityTime = item2.buzPriorityTime; //业务优先时间
            item1.custPriorityTime = item2.custPriorityTime; //等级优先时间
            item1.maxWaitTime = item2.maxWaitTime;   //最大等待时间
            item1.saveDjStatus = true;  //客户等级的选中状态
          }
        });
      });
      
      //这一步完成后，查询出的（业务+等级的里面的信息就有了，真实的窗口配置里面的业务优先时间，等级优先时间，这个等级是否被选中了，这个业务最大等待时间）；
      
      
      //假日数据初始化 
      $.each(jrItemDataArr, function (index1, item1)
      {
        $.each(rlt2.counterBuzs, function (index2, item2)
        {
          //假日	
          if (item1.custLevel == item2.custLevel && item1.busId == item2.busId && item2.dateTypeId == 2)
          {
            item1.buzPriorityTime = item2.buzPriorityTime;
            item1.custPriorityTime = item2.custPriorityTime;
            item1.maxWaitTime = item2.maxWaitTime;
            item1.saveDjStatus = true;
          }
        });
      });

      //处理平日数据
      var prItemDataArrEnd = [];  //平日最终生成行的数据
      //遍历网点业务配置的数据
      $.each(result1.buzTypes, function (index1, item1)
      {
        prItemData = {};  //一个业务的信息：是否被开通，他的优先信息，他的相关的等级信息
        prItemData.custLevelArr = [];  //业务对应的等级信息
        //遍历修改后的（业务+等级的数据）
        $.each(prItemDataArr, function (index2, item2)
        {
          if (item1.busId == item2.busId)
          {
            prItemData.custLevelArr.push(item2);
          }
        });
        
        //设置窗口的业务是否被开通（如果这个业务里面有等级被勾选，那么这个业务就是勾选状态）
        $.each(prItemData.custLevelArr, function (index2, item2)
        {
          if (item2.saveDjStatus == true)
          {
            prItemData.saveBuzStatus = true;
            return false;
          }
        });
        prItemDataArrEnd.push(prItemData); //将业务信息保存起来prItemData这里面的数据就是saveBuzStatus，和custLevelArr（业务+等级（笛卡尔积））
      });

      //假日数据分组
      var jrItemDataArrEnd = [];
      $.each(result1.buzTypes, function (index1, item1)
      {
        jrItemData = {};
        jrItemData.custLevelArr = [];

        $.each(jrItemDataArr, function (index2, item2)
        {
          if (item1.busId == item2.busId)
          {
            jrItemData.custLevelArr.push(item2);
          }
        });
        $.each(jrItemData.custLevelArr, function (index2, item2)
        {
          if (item2.saveDjStatus == true)
          {
            jrItemData.saveBuzStatus = true;
            return false;
          }
        });
        jrItemDataArrEnd.push(jrItemData);
      });
      
      //添加平日数据列表
      $.each(prItemDataArrEnd, function (index, item)
      {
    	//如果没有客户等级被选中，就默认所有的等级被选中，免去客户点击设置等级后，还要手工勾选所有的客户等级。
        if (isNoCheck(item.custLevelArr))
        {

          $.each(item.custLevelArr, function (index1, item1)
          {
            item1.saveDjStatus = true;
          });
        }
        addTr("#prList tbody", item, "pr");//添加平日列表数据
      });
      
      //添加假日数据列表
      $.each(jrItemDataArrEnd, function (index, item)
      {
        if (isNoCheck(item.custLevelArr))
        {
          $.each(item.custLevelArr, function (index1, item1)
          {
            item1.saveDjStatus = true;
          });
        }
        addTr("#jrList tbody", item, "jr");//假日数据显示
      });

      //维护全选 checkbox状态
      changeCheckAll("#prList");
      changeCheckAll("#jrList");
      
    }
    
    //单选select html初始化
    function chose_ini(select, jsonObj, iniValue)
    {
      $.each(jsonObj, function (index, item)
      {
        $(select).append("<option value='" + item.key + "'  style='font-family:SimHei;'>" + item.value + "</option>");
      });
      if (iniValue) $(select).val(iniValue);
      $(select).trigger("chosen:updated");
    }


    //获取右边窗口信息中的复选框数据
    function init_select(jo, initValue)
    {
      counterIdArr = [];
      var selectorsTemp = "";
      $.each(jo, function (index, item)
      {
        counterIdArr.push(item.winId);
        if (initValue == item.winId)
        {
          selectorsTemp += "<option selected value=" + item.winId + ">" + item.winNo + "号窗口</option>";
        } else
        {
          selectorsTemp += "<option value=" + item.winId + ">" + item.winNo + "号窗口</option>";
        }
      });
      return selectorsTemp;
    }
    
    function chose_mult_ini(select, jsonObj, iniValues){
    }

    //单选select 值初始化
    function chose_set_ini(select, value)
    {
      $(select).val(value);
      $(select).trigger("chosen:updated");
    }

    //多选select 数据初始化
    function chose_mult_set_ini(select, values)
    {
      var arr = values.split(',');
      var length = arr.length;
      var value = '';
      for (i = 0; i < length; i++)
      {
        value = arr[i];
        $(select + " [value='" + value + "']").attr('selected', 'selected');
      }
      $(select).trigger("chosen:updated");
    }

    //设置初始状态
    function changeCheckAll(select)
    {
      var $trs = $(select).find("tbody tr");
      var checkAllflag = true;
      $.each($trs, function (index, item)
      {
        if (!$(item).find("input").eq(0).prop("checked"))
        {
          checkAllflag = false;
        }
      });
      $(select).find("thead input").eq(0).prop("checked", checkAllflag);
    }

    /**
     * 判断客户等级的数据里面是否有勾选，如果没有勾选，就返回true，
     * 如果有勾选就返回false
     * @param itemData
     * @returns {Boolean}
     */
    function isNoCheck(itemData)
    {
      var flag = true;
      $.each(itemData, function (index, item)
      {
        if (item.saveDjStatus == true)
        {
          flag = false;
          return false;
        }
      });
      return flag;
    }

    /**
     * 生成表格
     * @param select  生成行的table的id
     * @param itemData   生成行的数据 prItemDataArrEnd里面的数据
     * @param type  平日，还是假日
     */
    function addTr(select, itemData, type)
    {
      var rowNum = $(select).find("tr").length + 1;
      var $tr;
      if (itemData)
      {
        $tr = $("<tr>" +
				"<td><input onclick='clearError(this);'  name='" + (type == "pr" ? "checkbox1" : "checkbox2") + "' type = 'checkbox' " + (itemData.saveBuzStatus ? "checked" : "") + "></td>" +
				"<td>" + itemData.custLevelArr[0].businessCode + "</td>" +
				"<td>" + itemData.custLevelArr[0].businessName + "</td>" +
				"<td class='center'><input  maxlength='3'   validate='{required:true,digits:true,range:[0,999]}' name='buzPriorityTime" + type + rowNum + "' value=" + (itemData.custLevelArr[0].buzPriorityTime==null?0:itemData.custLevelArr[0].buzPriorityTime) + " class='form-control' placeholder='请输入优先时间'></td>" +
				"<td class='center'><a class='btn btn-info' href='#' onclick='custLevelSetting(this,\"" + type + "\");'><i class='glyphicon glyphicon-edit icon-white'></i>等级设置</a></td>" +
			"</tr>");
      }
      //将这一行数据添加到这一行
      $tr.data("itemData", itemData);
      $tr.appendTo($(select));
    }

    //添加查询出来的客户等级数据到表格中去
    function addDjTr(select, itemData)
    {
      var $tr;
      var rowNum = $(select).find("tr").length + 1;
      if (itemData)
      {
        $tr = $("<tr>" +
				"<td><input name='checkboxModal' type = 'checkbox' " + (itemData.saveDjStatus ? "checked" : "") + "></td>" +
				"<td>" + itemData.custLevel + "</td>" +
				"<td>" + itemData.LEVEL_NAME + "</td>" +
				"<td class='center'><input  maxlength='3'  validate='{required:true,digits:true,range:[0,999]}' name='custPriorityTime" + rowNum + "' value=" + itemData.custPriorityTime + " class='form-control' placeholder='请输入优先时间'></td>" +
				"<td class='center'><input  maxlength='3'  validate='{required:true,digits:true,range:[0,999]}' name='maxWaitTime" + rowNum + "' value=" + itemData.maxWaitTime + " class='form-control' placeholder='请输入最大等待时间'></td>" +
			"</tr>");
      }
      $tr.data("itemData", itemData);
      $tr.appendTo($(select));
    }

    function clearError(obj)
    {
      qmsVld.hideError(obj);
    }

    /**
     * 点击下一步 进入取号界面
     */
    function nextStep(){
    	//跳转到取号界面
     	window.location.href = encodeURI(contextPath + "/businessconfig/navconfig/queueface?dt="+(new Date().getTime())
     	+"&deviceNo="+$("#deviceNo").val()+"&orgId="+$("#orgId").val()+"&devName="+devName
     	+"&orgName="+orgName);
    }
    
    /**
     * 返回上一步 进入客户识别
     * @param orgId
     */
    function back(){
    	//跳转到快速应用
     	window.location.href = encodeURI(contextPath + "/businessconfig/navconfig/recognition?dt="+(new Date().getTime())
     	+"&deviceNo="+$("#deviceNo").val()+"&orgId="+$("#orgId").val()+"&devName="+devName
     	+"&orgName="+orgName);
    }
    
    /**
     * 点击向导栏图标跳转到指定页面
     * @param e
     */
    function redirect(e){
    	if(e.getAttribute("data-step")=='1'){
    		//跳转到创建设备
    	 	window.location.href = encodeURI(contextPath + "/businessconfig/navconfig/backdevice?dt="+(new Date().getTime())
    	 	+"&deviceNo="+$("#deviceNo").val()+"&devName="+devName);
    	}else if(e.getAttribute("data-step")=='2'){
    		//跳转到快速应用
         	window.location.href = encodeURI(contextPath + "/businessconfig/navconfig/copyToOrg?dt="+(new Date().getTime())
         	+"&deviceNo="+$("#deviceNo").val()+"&orgId="+$("#orgId").val()+"&devName="+devName
         	+"&orgName="+orgName);
    	}else if(e.getAttribute("data-step")=='3'){
    		//跳转到窗口配置
    	 	window.location.href = encodeURI(contextPath + "/businessconfig/navconfig/winconfig?dt="+(new Date().getTime())
    	 	+"&deviceNo="+$("#deviceNo").val()+"&orgId="+$("#orgId").val()+"&devName="+devName
         	+"&orgName="+orgName);
    	}else if(e.getAttribute("data-step")=='4'){
    		//跳转到网点业务
    	 	window.location.href = encodeURI(contextPath + "/businessconfig/navconfig/branchbus?dt="+(new Date().getTime())
    	 	+"&deviceNo="+$("#deviceNo").val()+"&orgId="+$("#orgId").val()+"&devName="+devName
         	+"&orgName="+orgName);
    	}else if(e.getAttribute("data-step")=='5'){
    		window.location.href = encodeURI(contextPath + "/businessconfig/navconfig/showtime?dt="+(new Date().getTime())
    		+"&deviceNo="+$("#deviceNo").val()+"&orgId="+$("#orgId").val()+"&devName="+devName
         	+"&orgName="+orgName);
    	}else if(e.getAttribute("data-step")=='6'){
    		window.location.href = encodeURI(contextPath + "/businessconfig/navconfig/ticketform?dt="+(new Date().getTime())
    		+"&deviceNo="+$("#deviceNo").val()+"&orgId="+$("#orgId").val()+"&devName="+devName
         	+"&orgName="+orgName);
    	}else if(e.getAttribute("data-step")=='7'){
    		window.location.href = encodeURI(contextPath + "/businessconfig/navconfig/custlevel?dt="+(new Date().getTime())
    		+"&deviceNo="+$("#deviceNo").val()+"&orgId="+$("#orgId").val()+"&devName="+devName
         	+"&orgName="+orgName);
    	}else if(e.getAttribute("data-step")=='8'){
    		window.location.href = encodeURI(contextPath + "/businessconfig/navconfig/recognition?dt="+(new Date().getTime())
    		+"&deviceNo="+$("#deviceNo").val()+"&orgId="+$("#orgId").val()+"&devName="+devName
         	+"&orgName="+orgName);
    	}
    }
    
    
    //保存配置存入数据库
    function saveConfig()
    {
      //窗口号
      var counterId = $("#prList").data("counterId");
      var counterIdArr = ($myWinNum.val() + '').split(",");
      //平日列表 
      var joArr = [];
      //遍列tbody tr
      var $trs = $("#prList tbody tr");
      var jo;
      var $inputs, saveBuzStatus, buzPriorityTime, saveDjStatus;
      var errorList = [];
      var errorItem;
      var itemTmp;
      $.each($trs, function (index, item)
      {
        jo = $(item).data("itemData");
        $inputs = $(item).find("input");
        saveBuzStatus = $inputs.eq(0).prop("checked");
        buzPriorityTime = $inputs.eq(1).val();

        if (saveBuzStatus)
        {
          var flag = false;
          $.each(jo.custLevelArr, function (index2, item2)
          {
            if (item2.saveDjStatus)
            {
              for (var i = 0; i < counterIdArr.length; i++)
              {
                itemTmp = $.extend(true, {}, item2);
                itemTmp.buzPriorityTime = buzPriorityTime;
                itemTmp.counterId = counterIdArr[i];
                itemTmp.dateTypeId = 1;
                joArr.push(itemTmp);
              }
              flag = true;
            }
          });

          //到少选择一个等级
          if (!flag)
          {
            errorItem = {};
            errorItem.message = "到少选择一个等级";
            errorItem.element = $(item).find("a").get(0);
            errorList.push(errorItem);
          }
        } else
        {
          var flag = false;
          $.each(jo.custLevelArr, function (index2, item2)
          {
            if (item2.saveDjStatus)
            {
              flag = true;
            }
          });
        }
      });
      //假日列表 
      $trs = $("#jrList tbody tr");
      $.each($trs, function (index, item)
      {
        jo = $(item).data("itemData");
        $inputs = $(item).find("input");
        saveBuzStatus = $inputs.eq(0).prop("checked");
        buzPriorityTime = $inputs.eq(1).val();
        if (saveBuzStatus)
        {
          var flag = false;
          $.each(jo.custLevelArr, function (index2, item2)
          {
            if (item2.saveDjStatus)
            {
              for (var i = 0; i < counterIdArr.length; i++)
              {
                itemTmp = $.extend(true, {}, item2);
                itemTmp.buzPriorityTime = buzPriorityTime;
                itemTmp.counterId = counterIdArr[i];
                itemTmp.dateTypeId = 2;
                joArr.push(itemTmp);
              }
              flag = true;
            }
          });

          //到少选择一个等级
          if (!flag)
          {
            errorItem = {};
            errorItem.message = "到少选择一个等级";
            errorItem.element = $(item).find("a").get(0);
            errorList.push(errorItem);
          }
        } else
        {
          var flag = false;
          $.each(jo.custLevelArr, function (index2, item2)
          {
            if (item2.saveDjStatus)
            {
              flag = true;
            }
          });
        }
      });
      if (errorList.length > 0)
      {
        showMyErrors(errorList);
        return;
      }
      var args = {};
      args.counterId = counterIdArr;
      args.counterBuzs = joArr;
      args.orgId = orgId;
      args.deviceNo = deviceNo;
      //alert($.toJSON(args));
      saveCounterBuzs(args,counterId);
    }

    //保存成功后触发
    function saveCounterBuzs(args,counterId){
    	//alert($.toJSON(args))
    	 //查询窗口业务统计
        $.ajax({
  	   		 url: contextPath+"/businessconfig/callstrategy?ftype=saveCounterBuzs", 
  	   		 type : "post", //数组传递参数时使用post，这样映射到后台时就不会出现特殊字符的问题
  	   		 dataType: "json",
  	   		 contentType: "application/json",
  	   		 data:$.toJSON(args), //json对象转json字符串传输
  	   		 success: function(data) {
  	   			//alert($.toJSON(data))
	   	   		 if (data.errorCode == 0){
	   	   			 qmsVld.showInfo("保存成功!");
	   	   			 $("#" + counterId).click();
	   	   		 }else{
	   	   			 qmsVld.showInfo("保存失败!");
	   	   		 }
  	   		 },
  	   		 error: function(msg) {
  	   			alert("出错了！");
  	   		 } 
        })
    }

    function showMyErrors(errorList)
    {
      $.each(errorList, function (i, v)
      {
        $(v.element).attr("data-content", v.message);
        $(v.element).popover({ trigger: "manual" });
        $(v.element).popover('show');
      })
    }

    //显示模态框
    function showModal(itemData, type)
    {
      $("#djList tbody").empty().html("");
      $.each(itemData.custLevelArr, function (index, item)
      {
        addDjTr("#djList tbody", item);//将等级数据加载到表格中
      });
      $("#modalTitle").text((type == "pr" ? "平日" : "假日") + " " + itemData.custLevelArr[0].businessName + " 等级设置");
      changeCheckAll("#djList");//全选按钮的状态
      $myModal.modal('show');
    }

    //等级设置按钮
    function custLevelSetting(obj, type)
    {
      $tr = $(obj).parent().parent();
      $("#djList").data("trEl", $tr);
      showModal($tr.data("itemData"), type);

      clearError(obj);
    }

    //等级设置确定保存提交
    function modelSubmit()
    {
      var $inputs, itemData;
      var $tr = $("#djList").data("trEl");

      var custLevelArr = [];
      $.each($("#djList tbody").find("tr"), function (index, item)
      {
        itemData = $(item).data("itemData");
        $inputs = $(item).find("input");
        itemData.saveDjStatus = $inputs.eq(0).prop("checked");
        itemData.custPriorityTime = $inputs.eq(1).val();
        itemData.maxWaitTime = $inputs.eq(2).val();
        custLevelArr.push(itemData);
      });
      $tr.data("itemData").custLevelArr = custLevelArr;//将填写的数据保存到对象中
      //alert($.toJSON(itemData))
      $('#myModal').modal('hide');
    }

    