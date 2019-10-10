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
		<title>窗口配置</title>

		<meta name="description" content="Dynamic tables and grids using jqGrid plugin" />
		<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0" />
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
		<link href="${staticPath}/static/components/ticket/js/lib/easyui/themes/icon.css" rel="shortcut icon">
		<script src="${staticPath}/static/components/ticket/js/config.js"></script>
		<script src="${staticPath}/static/components/ticket/js/peripheral.js"></script>
		<script src="${staticPath}/static/components/ticket/js/bootstrap-datetimepicker.js"></script>
		<script src="${staticPath}/static/components/ticket/js/qmsVld.js"></script>
		<script src="${staticPath}/static/components/ticket/js/jquery.noty.js"></script>
		
		
		<%-- <script src="${staticPath}/static/js/businessconfig/bscwinconfig/list.js"></script> --%>
		<%-- <script src="${staticPath}/static/js/businessconfig/bscwinconfig/remove.js"></script>   --%>
	</head>

	<body class="no-skin">
	<script src="${staticPath}/static/js/businessconfig/bscwinconfig/list.js"></script>
	<!-- 引入增改查页面 -->
	<%--<%@ include file="/WEB-INF/views/businessconfig/bscwinconfig/new.jsp"%>
	<%@ include file="/WEB-INF/views/businessconfig/bscwinconfig/edit.jsp"%>
	 <%@ include file="/WEB-INF/views/businessconfig/bscwinconfig/show.jsp"%> --%>
	
	<div class="main-container ace-save-state" id="main-container">
		<!-- /section:basics/sidebar -->
		<div class="main-content">
			<div class="main-content-inner">

				<!-- /section:basics/content.breadcrumbs -->
				<div class="page-content">

					<!--widget搜索条件 start-->
					<div class="row">
						<div class="col-lg-12 col-sm-12 col-xs-12">
							<div class="widget-box transparent ui-sortable-handle" id="widget-box-12">
								<div class="widget-header">

									<h4 class="widget-title ">
										<i class="ace-icon fa fa-search"></i>
										条件查询
															
									</h4>

									<div class="widget-toolbar no-border">
										<a href="#" data-action="collapse">
											<i class="ace-icon fa fa-chevron-up bigger-160 blue"></i>
										</a>

									</div>
								</div>
								<!-- widget 主体查询部分 -->
								<div class="widget-body" style="margin-top: 10px;" style="display: block;">
									<form class="form-search form-inline" id="searchFrom">
										<div class="form-group">
											<label>选择设备：</label> 
											<span class="input-icon"> 
											<input type="text" placeholder="" value="" class="nav-search-input" 
												name="devName" id="devName" autocomplete="off"
												onclick="selectOrgDeviceTree(${currentUser.orgId},true,false,false,searchCondition)" />
												<!-- 保存机构id -->
											 <input type="hidden" name="orgId" id="orgId" value="" />
											 <input type="hidden" name="deviceNo"id="deviceNo" value="" />
											 <input type="hidden" name="orgName" id="orgName" value="" />
											</span>
										 </div>
										 
										 <!-- <div class="form-group">
												<button type="button" class="btn btn-white btn-info btn-bold" onclick="searchCondition();">
													<i class="ace-icon fa fa-search icon-on-right bigger-100 blue"></i>
													查询
												</button>
												<br/>
										 </div> -->

									</form>
								</div>
							</div>
						</div>
					</div>
					<!-- widget 条件搜索 end -->
					
					<!-- 空行 -->
					<div class="space-6"></div>
					<div class="row" id="ticketList">
						<div class="box col-md-12">
							<div class="box-inner">
								<div class="box-header well" data-original-title="">
									<h2>
										<i class="glyphicon glyphicon-info-sign"></i>窗口设置
									</h2>
									<div class="box-icon">
										<a href="#" class="btn btn-minimize btn-round btn-default"><i
											class="glyphicon glyphicon-chevron-up"></i></a>
										<!--<a href="#" class="btn btn-close btn-round btn-default"><i
									class="glyphicon glyphicon-remove"></i></a>-->
									</div>
								</div>
								<div class="box-content">
									<form id="frm">
										<p class="left">
											<a class="btn btn-primary" href="#" id="addBtn"><i
												class="glyphicon glyphicon-plus icon-white"></i>添加窗口 </a>
											<%-- <a class="btn btn-primary" href="#" id="CopyToOrg"
											onclick="orgDeviceTree(${currentUser.orgId})"
											 ><i
												class="glyphicon glyphicon-plus icon-white"></i>应用到下级机构 </a>
											<span class="input-icon">  
												<!-- 保存机构id -->
											 <input type="hidden" name="orgDevicelist" id="orgDevicelist" value="" /> 
											</span>  --%>
										</p>
										<table class="table table-striped table-bordered" id="ccc">
											<thead>
												<tr>
													<th style="width: 5%;">序号</th>
													<th style="width: 15%;">所属网点</th>
													<th style="width: 10%;">窗口号<span class="star">*</span></th>
													<th style="width: 10%;">呼叫器</th>
													<th style="width: 10%;">评价器</th>
													<th style="width: 15%;">窗口屏</th>
													<th style="width: 15%;">综合屏</th>
													<th style="width: 10%;">启用</th>
													<th style="width: 10%;">操作</th>
												</tr>
											</thead>
											<tbody id="tbody">
											</tbody>
										</table>
										<div>
											<p class="center">
												<input type="submit" class="btn btn-primary" value="保存配置" id="saveConfig">
												</input>
											</p>
										</div>
									</form>
								</div>
							</div>
						</div>
						<!--/span-->
					</div>
					<!--jqGrid数据表格-->
					<!-- <div class="row">
						<div class="col-xs-12">

							<table id="grid-table"></table>

							<div id="grid-pager"></div>

							PAGE CONTENT ENDS
						</div>
						/.col
					</div> -->
					<!-- /.row -->
				</div>
				<!-- /.page-content -->
				
				<!-- page-foot start -->
				<!-- page-foot end -->
				
			</div>
			
		</div>
		<!-- /.main-content -->
	</div>

	</body>

</html>