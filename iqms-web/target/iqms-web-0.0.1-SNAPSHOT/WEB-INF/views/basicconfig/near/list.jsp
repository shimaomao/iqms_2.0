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
<title>临近网点配置</title>

<meta name="description"
	content="Dynamic tables and grids using jqGrid plugin" />
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0" />

<%@ include file="/WEB-INF/views/shared/bootstrapcontentui.jsp"%>
<link rel="stylesheet"
	href="${staticPath}/static/components/zTree/css/demo.css"
	type="text/css">
<link rel="stylesheet"
	href="${staticPath}/static/components/zTree/css/zTreeStyle/zTreeStyle.css"
	type="text/css">
<link
	href="${staticPath}/static/components/ticket/css/bootstrap-11.min.css"
	rel="stylesheet">
<link href="${staticPath}/static/components/ticket/css/charisma-app.css"
	rel="stylesheet">
<link rel="stylesheet" href="${staticPath}/static/components/_mod/jquery-ui/jquery-ui.min.css" />

<script type="text/javascript"
	src="${staticPath}/static/components/zTree/js/jquery.ztree.core.js"></script>
<script type="text/javascript"
	src="${staticPath}/static/components/zTree/js/jquery.ztree.excheck.js"></script>
<script type="text/javascript"
	src="${staticPath}/static/components/zTree/js/jquery.ztree.exedit.js"></script>
<script type="text/javascript"
	src="${staticPath}/static/js/shared/selectOrgTree.js"></script>
<script src="${staticPath}/static/js/basicconfig/near/list.js"></script>
<script src="${staticPath}/static/js/basicconfig/near/remove.js"></script>
<script type="text/javascript">
    	var orgIdTemp = "${currentUser.orgId}";
    
    </script>
</head>

<body class="no-skin">

	<!-- 引入增改查页面 -->
	<%--<%@ include file="/WEB-INF/views/basicconfig/teller/new.jsp"%>
	<%@ include file="/WEB-INF/views/basicconfig/teller/edit.jsp"%>--%>
	<div class="main-container ace-save-state" id="main-container">
		<!-- /section:basics/sidebar -->
		<div class="main-content">
			<div class="main-content-inner" id="main">
				<div id="dialog-new" class="hide">确定要保存吗？</div>
				<div id="dialog-remove" class="hide">确定要删除吗？</div>
				<!-- /section:basics/content.breadcrumbs -->
				<form name="FormPost" class="form-horizontal"
					onsubmit="return false;" style="width: auto; height: auto;">
					<div class="page-content">
						<div class="row">
							<div class="col-lg-12 col-sm-12 col-xs-12">
								<div class="widget-box transparent ui-sortable-handle"
									id="widget-box-12">
									<h3 class="header blue lighter smaller">
										<i class="ace-icon fa fa-cog"> 临近网点配置 </i>
									</h3>
								</div>
							</div>
						</div>
						<div class="row">
							<div class="col-xs-12">
								<!-- PAGE CONTENT BEGINS -->

								<!-- #section:plugins/fuelux.treeview -->
								<div class="row">
									<!-- <div class="col-sm-4">
										<div class="widget-box widget-color-blue2">
											<div class="widget-header">
												<h4 class="widget-title lighter smaller">请选择机构</h4>
											</div>
											<div class="widget-body">
												<div class="widget-main padding-8">
													<ul id="orgTree1" class="ztree"></ul>
												</div>
												<input type="hidden" id="orgId" name="orgId" value="" />
											</div>
										</div>
									</div> -->
									<div class="box col-md-4">
										<div class="box-inner">
											<div class="box-header well" data-original-title="">
												<h2>
													<i class="glyphicon glyphicon-info-sign"></i>请选择机构
												</h2>
											</div>
											<div class="box-content">
												<div class="easyui-layout"
													style="display: inline-block; margin-top: 10px; width: 100%; height: 260px; overflow-x: hidden; overflow-y: auto;">
													<div
														data-options="border:true,region:'center',collapsible:true,iconCls:'icon-list'">
														<ul id="orgTree1" class="ztree"></ul>
													</div>
													<input type="hidden" id="orgId" name="orgId" value="" />
												</div>
											</div>
										</div>
									</div>

									<div class="box col-md-8">
										<div class="box-inner">
											<div class="box-header well" data-original-title="">
												<h2>
													<i class="glyphicon glyphicon-info-sign"></i> 临近网点 <span
														class="smaller-80">(点击左侧机构查看)</span>
												</h2>
											</div>
											<div class="box-content">
												<div class="form-group">
													<label class="col-md-2 control-label no-padding-right"
														for="branchName">临近网点一 : </label>

													<div class="col-md-4">
														<input type="text" value="" class="nav-search-input"
															id="orgName1" name="orgName1" autocomplete="off"
															onclick="selectOrgTree(this,true);" /> <input
															type="hidden" id="orgId1" name="orgId1" value="" />
													</div>
													<label class="col-md-2 control-label no-padding-right"
														for="branchName">临近网点二 : </label>

													<div class="col-md-4">
														<input type="text"
															value="" class="nav-search-input" name="orgName2"
															id="orgName2" autocomplete="off"
															onclick="selectOrgTree(this,true);" /> <input
															type="hidden" id="orgId2" name="orgId2" value="" />
													</div>
												</div>
												
												<div class="form-group">
													<label class="col-md-2 control-label no-padding-right"
														for="branchName">临近网点三 : </label>

													<div class="col-md-4">
														<input type="text"
															value="" class="nav-search-input" name="orgName3"
															id="orgName3" autocomplete="off"
															onclick="selectOrgTree(this,true);" /> <input
															type="hidden" name="orgId3" id="orgId3" value="" />
													</div>
													<label class="col-md-2 control-label no-padding-right"
														for="branchName">临近网点四 : </label>

													<div class="col-md-4">
														<input type="text"
															value="" class="nav-search-input" name="orgName4"
															id="orgName4" autocomplete="off"
															onclick="selectOrgTree(this,true);" /> <input
															type="hidden" name="orgId4" id="orgId4" value="" />
													</div>
												</div>
												<div id="dialog-org" class="hide">
													<div class="widget-body">
														<ul id="orgTree" class="ztree"
															style="width: 350px; height: 250px"></ul>
													</div>
												</div>
											</div>
										</div>
									</div>

									<!-- <div class="col-sm-8">
										<div class="widget-box widget-color-green2">
											<div class="widget-header">
												<h4 class="widget-title lighter smaller">
													临近网点 <span class="smaller-80">(点击左侧机构查看)</span>
												</h4>
											</div>
											<div class="widget-body">
												<div class="widget-main ">
													<div class="col-sm-6">
														<span class="input-icon">临近网点一: <input type="text"
															value="" class="nav-search-input" id="orgName1"
															name="orgName1" autocomplete="off"
															onclick="selectOrgTree(this,true);" /> <input
															type="hidden" id="orgId1" name="orgId1" value="" />
														</span>
													</div>
													<div class="row">
														<span class="input-icon"> <input type="text"
															value="" class="nav-search-input" name="orgName2"
															id="orgName2" autocomplete="off"
															onclick="selectOrgTree(this,true);" /> <input
															type="hidden" id="orgId2" name="orgId2" value="" />
														</span>
													</div>
													<div class="col-sm-6">
														<span class="input-icon"> <input type="text"
															value="" class="nav-search-input" name="orgName3"
															id="orgName3" autocomplete="off"
															onclick="selectOrgTree(this,true);" /> <input
															type="hidden" name="orgId3" id="orgId3" value="" />
														</span>
													</div>
													<div class="row">
														<span class="input-icon"> <input type="text"
															value="" class="nav-search-input" name="orgName4"
															id="orgName4" autocomplete="off"
															onclick="selectOrgTree(this,true);" /> <input
															type="hidden" name="orgId4" id="orgId4" value="" />
														</span>
													</div>
												</div>
												<div id="dialog-org" class="hide">
													<div class="widget-body">
														<ul id="orgTree" class="ztree"
															style="width: 350px; height: 250px"></ul>
													</div>
												</div>
											</div>
										</div>
									</div> -->
								</div>
							</div>
						</div>


						<div class="col-md-2 col-md-offset-1">
							<button type="button" class="btn btn-white btn-info btn-bold"
								onclick="newNear()">
								保存 <i class="ace-icon fa fa-floppy-o bigger-120 blue"></i>
							</button>
						</div>
						<div class="col-md-2 ">
							<button type="button" class="btn btn-white btn-info btn-bold"
								onclick="removeNear()">
								删除 <i class="ace-icon fa fa-trash-o red"></i>
							</button>
						</div>
					</div>
					<!-- /.page-content -->

					<!-- page-foot start -->
					<!-- page-foot end -->

				</form>
			</div>
		</div>
	</div>
</body>

</html>