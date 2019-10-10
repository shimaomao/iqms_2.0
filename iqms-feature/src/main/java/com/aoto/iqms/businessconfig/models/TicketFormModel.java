package com.aoto.iqms.businessconfig.models;

import com.aoto.framework.commons.beans.Model;

/**
 * 号票模板
 * @author humz
 *
 */
public class TicketFormModel implements Model{

	private static final long serialVersionUID = -830204853263600531L;
	
	private String tktTmpId ;//号票模板的序号ID
	private String tktTmpName ; //号票名称
	private String def ; //是否为默认模板
	private String tktFormatId ;//号码模板的序号ID
	private String tktFormat ;//号码模板序号的字符串值
	private String tktTmpStyle;//号票样式 
	private String orgId;
	private String deviceNo;
	private String orgDevicelist;//包含机构id 设备编号
	private String orgName;
	private String devName;
	
	
	public String getOrgName() {
		return orgName;
	}
	public void setOrgName(String orgName) {
		this.orgName = orgName;
	}
	public String getDevName() {
		return devName;
	}
	public void setDevName(String devName) {
		this.devName = devName;
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
	public String getOrgDevicelist() {
		return orgDevicelist;
	}
	public void setOrgDevicelist(String orgDevicelist) {
		this.orgDevicelist = orgDevicelist;
	}
	public String getTktTmpId() {
		return tktTmpId;
	}
	public void setTktTmpId(String tktTmpId) {
		this.tktTmpId = tktTmpId;
	}
	public String getTktTmpName() {
		return tktTmpName;
	}
	public void setTktTmpName(String tktTmpName) {
		this.tktTmpName = tktTmpName;
	}
	public String getDef() {
		return def;
	}
	public void setDef(String def) {
		this.def = def;
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
	public String getTktTmpStyle() {
		return tktTmpStyle;
	}
	public void setTktTmpStyle(String tktTmpStyle) {
		this.tktTmpStyle = tktTmpStyle;
	}
	
}
