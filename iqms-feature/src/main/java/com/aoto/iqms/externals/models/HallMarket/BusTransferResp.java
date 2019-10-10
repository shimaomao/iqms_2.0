package com.aoto.iqms.externals.models.HallMarket;

import java.io.Serializable;

public class BusTransferResp implements Serializable{
	private static final long serialVersionUID = 7887189850437362170L;
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
