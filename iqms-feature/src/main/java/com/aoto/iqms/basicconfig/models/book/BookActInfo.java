package com.aoto.iqms.basicconfig.models.book;

import java.io.Serializable;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
@JsonIgnoreProperties(ignoreUnknown = true)
public class BookActInfo implements Serializable{
	private static final long serialVersionUID = -734382693990170068L;
	private String devNo = "";
	private String actNo = "";
	private String orderDate = "";
	private String orderTime = "";
	private String rangeBegin = "";
	private String rangeEnd = "";
	private String orderServiceCode = "";
	public String getDevNo() {
		return devNo;
	}
	public void setDevNo(String devNo) {
		this.devNo = devNo;
	}
	public String getActNo() {
		return actNo;
	}
	public void setActNo(String actNo) {
		this.actNo = actNo;
	}
	public String getOrderDate() {
		return orderDate;
	}
	public void setOrderDate(String orderDate) {
		this.orderDate = orderDate;
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
	
	
}
