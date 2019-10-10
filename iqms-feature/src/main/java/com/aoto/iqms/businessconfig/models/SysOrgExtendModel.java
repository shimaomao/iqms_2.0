package com.aoto.iqms.businessconfig.models;

import com.aoto.framework.commons.beans.Model;

/**
 * 机构
 * @author zhousj
 *
 */
public class SysOrgExtendModel implements Model{
	private static final long serialVersionUID = 7835248136017592539L;
	private String orgId;
	private String orgCode;
	private String orgName;
	public String getOrgId() {
		return orgId;
	}
	public void setOrgId(String orgId) {
		this.orgId = orgId;
	}
	public String getOrgCode() {
		return orgCode;
	}
	public void setOrgCode(String orgCode) {
		this.orgCode = orgCode;
	}
	public String getOrgName() {
		return orgName;
	}
	public void setOrgName(String orgName) {
		this.orgName = orgName;
	}
	
	
}
