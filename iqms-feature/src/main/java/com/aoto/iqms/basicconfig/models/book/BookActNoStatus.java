package com.aoto.iqms.basicconfig.models.book;

import java.io.Serializable;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

@JsonIgnoreProperties(ignoreUnknown = true)
public class BookActNoStatus implements Serializable{
	private static final long serialVersionUID = -9163136237747603958L;

	private String actNo = "";  //激活码
	
	private String orderDt = "";  //预约日期
	 
	private String actStatus = "";  //预约码状态
	
	private String devNo = "";    //设备编号
	
	private String orderBusId = "";//预约业务id
	
	private String orderBusCode = "";  //预约业务编码
	
	private String orderTime = "";    //预约时间
	
    private String rangeBegin = "";   //预约开始时间段
    
    private String rangeEnd = "";    //雨夜结束时间段

    
	public String getOrderDt() {
		return orderDt;
	}

	public void setOrderDt(String orderDt) {
		this.orderDt = orderDt;
	}

	public String getOrderBusId() {
		return orderBusId;
	}

	public void setOrderBusId(String orderBusId) {
		this.orderBusId = orderBusId;
	}

	public String getActNo() {
		return actNo;
	}

	public void setActNo(String actNo) {
		this.actNo = actNo;
	}


	public String getActStatus() {
		return actStatus;
	}

	public void setActStatus(String actStatus) {
		this.actStatus = actStatus;
	}

	public String getDevNo() {
		return devNo;
	}

	public void setDevNo(String devNo) {
		this.devNo = devNo;
	}

	public String getOrderBusCode() {
		return orderBusCode;
	}

	public void setOrderBusCode(String orderBusCode) {
		this.orderBusCode = orderBusCode;
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
}
