<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script src="${staticPath}/static/js/basicconfig/resourceupload/new.js"></script>
<!--模态窗口页面内容这里是一个表单-上传附件的附加消息-->
<div id="dialog-uploadinfo" class="hide">
	<form name="FormPost" id="uploadForm" class="form-horizontal" onsubmit="return false;" style="width:auto;height:auto;">
		
		<div class="form-group">
			<label class="col-md-3 control-label no-padding-right" for="fileName">文件名称</label>
			<div class="col-md-9">
				<div class="clearfix">
				<input type="text" id="fileName" name="fileName" readonly="readonly" class="col-md-9 col-sm-9" />
				</div>
			</div>
		</div>
		<div class="space-4"></div>
		<div class="form-group">
			<label class="col-md-3 control-label no-padding-right" for="filePath">目标目录</label>

			<div class="col-md-9">
				<div class="clearfix">
					<input type="text" placeholder="" value="" class="nav-search-input" readonly="readonly"
					name="filePath" id="filePath" autocomplete="off" onclick="selectFileTree(true,true,false,searchCondition)" />
				</div>
			</div>
		</div>
		<div class="space-4"></div>
		<div class="form-group">
			<label class="col-md-3 control-label no-padding-right" for="fileRemark"> 备注 </label>

			<div class="col-md-7">
				<div class="clearfix">
					<textarea id="fileRemark" name="fileRemark" placeholder="最多50个字符" class="form-control limited" maxlength="50"></textarea>
				</div>
			</div>
		</div>
	</form>
</div>
<!-- #dialog-message -->