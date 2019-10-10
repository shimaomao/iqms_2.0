<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script src="${staticPath}/static/js/businessconfig/bsccustlevel/edit.js"></script> 
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
			<label class="col-md-3 control-label no-padding-right" for="custLevel">客户等级</label>

			<div class="col-md-9">
				<div class="clearfix">
				<input type="text" id="custLevel" name="custLevel" placeholder="客户等级" value="" readonly="readonly" class="col-md-9 col-sm-9" />
				</div>
			</div>
		</div> 
		
		<div class="form-group">
			<label class="col-md-3 control-label no-padding-right" for="businessId"> 绑定业务 </label>

			<div class="col-md-9">
				<select name="businessId" id="businessId" class="form-control" style="width:197px;"></select>
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
				<select name="ticketTemplate" id="ticketTemplate" class="form-control" style="width:197px;"/>
			</div>
		</div> -->
		
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