package com.aoto.iqms.externals.models;

import java.io.Serializable;

/**
 * 响应头
 * @author hongxz
 *
 */
public class RespHeader implements Serializable {
	private String transCode = "";
	private String transDateTime= "";
	private String transStatus= "";
	private String transDescription= "";
	public String getTransCode() {
		return transCode;
	}
	public void setTransCode(String transCode) {
		this.transCode = transCode;
	}
	public String getTransDateTime() {
		return transDateTime;
	}
	public void setTransDateTime(String transDateTime) {
		this.transDateTime = transDateTime;
	}
	public String getTransStatus() {
		return transStatus;
	}
	public void setTransStatus(String transStatus) {
		this.transStatus = transStatus;
	}
	public String getTransDescription() {
		return transDescription;
	}
	public void setTransDescription(String transDescription) {
		this.transDescription = transDescription;
	}
}
