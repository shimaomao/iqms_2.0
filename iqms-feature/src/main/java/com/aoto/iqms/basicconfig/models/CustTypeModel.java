package com.aoto.iqms.basicconfig.models;

import com.aoto.framework.commons.beans.Model;

/**
 * 客户类型
 * 
 * @author daxian
 * 
 */
public class CustTypeModel implements Model {
	private static final long serialVersionUID = -4623159755481759427L;
	private String custLevel;// 客户等级代码
	private String custName;// 客户等级名称
	private String smsFlag;// 是否发送短信
	private String presentFlag;// 是否送礼物
	private String expend1;// 扩展1
	private String expend2;// 扩展2
	private String expend3;// 扩展3
	private String waitTimeout;//等待超时时长 20170412
	private String vipFlag;// 是否vip
	private String isUse;// 是否使用
	public String getCustLevel() {
		return custLevel;
	}
	public void setCustLevel(String custLevel) {
		this.custLevel = custLevel;
	}
	
	public String getCustName() {
		return custName;
	}
	public void setCustName(String custName) {
		this.custName = custName;
	}
	public String getSmsFlag() {
		return smsFlag;
	}
	public void setSmsFlag(String smsFlag) {
		this.smsFlag = smsFlag;
	}
	public String getPresentFlag() {
		return presentFlag;
	}
	public void setPresentFlag(String presentFlag) {
		this.presentFlag = presentFlag;
	}
	public String getExpend1() {
		return expend1;
	}
	public void setExpend1(String expend1) {
		this.expend1 = expend1;
	}
	public String getExpend2() {
		return expend2;
	}
	public void setExpend2(String expend2) {
		this.expend2 = expend2;
	}
	public String getExpend3() {
		return expend3;
	}
	public void setExpend3(String expend3) {
		this.expend3 = expend3;
	}
	public String getWaitTimeout() {
		return waitTimeout;
	}
	public void setWaitTimeout(String waitTimeout) {
		this.waitTimeout = waitTimeout;
	}
	public String getIsUse() {
		return  isUse;
	}
	public void setIsUse(String isUse) {
		this.isUse = isUse;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	public String getVipFlag() {
		return vipFlag;
	}
	public void setVipFlag(String vipFlag) {
		this.vipFlag = vipFlag;
	}
	
}
