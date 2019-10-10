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
<script
	src="${staticPath}/static/components/assets/js/src/elements.aside.js"></script>
<script src="${staticPath}/static/components/ticket/js/lib/jquery/plugins/jquery.string.js"></script>
<script src="${staticPath}/static/js/businessconfig/navconfig/device.js"></script>
<%-- <script src="${staticPath}/static/js/businessconfig/navconfig/redirect.js"></script> --%>
</head>
<script type="text/javascript">

  //控制层返回过来的信息
  var norgId = '${orgId}';
  var ndeviceNo = '${deviceNo}';
  var nhostName = '${hostName}';
  var nipAddr = '${ipAddr}';
  var nmacAddr = '${macAddr}';
  var nproducer = '${producer}';
  var nscreenResolution = '${screenResolution}';
  var ninstallDate = '${installDate}';
  var nadminName = '${adminName}';
  var nadminPhone = '${adminPhone}';
  var norderFlag = '${orderFlag}';
  var nonlineModel = '${onlineModel}';
  var ntpscrollFlag = '${tpscrollFlag}';
  var ntpscrollFlag = '${tpscrollFlag}';
  var norgName = '${orgName}';
</script>
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
													<li data-step="1" class="active"><span class="step">1</span>
														<span class="title">创建设备</span></li>

													<li data-step="2"><span class="step">2</span>
														<span class="title">快速应用</span></li>

													<li data-step="3"><span class="step">3</span>
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
												<div class="step-pane active" data-step="1">
													<h3 class="lighter block green">创建设备</h3>

													<form class="form-horizontal" id="sample-form">
														<!-- #section:elements.form.input-state -->
														<div class="form-group">
															<label
																class="control-label col-xs-12 col-sm-3 no-padding-right"
																for="orgName"> 所属机构 </label>
															<div class="col-xs-12 col-sm-9">
																<div class="clearfix">
																	<input type="text" id="orgName" name="orgName"
																		placeholder="选中机构" value="${currentUser.orgName}"
																		onclick="selectOrgTree(this,true,fillDevNo);"
																		class="col-xs-12 col-sm-6" /><input type="hidden"
																		name="orgId" id="orgId" value="${currentUser.orgId}" />
																	 <%-- <input type="hidden" name="org_name" id="org_name"
																		value="${orgName}" /> <input type="hidden"
																		name="org_id" id="org_id" value="${orgId}" /> <input
																		type="hidden" name="devName" id="devName"
																		value="${devName}" /> --%>
																</div>
															</div>
														</div>

														<!-- /section:elements.form.input-state -->
														<div class="form-group">
															<label class="col-md-3 control-label no-padding-right"
																for="deviceNo"> 设备编号 </label>

															<div class="col-xs-12 col-sm-9">
																<div class="clearfix">
																	<input type="text" id="deviceNo" name="deviceNo"
																		readonly="readonly" placeholder="点击自动生成"
																		onclick="fillDevNo();" class="col-xs-12 col-sm-6" /><%--  <input
																		type="hidden" name="devNo" id="devNo"
																		value="${deviceNo}" /> --%>
																</div>
															</div>
														</div>

														<!-- /section:elements.form -->
														<div class="space-4"></div>
														<div class="form-group">
															<label class="col-md-3 control-label no-padding-right"
																for="hostName"> 主机名称 </label>

															<div class="col-xs-12 col-sm-9">
																<div class="clearfix">
																	<input type="text" id="hostName" name="hostName"
																		placeholder="主机名称" class="col-xs-12 col-sm-6"
																		value="${hostName}" />
																</div>
															</div>
														</div>

														<div class="space-4"></div>
														<div class="form-group">
															<label class="col-md-3 control-label no-padding-right"
																for="ipAddr"> IP地址 </label>

															<div class="col-xs-12 col-sm-9">
																<div class="clearfix">
																	<input type="text" id="ipAddr" name="ipAddr"
																		placeholder="IP地址" class="col-xs-12 col-sm-6"
																		value="${ipAddr}" />
																</div>
															</div>
														</div>

														<div class="space-4"></div>
														<div class="form-group">
															<label class="col-md-3 control-label no-padding-right"
																for="screenResolution"> 分辨率 </label>

															<div class="col-xs-12 col-sm-9">
																<div class="clearfix">
																	<select id="screenResolution" name="screenResolution"
																		class="col-xs-12 col-sm-6">
																	</select> <%-- <input type="hidden" name="Resolution" id="Resolution"
																		value="${screenResolution}" /> --%>
																</div>
															</div>
														</div>

														<div class="space-4"></div>
														<div class="form-group">
															<label class="col-md-3 control-label no-padding-right"
																for="macAddr"> MAC地址 </label>

															<div class="col-xs-12 col-sm-9">
																<div class="clearfix">
																	<input type="text" id="macAddr" name="macAddr"
																		placeholder="mac地址" class="col-xs-12 col-sm-6"
																		value="${macAddr}" />
																</div>
															</div>
														</div>

														<div class="space-4"></div>
														<div class="form-group">
															<label class="col-md-3 control-label no-padding-right"
																for="producer"> 设备厂家 </label>

															<div class="col-xs-12 col-sm-9">
																<div class="clearfix">
																	<select id="producer" name="producer"
																		class="col-xs-12 col-sm-6">
																	</select> <%-- <input type="hidden" name="producerName"
																		id="producerName" value="${producer}" /> --%>
																</div>
															</div>
														</div>

														<div class="space-4"></div>
														<div class="form-group">
															<label class="col-md-3 control-label no-padding-right"
																for="installDate"> 安装日期 </label>

															<div class="col-xs-12 col-sm-9">
																<div class="clearfix">
																	<input type="text" id="installDate" name="installDate"
																		placeholder="" class="col-xs-12 col-sm-6"
																		value="${installDate}" />
																</div>
															</div>
														</div>

														<div class="space-4"></div>
														<div class="form-group">
															<label class="col-md-3 control-label no-padding-right"
																for="installDate"> 设备管理员 </label>

															<div class="col-xs-12 col-sm-9">
																<div class="clearfix">
																	<input type="text" id="adminName" name="adminName"
																		placeholder="" class="col-xs-12 col-sm-6"
																		value="${adminName}" />
																</div>
															</div>
														</div>

														<div class="space-4"></div>
														<div class="form-group">
															<label class="col-md-3 control-label no-padding-right"
																for="adminPhone"> 管理员电话 </label>

															<div class="col-xs-12 col-sm-9">
																<div class="clearfix">
																	<input type="text" id="adminPhone" name="adminPhone"
																		placeholder="" class="col-xs-12 col-sm-6"
																		value="${adminPhone}" />
																</div>
															</div>
														</div>

														<div class="space-4"></div>
														<div class="form-group">
															<label class="col-md-3 control-label no-padding-right"
																for="orderFlag"> 是否可预约 </label>

															<div class="col-xs-12 col-sm-9">
																<select name="orderFlag" id="orderFlag"
																	class="col-xs-12 col-sm-6">
																	<option value="1">是</option>
																	<option value="0">否</option>
																</select> <%-- <input type="hidden" name="order" id="order"
																	value="${orderFlag}" /> --%>
															</div>
														</div>

														<div class="space-4"></div>
														<div class="form-group">
															<label class="col-md-3 control-label no-padding-right"
																for="onlineModel">上线模式</label>

															<div class="col-xs-12 col-sm-9">
																<select name="onlineModel" id="onlineModel"
																	class="col-xs-12 col-sm-6">
																	<option value="1">联网</option>
																	<option value="0">单机</option>
																	<%-- <input type="hidden" name="online" id="online"
																	value="${onlineModel}" /> --%>
																</select>
															</div>
														</div>

														<div class="space-4"></div>
														<div class="form-group">
															<label class="col-md-3 control-label no-padding-right"
																for="tpscrollFlag">条屏显示</label>

															<div class="col-xs-12 col-sm-9">
																<select name="tpscrollFlag" id="tpscrollFlag"
																	class="col-xs-12 col-sm-6">
																	<option value="1">条屏滚动</option>
																	<option value="0">直接显示</option>
																</select> <%-- <input type="hidden" name="tpscroll" id="tpscroll"
																	value="${tpscrollFlag}" /> --%>
															</div>
														</div>
													</form>
												</div>

												<!-- <div class="step-pane" data-step="2">
													<div>
														<h3 class="lighter block green">Enter the following
															information</h3>
														<div class="alert alert-success">
															<button type="button" class="close" data-dismiss="alert">
																<i class="ace-icon fa fa-times"></i>
															</button>

															<strong> <i class="ace-icon fa fa-check"></i>
																Well done!
															</strong> You successfully read this important alert message. <br />
														</div>

														<div class="alert alert-danger">
															<button type="button" class="close" data-dismiss="alert">
																<i class="ace-icon fa fa-times"></i>
															</button>

															<strong> <i class="ace-icon fa fa-times"></i> Oh
																snap!
															</strong> Change a few things up and try submitting again. <br />
														</div>

														<div class="alert alert-warning">
															<button type="button" class="close" data-dismiss="alert">
																<i class="ace-icon fa fa-times"></i>
															</button>
															<strong>Warning!</strong> Best check yo self, you're not
															looking too good. <br />
														</div>

														<div class="alert alert-info">
															<button type="button" class="close" data-dismiss="alert">
																<i class="ace-icon fa fa-times"></i>
															</button>
															<strong>Heads up!</strong> This alert needs your
															attention, but it's not super important. <br />
														</div>
													</div>
												</div>

												<div class="step-pane" data-step="3">
													<div class="center">
														<h3 class="blue lighter">This is step 3</h3>
													</div>
												</div>

												<div class="step-pane" data-step="4">
													<div class="center">
														<h3 class="green">Congrats!</h3>
														Your product is ready to ship! Click finish to continue!
													</div>
												</div> -->
											</div>

											<!-- /section:plugins/fuelux.wizard.container -->
										</div>

										<hr />
										<div class="wizard-actions">
											<!-- #section:plugins/fuelux.wizard.buttons -->
											<p class="center" style="margin-top: 30px;">
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