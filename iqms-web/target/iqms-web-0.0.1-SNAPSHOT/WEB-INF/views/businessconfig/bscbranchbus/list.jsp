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
<title>网点业务</title>

<meta name="description"
	content="Dynamic tables and grids using jqGrid plugin" />
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0" />
<%-- --%>
<%@ include file="/WEB-INF/views/shared/selectOrg.jsp"%>
<link href="${staticPath}/static/components/bootstrap-datetimepicker/css/bootstrap-datetimepicker.css" rel="stylesheet">
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
<link rel="stylesheet" href="${staticPath}/static/components/_mod/jquery-ui/jquery-ui.min.css" />
<script src="${staticPath}/static/components/ticket/js/config.js"></script>
<script src="${staticPath}/static/components/ticket/js/peripheral.js"></script>
<script src="${staticPath}/static/components/ticket/js/bootstrap-datetimepicker.js"></script>
<script src="${staticPath}/static/components/ticket/js/qmsVld.js"></script>
<script src="${staticPath}/static/components/ticket/js/jquery.noty.js"></script>
<!-- jquery验证框架 -->
<script src="${staticPath}/static/components/jquery-validation/dist/jquery.validate.js"></script>
<script src="${staticPath}/static/components/jquery-validation/dist/additional-methods.js"></script>
<script src="${staticPath}/static/components/jquery-validation/dist/localization/messages_zh.js"></script>
<%-- <%@ include file="/WEB-INF/views/shared/bootstrapcontentui.jsp"%> --%>

<script src="${staticPath}/static/js/businessconfig/bscbranchbus/list.js"></script>
<script src="${staticPath}/static/js/businessconfig/bscbranchbus/remove.js"></script> 
</head>

<body class="no-skin">

	<!-- 引入增改查页面 -->

	<div class="main-container ace-save-state" id="main-container">
		<!-- /section:basics/sidebar -->
		<div class="main-content">
			<div class="main-content-inner">
			<div id="dialog-new" class="hide">确定要保存吗？ </div>
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

										<!-- <div class="form-group">
												<button type="button"
													class="btn btn-white btn-info btn-bold"
													onclick="searchCondition();">
													<i
														class="ace-icon fa fa-search icon-on-right bigger-100 blue"></i>
													查询
												</button> <br />
										</div> -->
										<div class="form-group">
											<a class="btn btn-primary" href="#" id="CopyToOrg"
											onclick="orgDeviceTree(${currentUser.orgId})"
											 ><i
												class="glyphicon glyphicon-plus icon-white"></i>应用到下级机构 </a>
											<span class="input-icon"> 
												<!-- 保存机构id -->
											 <input type="hidden" name="orgDevicelist" id="orgDevicelist" value="" /> 
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
							<div class="box col-md-4">
								<div class="box-inner">
									<div class="box-header well" data-original-title="">
										<h2>
											<i class="glyphicon glyphicon-info-sign"></i>菜单
										</h2>
									</div>
									<div class="box-content">
										<div class="easyui-layout"
											style="display: inline-block; margin-top: 10px; width: 100%; height: 260px; overflow-x: hidden; overflow-y: auto;">
											<div
												data-options="border:true,region:'center',collapsible:true,iconCls:'icon-list'" id="menuList">
											</div>
										</div>
									</div>
								</div>
							</div>
							<div class="box col-md-4">
								<div class="box-inner">
									<div class="box-header well" data-original-title="">
										<h2>
											<i class="glyphicon glyphicon-info-sign"></i>业务类型
										</h2>
									</div>
									<div class="box-content">
										<div class="easyui-layout"
											style="display: inline-block; margin-top: 10px; width: 100%; height: 260px; overflow-x: hidden; overflow-y: auto;">
											<div data-options="border:true,region:'center',collapsible:true,iconCls:'icon-list'">
												<ul id="branchBusTree" class="ztree"></ul>
											</div>
										</div>
									</div>
								</div>
							</div>
							<div class="box col-md-4">
								<div class="box-inner">
									<div class="box-header well" data-original-title="">
										<h2>
											<i class="glyphicon glyphicon-info-sign"></i>业务
										</h2>
									</div>
									<div class="box-content">
										<div class="easyui-layout"
											style="display: inline-block; margin-top: 10px; width: 100%; height: 260px; overflow-x: hidden; overflow-y: auto;">
											<div
												data-options="border:true,region:'center',collapsible:true,iconCls:'icon-list'" id="busList">
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					<form name="FormPost" id="FormPost" class="form-horizontal" onsubmit="return false;" style="width:auto;height:auto;">
						<div class="row">
							<div class="box col-md-12 ">
								<div class="box-inner">
									<div class="box-header well" data-original-title="">
										<h2>
											<i class="glyphicon glyphicon-info-sign"></i>业务属性
										</h2>
									</div>
									<div class="box-content">
										<div class="form-group">
											<label class="col-md-2 control-label no-padding-right"
												for="branchName">业务名称 <span style="color: red">*</span>
											</label>

											<div class="col-md-4">
												<input type="text" id="branchName"  name="branchName"
													placeholder="" class="col-xs-10 col-sm-8" /> <input
													type="hidden" id="treeId" name="treeId" value="" /> <input
													type="hidden" id="treePid" name="treePid" value="" /> <input
													type="hidden" id="businessType" name="businessType"
													value="" />
													<input
													type="hidden" id="levelNum" name="levelNum"
													value="" />
											</div>
											<label class="col-md-2 control-label no-padding-right"
												for="businessEnName">英文名称 <span>&nbsp;&nbsp;</span>
											</label>

											<div class="col-md-4">
												<input type="text" id="businessEnName" name="businessEnName"
													placeholder="" class="col-xs-10 col-sm-5" /> <span
													class="help-inline col-xs-12 col-sm-7"> <label
													class="middle"> <input class="ace" type="checkbox"
														id="showEn" /> <span class="lbl">显示</span>
												</label> <input type="hidden" id="isShowEn" name="isShowEn" value="" />
												</span>
											</div>
										</div>
										<div class="form-group">
											<label class="col-md-2 control-label no-padding-right"
												for="businessCode">业务代码 <span style="color: red">*</span>
											</label>

											<div class="col-md-4">
												<input type="text" id="businessCode" 
													name="businessCode" 
													placeholder="" class="col-xs-10 col-sm-8" />
											</div>
											<label class="col-md-2 control-label no-padding-right"
												for="callHead">呼叫字头 <span style="color: red">*</span>
											</label>

											<div class="col-md-4">
												<input type="text" id="callHead" name="callHead"
													placeholder="" class="col-xs-10 col-sm-5" />
												<span
													class="help-inline col-xs-12 col-sm-7">
												<label
													class="middle"> <input class="ace" type="checkbox"
														id="swipe" /> <span class="lbl">证件取号</span>
												</label> <input type="hidden" id="isSwipe" name="isSwipe" value="" />
												</span>
											</div>
										</div>
										<div class="form-group">
											<label class="col-md-2 control-label no-padding-right"
												for="priorTime">优先时间 <span>&nbsp;&nbsp;</span>
											</label>

											<div class="col-md-4">
												<input type="text" id="priorTime" name="priorTime"
													placeholder="" class="col-xs-10 col-sm-8" /> <span
													class="help-inline"> <label
													class="middle"> <span class="lbl">分钟</span>
												</label>
												</span>
											</div>
											<label class="col-md-2 control-label no-padding-right"
												for="maxPickUp">取号上限<span>&nbsp;&nbsp;</span>
											</label>

											<div class="col-md-4">
												<input type="text" id="maxPickUp" name="maxPickUp"
													placeholder="" class="col-xs-10 col-sm-8" />
											</div>
										</div>


										<div class="form-group">
											<label class="col-md-2 control-label no-padding-right"
												for="pickUpAdvice">取票提示 <span>&nbsp;&nbsp;</span>
											</label>

											<div class="col-md-4">
												<input type="text" id="pickUpAdvice" name="pickUpAdvice"
													placeholder="" class="col-xs-10 col-sm-8" />
											</div>
											<label class="col-md-2 control-label no-padding-right"
												for="sortNum">排序号 <span>&nbsp;&nbsp;</span>
											</label>

											<div class="col-md-4">
												<input type="text" id="sortNum" name="sortNum"
													placeholder="" class="col-xs-10 col-sm-8" />
											</div>
										</div>

									</div>
								</div>
							</div>
						</div>
						<p class="center">
									<input type="submit" class="btn btn-primary" id="saveConfig" 
									onclick="newBscBranchBus()"	value="保存配置">
								</p>
							</form>
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