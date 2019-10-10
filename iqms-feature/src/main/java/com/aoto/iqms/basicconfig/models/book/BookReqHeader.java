package com.aoto.iqms.basicconfig.models.book;

import java.io.Serializable;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

/**
 * 预约请求头
 * @author zhousj
 *
 */
@JsonIgnoreProperties(ignoreUnknown = true)
public class BookReqHeader implements Serializable{
	private static final long serialVersionUID = -8731201583335238603L;
	private String orgCode = "";
	private String transCode = "";
	private String transDt = "";//交易时间
	private String channel = "";//01-微信   02-掌上营业厅  
	private String orderDt = "";//预约日期
	
	
	//X002
//	private String certType = ""; //证件类型  1-手机号   2-身份证号
//	private String certContent = ""; //证件内容
//	private String orderTime = ""; //客户预约的时间点
//	private String rangeBegin = ""; //预约其实时间段
//	private String rangeEnd = ""; //预约结束时间段
//	private String orderServiceCode = "";// 预约业务编码
//	private String orderServiceId = "";//预约业务id
//	private String devNo = "";//设备号
//	private String actNo = "";
	
	
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
	public String getTransDt() {
		return transDt;
	}
	public void setTransDt(String transDt) {
		this.transDt = transDt;
	}
	public String getChannel() {
		return channel;
	}
	public void setChannel(String channel) {
		this.channel = channel;
	}
	public String getOrderDt() {
		return orderDt;
	}
	public void setOrderDt(String orderDt) {
		this.orderDt = orderDt;
	}
	
}
