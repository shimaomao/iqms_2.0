package com.aoto.iqms.report.models;

import com.aoto.framework.commons.pagination.PaginationQuery;

/**
 * 柜员评价报表-查询字段
 * @author humz
 *
 */
public class EmpAppraiseReportQuery extends PaginationQuery {
	
	private static final long serialVersionUID = 5800647846718954005L;
	
	private String orgId; //机构ID
	private String workName;//柜员姓名
	private String startDate; //查询开始时间
	private String endDate; //查询结束日期
	
	public String getOrgId() {
		return orgId;
	}
	public void setOrgId(String orgId) {
		this.orgId = orgId;
	}
	public String getWorkName() {
		return workName;
	}
	public void setWorkName(String workName) {
		this.workName = workName;
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
