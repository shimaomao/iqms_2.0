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
<title>版本管理</title>

<meta name="description"
	content="Dynamic tables and grids using jqGrid plugin" />
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0" />

<%@ include file="/WEB-INF/views/shared/bootstrapcontentui.jsp"%>

<link rel="stylesheet"
	href="${staticPath}/static/components/dropzone/dist/dropzone.css" />

<script src="${staticPath}/static/components/dropzone/dist/dropzone.js"></script>

<script src="${staticPath}/static/js/basicconfig/patchversion/list.js"></script>

<script src="${staticPath}/static/js/basicconfig/patchversion/datalist.js"></script>
</head>

<body class="no-skin">

	<!-- 引入增改查页面 -->
	<%@ include file="/WEB-INF/views/basicconfig/patchversion/new.jsp"%>
	<%@ include file="/WEB-INF/views/basicconfig/patchversion/selectUpgradeDev.jsp"%>

	<!-- /section:basics/navbar.layout -->
	<div class="main-container ace-save-state" id="main-container">
		
		<input  type="hidden" id="userOrgId" name="userOrgId"  value="${currentUser.orgId}"  />

		<!-- /section:basics/sidebar -->
		<div class="main-content">
			<div class="main-content-inner">

				<!-- /section:basics/content.breadcrumbs -->
				<div class="page-content">

					<div class="row">
						<div class="col-xs-12">
							<!-- PAGE CONTENT BEGINS -->
							<div id="main-widget-container">
								<div class="row">
									<div class="col-sm-12 widget-container-col"
										id="widget-container-col-13">
										<div class="widget-box transparent" id="widget-box-13">
											<div class="widget-header">

												<h4 class="widget-title lighter">
													<i class="ace-icon fa fa-upload"></i> 版本上传
												</h4>

												<div class="widget-toolbar no-border">
													<ul class="nav nav-tabs" id="myTab2">
														<li class="active">
															<a data-toggle="tab" href="#patchupload">
																<i class="ace-icon fa fa-share red"></i>版本发布
															</a>
														</li>

														<li>
														     <a data-toggle="tab" href="#patchDetail">
														          <i class="ace-icon fa fa-file-text red"></i>版本详情
														      </a>
														</li>
													</ul>
												</div>
											</div>

											<div class="widget-body">
												<div
													class="widget-main padding-12 no-padding-left no-padding-right">
													<div class="tab-content padding-4">
														<div id="patchupload" class="tab-pane in active">
															<div>
																<form action="/iqms-web/basicconfig/patchversion"  class="dropzone well" enctype="multipart/form-data"
																	id="dropzone">
																	<div class="fallback">
																		<input name="patchFile" type="file" multiple="" />
																	</div>
																</form>
															</div>

															<div id="preview-template" class="hide">
																<div class="dz-preview dz-file-preview">
																	<!-- 缩略图 -->
																	<div class="dz-image">
																		<img data-dz-thumbnail="" />
																	</div>
																	<!-- 上传文件详情 -->
																	<div class="dz-details">
																		<!--文件大小-->
																		<div class="dz-size">
																			<span data-dz-size=""></span>
																		</div>
																		<!--文件名称-->
																		<div class="dz-filename">
																			<span data-dz-name=""></span>
																		</div>
																	</div>

																	<!-- 文件上传时显示的样式 -->
																	<div class="dz-progress">
																		<span class="dz-upload" data-dz-uploadprogress=""></span>
																	</div>

																	<!-- 服务器返回的文本信息 -->
																	<div class="dz-error-message">
																		<span data-dz-errormessage=""></span>
																	</div>

																	<!-- 文件上传成功-->
																	<div class="dz-success-mark">
																		<span class="fa-stack fa-lg bigger-150"> <i
																			class="fa fa-circle fa-stack-2x white"></i> <i
																			class="fa fa-check fa-stack-1x fa-inverse green"></i>
																		</span>
																	</div>

																	<!-- 文件上传失败 -->
																	<div class="dz-error-mark">
																		<span class="fa-stack fa-lg bigger-150"> <i
																			class="fa fa-circle fa-stack-2x white"></i> <i
																			class="fa fa-remove fa-stack-1x fa-inverse red"></i>
																		</span>
																	</div>
																</div>
															</div>
															<!-- PAGE CONTENT ENDS -->
														</div>

														<div id="patchDetail" class="tab-pane">
														<!-- 展示版本列表数据 -->
														
														</div>
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>

								<hr />
							</div>
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
	<!-- /.main-container -->

</body>

</html>