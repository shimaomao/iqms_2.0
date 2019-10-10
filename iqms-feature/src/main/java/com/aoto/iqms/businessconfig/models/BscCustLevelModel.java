package com.aoto.iqms.businessconfig.models;

import com.aoto.framework.commons.beans.Model;

/**
 * 客户等级
 * @author zhousj
 *
 */
public class BscCustLevelModel implements Model{

	private static final long serialVersionUID = 6532455123966389937L;
	private String orgId;
	private String deviceNo;
	private String custLevel;
	private String levelName;
	private String businessId;//绑定的业务ID
	private String priorTime;//优先时间
	private String callHead;//呼叫字头
	private String maxWaitTime;//最大等待时间
	private String ticketTemplate;//号票模板
	private String isStart;
	private String extend1;
	private String extend2;
	private String extend3;
	private String orgDevicelist;//包含机构id 设备编号
	private String rowId;//页面序号 同时代表固定客户级别
	
	
	public String getLevelName() {
		return levelName;
	}
	public void setLevelName(String levelName) {
		this.levelName = levelName;
	}
	public String getRowId() {
		return rowId;
	}
	public void setRowId(String rowId) {
		this.rowId = rowId;
	}
	public String getOrgId() {
		return orgId;
	}
	public void setOrgId(String orgId) {
		this.orgId = orgId;
	}
	public String getDeviceNo() {
		return deviceNo;
	}
	public void setDeviceNo(String deviceNo) {
		this.deviceNo = deviceNo;
	}
	public String getCustLevel() {
		return custLevel;
	}
	public void setCustLevel(String custLevel) {
		this.custLevel = custLevel;
	}
	public String getBusinessId() {
		return businessId;
	}
	public void setBusinessId(String businessId) {
		this.businessId = businessId;
	}
	public String getPriorTime() {
		return priorTime;
	}
	public void setPriorTime(String priorTime) {
		this.priorTime = priorTime;
	}
	public String getCallHead() {
		return callHead;
	}
	public void setCallHead(String callHead) {
		this.callHead = callHead;
	}
	public String getMaxWaitTime() {
		return maxWaitTime;
	}
	public void setMaxWaitTime(String maxWaitTime) {
		this.maxWaitTime = maxWaitTime;
	}
	public String getTicketTemplate() {
		return ticketTemplate;
	}
	public void setTicketTemplate(String ticketTemplate) {
		this.ticketTemplate = ticketTemplate;
	}
	public String getIsStart() {
		return isStart;
	}
	public void setIsStart(String isStart) {
		this.isStart = isStart;
	}
	public String getExtend1() {
		return extend1;
	}
	public void setExtend1(String extend1) {
		this.extend1 = extend1;
	}
	public String getExtend2() {
		return extend2;
	}
	public void setExtend2(String extend2) {
		this.extend2 = extend2;
	}
	public String getExtend3() {
		return extend3;
	}
	public void setExtend3(String extend3) {
		this.extend3 = extend3;
	}
	public String getOrgDevicelist() {
		return orgDevicelist;
	}
	public void setOrgDevicelist(String orgDevicelist) {
		this.orgDevicelist = orgDevicelist;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
}
