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
<title>业务队列监控</title>

<meta name="description"
	content="Dynamic tables and grids using jqGrid plugin" />
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0" />


<%@ include file="/WEB-INF/views/shared/bootstrapcontentui.jsp"%>
<%@ include file="/WEB-INF/views/shared/selectOrg.jsp"%>
<script src="${staticPath}/static/js/monitor/trxtoday/list.js"></script>


<!-- 饼状图 -->
<script src="${staticPath}/static/js/monitor/trxtoday/picture.js"></script>
<script src="${staticPath}/static/components/flot/jquery.flot.js"></script>
<script src="${staticPath}/static/components/flot/jquery.flot.pie.js"></script>
<script src="${staticPath}/static/components/flot/jquery.flot.resize.js"></script>
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
											<label>机构选择：</label> <span class="input-icon"> <input
												type="text" placeholder="请选择机构"
												value="${currentUser.orgName}" class="nav-search-input"
												name="orgName" autocomplete="off"
												onclick="selectOrgTree(this,true);" /> <!-- 保存机构id --> <input
												type="hidden" name="orgId" id="orgId" value="${currentUser.orgId}" />
											</span>
										</div>

										<div class="form-group">
												<button type="button"
													class="btn btn-white btn-info btn-bold"
													onclick="searchCondition();">
													<i
														class="ace-icon fa fa-search icon-on-right bigger-100 blue"></i>
													查询
												</button>
										</div>
									</form>
								</div>
							</div>
						</div>
					</div>
					<!-- widget 条件搜索 end -->
					<!-- 空行 -->
					<div class="space-6"></div>
					<div class="col-lg-7 col-sm-7 col-xs-7 infobox-container">
						<!-- #section:pages/dashboard.infobox -->
						<div class='row'>
							<div class="infobox infobox-green">
								<div class="infobox-icon">
									<i class="ace-icon fa fa-users"></i>
								</div>
								<div class="infobox-data">
									<span class="infobox-data-number" id="total">32</span>
									<div class="infobox-content">
										总取号数&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <span
											class="infobox-data-number" id="yesTotal">昨日:500</span>
									</div>
								</div>

								<!-- #section:pages/dashboard.infobox.stat -->
								<div class="stat stat-success" id="totalPercent"></div>
								<!-- /section:pages/dashboard.infobox.stat -->
							</div>

							<div class="infobox infobox-blue">
								<div class="infobox-icon">
									<i class="ace-icon fa fa-coffee"></i>
								</div>

								<div class="infobox-data">
									<span class="infobox-data-number" id="wait">11</span>
									<div class="infobox-content">普通等候人数</div>
								</div>

								<!-- <div class="badge badge-success">
							32% <i class="ace-icon fa fa-arrow-up"></i>
						</div> -->
							</div>
						</div>
						<div class='row'>
							<div class="infobox infobox-pink">
								<div class="infobox-icon">
									<i class="ace-icon glyphicon glyphicon-pencil"></i>
								</div>

								<div class="infobox-data">
									<span class="infobox-data-number" id="doing"></span>
									<div class="infobox-content">正在办理人数</div>
								</div>
								<!-- <div class="stat stat-important">4%</div> -->
							</div>

							<div class="infobox infobox-red">
								<div class="infobox-icon">
									<i class="ace-icon glyphicon glyphicon-star"></i>
								</div>

								<div class="infobox-data">
									<span class="infobox-data-number" id="vipTotal">7</span>
									<div class="infobox-content">
										VIP取号数&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <span
											class="infobox-data-number" id="yesVipTotal">昨日:147</span>
									</div>
								</div>
								<div class="stat stat-success" id="vipPercent"></div>
							</div>
						</div>
						<div class='row'>
							<div class="infobox infobox-red">
								<div class="infobox-icon">
									<i class="ace-icon glyphicon glyphicon-glass"></i>
								</div>
								<!-- /section:pages/dashboard.infobox.sparkline -->
								<div class="infobox-data">
									<span class="infobox-data-number" id="vipWait">6,251</span>
									<div class="infobox-content">VIP等候人数</div>
								</div>

								<!-- <div class="badge badge-success">
							7.2% <i class="ace-icon fa fa-arrow-up"></i>
						</div> -->
							</div>
							<div class="infobox infobox-pink"></div>
						</div>
						<!-- /section:pages/dashboard.infobox -->
						<div class="space-6"></div>
					</div>

					<div class="vspace-12-sm"></div>

					<div class="col-sm-5">
						<div class="widget-box">
							<div class="widget-body">
								<div id="piechart-placeholder"></div>
								<!-- /.widget-body -->
							</div>
							<!-- /.widget-box -->
						</div>
						<!-- /.col -->
					</div>
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
			</div>
			<!-- page-foot start -->
			<!-- page-foot end -->

		</div>

	</div>
	<!-- /.main-content -->
	</div>

</body>

</html>