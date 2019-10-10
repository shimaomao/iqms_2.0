package com.aoto.iqms.monitor.models;

import com.aoto.framework.commons.pagination.PaginationQuery;

/**
 * 查询对象
 * @author tianjm 20190304
 *
 */
public class SqlSelectQuery extends PaginationQuery{
	private static final long serialVersionUID = 5214805260096934432L;
	private String selectInfo;
	public String getSelectInfo() {
		return selectInfo;
	}
	public void setSelectInfo(String selectInfo) {
		this.selectInfo = selectInfo;
	}
	
}
