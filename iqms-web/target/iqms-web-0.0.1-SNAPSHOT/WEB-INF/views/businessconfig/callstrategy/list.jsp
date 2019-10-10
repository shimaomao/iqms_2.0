<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<sec:authentication property="principal" var="currentUser" />
<!DOCTYPE>
<html lang="en">
<head>
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
  <meta charset="utf-8">
  <title>叫号策略</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <meta name="description" content="Charisma, a fully featured, responsive, HTML5, Bootstrap admin template.">
  
  <%@ include file="/WEB-INF/views/shared/bootstrapcontentui.jsp"%>
  <%@ include file="/WEB-INF/views/shared/selectOrg.jsp"%>
  <link id="bs-css" href="${staticPath}/static/components/ticket/css/bootstrap-11.min.css" rel="stylesheet">
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
  <link href='${staticPath}/static/components/ticket/css/uploadify.css' rel='stylesheet'>
  <link href="${staticPath}/static/components/ticket/css/bootstrap-multiselect.css" rel="stylesheet" />
  <link href="${staticPath}/static/components/ticket/images/favicon.ico" rel="shortcut icon">
  
  
  <%-- <script src="${staticPath}/static/components/ticket/js/lib/jquery/jquery.js"></script> --%>
  <script src="${staticPath}/static/components/ticket/js/lib/jquery/plugins/jquery.string.js"></script>
  <script src="${staticPath}/static/components/ticket/js/lib/jquery/plugins/jquery.json.js"></script>
  <script src="${staticPath}/static/components/ticket/js/lib/easyui/plugins/jquery.draggable.js"></script>
  <script src="${staticPath}/static/components/ticket/js/lib/easyui/plugins/jquery.parser.js"></script>
  <script src="${staticPath}/static/components/ticket/js/config.js"></script>
  <script src="${staticPath}/static/components/ticket/js/jquery.metadata.js"></script>
  <script src="${staticPath}/static/components/ticket/js/jquery.validate.js"></script>
  <script src="${staticPath}/static/components/ticket/js/qmsVld.js"></script>
 

</head>
<body>
  
  <div class="ch-container">
    <div class="row">
      <noscript>
        <div class="alert alert-block col-md-12">
          <h4 class="alert-heading">
            Warning!
          </h4>
        </div>
      </noscript>
     
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
							<label>选择设备：</label> 
							<span class="input-icon">
							 <input type="text" placeholder="" value="" class="nav-search-input"
								name="devName" id="devName" autocomplete="off"
								onclick="selectOrgDeviceTree(${currentUser.orgId},true,false,false,searchCondition)" />
							 <!-- 保存机构id -->
							 <input type="hidden" name="orgId" id="orgId" value="" /> 
							 <input type="hidden" name="deviceNo" id="deviceNo" value="" />
							</span>
						</div>
						<%-- <div class="form-group" >
							<span class="input-group-btn" style="display:inline-block;">
								<button type="button"
									class="btn btn-white btn-info btn-bold"
									onclick="searchCondition();">
									<i
										class="ace-icon fa fa-search icon-on-right bigger-100 blue"></i>
									查询
								</button> <br />
							</span>
							<span style="display:inline-block;padding-left: 90px;">
								<p class="left" >
									<a class="btn btn-primary" href="#" id="CopyToOrg"
									onclick="orgDeviceTree(${currentUser.orgId})"><i class="glyphicon glyphicon-plus icon-white"></i>
									 应用到下级机构
									</a>
									<span class="input-icon"> 
										<!-- 保存机构id -->
									 <input type="hidden" name="orgDevicelist" id="orgDevicelist" value="" /> 
									</span>
								</p>
							</span>
						</div>  --%>
						
					</form>
				</div>
			</div>
	    </div>
	  </div>
      
      <!-- 空行 -->
	  <div class="space-6"></div>
	  
      <div id="content" class="col-lg-12 col-sm-12">
        <div class="row" id="ticketEdit">
          <div class="box col-md-3">
            <div class="box-inner">
              <div class="box-header well" data-original-title="">
                <h2>
                  <i class="glyphicon glyphicon-info-sign"></i>窗口列表</h2>
                <div class="box-icon">
                  <a href="#" class="btn btn-minimize btn-round btn-default"><i class="glyphicon glyphicon-chevron-up"></i></a>
                </div>
              </div>
              <div class="box-content">
                <ul class="nav nav-pills nav-stacked main-menu" id="counterList">
                </ul>
              </div>
            </div>
          </div>
          <!--/span-->
          <form id="frm">
          <div class="box col-md-9" style="margin-top: 0px;">
            <div class="row">
              <div class="box col-md-12">
                <div class="box-inner">
                  <div class="box-header well" data-original-title="">
                    <h2>
                      <i class="glyphicon glyphicon-info-sign"></i>窗口信息</h2>
                    <div class="box-icon">
                      <a href="#" class="btn btn-minimize btn-round btn-default"><i class="glyphicon glyphicon-chevron-up"></i></a>
                    </div>
                  </div>
                  <div class="box-content">
                    <table>
                      <tbody>
                        <tr>
                          <td style="text-align: right; width: 100px;">
                           	  窗口<span class="star">*</span>
                          </td>
                          <td>
                            <div class="controls">
                              <select id="myWinNum" validate="{required:true}" name="multiselect[]" multiple="multiple">
                              </select>
                            </div>
                          </td>
                        </tr>
                      </tbody>
                    </table>
                  </div>
                </div>
              </div>
            </div>
            <div class="row">
              <div class="box col-md-12">
                <div class="box-inner">
                  <div class="box-header well" data-original-title="">
                    <h2>
                      <i class="glyphicon glyphicon-info-sign"></i>
                                                          平日
                    </h2>
                    <div class="box-icon">
                      <a href="#" class="btn btn-minimize btn-round btn-default"><i class="glyphicon glyphicon-chevron-up"></i></a>
                    </div>
                  </div>
                  <div class="box-content">
                    <table class="table table-striped table-bordered" id="prList">
                      <thead>
                        <tr>
                          <th style="width: 10%;">
                            <input type="checkbox" id="checkbox1">
                          </th>
                          <th style="width: 20%;">
                            	业务代码
                          </th>
                          <th style="width: 25%;">
                            	业务名称
                          </th>
                          <th style="width: 25%;">
                          	  优先时间（分钟）<span class="star">*</span>
                          </th>
                          <th style="width: 20%;">
                         	   操作
                          </th>
                        </tr>
                      </thead>
                      <tbody>
                        &nbsp;
                      </tbody>
                    </table>
                  </div>
                </div>
              </div>
            </div>
            <div class="row">
              <div class="box col-md-12">
                <div class="box-inner">
                  <div class="box-header well" data-original-title="">
                    <h2>
                      <i class="glyphicon glyphicon-info-sign"></i>假日</h2>
                    <div class="box-icon">
                      <a href="#" class="btn btn-minimize btn-round btn-default"><i class="glyphicon glyphicon-chevron-up"></i></a>
                    </div>
                  </div>
                  <div class="box-content">
                    <table class="table table-striped table-bordered" id="jrList">
                      <thead>
                        <tr>
                          <th style="width: 10%;">
                            <input type="checkbox" id="checkbox2">
                          </th>
                          <th style="width: 20%;">
                          	  业务代码
                          </th>
                          <th style="width: 25%;">
                          	  业务名称
                          </th>
                          <th style="width: 25%;">
                                                                              优先时间（分钟）<span class="star">*</span>
                          </th>
                          <th style="width: 20%;">
                                                                             操作
                          </th>
                        </tr>
                      </thead>
                      <tbody>
                        &nbsp;
                      </tbody>
                    </table>
                  </div>
                </div>
              </div>
            </div>
            <div>
              <p class="center">
                <input id="saveConfig" type="submit" class="btn btn-success" value="保存配置">
              </p>
            </div>
          </div>
          </form>
        </div>
      </div>
    </div>
  
    <!-- 打开后的模态框 -->
    <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
      <div class="modal-dialog">
        <form id="frmModal">
        <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal">
              X
            </button>
            <h3 id="modalTitle">
              	平日个人业务等级设置
            </h3>
          </div>
          <div class="modal-body">
            <div class="box-content">
              <table class="table table-striped table-bordered" id="djList">
            	<span class="controls" style="margin-left: 10px; font-size: 20px;">
                    <input type="checkbox" id="copyLevel"><label for="copyLevel">应用到该窗口所有业务</label>
                  </span>
                <thead>
                  <tr>
                    <th style="width: 10%;">
                      <input type="checkbox" id="checkboxModal">
                    </th>
                    <th style="width: 20%;">
                      	客户等级
                    </th>
                    <th style="width: 30%;">
                      	等级名称
                    </th>
                    <th style="width: 20%;">
                      	优先时间<br>
                        (分钟)<span class="star">*</span>
                    </th>
                    <th style="width: 20%;">
                      	最大等待时间<br>
                        (分钟)<span class="star">*</span>
                    </th>
                  </tr>
                </thead>
                <tbody>
                  &nbsp;
                </tbody>
              </table>
            </div>
          </div>
          <div class="modal-footer">
            <input type="button" class="btn btn-default" data-dismiss="modal" value="取消">
            <input type="submit" class="btn btn-primary" value="确定">
          </div>
        </div>
        <form>
      </div>
    </div>
  
  </div>
  
  <script src="${staticPath}/static/components/ticket/js/bootstrap.min.js"></script>
  <script src="${staticPath}/static/components/ticket/js/bootstrap-multiselect.js"></script>
  <script src="${staticPath}/static/components/ticket/js/jquery.cookie.js"></script>
  <script src='${staticPath}/static/components/ticket/js/jquery.dataTables.min.js'></script>
  <script src="${staticPath}/static/components/ticket/js/chosen.jquery.min.js"></script>
  <script src="${staticPath}/static/components/ticket/js/jquery.colorbox-min.js"></script>
  <script src="${staticPath}/static/components/ticket/js/jquery.noty.js"></script>
  <script src="${staticPath}/static/components/ticket/js/responsive-tables.js"></script>
  <script src="${staticPath}/static/components/ticket/js/bootstrap-tour.min.js"></script>
  <script src="${staticPath}/static/components/ticket/js/jquery.raty.min.js"></script>
  <script src="${staticPath}/static/components/ticket/js/jquery.iphone.toggle.js"></script>
  <script src="${staticPath}/static/components/ticket/js/jquery.autogrow-textarea.js"></script>
  <script src="${staticPath}/static/components/ticket/js/jquery.uploadify-3.1.min.js"></script>
  <script src="${staticPath}/static/components/ticket/js/jquery.history.js"></script>
  
  <script src="${staticPath}/static/js/businessconfig/callstrategy/list.js"></script>

</body>
</html>
