package com.aoto.iqms.externals.models.HallMarket;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
/**
 * 厅堂易号票业务转移 返回信息
 * @author zhousj
 *
 */
@JsonIgnoreProperties(ignoreUnknown = true)
public class BusTransferInfo {
	private String status = "";
	private String newBusCode = "";
	private String newLevel = ""; 
	private String newTicket = "";
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getNewBusCode() {
		return newBusCode;
	}
	public void setNewBusCode(String newBusCode) {
		this.newBusCode = newBusCode;
	}
	public String getNewLevel() {
		return newLevel;
	}
	public void setNewLevel(String newLevel) {
		this.newLevel = newLevel;
	}
	public String getNewTicket() {
		return newTicket;
	}
	public void setNewTicket(String newTicket) {
		this.newTicket = newTicket;
	}
	
	
}
