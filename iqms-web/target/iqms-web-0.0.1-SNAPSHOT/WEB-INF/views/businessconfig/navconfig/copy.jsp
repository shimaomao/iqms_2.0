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
<title>导航配置</title>

<meta name="description"
	content="Dynamic tables and grids using jqGrid plugin" />
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0" />
<link
	href="${staticPath}/static/components/ticket/css/bootstrap-11.min.css"
	rel="stylesheet">
<%@ include file="/WEB-INF/views/shared/bootstrapcontentui.jsp"%>
<%@ include file="/WEB-INF/views/shared/selectOrg.jsp"%>
<script src="${staticPath}/static/components/fuelux/js/wizard.js"></script>
<script src="${staticPath}/static/components/select2/dist/js/select2.js"></script>
<script
	src="${staticPath}/static/components/assets/js/src/elements.wizard.js"></script>
<script src="${staticPath}/static/components/assets/js/src/elements.aside.js"></script>
<script src="${staticPath}/static/components/ticket/js/lib/jquery/plugins/jquery.string.js"></script>
<script src="${staticPath}/static/js/businessconfig/navconfig/copy.js"></script>
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
								<!-- widget 导航部分 -->
								<div class="widget-body">
									<div class="widget-main">
										<!-- #section:plugins/fuelux.wizard -->
										<div id="fuelux-wizard-container">
											<div>
												<!-- #section:plugins/fuelux.wizard.steps -->
												<ul class="steps">
													<li data-step="1" class="complete" onclick="redirect(this)"><span class="step">1</span>
														<span class="title" >创建设备</span></li>

													<li data-step="2" class="active"><span class="step">2</span>
														<span class="title">快速应用</span></li>

													<li data-step="3" onclick="test(this)"><span class="step">3</span>
														<span class="title">窗口配置</span></li>

													<li data-step="4"><span class="step">4</span>
														<span class="title">网点业务</span></li>

													<li data-step="6"><span class="step">5</span>
														<span class="title">业务显示</span></li>
													
													<li data-step="5"><span class="step">6</span>
														<span class="title">号票模板</span></li>

													<li data-step="7"><span class="step">7</span>
														<span class="title">客户等级</span></li>

													<li data-step="8"><span class="step">8</span>
														<span class="title">客户识别</span></li>

													<li data-step="9"><span class="step">9</span>
														<span class="title">叫号策略</span></li>

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
												<div class="step-pane active" data-step="2">
													<h3 class="lighter block green">快速应用</h3>

													<form class="form-horizontal" id="sample-form">
														<!-- #section:elements.form.input-state -->
														<div class="form-group">
															<label
																class="control-label col-xs-12 col-sm-3 no-padding-right"
																for="devName">选择设备</label>
															<div class="col-xs-12 col-sm-9">
																<div class="clearfix">
																	<input type="text" placeholder="" value="" class="nav-search-input"
																	name="devName" id="devName" autocomplete="off"
																	onclick="orgDeviceTree(${currentUser.orgId})"/>
																	<input type="hidden" name="orgId" id="orgId" value="${orgId}" />  
																	<input type="hidden" name="deviceNo" id="deviceNo" value="${deviceNo}" />
																	<input type="hidden" name="orgDevicelist" id="orgDevicelist" value="" />
																	<%-- <input type="hidden" name="deviceName" id="deviceName" value="${devName}" /> 
																	<input type="hidden" name="orgName" id="orgName" value="${orgName}" /> --%> 
																</div>
															</div>
														</div>
														<div class="form-group">
															<label
																class="control-label col-xs-12 col-sm-8 no-padding-right"
																for="ps" style="color:red;">可选择已经配置好的设备,点击确定将所有配置都应用到创建的设备上,也可直接下一步跳过该步骤</label>
														</div>
													</form>
												</div>

											</div>

											<!-- /section:plugins/fuelux.wizard.container -->
										</div>

										<hr />
										<div class="wizard-actions">
											<p class="center" style="margin-top: 30px;">
											<!-- #section:plugins/fuelux.wizard.buttons -->
											<button class="btn btn-success btn-prev" id = "prev" onclick="back()">
												<i class="ace-icon fa fa-arrow-left"></i> 上一步
											</button>

											<button class="btn btn-success btn-next" data-last="Finish" id = "next" onclick="next()">
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