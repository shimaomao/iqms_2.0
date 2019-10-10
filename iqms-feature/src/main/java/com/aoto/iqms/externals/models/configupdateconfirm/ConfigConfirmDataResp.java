package com.aoto.iqms.externals.models.configupdateconfirm;

import java.io.Serializable;

/**
 * 配置更新确认data部分的报文
 * @author hongxz
 *
 */
public class ConfigConfirmDataResp implements Serializable {
	private String result; //随便是什么值

	public String getResult() {
		return result;
	}

	public void setResult(String result) {
		this.result = result;
	}
}
