package com.aoto.iqms.businessconfig.models;

import com.aoto.framework.commons.pagination.PaginationQuery;

public class NumberFormQuery extends PaginationQuery{
	private static final long serialVersionUID = 3507239006313065048L;
	private String orgId;
	private String deviceNo;
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
