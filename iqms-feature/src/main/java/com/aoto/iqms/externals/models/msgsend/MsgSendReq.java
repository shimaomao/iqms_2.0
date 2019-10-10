package com.aoto.iqms.externals.models.msgsend;

import java.io.Serializable;

/**
 * 短信提醒data数据
 * @author hongxz
 *
 */
public class MsgSendReq implements Serializable {
	private String deviceId; //设备id
	private String deviceIp; //设备IP
	private String transNet; //机构id
	private String telNo; //手机号
	private String ticketNo; //排队号
	private String busName; //业务名称
	private String busId; //业务ID
	private String busWait; //业务等待人数
	private String msgContent; //短信内容
	private String actDateTime; //动作时间
	private String orgCode; //机构编码 2017-07-20
	
	public String getOrgCode() {
		return orgCode;
	}
	public void setOrgCode(String orgCode) {
		this.orgCode = orgCode;
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
	public String getTelNo() {
		return telNo;
	}
	public void setTelNo(String telNo) {
		this.telNo = telNo;
	}
	public String getTicketNo() {
		return ticketNo;
	}
	public void setTicketNo(String ticketNo) {
		this.ticketNo = ticketNo;
	}
	public String getBusName() {
		return busName;
	}
	public void setBusName(String busName) {
		this.busName = busName;
	}
	public String getBusId() {
		return busId;
	}
	public void setBusId(String busId) {
		this.busId = busId;
	}
	public String getBusWait() {
		return busWait;
	}
	public void setBusWait(String busWait) {
		this.busWait = busWait;
	}
	public String getMsgContent() {
		return msgContent;
	}
	public void setMsgContent(String msgContent) {
		this.msgContent = msgContent;
	}
	public String getActDateTime() {
		return actDateTime;
	}
	public void setActDateTime(String actDateTime) {
		this.actDateTime = actDateTime;
	}
	
}
