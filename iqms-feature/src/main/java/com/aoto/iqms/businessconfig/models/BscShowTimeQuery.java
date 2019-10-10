package com.aoto.iqms.businessconfig.models;

import com.aoto.framework.commons.pagination.PaginationQuery;

public class BscShowTimeQuery extends PaginationQuery{
	private static final long serialVersionUID = -4584895435010467259L;
	private String orgId;
	private String deviceNo;
	private String businessId;
	
	
	public String getBusinessId() {
		return businessId;
	}
	public void setBusinessId(String businessId) {
		this.businessId = businessId;
	}
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
