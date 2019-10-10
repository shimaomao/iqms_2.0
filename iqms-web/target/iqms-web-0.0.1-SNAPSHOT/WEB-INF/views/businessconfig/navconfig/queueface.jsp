<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<sec:authentication property="principal" var="currentUser" />
<!DOCTYPE>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>取号配置</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description"
	content="Charisma, a fully featured, responsive, HTML5, Bootstrap admin template.">

<%@ include file="/WEB-INF/views/shared/bootstrapcontentui.jsp"%>
<link id="bs-css"
	href="${staticPath}/static/components/ticket/css/bootstrap-11.min.css"
	rel="stylesheet">
<link href="${staticPath}/static/components/ticket/css/charisma-app.css"
	rel="stylesheet">
<link href='${staticPath}/static/components/ticket/css/chosen.min.css'
	rel='stylesheet'>
<link href='${staticPath}/static/components/ticket/css/colorbox.css'
	rel='stylesheet'>
<link
	href='${staticPath}/static/components/ticket/css/responsive-tables.css'
	rel='stylesheet'>
<link
	href='${staticPath}/static/components/ticket/css/bootstrap-tour.min.css'
	rel='stylesheet'>
<link href='${staticPath}/static/components/ticket/css/jquery.noty.css'
	rel='stylesheet'>
<link
	href='${staticPath}/static/components/ticket/css/noty_theme_default.css'
	rel='stylesheet'>
<link href='${staticPath}/static/components/ticket/css/elfinder.min.css'
	rel='stylesheet'>
<link
	href='${staticPath}/static/components/ticket/css/elfinder.theme.css'
	rel='stylesheet'>
<link
	href='${staticPath}/static/components/ticket/css/jquery.iphone.toggle.css'
	rel='stylesheet'>
<link href='${staticPath}/static/components/ticket/css/uploadify.css'
	rel='stylesheet'>
<link href='${staticPath}/static/components/ticket/css/animate.min.css'
	rel='stylesheet'>
<link href="${staticPath}/static/components/ticket/images/favicon.ico"
	rel="shortcut icon">

<link href="${staticPath}/static/components/ticket/css/spectrum.css"
	rel="stylesheet">
<link href="${staticPath}/static/components/ticket/css/image-picker.css"
	rel="stylesheet">
<link
	href="${staticPath}/static/components/ticket/css/contextmenu_css/contextmenu.css"
	rel="stylesheet" />
<link
	href="${staticPath}/static/components/ticket/css/icon-fonts/elusive-icons-2.0.0/css/elusive-icons.min.css"
	rel="stylesheet" />
<link
	href="${staticPath}/static/components/ticket/css/icon-fonts/font-awesome-4.2.0/css/font-awesome.min.css"
	rel="stylesheet" />
<link
	href="${staticPath}/static/components/ticket/css/icon-fonts/ionicons-1.5.2/css/ionicons.min.css"
	rel="stylesheet" />
<link
	href="${staticPath}/static/components/ticket/css/icon-fonts/map-icons-2.1.0/css/map-icons.min.css"
	rel="stylesheet" />
<link
	href="${staticPath}/static/components/ticket/css/icon-fonts/material-design-1.1.1/css/material-design-iconic-font.min.css"
	rel="stylesheet" />
<link
	href="${staticPath}/static/components/ticket/css/icon-fonts/octicons-2.1.2/css/octicons.min.css"
	rel="stylesheet" />
<link
	href="${staticPath}/static/components/ticket/css/icon-fonts/typicons-2.0.6/css/typicons.min.css"
	rel="stylesheet" />
<link
	href="${staticPath}/static/components/ticket/css/icon-fonts/weather-icons-1.2.0/css/weather-icons.min.css"
	rel="stylesheet" />
<link
	href="${staticPath}/static/components/ticket/css/jplayer.blue.monday.css"
	rel="stylesheet" />
<link
	href="${staticPath}/static/components/ticket/css/bootstrap-iconpicker.css" />

<script
	src="${staticPath}/static/components/ticket/js/lib/jquery/plugins/jquery.string.js"></script>
<script
	src="${staticPath}/static/components/ticket/js/lib/jquery/plugins/jquery.json.js"></script>
<script
	src="${staticPath}/static/components/ticket/js/lib/jquery/plugins/jquery.cycle.js"></script>
<script
	src="${staticPath}/static/components/ticket/js/jquery.ui.core.js"></script>
<script
	src="${staticPath}/static/components/ticket/js/jquery.ui.widget.js"></script>
<script
	src="${staticPath}/static/components/ticket/js/jquery.ui.mouse.js"></script>
<script
	src="${staticPath}/static/components/ticket/js/lib/easyui/plugins/jquery.draggable.js"></script>
<script
	src="${staticPath}/static/components/ticket/js/lib/easyui/plugins/jquery.parser.js"></script>
<script src="${staticPath}/static/components/ticket/js/config.js"></script>
<script src="${staticPath}/static/components/ticket/js/peripheral.js"></script>
<script
	src="${staticPath}/static/components/ticket/js/image-picker.min.js"></script>
<script
	src="${staticPath}/static/components/ticket/js/jquery.contextmenu.js"></script>
<script
	src="${staticPath}/static/components/ticket/js/iconset/iconset-all.min.js"></script>
<script
	src="${staticPath}/static/components/ticket/js/bootstrap-iconpicker.js"></script>
<script
	src="${staticPath}/static/components/ticket/js/jquery.metadata.js"></script>
<script
	src="${staticPath}/static/components/ticket/js/jquery.validate.js"></script>
<script src="${staticPath}/static/components/ticket/js/qmsVld.js"></script>
<script src="${staticPath}/static/components/ticket/js/map.js"></script>
<script
	src="${staticPath}/static/components/ticket/js/lib/jquery/plugins/jquery.jplayer.min.js"></script>
<script
	src="${staticPath}/static/components/ticket/js/lib/jquery/plugins/jplayer.playlist.min.js"></script>
<%-- <script
	src="${staticPath}/static/js/businessconfig/navconfig/redirect.js"></script> --%>

<style type="text/css">
.close {
	position: absolute;
	border: 0px solid red;
	z-index: 100;
	right: 0;
	top: 0;
	width: 45px;
	height: 18px;
	float: right;
	background:
		url(${staticPath}/static/components/ticket/images/q/1/sh.png)
		no-repeat 0px 0px;
}

.close:hover {
	background:
		url(${staticPath}/static/components/ticket/images/q/1/sh.png)
		no-repeat 0px -25px;
}

.clone {
	position: absolute;
	border: 1px solid rgba(221, 221, 221, 0.46);
	text-align: -webkit-match-parent;
	box-sizing: border-box;
	list-style: none;
	font-weight: normal;
}

.over {
	border: 1px solid black;
}

.selected {
	background: blue;
}

.site {
	display: table;
	background-size: 100% 100%;
	margin: 0;
	text-align: left;
	-moz-box-shadow: 1px 1px 3px #333;
	-webkit-box-shadow: 1px 1px 3px #333;
	box-shadow: 1px 1px 3px #333;
	position: absolute;
	text-align: center;
}

.site:hover {
	border: 1px #fff solid;
	box-shadow: 0px 0px 2px #fff;
	margin-left: 1px;
	margin-top: 1px;
}

.site a {
	display: table-cell;
	vertical-align: middle;
	text-align: center;
}
</style>
</head>

<script type="text/javascript">
	var mdStyleId = '${styleId}';
	var mdStyleName = '${styleName}';
	var mdOrgId = '${orgId}';
	var mdDeviceNo = '${deviceNo}';
	var mdDeviceName = '${deviceName}';
	var mdScreenResolution = '${screenResolution}';
	var mdDef = '${def}';
	//alert(mdStyleId+"|"+styleName+"|"+orgId+"|"+deviceNo+"|"+deviceName+"|"+screenResolution+"|"+def);
</script>

<body>
	<div class="ch-container">
		<div class="row">
			<noscript>
				<div class="alert alert-block col-md-12">
					<h4 class="alert-heading">Warning!</h4>
				</div>
			</noscript>

			<div id="content" class="col-lg-12 col-sm-12">
				<div class="widget-header">
					<h4 class="widget-title ">
						<i
							class="ace-icon fa fa-hand-o-right icon-animated-hand-pointer blue"></i>
						配置向导
					</h4>
					<div class="widget-toolbar no-border">
						<a href="#" data-action="collapse"> <i
							class="ace-icon fa fa-chevron-up bigger-160 blue"></i>
						</a>
					</div>
				</div>
				<div>
					<!-- #section:plugins/fuelux.wizard.steps -->
					<ul class="steps">
						<li data-step="1" class="complete" onclick="redirect(this)"><span
							class="step">1</span> <span class="title">创建设备</span></li>

						<li data-step="2" class="complete" onclick="redirect(this)"><span
							class="step">2</span> <span class="title">快速应用</span></li>

						<li data-step="3" class="complete" onclick="redirect(this)"><span
							class="step">3</span> <span class="title">窗口配置</span></li>

						<li data-step="4" class="complete" onclick="redirect(this)"><span
							class="step">4</span> <span class="title">网点业务</span></li>

						<li data-step="5" class="complete" onclick="redirect(this)"><span
							class="step">5</span> <span class="title">号票模板</span></li>

						<li data-step="6" class="complete" onclick="redirect(this)"><span
							class="step">6</span> <span class="title">业务显示</span></li>

						<li data-step="7" class="complete" onclick="redirect(this)"><span
							class="step">7</span> <span class="title">客户等级</span></li>

						<li data-step="8" class="complete" onclick="redirect(this)"><span
							class="step">8</span> <span class="title">客户识别</span></li>

						<li data-step="9" class="complete" onclick="redirect(this)"><span
							class="step">9</span> <span class="title">叫号策略</span></li>

						<li data-step="10" class="active"><span class="step">10</span>
							<span class="title">取号界面</span></li>

						<li data-step="11"><span class="step">11</span> <span
							class="title">配置检测</span></li>

					</ul>
				</div>
				<form id="frm" name="frm" method="post" action="">
					<div class="row" id="ticketEdit1">
						<div class="box col-md-12">
							<div class="box-inner">
								<div class="box-header well" data-original-title="">
									<h2>
										<i class="glyphicon glyphicon-info-sign"></i> <label
											name="tktName"> A</label>模板 基础信息
									</h2>
									<div class="box-icon">
										<a href="#" class="btn btn-minimize btn-round btn-default"><i
											class="glyphicon glyphicon-chevron-up"></i></a>
									</div>
								</div>
								<div class="box-content">
									<table>
										<tbody>
											<tr>
												<td style="text-align: left; width: 10%">模板名称<span
													class="star">*</span>
												</td>
												<td style="text-align: left; width: 40%"><input
													maxlength='50' validate="{required:true,maxlength:50}"
													class="form-control" name="styleName" id="styleName"
													placeholder="请输入模板名称"></td>
												<td style="text-align: left; width: 10%">默认模板<span
													class="star"></span>
												</td>
												<td><input type="checkbox" id="def" disabled="disabled"
													readonly="readonly"></td>
											</tr>
										</tbody>
									</table>
								</div>
							</div>
						</div>
					</div>
					<div class="row" id="ticketEdit">
						<div class="box col-md-2">
							<div class="box-inner">
								<div class="box-header well" data-original-title="">
									<h2>
										<i class="glyphicon glyphicon-info-sign"></i>元素列表
									</h2>
									<div class="box-icon">
										<a href="#" class="btn btn-minimize btn-round btn-default"><i
											class="glyphicon glyphicon-chevron-up"></i></a>
									</div>
								</div>
								<div class="box-content">
									<ul class="nav nav-pills nav-stacked main-menu" id="ctrList">
									</ul>
								</div>
							</div>
						</div>
						<!--/span-->
						<div class="box col-md-6">
							<div class="box-inner">
								<div class="box-header well" data-original-title="">
									<h2>
										<i class="glyphicon glyphicon-info-sign"></i> <label
											name="tktName"> win8风格</label>模板 拖动配置（比例尺 1:3）
									</h2>
									<div class="box-icon">
										<a href="#" class="btn btn-minimize btn-round btn-default"><i
											class="glyphicon glyphicon-chevron-up"></i></a>
									</div>
								</div>
								<div class="box-content">
									<div style="line-height: 50px;">
										<span>屏幕分辨率：</span> <span class="controls"> <select
											id="screenResolution" data-rel="chosen" style="width: 100px;">
										</select>
										</span><span style="margin-left: 10px;">日期类型：</span> <span
											class="controls"> <select id="dateTypeId"
											data-rel="chosen" style="width: 70px;">
												<option value="1">平日</option>
												<option value="2">假日</option>
										</select>
										</span><span class="controls"
											style="margin-left: 10px; font-size: 20px;"> <input
											type="checkbox" id="copyStatus"><label
											for="copyStatus">平日同假日</label>
										</span>
									</div>
									<ul id="myTab" class="nav nav-tabs">
									</ul>
									<input type="hidden" id="myhidden" value="${staticPath}">
									<div id="myTabContent" class="tab-content"
										style="border: 0px #056498 solid; text-align: center"></div>
									<div>
										<p class="center" style="margin-top: 30px;">
											<button class="btn btn-success btn-prev" id="prev" type="button" onclick="back()">
												<i class="ace-icon fa fa-arrow-left"></i> 上一步
											</button>

											<input type="submit" class="btn btn-info" id="saveConfig"
												value="保存配置">
												
											<button class="btn btn-success btn-next" data-last="Finish"
												id="next" type="button" onclick="nextStep()">
												下一步 <i class="ace-icon fa fa-arrow-right icon-on-right"></i>
											</button>
										</p>
									</div>
								</div>
								<div id="dragPanel"
									style="display: none; position: absolute; z-index: 999; left: 100px; top: 40px; width: 320px; height: 350px; padding: 15px; background: #fafafa; border: 1px solid #ccc;">
									<div>
										<button type="button" class="close" data-dismiss="modal">
											×</button>
									</div>
									<div>
										<a href="javascript:up();"
											style="background: url(../../images/up.png) 0 0 no-repeat; width: 64px; height: 64px; line-height: 64px; display: inline-block;"></a><a
											href="javascript:down();"
											style="background: url(../../images/down.png) 0 0 no-repeat; width: 64px; height: 64px; line-height: 64px; display: inline-block;"></a><a
											href="javascript:left();"
											style="background: url(../../images/left.png) 0 0 no-repeat; width: 64px; height: 64px; line-height: 64px; display: inline-block;"></a><a
											href="javascript:right();"
											style="background: url(../../images/right.png) 0 0 no-repeat; width: 64px; height: 64px; line-height: 64px; display: inline-block;"></a>
									</div>
									<div style="margin: 20px; font-size: 24px;">
										<label> <input type="checkbox" id="allItems"
											checked="checked" />&nbsp;整体移动
										</label>
									</div>
									<table>
										<tbody>
											<tr>
												<td>移&nbsp;&nbsp;动&nbsp;&nbsp;单&nbsp;&nbsp;位：</td>
												<td><input id="moveUnit" style="width: 60px;"
													maxlength="4" value="5" type="email" class="form-control"
													id="exampleInputEmail1" placeholder="5"></td>
												<td>像素</td>
											</tr>
											<tr>
												<td>打印机偏移 X：</td>
												<td><input id="offsetX" style="width: 60px;"
													maxlength="4" type="email" class="form-control"
													id="exampleInputEmail1" placeholder="0"></td>
												<td>毫米</td>
											</tr>
											<tr>
												<td>打印机偏移 Y：</td>
												<td><input id="offsetY" style="width: 60px;"
													maxlength="4" type="email" class="form-control"
													id="exampleInputEmail1" placeholder="0"></td>
												<td>毫米</td>
											</tr>
										</tbody>
									</table>
								</div>
							</div>
						</div>
						<div class="box col-md-4">
							<div class="box-inner">
								<div class="box-header well" data-original-title="">
									<h2>
										<i class="glyphicon glyphicon-info-sign"></i> <label
											name="tktName"> win8风格</label>模板 设置
									</h2>
									<div class="box-icon">
										<a href="#" class="btn btn-minimize btn-round btn-default"><i
											class="glyphicon glyphicon-chevron-up"></i></a>
									</div>
								</div>
								<div class="box-content">
									<table>
										<tbody>
											<tr>
												<td>元素类型</td>
												<td colspan="3">
													<div class="controls">
														<select id="ctrStyle" data-rel="chosen" disabled
															style="width: 140px;">
														</select>
													</div>
												</td>
											</tr>
											<tr>
												<td>背景颜色</td>
												<td><input class="form-control" id="backgroundColor">
												</td>
												<td>图片</td>
												<td><img
													style="width: 50px; height: 30px; border: 1px solid #dddddd;"
													id="backgroundImage" name="backgroundImage" src="" /></td>
											</tr>
											<tr>
												<td>X<input style="width: 50px; height: 30px;"
													class="form-control" maxlength='4' id="x" placeholder="">
												</td>
												<td>Y<input style="width: 50px; height: 30px;"
													class="form-control" maxlength='4' id="y" placeholder="">
												</td>
												<td>宽<input style="width: 50px; height: 30px;"
													class="form-control" maxlength='4' id="width"
													placeholder="">
												</td>
												<td>高<input style="width: 50px; height: 30px;"
													class="form-control" maxlength='4' id="height"
													placeholder="">
												</td>
											</tr>
											<tr>
											</tr>
											<tr style="display: none;">
												<td>形状</td>
												<td colspan="3">
													<div class="controls">
														<select id="shape" data-rel="chosen" style="width: 140px;">
															<option value="normal">常规</option>
															<option value="hexagon">多边形</option>
														</select>
													</div>
												</td>
											</tr>
											<tr>
												<td>阴影效果</td>
												<td colspan="3">
													<div class="controls">
														<select id="shadow" data-rel="chosen"
															style="width: 140px;">
															<option value="normal">无阴影</option>
															<option value="shadow">阴影</option>
														</select>
													</div>
												</td>
											</tr>
											<tr>
												<td>水平阴影<input style="width: 50px; height: 30px;"
													class="form-control" value="0" maxlength='3' id="shadowH"
													placeholder="">
												</td>
												<td>垂直阴影<input style="width: 50px; height: 30px;"
													class="form-control" value="0" maxlength='3' id="shadowV"
													placeholder="">
												</td>
												<td>距离<input style="width: 50px; height: 30px;"
													class="form-control" value="0" maxlength='3'
													id="shadowBlur" placeholder="">
												</td>
												<td></td>
											</tr>
											<tr>
												<td>倾&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;斜
												</td>
												<td colspan="3">
													<div class="controls">
														<select id="skew" data-rel="chosen" style="width: 140px;">
															<option value="normal">常规</option>
															<option value="skew">倾斜</option>
														</select>
													</div>
												</td>
											</tr>
											<tr>
												<td>水平<input style="width: 50px; height: 30px;"
													class="form-control" value="0" maxlength='3' id="skewH"
													placeholder="">
												</td>
												<td>垂直<input style="width: 50px; height: 30px;"
													class="form-control" value="0" maxlength='3' id="skewV"
													placeholder="">
												</td>
												<td></td>
												<td></td>
											</tr>
											<tr>
												<td>圆&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;角
												</td>
												<td colspan="3">
													<div class="controls">
														<select id="borderRadius" data-rel="chosen"
															style="width: 140px;">
															<option value="normal">常规</option>
															<option value="borderRadius">圆角</option>
														</select>
													</div>
												</td>
											</tr>
											<tr>
												<td>左上角<input style="width: 50px; height: 30px;"
													class="form-control" value="0" maxlength='3' id="topLeft1"
													placeholder=""><input
													style="width: 50px; height: 30px;" class="form-control"
													value="0" maxlength='3' id="topLeft2" placeholder="">
												</td>
												<td>右上角<input style="width: 50px; height: 30px;"
													class="form-control" value="0" maxlength='3' id="topRight1"
													placeholder=""><input
													style="width: 50px; height: 30px;" class="form-control"
													value="0" maxlength='3' id="topRight2" placeholder="">
												</td>
												<td>右下角<input style="width: 50px; height: 30px;"
													class="form-control" value="0" maxlength='3'
													id="bottomRight1" placeholder=""><input
													style="width: 50px; height: 30px;" class="form-control"
													value="0" maxlength='3' id="bottomRight2" placeholder="">
												</td>
												<td>左下角<input style="width: 50px; height: 30px;"
													class="form-control" value="0" maxlength='3'
													id="bottomLeft1" placeholder=""><input
													style="width: 50px; height: 30px;" class="form-control"
													value="0" maxlength='3' id="bottomLeft2" placeholder="">
												</td>
											</tr>
											<tr>
												<td>旋&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;转
												</td>
												<td colspan="3">
													<div class="controls">
														<select id="rotate" data-rel="chosen"
															style="width: 140px;">
															<option value="normal">常规</option>
															<option value="rotate">旋转</option>
														</select>
													</div>
												</td>
											</tr>
											<tr>
												<td>X轴<input style="width: 50px; height: 30px;"
													class="form-control" value="0" maxlength='3'
													id="angleOfRotationX" placeholder="">
												</td>
												<td>Y轴<input style="width: 50px; height: 30px;"
													class="form-control" value="0" maxlength='3'
													id="angleOfRotationY" placeholder="">
												</td>
												<td>Z轴<input style="width: 50px; height: 30px;"
													class="form-control" value="0" maxlength='3'
													id="angleOfRotationZ" placeholder="">
												</td>
											</tr>
											<tr>
												<td>字&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;体
												</td>
												<td colspan="3">
													<div class="controls">
														<select id="fontFamily" data-rel="chosen"
															style="width: 140px;">
															<option value="SimHei" style="font-family: SimHei;">黑体</option>
															<option value="SimSun" style="font-family: SimSun;">宋体</option>
															<option value="Microsoft YaHei"
																style="font-family: Microsoft YaHei;">微软雅黑</option>
															<option value="Arial" style="font-family: Arial;">Arial</option>
															<option value="Helvetica" style="font-family: Helvetica;">Helvetica</option>
															<option value="sans-serif"
																style="font-family: sans-serif;">sans-serif</option>
														</select>
													</div>
												</td>
											</tr>
											<tr>
												<td>字&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;形
												</td>
												<td colspan="3">
													<div class="controls">
														<select id="fontStyle" data-rel="chosen"
															style="width: 140px;">
															<option value="normal" style="font-style: normal;">常规</option>
															<option value="italic" style="font-style: italic;">倾斜</option>
															<option value="bold" style="font-weight: bold;">粗体</option>
															<option value="boldAndItalic"
																style="font-weight: bold; font-style: italic;">粗体倾斜</option>
														</select>
													</div>
												</td>
											</tr>
											<tr>
												<td>大&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;小
												</td>
												<td colspan="3">
													<div class="controls">
														<select id="fontSize" data-rel="chosen"
															style="width: 140px;">
															<option value="16" style="font-size: 16px;">小四</option>
															<option value="14" style="font-size: 14px;">五号</option>
															<option value="12" style="font-size: 12px;">小五</option>
															<option value="10" style="font-size: 10px;">六号</option>
															<option value="8.7" style="font-size: 8.7px;">小六</option>
															<option value="7.3" style="font-size: 7.3px;">七号</option>
															<option value="6.7" style="font-size: 6.7px;">八号</option>
														</select>
													</div>
												</td>
											</tr>
											<tr>
												<td>文字颜色</td>
												<td colspan="3"><input class="form-control"
													id="fontColor"></td>
											</tr>
											<tr>
												<td>文字内容</td>
												<td colspan="3"><input class="form-control"
													maxlength='100' id="ctrText" placeholder="控件类型为固定文本时录入">
												</td>
											</tr>
											<tr>
												<td>特&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;效
												</td>
												<td colspan="3">
													<div class="controls">
														<select id="effect" data-rel="chosen"
															style="width: 140px;">
															<option value="normal" style="font-style: normal;">常规</option>
															<option value="marquee" style="font-style: normal;">跑马灯</option>
														</select>
													</div>
												</td>
											</tr>
											<tr>
												<td>速度</td>
												<td colspan="3">
													<div class="controls">
														<select id="scrollAmount" data-rel="chosen"
															style="width: 140px;">
															<option value="15" style="font-style: normal;">常规</option>
															<option value="5" style="font-style: normal;">超慢</option>
															<option value="10" style="font-style: normal;">慢</option>
															<option value="25" style="font-style: normal;">快</option>
															<option value="30" style="font-style: normal;">超快</option>
														</select>
													</div>
												</td>
											</tr>
											<tr>
												<td>方向</td>
												<td colspan="3">
													<div class="controls">
														<select id="direction" data-rel="chosen"
															style="width: 140px;">
															<option value="left" style="font-style: normal;">左</option>
															<option value="right" style="font-style: normal;">右</option>
															<option value="down" style="font-style: normal;">下</option>
															<option value="up" style="font-style: normal;">上</option>
														</select>
													</div>
												</td>
											</tr>
											<tr>
												<td>图&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;标
												</td>
												<td colspan="3">
													<button data-iconset="fontawesome"
														data-icon="fa-area-chart" id="icon" data-search="false"
														class="btn btn-default" data-placement="bottom"
														style="color: #0E0D0D !important; background-color: #fff !important"
														role="iconpicker"></button>
												</td>
											</tr>
											<tr>
												<td>图标位置</td>
												<td colspan="3">
													<div id="btn-icon-positions" class="btn-group">
														<button class="btn btn-default" value="left" type="button"
															style="color: #0E0D0D !important; background-color: #fff !important">
															<span class="glyphicon glyphicon-arrow-left"></span>左
														</button>
														<button class="btn btn-default" value="right"
															type="button"
															style="color: #0E0D0D !important; background-color: #fff !important">
															右<span class="glyphicon glyphicon-arrow-right"></span>
														</button>
													</div>
												</td>
											</tr>
											<%-- <tr>
												<td>音&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;量
												</td>
												<td colspan="3" id="voiceTr"><span style="width: 4%;">
														<img id="isMute"
														src="${staticPath}/static/components/ticket/images/voice/yl.png"
														style="margin-top: 100px" />
												</span> <span style="width: 4%;"> <img
														src="${staticPath}/static/components/ticket/images/voice/voice1.png"
														onclick="setVoice(10,2)"
														style="width: 15px; margin-top: 88px" />
												</span> <span style="width: 4%;"> <img
														src="${staticPath}/static/components/ticket/images/voice/voice2.png"
														onclick="setVoice(20,3)"
														style="width: 15px; margin-top: 65px" />
												</span> <span style="width: 4%;"> <img
														src="${staticPath}/static/components/ticket/images/voice/voice3.png"
														onclick="setVoice(40,4)"
														style="width: 15px; margin-top: 55px" />
												</span> <span style="width: 4%;"> <img
														src="${staticPath}/static/components/ticket/images/voice/voice4.png"
														onclick="setVoice(60,5)"
														style="width: 15px; margin-top: 35px" />
												</span> <span style="width: 4%;"> <img
														src="${staticPath}/static/components/ticket/images/voice/voice5.png"
														onclick="setVoice(80,6)"
														style="width: 15px; margin-top: 15px" />
												</span> <span style="width: 4%;"> <img
														src="${staticPath}/static/components/ticket/images/voice/voice6.png"
														onclick="setVoice(100,7)"
														style="width: 15px; margin-top: -5px" />
												</span> <span id="volume" style="width: 6%;">20</span></td>
											</tr> --%>
										</tbody>
									</table>
								</div>
							</div>
						</div>
					</div>
					<!--/row-->
				</form>
				<div>
				</div>
				<!-- content ends -->
			</div>
		</div>
		<hr>
		<!-- 打开后的模态框 -->
		<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
			aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">
							X</button>
						<h3 id="modalTitle">图片选择</h3>
					</div>
					<form id="frm" name="frm" method="post" action="">
						<div class="modal-body">
							<div class="box-content">
								<div>
									<div class="picker">
										<select id="myImagePicker"
											class="image-picker show-html show-labels">
										</select>
									</div>
								</div>
							</div>
						</div>
						<div class="modal-footer">
							<input type="hidden" id="objId" /> <input type="button"
								class="btn btn-default" data-dismiss="modal" value="取消">
							<input type="button" class="btn btn-primary"
								onclick="modelSubmit()" value="确定">
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>

	<script src="${staticPath}/static/components/ticket/js/spectrum.js"></script>
	<script
		src="${staticPath}/static/components/ticket/js/jquery.cookie.js"></script>
	<script
		src='${staticPath}/static/components/ticket/js/jquery.dataTables.min.js'></script>
	<script
		src="${staticPath}/static/components/ticket/js/chosen.jquery.min.js"></script>
	<script
		src="${staticPath}/static/components/ticket/js/jquery.colorbox-min.js"></script>
	<script src="${staticPath}/static/components/ticket/js/jquery.noty.js"></script>
	<script
		src="${staticPath}/static/components/ticket/js/responsive-tables.js"></script>
	<script
		src="${staticPath}/static/components/ticket/js/bootstrap-tour.min.js"></script>
	<script
		src="${staticPath}/static/components/ticket/js/jquery.raty.min.js"></script>
	<script
		src="${staticPath}/static/components/ticket/js/jquery.iphone.toggle.js"></script>
	<script
		src="${staticPath}/static/components/ticket/js/jquery.autogrow-textarea.js"></script>
	<script
		src="${staticPath}/static/components/ticket/js/jquery.uploadify-3.1.min.js"></script>
	<script
		src="${staticPath}/static/components/ticket/js/jquery.history.js"></script>

	<script
		src="${staticPath}/static/js/businessconfig/navconfig/queueface.js"></script>


</body>
</html>
