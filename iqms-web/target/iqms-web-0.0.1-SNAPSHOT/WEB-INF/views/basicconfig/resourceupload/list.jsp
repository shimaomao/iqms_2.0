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
<title>资源上传</title>

<meta name="description"
	content="Dynamic tables and grids using jqGrid plugin" />
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0" />

<link
	href="${staticPath}/static/components/bootstrap-datetimepicker/css/bootstrap-datetimepicker.css"
	rel="stylesheet">
<%@ include file="/WEB-INF/views/shared/selectOrg.jsp"%>

<link href="${staticPath}/static/components/ticket/css/bootstrap-11.min.css" rel="stylesheet">

<!-- 图片预览 -->
<link rel="stylesheet" href="${staticPath}/static/components/jqeryMasonry/dist/stylesheets/chromagallery.min.css">
<script src="${staticPath}/static/components/jqeryMasonry/dist/scripts/chromagallery.pkgd.min.js"></script>
<style type="text/css">
body,html
		{
			height: 100%;
		} 
		.content
		{
			width: 100%;
			height: 100%;
			margin: 10px auto;
		}
		@media screen and (min-width: 980px;max-height:500px;) /* Desktop */ {
		  .content {
		    width: 100%;
		  }
		}		
		.mygallery
		{
			margin: 15px 0;
		}
</style> 
<!-- 上传图片 -->
<link rel="stylesheet"
	href="${staticPath}/static/components/dropzone/dist/dropzone.css" />

<script src="${staticPath}/static/components/dropzone/dist/dropzone.js"></script>

<script src="${staticPath}/static/js/basicconfig/resourceupload/list.js"></script>
<script src="${staticPath}/static/js/basicconfig/resourceupload/datalist.js"></script>
</head>

<body class="no-skin">

	<!-- 引入增改查页面 -->
	<%@ include file="/WEB-INF/views/basicconfig/resourceupload/new.jsp"%>
	<div class="main-container ace-save-state" id="main-container">
		<!-- /section:basics/sidebar -->
		<div class="main-content">
			<div class="main-content-inner">
				<div id="dialog-new" class="hide">确定要下发吗？</div>
				<div id="dialog-remove" class="hide">确定要删除吗？</div>
				<!-- /section:basics/content.breadcrumbs -->
				<div class="page-content">
					<!--widget搜索条件 start-->
					<div class="row">
						<div class="col-sm-12 widget-container-col"
										id="widget-container-col-13">
							<div class="widget-box transparent"
								id="widget-box-13">
								<div class="widget-header">
									<h4 class="widget-title lighter">
										<i class="ace-icon fa fa-upload"></i> 资源上传
									</h4>

									<div class="widget-toolbar no-border">
										<ul class="nav nav-tabs" id="myTab2">
											<li class="active"><a data-toggle="tab"
												href="#fileShow" onclick="searchCondition()"> <i class="ace-icon fa fa-search red"></i>文件浏览
											</a></li>
											<li><a data-toggle="tab"
												href="#patchupload"> <i class="ace-icon fa fa-share red"></i>文件上传
											</a></li>

											<li><a data-toggle="tab" href="#patchDetail"> 
												<i class="ace-icon fa fa-file-text red"></i>上传记录
											</a></li>
										</ul>
									</div>
								</div>
								<!-- widget 主体查询部分 -->
								<div class="widget-body" style="margin-top: 10px;"
									style="display: block;">
									<div class="widget-main padding-12 no-padding-left no-padding-right">
										<div class="tab-content padding-4">
													<div id="fileShow" class="tab-pane in active">
													<form class="form-search form-inline" id="searchFrom">
														<div class="form-group">
															<label>选择目录：</label> <span class="input-icon"> <input
																type="text" placeholder="" value="" class="nav-search-input"
																name="dirName" id="dirName" autocomplete="off"
																onclick="selectFileTree(false,true,false,searchCondition)" /> <!-- 保存目录路径 -->
																<input type="hidden" name="dirPath" id="dirPath" value="" />
															</span>
														</div>
														<div class="form-group">
															<input type="checkbox" class="ace" id="checkAll"/>
															<span class="lbl">全选</span>
															<a class="btn btn-danger" href="#" onclick='del();'><i class="glyphicon glyphicon-trash icon-white"></i>删除</a>
															<span class="input-icon"></span>
															<a class="btn btn-info" href="#" onclick='zip();'><i class="ace-icon fa fa-cloud-upload bigger-150"></i>下发</a>
															<span class="input-icon"></span>
														</div>
														<div class="content">
														
														</div>
														</form>
													</div>
												<div id="patchupload" class="tab-pane">
															<div>
																<form action="/iqms-web/basicconfig/uploadfile"  class="dropzone well" enctype="multipart/form-data"
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
					<!-- widget 条件搜索 end -->
				</div>

			</div>
			<!-- /.main-content -->
		</div>
</body>

</html>