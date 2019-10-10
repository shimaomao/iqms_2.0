package com.aoto.iqms.externals.models.flowdata;

import java.io.Serializable;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

/**
 * 排队机流水数据封装类（将客户端发送过来的请求报文封装到此类中）
 * @author hongxz
 *
 */
@JsonIgnoreProperties(ignoreUnknown = true)
public class FlowData implements Serializable {

	private String deviceId; //设备ID【必填】MAC地址
	private String deviceIp; // 设备IP【可填】
	private String transNet; // 机构id
	private String transCode;//  交易码
	private String tickDate;// 号票日期，定长字符串，YYYY-MM-DD
	private String flowId;//主键（唯一字段，机构号+设备号+取号时间+排队号）	
	private String tickNo;//号票号码：一个5字节的号票号码（号码规则类似于A2009）
	private String type;//状态：1-取号；2-叫号；3-办理结束
	private String fetchType;//取票类型：手工取票0，刷二代证取票1，刷卡取票2，刷存折3，预约取号4，远程取号5，输入号码取票6，固话取票7，宽带拨号账号取票8。
	private String buzTypeId;//业务ID
	private String buzCode;//业务代码(如：A)
	private String custId;//客户号
	private String mediaType;//客户刷卡类型：0 无；1 身份证；2 卡；3存折。
	private String certNo;//客户识别号码：（和客户刷卡类型一起标识客户）银行卡号，身份证号等
	private String custLevel;// 客户类型
	private String custPrefix;// 系统客户等级 1-9
	private String tickNoStatus;//票号状态：取值范围：正常等候 ：1?，正在办理 ：2?，完成： 3，弃号：4，转移：5；锁号：6；延后：7，插前：8
	private String fetchedDate;//取号时间：格式为yyyy-MM-dd HH:mm:ss （取号后，呼叫时间，开始办理时间，结束办理时间都为空）
	private String calledDate;//呼叫时间：格式为yyyy-MM-dd HH:mm:ss（呼叫后，呼叫时间，开始办理时间，结束办理时间值都设为呼叫时间。）
	private String startDate;//开始办理时间：格式为yyyy-MM-dd HH:mm:ss (评价后，更新业务开始办理时间）有评价器时按欢迎光临的时间
	private String finishedDate;//结束办理时间：格式为yyyy-MM-dd HH:mm:ss （评价后、叫下一号更新上一号的结束办理时间）即评价时间	
	private String rate;//评价值：0:未评价，默认值1:不满意2:一般3:满意
	private String counterNo;//办理窗口，默认值为0表示没有被叫号
	private String tellerNo;//柜员工号：再用0000签到，默认值是0
	private String recallNo;//重呼次数
	private String pauseDate;//暂停开始时间 yyyy-MM-dd HH:mm:ss
	private String finishedpauseDate;//暂停结束时间 yyyy-MM-dd HH:mm:ss
	private String callType;//叫号方式： 1:顺呼; 2:重呼; 3:指呼; 4:特呼
	private String transferNo;//转移次数
	private String buzFlag;//业务标记【扩展备用】
	
	
	@Override
	public String toString() {
		return "FlowData [deviceId=" + deviceId + ", deviceIp=" + deviceIp + ", transNet=" + transNet + ", transCode="
				+ transCode + ", tickDate=" + tickDate + ", flowId=" + flowId + ", tickNo=" + tickNo + ", type=" + type
				+ ", fetchType=" + fetchType + ", buzTypeId=" + buzTypeId + ", buzCode=" + buzCode + ", custId="
				+ custId + ", mediaType=" + mediaType + ", certNo=" + certNo + ", custLevel=" + custLevel
				+ ", custPrefix=" + custPrefix + ", tickNoStatus=" + tickNoStatus + ", fetchedDate=" + fetchedDate
				+ ", calledDate=" + calledDate + ", startDate=" + startDate + ", finishedDate=" + finishedDate
				+ ", rate=" + rate + ", counterNo=" + counterNo + ", tellerNo=" + tellerNo + ", recallNo=" + recallNo
				+ ", pauseDate=" + pauseDate + ", finishedpauseDate=" + finishedpauseDate + ", callType=" + callType
				+ ", transferNo=" + transferNo + ", buzFlag=" + buzFlag + "]";
	}
	public String getCustLevel() {
		return custLevel;
	}
	public void setCustLevel(String custLevel) {
		this.custLevel = custLevel;
	}
	public String getCustPrefix() {
		return custPrefix;
	}
	public void setCustPrefix(String custPrefix) {
		this.custPrefix = custPrefix;
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
	public String getTransCode() {
		return transCode;
	}
	public void setTransCode(String transCode) {
		this.transCode = transCode;
	}

	public String getTickDate() {
		return tickDate;
	}
	public void setTickDate(String tickDate) {
		this.tickDate = tickDate;
	}
	public String getFlowId() {
		return flowId;
	}
	public void setFlowId(String flowId) {
		this.flowId = flowId;
	}
	public String getTickNo() {
		return tickNo;
	}
	public void setTickNo(String tickNo) {
		this.tickNo = tickNo;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getFetchType() {
		return fetchType;
	}
	public void setFetchType(String fetchType) {
		this.fetchType = fetchType;
	}
	public String getBuzTypeId() {
		return buzTypeId;
	}
	public void setBuzTypeId(String buzTypeId) {
		this.buzTypeId = buzTypeId;
	}
	public String getBuzCode() {
		return buzCode;
	}
	public void setBuzCode(String buzCode) {
		this.buzCode = buzCode;
	}
	public String getCustId() {
		return custId;
	}
	public void setCustId(String custId) {
		this.custId = custId;
	}
	public String getMediaType() {
		return mediaType;
	}
	public void setMediaType(String mediaType) {
		this.mediaType = mediaType;
	}
	public String getCertNo() {
		return certNo;
	}
	public void setCertNo(String certNo) {
		this.certNo = certNo;
	}
	public String getTickNoStatus() {
		return tickNoStatus;
	}
	public void setTickNoStatus(String tickNoStatus) {
		this.tickNoStatus = tickNoStatus;
	}
	public String getFetchedDate() {
		return fetchedDate;
	}
	public void setFetchedDate(String fetchedDate) {
		this.fetchedDate = fetchedDate;
	}
	public String getCalledDate() {
		return calledDate;
	}
	public void setCalledDate(String calledDate) {
		this.calledDate = calledDate;
	}
	public String getStartDate() {
		return startDate;
	}
	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}
	public String getFinishedDate() {
		return finishedDate;
	}
	public void setFinishedDate(String finishedDate) {
		this.finishedDate = finishedDate;
	}
	public String getRate() {
		return rate;
	}
	public void setRate(String rate) {
		this.rate = rate;
	}
	public String getCounterNo() {
		return counterNo;
	}
	public void setCounterNo(String counterNo) {
		this.counterNo = counterNo;
	}
	public String getTellerNo() {
		return tellerNo;
	}
	public void setTellerNo(String tellerNo) {
		this.tellerNo = tellerNo;
	}
	public String getRecallNo() {
		return recallNo;
	}
	public void setRecallNo(String recallNo) {
		this.recallNo = recallNo;
	}
	public String getPauseDate() {
		return pauseDate;
	}
	public void setPauseDate(String pauseDate) {
		this.pauseDate = pauseDate;
	}
	public String getFinishedpauseDate() {
		return finishedpauseDate;
	}
	public void setFinishedpauseDate(String finishedpauseDate) {
		this.finishedpauseDate = finishedpauseDate;
	}
	public String getCallType() {
		return callType;
	}
	public void setCallType(String callType) {
		this.callType = callType;
	}
	public String getTransferNo() {
		return transferNo;
	}
	public void setTransferNo(String transferNo) {
		this.transferNo = transferNo;
	}
	public String getBuzFlag() {
		return buzFlag;
	}
	public void setBuzFlag(String buzFlag) {
		this.buzFlag = buzFlag;
	}
}
