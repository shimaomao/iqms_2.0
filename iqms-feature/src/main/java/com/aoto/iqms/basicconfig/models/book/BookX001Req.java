package com.aoto.iqms.basicconfig.models.book;

import java.io.Serializable;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
@JsonIgnoreProperties(ignoreUnknown = true)
public class BookX001Req implements Serializable{
	private static final long serialVersionUID = -6701096181783776110L;
	private BookReqHeader head = new BookReqHeader();
	private Object data = new Object();
	
	public Object getData() {
		return data;
	}
	public void setData(Object data) {
		this.data = data;
	}
	public BookReqHeader getHead() {
		return head;
	}
	public void setHead(BookReqHeader head) {
		this.head = head;
	}
}
