	var $rowNum = 0;
    var delRowidArr = [];
    $tbody = $("#ccc tbody");
    var joCustLevels = null;
    var custlist = null;
    var recognitionList = null;
    var orgId = "";
    var deviceNo = "";
    var delFlag = false;
    $(function ()
    {
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
      $("#addBtn").on("click", function ()
      {
        addTr();
      });
      setTimeout(initPage, 0);
      disabledButton();
    });
  //按钮不可使用
    function disabledButton()
    {
      $("#addBtn").attr('disabled', true);
      $("#CopyToOrg").attr('disabled', true);
      $("#saveConfig").attr('disabled', true);
    }
    
  //设置按钮可用
    function abledButton()
    {
      $("#addBtn").attr('disabled', false);
      $("#CopyToOrg").attr('disabled', false);
      $("#saveConfig").attr('disabled', false);
    }
    
    function orgDeviceTree(orgId){
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
                }
            };
    	//ajax请求加载数据
    	 $.ajax({
            url : contextPath + "/businessconfig/ztreeorgdevice?dt="+(new Date().getTime()),
            type : "get",
            dataType : "json",
            contentType : "application/json",
            data : {"orgId":orgId},
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
    //应用到下级机构
    function copyToOrg(){
    	if($("#orgDevicelist").val()!="" && $("#orgDevicelist").val()!=null){
    		var jc = $.confirm({
    	        title: '应用到下级机构',
    	        icon: 'fa fa-warning red',
    	        theme:'bootstrap',
    	        content: '将清空所选下级机构的客户识别配置，确定要应用吗?',
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
    	                	var data = {};
    	                	data.orgId = orgId;
    	                	data.deviceNo = deviceNo;
    	                	data.orgDevicelist = $("#orgDevicelist").val();
    	                	var url = contextPath + "/businessconfig/copycustrecognition?dt="+(new Date().getTime());
    		           	     $.post(url, data, function(result)
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
    		           	            $newDialog.dialog("close");//关闭窗口
    		           	         }
    		           	         else if(result.errorCode == '2'){
    		           	        	$.alert({
    		           	                 title: '提示信息',
    		           	                 icon:'fa fa-info-circle red',
    		           	                 theme:'bootstrap',
    		           	                 content: '请先保存配置',
    		           	                 closeIcon: true,
    		           	                 buttons:{
    		           	                 	 colseWin: {
    		           	                      	text: '<i class="ace-icon fa fa-times"></i>关闭',
    		           	                          btnClass: 'btn-info'
    		           	                      }
    		           	                 }
    		           	             });
    		           	         }else
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
    		qmsVld.showError("请先选择要应用的下级机构");
    	    return false;
    	}
    }
    
    function initPage()
    {
      delRowidArr = [];
      $rowNum = 0;
      $tbody.html("");
      getRecognitionType();
    }

    var index = 0;
    function addTr(itemData)
    {
      //取到最大序号+1
      if ($tbody.find("tr:last"))
      {
        var num = $tbody.find("tr:last").find("td").eq(0).text();
        if (num)
        {
          $rowNum = num;
        }
      }
      $rowNum++;
      index++;

      var $tr;
      var checked1 = "";
      var checked2 = "";
      if (itemData && itemData.dateType == 'N')//平日
      {
        checked1 = "checked";
        checked2 = "";
      } else if (itemData && itemData.dateType == 'H')//假日
      {
        checked1 = "";
        checked2 = "checked";
      } else if (itemData && itemData.dateType == 'A')//all
      {
        checked1 = "checked";
        checked2 = "checked";
      }

      if (itemData)
      {
        $tr = $("<tr>" +
				"<td>" + $rowNum + "</td>" +
				"<td><div class=\"controls\"><input validate='{required:true}' name='dateType" + index + "'  type=\"checkbox\" " + checked1 + " >平日&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input  name='dateType" + index + "'  type=\"checkbox\" " + checked2 + "  >假日</div></td>" +
				"<td><div class=\"controls\"><input  maxlength='3' digits='true' required='true'  validate='{required:true,digits:true,range:[1,99]}' name='startIndex" + index + "' class=\"form-control\" value = '" + itemData.startPosition + "' placeholder=\"请输入开始位\"></div></td>" +
				"<td><div class=\"controls\"><input  maxlength='3' digits='true' required='true'  validate='{required:true,digits:true,range:[1,8]}' name='len" + index + "'  class=\"form-control\" value = '" + itemData.mateLength + "' placeholder=\"请输入匹配长度\"></div></td>" +
				"<td><div class=\"controls\"><input  maxlength='32' zm_sz2='true' required='true'  validate='{required:true,num:true,maxlength:8}' name='matchingMin" + index + "' class=\"form-control\" value = '" + itemData.startMateCode + "' placeholder=\"请输入起始匹配码\"></div></td>" +
				"<td><div class=\"controls\"><input  maxlength='32' zm_sz2='true' required='true'  validate='{required:true,num:true,maxlength:8}' name='matchingMax" + index + "' class=\"form-control\" value = '" + itemData.endMateCode + "' placeholder=\"请输入结束匹配码\"></div></td>" +
				"<td><div class=\"controls\"><select validate='{required:true}' required='true' name='custLevel" + index + "' data-rel=\"chosen\" style=\"width: 80%;\" >" + init_select_CustLevel(custList, itemData.custLevel) + "</select></div></td>" +
				"<td class=\"center\"><a class=\"btn btn-danger\" href=\"#\" onclick='delTr(this);'><i class=\"glyphicon glyphicon-trash icon-white\"></i>删除</a></td>" +
			"</tr>");
      } else
      {
        $tr = $("<tr>" +
				"<td>" + $rowNum + "</td>" +
				"<td><div class=\"controls\"><input validate='{required:true}' checked name='dateType" + index + "'  type=\"checkbox\">平日&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input  name='dateType" + index + "' checked type=\"checkbox\">假日</div></td>" +
				"<td><div class=\"controls\"><input value='1'  maxlength='3' digits='true' required='true'  validate='{required:true,digits:true,range:[1,99]}' name='startIndex" + index + "' class=\"form-control\" placeholder=\"请输入开始位\"></div></td>" +
				"<td><div class=\"controls\"><input  maxlength='3' digits='true' required='true'  validate='{required:true,digits:true,range:[1,8]}' name='len" + index + "'  class=\"form-control\"  placeholder=\"请输入匹配长度\"></div></td>" +
				"<td><div class=\"controls\"><input  maxlength='32' zm_sz2='true' required='true' validate='{required:true,num:true,maxlength:8}' name='matchingMin" + index + "'  class=\"form-control\"  placeholder=\"请输入匹配最小值\"></div></td>" +
				"<td><div class=\"controls\"><input  maxlength='32' zm_sz2='true' required='true' validate='{required:true,num:true,maxlength:8}' name='matchingMax" + index + "'  class=\"form-control\"  placeholder=\"请输入匹配最大值\"></div></td>" +
				"<td><div class=\"controls\"><select validate='{required:true}' required='true' name='custLevel" + index + "' data-rel=\"chosen\" style=\"width: 80%;\" >" + init_select_CustLevel(custList) + "</select></div></td>" +
				"<td class=\"center\"><a class=\"btn btn-danger\" href=\"#\" onclick='delTr(this);'><i class=\"glyphicon glyphicon-trash icon-white\"></i>删除</a></td>" +
			"</tr>");
      }

      $("#tbody").append($tr);

    }

    function delTr(obj)
    {
      delFlag = true;
      var $tr = $(obj).parent().parent();
      var $tbody = $tr.parent();
      $tr.remove();
      if($rowNum>0){
    	  $rowNum--;
      }
      //重新计算序号
      var $trs = $tbody.find("tr");
      $.each($trs, function (index, item)
      {
        $(item).find("td").eq(0).text(index + 1);
      });
    }


    //保存
    function saveConfig()
    {
      if (!checkData()) return false;
      var joArr = [];
      //遍列tbody tr
      var $trs = $("#ccc tbody tr");
      var $tds = null;
      var jo = {};
      
      if(delFlag){
    	  jo = {};
    	  jo.orgId = orgId;
    	  jo.deviceNo = deviceNo;
    	  jo.saveStatus = "deleted";
    	  joArr.push(jo);
      }
      $.each($trs, function (index, item)
      {
    	jo = {};
        $tds = $(item).find("td");
        var radioValue0 = $tds.eq(1).find("input").eq(0).prop("checked");
        var radioValue1 = $tds.eq(1).find("input").eq(1).prop("checked");
        jo.dateType = "";
        if (radioValue0 && radioValue1)
        {
          jo.dateType = 'A';
        } else if (radioValue0 == false && radioValue1 == true)
        {
          jo.dateType= 'H';
        } else if (radioValue0 == true && radioValue1 == false)
        {
          jo.dateType = 'N';
        } else
        {
          jo.dateType = 0;
        }
        jo.startPosition = $tds.eq(2).find("input").eq(0).val();
        jo.mateLength = $tds.eq(3).find("input").eq(0).val();
        jo.startMateCode = $tds.eq(4).find("input").eq(0).val();
        jo.endMateCode = $tds.eq(5).find("input").eq(0).val();
        jo.custLevel = $tds.eq(6).find("select option:selected").val();
//        jo.recognitionType = $("#frm p").find("select option:selected").val();
        jo.rowId = $tds.eq(0).text();
        jo.orgId = orgId;
        jo.deviceNo = deviceNo;
        jo.saveStatus = "inserted";
        joArr.push(jo);
      });
      $.ajax({
  		url : contextPath + "/businessconfig/bsccustrecogni/saveCustRecogni?_method=delete&dt="
  				+ (new Date().getTime()),
  		type : "post",
  		data :$.toJSON(joArr),
  		dataType : "json",
  		contentType : "application/json",
  		success : function(result) {
  			if (result.errorCode == '0')
  	         {
  	        	//弹出对话框
  	         	$.alert({
  	                 title: '提示信息',
  	                 icon:'fa fa-info-circle blue',
  	                 theme:'bootstrap',
  	                 content: '客户识别配置保存成功',
  	                 closeIcon: true,
  	                 buttons:{
  	                 	 colseWin: {
  	                      	text: '<i class="ace-icon fa fa-times"></i>关闭',
  	                          btnClass: 'btn-info'
  	                      }
  	                 }
  	             });
  	         }
  	         else
  	         {
  	        	 $.alert({
  	                 title: '提示信息',
  	                 icon:'fa fa-info-circle red',
  	                 theme:'bootstrap',
  	                 content: '客户识别配置保存失败',
  	                 closeIcon: true,
  	                 buttons:{
  	                 	 colseWin: {
  	                      	text: '<i class="ace-icon fa fa-times"></i>关闭',
  	                          btnClass: 'btn-info'
  	                      }
  	                 }
  	             });
  	         }
  		}
  	});
    }


    //生成客户类型下拉框
    function getCustType(){
      	$.ajax({
      		url : contextPath + "/businessconfig/bsccustlevel?_method=get&dt="
      				+ (new Date().getTime()),
      		type : "GET",
      		data :{"orgId":orgId,"deviceNo":deviceNo},
      		contentType : "application/json; charset=utf-8",
      		dataType : "json",
      		success : function(result) {
      			custList = result.rows;
      			$.ajax({
    	    		url : contextPath + "/businessconfig/bsccustrecogni?dt="
    	    				+ (new Date().getTime()),
    	    		type : "get",
    	    		data :{"orgId":orgId,"deviceNo":deviceNo},
    	    		dataType : "json",
    	    		contentType : "application/json",
    	    		success : function(datas) {
    	    			 var list = datas.rows;
    	    			 for(var i=0; i<list.length; i++){
    	    				 addTr(list[i]);
    	    			 }
//    	    			 $("#recognition").children().remove();
//    	    			 init_select_Recognition(recognitionList,list[0].recognitionType);
    	    			 abledButton();
    	    		}
    	    	});
      		}
      	});
    }
    
    //生成识别模式下拉框
    function getRecognitionType(){
      	$.ajax({
      		url : contextPath + "/basicconfig/sysdic/recognitionType?_method=get&dt="
      				+ (new Date().getTime()),
      		type : "GET",
      		contentType : "application/json; charset=utf-8",
      		dataType : "json",
      		success : function(result) {
      			recognitionList = result.rows;
      			init_select_Recognition(recognitionList,'0');
      		}
      	});
    }
    
    function init_select_Recognition(initList,initValue)
    {
      var selectorsCustLevel = "<option value=\"\">请选择一项</option>";
      for (var i=0; i<initList.length; i++){
			map = initList[i]; 
			if(initValue == map["key"]){
			   selectorsCustLevel += "<option selected value=" + initValue + ">" + map["value"] + "</option>";
			}else{
			   selectorsCustLevel += "<option value=" + map["key"] + ">" + map["value"] + "</option>";
			}
		}
      $("#recognition").append(selectorsCustLevel);
    }
    
    function init_select_CustLevel(initList,initValue)
    {
      var selectorsCustLevel = "<option value=\"\">请选择一项</option>";
      for (var i=0; i<initList.length; i++){
			map = initList[i]; 
			if(initValue == map["custLevel"]){
			   selectorsCustLevel += "<option selected value=" + initValue + ">" + map["levelName"] + "</option>";
			}else{
			   selectorsCustLevel += "<option value=" + map["custLevel"] + ">" + map["levelName"] + "</option>";
			}
		}
      	return selectorsCustLevel;
    }

    function checkData()
    {
      var $trs = $("#ccc tbody tr");
      var size = $trs.length;
      var matchingMin, matchingMax, len,custType,recognitionType;
      for (var i = 0; i < size; i++)
      {
    	dateType1 = $trs.eq(i).find("input").eq(0).prop("checked")?"1":"0";
    	dateType2 = $trs.eq(i).find("input").eq(1).prop("checked")?"1":"0";
        len = $trs.eq(i).find("input").eq(3).val();
        matchingMin = $trs.eq(i).find("input").eq(4).val();
        matchingMax = $trs.eq(i).find("input").eq(5).val();
        custType = $trs.eq(i).find("select option:selected").eq(0).val();
        recognitionType = $("#frm p").find("select option:selected").eq(1).val();
        if(dateType1=='0' && dateType2=='0'){
        	qmsVld.showError("请选择日期类型");
        	return false;
        }
        if(custType == ""){
        	qmsVld.showError("请选择客户等级");
            return false;
        }
        if(recognitionType == ""){
        	qmsVld.showError("请选择识别模式");
            return false;
        }
        if (matchingMin.length != len)
        {
          qmsVld.showError("第" + (i + 1) + "行开始匹配码长度必须等于匹配长度,请重新输入", $trs.eq(i).find("input").eq(4).get(0));
          return false;
        }

        if (matchingMax.length != len)
        {
          qmsVld.showError("第" + (i + 1) + "行结束匹配码长度必须等于匹配长度,请重新输入", $trs.eq(i).find("input").eq(5).get(0));
          return false;
        }

        if (matchingMin > matchingMax)
        {
          qmsVld.showError("第" + (i + 1) + "行结束匹配码必须大于等于起始匹配码,请重新输入", $trs.eq(i).find("input").eq(4).get(0));
          return false;
        }
      }
      return true;
    }	
    
  //查询
    function searchCondition() {
    	 $rowNum = 0;
    	 $("#ccc").children().eq(1).find("tr").remove();
    	 loadDatas();
    }
    
 // //执行查询方法
    function loadDatas() {
    	// 获取参数对象
    	orgId = jQuery("#searchFrom").find("input[name=orgId]").val();
    	deviceNo = jQuery("#searchFrom").find("input[name=deviceNo]").val();
    	getCustType();
    }