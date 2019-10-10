/**
 * 点击向导栏图标跳转到指定页面
 * @param e
 */
function redirect(e){
	if(e.getAttribute("data-step")=='1'){
		//跳转到创建设备
	 	window.location.href = encodeURI(contextPath + "/businessconfig/navconfig/backdevice?dt="+(new Date().getTime())
	 	+"&deviceNo="+$("#deviceNo").val()+"&devName="+$("#devName").val());
	}else if(e.getAttribute("data-step")=='2'){
		//跳转到快速应用
     	window.location.href = encodeURI(contextPath + "/businessconfig/navconfig/copyToOrg?dt="+(new Date().getTime())
     	+"&deviceNo="+deviceNo+"&orgId="+orgId+"&devName="+devName
     	+"&orgName="+orgName);
	}else if(e.getAttribute("data-step")=='3'){
		//跳转到窗口配置
	 	window.location.href = encodeURI(contextPath + "/businessconfig/navconfig/winconfig?dt="+(new Date().getTime())
	 	+"&deviceNo="+deviceNo+"&orgId="+orgId+"&devName="+devName
     	+"&orgName="+orgName);
	}else if(e.getAttribute("data-step")=='4'){
		//跳转到网点业务
	 	window.location.href = encodeURI(contextPath + "/businessconfig/navconfig/branchbus?dt="+(new Date().getTime())
	 	+"&deviceNo="+$("#deviceNo").val()+"&orgId="+$("#orgId").val()+"&devName="+devName
     	+"&orgName="+orgName);
	}else if(e.getAttribute("data-step")=='5'){
		window.location.href = encodeURI(contextPath + "/businessconfig/navconfig/showtime?dt="+(new Date().getTime())
		+"&deviceNo="+$("#deviceNo").val()+"&orgId="+$("#orgId").val()+"&devName="+devName
     	+"&orgName="+orgName);
	}else if(e.getAttribute("data-step")=='6'){
		window.location.href = encodeURI(contextPath + "/businessconfig/navconfig/ticketform?dt="+(new Date().getTime())
		+"&deviceNo="+$("#deviceNo").val()+"&orgId="+$("#orgId").val()+"&devName="+devName
     	+"&orgName="+orgName);
	}else if(e.getAttribute("data-step")=='7'){
		window.location.href = encodeURI(contextPath + "/businessconfig/navconfig/custlevel?dt="+(new Date().getTime())
		+"&deviceNo="+$("#deviceNo").val()+"&orgId="+$("#orgId").val()+"&devName="+devName
     	+"&orgName="+orgName);
	}else if(e.getAttribute("data-step")=='8'){
		window.location.href = encodeURI(contextPath + "/businessconfig/navconfig/recognition?dt="+(new Date().getTime())
		+"&deviceNo="+$("#deviceNo").val()+"&orgId="+$("#orgId").val()+"&devName="+devName
     	+"&orgName="+orgName);
	}else if(e.getAttribute("data-step")=='9'){
		window.location.href = encodeURI(contextPath + "/businessconfig/navconfig/callstrategy?dt="+(new Date().getTime())
		+"&deviceNo="+$("#deviceNo").val()+"&orgId="+$("#orgId").val()+"&devName="+devName
     	+"&orgName="+orgName);
	}else if(e.getAttribute("data-step")=='10'){
		window.location.href = encodeURI(contextPath + "/businessconfig/navconfig/queueface?dt="+(new Date().getTime())
	 	+"&deviceNo="+$("#deviceNo").val()+"&orgId="+$("#orgId").val()+"&devName="+devName
     	+"&orgName="+orgName);
	}
}