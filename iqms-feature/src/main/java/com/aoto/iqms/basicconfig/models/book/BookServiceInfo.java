package com.aoto.iqms.basicconfig.models.book;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

/**
 * 业务信息
 * @author zhousj
 *
 */
@JsonIgnoreProperties(ignoreUnknown = true)
public class BookServiceInfo {
	//业务ID
	private String serviceId;
	//业务编码
	private String serviceCode;
	//业务名称
	private String serviceName;
	//业务显示时间
	private String[] serviceShowTime;
	
	
	
	public BookServiceInfo(String serviceId, String serviceCode, String serviceName, String[] serviceShowTime) {
		super();
		this.serviceId = serviceId;
		this.serviceCode = serviceCode;
		this.serviceName = serviceName;
		this.serviceShowTime = serviceShowTime;
	}
	public BookServiceInfo() {
		super();
		// TODO Auto-generated constructor stub
	}
	public String getServiceId() {
		return serviceId;
	}
	public void setServiceId(String serviceId) {
		this.serviceId = serviceId;
	}
	public String getServiceCode() {
		return serviceCode;
	}
	public void setServiceCode(String serviceCode) {
		this.serviceCode = serviceCode;
	}
	public String getServiceName() {
		return serviceName;
	}
	public void setServiceName(String serviceName) {
		this.serviceName = serviceName;
	}
	public String[] getServiceShowTime() {
		return serviceShowTime;
	}
	public void setServiceShowTime(String[] serviceShowTime) {
		this.serviceShowTime = serviceShowTime;
	}
	
	
	
}
