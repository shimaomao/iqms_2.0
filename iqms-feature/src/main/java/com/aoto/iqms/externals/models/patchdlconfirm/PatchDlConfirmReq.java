package com.aoto.iqms.externals.models.patchdlconfirm;

import java.io.Serializable;

/**
 * 版本更新包下载确认
 * @author hongxz
 *
 */
public class PatchDlConfirmReq implements Serializable {
	private String deviceId; //设备id
	
	private String versionSeq; //版本Id

	public String getDeviceId() {
		return deviceId;
	}

	public void setDeviceId(String deviceId) {
		this.deviceId = deviceId;
	}

	public String getVersionSeq() {
		return versionSeq;
	}

	public void setVersionSeq(String versionSeq) {
		this.versionSeq = versionSeq;
	}
	
}
