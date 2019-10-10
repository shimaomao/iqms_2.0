<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE>
<html lang="en">
<head>
  <meta charset="utf-8">
  <title>一键检测</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <meta name="description" content="Charisma, a fully featured, responsive, HTML5, Bootstrap admin template.">
  <meta name="author" content="Muhammad Usman">
  
  <%@ include file="/WEB-INF/views/shared/selectOrg.jsp"%>
  <script src="${staticPath}/static/js/businessconfig/onekeycheck/list.js"></script>
</head>
<body>

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
										<i class="ace-icon fa  fa-check-square-o"></i>
										配置检测
															
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
												onclick="selectOrgDeviceTree(${currentUser.orgId},true,false,false,check)" />
												<!-- 保存机构id -->
											 <input type="hidden" name="orgId" id="orgId" value="" />
											 <input type="hidden" name="deviceNo"id="deviceNo" value="" />
											 <input type="hidden" name="orgName" id="orgName" value="" />
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
					
					<div class="box-content">
		                <div class="progress">
		                  <div class="progress-bar" role="progressbar" style="width: 0%;" id="progressbar">
		                    <span>0%</span>
		                  </div>
		                </div>
		                <div style="line-height: 50px;">
		                  进度条/检测结果 颜色说明:<span class="alert-danger ace-icon fa fa-times red2">红色表示错误</span>&nbsp;&nbsp;<span class="alert-warning  ace-icon fa fa-exclamation-triangle">黄色表示警告</span>&nbsp;&nbsp;<span class="alert-success ace-icon fa fa-check">绿色表示检测通过</span></div>
		                <div class="alert alert-info" id="info">
		                </div>
		             </div>
					
				</div>
			</div>
			
		</div>
		<!-- /.main-content -->
	</div>
</body>
</html>
