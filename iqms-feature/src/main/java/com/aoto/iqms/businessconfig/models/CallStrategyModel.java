package com.aoto.iqms.businessconfig.models;

import java.util.List;
import java.util.Map;

import com.aoto.framework.commons.beans.Model;

/**
 * 叫号策略
 * @author humz
 *
 */
public class CallStrategyModel implements Model{

	private static final long serialVersionUID = -578808258099715666L;
	
	private String winId;
	private String counterId;
	private String dateTypeId;
	private String buzTypeId;
	private String levelId;
	private String buzPriorityTime;
	private String custPriorityTime;
	private String maxWaiting;
	private String orgId;
	private String deviceNo;
	private String orgDevicelist;//包含机构id 设备编号
	
	public String getOrgDevicelist() {
		return orgDevicelist;
	}

	public void setOrgDevicelist(String orgDevicelist) {
		this.orgDevicelist = orgDevicelist;
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

	public String getWinId() {
		return winId;
	}

	public void setWinId(String winId) {
		this.winId = winId;
	}

	public String getCounterId() {
		return counterId;
	}

	public void setCounterId(String counterId) {
		this.counterId = counterId;
	}

	public String getDateTypeId() {
		return dateTypeId;
	}

	public void setDateTypeId(String dateTypeId) {
		this.dateTypeId = dateTypeId;
	}

	public String getBuzTypeId() {
		return buzTypeId;
	}

	public void setBuzTypeId(String buzTypeId) {
		this.buzTypeId = buzTypeId;
	}

	public String getLevelId() {
		return levelId;
	}

	public void setLevelId(String levelId) {
		this.levelId = levelId;
	}

	public String getBuzPriorityTime() {
		return buzPriorityTime;
	}

	public void setBuzPriorityTime(String buzPriorityTime) {
		this.buzPriorityTime = buzPriorityTime;
	}

	public String getCustPriorityTime() {
		return custPriorityTime;
	}

	public void setCustPriorityTime(String custPriorityTime) {
		this.custPriorityTime = custPriorityTime;
	}

	public String getMaxWaiting() {
		return maxWaiting;
	}

	public void setMaxWaiting(String maxWaiting) {
		this.maxWaiting = maxWaiting;
	}

}
