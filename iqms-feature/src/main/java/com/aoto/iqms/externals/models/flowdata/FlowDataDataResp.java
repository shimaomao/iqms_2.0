package com.aoto.iqms.externals.models.flowdata;

import java.io.Serializable;

import com.aoto.iqms.externals.models.RespHeader;

/**
 * 柜员同步返回数据部分报文
 * @author hongxz
 *
 */
public class FlowDataDataResp implements Serializable {

	String result = "";

	public String getResult() {
		return result;
	}

	public void setResult(String result) {
		this.result = result;
	}
	
	

}
