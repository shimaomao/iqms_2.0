package com.aoto.iqms.externals.models.deviceheartbeat;

import java.io.Serializable;

import com.aoto.iqms.externals.models.RespHeader;

/**
 * 设备心跳响应数据最终返回
 * @author hongxz
 *
 */
public class DevHeartbeatResp implements Serializable {

	private RespHeader head = new RespHeader();
	
	private DevHeartbeatDataResp data = new DevHeartbeatDataResp();
	
	public RespHeader getHead() {
		return head;
	}

	public void setHead(RespHeader head) {
		this.head = head;
	}

	public DevHeartbeatDataResp getData() {
		return data;
	}

	public void setData(DevHeartbeatDataResp data) {
		this.data = data;
	}
	
}
