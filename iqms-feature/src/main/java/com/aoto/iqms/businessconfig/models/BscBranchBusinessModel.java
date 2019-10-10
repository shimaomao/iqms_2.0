package com.aoto.iqms.businessconfig.models;

import com.aoto.framework.commons.beans.Model;

/**
 * 网点业务
 * @author zhousj
 *
 */
public class BscBranchBusinessModel implements Model{

	private static final long serialVersionUID = 2001688486209248327L;
	private String orgId;
	private String deviceNo;
	private String treePid;
	private String treeId;
	private String businessType;
	private String businessEnName;
	private String businessCode;
	private String callHead;
	private String priorTime;
	private String isSwipe;
	private String isShowEn;
	private String pickUpAdvice;
	private String maxPickUp;
	private String sortNum;
	private String extend1;
	private String extend2;
	private String extend3;
	private String busId;
	private String orgDevicelist;
	private String levelNum;
	
	
	public String getLevelNum() {
		return levelNum;
	}
	public void setLevelNum(String levelNum) {
		this.levelNum = levelNum;
	}
	public String getOrgDevicelist() {
		return orgDevicelist;
	}
	public void setOrgDevicelist(String orgDevicelist) {
		this.orgDevicelist = orgDevicelist;
	}
	public String getBusId() {
		return busId;
	}
	public void setBusId(String busId) {
		this.busId = busId;
	}
	public String getTreePid() {
		return treePid;
	}
	public void setTreePid(String treePid) {
		this.treePid = treePid;
	}
	public String getTreeId() {
		return treeId;
	}
	public void setTreeId(String treeId) {
		this.treeId = treeId;
	}
	public String getBusinessType() {
		return businessType;
	}
	public void setBusinessType(String businessType) {
		this.businessType = businessType;
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
	public String getBusinessEnName() {
		return businessEnName;
	}
	public void setBusinessEnName(String businessEnName) {
		this.businessEnName = businessEnName;
	}
	public String getBusinessCode() {
		return businessCode;
	}
	public void setBusinessCode(String businessCode) {
		this.businessCode = businessCode;
	}
	public String getCallHead() {
		return callHead;
	}
	public void setCallHead(String callHead) {
		this.callHead = callHead;
	}
	public String getPriorTime() {
		return priorTime;
	}
	public void setPriorTime(String priorTime) {
		this.priorTime = priorTime;
	}
	public String getIsSwipe() {
		return isSwipe;
	}
	public void setIsSwipe(String isSwipe) {
		this.isSwipe = isSwipe;
	}
	public String getIsShowEn() {
		return isShowEn;
	}
	public void setIsShowEn(String isShowEn) {
		this.isShowEn = isShowEn;
	}
	public String getPickUpAdvice() {
		return pickUpAdvice;
	}
	public void setPickUpAdvice(String pickUpAdvice) {
		this.pickUpAdvice = pickUpAdvice;
	}
	public String getMaxPickUp() {
		return maxPickUp;
	}
	public void setMaxPickUp(String maxPickUp) {
		this.maxPickUp = maxPickUp;
	}
	public String getSortNum() {
		return sortNum;
	}
	public void setSortNum(String sortNum) {
		this.sortNum = sortNum;
	}
}
