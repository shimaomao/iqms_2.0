<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script src="${staticPath}/static/js/businessconfig/bscdevice/edit.js"></script>
<!--模态窗口页面内容这里是一个表单-->
<div id="dialog-edit" class="hide">
	<form name="FormPost"  class="form-horizontal" onsubmit="return false;" style="width:auto;height:auto;">
		<div class="form-group">
			<label class="col-md-3 control-label no-padding-right" for="orgName"> 所属机构 </label>
			<div class="col-md-9">
				<div class="clearfix">
					<input type="text" id="orgName" name="orgName" placeholder="选中机构" value="" readonly="readonly" class="col-md-9 col-sm-9" />
					<input  type="hidden" name="orgId"  value=""  />
				</div>
			</div>
		</div>

		<div class="form-group">
			<label class="col-md-3 control-label no-padding-right" for="deviceNo"> 设备编号 </label>

			<div class="col-md-9">
				<div class="clearfix">
					<input type="text" id="deviceNo" name="deviceNo" placeholder="点击自动生成" readonly="readonly" class="col-md-9 col-sm-5" />
				</div>
			</div>
		</div>

		<!-- /section:elements.form -->
		<div class="space-4"></div>
		<div class="form-group">
			<label class="col-md-3 control-label no-padding-right" for="hostName"> 主机名称 </label>

			<div class="col-md-9">
				<div class="clearfix">
					<input type="text" id="hostName" name="hostName" placeholder="随便填写" class="col-md-9 col-sm-5" />
				</div>
			</div>
		</div>

		<div class="space-4"></div>
		<div class="form-group">
			<label class="col-md-3 control-label no-padding-right" for="ipAddr"> IP地址 </label>

			<div class="col-md-9">
				<div class="clearfix">
					<input type="text" id="ipAddr" name="ipAddr" placeholder="IP地址" class="col-md-9 col-sm-5" />
				</div>
			</div>
		</div>
		
		<div class="space-4"></div>
		<div class="form-group">
			<label class="col-md-3 control-label no-padding-right" for="screenResolution1"> 分辨率 </label>

			<div class="col-md-9">
				<div class="clearfix">
					<select  id="screenResolution1" name="screenResolution1" class="col-md-9 col-sm-5">
					</select>
					<input type="hidden" id="screenResolution" name="screenResolution"/>
				</div>
			</div>
		</div>
		
		<div class="space-4"></div>
		<div class="form-group">
			<label class="col-md-3 control-label no-padding-right" for="macAddr"> MAC地址 </label>

			<div class="col-md-9">
				<div class="clearfix">
					<input type="text" id="macAddr" name="macAddr" placeholder="mac地址" class="col-md-9 col-sm-5" />
				</div>
			</div>
		</div>
		
		<div class="space-4"></div>
		<div class="form-group">
			<label class="col-md-3 control-label no-padding-right" for="producer"> 设备厂家 </label>

			<div class="col-md-9">
				<div class="clearfix">
					<select  id="producer1" name="producer1" class="col-md-9 col-sm-5">
					</select>
					<input type="hidden" id="producer" name="producer"/>
				</div>
			</div>
		</div>
		
		<div class="space-4"></div>
		<div class="form-group">
			<label class="col-md-3 control-label no-padding-right" for="installDate"> 安装日期 </label>

			<div class="col-md-9">
				<div class="clearfix">
					<input type="text" id="installDate" name="installDate" placeholder="" class="col-md-9 col-sm-5" />
				</div>
			</div>
		</div>
		
		<div class="space-4"></div>
		<div class="form-group">
			<label class="col-md-3 control-label no-padding-right" for="installDate"> 设备管理员 </label>

			<div class="col-md-9">
				<div class="clearfix">
					<input type="text" id="adminName" name="adminName" placeholder="" class="col-md-9 col-sm-5" />
				</div>
			</div>
		</div>
		
		<div class="space-4"></div>
		<div class="form-group">
			<label class="col-md-3 control-label no-padding-right" for="adminPhone"> 管理员电话 </label>

			<div class="col-md-9">
				<div class="clearfix">
					<input type="text" id="adminPhone" name="adminPhone" placeholder="" class="col-md-9 col-sm-5" />
				</div>
			</div>
		</div>

		<div class="space-4"></div>
		<div class="form-group">
			<label class="col-md-3 control-label no-padding-right" for="orderFlag"> 是否可预约 </label>

			<div class="col-md-9">
				<select name="orderFlag" id="orderFlag" class="form-control" style="width:197px;">
					<option value="1">是</option>
					<option value="0">否</option>
				</select>
			</div>
		</div>
		
		<div class="space-4"></div>
		<div class="form-group">
			<label class="col-md-3 control-label no-padding-right" for="orderFlag">上线模式</label>

			<div class="col-md-9">
				<select name="onlineModel" id="onlineModel" class="form-control" style="width:197px;">
					<option value="1">联网</option>
					<option value="0">单机</option>
				</select>
			</div>
		</div>
		
		<div class="space-4"></div>
		<div class="form-group">
			<label class="col-md-3 control-label no-padding-right" for="tpscrollFlag">条屏显示</label>

			<div class="col-md-9">
				<select name="tpscrollFlag" id="tpscrollFlag" class="form-control" style="width:197px;">
					<option value="1">条屏滚动</option>
					<option value="0">直接显示</option>
				</select>
			</div>
		</div>
		
	</form>
</div>
<!-- #dialog-message -->