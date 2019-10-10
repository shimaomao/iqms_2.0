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
		<title>客户类型管理</title>

		<meta name="description" content="Dynamic tables and grids using jqGrid plugin" />
		<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0" />

		<%@ include file="/WEB-INF/views/shared/bootstrapcontentui.jsp"%>
		<script src="${staticPath}/static/js/basicconfig/custtype/list.js"></script>
		<script src="${staticPath}/static/js/basicconfig/custtype/remove.js"></script>
		<link href="${staticPath}/static/components/ticket/css/bootstrap-11.min.css" rel="stylesheet">
	</head>

	<body class="no-skin">
    	
	<!-- 引入增改查页面 -->
	<%@ include file="/WEB-INF/views/basicconfig/custtype/new.jsp"%>
	<%@ include file="/WEB-INF/views/basicconfig/custtype/edit.jsp"%>
	<%@ include file="/WEB-INF/views/basicconfig/custtype/show.jsp"%>
	
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
											<label>类型名称：</label>
											<span class="input-icon">
												<input type="text" placeholder="请输入客户类型" class="nav-search-input" name="custName" autocomplete="off" />
												<button type="button" class="btn btn-white btn-info btn-bold" onclick="searchCondition();">
													<i class="ace-icon fa fa-search icon-on-right bigger-100 blue"></i>
													查询
												</button>
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

					<!--jqGrid数据表格-->
					<div class="row">
						<div class="col-xs-12">

							<table id="grid-table"></table>

							<div id="grid-pager"></div>

							<!-- PAGE CONTENT ENDS -->
						</div>
						<!-- /.col -->
					</div>
					<!-- /.row -->
				</div>
				<!-- /.page-content -->
			</div>
			
		</div>
		<!-- /.main-content -->
	</div>

	</body>

</html>