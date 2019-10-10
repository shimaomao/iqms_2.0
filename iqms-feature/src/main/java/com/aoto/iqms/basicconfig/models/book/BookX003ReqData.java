package com.aoto.iqms.basicconfig.models.book;

import java.io.Serializable;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
@JsonIgnoreProperties(ignoreUnknown = true)
public class BookX003ReqData implements Serializable{
	private static final long serialVersionUID = 7966413626367478646L;
	private String actNo = "";
	private String certType = "";
	private String certContent = "";
	public String getActNo() {
		return actNo;
	}
	public void setActNo(String actNo) {
		this.actNo = actNo;
	}
	public String getCertType() {
		return certType;
	}
	public void setCertType(String certType) {
		this.certType = certType;
	}
	public String getCertContent() {
		return certContent;
	}
	public void setCertContent(String certContent) {
		this.certContent = certContent;
	}
	
}
