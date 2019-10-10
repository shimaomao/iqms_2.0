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
  <%@ include file="/WEB-INF/views/shared/bootstrapcontentui.jsp"%>
  <script src="${staticPath}/static/components/ticket/js/lib/jquery/plugins/jquery.string.js"></script>
  <script src="${staticPath}/static/js/businessconfig/navconfig/check.js"></script>
  <%-- <script src="${staticPath}/static/js/businessconfig/navconfig/redirect.js"></script> --%>
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
										<i class="ace-icon fa fa-hand-o-right icon-animated-hand-pointer blue"></i>
										配置向导
									</h4>
									<div class="widget-toolbar no-border">
										<a href="#" data-action="collapse"> <i
											class="ace-icon fa fa-chevron-up bigger-160 blue"></i>
										</a>
									</div>
								</div>
								<!-- widget 主体查询部分 -->
								<div class="widget-body" style="margin-top: 10px;" style="display: block;">
									<div>
										<!-- #section:plugins/fuelux.wizard.steps -->
										<ul class="steps">
											<li data-step="1" class="complete" onclick="redirect(this)"><span class="step">1</span>
												<span class="title">创建设备</span></li>
					
											<li data-step="2" class="complete" onclick="redirect(this)"><span class="step">2</span>
												<span class="title">快速应用</span></li>
					
											<li data-step="3" class="complete" onclick="redirect(this)"><span class="step">3</span>
												<span class="title">窗口配置</span></li>
					
											<li data-step="4" class="complete" onclick="redirect(this)"><span class="step">4</span>
												<span class="title">网点业务</span></li>
					
											<li data-step="5" class="complete" onclick="redirect(this)"><span class="step">5</span>
												<span class="title">号票模板</span></li>
					
											<li data-step="6" class="complete" onclick="redirect(this)"><span class="step">6</span> <span
												class="title">业务显示</span></li>
					
											<li data-step="7" class="complete" onclick="redirect(this)"><span class="step">7</span> <span
												class="title">客户等级</span></li>
					
											<li data-step="8" class="complete" onclick="redirect(this)"><span class="step">8</span> <span
												class="title">客户识别</span></li>
					
											<li data-step="9" class="complete" onclick="redirect(this)"><span class="step">9</span> <span
												class="title">叫号策略</span></li>
					
											<li data-step="10" class="complete" onclick="redirect(this)"><span class="step">10</span> <span
												class="title">取号界面</span></li>
					
											<li data-step="11" classs="active" id="checkPic"><span class="step">11</span> <span
												class="title">配置检测</span></li>
					
										</ul>
									</div>
								</div>
							</div>
						</div>
					</div>
					<!-- widget 条件搜索 end -->
					
					<!-- 空行 -->
					<div class="space-6"></div>
					
					<div class="box-content">
		                <div class="progress">
			                <input type="hidden" name="orgId" id="orgId" value="${orgId}" /> 
			                <input type="hidden" name="deviceNo" id="deviceNo" value="${deviceNo}" />
							<%-- <input type="hidden" name="devName" id="devName" value="${devName}" /> 
							<input type="hidden" name="orgName" id="orgName" value="${orgName}" /> --%>
		                  <div class="progress-bar" role="progressbar" style="width: 0%;" id="progressbar">
		                    <span>0%</span>
		                  </div>
		                </div>
		                <div style="line-height: 50px;">
		                  	进度条/检测结果 颜色说明:<span class="alert-danger ace-icon fa fa-times red2">红色表示错误</span>&nbsp;&nbsp;<span class="alert-warning  ace-icon fa fa-exclamation-triangle">黄色表示警告</span>&nbsp;&nbsp;<span class="alert-success ace-icon fa fa-check">绿色表示检测通过</span></div>
		                <div class="alert alert-info" id="info">
		                </div>
		             </div>
					<div class="wizard-actions">
						<p class="center" style="margin-top: 30px;">
							<!-- #section:plugins/fuelux.wizard.buttons -->
							<button class="btn btn-success btn-prev" id="prev" onclick="back()">
								<i class="ace-icon fa fa-arrow-left"></i> 上一步
							</button>
						</p>
					</div>
				</div>
			</div>
			
		</div>
		<!-- /.main-content -->
	</div>
</body>
</html>
