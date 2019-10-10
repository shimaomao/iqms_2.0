package com.aoto.iqms.basicconfig.models.book;

import java.io.Serializable;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
/**
 * 预约解析异常 返回报文
 * @author zhousj
 *
 */
@JsonIgnoreProperties(ignoreUnknown = true)
public class BookResp implements Serializable{
	private static final long serialVersionUID = -1553952226973953508L;
	private BookRespHeader head = new BookRespHeader();
	private BookRespData data = new BookRespData();
	
	public BookRespData getData() {
		return data;
	}
	public void setData(BookRespData data) {
		this.data = data;
	}
	public BookRespHeader getHead() {
		return head;
	}
	public void setHead(BookRespHeader head) {
		this.head = head;
	}
	
	
}
