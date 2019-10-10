package com.aoto.iqms.externals.models.patchdlconfirm;

import java.io.Serializable;

import com.aoto.iqms.externals.models.RespHeader;

/**
 * 短信提醒最终返回报文
 * @author hongxz
 *
 */
public class PatchDlConfirmResp implements Serializable {

	private RespHeader head = new RespHeader();
	
	private PatchDlConfirmDataResp data = new PatchDlConfirmDataResp();
	
	public RespHeader getHead() {
		return head;
	}

	public void setHead(RespHeader head) {
		this.head = head;
	}

	public PatchDlConfirmDataResp getData() {
		return data;
	}

	public void setData(PatchDlConfirmDataResp data) {
		this.data = data;
	}
	
}
