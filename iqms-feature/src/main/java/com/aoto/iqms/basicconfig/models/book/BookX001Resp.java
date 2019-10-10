package com.aoto.iqms.basicconfig.models.book;

import java.io.Serializable;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
@JsonIgnoreProperties(ignoreUnknown = true)
public class BookX001Resp implements Serializable{
	private static final long serialVersionUID = 4628378051393254650L;
	private BookRespHeader head = new BookRespHeader();
	private BookNetRoomInfo data = new BookNetRoomInfo();
	public BookRespHeader getHead() {
		return head;
	}
	public void setHead(BookRespHeader head) {
		this.head = head;
	}
	public BookNetRoomInfo getData() {
		return data;
	}
	public void setData(BookNetRoomInfo data) {
		this.data = data;
	}
	
	
}
