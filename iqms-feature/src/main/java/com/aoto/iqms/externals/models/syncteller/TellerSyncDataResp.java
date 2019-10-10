package com.aoto.iqms.externals.models.syncteller;

import java.io.Serializable;

import com.aoto.iqms.externals.models.RespHeader;

/**
 * 预约激活最终返回报文
 * @author hongxz
 *
 */
public class TellerSyncDataResp implements Serializable {

	String result = "";

	public String getResult() {
		return result;
	}

	public void setResult(String result) {
		this.result = result;
	}
	
	

}
