package com.aoto.iqms.businessconfig.models;

import com.aoto.framework.commons.beans.Model;

/**
*@author zsj
*@创建时间：2018年10月9日下午6:41:11
*/
public class BscSpecialDateModel implements Model{
	private static final long serialVersionUID = -7566016759901138742L;
	private String deviceNo;
	private String specialDate;
	private String dateType;
	private String saveStatus;
	private String orgDevicelist;//包含窗口要应用到得所有下级机构和设备号
	
	public String getSaveStatus() {
		return saveStatus;
	}
	public void setSaveStatus(String saveStatus) {
		this.saveStatus = saveStatus;
	}
	public String getDeviceNo() {
		return deviceNo;
	}
	public void setDeviceNo(String deviceNo) {
		this.deviceNo = deviceNo;
	}
	public String getSpecialDate() {
		return specialDate;
	}
	public void setSpecialDate(String specialDate) {
		this.specialDate = specialDate;
	}
	public String getDateType() {
		return dateType;
	}
	public void setDateType(String dateType) {
		this.dateType = dateType;
	}
	public String getOrgDevicelist() {
		return orgDevicelist;
	}
	public void setOrgDevicelist(String orgDevicelist) {
		this.orgDevicelist = orgDevicelist;
	}
}
