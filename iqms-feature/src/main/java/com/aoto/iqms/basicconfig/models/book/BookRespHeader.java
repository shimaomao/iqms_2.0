package com.aoto.iqms.basicconfig.models.book;

import java.io.Serializable;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

/**
 * 预约返回报文头
 * @author zhousj
 *
 */
@JsonIgnoreProperties(ignoreUnknown = true)
public class BookRespHeader implements Serializable{
	private static final long serialVersionUID = 8772978176774453036L;
	private String orgCode = "";
	private String transCode = "";
	private String respDate = "";
	private String statusDescribe = "";
	private String transStatus = "";
	private String channel = "";
	public String getOrgCode() {
		return orgCode;
	}
	public void setOrgCode(String orgCode) {
		this.orgCode = orgCode;
	}
	public String getTransCode() {
		return transCode;
	}
	public void setTransCode(String transCode) {
		this.transCode = transCode;
	}
	public String getRespDate() {
		return respDate;
	}
	public void setRespDate(String respDate) {
		this.respDate = respDate;
	}
	public String getStatusDescribe() {
		return statusDescribe;
	}
	public void setStatusDescribe(String statusDescribe) {
		this.statusDescribe = statusDescribe;
	}
	public String getTransStatus() {
		return transStatus;
	}
	public void setTransStatus(String transStatus) {
		this.transStatus = transStatus;
	}
	public String getChannel() {
		return channel;
	}
	public void setChannel(String channel) {
		this.channel = channel;
	}
	
	
}
