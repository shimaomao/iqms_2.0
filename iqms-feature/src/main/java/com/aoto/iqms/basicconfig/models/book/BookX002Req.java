package com.aoto.iqms.basicconfig.models.book;

import java.io.Serializable;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
@JsonIgnoreProperties(ignoreUnknown = true)
public class BookX002Req implements Serializable{
	private static final long serialVersionUID = 205860298321138580L;
	private BookReqHeader head = new BookReqHeader();
	private BookX002ReqData data = new BookX002ReqData();
	public BookReqHeader getHead() {
		return head;
	}
	public void setHead(BookReqHeader head) {
		this.head = head;
	}
	public BookX002ReqData getData() {
		return data;
	}
	public void setData(BookX002ReqData data) {
		this.data = data;
	}
	
}
