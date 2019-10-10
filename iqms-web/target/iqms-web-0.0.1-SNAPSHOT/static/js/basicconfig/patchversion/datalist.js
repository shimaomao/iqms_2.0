
/**
 * ajax加载数据的方法
 */
function loadData(){
	 //执行get请求
	 var url = contextPath + "/basicconfig/patchversion?dt="+(new Date().getTime());
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
        	   patchHtml += '版本日期：'+patchObj.patchDate;
        	   patchHtml += '</h5>';
        	   patchHtml += '</div>';
        	   patchHtml += '<div class="widget-body">';
        	   patchHtml += '<div class="widget-main">';
        	   patchHtml += '<ul class="list-unstyled spaced2">';
        	   patchHtml += '<li><i class="ace-icon fa fa-check green"></i>版本编号：'+patchObj.id+'</li>';
        	   patchHtml += '<li><i class="ace-icon fa fa-check green"></i>版本名称：'+patchObj.patchName+'</li>';
        	   patchHtml += '<li><i class="ace-icon fa fa-check green"></i>版本号：'+patchObj.patchVerno+'</li>';
        	   //patchHtml += '<li><i class="ace-icon fa fa-check green"></i>MD5:'+patchObj.patchMd5+'</li>';
        	   patchHtml += '<li><i class="ace-icon fa fa-check green"></i>是否全量：'+(patchObj.intactFlag == 1?'全量':'增量')+'</li>';
        	   patchHtml += '<li><i class="ace-icon fa fa-check green"></i>包含数据库：'+(patchObj.dbFlag == 1?'包含数据库':'不包含数据库')+'</li>';
        	   patchHtml += '<li><i class="ace-icon fa fa-check green"></i>备注：'+(patchObj.patchRemark == null ?'':patchObj.patchRemark)+'</li>';
        	   patchHtml += '<hr />';
        	   patchHtml += '<div class="price">';
        	   var downUrl = contextPath+patchObj.patchPath;
        	   patchHtml += '<a href="'+downUrl+'" >';
        	   patchHtml += '<i class="ace-icon fa fa-download red"></i>';
        	   patchHtml += '</a>';
        	   patchHtml += '</div>';
        	   patchHtml += '</div>';
        	   patchHtml += '<div>';
        	   patchHtml += '<a href="javascript:void(0);" onclick="chooseUpgradeDevTree('+patchObj.id+');" class="btn btn-block btn-inverse">';
        	   patchHtml += '<i class="ace-icon fa fa-hand-o-right" bigger-150"></i>选择设备升级';
        	   patchHtml += '</a>';
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