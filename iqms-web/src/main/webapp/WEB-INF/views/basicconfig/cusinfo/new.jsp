<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script src="${staticPath}/static/js/basicconfig/cusinfo/new.js"></script>
<!--模态窗口页面内容这里是一个表单-->
<div id="dialog-new" class="hide">
	<form name="FormPost"  class="form-horizontal" onsubmit="return false;" style="width:400px;height:auto;">
		
		<div class="form-group">
			<label class="col-md-3 control-label no-padding-right" for="orgName"> 所属机构 </label>
			<div class="col-md-9">
				<div class="clearfix">
				<input type="text" id="orgName" name="orgName" placeholder="选中机构" value="${currentUser.orgName}" onclick="selectOrgTree(this,true,fillCustId);" class="col-md-9 col-sm-9" />
				<input  type="hidden" name="orgId"  value="${currentUser.orgId}"  />
				</div>
			</div>
		</div>

		<div class="form-group">
			<label class="col-md-3 control-label no-padding-right" for="custId"> 客户识别码 </label>

			<div class="col-md-9">
				<div class="clearfix">
					<input type="text" id="custId" name="custId" placeholder="客户识别码" class="col-md-9 col-sm-5" />
				</div>
			</div>
		</div>

		<!-- /section:elements.form -->
		<div class="space-4"></div>
		<div class="form-group">
			<label class="col-md-3 control-label no-padding-right" for="custName"> 客户姓名 </label>

			<div class="col-md-9">
				<div class="clearfix">
					<input type="text" id="custName" name="custName" placeholder="客户姓名" class="col-md-9 col-sm-5" />
				</div>
			</div>
		</div>

		<div class="space-4"></div>
		<div class="form-group">
			<label class="col-md-3 control-label no-padding-right" for="custLevel"> 客户类型</label>

			<div class="col-md-9">
				<div class="clearfix">
					<select class="col-md-9 col-sm-5" name="custLevel">
												
					</select>
				</div>
			</div>
		</div>
		
		<div class="space-4"></div>
		<div class="form-group">
			<label class="col-md-3 control-label no-padding-right" for="isBankEftve"> 是否全行生效 </label>

			<div class="col-md-9">
				<div class="clearfix">
				<select name="isBankEftve" id="isBankEftve" class="col-md-9 col-sm-5"  >
					<option value="1">是</option>
					<option value="0">否</option>
				</select>
				</div>
			</div>
		</div>
		
		<div class="space-4"></div>
		<div class="form-group">
			<label class="col-md-3 control-label no-padding-right" for="custPdut"> 推荐产品 </label>

			<div class="col-md-9">
				<div class="clearfix">
					<input type="text" id="custPdut" name="custPdut" placeholder="推荐产品" class="col-md-9 col-sm-5" />
				</div>
			</div>
		</div>
		
		<div class="space-4"></div>
		<div class="form-group">
			<label class="col-md-3 control-label no-padding-right" for="custAd"> 精准广告 </label>

			<div class="col-md-9">
				<div class="clearfix">
					<input type="text" id="custAd" name="custAd" placeholder="精准广告" class="col-md-9 col-sm-5" />
				</div>
			</div>
		</div>
		
	</form>
</div>
<!-- #dialog-message -->