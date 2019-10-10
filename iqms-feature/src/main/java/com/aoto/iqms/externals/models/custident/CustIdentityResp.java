package com.aoto.iqms.externals.models.custident;

import java.io.Serializable;

import com.aoto.iqms.externals.models.RespHeader;

/**
 * 客户识别响应数据最终返回
 * @author hongxz
 *
 */
public class CustIdentityResp implements Serializable {

	private RespHeader head = new RespHeader();
	
	private CustIdentityDataResp data = new CustIdentityDataResp();
	
	public RespHeader getHead() {
		return head;
	}

	public void setHead(RespHeader head) {
		this.head = head;
	}

	public CustIdentityDataResp getData() {
		return data;
	}

	public void setData(CustIdentityDataResp data) {
		this.data = data;
	}

}
