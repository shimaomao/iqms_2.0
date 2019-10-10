package com.aoto.iqms.externals.models.flowdata;

import java.io.Serializable;

import com.aoto.iqms.externals.models.RespHeader;

/**
 * 预约激活最终返回报文
 * @author hongxz
 *
 */
public class FlowDataResp implements Serializable {

	private RespHeader head = new RespHeader();
	
	private FlowDataDataResp data = new FlowDataDataResp();
	
	public RespHeader getHead() {
		return head;
	}

	public void setHead(RespHeader head) {
		this.head = head;
	}

	public FlowDataDataResp getData() {
		return data;
	}

	public void setData(FlowDataDataResp data) {
		this.data = data;
	}
	
	

}
