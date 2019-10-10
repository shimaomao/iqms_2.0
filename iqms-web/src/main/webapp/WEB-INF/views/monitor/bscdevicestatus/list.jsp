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
<title>设备监控</title>

<meta name="description"
	content="Dynamic tables and grids using jqGrid plugin" />
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0" />

<link href="${staticPath}/static/components/jquery/css/pagination.css" />
<%@ include file="/WEB-INF/views/shared/bootstrapcontentui.jsp"%>
<%@ include file="/WEB-INF/views/shared/selectOrg.jsp"%>
<script src="${staticPath}/static/js/monitor/bscdevicestatus/list.js"></script>
<script src="${staticPath}/static/components/jquery/jquery.pagination.js"></script>
<%@ include file="/WEB-INF/views/monitor/bscdevicestatus/show.jsp"%>
<style type="text/css">
li {
	list-style-type: none;
}
</style>
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
												type="hidden" name="orgId" id="orgId" value=${currentUser.orgId} />
											</span> <label>是否在线：</label> <select name="onLineFlag"
												id="onLineFlag" class="form-control" style="width: 100px;">
												<option value="2">所有</option>
												<option value="3">否</option>
												<option value="1">是</option>
											</select>
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
				
				<!-- page-foot start -->
				<!-- page-foot end -->
				
			</div>
			
		</div>
		<!-- /.main-content -->
	</div>

	</body>

</html>