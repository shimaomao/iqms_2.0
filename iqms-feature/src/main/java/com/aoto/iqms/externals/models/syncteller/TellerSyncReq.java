package com.aoto.iqms.externals.models.syncteller;

import java.io.Serializable;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

/**
 * 柜员同步data数据
 * @author hongxz
 *
 */
@JsonIgnoreProperties(ignoreUnknown = true)
public class TellerSyncReq implements Serializable {
	private String workId; //员工id
	private String orgId; //机构id
	private String callerPwd; //密码
	private String name; //姓名
	private String sex; //性别
	private String status; //状态
	
	
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getWorkId() {
		return workId;
	}
	public void setWorkId(String workId) {
		this.workId = workId;
	}
	public String getOrgId() {
		return orgId;
	}
	public void setOrgId(String orgId) {
		this.orgId = orgId;
	}
	public String getCallerPwd() {
		return callerPwd;
	}
	public void setCallerPwd(String callerPwd) {
		this.callerPwd = callerPwd;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getSex() {
		return sex;
	}
	public void setSex(String sex) {
		this.sex = sex;
	}
	
}
