package com.aoto.iqms.externals.models.deviceheartbeat;

import java.io.Serializable;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

/**
 * 设备心跳请求报文数据部分
 * @author hongxz
 *
 */
public class DevHeartbeatDataReq implements Serializable {
	private String deviceId; //设备id
	private String transNet; //机构id
	private String cpuRatio; //cpu使用率
	private String memRatio; //内存使用率
	private String diskRatio; //硬盘使用率
	private String versionSeq; //当前版本序号
	private String thermalPrinterStatus; //号票打印机 1：正常 3：离线 5：缺纸
	private String needlePrinterStatus; //针式打印机1：正常 3：离线
	private String idReaderStatus; //身份证1：正常 3：离线
	private String swReadStatus; //磁条卡1：正常 3：离线
	private String icReaderStatus; //IC卡1：正常 3：离线
	private String barStatus; //条屏1：正常 3：离线
	private String compStatus; //综合屏1：正常 3：离线
	
	public String getDeviceId() {
		return deviceId;
	}
	public void setDeviceId(String deviceId) {
		this.deviceId = deviceId;
	}
	public String getTransNet() {
		return transNet;
	}
	public void setTransNet(String transNet) {
		this.transNet = transNet;
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
	public String getThermalPrinterStatus() {
		return thermalPrinterStatus;
	}
	public void setThermalPrinterStatus(String thermalPrinterStatus) {
		this.thermalPrinterStatus = thermalPrinterStatus;
	}
	public String getNeedlePrinterStatus() {
		return needlePrinterStatus;
	}
	public void setNeedlePrinterStatus(String needlePrinterStatus) {
		this.needlePrinterStatus = needlePrinterStatus;
	}
	public String getIdReaderStatus() {
		return idReaderStatus;
	}
	public void setIdReaderStatus(String idReaderStatus) {
		this.idReaderStatus = idReaderStatus;
	}
	public String getSwReadStatus() {
		return swReadStatus;
	}
	public void setSwReadStatus(String swReadStatus) {
		this.swReadStatus = swReadStatus;
	}
	public String getIcReaderStatus() {
		return icReaderStatus;
	}
	public void setIcReaderStatus(String icReaderStatus) {
		this.icReaderStatus = icReaderStatus;
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
}
