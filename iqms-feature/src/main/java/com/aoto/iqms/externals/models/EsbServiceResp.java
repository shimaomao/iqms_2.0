package com.aoto.iqms.externals.models;

import java.io.Serializable;

/**
 * esb的响应部分
 * @author hongxz
 *
 */
public class EsbServiceResp implements Serializable {

	private String status; //COMPLETE 表明交易成功 FAIL 表明交易处理失败
	private String code; 
	private String desc; 
	private String requester_code; 
	private String requester_desc;
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public String getDesc() {
		return desc;
	}
	public void setDesc(String desc) {
		this.desc = desc;
	}
	public String getRequester_code() {
		return requester_code;
	}
	public void setRequester_code(String requester_code) {
		this.requester_code = requester_code;
	}
	public String getRequester_desc() {
		return requester_desc;
	}
	public void setRequester_desc(String requester_desc) {
		this.requester_desc = requester_desc;
	} 
	
}
