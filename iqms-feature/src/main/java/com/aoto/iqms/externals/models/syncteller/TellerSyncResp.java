package com.aoto.iqms.externals.models.syncteller;

import java.io.Serializable;

import com.aoto.iqms.externals.models.RespHeader;

/**
 * 柜员同步最终返回报文
 * @author hongxz
 *
 */
public class TellerSyncResp implements Serializable {

	private RespHeader head = new RespHeader();
	
	private TellerSyncDataResp data = new TellerSyncDataResp();
	
	public RespHeader getHead() {
		return head;
	}

	public void setHead(RespHeader head) {
		this.head = head;
	}

	public TellerSyncDataResp getData() {
		return data;
	}

	public void setData(TellerSyncDataResp data) {
		this.data = data;
	}
	
	

}
