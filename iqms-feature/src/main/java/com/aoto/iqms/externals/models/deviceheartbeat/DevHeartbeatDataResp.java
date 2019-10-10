package com.aoto.iqms.externals.models.deviceheartbeat;

import java.io.Serializable;

/**
 * 设备心跳返回data部分的报文
 * @author hongxz
 *
 */
public class DevHeartbeatDataResp implements Serializable {
	private String serverTime; //服务器时间（可用于时间同步）
	private String configUpdaeFlag; //配置文件是否有更新   1-有更新   0-无更新
	private String clientUpdateFlag; //客户端软件是否有更新  1-有更新   0-无更新
	private String clentiVerSeq; //客户端有更新此列有值：版本序号（要升级的版本号）
	private String clientVerName; //客户端有更新此列有值：版本名称
	private String clientPatchMd5; //客户端有更新此列有值：更新包的MD5码
	private String hearBeatInterval; //心跳间隔
	private String authenticationType; //鉴权模式： 1：远程识别 2：本地识别3：远程+本地按高计算4：远程+本地按低计算
	public String getServerTime() {
		return serverTime;
	}
	public void setServerTime(String serverTime) {
		this.serverTime = serverTime;
	}
	public String getConfigUpdaeFlag() {
		return configUpdaeFlag;
	}
	public void setConfigUpdaeFlag(String configUpdaeFlag) {
		this.configUpdaeFlag = configUpdaeFlag;
	}
	public String getClientUpdateFlag() {
		return clientUpdateFlag;
	}
	public void setClientUpdateFlag(String clientUpdateFlag) {
		this.clientUpdateFlag = clientUpdateFlag;
	}
	public String getClentiVerSeq() {
		return clentiVerSeq;
	}
	public void setClentiVerSeq(String clentiVerSeq) {
		this.clentiVerSeq = clentiVerSeq;
	}
	public String getClientVerName() {
		return clientVerName;
	}
	public void setClientVerName(String clientVerName) {
		this.clientVerName = clientVerName;
	}
	public String getClientPatchMd5() {
		return clientPatchMd5;
	}
	public void setClientPatchMd5(String clientPatchMd5) {
		this.clientPatchMd5 = clientPatchMd5;
	}
	public String getHearBeatInterval() {
		return hearBeatInterval;
	}
	public void setHearBeatInterval(String hearBeatInterval) {
		this.hearBeatInterval = hearBeatInterval;
	}
	public String getAuthenticationType() {
		return authenticationType;
	}
	public void setAuthenticationType(String authenticationType) {
		this.authenticationType = authenticationType;
	}
}
