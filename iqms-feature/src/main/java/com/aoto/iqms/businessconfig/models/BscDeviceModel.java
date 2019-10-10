package com.aoto.iqms.businessconfig.models;

import com.aoto.framework.commons.beans.Model;

/**
 * 设备管理类
 * @author daxian
 *
 */
public class BscDeviceModel implements Model {

	private static final long serialVersionUID = 3907310931526663047L;
	private String orgId;  //机构id
	private String deviceNo;//设变号，唯一标识一台设备
	private String hostName;//主机名，排队机实际的主机名
	private String ipAddr;//排队机实际ip地址
	private String macAddr;//排队机实际mac地址
	private String producer;//厂商品牌
	private String installDate;//安装日期
	private String adminName;//管理员姓名
	private String adminPhone;//管理员电话
	private String onlineTime;//上线时间
	private String currtVer;//软件版本号
	
	
	//20151231 by hongxz 
	private String netOrgCode;//本地网
	private String orderFlag;//是否提供预约
	private String extend1;//扩展1    预约数量
	private String extend2;//扩展2
	private String extend3 ; //扩展3
	
	private String screenResolution;//分辨率
	private String screenResolution1;
	private String producer1;
	private String onlineModel;//上线模式
	private String tpscrollFlag;//条屏显示
	
	
	
	
	public String getOnlineModel() {
		return onlineModel;
	}
	public void setOnlineModel(String onlineModel) {
		this.onlineModel = onlineModel;
	}
	public String getTpscrollFlag() {
		return tpscrollFlag;
	}
	public void setTpscrollFlag(String tpscrollFlag) {
		this.tpscrollFlag = tpscrollFlag;
	}
	public String getScreenResolution1() {
		return screenResolution1;
	}
	public void setScreenResolution1(String screenResolution1) {
		this.screenResolution1 = screenResolution1;
	}
	public String getProducer1() {
		return producer1;
	}
	public void setProducer1(String producer1) {
		this.producer1 = producer1;
	}
	public String getScreenResolution() {
		return screenResolution;
	}
	public void setScreenResolution(String screenResolution) {
		this.screenResolution = screenResolution;
	}
	public String getNetOrgCode() {
		return netOrgCode;
	}
	public void setNetOrgCode(String netOrgCode) {
		this.netOrgCode = netOrgCode;
	}
	public String getOrderFlag() {
		return orderFlag;
	}
	public void setOrderFlag(String orderFlag) {
		this.orderFlag = orderFlag;
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
	public String getHostName() {
		return hostName;
	}
	public void setHostName(String hostName) {
		this.hostName = hostName;
	}
	public String getIpAddr() {
		return ipAddr;
	}
	public void setIpAddr(String ipAddr) {
		this.ipAddr = ipAddr;
	}
	public String getMacAddr() {
		return macAddr;
	}
	public void setMacAddr(String macAddr) {
		this.macAddr = macAddr;
	}
	public String getProducer() {
		return producer;
	}
	public void setProducer(String producer) {
		this.producer = producer;
	}
	public String getInstallDate() {
		return installDate;
	}
	public void setInstallDate(String installDate) {
		this.installDate = installDate;
	}
	public String getAdminName() {
		return adminName;
	}
	public void setAdminName(String adminName) {
		this.adminName = adminName;
	}
	public String getAdminPhone() {
		return adminPhone;
	}
	public void setAdminPhone(String adminPhone) {
		this.adminPhone = adminPhone;
	}
	public String getOnlineTime() {
		return onlineTime;
	}
	public void setOnlineTime(String onlineTime) {
		this.onlineTime = onlineTime;
	}
	public String getCurrtVer() {
		return currtVer;
	}
	public void setCurrtVer(String currtVer) {
		this.currtVer = currtVer;
	}
	
}
