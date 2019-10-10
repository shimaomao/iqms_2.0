<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script src="${staticPath}/static/js/businessconfig/bsccustlevel/new.js"></script> 
<!--模态窗口页面内容这里是一个表单-->
<div id="dialog-new" class="hide">
	<form name="FormPost"  class="form-horizontal" onsubmit="return false;" style="width:auto;height:auto;">
		
		<div class="form-group">
			<label class="col-md-3 control-label no-padding-right" for="orgName"> 
			请选择：
			<span style="color:red">*</span>
			</label>
			<div class="col-md-9">
				<div class="clearfix">
				<input type="text" id="devName" name="devName" placeholder="选中机构或设备" value="${currentUser.orgName}" onclick="selectOrgDeviceTree(${currentUser.orgId},true,true)" class="col-md-9 col-sm-9" />
				<input  type="hidden" id="orgDevicelist" name="orgDevicelist"  value=""  /> 
				</div>
			</div>
		</div>
		
		<div class="form-group">
			<label class="col-md-3 control-label no-padding-right" for="custLevel">客户等级</label>

			<div class="col-md-9">
				<select name="custLevel" id="custLevel" class="form-control" style="width:198px;"></select>
			</div>
		</div>
		
		<div class="form-group">
			<label class="col-md-3 control-label no-padding-right" for="businessId"> 绑定业务 </label>

			<div class="col-md-9">
				<div class="clearfix">
				<select name="businessId" id="businessId" class="form-control" style="width:198px;"></select>
				</div>
			</div>
		</div> 

		<!-- /section:elements.form -->
		<div class="space-4"></div>
		<div class="form-group">
			<label class="col-md-3 control-label no-padding-right" for="priorTime"> 优先时间 </label>

			<div class="col-md-9">
				<div class="clearfix">
					<input type="text" id="priorTime" name="priorTime" placeholder="" class="col-md-9 col-sm-5" />
				</div>
			</div>
		</div>

		<div class="space-4"></div>
		<div class="form-group">
			<label class="col-md-3 control-label no-padding-right" for="callHead">
			呼叫字头
			<span style="color:red">*</span>
			</label>
			<div class="col-md-9">
				<div class="clearfix">
					<input type="text" id="callHead" name="callHead" placeholder="" class="col-md-9 col-sm-5" />
				</div>
			</div>
		</div>
		
		<div class="space-4"></div>
		<div class="form-group">
			<label class="col-md-3 control-label no-padding-right" for="maxWaitTime">最大等候时间</label>

			<div class="col-md-9">
				<div class="clearfix">
					<input type="text" id="maxWaitTime" name="maxWaitTime" placeholder="" class="col-md-9 col-sm-5" />
				</div>
			</div>
		</div>
		
		<div class="space-4"></div>
		<!-- <div class="form-group">
			<label class="col-md-3 control-label no-padding-right" for="ticketTemplate">号票模板 </label>

			<div class="col-md-9">
				<div class="col-md-9">
				<select name="ticketTemplate" id="ticketTemplate" class="form-control" style="width:198px;"/>
				</div>
			</div>
		</div> -->
		
		<div class="space-4"></div>
		<div class="form-group">
			<label class="col-md-3 control-label no-padding-right" for="isStart">是否启用</label>

			<div class="col-md-9">
				<select name="isStart" id="isStart" class="form-control" style="width:198px;">
					<option value="0">是</option>
					<option value="1">否</option>
				</select>
			</div>
		</div>
	</form>
</div>
<!-- #dialog-message -->