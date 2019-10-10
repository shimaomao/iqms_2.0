package com.aoto.iqms.monitor.models;

import com.aoto.framework.commons.pagination.PaginationQuery;

public class BscDeviceStatusQuery extends PaginationQuery{
	private static final long serialVersionUID = 8659758673419126845L;
	private String orgId;
	private String onLineFlag;
	public String getOrgId() {
		return orgId;
	}
	public void setOrgId(String orgId) {
		this.orgId = orgId;
	}
	public String getOnLineFlag() {
		return onLineFlag;
	}
	public void setOnLineFlag(String onLineFlag) {
		this.onLineFlag = onLineFlag;
	}
	
}
