package com.aoto.iqms.externals.models.msgsend;

import java.io.Serializable;

/**
 * 短信提醒返回data部分的报文
 * @author hongxz
 *
 */
public class MsgSendDataResp implements Serializable {
	private String result; //随便是什么值

	public String getResult() {
		return result;
	}

	public void setResult(String result) {
		this.result = result;
	}
}
