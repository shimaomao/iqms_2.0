
var $dlgImportCusInfo;
var $dlgImportErrCusInfo;
var $dgImportErrlist;

/**
 * 初始化对话框页面
 */
$(function(){
	
	$dlgImportCusInfo = $("#dlgImportCusInfo");
	$dlgImportErrCusInfo = $("#dlgImportErrCusInfo");
	$dgImportErrlist = $("#dgImportErrlist");
	
	//将文件名填充到文本框中去
	$("input[type=file]").change(function(){
		$(this).parents(".uploader").find(".filename").val($(this).val());
	});
	
	//遍历文件是否有，没有则显示下面文件内容
	$("input[type=file]").each(function(){
		if($(this).val()==""){
			$(this).parents(".uploader").find(".filename").val("没有选择文件...");
		}else{
			$(this).parents(".uploader").find(".filename").val("");
		}
	});
})

/**
 * 打开文件上传对话框
 */
function importExcelfFile(){
	$dlgImportCusInfo.removeClass("hide").dialog({
		modal: true, //模式对话框
		title: '<i class="ace-icon fa fa-pencil-square-o bigger-250"></i><span class="ui-jqdialog-title" style="float: left;"> 导入本地客户</span>',
		title_html: true,
		width:"500",
		height:"400",
		buttons: [{
			html: '<i class="ace-icon fa fa-times"></i>关闭', //按钮文本
			"class": "btn btn-minier",
			click: function() {
				$(this).dialog("close");//关闭窗口
			}
		}],
		onClose: function(){
        	//清空里面的内容
			$("#filename").val("");
			
        }
	});
}


/**
 * 请求模板下载(到DownloadFileController.java中)
 */
function downloadFile(filename){
	window.location=contextPath+"/basicconfig/cusinfo/downloadfile?f="+filename;
}


/**
 * 文件上传
 */
function importFile(){
	
	//上传文件验证
	var fileInfo = $("#cusinfoimport").val();
	if (fileInfo == ''){
		confirm('请选择要导入的excel文件');
		return;
	}
	if (fileInfo.lastIndexOf('.') < 0){
		confirm('文件格式不正确,您可以修改下载的模板后上传模板文件');
	} else {
		var suffix = fileInfo.substring(fileInfo.lastIndexOf('.'));
		
		if (suffix != '.xls'){
			confirm('文件格式不正确,请上传excel表格模板文件');
			return;
		}
		
	}
	
	//调用ajaxfileupload.js中扩展定义的ajaxfileupload方法，将文件上传到后台
	 $.ajaxFileUpload({  
        url:contextPath+'/basicconfig/cusinfo/import',  
        secureuri:false,  
        fileElementId:'cusinfoimport',  
        dataType: 'json',
        type:'post',
        success: function (data, status){  
        	if (data != null){
        		var result = data.result;
        		if (result != null ){
        			if (result == '1'){
        				confirm('导入的表格没有客户信息');    
        			} else if (result == '0'){
        				confirm('全部导入成功');
        				loadDatas();//方法在list.js中，关闭模态框后用于自动查询加载数据
        			}
        			$dlgImportCusInfo.dialog("close");//关闭模态框
        		} else {
        			//导入数据失败的弹出框
        			$dlgImportErrCusInfo.removeClass("hide").dialog({
        				modal: true, //模式对话框
        				title: '<i class="ace-icon fa fa-pencil-square-o bigger-250"></i><span class="ui-jqdialog-title" style="float: left;">导入失败列表</span>',
        				title_html: true,
        				width:"500",
        				height:"400"
        				/*buttons: [{
        					html: '<i class="ace-icon fa fa-times"></i>关闭', //按钮文本
        					"class": "btn btn-minier",
        					click: function() {
        						$(this).dialog("close");//关闭窗口
        					}
        				}],
        				open: function(){
        		        	//清空里面的内容
        		        }*/
        			});
        			//展开失败列表
        		    $dgImportErrlist = $dgImportErrlist.jqGrid({
            	    	height:490,
            	    	width:465,
            	    	datatype:"local",
            	    	data:data,
            		    colNames:['excel行号', '错误信息'],
            	        colModel:[
            	            {name:'rownum',index:'rownum', width:'15%',align:'center'},
            	            {name:'errMsg',index:'errMsg', width:'15%',align:'center'},
            	        ],
            	        rowNum: 10000 //注意：-1通过url加载的数据会全部显示，但加载本地数据会少一条
        	        });
        			
        			//动态填充数据到表格中
        			/*var $thead = $('<thead><tr><th>excel行号</th><th>错误信息</th></tr></thead>');
        			$thead.appendTo($dgImportErrlist);
        			var $tbody = $('<tobdy></tobdy>');
        			for (var i = 0; i< data.length; i++) {
						var $errMsg  = data[i].errMsg;
						var $rownum  = data[i].rownum;
						var $tr = $('<tr><td>'+$rownum+'</td><td>'+$errMsg+'</td></tr>');
						$tr.appendTo($tbody);
					}
        			$tbody.appendTo($dgImportErrlist);
        			*/
        			loadDatas();//方法在list.js中，关闭对话框后用于自动查询数据
        		}
        	}
        },  
        error: function (data, status, e)  
        {  
            alert(data.status);  
            confirm(data.message+" error:  "+e); 
        }  
     }  
  );  
}
