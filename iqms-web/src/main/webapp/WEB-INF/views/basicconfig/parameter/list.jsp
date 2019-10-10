<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<sec:authentication property="principal" var="currentUser" />
<!DOCTYPE html>
<html>

<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<meta charset="utf-8" />
<title>参数配置</title>

<meta name="description"
	content="Dynamic tables and grids using jqGrid plugin" />
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0" />

<%@ include file="/WEB-INF/views/shared/bootstrapcontentui.jsp"%>

<%@ include file="/WEB-INF/views/shared/selectOrg.jsp"%>
<link rel="stylesheet"
	href="${staticPath}/static/components/zTree/css/demo.css"
	type="text/css">
<link rel="stylesheet"
	href="${staticPath}/static/components/zTree/css/zTreeStyle/zTreeStyle.css"
	type="text/css">

<script src="${staticPath}/static/components/fuelux/js/spinbox.js"></script>
<script src="${staticPath}/static/components/jquery-validation/dist/jquery.validate.js"></script>
<script src="${staticPath}/static/components/jquery-validation/dist/additional-methods.js"></script>
<script src="${staticPath}/static/components/jquery-validation/dist/localization/messages_zh.js"></script>
<script
	src="${staticPath}/static/components/assets/js/src/elements.spinner.js"></script>
<script src="${staticPath}/static/js/basicconfig/parameter/list.js"></script>

</head>

<body class="no-skin">


	<div class="main-container ace-save-state" id="main-container">
		<!-- /section:basics/sidebar -->
		<div class="main-content">
			<div class="main-content-inner" id="main">
				<div id="dialog-new" class="hide">确定要保存吗？</div>
				<!-- /section:basics/content.breadcrumbs -->
				<form name="FormPost" class="form-horizontal" id="formPost"
					onsubmit="return false;" style="width: auto; height: auto;">
					<div class="page-content">
						<div class="widget-body">
							<div class="widget-main">
								<div class="form-group">
									<label for="hb_Interval" class="col-md-2">心跳间隔：</label> <input
										type="text" id="hbInterval" name="hbInterval"
										readonly="readonly">分钟</input>
									<div class="space-6"></div>
								</div>
								<div class="form-group">
									<label for="form-field-select-1" class="col-md-2">鉴权模式：</label>

									<select class="col-sm-2" id="authenticationType"
										name="authenticationType">
										<!-- <option value=""></option>
								<option value=""></option>
								<option value=""></option>
								<option value=""></option> -->
									</select>
								</div>

								<div class="space-6"></div>
								<div class="form-group">
									<label class="col-md-2" for="flowPort"> 流水上报端口： </label>
										<div class="clearfix">
										<input type="text" id="flowPort" name="flowPort"
											placeholder="流水上报端口" class="col-sm-2" />
											</div>
								</div>

								<div class="space-6"></div>
								<div class="form-group">
									<label class="col-md-2" for="identPort"> 客户识别端口 ：</label>
										<div class="clearfix">
										<input type="text" id="identPort" name="identPort"
											placeholder="客户识别端口" class="col-sm-2" />
											</div>
								</div>
								<div class="space-6"></div>
								<div class="form-group">
									<label class="col-md-2" for="httpPort"> 服务端http端口： </label>
										<div class="clearfix">
										<input type="text" id="httpPort" name="httpPort"
											placeholder="服务端http端口" class="col-sm-2" />
											</div>
								</div>
								<div class="space-6"></div>
								<div class="form-group">
									<label class="col-md-2" for="appRoot"> 工程名称：</label>
										<div class="clearfix">
										<input type="text" id="appRoot" name="appRoot"
											placeholder="工程名称" class="col-sm-2" />
											</div>
								</div>

								<div class="space-6"></div>
								<div class="space-6"></div>
								<div class="space-6"></div>
								<div class="space-6"></div>
								<div class="space-6"></div>
								<div class="space-6"></div>
								<div class="col-md-3 col-md-offset-1">
									<button type="button" class="btn btn-white btn-info btn-bold"
										onclick="newParameter()">
										保存 <i class="ace-icon fa fa-floppy-o bigger-120 blue"></i>
									</button>
								</div>

							</div>
						</div>
					</div>
					<!-- /.page-content -->

					<!-- page-foot start -->
					<!-- page-foot end -->

				</form>

			</div>

		</div>
		<!-- /.main-content -->
	</div>
</body>

</html>