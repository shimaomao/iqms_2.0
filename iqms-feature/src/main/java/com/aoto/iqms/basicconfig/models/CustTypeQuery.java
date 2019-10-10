package com.aoto.iqms.basicconfig.models;

import com.aoto.framework.commons.pagination.PaginationQuery;

/**
 * 查询对象
 * @author daxian
 *
 */
public class CustTypeQuery extends PaginationQuery {
	
	private static final long serialVersionUID = 6918402218800828656L;
	private String custName;  //查询名称
	public String getCustName() {
		return custName;
	}
	public void setCustName(String custName) {
		this.custName = custName;
	}
	
}
