package com.aoto.iqms.externals.models.HallMarket;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
/**
 * 厅堂易 直接取号返回信息
 * @author zhousj
 *
 */
@JsonIgnoreProperties(ignoreUnknown = true)
public class PickTicketInfo {
	private String ticketNo = "";
	private String waitNum = "";
	private String printTime = "";
	private String custLevel = "";
	public PickTicketInfo() {
		super();
		// TODO Auto-generated constructor stub
	}
	public PickTicketInfo(String ticketNo, String waitNum, String printTime) {
		super();
		this.ticketNo = ticketNo;
		this.waitNum = waitNum;
		this.printTime = printTime;
	}
	
	
	public String getCustLevel() {
		return custLevel;
	}
	public void setCustLevel(String custLevel) {
		this.custLevel = custLevel;
	}
	public String getTicketNo() {
		return ticketNo;
	}
	public void setTicketNo(String ticketNo) {
		this.ticketNo = ticketNo;
	}
	public String getWaitNum() {
		return waitNum;
	}
	public void setWaitNum(String waitNum) {
		this.waitNum = waitNum;
	}
	public String getPrintTime() {
		return printTime;
	}
	public void setPrintTime(String printTime) {
		this.printTime = printTime;
	}
	
	
}
