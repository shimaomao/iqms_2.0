package com.aoto.iqms.businessconfig.models;

import com.aoto.framework.commons.pagination.PaginationQuery;

public class BscWinConfigQuery extends PaginationQuery{

	private static final long serialVersionUID = -2963834589493255695L;
	private String orgId;
	private String deviceNo;
	
	public String getDeviceNo() {
		return deviceNo;
	}
	public void setDeviceNo(String deviceNo) {
		this.deviceNo = deviceNo;
	}
	public String getOrgId() {
		return orgId;
	}
	public void setOrgId(String orgId) {
		this.orgId = orgId;
	}
	
	
}
