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
		<title>业务流水报表</title>

		<meta name="description" content="Dynamic tables and grids using jqGrid plugin" />
		<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0" />
		
		<%-- <%@ include file="/WEB-INF/views/shared/bootstrapcontentui.jsp"%> --%>
		
		<%@ include file="/WEB-INF/views/shared/selectOrg.jsp"%>
		<%-- <link rel="stylesheet" href="${staticPath}/static/components/jquery-ui/theme.css" /> --%>
		<script src="${staticPath}/static/components/jquery-ui/ui/datepicker.js"></script>
		<script src="${staticPath}/static/lib/Charts/FusionCharts.js"></script>
		<script src="${staticPath}/static/js/report/businessflow/list.js"></script>
		
	</head>

	<body class="no-skin">
	<!-- 引入增改查页面 -->
		
	<div class="main-container ace-save-state" id="main-container">
		<div class="main-content">
			<div class="main-content-inner">
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
									<form class="form-search form-inline" id="searchFrom" >
									<!-- style="position: absolute;z-index:0;" -->
										<div class="form-group">
											<label>机构选择：</label>
											<span class="input-icon">
												<input type="text" placeholder="请选择机构" value="${currentUser.orgName}" 
													class="nav-search-input" id="orgName" name="orgName" autocomplete="off" onclick="selectOrgTree(this,true);" />
												<!-- 保存机构id -->
												<input  type="hidden" name="orgId"  value="${currentUser.orgId}"  />
											</span>
										 </div>
										 
										<!--  <div class="form-group">
											<label>业务名称：</label>
											<span class="input-icon">
												<select  class="busType" name="busType">
												
												</select>
											</span>
										 </div> -->
										 
										 <div class="form-group">
											<label>客户类型：</label>
											<span class="input-icon">
												<select  class="custLevel" name="custLevel">
												
												</select>
											</span>
										 </div>
										 
										 <div class="form-group">
											<label>评价值：</label>
											<span class="input-icon">
												<select  class="appValue" name="appValue">
												
												</select>
											</span>
										 </div>
										 
										  <div class="form-group" >
											<label>开始时间：</label>
											<span class="input-icon">
												<input type="text" style="width:120px" placeholder="请选择开始时间"  class="nav-search-input" name="startDate" id="startDate" autocomplete="off"/>
											</span>
										 </div>
										 
										 
										 <div class="form-group">
										 	<label>结束时间：</label>
											<span class="input-icon">
												<input type="text" style="width:120px" placeholder="请选择结束时间" class="nav-search-input" name="endDate" id="endDate" autocomplete="off"/>
											</span>
												<button type="button" class="btn btn-white btn-info btn-bold" onclick="searchCondition();">
													<i class="ace-icon fa fa-search icon-on-right bigger-100 blue"></i>
													查询
												</button>
												<br/>
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
					<div class="row" >
						<div class="col-xs-12" >
							<table id="grid-table" ></table>

							<div id="grid-pager"></div>
						</div>
					</div>
					
			</div>
			
		</div>
	</div>

	</body>

</html>