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
<title>号码模板</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description"
	content="Charisma, a fully featured, responsive, HTML5, Bootstrap admin template.">
<meta name="author" content="Muhammad Usman">


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

<!-- 必须使用 -->
<script src="${staticPath}/static/components/ticket/js/lib/jquery/jquery.js"></script>
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
		<!--  号码模板页面 -->
		<div class="row">
			<noscript>
				<div class="alert alert-block col-md-12">
					<h4 class="alert-heading">Warning!</h4>
				</div>
			</noscript>
			<div id="content" class="col-lg-12 col-sm-12">
				<div class="row" id="ticketList">
					<div class="box col-md-12">
						<div class="box-inner">
							<div class="box-header well" data-original-title="">
								<h2>
									<i class="glyphicon glyphicon-info-sign"></i>号码模板列表
								</h2>
								<div class="box-icon">
									<a href="#" class="btn btn-minimize btn-round btn-default"><i
										class="glyphicon glyphicon-chevron-up"></i></a>
								</div>
							</div>
							<div class="box-content">
								<p class="left">
									<a class="btn btn-primary" href="#" id="addBtn"><i
										class="glyphicon glyphicon-plus icon-white"></i>新增 </a>
								</p>
								<table class="table table-striped table-bordered" id="ccc">
									<thead>
										<tr>
											<th>序号</th>
											<th>模板</th>
											<th>操作</th>
										</tr>
									</thead>
									<tbody>&nbsp;
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
											<td style="text-align: right; width: 20%">号码模板<span
												class="star">*</span>
											</td>
											<td><input type="hidden" id="tktFormat">
												<div class="controls">
													<ul id="sortable2" name="sortableName"
														style="border: 3px rgba(221, 221, 221, 0.8) solid; list-style-type: none; margin: 0; padding: 0; margin-bottom: 10px; height: 118px;"
														class="connectedSortable ui-helper-reset ui-sortable"
														unselectable="on">
														<li class='ui-state-highlight'
															style='border: 1.5px rgba(221, 221, 221, 0.6) solid; margin: 5px; padding: 5px; text-align: left; font-family: Arial Negreta, Arial; font-size: 12px; line-height: 30px; background-color: rgb(251, 249, 238);'>
															<span class='ui-state-highlight'> <input
																type='checkbox' checked id='tktPrefix'> <label
																style='margin-left: 5px; margin-right: 5px;'>业务类型</label>
														</span>
														</li>
														<li class='ui-state-highlight'
															style='border: 1.5px rgba(221, 221, 221, 0.6) solid; margin: 5px; padding: 5px; text-align: left; font-family: Arial Negreta, Arial; font-size: 12px; line-height: 30px; background-color: rgb(251, 249, 238);'>
															<span class='ui-state-highlight'> <input
																type='checkbox' checked id='custPrefix'> <label
																style='margin-left: 5px; margin-right: 5px;'>客户等级</label>
														</span>
														</li>
													</ul>
													<span class='ui-state-highlight'> <input
														type='checkbox' disabled checked id='lsws'> <label
														style='margin-left: 5px; margin-right: 5px;'>流水位数</label><span
														class="star">*</span> <input class='form-control'
														maxlength='1' validate="{required:true,range:[1,9]}"
														style='display: inline-block; width: 50%' name="lswsNum"
														id='lswsNum' placeholder='请输入流水位数'>
													</span> <label
														style="margin: 5px; padding: 5px; text-align: left; font-family: Arial Negreta, Arial; font-size: 12px; line-height: 30px; color: #317eac;">
														拖动业务类型，客户等级区域排序，选择打印的流水位数 </label>
												</div></td>
										</tr>
									</tbody>
								</table>
							</div>
						</div>
						<div class="modal-footer">
							<input type="hidden" id="actionType" /> <input type="hidden"
								id="tktFormatId" /> <input type="button"
								class="btn btn-default" data-dismiss="modal" value="取消">
							<input type="submit" class="btn btn-primary" value="确定">
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

	<script src="${staticPath}/static/js/businessconfig/numberform/list.js"></script>
	
	<!-- 弹出框 -->
<script src="${staticPath}/static/components/jquery-confirm-master/dist/jquery-confirm.min.js"></script>

</body>
</html>
