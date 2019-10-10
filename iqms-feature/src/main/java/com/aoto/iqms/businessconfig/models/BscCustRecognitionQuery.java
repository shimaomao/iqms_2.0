package com.aoto.iqms.businessconfig.models;

import com.aoto.framework.commons.pagination.PaginationQuery;

public class BscCustRecognitionQuery extends PaginationQuery{
	private static final long serialVersionUID = 4199976846447716944L;
	
	private String orgId;
	private String deviceNo;
	private String orgDevicelist;//包含机构id 设备编号 
	
	public String getOrgDevicelist() {
		return orgDevicelist;
	}
	public void setOrgDevicelist(String orgDevicelist) {
		this.orgDevicelist = orgDevicelist;
	}
	public String getOrgId() {
		return orgId;
	}
	public void setOrgId(String orgId) {
		this.orgId = orgId;
	}
	public String getDeviceNo() {
		return deviceNo;
	}
	public void setDeviceNo(String deviceNo) {
		this.deviceNo = deviceNo;
	}
	
}
