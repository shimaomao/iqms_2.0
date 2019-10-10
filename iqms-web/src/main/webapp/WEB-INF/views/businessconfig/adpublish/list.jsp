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
<title>广告发布</title>

<meta name="description"
	content="Dynamic tables and grids using jqGrid plugin" />
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0" />
<%@ include file="/WEB-INF/views/shared/selectOrg.jsp"%>
<link href="${staticPath}/static/components/ticket/css/bootstrap-11.min.css" rel="stylesheet">
<link href="${staticPath}/static/components/ticket/css/charisma-app.css" rel="stylesheet">
<link href='${staticPath}/static/components/ticket/css/chosen.min.css' rel='stylesheet'>
<link href='${staticPath}/static/components/ticket/css/colorbox.css' rel='stylesheet'>
<link href='${staticPath}/static/components/ticket/css/responsive-tables.css' rel='stylesheet'>
<link href='${staticPath}/static/components/ticket/css/bootstrap-tour.min.css' rel='stylesheet'>
<link href='${staticPath}/static/components/ticket/css/jquery.noty.css' rel='stylesheet'>
<link href='${staticPath}/static/components/ticket/css/noty_theme_default.css' rel='stylesheet'>
<link href='${staticPath}/static/components/ticket/css/elfinder.min.css' rel='stylesheet'>
<link href='${staticPath}/static/components/ticket/css/elfinder.theme.css' rel='stylesheet'>
<link href='${staticPath}/static/components/ticket/css/jquery.iphone.toggle.css' rel='stylesheet'>
<link href='${staticPath}/static/components/ticket/css/animate.min.css' rel='stylesheet'>
<link href="${staticPath}/static/components/ticket/images/favicon.ico" rel="shortcut icon">
<link rel="stylesheet" href="${staticPath}/static/components/_mod/jquery-ui/jquery-ui.min.css" />
<script src="${staticPath}/static/components/ticket/js/config.js"></script>
<script src="${staticPath}/static/components/ticket/js/peripheral.js"></script>
<script src="${staticPath}/static/components/ticket/js/bootstrap-datetimepicker.js"></script>
<script src="${staticPath}/static/components/ticket/js/qmsVld.js"></script>
<script src="${staticPath}/static/components/ticket/js/jquery.noty.js"></script>
<!-- jquery验证框架 -->
<script src="${staticPath}/static/components/jquery-validation/dist/jquery.validate.js"></script>
<script src="${staticPath}/static/components/jquery-validation/dist/additional-methods.js"></script>
<script src="${staticPath}/static/components/jquery-validation/dist/localization/messages_zh.js"></script>

<script src="${staticPath}/static/js/businessconfig/adpublish/list.js"></script>
</head>

<body class="no-skin">

	<!-- 引入增改查页面 -->

	<div class="main-container ace-save-state" id="main-container">
		<!-- /section:basics/sidebar -->
		<div class="main-content">
			<div class="main-content-inner">
				<div class="page-content">
					<!--widget搜索条件 start-->
					<div class="row">
						<div class="col-lg-12 col-sm-12 col-xs-12">
							<div class="widget-box transparent ui-sortable-handle"
								id="widget-box-12">
								<div class="widget-header">

									<h4 class="widget-title ">
										<i class="ace-icon fa fa-search"></i> 条件查询
									</h4>

									<div class="widget-toolbar no-border">
										<a href="#" data-action="collapse"> <i
											class="ace-icon fa fa-chevron-up bigger-160 blue"></i>
										</a>
									</div>
								</div>
								<!-- widget 主体查询部分 -->
								<div class="widget-body" style="margin-top: 10px;"
									style="display: block;">
									<form class="form-search form-inline" id="searchFrom">
										<div class="form-group">
											<label>选择设备：</label> <span class="input-icon"> <input
												type="text" placeholder="" value="" class="nav-search-input"
												name="devName" id="devName" autocomplete="off"
												onclick="selectOrgDeviceTree(${currentUser.orgId},true,false,false,searchCondition)" />
												<input type="hidden" name="orgId" id="orgId" value="" />
												<input type="hidden" name="deviceNo" id="deviceNo" value="" />
												<input type="hidden" name="ip" id="ip" value="" />
											</span>
										</div>

										<!-- <div class="form-group">
												<button type="button"
													class="btn btn-white btn-info btn-bold"
													onclick="searchCondition();">
													<i
														class="ace-icon fa fa-search icon-on-right bigger-100 blue"></i>
													查询
												</button> <br />
										</div> -->
									</form>
								</div>
							</div>
						</div>
					</div>
					<!-- widget 条件搜索 end -->

					<!-- 空行 -->
					<div class="space-6"></div>
							
					<form name="FormPost" id="FormPost" class="form-horizontal" onsubmit="return false;" style="width:auto;height:auto;">
						<div class="row">
							<div class="box col-md-12 ">
								<div class="box-inner">
									<div class="box-header well" data-original-title="">
										<h2>
											<i class="glyphicon glyphicon-info-sign"></i>广告类型
										</h2>
									</div>
									
									<div class="box-content" style="display: none" id="AdType">
										<!-- <div class="form-group">
											<label class="col-md-2 control-label no-padding-right" for="acdAds" 
											style="margin-top: 20px;">排队机界面广告：
											</label>

											<textarea class="col-md-6" style="resize:none;vertical-align:middle;height:80px;" id="acdAds" name="acdAds" /></textarea>
											
											<p class="col-md-4" style="margin-top: 20px;">
												<input type="button" class="btn btn-primary" id="SaveAcdAds"  value="保存并发送">
											</p>
										</div> -->
										
										<div class="form-group">
												<label class="col-md-2 control-label no-padding-right" for="compositeAds" 
												style="margin-top: 20px;">综合屏广告：
												</label>
	
												<textarea class="col-md-6" style="resize:none;vertical-align:middle;height:80px;" id="compositeAds" name="compositeAds" /></textarea>
												
												<p class="col-md-4" style="margin-top: 20px;">
													<input type="button" class="btn btn-primary" id="SaveCompositeAds"  value="保存并发送">
												</p>
										</div>
										
										<div class="form-group">
												<label class="col-md-2 control-label no-padding-right" for="screenAds" 
												style="margin-top: 20px;">条屏广告：
												</label>
	
												<textarea class="col-md-6" style="resize:none;vertical-align:middle;height:80px;" id="screenAds" name="screenAds" /></textarea>
												
												<p class="col-md-4" style="margin-top: 20px;">
													<input type="button" class="btn btn-primary" id="SaveScreenAds"  value="保存并发送">
												</p>
										</div>
										
										<!-- <div class="form-group">
												<label class="col-md-2 control-label no-padding-right" for="formAds" 
												style="margin-top: 20px;">号票广告：
												</label>
	
												<textarea class="col-md-6" style="resize:none;vertical-align:middle;height:80px;" id="formAds" name="formAds" /></textarea>
												
												<p class="col-md-4" style="margin-top: 20px;">
													<input type="button" class="btn btn-primary" id="SaveFormAds"  value="保存并发送">
												</p>
										</div> -->
							   </div>
							</div>
						</div>
						
					</form>
				</div>
			</div>
		</div>
	</div>

</body>

</html>