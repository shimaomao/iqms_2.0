<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script src="${staticPath}/static/js/basicconfig/patchversion/new.js"></script>
<!--模态窗口页面内容这里是一个表单-上传附件的附加消息-->
<div id="dialog-patchinfo" class="hide">
	<form name="FormPost"  class="form-horizontal" onsubmit="return false;" style="width:auto;height:auto;">
		
		<div class="form-group">
			<label class="col-md-3 control-label no-padding-right" for="patchName"> 版本名称 </label>
			<div class="col-md-9">
				<div class="clearfix">
				<input type="text" id="patchName" name="patchName" readonly="readonly" class="col-md-9 col-sm-9" />
				</div>
			</div>
		</div>

		<div class="form-group">
			<label class="col-md-3 control-label no-padding-right" for="patchVerno"> 版本号 </label>

			<div class="col-md-9">
				<div class="clearfix">
					<input type="text" id="patchVerno" name="patchVerno" placeholder="版本号：V1.0" maxlength="10" class="col-md-9 col-sm-5" />
				</div>
			</div>
		</div>

		<div class="space-4"></div>
		<div class="form-group">
			<label class="col-md-3 control-label no-padding-right" for="intactFlag"> 更新包 </label>

			<div class="col-md-9">
				<select name="intactFlag" id="intactFlag" class="form-control" style="width:197px;">
					<option value="1">全量</option>
					<option value="0">增量</option>
				</select>
			</div>
		</div>
		
		<div class="space-4"></div>
		<div class="form-group">
			<label class="col-md-3 control-label no-padding-right" for="dbFlag"> 数据库 </label>

			<div class="col-md-9">
				<select name="dbFlag" id="dbFlag" class="form-control" style="width:197px;">
					<option value="1">包含</option>
					<option value="0">不包含</option>
				</select>
			</div>
		</div>
		
		<div class="space-4"></div>
		<div class="form-group">
			<label class="col-md-3 control-label no-padding-right" for="patchRemark"> 备注 </label>

			<div class="col-md-7">
				<div class="clearfix">
					<textarea id="patchRemark" name="patchRemark" placeholder="最多50个字符" class="form-control limited" maxlength="50"></textarea>
				</div>
			</div>
		</div>
	</form>
</div>
<!-- #dialog-message -->