//上传文件对象
var myDropzone;
var $newDialog;
$(function(){
	$checkAll = $("#checkAll");
	$checkAll.on("click", function ()
	{
		checkAll(this);
     });
	//加载客户数据
	loadData();
	
	try {
		  Dropzone.autoDiscover = false;  //取消自动查找
		
		   myDropzone = new Dropzone('#dropzone', {
		    previewTemplate: $('#preview-template').html(), //预览模板
		    url:contextPath+'/basicconfig/uploadfile',
		    //method:'POST', 默认就是post
		    paramName:'patchFile',
		    
			thumbnailHeight: 120,  //缩略图宽度
		    thumbnailWidth: 120,   //缩略图高度
		    maxFilesize: 20,      //最大文件大小MB
		    autoProcessQueue:false, //取消自动上传文件  
//		    acceptedFiles:'', //接收的文件类型
		    maxFiles:1,//最多可以处理多少文件
			
			addRemoveLinks:true,  //是否添加移除链接
			//取消上传显示文本,addRemoveLinks为true时有效
			dictCancelUpload:'取消上传',
			
			uploadMultiple:false, //指明允许提交多个文件
			
			//dictRemoveFile: 'Remove',
			//初始化显示的内容消息，有上传文件后会消失
			dictDefaultMessage :   
			'<span class="bigger-150 bolder"><i class="ace-icon fa fa-caret-right red"></i> 拖动文件</span> 上传 \
			<span class="smaller-80 grey">(或者点击灰色区域)</span> <br /> \
			<i class="upload-icon ace-icon fa fa-cloud-upload blue fa-3x"></i>',
			
			//浏览器不支持时提示的错误信息
			dictFallbackMessage:'您的浏览器不支持此文件上传控件，请升级浏览器',
			
			//不匹配的文件类型
			dictInvalidFileType:'文件格式不正确：请上传zip压缩包文件',
			
			//文件太大
			dictFileTooBig:'文件大小超出范围：请上传{{filesize}}到{{maxFilesize}}范围大小的压缩包',
			
			//服务器响应错误
			dictResponseError:'文件上传服务器响应错误：{{statusCode}}',
			
			//取消确认上传的文字,addRemoveLinks为true时有效
			dictCancelUploadConfirmation:'取消上传确认',
			
			//删除显示文本：,addRemoveLinks为true时有效
			dictRemoveFile:'移除文件',
			
			//超出最大文件上传数时，显示的文本
			dictMaxFilesExceeded:'上传的文件超出了最大上传数',
			
			//缩略图显示
		    thumbnail: function(file, dataUrl) {
		      if (file.previewElement) {
		        $(file.previewElement).removeClass("dz-file-preview");
		        var images = $(file.previewElement).find("[data-dz-thumbnail]").each(function() {
					var thumbnailElement = this;
					thumbnailElement.alt = file.name;
					thumbnailElement.src = dataUrl;
				});
		        setTimeout(function() { $(file.previewElement).addClass("dz-image-preview"); }, 1);
		      }
		    },
		    //在初始化事件中，绑定默认事件
		    init:function(){
		    	//绑定添加文件的时间
		    	this.on("addedfile", function(file) { 
		    			//alert("添加文件监听时间，可以手工提交文件到服务器");
		    			//打开对话框 
		    		    addtionalInfo(file);
		    			//myDropzone.processQueue();
		    		    //删除元素
		    		    file.previewElement.addEventListener("click", function() {
	    		           myDropzone.removeFile(file);
	    		        });
		    		});
		    	//删除文件监听事件
		    	this.on("removedfile", function(file) { 
	    			//alert("删除文件事件，编写代码删除服务器上的文件."); 
	    		});
		    	//出错监听事件:文件，错误消息，XHttpRequest
		    	this.on("removedfile", function(file,errorMessage,XHttpRequest) { 
	    			//alert("删除文件事件，编写代码删除服务器上的文件."); 
	    		});
		    	
		    	//监听文件正在处理的事件：
		    	this.on("processing", function(file,errorMessage,XHttpRequest) { 
	    			//alert("文件正在被处理."); 
	    		});
		    	
		    	//文件上传进度更改时都会定期调用：file第一个参数，进度参数作为第二个参数（0-100的百分比），byteSent第三个参数发送到服务器的字节数
		    	//当上传完成dropzone时，确保uploadprogress将被调用百分之100至少一次。
		    	//警告：这个功能可以多次调用相同的进度
		    	this.on("uploadprogress", function(file,percentage,byteSent) { 
	    			//alert("调用进度条."); 
	    		});
		    	
		    	//发送之前封装参数
		    	this.on("sending", function(file,xhr,formData) { 
		    		var $form = $("#dialog-uploadinfo").find("form");
		    		var fileName = $form.find("#fileName").val();
		    		var filePath = $form.find("#filePath").val();
		    		var fileRemark = $form.find("#fileRemark").val();
		    		//获取附加参数
		    		formData.append("fileName", fileName);
		    		formData.append("filePath", filePath);
		    		formData.append("fileRemark", fileRemark);
		    		formData.append("opt", "add");
	    		});
		    	
		    	//文件上传成功被调用
		    	this.on("success", function(file, response, e) { 
		    		
		    		var data = $.parseJSON(response); //转json对象
		    		
		    		if (data != null && data.errorCode == '0'){
		    			//上传成功
		    			 $newDialog.dialog("close");
		    			 $.alert({
		                     title: '提示信息',
		                     icon:'fa fa-info-circle red',
		                     theme:'bootstrap',
		                     draggable: true,
		                     content: '<span class="bigger-120">文件上传成功:</span><br/>在文件浏览中可以查看上传的文件',
		                     closeIcon: true,
		                     buttons:{
		                     	 colseWin: {
		                          	text: '<i class="ace-icon fa fa-times"></i>关闭',
		                              btnClass: 'btn-info'
		                          }
		                     }
		                 });
		    			//重新加载版本详情页面
		    			loadData();
		    		} 
		    		else {
		    			//上传失败
		    			$.alert({
		                     title: '提示信息',
		                     icon:'fa fa-info-circle red',
		                     theme:'bootstrap',
		                     content: '文件上传失败，请联系管理员！',
		                     closeIcon: true,
		                     draggable: true,
		                     buttons:{
		                     	 colseWin: {
		                          	text: '<i class="ace-icon fa fa-times"></i>关闭',
		                              btnClass: 'btn-info'
		                          }
		                     }
		                 });
		    			
		    		}
	    		});
		    	
		    	//上传完成或者出错时触发
		    	this.on("complete", function(file) { 
	    			//alert("文件上传完成或者出错."); 
	    		});
		    	
		    	
		    	//出错时，点击模板就会删除
		    	this.on("error", function(file,errorMessage,XMLHttpRequest) { 
		    		file.previewElement.addEventListener("click", function() {
		    		    myDropzone.removeFile(file);
		    		  });
	    		});
		    	
		    	//取消文件上传调用
		    	this.on("canceled", function(file) { 
	    			//alert("取消文件上传调用."); 
	    		});
		    	
		    	//显示所有文件的总体上传进度
		    	
		    	this.on("totaluploadprogress", function(file) { 
	    			//alert("显示文件的总体上传进度."); 
	    		});
		    	
		    }
		
		  });
		
		   $(document).one('ajaxloadstart.page', function(e) {
				try {
					myDropzone.destroy();
				} catch(e) {}
		   });
		
		} catch(e) {
		  alert('Dropzone.js 不支持版本低的浏览器!');
		}
	
	
});

//全选
function checkAll(obj){
  if ($(obj).prop("checked") == true)
  { 
    $("input[type='checkbox']").each(function ()
    {
      $(this).prop("checked", true);
    });
  } else
  {
    $("input[type='checkbox']").each(function ()
    {
      $(this).prop("checked", false);
    });
  }
}


 //查询
function searchCondition() {
	$(".content").empty();
	 loadDatas();
}


 //执行查询方法
function loadDatas() {
	var dirPath = $("#dirPath").val();
	if(dirPath != ''&& dirPath != null){
		var fileList;
		$.ajax({
			url : contextPath + "/basicconfig/getFiles?dt="
			+ (new Date().getTime()),
			type : "get",
			data :{"dirPath":dirPath},
			dataType : "json ",
			contentType : "application/json",
			success : function(datas) {
				fileList = datas.rows;
				$div = $(".content");
				var $mygallery = $("<div class='chroma-gallery mygallery'>"+"</div>");
				$div.append($mygallery);
				for(var i = 0; i<fileList.length; i++){
					initData(fileList[i]);
				}
				$(".mygallery").chromaGallery
				({
					color:'#A9A9A9',
					gridMargin:15,
					maxColumns:10,
					dof:true,
					screenOpacity:0.8,
					fullscreen:false
				});
			}
		});
	}
}

function initData(itemData) {
	$ul = $(".mygallery");
	var $li;
	if (itemData) {
		/*$li = $("<li class='box'width='50%' height='50%'><a href='"+itemData.filePath+"' class='swipebox' title='"+itemData.fileName+"'>" 
				+"<img src='"+itemData.filePath+"'alt='image'>"
				+"</a></li>");*/
		$li = $("<img src='"+itemData.filePath+"'alt='"+itemData.fileName+"' data-largesrc='"+itemData.filePath+"'>"+"</img>");
	}
	$ul.append($li);
}

function zip(){
	$newDialog = $("#dialog-new").removeClass("hide").dialog({
		modal: true, //模式对话框
		title: '<i class="ace-icon fa fa-pencil-square-o bigger-250"></i><span class="ui-jqdialog-title" style="float: left;">上传</span>',
		title_html: true,
		width:"250",
		height:"200",
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
				//保存数据
				$(this).dialog("close");
				zipToClient();
			}
		}],
		open:function(){ //加载数据
			//请空上一次的表单数据
//			$("#dialog-new").find("form").clearForm();
		}
	});
}

function del(){
	$newDialog = $("#dialog-remove").removeClass("hide").dialog({
		modal: true, //模式对话框
		title: '<i class="ace-icon fa fa-pencil-square-o bigger-250"></i><span class="ui-jqdialog-title" style="float: left;">删除</span>',
		title_html: true,
		width:"250",
		height:"200",
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
				//保存数据
				$(this).dialog("close");
				remove();
			}
		}],
		open:function(){ //加载数据
			//请空上一次的表单数据
//			$("#dialog-new").find("form").clearForm();
		}
	});
}
//将images打包成zip
function zipToClient(){
	$.ajax({
		url : contextPath + "/basicconfig/resourceupload/zip?dt="
		+ (new Date().getTime()),
		type : "get",
		data :"",
		dataType : "json ",
		contentType : "application/json",
		success : function(result) {
			if (result.errorCode == '0')
	         {
	        	//弹出对话框
	         	$.alert({
	                 title: '提示信息',
	                 icon:'fa fa-info-circle blue',
	                 theme:'bootstrap',
	                 content: '下发成功',
	                 closeIcon: true,
	                 buttons:{
	                 	 colseWin: {
	                      	text: '<i class="ace-icon fa fa-times"></i>关闭',
	                          btnClass: 'btn-info'
	                      }
	                 }
	             });
	         	$newDialog.dialog("close");//关闭窗口
	         }
		}
	});
}

function remove(){
	var joArr = [];
	$("input[type='checkbox']").each(function() {
		if ($(this).attr("id") != "checkAll") {
			if($(this).is(':checked')){
				var jo = {};
				jo.fileName = $(this).attr("id");
				jo.filePath = $("#dirPath").val();
				jo.fileType = $("#dirName").val();
				joArr.push(jo);
			}
		}
	});
//	alert($.toJSON(joArr));
	$.ajax({
  		url : contextPath + "/basicconfig/resourceupload/delete?_method=delete&dt="
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
  	                 content: '图片删除成功',
  	                 closeIcon: true,
  	                 buttons:{
  	                 	 colseWin: {
  	                      	text: '<i class="ace-icon fa fa-times"></i>关闭',
  	                          btnClass: 'btn-info'
  	                      }
  	                 }
  	             });
  	         	searchCondition();
  	         }else if(result.errorCode == '2'){
  	        	$.alert({
 	                 title: '提示信息',
 	                 icon:'fa fa-info-circle red',
 	                 theme:'bootstrap',
 	                 content: '请勾选图片',
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
  	                 content: '图片删除失败',
  	                 closeIcon: true,
  	                 buttons:{
  	                 	 colseWin: {
  	                      	text: '<i class="ace-icon fa fa-times"></i>关闭',
  	                          btnClass: 'btn-info'
  	                      }
  	                 }
  	             });
  	        	searchCondition();
  	         }
  		}
  	});
}