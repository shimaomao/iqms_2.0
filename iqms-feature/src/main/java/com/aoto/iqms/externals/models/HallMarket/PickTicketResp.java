package com.aoto.iqms.externals.models.HallMarket;

import java.util.ArrayList;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
/**
 * 厅堂易直接取号返回 的封装类
 * @author zhousj
 *
 */
@JsonIgnoreProperties(ignoreUnknown = true)
public class PickTicketResp {
	private String responseCode = ""; //是否成功
	private String responseObject = "";
	public PickTicketResp() {
		super();
		// TODO Auto-generated constructor stub
	}
	

	public PickTicketResp(String responseCode, String responseObject) {
		super();
		this.responseCode = responseCode;
		this.responseObject = responseObject;
	}


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
