package com.aoto.iqms.externals.models.bookband;

import java.io.Serializable;

import com.aoto.iqms.externals.models.RespHeader;

/**
 * 预约激活最终返回报文
 * @author hongxz
 *
 */
public class BookBandResp implements Serializable {

	private RespHeader head = new RespHeader();
	
	private BookBandDataResp data = new BookBandDataResp();
	
	public RespHeader getHead() {
		return head;
	}

	public void setHead(RespHeader head) {
		this.head = head;
	}

	public BookBandDataResp getData() {
		return data;
	}

	public void setData(BookBandDataResp data) {
		this.data = data;
	}

}
