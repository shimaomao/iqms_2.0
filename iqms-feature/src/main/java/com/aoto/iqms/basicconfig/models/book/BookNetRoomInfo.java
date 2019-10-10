package com.aoto.iqms.basicconfig.models.book;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

/**
 * 预约 网点业务信息
 * @author zhousj
 *
 */
@JsonIgnoreProperties(ignoreUnknown = true)
public class BookNetRoomInfo implements Serializable{
	private static final long serialVersionUID = -2052557839673419731L;
	//网点各业务信息
	private List<BookDevInfo> deviceInfos = new ArrayList<BookDevInfo>();

	public List<BookDevInfo> getDeviceInfos() {
		return deviceInfos;
	}

	public void setDeviceInfos(List<BookDevInfo> deviceInfos) {
		this.deviceInfos = deviceInfos;
	}
	
}
