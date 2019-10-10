<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script src="${staticPath}/static/js/basicconfig/orderconfig/new.js"></script>
<!--模态窗口页面内容这里是一个表单-->
<div id="dialog-new" class="hide">
	<form name="FormPost" id="new" class="form-horizontal" onsubmit="return false;" style="width:auto;height:auto;">
		
		<div class="form-group">
			<label class="col-md-3 control-label no-padding-right" for="devName">选择设备</label>
			<div class="col-md-9">
				<div class="clearfix">
				<input type="text" id="devName" readonly="readonly" name="devName" placeholder=""  autocomplete="off"
				onclick="createDevTree(${currentUser.orgId},true,false,true)" class="col-md-9 col-sm-9" />
				<input  type="hidden"  name="orgId"  value="${currentUser.orgId}"  />
				<input  type="hidden"  name="deviceNo"  value="${currentUser.orgId}"  />
				</div>
			</div>
		</div>
		
		<div class="space-4"></div>
		<div class="form-group">
			<label class="col-md-3 control-label no-padding-right" for="beginTime">开始时间</label>

			<div class="col-md-9">
				<div class="clearfix">
					<input type="text" id="beginTime" name="beginTime" readonly="readonly" placeholder="请输入时间(hh:mm)"  class="col-md-9 col-sm-5" />
				</div>
			</div>
		</div>

		<div class="space-4"></div>
		<div class="form-group">
			<label class="col-md-3 control-label no-padding-right" for="endTime">结束时间</label>

			<div class="col-md-9">
				<div class="clearfix">
					<input type="text" id="endTime" name="endTime" readonly="readonly" placeholder="请输入时间(hh:mm)" class="col-md-9 col-sm-5" />
				</div>
			</div>
		</div>

		<div class="space-4"></div>
		<div class="form-group">
			<label class="col-md-3 control-label no-padding-right" for="orderCount">预约数量</label>

			<div class="col-md-9">
				<div class="clearfix">
					<input type="text" id="orderCount" name="orderCount" placeholder="0" class="col-md-9 col-sm-5" />
				</div>
			</div>
		</div>
		
	</form>
</div>
<!-- #dialog-message -->