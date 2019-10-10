package com.aoto.iqms.externals.models.HallMarket;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
/**
 * 厅堂易更新号票状态 返回信息
 * @author zhousj
 *
 */
@JsonIgnoreProperties(ignoreUnknown = true)
public class UpdateTicketInfo {
	private String statusCode;
	private String statusMessage;
	public UpdateTicketInfo() {
		super();
		// TODO Auto-generated constructor stub
	}
	public UpdateTicketInfo(String statusCode, String statusMessage) {
		super();
		this.statusCode = statusCode;
		this.statusMessage = statusMessage;
	}
	public String getStatusCode() {
		return statusCode;
	}
	public void setStatusCode(String statusCode) {
		this.statusCode = statusCode;
	}
	public String getStatusMessage() {
		return statusMessage;
	}
	public void setStatusMessage(String statusMessage) {
		this.statusMessage = statusMessage;
	}
	
}
