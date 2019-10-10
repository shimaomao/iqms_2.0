package com.aoto.iqms.basicconfig.models;

import com.aoto.framework.commons.pagination.PaginationQuery;

/**
 * 版本查询类
 * @author daxian
 *
 */
public class PatchVersionQuery extends PaginationQuery {
	
	private static final long serialVersionUID = 6918402218800828656L;
	private String patchDate;//更新包日期
	private String status; //记录状态
	
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getPatchDate() {
		return patchDate;
	}
	public void setPatchDate(String patchDate) {
		this.patchDate = patchDate;
	}
	
	
}
