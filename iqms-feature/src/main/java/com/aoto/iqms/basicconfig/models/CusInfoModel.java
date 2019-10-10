package com.aoto.iqms.basicconfig.models;

import com.aoto.framework.commons.beans.Model;

/**
 * 本地客户
 * 
 * @author humz
 * 
 */

public class CusInfoModel implements Model{

	private static final long serialVersionUID = -1968970397943283167L;
	private String orgId;//机构ID
	private String orgName;//机构名称
	private String custId;//客户识别码(卡号，身份证号，手机号码等)
	private String custName;//客户姓名
	private String custLevel;//客户类型码(表BC_CUSTTYPE)
	private String custPdut;//客户开办产品
	private String custAd;//客户精准广告
	private String isBankEftve;//是否全行生效。1：是 0：否 ，默认全行生效，否则只在所加网点生效
	private String orgCode;
	
	public String getOrgCode() {
		return orgCode;
	}
	public void setOrgCode(String orgCode) {
		this.orgCode = orgCode;
	}
	public String getOrgId() {
		return orgId;
	}
	public void setOrgId(String orgId) {
		this.orgId = orgId;
	}
	public String getOrgName() {
		return orgName;
	}
	public void setOrgName(String orgName) {
		this.orgName = orgName;
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
	public String getCustPdut() {
		return custPdut;
	}
	public void setCustPdut(String custPdut) {
		this.custPdut = custPdut;
	}
	public String getCustAd() {
		return custAd;
	}
	public void setCustAd(String custAd) {
		this.custAd = custAd;
	}
	public String getIsBankEftve() {
		return isBankEftve;
	}
	public void setIsBankEftve(String isBankEftve) {
		this.isBankEftve = isBankEftve;
	}
	
	
	
}
