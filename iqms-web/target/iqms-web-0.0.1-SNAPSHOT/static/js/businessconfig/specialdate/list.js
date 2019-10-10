	var params, bizTypeId, index, busType;
    var $rowNum = 0;
    var delRowidArr = [];
    var $tbody = $("#ccc tbody");
    var deviceNo = "";
    $(function ()
    {
        $("#frm").validate({
          onfocusout: function (element)
          {
            //alert(element.value);
            //setTimeout(function(){
            $(element).valid();
            //},300);
          },
          submitHandler: function (form)
          {
        	 save();
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
    	        content: '将清空所选下级机构的特殊日期配置，确定要应用吗?',
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
    	                	var url = contextPath + "/businessconfig/copyspecialdate?dt="+(new Date().getTime());
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
    
    function getSpecialDatesCallback(jo)
    {
      //alert($.toJSON(jo));		
      if (jo.result == 0)
      {
        $.each(jo.specialDates, function (index, item)
        {
          addTr(item);
        });
      }
      closeLoading();
    }

    function initPage()
    {
      delRowidArr = [];
      $tbody.empty().html("");
      $rowNum = 0;
      //获取特殊日期
      $.qms.getSpecialDates();
    }

    function save()
    {
      if (!checkData()) return;
      //遍列tbody tr
      var $trs = $("#ccc tbody tr");
      var joArr = [];
      var $tds = null;
      var jo;
      $.each(delRowidArr, function (index, item)
      {
        jo = {};
        jo.deviceNo = deviceNo;
        jo.saveStatus = "deleted";
        joArr.push(jo);
      });
      $.each($trs, function (index, item)
      {
        jo = {};
        $tds = $(item).find("td");
        jo.deviceNo = deviceNo;
        jo.specialDate = $tds.eq(1).find("input").eq(0).val()+","+$tds.eq(2).find("input").eq(0).val();
        var dateTypeId0 = $tds.eq(3).find("input").eq(0).prop("checked");
        var dateTypeId1 = $tds.eq(3).find("input").eq(1).prop("checked");
        jo.dateType = dateTypeId0 ? 1 : (dateTypeId1 ? 2 : 0);
        if ($(item).data("itemData") && $(item).data("itemData").spId)
        {
//          jo.spId = $(item).data("itemData").spId;
          jo.saveStatus = "updated";
        } else
        {
          jo.saveStatus = "inserted";
        }
        joArr.push(jo);
      });

      $.ajax({
    		url : contextPath + "/businessconfig/specialdate/saveSpecialDate?_method=delete&dt="
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
    	                 content: '特殊日期配置保存成功',
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
    	                 content: '特殊日期配置保存失败',
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

    function saveSpecialDatesCallback(joResult)
    {
      // alert($.toJSON(joResult));
      if (joResult.result == 0)
      {
        qmsVld.showInfo("保存成功");
        initPage();
      } else
      {
        qmsVld.showError("保存失败");
      }
    }

    function delTr(obj)
    {
      //window.event.stopPropagation();
      var $tr = $(obj).parent().parent();
      var itemData = $tr.data("itemData");
      if (itemData && itemData.specialDate)
      {
        delRowidArr.push(itemData.specialDate);
      }
      var $tbody = $tr.parent();
      $tr.remove();
      //重新计算序号
      var $trs = $tbody.find("tr");
      $.each($trs, function (index, item)
      {
        $(item).find("td").eq(0).text(index + 1);
      });
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
      var $tr;
      index++;
      var radioName = "dateTypeId" + index;
      if (itemData)
      {
        var checked1 = "";
        var checked2 = "";
        if (itemData.dateType == 1)
        {
          var checked1 = "checked";
          var checked2 = "";
        } else if (itemData.dateType == 2)
        {
          var checked1 = "";
          var checked2 = "checked";
        }


        $tr = $("<tr>" +
				"<td>" + $rowNum + "</td>" +
				"<td class=\"center\"><div class=\"controls\"><input  name='spDateBegin" + index + "' class=\"{required:true,dateISO:true} form-control datepicker\"  value = '" + itemData.specialDate.split(",")[0] + "' placeholder=\"请输入特殊日期,格式20151001\"></div></td>" +
				"<td class=\"center\"><div class=\"controls\"><input  name='spDateEnd" + index + "' class=\"{required:true,dateISO:true} form-control datepicker\"  value = '" + itemData.specialDate.split(",")[1] + "' placeholder=\"请输入特殊日期,格式20151001\"></div></td>" +
				"<td><div class=\"controls\"><input class = '{required:true}'  type=\"radio\" " + checked1 + " name=\"" + radioName + "\">平日&nbsp;&nbsp;&nbsp;&nbsp;  <input class = '{required:true}'  type=\"radio\" " + checked2 + " name=\"" + radioName + "\" >假日</div></td>" +
				"<td class=\"center\"><a class=\"btn btn-danger\" href=\"#\" onclick='delTr(this);'><i class=\"glyphicon glyphicon-trash icon-white\"></i>删除</a></td>" +
			"</tr>");
      } else
      {
    	  $tr = $("<tr>" +
  				"<td>" + $rowNum + "</td>" +
  				"<td class=\"center\"><div class=\"controls\"><input   name='spDateBegin" + index + "' class=\"{required:true,dateISO:true} form-control datepicker\"  placeholder=\"请输入特殊日期,格式20151001\"></div></td>" +
  				"<td class=\"center\"><div class=\"controls\"><input   name='spDateEnd" + index + "' class=\"{required:true,dateISO:true} form-control datepicker\"  placeholder=\"请输入特殊日期,格式20151001\"></div></td>" +
  				"<td><div class=\"controls\"><input  class = '{required:true}'    type=\"radio\" name=\"" + radioName + "\" >平日&nbsp;&nbsp;&nbsp;&nbsp;  <input class = '{required:true}' checked type=\"radio\"  name=\"" + radioName + "\" >假日</div></td>" +
  				"<td class=\"center\"><a class=\"btn btn-danger\" href=\"#\" onclick='delTr(this);'><i class=\"glyphicon glyphicon-trash icon-white\"></i>删除</a></td>" +
  			"</tr>");
      }

      $(".datepicker", $tr).datepicker({
          changeYear: true,
          changeMonth: true,
          showButtonPanel: true,
          dateFormat: "yymmdd",
          minDate: new Date(),
          onClose: function ()
          {
            //alert(this.name);
            //setTimeout(function(){
            $(".datepicker", $tr).valid();
            //},1000);
          }
        });
//      $("iframe .ui-datepicker-cover").hide();
      $tr.data("itemData", itemData);
      $("#tbody").append($tr);
    }

    //特殊日期组校验
    function checkData()
    {
      var $trs = $("#ccc tbody tr");
      var size = $trs.length;
      var spDate1, spDate2;
      for (var i = 0; i < size; i++)
      {
        spDate1 = $trs.eq(i).find("input").eq(0).val();
        for (var j = (i + 1); j < size; j++)
        {
          spDate2 = $trs.eq(j).find("input").eq(0).val();
          if (spDate1 == spDate2)
          {
            qmsVld.showError("第" + (i + 1) + "行与第" + (j + 1) + "行特殊日期重复,请重新输入", $trs.eq(i).find("input").eq(0).get(0));
            return false;
          }
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
    
    //执行查询方法
    function loadDatas() {
    	// 获取参数对象
    	orgId = jQuery("#searchFrom").find("input[name=orgId]").val();
    	deviceNo = jQuery("#searchFrom").find("input[name=deviceNo]").val();
    	$.ajax({
      		url : contextPath + "/businessconfig/specialdate?_method=get&dt="
      				+ (new Date().getTime()),
      		type : "GET",
      		data :{"orgId":orgId,"deviceNo":deviceNo},
      		contentType : "application/json; charset=utf-8",
      		dataType : "json",
      		success : function(result) {
      			var spDateList = result.rows;
      			 for(var i=0; i<spDateList.length; i++){
    				 addTr(spDateList[i]);
    			 }
      			abledButton();
      		}
      	});
    }