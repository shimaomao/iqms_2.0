package com.aoto.iqms.basicconfig.models;

import com.aoto.framework.commons.pagination.PaginationQuery;

/**
 * 查询对象
 * @author humz
 *
 */
public class BusinessManageQuery extends PaginationQuery{

	private static final long serialVersionUID = -1967319357215492343L;
	private String businessName;//业务名称
	
	public String getBusinessName() {
		return businessName;
	}
	public void setBusinessName(String businessName) {
		this.businessName = businessName;
	}

}
