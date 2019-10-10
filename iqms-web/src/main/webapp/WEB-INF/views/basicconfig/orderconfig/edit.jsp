<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script src="${staticPath}/static/js/basicconfig/orderconfig/edit.js"></script>
<!--模态窗口页面内容这里是一个表单-->
<div id="dialog-edit" class="hide">
	<form name="FormPost"  class="form-horizontal" onsubmit="return false;" style="width:350px;height:auto;">
		
		<div class="form-group">
			<label class="col-md-3 control-label no-padding-right" for="orgName"> 所属机构 </label>
			<div class="col-md-9">
				<div class="clearfix">
					<input type="text" id="orgName" name="orgName"  readonly="readonly" class="col-md-9 col-sm-5" />
					<input type="hidden" id="orderId" name="orderId"/>
					<input type="hidden" id="deviceNo" name="deviceNo"/>
				</div>
			</div>
		</div>

		<div class="form-group">
			<label class="col-md-3 control-label no-padding-right" for="devName"> 设备名称 </label>

			<div class="col-md-9">
			    <div class="clearfix">
					<input type="text" id="hostName" name="hostName" readonly="readonly" class="col-md-9 col-sm-5" />
				</div>
			</div>
		</div>
		<div class="form-group">
			<label class="col-md-3 control-label no-padding-right" for="beginTime">开始时间</label>

			<div class="col-md-9">
			    <div class="clearfix">
					<input type="text" id="beginTime" name="beginTime" readonly="readonly" placeholder="请输入时间(hh:mm)" class="col-md-9 col-sm-5" />
				</div>
			</div>
		</div>
		<div class="form-group">
			<label class="col-md-3 control-label no-padding-right" for="endTime"> 结束时间 </label>

			<div class="col-md-9">
			    <div class="clearfix">
					<input type="text" id="endTime" name="endTime" readonly="readonly" placeholder="请输入时间(hh:mm)" class="col-md-9 col-sm-5" />
				</div>
			</div>
		</div>
		<div class="form-group">
			<label class="col-md-3 control-label no-padding-right" for="orderCount"> 预约数量 </label>

			<div class="col-md-9">
			    <div class="clearfix">
					<input type="text" id="orderCount" name="orderCount" placeholder="请输入数字" class="col-md-9 col-sm-5" />
				</div>
			</div>
		</div>
	</form>
</div>
<!-- #dialog-message -->