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
<title>号票编辑</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description"
	content="Charisma, a fully featured, responsive, HTML5, Bootstrap admin template.">

<%@ include file="/WEB-INF/views/shared/bootstrapcontentui.jsp"%>
<%@ include file="/WEB-INF/views/shared/selectOrg.jsp"%>
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

<script
	src="${staticPath}/static/components/ticket/js/lib/jquery/plugins/jquery.string.js"></script>
<script
	src="${staticPath}/static/components/ticket/js/lib/jquery/plugins/jquery.json.js"></script>
<script
	src="${staticPath}/static/components/ticket/js/lib/easyui/plugins/jquery.draggable.js"></script>
<script
	src="${staticPath}/static/components/ticket/js/lib/easyui/plugins/jquery.parser.js"></script>
<script src="${staticPath}/static/components/ticket/js/config.js"></script>
<script src="${staticPath}/static/components/ticket/js/peripheral.js"></script>
<script
	src="${staticPath}/static/components/ticket/js/jquery.metadata.js"></script>
<script
	src="${staticPath}/static/components/ticket/js/jquery.validate.js"></script>
<script src="${staticPath}/static/components/ticket/js/qmsVld.js"></script>
<script src="${staticPath}/static/components/ticket/js/map.js"></script>

<style type="text/css">
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
</style>
</head>

<script type="text/javascript">

  //控制层返回过来的信息
  var norgId = '${orgId}';
  var ndeviceNo = '${deviceNo}';
  var nscreenResolution = '${screenResolution}';
  var ntktTmpId = '${tktTmpId}';
  var ntktTmpName = '${tktTmpName}';
  var ndef = '${def}';
  var ntktFormatId = '${tktFormatId}';


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
						<li data-step="1" class="complete"><span class="step">1</span>
							<span class="title">创建设备</span></li>

						<li data-step="2" class="complete"><span class="step">2</span>
							<span class="title">快速应用</span></li>

						<li data-step="3" class="complete"><span class="step">3</span>
							<span class="title">窗口配置</span></li>

						<li data-step="4" class="complete"><span class="step">4</span>
							<span class="title">网点业务</span></li>
						
						<li data-step="5" class="complete"><span class="step">5</span> <span
							class="title">业务显示</span></li>

						<li data-step="6" class="active"><span class="step">6</span>
							<span class="title">号票模板</span></li>

						<li data-step="7" ><span class="step">7</span> <span
							class="title">客户等级</span></li>

						<li data-step="8" ><span class="step">8</span> <span
							class="title">客户识别</span></li>

						<li data-step="9" ><span class="step">9</span> <span
							class="title">叫号策略</span></li>

						<li data-step="10" ><span class="step">10</span> <span
							class="title">取号界面</span></li>

						<li data-step="11"><span class="step">11</span> <span
							class="title">配置检测</span></li>
					</ul>
				</div>
				<!-- form begin -->
				<form id="frm" name="frm" method="post" action="">
					<!-- 基本模板编辑   begin  -->
					<div class="row" id="ti cketEdit1">
						<div class="box col-md-12">
							<div class="box-inner">
								<div class="box-header well" data-original-title="">
									<h2>
										<i class="glyphicon glyphicon-info-sign"></i>
										步骤一、选择一个已经配置好号票模板的设备，作为初始的号票模板
										<label name="tktName"></label>
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
												<td style="text-align: right; width: 30%">选择设备：
												</td>
												<td style="text-align: left; width: 30%">
													<input placeholder="" value="" class="form-control"
													name="deviceName" id="deviceName" autocomplete="off"
													onclick="selectTicketTree(${currentUser.orgId})"/>
												</td>
											</tr>
										</tbody>
									</table>
								</div>
							</div>
						</div>
					</div>
					<div class="row" id="ti cketEdit1">
						<div class="box col-md-12">
							<div class="box-inner">
								<div class="box-header well" data-original-title="">
									<h2>
										<i class="glyphicon glyphicon-info-sign"></i>
										步骤二、调整号票模板
										<label name="tktName"></label>
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
												<td style="text-align: right; width: 20%">模板名称<span
													class="star">*</span>
												</td>
												<td style="text-align: left; width: 20%"><input
													maxlength='50' validate="{required:true,maxlength:50}"
													class="form-control" name="tktTmpName" id="tktTmpName"
													placeholder="请输入号票模板名称"></td>
												<td style="text-align: right; width: 20%">默认模板<span
													class="star"></span>
												</td>
												<td><input type="checkbox" id="def" ></td>
												<td style="text-align: right; width: 20%">号码模板<span
													class="star">*</span>
												</td>
												<td style="text-align: right; width: 20%">
													<div class="controls">
														<select id="tktFormatId" validate="{required:true}"
															name="tktFormatId" data-rel="chosen"
															style="width: 215px;">
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
					<!-- 基本模板编辑   end  -->

					<!-- 号票设计页面 start  -->
					<div class="row" id="ticketEdit">
						<!-- 元素列表 start -->
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
										<li><a class="ajax-link" href="#"> <img
												style="width: 150px; height: 35px;"
												src="${staticPath}/static/components/ticket/images/logo2.png">
										</a> <input type="hidden" id="myhidden" value="${staticPath}">
										</li>
										<li><a class="ajax-link" href="#"><i
												class="glyphicon glyphicon-font"></i><span>固定文本</span></a></li>
										<li><a class="ajax-link" href="#"><i
												class="glyphicon glyphicon-briefcase"></i><span>业务名称</span></a>
										</li>
										<li><a class="ajax-link" href="#"><i
												class="glyphicon glyphicon-user"></i><span>等候人数</span></a></li>
										<li><a class="ajax-link" href="#"><i
												class="glyphicon glyphicon-time"></i><span>取号时间</span></a></li>
									</ul>
								</div>
							</div>
						</div>
						<!-- 元素列表 end -->

						<!--/span-->
						<!-- 号票设置主界面 start -->
						<div class="box col-md-6">
							<div class="box-inner">
								<div class="box-header well" data-original-title="">
									<h2>
										<i class="glyphicon glyphicon-info-sign"></i> <label
											name="tktName">  </label> 拖动配置
									</h2>
									<div class="box-icon">
										<a href="#" class="btn btn-round btn-default" id="up"><i
											class="glyphicon glyphicon-arrow-up"></i></a> <a href="#"
											class="btn btn-round btn-default" id="down"><i
											class="glyphicon glyphicon-arrow-down"></i></a> <a href="#"
											class="btn btn-round btn-default" id="showWin"><i
											class="glyphicon glyphicon-cog"></i></a> <a href="#"
											class="btn btn-minimize btn-round btn-default"><i
											class="glyphicon glyphicon-chevron-up"></i></a>
									</div>
								</div>
								<div class="box-content"
									style="border: 0px #056498 solid; text-align: center">
									<div
										style="padding: 0px; margin-right: auto; margin-left: auto; width: 310px; border: 0px #056498 solid;">
										<!-- 号票模板设计区域 -->
										<div id="ticket"
											style="position: relative; padding: 0px; margin: 0; width: 310px; height: 400px; border: 1px #056498 solid;">
										</div>
									</div>
									<div
										style="padding: 0px; margin-top: 20px; margin-right: auto; margin-left: auto; width: 310px; border: 0px #056498 solid;">
										<p class="center">
											<button class="btn btn-success btn-prev" id="prev" onclick="back()">
												<i class="ace-icon fa fa-arrow-left"></i> 上一步
											</button>
											<input type="submit" id="saveConfig" class="btn btn-info" value="保存配置" />
											<button class="btn btn-success btn-next" data-last="Finish" type="button" id="next" onclick="nextStep()">
												下一步 <i class="ace-icon fa fa-arrow-right icon-on-right"></i>
											</button>
										</p>
									</div>
								</div>
								<div id="dragPanel"
									style="display: none; position: absolute; z-index: 9999; left: 100px; top: 40px; width: 320px; height: 420px; background: #fafafa; border: 1px solid #ccc;">
									<div id="dragPanelTitle"
										style="width: 100%; height: 30px; background: #CCC000;">
										<button type="button" class="close" data-dismiss="modal"
											style="color: red; font-size: 30px">X</button>
									</div>
									<div style="padding: 15px 25px;">
										<div>
											<a href="javascript:up();"
												style="background: url(${staticPath}/static/components/ticket/images/up.png) 0 0 no-repeat; width: 64px; height: 64px; line-height: 64px; display: inline-block;"></a>
											<a href="javascript:down();"
												style="background: url(${staticPath}/static/components/ticket/images/down.png) 0 0 no-repeat; width: 64px; height: 64px; line-height: 64px; display: inline-block;"></a>
											<a href="javascript:left();"
												style="background: url(${staticPath}/static/components/ticket/images/left.png) 0 0 no-repeat; width: 64px; height: 64px; line-height: 64px; display: inline-block;"></a>
											<a href="javascript:right();"
												style="background: url(${staticPath}/static/components/ticket/images/right.png) 0 0 no-repeat; width: 64px; height: 64px; line-height: 64px; display: inline-block;"></a>
										</div>
										<div style="margin: 30px 70px; font-size: 24px;">
											<label style="font-size: 24px;"> <input
												type="checkbox" name="allItems" id="allItems" checked />&nbsp;整体移动
											</label>
										</div>
										<div>
											<table>
												<tbody>
													<tr>
														<td>移&nbsp;&nbsp;动&nbsp;&nbsp;单&nbsp;&nbsp;位：</td>
														<td><input id="moveUnit" name="moveUnit"
															style="width: 60px;" maxlength="4" value="5"
															class="form-control"></td>
														<td>像素</td>
													</tr>
													<tr>
														<td>打印机偏移 X：</td>
														<td><input id="offsetX" name="offsetX"
															style="width: 60px;" maxlength="4" value="0"
															class="form-control"></td>
														<td>毫米</td>
													</tr>
													<tr>
														<td>打印机偏移 Y：</td>
														<td><input id="offsetY" name="offsetY"
															style="width: 60px;" maxlength="4" value="0"
															class="form-control"></td>
														<td>毫米</td>
													</tr>
												</tbody>
											</table>
										</div>
									</div>
								</div>
							</div>
						</div>
						<!-- 号票设置主界面  end -->

						<!-- 元素属性 start -->
						<div class="box col-md-4">
							<div class="box-inner">
								<div class="box-header well" data-original-title="">
									<h2>
										<i class="glyphicon glyphicon-user"></i> <label name="tktName">
											 </label> 号票设置
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
														<select id="ctrStyle" data-rel="chosen"
															style="width: 140px;">
														</select>
													</div>
												</td>
											</tr>
											<tr>
												<td>文字内容</td>
												<td colspan="3"><input class="form-control"
													maxlength='100' id="ctrText" placeholder="控件类型为固定文本时录入">
												</td>
											</tr>
											<tr>
												<td>X</td>
												<td><input class="form-control" maxlength='4' id="x"
													placeholder=""></td>
												<td>Y</td>
												<td><input class="form-control" maxlength='4' id="y"
													placeholder=""></td>
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
															<option value="56"
																style="font-size: 56px; line-height: 60px;">初号</option>
															<option value="48"
																style="font-size: 48px; line-height: 50px;">小初</option>
															<option value="34.7"
																style="font-size: 34.7px; line-height: 40px;">一号</option>
															<option value="32"
																style="font-size: 32px; line-height: 35px;">小一</option>
															<option value="29.3" style="font-size: 29.3px;">二号</option>
															<option value="24" style="font-size: 24px;">小二</option>
															<option value="21.3" style="font-size: 21.3px;">三号</option>
															<option value="20" style="font-size: 20px;">小三</option>
															<option value="18.7" style="font-size: 18.7px;">四号</option>
															<option value="16" style="font-size: 16px;">小四</option>
															<option value="14" style="font-size: 14px;">五号</option>
															<option value="12" style="font-size: 12px;">小五</option>
															<option value="10" style="font-size: 10px;">六号</option>
															<option value="8.7" style="font-size: 8.7px;">小六</option>
															<option value="7.3" style="font-size: 7.3px;">七号</option>
															<option value="6.7" style="font-size: 6.7px;">八号</option>
															<!--
							<option value="10.5" style="font-size:10.5px;">8</option>
							<option value="12" style="font-size:12px;">9</option>
							<option value="14" style="font-size:14px;">10</option>
							<option value="15" style="font-size:15px;">11</option>
							<option value="16" style="font-size:16px;">12</option>
							<option value="18.7" style="font-size:18.7px;">14</option>
							<option value="21.3" style="font-size:21.3px;">16</option>
							<option value="24" style="font-size:24px;">18</option>
							<option value="26" style="font-size:26px;">20</option>
							<option value="29.3" style="font-size:29.3px;">22</option>
							<option value="32" style="font-size:32px;line-height:35px;">24</option>
							<option value="34.7" style="font-size:34.7px;line-height:40px;">26</option>
							<option value="36" style="font-size:36px;line-height:40px;">28</option>
							<option value="48" style="font-size:48px;line-height:50px;">36</option>
							<option value="65" style="font-size:65px;line-height:70px;">48</option>
							-->
														</select>
													</div>
												</td>
											</tr>
										</tbody>
									</table>
								</div>
							</div>
						</div>
						<!-- 元素属性 start -->
					</div>
					<!-- 号票设计页面 start  -->
				</form>
				<!-- form end -->
			</div>
		</div>
	</div>

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

	<script src="${staticPath}/static/js/businessconfig/navconfig/ticketform.js"></script>

</body>
</html>
