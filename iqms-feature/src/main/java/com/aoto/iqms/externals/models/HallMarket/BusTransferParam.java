package com.aoto.iqms.externals.models.HallMarket;

import java.io.Serializable;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

@JsonIgnoreProperties(ignoreUnknown = true)
public class BusTransferParam implements Serializable{
	private static final long serialVersionUID = -7214103744165658952L;
	private String orgCode;
	private String deviceNo;
	private String ticketNo;
	private String busType;
	private String busCode;
	private String custLevel;
	private String isCreateT;
	public String getOrgCode() {
		return orgCode;
	}
	public void setOrgCode(String orgCode) {
		this.orgCode = orgCode;
	}
	public String getDeviceNo() {
		return deviceNo;
	}
	public void setDeviceNo(String deviceNo) {
		this.deviceNo = deviceNo;
	}
	public String getTicketNo() {
		return ticketNo;
	}
	public void setTicketNo(String ticketNo) {
		this.ticketNo = ticketNo;
	}
	public String getBusType() {
		return busType;
	}
	public void setBusType(String busType) {
		this.busType = busType;
	}
	public String getBusCode() {
		return busCode;
	}
	public void setBusCode(String busCode) {
		this.busCode = busCode;
	}
	public String getCustLevel() {
		return custLevel;
	}
	public void setCustLevel(String custLevel) {
		this.custLevel = custLevel;
	}
	public String getIsCreateT() {
		return isCreateT;
	}
	public void setIsCreateT(String isCreateT) {
		this.isCreateT = isCreateT;
	}
	
	
}
