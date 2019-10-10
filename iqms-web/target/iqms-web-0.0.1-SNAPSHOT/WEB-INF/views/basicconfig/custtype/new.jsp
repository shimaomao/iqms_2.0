<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script src="${staticPath}/static/js/basicconfig/custtype/new.js"></script>
<!--模态窗口页面内容这里是一个表单-->
<div id="dialog-new" class="hide">
	<form name="FormPost"  class="form-horizontal" onsubmit="return false;" style="width:400px;height:auto;">
		
		<div class="form-group">
			<label class="col-md-3 control-label no-padding-right" for="custLevel"> 类型编码 </label>
			<div class="col-md-9">
				<div class="clearfix">
				<input type="text" id="custLevel" name="custLevel" placeholder="请输入字母或数字" class="col-md-9 col-sm-5" />
				</div>
			</div>
		</div>

		<div class="form-group">
			<label class="col-md-3 control-label no-padding-right" for="custName"> 类型名称 </label>

			<div class="col-md-9">
				<div class="clearfix">
					<input type="text" id="custName" name="custName" placeholder="请输入中英文" class="col-md-9 col-sm-5" />
				</div>
			</div>
		</div>

		<!-- /section:elements.form -->
		<div class="space-4"></div>
		<div class="form-group">
			<label class="col-md-3 control-label no-padding-right" for="waitTimeout"> 等待超时 </label>

			<div class="col-md-9">
				<div class="clearfix">
					<input type="text" id="waitTimeout" name="waitTimeout" placeholder="单位-分钟" class="col-md-9 col-sm-5" />
				</div>
			</div>
		</div>

		<div class="space-4"></div>
		<div class="form-group">
			<label class="col-md-3 control-label no-padding-right" for="vipFlag">VIP客户</label>

			<div class="col-md-9">
				<div class="clearfix">
					<select name="vipFlag" id="vipFlag" class="form-control" style="width:197px;">
					<option value="1">是</option>
					<option value="0">否</option>
				</select>
				</div>
			</div>
		</div>

		<div class="space-4"></div>
		<div class="form-group">
			<label class="col-md-3 control-label no-padding-right" for="smsFlag"> 是否发短信 </label>

			<div class="col-md-9">
			    <!--  
				<label>
					<input name="smsFlag" id="smsFlag" class="ace ace-switch ace-switch-5" type="checkbox">
					<span class="lbl"></span>
				</label>
				-->
				<select name="smsFlag" id="smsFlag" class="form-control" style="width:197px;">
					<option value="1">是</option>
					<option value="0">否</option>
				</select>
			</div>
		</div>
		
		<div class="space-4"></div>
		<div class="form-group">
			<label class="col-md-3 control-label no-padding-right" for="presentFlag"> 是否送礼物 </label>

			<div class="col-md-9">
				<!-- 
				<label>
					<input name="presentFlag" id="presentFlag" class="ace ace-switch ace-switch-5" type="checkbox">
					<span class="lbl"></span>
				</label>
				 -->
				<select name="presentFlag" id="presentFlag" class="form-control" style="width:197px;">
					<option value="1">是</option>
					<option value="0">否</option>
				</select>
			</div>
		</div>
		
		<div class="space-4"></div>
		<div class="form-group">
			<label class="col-md-3 control-label no-padding-right" for="isUse"> 是否使用 </label>

			<div class="col-md-9">
			    <!--  
				<label>
					<input name="isUse" id="isUse" class="ace ace-switch ace-switch-5" checked="checked" type="checkbox">
					<span class="lbl"></span>
				</label>
				-->
				<select name="isUse" id="isUse" class="form-control" style="width:197px;">
					<option value="1">是</option>
					<option value="0">否</option>
				</select>
			</div>
		</div>
		
	</form>
</div>
<!-- #dialog-message -->