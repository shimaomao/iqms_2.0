package com.aoto.iqms.externals.models.deviceregist;

import java.io.Serializable;

import com.aoto.iqms.externals.models.RespHeader;

/**
 * 设备注册响应数据最终返回
 * @author hongxz
 *
 */
public class DeviceRegistResp implements Serializable {

	private RespHeader head = new RespHeader();
	
	private DeviceRegistData data = new DeviceRegistData();
	
	public RespHeader getHead() {
		return head;
	}

	public void setHead(RespHeader head) {
		this.head = head;
	}

	public DeviceRegistData getData() {
		return data;
	}

	public void setData(DeviceRegistData data) {
		this.data = data;
	}
}
