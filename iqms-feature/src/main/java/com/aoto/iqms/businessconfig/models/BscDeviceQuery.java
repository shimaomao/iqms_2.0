package com.aoto.iqms.businessconfig.models;

import com.aoto.framework.commons.pagination.PaginationQuery;

public class BscDeviceQuery extends PaginationQuery {
	
	private static final long serialVersionUID = 6918402218800828656L;
	private String orgId; //机构名称
	
	private String islstversion; //是否是最新版本
	
	private String patchId; //版本号
	
	private String targetId;//用户所属机构id
	
	private String deviceNo;//设备号
	
	private String orgDevicelist;//包含机构id 设备编号 
	
	private String devName;//被应用到新增设备的设备名
	
	private String orgName;//设备所属机构名
	
	
	public String getOrgName() {
		return orgName;
	}
	public void setOrgName(String orgName) {
		this.orgName = orgName;
	}
	public String getDevName() {
		return devName;
	}
	public void setDevName(String devName) {
		this.devName = devName;
	}
	public String getOrgDevicelist() {
		return orgDevicelist;
	}
	public void setOrgDevicelist(String orgDevicelist) {
		this.orgDevicelist = orgDevicelist;
	}
	public String getDeviceNo() {
		return deviceNo;
	}
	public void setDeviceNo(String deviceNo) {
		this.deviceNo = deviceNo;
	}
	public String getTargetId() {
		return targetId;
	}
	public void setTargetId(String targetId) {
		this.targetId = targetId;
	}
	public String getPatchId() {
		return patchId;
	}
	public void setPatchId(String patchId) {
		this.patchId = patchId;
	}
	public String getIslstversion() {
		return islstversion;
	}
	public void setIslstversion(String islstversion) {
		this.islstversion = islstversion;
	}
	public String getOrgId() {
		return orgId;
	}
	public void setOrgId(String orgId) {
		this.orgId = orgId;
	}
	
	
	
}
