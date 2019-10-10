package com.aoto.iqms.basicconfig.models.book;

import java.io.Serializable;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
@JsonIgnoreProperties(ignoreUnknown = true)
public class BookX002ReqData implements Serializable{
	private static final long serialVersionUID = -4265843192896869652L;
	private String devNo = "";
	private String certType = "";
	private String certContent = "";
	private String orderTime = "";
	private String rangeBegin = "";
	private String rangeEnd = "";
	private String orderServiceCode = "";
	private String orderServiceId = "";
	
	private String actNo = "";
	
	public String getActNo() {
		return actNo;
	}
	public void setActNo(String actNo) {
		this.actNo = actNo;
	}
	public String getDevNo() {
		return devNo;
	}
	public void setDevNo(String devNo) {
		this.devNo = devNo;
	}
	public String getCertType() {
		return certType;
	}
	public void setCertType(String certType) {
		this.certType = certType;
	}
	public String getCertContent() {
		return certContent;
	}
	public void setCertContent(String certContent) {
		this.certContent = certContent;
	}
	public String getOrderTime() {
		return orderTime;
	}
	public void setOrderTime(String orderTime) {
		this.orderTime = orderTime;
	}
	public String getRangeBegin() {
		return rangeBegin;
	}
	public void setRangeBegin(String rangeBegin) {
		this.rangeBegin = rangeBegin;
	}
	public String getRangeEnd() {
		return rangeEnd;
	}
	public void setRangeEnd(String rangeEnd) {
		this.rangeEnd = rangeEnd;
	}
	public String getOrderServiceCode() {
		return orderServiceCode;
	}
	public void setOrderServiceCode(String orderServiceCode) {
		this.orderServiceCode = orderServiceCode;
	}
	public String getOrderServiceId() {
		return orderServiceId;
	}
	public void setOrderServiceId(String orderServiceId) {
		this.orderServiceId = orderServiceId;
	}
	
	
}
