package com.aoto.iqms.basicconfig.models;

import com.aoto.framework.commons.beans.Model;

public class DeviceNoModel implements Model{

	private static final long serialVersionUID = -3732822199097320770L;
	private String orgId;
	private String deviceNo;
	
	public String getOrgId() {
		return orgId;
	}
	public void setOrgId(String orgId) {
		this.orgId = orgId;
	}
	public String getDeviceNo() {
		return deviceNo;
	}
	public void setDeviceNo(String deviceNo) {
		this.deviceNo = deviceNo;
	}
	
}
