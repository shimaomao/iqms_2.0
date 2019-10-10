package com.aoto.iqms.basicconfig.models;

import com.aoto.framework.commons.pagination.PaginationQuery;

public class OrderConfigQuery extends PaginationQuery{
	private static final long serialVersionUID = -4218111140293664309L;
	private String orgId;//查询
	private String orgDevicelist;
	private String deviceNo;//查询
	
	
	public String getDeviceNo() {
		return deviceNo;
	}
	public void setDeviceNo(String deviceNo) {
		this.deviceNo = deviceNo;
	}
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
	
	
}
