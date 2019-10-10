<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script src="${staticPath}/static/js/basicconfig/menu/edit.js"></script>
<!--模态窗口页面内容这里是一个表单-->
<div id="dialog-edit" class="hide">
	<form name="FormPost"  class="form-horizontal" onsubmit="return false;" style="width:350px;height:auto;">
		
		<div class="form-group">
			<label class="col-md-3 control-label no-padding-right" for="menuName"> 菜单名称 </label>
			<div class="col-md-9">
				<div class="clearfix">
					<input type="text" id="menuName" name="menuName"  placeholder="请输入汉字" class="col-md-9 col-sm-5" />
					<input type="hidden" id="menuId" name="menuId"/>
				</div>
			</div>
		</div>

		<div class="form-group">
			<label class="col-md-3 control-label no-padding-right" for="menuEnName"> 菜单英文名 </label>

			<div class="col-md-9">
			    <div class="clearfix">
					<input type="text" id="menuEnName" name="menuEnName" placeholder="请输入字母或数字" class="col-md-9 col-sm-5" />
				</div>
			</div>
		</div>
	</form>
</div>
<!-- #dialog-message -->