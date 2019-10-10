
/**
 * ajax加载数据的方法
 */
function loadData(){
	 //执行get请求
	 var url = contextPath + "/basicconfig/resourceupload?dt="+(new Date().getTime());
     $.get(url, {"page":0,"rows":0}, function(result)
     {
       //加载解析数据
       var dataList = result.rows;
       var patchHtml = '';
       if (dataList != null ){
    	   //每行展示4个记录
           for (var i = 0; i< dataList.length; i++){
        	   var patchObj = dataList[i];
        	   if (i == 0 || i%4 == 0){ //增加行
        		   patchHtml += '<div class="row">';
        		   patchHtml += '<div class="col-xs-12">';
        		   patchHtml += '<div class="row">';
        	   }
        	   
        	   //版本内容
        	   patchHtml += '<div class="col-xs-6 col-sm-3 pricing-box">';
        	   patchHtml += '<div class="widget-box widget-color-dark">';
        	   patchHtml += '<div class="widget-header">';
        	   patchHtml += '<h5 class="widget-title bigger lighter">';
        	   patchHtml += '上传日期：'+patchObj.uploadDate;
        	   patchHtml += '</h5>';
        	   patchHtml += '</div>';
        	   patchHtml += '<div class="widget-body">';
        	   patchHtml += '<div class="widget-main">';
        	   patchHtml += '<ul class="list-unstyled spaced2">';
        	   patchHtml += '<li><i class="ace-icon fa fa-check green"></i>文件名称：'+patchObj.fileName+'</li>';
        	   patchHtml += '<li><i class="ace-icon fa fa-check green"></i>文件类型：'+patchObj.fileType+'</li>';
        	   patchHtml += '<li><i class="ace-icon fa fa-check green"></i>所属目录：'+patchObj.filePath+'</li>';
        	   patchHtml += '<li><i class="ace-icon fa fa-check green"></i>备注：'+(patchObj.fileRemark == null ?'':patchObj.fileRemark)+'</li>';
        	   patchHtml += '<hr />';
        	   patchHtml += '</div>';
        	   patchHtml += '</div>';
        	   patchHtml += '</div>';
        	   patchHtml += '</div>';
        	   
        	   if ((i == dataList.length-1) || i%4 == 3){ //行结尾
        		   patchHtml += '</div>';
        		   patchHtml += '<div class="space-24"></div>';
        		   patchHtml += '</div>';
        		   patchHtml += '</div>';
        	   }
           }
       }
       
       //将html增加到
       $("#patchDetail").html(patchHtml);	 
    	 
     }, "json");
}