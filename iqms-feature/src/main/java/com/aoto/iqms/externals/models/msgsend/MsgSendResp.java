package com.aoto.iqms.externals.models.msgsend;

import java.io.Serializable;

import com.aoto.iqms.externals.models.RespHeader;

/**
 * 短信提醒最终返回报文
 * @author hongxz
 *
 */
public class MsgSendResp implements Serializable {

	private RespHeader head = new RespHeader();
	
	private MsgSendDataResp data = new MsgSendDataResp();
	
	public RespHeader getHead() {
		return head;
	}

	public void setHead(RespHeader head) {
		this.head = head;
	}

	public MsgSendDataResp getData() {
		return data;
	}

	public void setData(MsgSendDataResp data) {
		this.data = data;
	}

}
