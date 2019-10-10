package com.aoto.iqms.basicconfig.models.book;

import java.io.Serializable;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
@JsonIgnoreProperties(ignoreUnknown = true)
public class BookX003Req implements Serializable{
	private static final long serialVersionUID = -1374641312992261446L;
	private BookReqHeader head = new BookReqHeader();
	private BookX003ReqData data = new BookX003ReqData();
	public BookReqHeader getHead() {
		return head;
	}
	public void setHead(BookReqHeader head) {
		this.head = head;
	}
	public BookX003ReqData getData() {
		return data;
	}
	public void setData(BookX003ReqData data) {
		this.data = data;
	}
	
}
