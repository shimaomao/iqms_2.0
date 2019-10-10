package com.aoto.iqms.businessconfig.models;

import com.aoto.framework.commons.pagination.PaginationQuery;

public class BscBranchBusinessQuery extends PaginationQuery{
	private static final long serialVersionUID = -7140246886116013358L;
	private String orgId;
	private String deviceNo;
	private String treeId;
	
	
	public String getTreeId() {
		return treeId;
	}
	public void setTreeId(String treeId) {
		this.treeId = treeId;
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
