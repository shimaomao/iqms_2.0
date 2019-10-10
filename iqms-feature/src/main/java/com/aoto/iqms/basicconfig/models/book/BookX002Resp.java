package com.aoto.iqms.basicconfig.models.book;

import java.io.Serializable;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
@JsonIgnoreProperties(ignoreUnknown = true)
public class BookX002Resp implements Serializable{
	private static final long serialVersionUID = 3097254363573054148L;
	private BookRespHeader head = new BookRespHeader();
	private BookActInfo data = new BookActInfo();
	public BookRespHeader getHead() {
		return head;
	}
	public void setHead(BookRespHeader head) {
		this.head = head;
	}
	public BookActInfo getData() {
		return data;
	}
	public void setData(BookActInfo data) {
		this.data = data;
	}
	
}
