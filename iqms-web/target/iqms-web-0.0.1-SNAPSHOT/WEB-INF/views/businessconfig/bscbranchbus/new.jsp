<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script src="${staticPath}/static/js/businessconfig/bscbranchbus/new.js"></script> 
<!--模态窗口页面内容这里是一个表单-->
<div id="dialog-new" class="hide">
	<form name="FormPost"  class="form-horizontal" id="new" onsubmit="return false;" style="width:auto;height:auto;">
		
		<div class="form-group">
			<label class="col-md-3 control-label no-padding-right" for="orgName"> 所属机构</label>
			<div class="col-md-9">
				<div class="clearfix">
				<input type="text" id="orgName" name="orgName" placeholder="所属机构" value="" readonly="readonly" class="col-md-9 col-sm-9" />
				<input  type="hidden" name="orgId"  value="123"  />
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
			<label class="col-md-3 control-label no-padding-right" for="menuName">菜单名称</label>
			<div class="col-md-9">
				<div class="clearfix">
				<input type="text" id="menuName" name="menuName" placeholder="菜单名称" value="" readonly="readonly" class="col-md-9 col-sm-9" />
				<input  type="hidden" name="menuId"  value=""  />
				</div>
			</div>
		</div>
		
		<div class="form-group">
			<label class="col-md-3 control-label no-padding-right" for="businessName">业务名称</label>
			<div class="col-md-9">
				<div class="clearfix">
				<input type="text" id="businessName" name="businessName" placeholder="业务名称" value="" readonly="readonly" class="col-md-9 col-sm-9" />
				<input  type="hidden" name="businessId"  value=""  />
				</div>
			</div>
		</div> 
		
		<div class="space-4"></div>
		<div class="form-group">
			<label class="col-md-3 control-label no-padding-right" for="businessEnName"> 业务英文名称 </label>

			<div class="col-md-9">
				<div class="clearfix">
					<input type="text" id="businessEnName" name="businessEnName" placeholder="" class="col-md-9 col-sm-5" />
				</div>
			</div>
		</div>
		
		<div class="space-4"></div>
		<div class="form-group">
			<label class="col-md-3 control-label no-padding-right" for="isShowEn">显示英文名</label>

			<div class="col-md-9">
				<select name="isShowEn" id="isShowEn" class="form-control" style="width:198px;">
					<option value="0">是</option>
					<option value="1">否</option>
				</select>
			</div>
		</div>
		
		<div class="space-4"></div>
		<div class="form-group">
			<label class="col-md-3 control-label no-padding-right" for="businessCode"> 业务代码 </label>

			<div class="col-md-9">
				<div class="clearfix">
					<input type="text" id="businessCode" name="businessCode" placeholder="" class="col-md-9 col-sm-5" />
				</div>
			</div>
		</div>
		<!-- /section:elements.form -->
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
			<label class="col-md-3 control-label no-padding-right" for="priorTime"> 优先时间 </label>

			<div class="col-md-9">
				<div class="clearfix">
					<input type="text" id="priorTime" name="priorTime" placeholder="" class="col-md-9 col-sm-5" />
				</div>
			</div>
		</div>

		<div class="space-4"></div>
		<div class="form-group">
			<label class="col-md-3 control-label no-padding-right" for="isSwipe">证件取号</label>

			<div class="col-md-9">
				<select name="isSwipe" id="isSwipe" class="form-control" style="width:198px;">
					<option value="0">是</option>
					<option value="1">否</option>
				</select>
			</div>
		</div>
		
		<div class="space-4"></div>
		<div class="form-group">
			<label class="col-md-3 control-label no-padding-right" for="pickUpAdvice">取票提示</label>

			<div class="col-md-9">
				<div class="clearfix">
					<input type="text" id="pickUpAdvice" name="pickUpAdvice" placeholder="" class="col-md-9 col-sm-5" />
				</div>
			</div>
		</div>
		
		<div class="space-4"></div>
		<div class="form-group">
			<label class="col-md-3 control-label no-padding-right" for="maxPickUp">最大取号数</label>

			<div class="col-md-9">
				<div class="clearfix">
					<input type="text" id="maxPickUp" name="maxPickUp" placeholder="" class="col-md-9 col-sm-5" />
				</div>
			</div>
		</div>
		
		<div class="space-4"></div>
		<div class="form-group">
			<label class="col-md-3 control-label no-padding-right" for="sortNum">排序号</label>

			<div class="col-md-9">
				<div class="clearfix">
					<input type="text" id="sortNum" name="sortNum" placeholder="" class="col-md-9 col-sm-5" />
				</div>
			</div>
		</div>
		
	</form>
</div>
<!-- #dialog-message -->