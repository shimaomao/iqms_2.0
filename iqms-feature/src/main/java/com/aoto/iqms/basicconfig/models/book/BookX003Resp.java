package com.aoto.iqms.basicconfig.models.book;

import java.io.Serializable;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
@JsonIgnoreProperties(ignoreUnknown = true)
public class BookX003Resp implements Serializable{
	private static final long serialVersionUID = -8824687887560867419L;
	private BookRespHeader head = new BookRespHeader();
	private BookActNoStatus data = new BookActNoStatus();
	public BookRespHeader getHead() {
		return head;
	}
	public void setHead(BookRespHeader head) {
		this.head = head;
	}
	public BookActNoStatus getData() {
		return data;
	}
	public void setData(BookActNoStatus data) {
		this.data = data;
	}
}
