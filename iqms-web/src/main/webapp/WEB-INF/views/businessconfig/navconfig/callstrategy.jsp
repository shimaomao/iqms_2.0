<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<sec:authentication property="principal" var="currentUser" />
<!DOCTYPE>
<html lang="en">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<meta charset="utf-8">
<title>叫号策略</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description"
	content="Charisma, a fully featured, responsive, HTML5, Bootstrap admin template.">

<%@ include file="/WEB-INF/views/shared/bootstrapcontentui.jsp"%>
<%@ include file="/WEB-INF/views/shared/selectOrg.jsp"%>
<link id="bs-css"
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
<link href='${staticPath}/static/components/ticket/css/uploadify.css'
	rel='stylesheet'>
<link
	href="${staticPath}/static/components/ticket/css/bootstrap-multiselect.css"
	rel="stylesheet" />
<link href="${staticPath}/static/components/ticket/images/favicon.ico"
	rel="shortcut icon">


<%-- <script src="${staticPath}/static/components/ticket/js/lib/jquery/jquery.js"></script> --%>
<script
	src="${staticPath}/static/components/ticket/js/lib/jquery/plugins/jquery.string.js"></script>
<script
	src="${staticPath}/static/components/ticket/js/lib/jquery/plugins/jquery.json.js"></script>
<script
	src="${staticPath}/static/components/ticket/js/lib/easyui/plugins/jquery.draggable.js"></script>
<script
	src="${staticPath}/static/components/ticket/js/lib/easyui/plugins/jquery.parser.js"></script>
<script src="${staticPath}/static/components/ticket/js/config.js"></script>
<script
	src="${staticPath}/static/components/ticket/js/jquery.metadata.js"></script>
<script
	src="${staticPath}/static/components/ticket/js/jquery.validate.js"></script>
<script src="${staticPath}/static/components/ticket/js/lib/jquery/plugins/jquery.string.js"></script>
<script src="${staticPath}/static/components/ticket/js/qmsVld.js"></script>
<%-- <script src="${staticPath}/static/js/businessconfig/navconfig/redirect.js"></script> --%>

</head>
<body>

	<div class="ch-container">
		<div class="row">
			<noscript>
				<div class="alert alert-block col-md-12">
					<h4 class="alert-heading">Warning!</h4>
				</div>
			</noscript>

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
						<div class="widget-body" style="margin-top: 10px;"
							style="display: block;">
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

											<li data-step="7" class="complete" onclick="redirect(this)"><span class="step">7</span>
												<span class="title">客户等级</span></li>

											<li data-step="8" class="complete" onclick="redirect(this)"><span class="step">8</span>
												<span class="title">客户识别</span></li>

											<li data-step="9" class="active"><span class="step">9</span> <span
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
										<div class="step-pane active" data-step="8">
											<h3 class="lighter block green">叫号策略</h3>
											<div class="row" id="ticketEdit">
												<div class="box col-md-3">
													<div class="box-inner">
														<div class="box-header well" data-original-title="">
															<h2>
																<i class="glyphicon glyphicon-info-sign"></i>窗口列表
															</h2>
															<div class="box-icon">
																<a href="#"
																	class="btn btn-minimize btn-round btn-default"><i
																	class="glyphicon glyphicon-chevron-up"></i></a>
															</div>
														</div>
														<div class="box-content">
															<ul class="nav nav-pills nav-stacked main-menu"
																id="counterList">
															</ul>
														</div>
													</div>
												</div>
												<!--/span-->
												<form id="frm">
													<div class="box col-md-9" style="margin-top: 0px;">
														<div class="row">
															<div class="box col-md-12">
																<div class="box-inner">
																	<div class="box-header well" data-original-title="">
																		<h2>
																			<i class="glyphicon glyphicon-info-sign"></i>窗口信息
																		</h2>
																		<div class="box-icon">
																			<a href="#"
																				class="btn btn-minimize btn-round btn-default"><i
																				class="glyphicon glyphicon-chevron-up"></i></a>
																		</div>
																	</div>
																	<div class="box-content">
																		<table>
																			<tbody>
																				<tr>
																					<td style="text-align: right; width: 100px;">窗口<span
																						class="star">*</span>
																					</td>
																					<td>
																						<div class="controls">
																							<select id="myWinNum" validate="{required:true}"
																								name="multiselect[]" multiple="multiple">
																							</select>
																						</div> <input type="hidden" name="orgId" id="orgId"
																						value="${orgId}" /> <input type="hidden"
																						name="deviceNo" id="deviceNo" value="${deviceNo}" />
																						<%-- <input type="hidden" name="devName" id="devName"
																						value="${devName}" /> <input type="hidden"
																						name="orgName" id="orgName" value="${orgName}" /> --%>
																					</td>
																				</tr>
																			</tbody>
																		</table>
																	</div>
																</div>
															</div>
														</div>
														<div class="row">
															<div class="box col-md-12">
																<div class="box-inner">
																	<div class="box-header well" data-original-title="">
																		<h2>
																			<i class="glyphicon glyphicon-info-sign"></i> 平日
																		</h2>
																		<div class="box-icon">
																			<a href="#"
																				class="btn btn-minimize btn-round btn-default"><i
																				class="glyphicon glyphicon-chevron-up"></i></a>
																		</div>
																	</div>
																	<div class="box-content">
																		<table class="table table-striped table-bordered"
																			id="prList">
																			<thead>
																				<tr>
																					<th style="width: 10%;"><input type="checkbox"
																						id="checkbox1"></th>
																					<th style="width: 20%;">业务代码</th>
																					<th style="width: 25%;">业务名称</th>
																					<th style="width: 25%;">优先时间（分钟）<span
																						class="star">*</span>
																					</th>
																					<th style="width: 20%;">操作</th>
																				</tr>
																			</thead>
																			<tbody>&nbsp;
																			</tbody>
																		</table>
																	</div>
																</div>
															</div>
														</div>
														<div class="row">
															<div class="box col-md-12">
																<div class="box-inner">
																	<div class="box-header well" data-original-title="">
																		<h2>
																			<i class="glyphicon glyphicon-info-sign"></i>假日
																		</h2>
																		<div class="box-icon">
																			<a href="#"
																				class="btn btn-minimize btn-round btn-default"><i
																				class="glyphicon glyphicon-chevron-up"></i></a>
																		</div>
																	</div>
																	<div class="box-content">
																		<table class="table table-striped table-bordered"
																			id="jrList">
																			<thead>
																				<tr>
																					<th style="width: 10%;"><input type="checkbox"
																						id="checkbox2"></th>
																					<th style="width: 20%;">业务代码</th>
																					<th style="width: 25%;">业务名称</th>
																					<th style="width: 25%;">优先时间（分钟）<span
																						class="star">*</span>
																					</th>
																					<th style="width: 20%;">操作</th>
																				</tr>
																			</thead>
																			<tbody>&nbsp;
																			</tbody>
																		</table>
																	</div>
																</div>
															</div>
														</div>
														<div style="padding: 0px; margin-top: 20px; margin-right: auto; margin-left: auto; width: 310px; border: 0px #056498 solid;">
															<p class="center">
																<button class="btn btn-success btn-prev" id="prev" type="button" onclick="back()">
																	<i class="ace-icon fa fa-arrow-left"></i> 上一步
																</button>
																<input type="submit" id="saveConfig" class="btn btn-info" value="保存配置" />
																<button class="btn btn-success btn-next" data-last="Finish" type="button" id="next" onclick="nextStep()">
																	下一步 <i class="ace-icon fa fa-arrow-right icon-on-right"></i>
																</button>
															</p>
														</div>
													</div>
												</form>
											</div>
										</div>
									</div>

									<!-- /section:plugins/fuelux.wizard.container -->
								</div>
								<!-- /section:plugins/fuelux.wizard -->
							</div>
						</div>
					</div>
				</div>
			</div>
			<div id="content" class="col-lg-12 col-sm-12"></div>
		</div>

		<!-- 打开后的模态框 -->
		<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
			aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<form id="frmModal">
					<div class="modal-content">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal">
								X</button>
							<h3 id="modalTitle">平日个人业务等级设置</h3>
						</div>
						<div class="modal-body">
							<div class="box-content">
								<table class="table table-striped table-bordered" id="djList">
									<thead>
										<tr>
											<th style="width: 10%;"><input type="checkbox"
												id="checkboxModal"></th>
											<th style="width: 20%;">客户等级</th>
											<th style="width: 30%;">等级名称</th>
											<th style="width: 20%;">优先时间<br> (分钟)<span
												class="star">*</span>
											</th>
											<th style="width: 20%;">最大等待时间<br> (分钟)<span
												class="star">*</span>
											</th>
										</tr>
									</thead>
									<tbody>&nbsp;
									</tbody>
								</table>
							</div>
						</div>
						<div class="modal-footer">
							<input type="button" class="btn btn-default" data-dismiss="modal"
								value="取消"> <input type="submit" class="btn btn-primary"
								value="确定">
						</div>
					</div>
					<form>
			</div>
		</div>

	</div>

	<script
		src="${staticPath}/static/components/ticket/js/bootstrap.min.js"></script>
	<script
		src="${staticPath}/static/components/ticket/js/bootstrap-multiselect.js"></script>
	<script
		src="${staticPath}/static/components/ticket/js/jquery.cookie.js"></script>
	<script
		src='${staticPath}/static/components/ticket/js/jquery.dataTables.min.js'></script>
	<script
		src="${staticPath}/static/components/ticket/js/chosen.jquery.min.js"></script>
	<script
		src="${staticPath}/static/components/ticket/js/jquery.colorbox-min.js"></script>
	<script src="${staticPath}/static/components/ticket/js/jquery.noty.js"></script>
	<script
		src="${staticPath}/static/components/ticket/js/responsive-tables.js"></script>
	<script
		src="${staticPath}/static/components/ticket/js/bootstrap-tour.min.js"></script>
	<script
		src="${staticPath}/static/components/ticket/js/jquery.raty.min.js"></script>
	<script
		src="${staticPath}/static/components/ticket/js/jquery.iphone.toggle.js"></script>
	<script
		src="${staticPath}/static/components/ticket/js/jquery.autogrow-textarea.js"></script>
	<script
		src="${staticPath}/static/components/ticket/js/jquery.uploadify-3.1.min.js"></script>
	<script
		src="${staticPath}/static/components/ticket/js/jquery.history.js"></script>

	<script
		src="${staticPath}/static/js/businessconfig/navconfig/callstrategy.js"></script>

</body>
</html>
