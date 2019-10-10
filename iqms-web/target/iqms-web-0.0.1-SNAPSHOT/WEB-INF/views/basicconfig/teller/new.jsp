<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script src="${staticPath}/static/js/basicconfig/teller/new.js"></script>
<!--模态窗口页面内容这里是一个表单-->
<div id="dialog-new" class="hide">
	<form name="FormPost"  class="form-horizontal" onsubmit="return false;" style="width:350px;height:auto;">
		
		<div class="form-group">
			<label class="col-md-3 control-label no-padding-right" for="orgName"> 所属机构 </label>
			<div class="col-md-9">
				<div class="clearfix">
				<input type="text" id="orgName" name="orgName" placeholder="选中机构" value="${currentUser.orgName}" onclick="selectOrgTree(this,true,fillDevNo);" class="col-md-9 col-sm-9" />
				<input  type="hidden" name="orgId"  value="${currentUser.orgId}"  />
				</div>
			</div>
		</div>

		<div class="form-group">
			<label class="col-md-3 control-label no-padding-right" for="workId"> 柜员工号 </label>

			<div class="col-md-9">
				<div class="clearfix">
					<input type="text" id="workId" name="workId" placeholder="请输入工号" class="col-md-9 col-sm-5" />
				</div>
			</div>
		</div>

		<!-- /section:elements.form -->
		<div class="space-4"></div>
		<div class="form-group">
			<label class="col-md-3 control-label no-padding-right" for="callerPwd"> 柜员密码 </label>

			<div class="col-md-9">
				<div class="clearfix">
					<input type="password" id="callerPwd" name="callerPwd"  class="col-md-9 col-sm-5" />
				</div>
			</div>
		</div>

		<div class="space-4"></div>
		<div class="form-group">
			<label class="col-md-3 control-label no-padding-right" for="name_"> 柜员名称 </label>

			<div class="col-md-9">
				<div class="clearfix">
					<input type="text" id="name_" name="name_" placeholder="请输入柜员名" class="col-md-9 col-sm-5" />
				</div>
			</div>
		</div>
		
		<div class="space-4"></div>
		<div class="form-group">
			<label class="col-md-3 control-label no-padding-right" for="sex"> 性别 </label>

			<div class="col-md-9">
				<div class="clearfix">
					<select  id="sex" name="sex" class="col-md-9 col-sm-5">
					</select>
				</div>
			</div>
		</div>
		
		<div class="space-4"></div>
		<div class="form-group">
			<label class="col-md-3 control-label no-padding-right" for="status"> 状态 </label>

			<div class="col-md-9">
				<div class="clearfix">
					<select  id="status" name="status" class="col-md-9 col-sm-5">
					</select>
				</div>
			</div>
		</div>
	</form>
</div>
<!-- #dialog-message -->