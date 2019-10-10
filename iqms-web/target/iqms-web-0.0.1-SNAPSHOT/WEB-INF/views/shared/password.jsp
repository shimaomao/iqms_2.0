<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<sec:authentication property="principal" var="currentUser" />
<!DOCTYPE html>
<html>
<head>
<title><fmt:message key="user.changePassword"/></title>
<meta charset="utf-8"/>
<%@ include file="/WEB-INF/views/shared/bootstrapui.jsp"%>
<script>var currentUserId = ${currentUser.userId};</script>

	<!--[if !IE]> -->
	<script src="${staticPath}/static/lib2/js/jquery-2.0.3.min.js"></script>
	<!-- <![endif]-->

	<!--[if IE]>
	<script src="${staticPath}/static/lib2/js/jquery-1.10.2.min.js"></script>
	<![endif]-->

	<!--[if !IE]> -->
	<script type="text/javascript">
		window.jQuery || document.write("<script src='${staticPath}/static/lib2/js/jquery-2.0.3.min.js'>"+"<"+"script>");
	</script>
	<!-- <![endif]-->

	<!--[if IE]>
	<script type="text/javascript">
			window.jQuery || document.write("<script src='${staticPath}/static/lib2/js/jquery-1.10.2.min.js'>"+"<"+"script>");
	</script>
	<![endif]-->

	<script type="text/javascript">
		if("ontouchend" in document) document.write("<script src='${staticPath}/static/lib2/js/jquery.mobile.custom.min.js'>"+"<"+"script>");
	</script>
	<script src="${staticPath}/static/lib2/js/bootstrap.min.js"></script>
	<script src="${staticPath}/static/lib2/js/bootstrapValidator.min.js"></script>
	<script src="${staticPath}/static/lib2/js/typeahead-bs2.min.js"></script>

	<!-- page specific plugin scripts -->

	<!--[if lte IE 8]>
	  <script src="${staticPath}/static/lib2/js/excanvas.min.js"></script>
	<![endif]-->

	<script src="${staticPath}/static/lib2/js/jquery-ui-1.10.3.custom.min.js"></script>
	<script src="${staticPath}/static/lib2/js/jquery.ui.touch-punch.min.js"></script>
	<script src="${staticPath}/static/lib2/js/jquery.slimscroll.min.js"></script>
	<script src="${staticPath}/static/lib2/js/jquery.easy-pie-chart.min.js"></script>
	<script src="${staticPath}/static/lib2/js/jquery.sparkline.min.js"></script>
	<script src="${staticPath}/static/lib/jquery/plugins/jquery.i18n.properties.js"></script>
	<script src="${staticPath}/static/lib/jquery/plugins/jquery.string.js"></script>
	<script src="${staticPath}/static/lib/jquery/plugins/jquery.json.js"></script>
	<script src="${staticPath}/static/lib2/js/flot/jquery.flot.min.js"></script>
	<script src="${staticPath}/static/lib2/js/flot/jquery.flot.pie.min.js"></script>
	<script src="${staticPath}/static/lib2/js/flot/jquery.flot.resize.min.js"></script>

	<!-- ace scripts -->

	<script src="${staticPath}/static/lib2/js/ace-elements.min.js"></script>
	<script src="${staticPath}/static/lib2/js/ace.min.js"></script>
	
	<script src="${staticPath}/static/js/aotoframeworknew.js"></script>
	<script src="${staticPath}/static/js/shared/password.js"></script>
</head>
<body class="">  

	<div >
		<div class="modal-dialog" style="width:500px" id="changePwdModal">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
					<h4 class="modal-title" id="myModalLabel"><fmt:message key="user.changePassword"/></h4>
					<span id="changeSuccess" class="label label-success" style="display:none"></span>
					<span id="changeFailed" class="label label-danger" style="display:none"></span>
				</div>	
				<div style="text-align:center;">
					<c:choose>
			        	<c:when test="${msg eq 'security_low'}">
				        	<p style="color:red;font-size:16px;font-weight:bold;align:center"> 提示：由于该账号密码安全级别较低，请更新密码！</p>
			        	</c:when>
			        	<c:otherwise>
			       		 	<p style="color:red;font-size:16px;font-weight:bold;align:center"> 提示：由于该账号密码使用超过${pwdTimeLength}天，请更新密码！</p>
			        	</c:otherwise>
			        </c:choose>
		        </div>
				<!-- 修改密码对话框 -->					
				<form id="changePasswordForm" class="form-horizontal" role="form">
					<br>							
					<div class="form-group">
						<label for="oldpass" class="col-sm-3 control-label"><fmt:message key="user.oldPassword"/></label>
						<div class="col-sm-8">
							<input type="password" class="form-control" style="width:260px;" name="oldpass" id="oldpass" placeholder="<fmt:message key="user.oldPassword.palceholder" />"><span id="oldpassTip" style="display:none;color:red;"></span>
						</div>
						<div class="col-sm-1"></div>
					</div>
					<div class="form-group">
						<label for="newpass" class="col-sm-3 control-label"><fmt:message key="user.newPassword"/></label>
						<div class="col-sm-8">
							<input type="password" class="form-control" style="width:260px;" name="newpass" id="newpass" placeholder="<fmt:message key="user.newPassword.palceholder" />"><span id="newpassTip" style="display:none;color:red;"></span>
						</div>
						<div class="col-sm-1"></div>
					</div>
					<div class="form-group">
						<label for="newpassAgain" class="col-sm-3 control-label"><fmt:message key="user.confirmPassword"/></label>
						<div class="col-sm-8">
							<input type="password" class="form-control" style="width:260px;" name="newpassAgain" id="newpassAgain" placeholder="<fmt:message key="user.confirmPassword.palceholder" />"><span id="newpassAgainTip" style="display:none;color:red;"></span>
						</div>
						<div class="col-sm-1"></div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" onclick="logout()"><fmt:message key="close"/></button>
						<button type="button" class="btn btn-primary" onclick="saveUpdate()"><fmt:message key="submit"/></button>
					</div>							
				</form>						
			</div>
		</div>
	</div>


</body>
</html>


 
 
 
 
