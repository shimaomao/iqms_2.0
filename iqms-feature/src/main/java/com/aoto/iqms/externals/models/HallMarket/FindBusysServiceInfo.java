package com.aoto.iqms.externals.models.HallMarket;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

/**
 * 厅堂易查询的业务信息
 * @author zhousj
 *
 */
@JsonIgnoreProperties(ignoreUnknown = true)
public class FindBusysServiceInfo {
	private String busType = "";
	private String busCode = "";
	private String busName = "";
	private String busShowTime = "";
	public FindBusysServiceInfo(String busType, String busCode, String busName, String busShowTime) {
		super();
		this.busType = busType;
		this.busCode = busCode;
		this.busName = busName;
		this.busShowTime = busShowTime;
	}
	public FindBusysServiceInfo() {
		super();
		// TODO Auto-generated constructor stub
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
	public String getBusName() {
		return busName;
	}
	public void setBusName(String busName) {
		this.busName = busName;
	}
	public String getBusShowTime() {
		return busShowTime;
	}
	public void setBusShowTime(String busShowTime) {
		this.busShowTime = busShowTime;
	}
	
	
}
