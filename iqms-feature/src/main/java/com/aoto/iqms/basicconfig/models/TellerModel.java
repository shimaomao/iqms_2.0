package com.aoto.iqms.basicconfig.models;

import com.aoto.framework.commons.beans.Model;

/**
 * 柜员信息
 * @author zhousj
 *
 */
public class TellerModel implements Model{
	private static final long serialVersionUID = -4347817288878195449L;
	private String  workId;
	private String orgId;
	private String callerPwd;
	private String name_;
	private String sex;
	private String status;
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
	public String getName_() {
		return name_;
	}
	public void setName_(String name_) {
		this.name_ = name_;
	}
	public String getSex() {
		return sex;
	}
	public void setSex(String sex) {
		this.sex = sex;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	
	
}
