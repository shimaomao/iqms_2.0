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
<title>业务显示时间</title>

<meta name="description" content="Dynamic tables and grids using jqGrid plugin" />
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0" />

<link href="${staticPath}/static/components/bootstrap-datetimepicker/css/bootstrap-datetimepicker.css" rel="stylesheet">
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
<script src="${staticPath}/static/components/ticket/js/config.js"></script>
<script src="${staticPath}/static/components/ticket/js/peripheral.js"></script>
<script src="${staticPath}/static/components/ticket/js/bootstrap-datetimepicker.js"></script>
<script src="${staticPath}/static/components/ticket/js/qmsVld.js"></script>
<script src="${staticPath}/static/components/ticket/js/jquery.noty.js"></script>


<script src="${staticPath}/static/js/businessconfig/bscshowtime/list.js"></script>
<%-- <script src="${staticPath}/static/js/businessconfig/bscbranchbus/remove.js"></script>  --%>
</head>

<body class="no-skin">

	<!-- 引入增改查页面 -->

	<div class="main-container ace-save-state" id="main-container">
		<!-- /section:basics/sidebar -->
		<div class="main-content">
			<div class="main-content-inner">
				<div id="dialog-new" class="hide">确定要保存吗？</div>
				<div id="dialog-remove" class="hide">确定要删除吗？</div>
				<!-- /section:basics/content.breadcrumbs -->
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
												<!-- 保存机构id --> <input type="hidden" name="orgId" id="orgId"
												value="" /> <input type="hidden" name="deviceNo"
												id="deviceNo" value="" />
											</span>
										</div>

									</form>
								</div>
							</div>
						</div>
					</div>
					<!-- widget 条件搜索 end -->

					<!-- 空行 -->
					<div class="space-6"></div>
					<div class="row" id="ticketList">
						<div class="box col-md-3">
							<div class="box-inner">
								<div class="box-header well" data-original-title="">
									<h2>
										<i class="glyphicon glyphicon-info-sign"></i>业务类型
									</h2>
									<div class="box-icon">
										<a href="#" class="btn btn-minimize btn-round btn-default"><i
											class="glyphicon glyphicon-chevron-up"></i></a>
									</div>
								</div>
								<div class="box-content">
									<div class="easyui-layout"
										style="display: inline-block; margin-top: 10px; width: 100%; height: 380px; overflow-x: hidden; overflow-y: auto;">
										<div
											data-options="border:true,region:'center',collapsible:true,iconCls:'icon-list'">
											<ul id="showTimeTree" class="ztree">
											</ul>
										</div>
									</div>
								</div>
							</div>
						</div>
						<div class="box col-md-9" style="margin-top: 0px;">
							<form id="frm">
								<div class="row">
									<div class="box col-md-12">
										<div class="box-inner">
											<div class="box-header well" data-original-title="">
												<h2>
													<i class="glyphicon glyphicon-info-sign"></i>平日显示时间
												</h2>
												<div class="box-icon">
													<a href="#" class="btn btn-minimize btn-round btn-default"><i
														class="glyphicon glyphicon-chevron-up"></i></a>
													<a href="#" class="btn btn-close btn-round btn-default"><i
											class="glyphicon glyphicon-remove"></i></a>
												</div>
											</div>
											<div class="box-content">
												<p class="left" style="display: inline-block; width: 20%">
													<a class="btn btn-primary" href="#" id="addBtn1"><i
														class="glyphicon glyphicon-plus icon-white"></i>添加时间 </a>
												</p>
												<table class="table table-striped table-bordered" id="ccc1">
													<thead>
														<tr>
															<th style="width: 10%;">序号</th>
															<th style="width: 30%;">从(时：分)<span class="star">*</span>
															</th>
															<th style="width: 30%;">到(时：分)<span class="star">*</span>
															</th>
															<th style="width: 20%;">取号数量限制<span class="star">*</span>
															</th>
															<th style="width: 10%;">操作</th>
														</tr>
													</thead>
													<tbody id="tbody1">
														<tr>
															<td>
																1
															</td>
															<td>
																<div class="controls">
																	<input type="text" class="form-control" name="beginTime1" value = "" placeholder="请输入时间(hh:mm)">
																</div>
															</td>
															<td>
																<div class="controls">
																	<input type="text" class="form-control" name="endTime1" value = "" placeholder="请输入时间(hh:mm)">
																</div>
															</td>
															<td>
																<div class="controls">
																	<input type="text" class="form-control" value = "" placeholder="请输入整数">
																</div>
															</td>
															<td class="center">
																<a class="btn btn-danger" href="#" onclick='delTr(this);'>
																	<i class="glyphicon glyphicon-trash icon-white"></i>
																	删除
																</a>
															</td>
														</tr>
													</tbody>
												</table>
											</div>
										</div>
									</div>
									<div class="box col-md-12">
										<div class="box-inner">
											<div class="box-header well" data-original-title="">
												<h2>
													<i class="glyphicon glyphicon-info-sign"></i>假日显示时间
												</h2>
												<div class="box-icon">
													<a href="#" class="btn btn-minimize btn-round btn-default"><i
														class="glyphicon glyphicon-chevron-up"></i></a>
													<a href="#" class="btn btn-close btn-round btn-default"><i
											class="glyphicon glyphicon-remove"></i></a>
												</div>
											</div>
											<div class="box-content">
												<p class="left" style="display: inline-block; width: 20%">
													<a class="btn btn-primary" href="#" id="addBtn2"><i
														class="glyphicon glyphicon-plus icon-white"></i>添加时间 </a>
												</p>
												<table class="table table-striped table-bordered" id="ccc2">
													<thead>
														<tr>
															<th style="width: 10%;">序号</th>
															<th style="width: 30%;">从(时：分)<span class="star">*</span>
															</th>
															<th style="width: 30%;">到(时：分)<span class="star">*</span>
															</th>
															<th style="width: 20%;">取号数量限制<span class="star">*</span>
															</th>
															<th style="width: 10%;">操作</th>
														</tr>
													</thead>
													<tbody id="tbody2">
														<tr>
													<td>
														1
													</td>
													<td>
														<div class="controls">
															<input type="text" class="form-control" name="beginTime2" value = "" placeholder="请输入时间(hh:mm)">
														</div>
													</td>
													<td>
														<div class="controls">
															<input type="text" class="form-control" name="endTime2" value = "" placeholder="请输入时间(hh:mm)">
														</div>
													</td>
													<td>
														<div class="controls">
															<input type="text" class="form-control" value = "" placeholder="请输入整数">
														</div>
													</td>
													<td class="center">
														<a class="btn btn-danger" href="#" onclick='delTr(this);'>
															<i class="glyphicon glyphicon-trash icon-white"></i>
															删除
														</a>
													</td>
												</tr>
													</tbody>
												</table>
											</div>
										</div>
									</div>
								</div>
								<p class="center">
									<input type="submit" class="btn btn-primary" id="saveConfig"
										value="保存配置">
								</p>
							</form>
						</div> 
						<!--/span-->
					</div>
					<!--jqGrid数据表格-->
					<!-- /.col -->
					<!-- /.row -->
					<!-- /.page-content -->

					<!-- page-foot start -->
					<!-- page-foot end -->

				</div>

			</div>
			<!-- /.main-content -->
		</div>
</body>

</html>