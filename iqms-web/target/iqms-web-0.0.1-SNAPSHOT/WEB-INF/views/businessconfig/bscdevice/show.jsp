<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script src="${staticPath}/static/js/businessconfig/bscdevice/show.js"></script>
<!--模态窗口页面内容这里是一个表单-->
<div id="dialog-show" class="hide">
	<form name="FormPost"  class="form-horizontal" onsubmit="return false;" style="width:auto;height:auto;">
		
		<div class="form-group">
			<label class="col-md-3 control-label no-padding-right" for="orgName"> 所属机构 </label>
			<div class="col-md-9">
				<div class="clearfix">
				<input type="text" id="orgName" disabled="disabled" name="orgName" placeholder="选中机构" value="${currentUser.orgName}" onclick="selectOrgTree(this,fillDevNo);" class="col-md-9 col-sm-9" />
				<input  type="hidden" name="orgId"  value="${currentUser.orgId}"  />
				</div>
			</div>
		</div>

		<div class="form-group">
			<label class="col-md-3 control-label no-padding-right" for="deviceNo"> 设备编号 </label>

			<div class="col-md-9">
				<div class="clearfix">
					<input type="text" id="deviceNo" disabled="disabled" name="deviceNo" placeholder="点击自动生成" class="col-md-9 col-sm-5" />
				</div>
			</div>
		</div>

		<!-- /section:elements.form -->
		<div class="space-4"></div>
		<div class="form-group">
			<label class="col-md-3 control-label no-padding-right" for="hostName"> 主机名称 </label>

			<div class="col-md-9">
				<div class="clearfix">
					<input type="text" id="hostName" disabled="disabled" name="hostName" placeholder="随便填写" class="col-md-9 col-sm-5" />
				</div>
			</div>
		</div>

		<div class="space-4"></div>
		<div class="form-group">
			<label class="col-md-3 control-label no-padding-right"  for="ipAddr"> IP地址 </label>

			<div class="col-md-9">
				<div class="clearfix">
					<input type="text" id="ipAddr" disabled="disabled" name="ipAddr" placeholder="IP地址" class="col-md-9 col-sm-5" />
				</div>
			</div>
		</div>
		
		<div class="space-4"></div>
		<div class="form-group">
			<label class="col-md-3 control-label no-padding-right" for="macAddr"> MAC地址 </label>

			<div class="col-md-9">
				<div class="clearfix">
					<input type="text" id="macAddr" disabled="disabled" name="macAddr" placeholder="mac地址" class="col-md-9 col-sm-5" />
				</div>
			</div>
		</div>
		
		<div class="space-4"></div>
		<div class="form-group">
			<label class="col-md-3 control-label no-padding-right" for="producer"> 设备厂家 </label>

			<div class="col-md-9">
				<div class="clearfix">
					<input type="text" id="producer" disabled="disabled" name="producer" placeholder="" class="col-md-9 col-sm-5" />
				</div>
			</div>
		</div>
		
		<div class="space-4"></div>
		<div class="form-group">
			<label class="col-md-3 control-label no-padding-right" for="installDate"> 安装日期 </label>

			<div class="col-md-9">
				<div class="clearfix">
					<input type="text" id="installDate" disabled="disabled" name="installDate" placeholder="" class="col-md-9 col-sm-5" />
				</div>
			</div>
		</div>
		
		<div class="space-4"></div>
		<div class="form-group">
			<label class="col-md-3 control-label no-padding-right" for="installDate"> 设备管理员 </label>

			<div class="col-md-9">
				<div class="clearfix">
					<input type="text" id="adminName" disabled="disabled" name="adminName" placeholder="" class="col-md-9 col-sm-5" />
				</div>
			</div>
		</div>
		
		<div class="space-4"></div>
		<div class="form-group">
			<label class="col-md-3 control-label no-padding-right" for="adminPhone"> 管理员电话 </label>

			<div class="col-md-9">
				<div class="clearfix">
					<input type="text" id="adminPhone" disabled="disabled" name="adminPhone" placeholder="" class="col-md-9 col-sm-5" />
				</div>
			</div>
		</div>

		<div class="space-4"></div>
		<div class="form-group">
			<label class="col-md-3 control-label no-padding-right" for="orderFlag"> 是否可预约 </label>

			<div class="col-md-9">
				<select name="orderFlag" id="orderFlag" disabled="disabled" class="form-control" style="width:197px;">
					<option value="1">是</option>
					<option value="0">否</option>
				</select>
			</div>
		</div>
		
	</form>
</div>
<!-- #dialog-message -->