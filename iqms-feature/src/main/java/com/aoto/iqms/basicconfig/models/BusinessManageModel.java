package com.aoto.iqms.basicconfig.models;

import com.aoto.framework.commons.beans.Model;

/**
 * 业务管理
 * 
 * @author humz
 * 
 */

public class BusinessManageModel implements Model{

	private static final long serialVersionUID = -4032133443701378821L;
	private String businessId;//业务ID
	private String businessName;//业务名称
	private String averageTime;//业务平均办理时长
	private String orderFlag;//是否可预约
	private String businessEName;//英文名
	
	
	public String getBusinessEName() {
		return businessEName;
	}
	public void setBusinessEName(String businessEName) {
		this.businessEName = businessEName;
	}
	public String getBusinessId() {
		return businessId;
	}
	public void setBusinessId(String businessId) {
		this.businessId = businessId;
	}
	public String getBusinessName() {
		return businessName;
	}
	public void setBusinessName(String businessName) {
		this.businessName = businessName;
	}
	public String getAverageTime() {
		return averageTime;
	}
	public void setAverageTime(String averageTime) {
		this.averageTime = averageTime;
	}
	public String getOrderFlag() {
		return orderFlag;
	}
	public void setOrderFlag(String orderFlag) {
		this.orderFlag = orderFlag;
	}
	
}
