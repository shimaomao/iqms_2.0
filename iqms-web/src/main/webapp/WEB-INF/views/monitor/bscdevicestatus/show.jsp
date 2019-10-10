<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script src="${staticPath}/static/js/monitor/bscdevicestatus/show.js"></script>
<!--模态窗口页面内容这里是一个表单-->
<div id="dialog-show" class="hide">
	<form name="FormPost"  class="form-horizontal" onsubmit="return false;" style="width:auto;height:auto;">
		
		<div class="form-group">
			<label class="col-md-3 control-label no-padding-right" for="orgName"> 机构名称 </label>
			<div class="col-md-9">
				<div class="clearfix">
					<input type="text" id="orgName" name="orgName" readonly="readonly" placeholder="请输入字母或数字" class="col-md-9 col-sm-5" />
				</div>
			</div>
		</div>

		<div class="form-group">
			<label class="col-md-3 control-label no-padding-right" for="deviceNo"> 设备编号</label>

			<div class="col-md-9">
			    <div class="clearfix">
					<input type="text" id="deviceNo" name="deviceNo" readonly="readonly" placeholder="请输入汉字或字母" class="col-md-9 col-sm-5" />
				</div>
			</div>
		</div>
		
		<!-- /section:elements.form -->
		<div class="space-4"></div>
		<div class="form-group">
			<label class="col-md-3 control-label no-padding-right" for="cpuRatio"> CPU使用率 </label>

			<div class="col-md-9">
				<input type="text" id="cpuRatio" name="cpuRatio" readonly="readonly" placeholder="" class="col-md-9 col-sm-5" />
			</div>
		</div>

		<div class="space-4"></div>
		<div class="form-group">
			<label class="col-md-3 control-label no-padding-right" for="memRatio"> 内存使用率 </label>

			<div class="col-md-9">
				<input type="text" id="memRatio" name="memRatio" readonly="readonly" placeholder="" class="col-md-9 col-sm-5" />
			</div>
		</div>

		<div class="space-4"></div>
		<div class="form-group">
			<label class="col-md-3 control-label no-padding-right" for="diskRatio"> 磁盘使用率</label>

			<div class="col-md-9">
				<input type="text" id="diskRatio" name="diskRatio" readonly="readonly" placeholder="" class="col-md-9 col-sm-5" />
			</div>
		</div>
		
		<div class="space-4"></div>
		<div class="form-group">
			<label class="col-md-3 control-label no-padding-right" for="currtVername">当前版本名称</label>
			<div class="col-md-9">
				<input type="text" id="currtVername" name="currtVername" readonly="readonly" placeholder="" class="col-md-9 col-sm-5" />
			</div>
		</div>
		
		<div class="space-4"></div>
		<div class="form-group">
			<label class="col-md-3 control-label no-padding-right" for="lastVername">最新版本名称</label>
			<div class="col-md-9">
				<input type="text" id="lastVername" name="lastVername" readonly="readonly" placeholder="" class="col-md-9 col-sm-5" />
			</div>
		</div>
	</form>
</div>
<!-- #dialog-message -->