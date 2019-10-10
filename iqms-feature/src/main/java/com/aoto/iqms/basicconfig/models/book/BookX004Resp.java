package com.aoto.iqms.basicconfig.models.book;

import java.io.Serializable;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
@JsonIgnoreProperties(ignoreUnknown = true)
public class BookX004Resp implements Serializable{
	private static final long serialVersionUID = -7314849409901101785L;
	private BookRespHeader head = new BookRespHeader();
	private BookCancel data = new BookCancel();
	public BookRespHeader getHead() {
		return head;
	}
	public void setHead(BookRespHeader head) {
		this.head = head;
	}
	public BookCancel getData() {
		return data;
	}
	public void setData(BookCancel data) {
		this.data = data;
	}
	
}
