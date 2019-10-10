package com.aoto.iqms.report.models;

import com.aoto.framework.commons.pagination.PaginationQuery;

/**
 * 业务量报表-查询字段
 * @author humz
 *
 */
public class BusinessCountReportQuery extends PaginationQuery {
	
	private static final long serialVersionUID = 4110595798820836142L;
	
	private String orgId; //机构id
	private String busType;//业务类型
	private String startDate; //查询开始时间
	private String endDate; //查询结束日期
	
	public String getBusType() {
		return busType;
	}

	public void setBusType(String busType) {
		this.busType = busType;
	}

	public String getOrgId() {
		return orgId;
	}

	public void setOrgId(String orgId) {
		this.orgId = orgId;
	}

	public String getStartDate() {
		return startDate;
	}

	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}

	public String getEndDate() {
		return endDate;
	}

	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}
}
