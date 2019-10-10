<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<sec:authentication property="principal" var="currentUser" />
<!doctype html>
<html data-ng-app="FileManagerApp">
<head>
    <meta name="viewport" content="initial-scale=1.0, user-scalable=no">
    <meta charset="utf-8">
    <title>根目录</title>

    <!-- 第三方插件 -->
    <script src="${staticPath}/static/js/report/logManager/angular.min.js"></script>
    <script src="${staticPath}/static/js/report/logManager/angular-translate.min.js"></script>
    <script src="${staticPath}/static/js/report/logManager/ng-file-upload.min.js"></script>
    <script src="${staticPath}/static/js/report/logManager/jquery.min.js"></script>
    <script src="${staticPath}/static/js/report/logManager/bootstrap.min.js"></script>
    <link rel="stylesheet" href="${staticPath}/static/js/report/logManager/bootstrap.min.css"/>
    <link href="${staticPath}/static/js/report/logManager/angular-filemanager.min.css" rel="stylesheet">
    <script src="${staticPath}/static/js/report/logManager/angular-filemanager.min.js"></script>

    <script type="text/javascript">
        // 重写默认Config配置
        angular.module('FileManagerApp').config(['fileManagerConfigProvider', function (config) {
            var defaults = config.$get();
            config.set({
                appName: 'angular-filemanager',
                defaultLang: 'zh',
                listUrl: '/iqms/fileManager/list',
                uploadUrl: '/iqms/fileManager/upload/',
                downloadFileUrl: '/iqms/fileManager/preview/',
                createFolderUrl: '/iqms/fileManager/createFolder/',
                permissionsUrl: '/iqms/fileManager/changePermissions/',
                copyUrl: '/iqms/fileManager/copy/',
                moveUrl: '/iqms/fileManager/move/',
                removeUrl: '/iqms/fileManager/remove/',
                renameUrl: '/iqms/fileManager/rename/',
                getContentUrl: '/iqms/fileManager/getContent/',
                editUrl: '/iqms/fileManager/edit/',
                compressUrl: '/iqms/fileManager/compress/',
                extractUrl: '/iqms/fileManager/extract/',
                documentViewUrl: '/iqms/office/',
                pickCallback: function (item) {
                    var msg = 'Picked %s "%s" for external use'
                            .replace('%s', item.type)
                            .replace('%s', item.fullPath());
                    window.alert(msg);
                },

                allowedActions: angular.extend(defaults.allowedActions, {
                    pickFiles: false,
                    pickFolders: false,
                    downloadMultiple: false
                }),
                tplPath: 'app/templates'
            });
        }]);
    </script>
</head>

<body class="ng-cloak">
<angular-filemanager></angular-filemanager>
</body>
</html>

