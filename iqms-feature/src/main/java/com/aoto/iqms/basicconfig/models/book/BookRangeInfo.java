package com.aoto.iqms.basicconfig.models.book;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
/**
 * 预约时间段信息
 * @author zhousj
 *
 */
@JsonIgnoreProperties(ignoreUnknown = true)
public class BookRangeInfo {
	private String rangeBegian; //开始时间段
	private String rangeEnd;    //结束时间段
	private String totalCount;  //总放号量
	private String orderCount;  //预约数量
	public String getRangeBegian() {
		return rangeBegian;
	}
	public void setRangeBegian(String rangeBegian) {
		this.rangeBegian = rangeBegian;
	}
	public String getRangeEnd() {
		return rangeEnd;
	}
	public void setRangeEnd(String rangeEnd) {
		this.rangeEnd = rangeEnd;
	}
	public String getTotalCount() {
		return totalCount;
	}
	public void setTotalCount(String totalCount) {
		this.totalCount = totalCount;
	}
	public String getOrderCount() {
		return orderCount;
	}
	public void setOrderCount(String orderCount) {
		this.orderCount = orderCount;
	}
	public BookRangeInfo(String rangeBegian, String rangeEnd, String totalCount, String orderCount) {
		super();
		this.rangeBegian = rangeBegian;
		this.rangeEnd = rangeEnd;
		this.totalCount = totalCount;
		this.orderCount = orderCount;
	}
	public BookRangeInfo() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	
}
