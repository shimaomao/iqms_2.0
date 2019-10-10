package com.aoto.iqms.businessconfig.models;

import com.aoto.framework.commons.beans.Model;

/**
 * 号码模板
 * @author humz
 */
public class NumberFormModel implements Model{

	private static final long serialVersionUID = -4098147154567076851L;
	private String tktFormatId ; //序号ID
	private String tktFormat ; //业务类型|客户等级|流量位数
	private String orgId;
	private String deviceNo;
	private String orgDevicelist;//包含机构id 设备编号
	
	
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

	public String getOrgDevicelist() {
		return orgDevicelist;
	}

	public void setOrgDevicelist(String orgDevicelist) {
		this.orgDevicelist = orgDevicelist;
	}

	public String getTktFormatId() {
		return tktFormatId;
	}

	public void setTktFormatId(String tktFormatId) {
		this.tktFormatId = tktFormatId;
	}

	public String getTktFormat() {
		return tktFormat;
	}

	public void setTktFormat(String tktFormat) {
		this.tktFormat = tktFormat;
	}
}
