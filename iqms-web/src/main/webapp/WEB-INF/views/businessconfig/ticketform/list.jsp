<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE>
<html lang="en">
<head>
<meta charset="utf-8">
<title>号票模板</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description"
	content="Charisma, a fully featured, responsive, HTML5, Bootstrap admin template.">

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
<script src="${staticPath}/static/components/ticket/js/peripheral.js"></script>
<script
	src="${staticPath}/static/components/ticket/js/jquery.ui.core.js"></script>
<script
	src="${staticPath}/static/components/ticket/js/jquery.ui.widget.js"></script>
<script
	src="${staticPath}/static/components/ticket/js/jquery.ui.mouse.js"></script>
<script
	src="${staticPath}/static/components/ticket/js/jquery.ui.draggable.js"></script>
<script
	src="${staticPath}/static/components/ticket/js/jquery.ui.sortable.js"></script>
<script
	src="${staticPath}/static/components/ticket/js/jquery.metadata.js"></script>
<script
	src="${staticPath}/static/components/ticket/js/jquery.validate.js"></script>
<script src="${staticPath}/static/components/ticket/js/qmsVld.js"></script>

</head>
<body>

	<div class="ch-container">
		<div class="row">
			<div class="col-lg-12 col-sm-12 col-xs-12">
				<div class="widget-box transparent ui-sortable-handle"
					id="widget-box-12">
					<div class="widget-header">

						<h4 class="widget-title ">
							<i class="ace-icon fa fa-search"></i> 条件查询

						</h4>

						<div class="widget-toolbar no-border">
							<a href="javascript:void(0);" data-action="collapse"> <i
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
									value="" /> <input type="hidden" name="deviceNo" id="deviceNo"
									value="" />
								</span>
							</div>

							<!-- <div class="form-group">
									<button type="button" class="btn btn-white btn-info btn-bold"
										onclick="searchCondition();">
										<i class="ace-icon fa fa-search icon-on-right bigger-100 blue"></i>
										查询
									</button> <br />
							</div> -->
						</form>
					</div>
				</div>
			</div>
		</div>
		<!--  号票模板页面 -->
		<div class="row">
			<noscript>
				<div class="alert alert-block col-md-12">
					<h4 class="alert-heading">Warning!</h4>
				</div>
			</noscript>
			<div id="content" class="col-lg-12 col-sm-12">
				<div class="row" id="ticketList">
					<div class="box col-md-7">
						<div class="box-inner">
							<div class="box-header well" data-original-title="">
								<h2>
									<i class="glyphicon glyphicon-info-sign"></i> 号票列表
								</h2>
								<div class="box-icon">
									<a href="#" class="btn btn-minimize btn-round btn-default"><i
										class="glyphicon glyphicon-chevron-up"></i></a>
								</div>
							</div>
							<div class="box-content">
								<p class="left">
									<a class="btn btn-primary" href="#" id="addBtn"><i
										class="glyphicon glyphicon-plus icon-white"></i>新增模板
									 </a>
									 <a class="btn btn-primary" href="#" id="CopyToOrg"
											onclick="orgDeviceTree(${currentUser.orgId})"
											 ><i
												class="glyphicon glyphicon-plus icon-white"></i>应用到下级机构 </a>
											<span class="input-icon"> 
												<!-- 保存机构id -->
											 <input type="hidden" name="orgDevicelist" id="orgDevicelist" value="" /> 
											</span>
								</p>
								<table class="table table-striped table-bordered" id="ccc">
									<thead>
										<tr>
											<th>序号</th>
											<th>模板名称</th>
											<th>是否默认</th>
											<th>操作</th>
										</tr>
									</thead>
									<tbody>&nbsp;
									</tbody>
								</table>
							</div>
						</div>
					</div>

					<div class="box col-md-5">
						<div class="box-inner">
							<div class="box-header well" data-original-title="">
								<h2>
									<i class="glyphicon glyphicon-info-sign"></i> <label
										id="tktName"></label> 号票预览
								</h2>
								<div class="box-icon">
									<a href="#" class="btn btn-minimize btn-round btn-default"><i
										class="glyphicon glyphicon-chevron-up"></i></a>
								</div>
							</div>
							<div class="box-content">
								<table>
									<tbody>
										<tr>
											<td>
												<div id="ticket"
													style="position: relative; padding: 0px; margin: 0px; width: 310px; border: 1px #056498 solid; height: 100px;">
												</div> <input type="hidden" id="myhidden" value="${staticPath}">
											</td>
										</tr>
									</tbody>
								</table>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>

		<hr>

		<!-- 点击新增按钮后弹出的模态框 -->
		<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
			aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">
							X</button>
						<h3 id="modalTitle">模板新增</h3>
					</div>
					<form id="frm" name="frm" method="post" action="">
						<div class="modal-body">
							<div class="box-content">
								<table style="width: 100%">
									<tbody>
										<tr>
											<td style="text-align: right; width: 20%">模板名称<span
												class="star">*</span>
											</td>
											<td><input maxlength="50"
												validate="{special:true,maxlength:50}" class="form-control"
												name="tktTmpName" id="tktTmpName" placeholder="请输入号票模板名称">
											</td>
										</tr>
										<tr>
											<td style="text-align: right; width: 20%">默认模板<span
												class="star"></span>
											</td>
											<td><input type="checkbox" id="def"></td>
										</tr>
										<tr>
											<td style="text-align: right; width: 20%">号码模板<span
												class="star">*</span>
											</td>
											<td><select id="tktFormatId" validate="{formatDevice:true,maxlength:50}"
												name="tktFormatId" style="width: 215px;">
											</select></td>
										</tr>
									</tbody>
								</table>
							</div>
						</div>
						<div class="modal-footer">
							<input type="hidden" id="actionType" /> <input type="hidden"
								id="tktTmpId" /> <input type="button" class="btn btn-default"
								data-dismiss="modal" value="取消"> <input type="submit"
								class="btn btn-primary" value="确定">
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>

	<script
		src="${staticPath}/static/components/ticket/js/bootstrap.min.js"></script>
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

	<script src="${staticPath}/static/js/businessconfig/ticketform/list.js"
		Charset="UTF-8"></script>

</body>
</html>
