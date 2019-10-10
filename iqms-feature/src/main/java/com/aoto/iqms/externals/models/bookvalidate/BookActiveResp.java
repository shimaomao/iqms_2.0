package com.aoto.iqms.externals.models.bookvalidate;

import java.io.Serializable;

import com.aoto.iqms.externals.models.RespHeader;

/**
 * 预约激活最终返回报文
 * @author hongxz
 *
 */
public class BookActiveResp implements Serializable {

	private RespHeader head = new RespHeader();
	
	private BookActiveDataResp data = new BookActiveDataResp();
	
	public RespHeader getHead() {
		return head;
	}

	public void setHead(RespHeader head) {
		this.head = head;
	}

	public BookActiveDataResp getData() {
		return data;
	}

	public void setData(BookActiveDataResp data) {
		this.data = data;
	}

}
