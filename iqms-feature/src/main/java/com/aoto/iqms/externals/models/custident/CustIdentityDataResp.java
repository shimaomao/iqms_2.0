package com.aoto.iqms.externals.models.custident;

import java.io.Serializable;

/**
 * 客户识别返回data部分的报文
 * @author hongxz
 *
 */
public class CustIdentityDataResp implements Serializable {
	private String deviceId=""; //设备ID【必填】MAC地址
	private String deviceIp=""; //设备IP【可填】
	private String transNet=""; //机构代码【必填】
	private String mediaType=""; //介质类型：00 其他；01 卡；02 折；03 身份证
	private String mediaId=""; //介质 Id：卡号/折号/身份证号
	private String transDate=""; //刷卡日期:YYYY-MM-DD  HH:MM:SS
	private String custId=""; //客户编号
	private String custLevel=""; //客户银行卡等级
	private String assetLevel=""; //资产等级:
	private String custLocal=""; //客户地域：0-本地；1-外地
	private String custIssue=""; //发卡网点：0-本网点；1-外网点
	private String lvInfo=""; //星级显示信息
	private String prodList=""; //产品列表
	private String markInfo=""; //营销信息
	private String orderFlag=""; //预约标识，0 为失败，1 为成功
	private String orderbuzTypeId=""; //预约业务类型Id
	private String orderTip=""; //预约提示信息
	public String getDeviceId() {
		return deviceId;
	}
	public void setDeviceId(String deviceId) {
		this.deviceId = deviceId;
	}
	public String getDeviceIp() {
		return deviceIp;
	}
	public void setDeviceIp(String deviceIp) {
		this.deviceIp = deviceIp;
	}
	public String getTransNet() {
		return transNet;
	}
	public void setTransNet(String transNet) {
		this.transNet = transNet;
	}
	public String getMediaType() {
		return mediaType;
	}
	public void setMediaType(String mediaType) {
		this.mediaType = mediaType;
	}
	public String getMediaId() {
		return mediaId;
	}
	public void setMediaId(String mediaId) {
		this.mediaId = mediaId;
	}
	public String getTransDate() {
		return transDate;
	}
	public void setTransDate(String transDate) {
		this.transDate = transDate;
	}
	public String getCustId() {
		return custId;
	}
	public void setCustId(String custId) {
		this.custId = custId;
	}
	public String getCustLevel() {
		return custLevel;
	}
	public void setCustLevel(String custLevel) {
		this.custLevel = custLevel;
	}
	public String getAssetLevel() {
		return assetLevel;
	}
	public void setAssetLevel(String assetLevel) {
		this.assetLevel = assetLevel;
	}
	public String getCustLocal() {
		return custLocal;
	}
	public void setCustLocal(String custLocal) {
		this.custLocal = custLocal;
	}
	public String getCustIssue() {
		return custIssue;
	}
	public void setCustIssue(String custIssue) {
		this.custIssue = custIssue;
	}
	public String getLvInfo() {
		return lvInfo;
	}
	public void setLvInfo(String lvInfo) {
		this.lvInfo = lvInfo;
	}
	public String getProdList() {
		return prodList;
	}
	public void setProdList(String prodList) {
		this.prodList = prodList;
	}
	public String getMarkInfo() {
		return markInfo;
	}
	public void setMarkInfo(String markInfo) {
		this.markInfo = markInfo;
	}
	public String getOrderFlag() {
		return orderFlag;
	}
	public void setOrderFlag(String orderFlag) {
		this.orderFlag = orderFlag;
	}
	public String getOrderbuzTypeId() {
		return orderbuzTypeId;
	}
	public void setOrderbuzTypeId(String orderbuzTypeId) {
		this.orderbuzTypeId = orderbuzTypeId;
	}
	public String getOrderTip() {
		return orderTip;
	}
	public void setOrderTip(String orderTip) {
		this.orderTip = orderTip;
	}
}
