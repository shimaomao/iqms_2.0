package com.aoto.iqms.externals.models.bookvalidate;

import java.io.Serializable;

/**
 * 客户识别返回data部分的报文
 * @author hongxz
 *
 */
public class BookActiveDataResp implements Serializable {
	private String deviceId = ""; //设备ID【必填】MAC地址
	private String deviceIp = ""; //设备IP【可填】
	private String transNet = ""; //机构代码【必填】
	private String mediaType = ""; //取票类型：手工取票0，刷二代证取票1，刷卡取票2，刷存折3，预约取号4，远程取号5，输入号码取票6，固话取票7，宽带拨号账号取票8。
	private String mediaId = ""; //介质 Id：卡号/折号/身份证号
	private String actDate = ""; //激活日期:YYYY-MM-DD  HH:MM:SS
	private String custId = ""; //客户编号
	private String custLevel = ""; //客户银行卡等级
	private String orderbuzTypeId = ""; //预约业务类型Id
	private String wfFlag = ""; // 填单标识： 1-有填单   0-没有填单
	
	private String orderId = ""; //预约id
	private String orderNum = ""; //预约号
	
	public String getOrderId() {
		return orderId;
	}
	public void setOrderId(String orderId) {
		this.orderId = orderId;
	}
	public String getOrderNum() {
		return orderNum;
	}
	public void setOrderNum(String orderNum) {
		this.orderNum = orderNum;
	}
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
	public String getOrderbuzTypeId() {
		return orderbuzTypeId;
	}
	public void setOrderbuzTypeId(String orderbuzTypeId) {
		this.orderbuzTypeId = orderbuzTypeId;
	}
	public String getActDate() {
		return actDate;
	}
	public void setActDate(String actDate) {
		this.actDate = actDate;
	}
	public String getWfFlag() {
		return wfFlag;
	}
	public void setWfFlag(String wfFlag) {
		this.wfFlag = wfFlag;
	}
	
}
