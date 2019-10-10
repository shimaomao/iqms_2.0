package com.aoto.iqms.monitor.models;

import com.aoto.framework.commons.pagination.PaginationQuery;

/**
 * 查询对象
 * @author zhousj
 *
 */
public class TrxHistoryQuery extends PaginationQuery{
	private static final long serialVersionUID = 6840112491460492579L;
	private String orgId;
	public String getOrgId() {
		return orgId;
	}
	public void setOrgId(String orgId) {
		this.orgId = orgId;
	}
}
