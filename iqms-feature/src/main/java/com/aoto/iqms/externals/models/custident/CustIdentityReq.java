package com.aoto.iqms.externals.models.custident;

import java.io.Serializable;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

/**
 * 预约激活data数据
 * @author hongxz
 *
 */
@JsonIgnoreProperties(ignoreUnknown = true)
public class CustIdentityReq implements Serializable {
	private String deviceId; //设备id
	private String deviceIp; //设备IP
	private String transNet; //机构id
	private String mediaType; //取票类型：手工取票0，刷二代证取票1，刷卡取票2，刷存折3，预约取号4，远程取号5，输入号码取票6，固话取票7，宽带拨号账号取票8。
	private String mediaId; //介质 Id：卡号/折号/身份证号
	private String orgCode; //机构编码
	private String certName; //客户名称
	
	
	public String getCertName() {
		return certName;
	}
	public void setCertName(String certName) {
		this.certName = certName;
	}
	public String getDeviceId() {
		return deviceId;
	}
	public void setDeviceId(String deviceId) {
		this.deviceId = deviceId;
	}
	public String getDeviceIp() {
		return deviceIp;
	}
	public void setDeviceIp(String deviceIp) {
		this.deviceIp = deviceIp;
	}
	public String getTransNet() {
		return transNet;
	}
	public void setTransNet(String transNet) {
		this.transNet = transNet;
	}
	public String getMediaType() {
		return mediaType;
	}
	public void setMediaType(String mediaType) {
		this.mediaType = mediaType;
	}
	public String getMediaId() {
		return mediaId;
	}
	public void setMediaId(String mediaId) {
		this.mediaId = mediaId;
	}
	public String getOrgCode() {
		return orgCode;
	}
	public void setOrgCode(String orgCode) {
		this.orgCode = orgCode;
	}
	
}
