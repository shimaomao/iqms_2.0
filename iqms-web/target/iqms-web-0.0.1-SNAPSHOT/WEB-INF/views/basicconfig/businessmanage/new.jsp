<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script src="${staticPath}/static/js/basicconfig/businessmanage/new.js"></script>
<!--模态窗口页面内容这里是一个表单-->
<div id="dialog-new" class="hide">
	<form name="FormPost"  class="form-horizontal" onsubmit="return false;" style="width:450px;height:auto;">
		
		<div class="form-group">
			<label class="col-md-4 control-label no-padding-right" for="businessName"> 业务名称 </label>

			<div class="col-md-8">
				<div class="clearfix">
					<input type="text" id="businessName" name="businessName" placeholder="请输入汉字、字母或数字" class="col-md-8 col-sm-5" />
				</div>
			</div>
		</div>

		<div class="form-group">
			<label class="col-md-4 control-label no-padding-right" for="businessEName"> 业务英文名 </label>

			<div class="col-md-8">
				<div class="clearfix">
					<input type="text" id="businessEName" name="businessEName" placeholder="请输入字母或数字" class="col-md-8 col-sm-5" />
				</div>
			</div>
		</div>

		<!-- /section:elements.form -->
		<div class="space-4"></div>
		<div class="form-group">
			<label class="col-md-4 control-label no-padding-right" for="averageTime"> 业务平均办理时长</label>

			<div class="col-md-8">
				<div class="clearfix">
					<input type="text" id="averageTime" name="averageTime" placeholder="单位-分钟" class="col-md-8 col-sm-5" />
				</div>
			</div>
		</div>

		<div class="space-4"></div>
		<div class="form-group">
			<label class="col-md-4 control-label no-padding-right" for="orderFlag">是否可预约 </label>
	
			<div class="col-md-8">
				<select name="orderFlag" id="orderFlag" class="form-control" style="width:197px;">
					<option value="1">是</option>
					<option value="0">否</option>
				</select>
			</div>
		</div>
		
	</form>
</div>
<!-- #dialog-message -->