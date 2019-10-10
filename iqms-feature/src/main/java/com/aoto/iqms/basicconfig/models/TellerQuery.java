package com.aoto.iqms.basicconfig.models;

import com.aoto.framework.commons.pagination.PaginationQuery;

public class TellerQuery extends PaginationQuery{

	private static final long serialVersionUID = 8786186323932673853L;
	private String name_;
	private String orgId;
	public String getName_() {
		return name_;
	}
	public void setName_(String name_) {
		this.name_ = name_;
	}
	public String getOrgId() {
		return orgId;
	}
	public void setOrgId(String orgId) {
		this.orgId = orgId;
	}
	
}
