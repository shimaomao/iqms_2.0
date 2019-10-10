package com.aoto.iqms.externals.models.HallMarket;

import java.io.Serializable;

public class UpdateTicketStatusResp implements Serializable{
	private static final long serialVersionUID = -5092789739510479063L;
	private String responseCode;
	private String responseObject = "";
	
	public String getResponseCode() {
		return responseCode;
	}
	public void setResponseCode(String responseCode) {
		this.responseCode = responseCode;
	}
	public String getResponseObject() {
		return responseObject;
	}
	public void setResponseObject(String responseObject) {
		this.responseObject = responseObject;
	}
	
	
}
