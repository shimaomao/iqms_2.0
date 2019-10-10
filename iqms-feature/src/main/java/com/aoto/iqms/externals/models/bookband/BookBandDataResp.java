package com.aoto.iqms.externals.models.bookband;

import java.io.Serializable;

/**
 * 客户识别返回data部分的报文
 * @author hongxz
 *
 */
public class BookBandDataResp implements Serializable {
	
	private String result = ""; //结果

	public String getResult() {
		return result;
	}

	public void setResult(String result) {
		this.result = result;
	}
	
}
