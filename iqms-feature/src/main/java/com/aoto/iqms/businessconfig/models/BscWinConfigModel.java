package com.aoto.iqms.businessconfig.models;

import com.aoto.framework.commons.beans.Model;

/**
 * 窗口配置类
 * @author zhousj
 *
 */
public class BscWinConfigModel implements Model{

	private static final long serialVersionUID = -5308252739254306637L;
	private String orgId;//机构id
	private String deviceNo;//设备
	private String winNo;//窗口号
	private String isCall;//是否有呼叫器
	private String isJudge;//是否有评价器
	private String winScreen;//窗口屏
	private String multipleScreen;//综合屏
	private String isStart;//是否启用
	private String rowId;//页面显示序号
	private String saveStatus;
	private String extend1;
	private String extend2;
	private String extend3;
	private String orgName;//所属网点名称
	private String orgDevicelist;//包含窗口要应用到得所有下级机构和设备号
	private String winId;
	
	
	public String getWinId() {
		return winId;
	}
	public void setWinId(String winId) {
		this.winId = winId;
	}
	public String getOrgName() {
		return orgName;
	}
	public void setOrgName(String orgName) {
		this.orgName = orgName;
	}
	public String getSaveStatus() {
		return saveStatus;
	}
	public void setSaveStatus(String saveStatus) {
		this.saveStatus = saveStatus;
	}
	public String getRowId() {
		return rowId;
	}
	public void setRowId(String rowId) {
		this.rowId = rowId;
	}
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
	public String getWinNo() {
		return winNo;
	}
	public void setWinNo(String winNo) {
		this.winNo = winNo;
	}
	public String getIsCall() {
		return isCall;
	}
	public void setIsCall(String isCall) {
		this.isCall = isCall;
	}
	public String getIsJudge() {
		return isJudge;
	}
	public void setIsJudge(String isJudge) {
		this.isJudge = isJudge;
	}
	public String getWinScreen() {
		return winScreen;
	}
	public void setWinScreen(String winScreen) {
		this.winScreen = winScreen;
	}
	public String getMultipleScreen() {
		return multipleScreen;
	}
	public void setMultipleScreen(String multipleScreen) {
		this.multipleScreen = multipleScreen;
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
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
}
