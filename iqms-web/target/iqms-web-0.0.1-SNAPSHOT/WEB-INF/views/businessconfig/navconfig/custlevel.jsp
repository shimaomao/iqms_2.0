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
<title>客户等级</title>

<meta name="description"
	content="Dynamic tables and grids using jqGrid plugin" />
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0" />

<%@ include file="/WEB-INF/views/shared/selectOrg.jsp"%>
<link
	href="${staticPath}/static/components/ticket/css/bootstrap-11.min.css"
	rel="stylesheet">
<link href="${staticPath}/static/components/ticket/css/charisma-app.css"
	rel="stylesheet">
<link href='${staticPath}/static/components/ticket/css/chosen.min.css'
	rel='stylesheet'>
<link href='${staticPath}/static/components/ticket/css/colorbox.css'
	rel='stylesheet'>
<link
	href='${staticPath}/static/components/ticket/css/responsive-tables.css'
	rel='stylesheet'>
<link
	href='${staticPath}/static/components/ticket/css/bootstrap-tour.min.css'
	rel='stylesheet'>
<link href='${staticPath}/static/components/ticket/css/jquery.noty.css'
	rel='stylesheet'>
<link
	href='${staticPath}/static/components/ticket/css/noty_theme_default.css'
	rel='stylesheet'>
<link href='${staticPath}/static/components/ticket/css/elfinder.min.css'
	rel='stylesheet'>
<link
	href='${staticPath}/static/components/ticket/css/elfinder.theme.css'
	rel='stylesheet'>
<link
	href='${staticPath}/static/components/ticket/css/jquery.iphone.toggle.css'
	rel='stylesheet'>
<link href='${staticPath}/static/components/ticket/css/animate.min.css'
	rel='stylesheet'>
<link href="${staticPath}/static/components/ticket/images/favicon.ico"
	rel="shortcut icon">
<script src="${staticPath}/static/components/ticket/js/config.js"></script>
<script src="${staticPath}/static/components/ticket/js/peripheral.js"></script>
<script
	src="${staticPath}/static/components/ticket/js/bootstrap-datetimepicker.js"></script>
<script src="${staticPath}/static/components/ticket/js/qmsVld.js"></script>
<script src="${staticPath}/static/components/ticket/js/jquery.noty.js"></script>
<script src="${staticPath}/static/components/ticket/js/lib/jquery/plugins/jquery.string.js"></script>
<script src="${staticPath}/static/js/businessconfig/navconfig/custlevel.js"></script>
<%-- <script src="${staticPath}/static/js/businessconfig/navconfig/redirect.js"></script> --%>
</head>

<body class="no-skin">
	<div class="main-container ace-save-state" id="main-container">
		<!-- /section:basics/sidebar -->
		<div class="main-content">
			<div class="main-content-inner">

				<!-- /section:basics/content.breadcrumbs -->
				<div class="page-content">

					<!--widget搜索条件 start-->
					<div class="row">
						<div class="col-lg-12 col-sm-12 col-xs-12">
							<div class="widget-box transparent ui-sortable-handle"
								id="widget-box-12">
								<div class="widget-header">

									<h4 class="widget-title ">
										<i
											class="ace-icon fa fa-hand-o-right icon-animated-hand-pointer blue"></i>
										配置向导
									</h4>
									<div class="widget-toolbar no-border">
										<a href="#" data-action="collapse"> <i
											class="ace-icon fa fa-chevron-up bigger-160 blue"></i>
										</a>
									</div>
								</div>
								<!-- widget 主体查询部分 -->
								<div class="widget-body">
									<div class="widget-main">
										<!-- #section:plugins/fuelux.wizard -->
										<div id="fuelux-wizard-container">
											<div>
												<!-- #section:plugins/fuelux.wizard.steps -->
												<ul class="steps">
													<li data-step="1" class="complete" onclick="redirect(this)"><span class="step">1</span>
														<span class="title">创建设备</span></li>

													<li data-step="2" class="complete" onclick="redirect(this)"><span class="step">2</span>
														<span class="title">快速应用</span></li>

													<li data-step="3" class="complete" onclick="redirect(this)"><span class="step">3</span>
														<span class="title">窗口配置</span></li>

													<li data-step="4" class="complete" onclick="redirect(this)"><span class="step">4</span>
														<span class="title">网点业务</span></li>

													<li data-step="5" class="complete" onclick="redirect(this)"><span class="step">5</span>
														<span class="title">业务显示</span></li>

													<li data-step="6" class="complete" onclick="redirect(this)"><span class="step">6</span>
														<span class="title">号票模板</span></li>

													<li data-step="7" class="active"><span class="step">7</span> <span
														class="title">客户等级</span></li>

													<li data-step="8"><span class="step">8</span> <span
														class="title">客户识别</span></li>

													<li data-step="9"><span class="step">9</span> <span
														class="title">叫号策略</span></li>

													<li data-step="10"><span class="step">10</span>
														<span class="title">取号界面</span></li>

													<li data-step="11"><span class="step">11</span> <span
														class="title">配置检测</span></li>
												</ul>

												<!-- /section:plugins/fuelux.wizard.steps -->
											</div>

											<hr />

											<!-- #section:plugins/fuelux.wizard.container -->
											<div class="step-content pos-rel" id="step">
												<div class="step-pane active" data-step="6">
													<h3 class="lighter block green">客户等级</h3>
													<div class="row" id="ticketList">
														<div class="box col-md-12">
															<div class="box-inner">
																<div class="box-header well" data-original-title="">
																	<h2>
																		<i class="glyphicon glyphicon-info-sign"></i>客户等级设置
																	</h2>
																	<div class="box-icon">
																		<a href="#"
																			class="btn btn-minimize btn-round btn-default"><i
																			class="glyphicon glyphicon-chevron-up"></i></a>
																	</div>
																</div>
																<div class="box-content">
																	<form id="frm">
																		<table class="table table-striped table-bordered "
																			id="ccc">
																			<thead>
																				<tr>
																					<th style="width: 5%;">级别</th>
																					<th style="width: 17%;">名称<span class="star">*</span>
																					</th>
																					<th style="width: 17%;">绑定业务</th>
																					<th style="width: 10%;">优先时间</th>
																					<th style="width: 10%;">呼叫字头<span class="star">*</span>
																					</th>
																					<th style="width: 10%;">最大等候时间</th>
																					<th style="width: 17%;">号票模板</th>
																					<th style="width: 8%;">启用</th>
																				</tr>
																			</thead>
																			<tbody id="tbody">
																				<input type="hidden" name="orgId" id="orgId"
																					value="${orgId}" />
																				<input type="hidden" name="deviceNo" id="deviceNo"
																					value="${deviceNo}" />
																				<%-- <input type="hidden" name="devName" id="devName"
																					value="${devName}" />
																				<input type="hidden" name="orgName" id="orgName"
																					value="${orgName}" /> --%>
																			</tbody>
																		</table>
																		<!-- <p class="center">
																			<input type="submit" class="btn btn-primary"
																				id="saveConfig" value="保存配置">
																		</p> -->
																	</form>
																</div>
															</div>
														</div>
														<!--/span-->
													</div>
												</div>
											</div>

											<!-- /section:plugins/fuelux.wizard.container -->
										</div>

										<hr />
										<div class="wizard-actions">
											<!-- #section:plugins/fuelux.wizard.buttons -->
											<p class="center" style="margin-top: 30px;">
											<button class="btn btn-success btn-prev" id="prev" onclick="back()">
												<i class="ace-icon fa fa-arrow-left"></i> 上一步
											</button>

											<button class="btn btn-success btn-next" data-last="Finish"
												id="next" onclick="next()">
												下一步 <i class="ace-icon fa fa-arrow-right icon-on-right"></i>
											</button>
											</p>
											<!-- /section:plugins/fuelux.wizard.buttons -->
										</div>

										<!-- /section:plugins/fuelux.wizard -->
									</div>
									<!-- /.widget-main -->
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>

		</div>
		<!-- /.main-content -->
	</div>

</body>

</html>