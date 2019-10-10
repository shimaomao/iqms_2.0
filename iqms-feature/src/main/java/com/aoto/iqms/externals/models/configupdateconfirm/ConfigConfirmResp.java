package com.aoto.iqms.externals.models.configupdateconfirm;

import java.io.Serializable;

import com.aoto.iqms.externals.models.RespHeader;

/**
 * 配置更新确认回报文
 * @author hongxz
 *
 */
public class ConfigConfirmResp implements Serializable {

	private RespHeader head = new RespHeader();
	
	private ConfigConfirmDataResp data = new ConfigConfirmDataResp();
	
	public RespHeader getHead() {
		return head;
	}

	public void setHead(RespHeader head) {
		this.head = head;
	}

	public ConfigConfirmDataResp getData() {
		return data;
	}

	public void setData(ConfigConfirmDataResp data) {
		this.data = data;
	}

}
