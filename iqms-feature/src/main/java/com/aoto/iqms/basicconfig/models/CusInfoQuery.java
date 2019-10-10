package com.aoto.iqms.basicconfig.models;

import com.aoto.framework.commons.pagination.PaginationQuery;

/**
 * 查询对象
 * @author humz
 *
 */
public class CusInfoQuery extends PaginationQuery{

	private static final long serialVersionUID = 7092645348834527489L;
	private String orgId; //机构名称
	private String custId;//客户识别码(卡号，身份证号，手机号码等)
	private String custName;//客户姓名
	private String custLevel;//客户类型码
	
	public String getOrgId() {
		return orgId;
	}
	public void setOrgId(String orgId) {
		this.orgId = orgId;
	}
	public String getCustId() {
		return custId;
	}
	public void setCustId(String custId) {
		this.custId = custId;
	}
	public String getCustName() {
		return custName;
	}
	public void setCustName(String custName) {
		this.custName = custName;
	}
	public String getCustLevel() {
		return custLevel;
	}
	public void setCustLevel(String custLevel) {
		this.custLevel = custLevel;
	}
	

}
