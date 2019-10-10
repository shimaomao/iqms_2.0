package com.aoto.iqms.externals.models.deviceregist;

import java.io.Serializable;

/**
 * 设备注册响应数据部分
 * @author hongxz
 *
 */
public class DeviceRegistData implements Serializable {

	private String orgId = "";   //系统内部机构id
	private String orgCode = ""; //银行机构编码
	private String deviceId = "";  //设备ID
	private String orgName = "";   //机构名称
	private String orderFlag = "";  //是否预约
	private String screenResolution = "";  //是否预约
	
	//20171017 by hongxz 
	private boolean onlineModel;  // true-联网    false-单机 
	private String  tpscrollflag;  // 1-条屏滚动     0-直接显示
	
	private String flowPort;  //流水上报端口
	private String identPort;  //客户识别端口
	private String httpPort;  //版本下载端口
	private String appRoot;  //项目根目录
	
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
	public String getIdentPort() {
		return identPort;
	}
	public void setIdentPort(String identPort) {
		this.identPort = identPort;
	}
	public String getHttpPort() {
		return httpPort;
	}
	public void setHttpPort(String httpPort) {
		this.httpPort = httpPort;
	}
	public boolean isOnlineModel() {
		return onlineModel;
	}
	public void setOnlineModel(boolean onlineModel) {
		this.onlineModel = onlineModel;
	}
	public String getTpscrollflag() {
		return tpscrollflag;
	}
	public void setTpscrollflag(String tpscrollflag) {
		this.tpscrollflag = tpscrollflag;
	}
	public String getOrgName() {
		return orgName;
	}
	public void setOrgName(String orgName) {
		this.orgName = orgName;
	}
	public String getOrderFlag() {
		return orderFlag;
	}
	public void setOrderFlag(String orderFlag) {
		this.orderFlag = orderFlag;
	}
	public String getOrgId() {
		return orgId;
	}
	public void setOrgId(String orgId) {
		this.orgId = orgId;
	}
	public String getOrgCode() {
		return orgCode;
	}
	public void setOrgCode(String orgCode) {
		this.orgCode = orgCode;
	}
	public String getDeviceId() {
		return deviceId;
	}
	public void setDeviceId(String deviceId) {
		this.deviceId = deviceId;
	}
	public String getScreenResolution() {
		return screenResolution;
	}
	public void setScreenResolution(String screenResolution) {
		this.screenResolution = screenResolution;
	}
}
