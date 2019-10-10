package com.aoto.iqms.externals.models.HallMarket;

import java.util.ArrayList;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
/**
 * 厅堂易获取业务列表 返回信息
 * @author zhousj
 *
 */
@JsonIgnoreProperties(ignoreUnknown = true)
public class FindBusysResp {
	private String responseCode = ""; //是否成功
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
