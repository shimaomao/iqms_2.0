<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script src="${staticPath}/static/js/businessconfig/bscwinconfig/edit.js"></script> 
<!--模态窗口页面内容这里是一个表单-->
<div id="dialog-edit" class="hide">
	<form name="FormPost"  class="form-horizontal" onsubmit="return false;" style="width:auto;height:auto;">
		
		<div class="form-group">
			<label class="col-md-3 control-label no-padding-right" for="orgName"> 所属机构</label>
			<div class="col-md-9">
				<div class="clearfix">
				<input type="text" id="orgName" name="orgName" placeholder="所属机构" value="" readonly="readonly" class="col-md-9 col-sm-9" />
				<input  type="hidden" name="orgId"  value=""  />
				</div>
			</div>
		</div>
		
		<div class="form-group">
			<label class="col-md-3 control-label no-padding-right" for="deviceNo"> 设备编号 </label>
			<div class="col-md-9">
				<div class="clearfix">
				<input type="text" id="deviceNo" name="deviceNo" placeholder="设备编号" value="" readonly="readonly" class="col-md-9 col-sm-9" />
				</div>
			</div>
		</div>

		<div class="form-group">
			<label class="col-md-3 control-label no-padding-right" for="winNo"> 窗口号 </label>

			<div class="col-md-9">
				<div class="clearfix">
					<input type="text" id="winNo" name="winNo" placeholder="窗口号" readonly="readonly"  class="col-md-9 col-sm-5" />
				</div>
			</div>
		</div>

		<!-- /section:elements.form -->
		<div class="space-4"></div>
		<div class="form-group">
			<label class="col-md-3 control-label no-padding-right" for="isCall">有无呼叫器 </label>

			<div class="col-md-9">
				<select name="isCall" id="isCall" class="form-control" style="width:197px;">
					<option value="0">有</option>
					<option value="1">无</option>
				</select>
			</div>
		</div>

		<div class="space-4"></div>
		<div class="form-group">
			<label class="col-md-3 control-label no-padding-right" for="isJudge">有无评价器</label>
			<div class="col-md-9">
				<select name="isJudge" id="isJudge" class="form-control" style="width:197px;">
					<option value="0">有</option>
					<option value="1">无</option>
				</select>
			</div>
		</div>
		
		<div class="space-4"></div>
		<div class="form-group">
			<label class="col-md-3 control-label no-padding-right" for="winScreen"> 窗口屏 </label>

			<div class="col-md-9">
				<div class="clearfix">
					<input type="text" id="winScreen" name="winScreen" placeholder="条屏地址，多个用'|'隔开" class="col-md-9 col-sm-5" />
				</div>
			</div>
		</div>
		
		<div class="space-4"></div>
		<div class="form-group">
			<label class="col-md-3 control-label no-padding-right" for="multipleScreen"> 综合屏 </label>

			<div class="col-md-9">
				<div class="clearfix">
					<input type="text" id="multipleScreen" name="multipleScreen" placeholder="综合屏地址，多个用'|'隔开" class="col-md-9 col-sm-5" />
				</div>
			</div>
		</div>
		
		<div class="space-4"></div>
		<div class="form-group">
			<label class="col-md-3 control-label no-padding-right" for="isStart">是否启用</label>

			<div class="col-md-9">
				<select name="isStart" id="isStart" class="form-control" style="width:197px;">
					<option value="0">是</option>
					<option value="1">否</option>
				</select>
			</div>
		</div>
	</form>
</div>
<!-- #dialog-message -->