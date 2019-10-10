package com.aoto.iqms.basicconfig.models;

import com.aoto.framework.commons.beans.Model;

/**
 * 参数配置类
 * @author zhousj
 *
 */
public class ParameterModel implements Model{

    private static final long serialVersionUID = 2255184909809383287L;
    private String hbInterval;//心跳间隔（分钟）
    private String authenticationType;//鉴权模式
    
    private String flowPort;//流水上传端口
    private String httpPort;//http端口
    private String identPort;//客户识别端口
    private String appRoot;//工程名
    
    
    public String getAppRoot() {
		return appRoot;
	}

	public void setAppRoot(String appRoot) {
		this.appRoot = appRoot;
	}

	public String getFlowPort() {
		return flowPort;
	}

	public void setFlowPort(String flowPort) {
		this.flowPort = flowPort;
	}

	public String getHttpPort() {
		return httpPort;
	}

	public void setHttpPort(String httpPort) {
		this.httpPort = httpPort;
	}

	public String getIdentPort() {
		return identPort;
	}

	public void setIdentPort(String identPort) {
		this.identPort = identPort;
	}

	public String getHbInterval() {
		return hbInterval;
	}

	public void setHbInterval(String hbInterval) {
		this.hbInterval = hbInterval;
	}

	public String getAuthenticationType() {
		return authenticationType;
	}

	public void setAuthenticationType(String authenticationType) {
		this.authenticationType = authenticationType;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}
}
