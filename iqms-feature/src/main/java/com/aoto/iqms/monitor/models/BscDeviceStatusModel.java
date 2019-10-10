package com.aoto.iqms.monitor.models;

import com.aoto.framework.commons.beans.Model;

public class BscDeviceStatusModel implements Model{
	private static final long serialVersionUID = -9026743794818918454L;
	private String orgId;
	private String deviceNo;
	private String cpuRatio;
	private String memRatio;
	private String diskRatio;
	private String versionSeq;
	private String updateDate;
	private String thermalprinterStatus;
	private String needleprinterStatus;
	private String idreaderStatus;
	private String swreadStatus;
	private String icreaderStatus;
	private String barStatus;
	private String compStatus;
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
	public String getCpuRatio() {
		return cpuRatio;
	}
	public void setCpuRatio(String cpuRatio) {
		this.cpuRatio = cpuRatio;
	}
	public String getMemRatio() {
		return memRatio;
	}
	public void setMemRatio(String memRatio) {
		this.memRatio = memRatio;
	}
	public String getDiskRatio() {
		return diskRatio;
	}
	public void setDiskRatio(String diskRatio) {
		this.diskRatio = diskRatio;
	}
	public String getVersionSeq() {
		return versionSeq;
	}
	public void setVersionSeq(String versionSeq) {
		this.versionSeq = versionSeq;
	}
	public String getUpdateDate() {
		return updateDate;
	}
	public void setUpdateDate(String updateDate) {
		this.updateDate = updateDate;
	}
	public String getThermalprinterStatus() {
		return thermalprinterStatus;
	}
	public void setThermalprinterStatus(String thermalprinterStatus) {
		this.thermalprinterStatus = thermalprinterStatus;
	}
	public String getNeedleprinterStatus() {
		return needleprinterStatus;
	}
	public void setNeedleprinterStatus(String needleprinterStatus) {
		this.needleprinterStatus = needleprinterStatus;
	}
	public String getIdreaderStatus() {
		return idreaderStatus;
	}
	public void setIdreaderStatus(String idreaderStatus) {
		this.idreaderStatus = idreaderStatus;
	}
	public String getSwreadStatus() {
		return swreadStatus;
	}
	public void setSwreadStatus(String swreadStatus) {
		this.swreadStatus = swreadStatus;
	}
	public String getIcreaderStatus() {
		return icreaderStatus;
	}
	public void setIcreaderStatus(String icreaderStatus) {
		this.icreaderStatus = icreaderStatus;
	}
	public String getBarStatus() {
		return barStatus;
	}
	public void setBarStatus(String barStatus) {
		this.barStatus = barStatus;
	}
	public String getCompStatus() {
		return compStatus;
	}
	public void setCompStatus(String compStatus) {
		this.compStatus = compStatus;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
}
