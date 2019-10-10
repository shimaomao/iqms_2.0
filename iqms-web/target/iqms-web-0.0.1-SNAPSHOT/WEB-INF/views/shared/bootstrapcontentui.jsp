<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<sec:authentication property="principal" var="currentUser" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />

<!-- bootstrap 内容显示区的公用文件 -->

<!-- bootstrap & fontawesome -->
<link rel="stylesheet" href="${staticPath}/static/components/assets/css/bootstrap.css" />
<link rel="stylesheet" href="${staticPath}/static/components/font-awesome/css/font-awesome.css" />

<!-- juqery ui & jqGrid -->
<link rel="stylesheet" href="${staticPath}/static/components/_mod/jquery-ui/jquery-ui.min.css" />
<link rel="stylesheet" href="${staticPath}/static/components/_mod/jqgrid/ui.jqgrid.min.css" />


<!-- 字体文件 -->
<link rel="stylesheet" href="${staticPath}/static/components/assets/css/ace-fonts.css" />
<link rel="stylesheet" href="${staticPath}/static/components/chosen/chosen.css" />

<!-- ace admin 样式 -->
<link rel="stylesheet" href="${staticPath}/static/components/assets/css/ace.css" class="ace-main-stylesheet" id="main-ace-style" />

<!-- 确认框样式 -->
<link rel="stylesheet" href="${staticPath}/static/components/jquery-confirm-master/dist/jquery-confirm.min.css" />

<!-- datetimepicker 样式 -->
<link rel="stylesheet" href="${staticPath}/static/components/bootstrap-datetimepicker/css/bootstrap-datetimepicker.css" />

<!--[if lte IE 9]>
	<link rel="stylesheet" href="${staticPath}/static/components/assets/css/ace-part2.css" class="ace-main-stylesheet" />
<![endif]-->
<link rel="stylesheet" href="${staticPath}/static/components/assets/css/ace-skins.css" />
<link rel="stylesheet" href="${staticPath}/static/components/assets/css/ace-rtl.css" />

<!--[if lte IE 9]>
  <link rel="stylesheet" href="${staticPath}/static/components/assets/css/ace-ie.css" />
<![endif]-->

<!-- inline styles related to this page -->


<!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->

<!--[if lt IE 9]>
<script src="${staticPath}/static/assets/js/html5shiv.js"></script>
<script src="${staticPath}/static/assets/js/respond.min.js"></script>
<![endif]-->


<!--[if !IE]> -->
<script src="${staticPath}/static/components/jquery/dist/jquery.js"></script>

<!-- <![endif]-->

<!--[if IE]>
<script src="${staticPath}/static/components/jquery.1x/dist/jquery.js"></script>
<![endif]-->

<script src="${staticPath}/static/components/bootstrap/dist/js/bootstrap.js"></script>

<!-- page specific plugin scripts -->
<script src="${staticPath}/static/components/jqGrid/js/jquery.jqGrid.js"></script>
<script src="${staticPath}/static/components/jqGrid/js/i18n/grid.locale-cn.js"></script>

<!-- ace scripts -->
<script src="${staticPath}/static/components/assets/js/src/ace.js"></script>
<script src="${staticPath}/static/components/assets/js/src/ace.widget-box.js"></script>
<script src="${staticPath}/static/components/assets/js/src/ace.widget-on-reload.js"></script>

<!--jquery UI 插件-->
<script src="${staticPath}/static/components/jquery-ui/jquery-ui.js"></script>

<script src="${staticPath}/static/js/bootsrapcontentui.js"></script>


<!-- 弹出框 -->
<script src="${staticPath}/static/components/jquery-confirm-master/dist/jquery-confirm.min.js"></script>


<!-- 对象转json -->
<script src="${staticPath}/static/lib/jquery/plugins/jquery.json.js"></script>

<!-- jquery验证框架 -->
<script src="${staticPath}/static/components/jquery-validation/dist/jquery.validate.js"></script>
<script src="${staticPath}/static/components/jquery-validation/dist/additional-methods.js"></script>
<script src="${staticPath}/static/components/jquery-validation/dist/localization/messages_zh.js"></script>

<!-- datetimepicker js -->
<script src="${staticPath}/static/components/bootstrap-datetimepicker/js/bootstrap-datetimepicker.js"></script>
<script src="${staticPath}/static/components/bootstrap-datetimepicker/js/locales/bootstrap-datetimepicker.zh-CN.js"></script>

<script>
      var logBehaviorEnabled = ${logBehaviorEnabled};
      var contextPath = "${contextPath}";
      var staticPath = "${staticPath}";
      var functionJson = ${currentUser.functionJson};
      var locale ="<%= request.getLocale().getLanguage() %>";
</script>


