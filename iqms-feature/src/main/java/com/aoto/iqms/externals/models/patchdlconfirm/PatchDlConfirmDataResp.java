package com.aoto.iqms.externals.models.patchdlconfirm;

import java.io.Serializable;

/**
 * 客户端更新包的报文
 * @author hongxz
 *
 */
public class PatchDlConfirmDataResp implements Serializable {
	private String result; //随便是什么值

	public String getResult() {
		return result;
	}

	public void setResult(String result) {
		this.result = result;
	}
}
