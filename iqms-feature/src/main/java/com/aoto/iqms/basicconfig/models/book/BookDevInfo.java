package com.aoto.iqms.basicconfig.models.book;

import java.util.ArrayList;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

/**
 * 预约 设备信息
 * @author zhousj
 *
 */
@JsonIgnoreProperties(ignoreUnknown = true)
public class BookDevInfo {
	private String devNo = ""; //设备编码
	private String remark = "";  //主机名称
	private List<BookServiceInfo> serviceInfos = new ArrayList<BookServiceInfo>();
	private List<BookRangeInfo> rangeInfos = new ArrayList<BookRangeInfo>();
	
	
	public BookDevInfo(String devNo, String remark, List<BookServiceInfo> serviceInfos,
			List<BookRangeInfo> rangeInfos) {
		super();
		this.devNo = devNo;
		this.remark = remark;
		this.serviceInfos = serviceInfos;
		this.rangeInfos = rangeInfos;
	}
	public BookDevInfo() {
		super();
		// TODO Auto-generated constructor stub
	}
	public String getDevNo() {
		return devNo;
	}
	public void setDevNo(String devNo) {
		this.devNo = devNo;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public List<BookServiceInfo> getServiceInfos() {
		return serviceInfos;
	}
	public void setServiceInfos(List<BookServiceInfo> serviceInfos) {
		this.serviceInfos = serviceInfos;
	}
	public List<BookRangeInfo> getRangeInfos() {
		return rangeInfos;
	}
	public void setRangeInfos(List<BookRangeInfo> rangeInfos) {
		this.rangeInfos = rangeInfos;
	}
	
}
