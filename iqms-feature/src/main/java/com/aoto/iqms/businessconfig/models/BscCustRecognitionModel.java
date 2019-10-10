package com.aoto.iqms.businessconfig.models;

import com.aoto.framework.commons.beans.Model;

/**
 * 客户识别
 * @author zhousj
 *
 */
public class BscCustRecognitionModel implements Model{
	private static final long serialVersionUID = 5783437072860738081L;
	private String orgId;
	private String deviceNo;
	private String rowId;
	private String dateType;
	private String startPosition;
	private String mateLength;
	private String startMateCode;
	private String endMateCode;
	private String custLevel;
	private String recognitionType;
	private String extend1;
	private String extend2;
	private String extend3;
	private String saveStatus;
	private String orgDevicelist;//包含窗口要应用到得所有下级机构和设备号
	
	
	public String getOrgDevicelist() {
		return orgDevicelist;
	}
	public void setOrgDevicelist(String orgDevicelist) {
		this.orgDevicelist = orgDevicelist;
	}
	public String getRecognitionType() {
		return recognitionType;
	}
	public void setRecognitionType(String recognitionType) {
		this.recognitionType = recognitionType;
	}
	public String getSaveStatus() {
		return saveStatus;
	}
	public void setSaveStatus(String saveStatus) {
		this.saveStatus = saveStatus;
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
	public String getRowId() {
		return rowId;
	}
	public void setRowId(String rowId) {
		this.rowId = rowId;
	}
	public String getDateType() {
		return dateType;
	}
	public void setDateType(String dateType) {
		this.dateType = dateType;
	}
	public String getStartPosition() {
		return startPosition;
	}
	public void setStartPosition(String startPosition) {
		this.startPosition = startPosition;
	}
	public String getMateLength() {
		return mateLength;
	}
	public void setMateLength(String mateLength) {
		this.mateLength = mateLength;
	}
	public String getStartMateCode() {
		return startMateCode;
	}
	public void setStartMateCode(String startMateCode) {
		this.startMateCode = startMateCode;
	}
	public String getEndMateCode() {
		return endMateCode;
	}
	public void setEndMateCode(String endMateCode) {
		this.endMateCode = endMateCode;
	}
	public String getCustLevel() {
		return custLevel;
	}
	public void setCustLevel(String custLevel) {
		this.custLevel = custLevel;
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
	
	
}
