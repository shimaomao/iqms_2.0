package com.aoto.iqms.externals.models.bookband;

import java.io.Serializable;

/**
 * 客户识别data数据
 * @author hongxz
 *
 */
public class BookBandReq implements Serializable {
	private String deviceId; //设备id
	private String deviceIp; //设备IP
	private String transNet; //机构id
	private String mediaType; //取票类型：手工取票0，刷二代证取票1，刷卡取票2，刷存折3，预约取号4，远程取号5，输入号码取票6，固话取票7，宽带拨号账号取票8。
	private String mediaId; //介质 Id：卡号/折号/身份证号
	
	private String orderId; //预约ID
	private String orderNum; //预约码
	private String ticketNo; //排队号
	
	private String orgCode; //机构编码 2017-07-10
	
	public String getOrgCode() {
		return orgCode;
	}
	public void setOrgCode(String orgCode) {
		this.orgCode = orgCode;
	}
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
	public String getTicketNo() {
		return ticketNo;
	}
	public void setTicketNo(String ticketNo) {
		this.ticketNo = ticketNo;
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
}
