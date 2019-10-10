package com.aoto.iqms.monitor.models;

import com.aoto.framework.commons.beans.Model;
/**
 * 业务队列数据（只保存当天数据）
 * @author zhousj
 *
 */
public class TrxTodayModel implements Model{
	private static final long serialVersionUID = -3213560088715538840L;
	private String orgId;          
	private String deviceNo;       
	private String trxDate;        
	private String flowNo;        
	private String busId;          
	private String busType;        
	private String custType;       
	private String pdjLevel;      
	private String ticketType;     
	private String ticketNo;      
	private String custId;         
	private String cardType;       
	private String cardNo;         
	private String managerNo;      
	private String trxType;        
	private String trxStatus;     
	private String printTime;      
	private String callTime;       
	private String beginTime;      
	private String endTime;        
	private String appValue;      
	private String winNo;          
	private String tellerNo;    
	private String recallCount;    
	private String pauseBeginTime; 
	private String pauseEndTime;   
	private String callType;       
	private String transferCount;  
	private String buzFlag;   
	private String extend1;         
	private String extend2;         
	private String extend3;
	
	public String getOrgId() {
		return orgId;
	}
	public void setOrgId(String orgId) {
		this.orgId = orgId;
	}
	public String getDeviceNo() {
		return deviceNo;
	}
	public void setDeviceNo(String deviceNo) {
		this.deviceNo = deviceNo;
	}
	public String getTrxDate() {
		return trxDate;
	}
	public void setTrxDate(String trxDate) {
		this.trxDate = trxDate;
	}
	public String getFlowNo() {
		return flowNo;
	}
	public void setFlowNo(String flowNo) {
		this.flowNo = flowNo;
	}
	public String getBusId() {
		return busId;
	}
	public void setBusId(String busId) {
		this.busId = busId;
	}
	public String getBusType() {
		return busType;
	}
	public void setBusType(String busType) {
		this.busType = busType;
	}
	public String getCustType() {
		return custType;
	}
	public void setCustType(String custType) {
		this.custType = custType;
	}
	public String getPdjLevel() {
		return pdjLevel;
	}
	public void setPdjLevel(String pdjLevel) {
		this.pdjLevel = pdjLevel;
	}
	public String getTicketType() {
		return ticketType;
	}
	public void setTicketType(String ticketType) {
		this.ticketType = ticketType;
	}
	public String getTicketNo() {
		return ticketNo;
	}
	public void setTicketNo(String ticketNo) {
		this.ticketNo = ticketNo;
	}
	public String getCustId() {
		return custId;
	}
	public void setCustId(String custId) {
		this.custId = custId;
	}
	public String getCardType() {
		return cardType;
	}
	public void setCardType(String cardType) {
		this.cardType = cardType;
	}
	public String getCardNo() {
		return cardNo;
	}
	public void setCardNo(String cardNo) {
		this.cardNo = cardNo;
	}
	public String getManagerNo() {
		return managerNo;
	}
	public void setManagerNo(String managerNo) {
		this.managerNo = managerNo;
	}
	public String getTrxType() {
		return trxType;
	}
	public void setTrxType(String trxType) {
		this.trxType = trxType;
	}
	public String getTrxStatus() {
		return trxStatus;
	}
	public void setTrxStatus(String trxStatus) {
		this.trxStatus = trxStatus;
	}
	public String getPrintTime() {
		return printTime;
	}
	public void setPrintTime(String printTime) {
		this.printTime = printTime;
	}
	public String getCallTime() {
		return callTime;
	}
	public void setCallTime(String callTime) {
		this.callTime = callTime;
	}
	public String getBeginTime() {
		return beginTime;
	}
	public void setBeginTime(String beginTime) {
		this.beginTime = beginTime;
	}
	public String getEndTime() {
		return endTime;
	}
	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}
	public String getAppValue() {
		return appValue;
	}
	public void setAppValue(String appValue) {
		this.appValue = appValue;
	}
	public String getWinNo() {
		return winNo;
	}
	public void setWinNo(String winNo) {
		this.winNo = winNo;
	}
	public String getTellerNo() {
		return tellerNo;
	}
	public void setTellerNo(String tellerNo) {
		this.tellerNo = tellerNo;
	}
	public String getRecallCount() {
		return recallCount;
	}
	public void setRecallCount(String recallCount) {
		this.recallCount = recallCount;
	}
	public String getPauseBeginTime() {
		return pauseBeginTime;
	}
	public void setPauseBeginTime(String pauseBeginTime) {
		this.pauseBeginTime = pauseBeginTime;
	}
	public String getPauseEndTime() {
		return pauseEndTime;
	}
	public void setPauseEndTime(String pauseEndTime) {
		this.pauseEndTime = pauseEndTime;
	}
	public String getCallType() {
		return callType;
	}
	public void setCallType(String callType) {
		this.callType = callType;
	}
	public String getTransferCount() {
		return transferCount;
	}
	public void setTransferCount(String transferCount) {
		this.transferCount = transferCount;
	}
	public String getBuzFlag() {
		return buzFlag;
	}
	public void setBuzFlag(String buzFlag) {
		this.buzFlag = buzFlag;
	}
	public String getExtend1() {
		return extend1;
	}
	public void setExtend1(String extend1) {
		this.extend1 = extend1;
	}
	public String getExtend2() {
		return extend2;
	}
	public void setExtend2(String extend2) {
		this.extend2 = extend2;
	}
	public String getExtend3() {
		return extend3;
	}
	public void setExtend3(String extend3) {
		this.extend3 = extend3;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
}
