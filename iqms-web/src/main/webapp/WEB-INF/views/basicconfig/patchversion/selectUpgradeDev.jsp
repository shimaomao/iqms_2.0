<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<sec:authentication property="principal" var="currentUser" />
<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
		<meta charset="utf-8" />
		<title>升级设备</title>

		<meta name="description" content="Dynamic tables and grids using jqGrid plugin" />
		<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0" />

		<%@ include file="/WEB-INF/views/shared/bootstrapcontentui.jsp"%>
		
		<link rel="stylesheet" href="${staticPath}/static/components/zTree/css/metroStyle/metroStyle.css" type="text/css">
		<script type="text/javascript" src="${staticPath}/static/components/zTree/js/jquery.ztree.core.js"></script>
	    <script type="text/javascript" src="${staticPath}/static/components/zTree/js/jquery.ztree.excheck.js"></script>
	    <script type="text/javascript" src="${staticPath}/static/components/zTree/js/jquery.ztree.exedit.js"></script>
	    <script type="text/javascript" src="${staticPath}/static/js/basicconfig/patchversion/chooseUpgradeDevTree.js"></script>

	</head>

	<body class="no-skin">
		<!--模态窗口页面内容这里是一个表单-->
		<div id="dialog-devtree" class="hide">
			<div class="widget-body">
					<ul id="devUpgradeTree"  class="ztree" style="width: 350px;height: 250px"></ul>
			</div>
			
		</div>
		<!-- #dialog-message -->

	</body>

</html>