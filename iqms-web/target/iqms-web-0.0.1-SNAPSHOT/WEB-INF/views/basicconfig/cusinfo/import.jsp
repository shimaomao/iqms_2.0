<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <%-- <%@ include file="/WEB-INF/views/shared/bootstrapcontentui.jsp"%> --%>
    <script src="${staticPath}/static/js/basicconfig/cusinfo/import.js"></script>
	<script src="${staticPath}/static/components/fileupload/js/ajaxfileupload.js"></script>
	<link rel="stylesheet" type="text/css" href="${staticPath}/static/components/fileupload/css/fileUpload.css" />
	
</head>
<body>
		
	<div id="dlgImportCusInfo" class="hide" style="overflow-y:hidden;">
		 <form >
			<div class="uploader">
				<input type="text" name="filename" class="filename" id="filename"  style="height:40px"/> 
				<input type="button" name="file" class="btn btn-sm btn-primary" style="height:40px" value="打开文件"/> 
				<input type="file" name="cusinfoimport" id="cusinfoimport" size="30" />
			</div>
			
			<div style="margin:60px 70px ;" align="center" >
				 <div style="width:100%; normal; display: inline-block;">
				 	<a href="javascript:downloadFile('cusinfotemplate.xls');" class="btn btn-sm btn-primary">
				 	<i class="ace-icon fa fa-download bigger-200"></i>
				 	模板下载</a>
				 	
				 	<a href="javascript:importFile();" class="btn btn-sm btn-primary">
				 	<i class="ace-icon fa fa-cloud-upload bigger-200"></i>
				 	文件上传</a>
				 </div>
		    </div>
		 </form>
	</div>
	
	<div id="dlgImportErrCusInfo" class="hide" >
		<table id="dgImportErrlist">
		</table>
	</div>
</body>
</html>
