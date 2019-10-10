package com.aoto.iqms.basicconfig.models;

import com.aoto.framework.commons.beans.Model;

/**
 * (新)版本对象
 * @author daxian
 *
 */
public class PatchVersionModel implements Model {
	private static final long serialVersionUID = -5738696647038040735L;
	
	private String id;//
	private String patchName;//更新包名称
	private String patchVerno; //手工录入版本号
	private String patchMd5;//更新包md5
	private String patchPath;//更新包地址
	private String patchRemark;//更新包备注
	private String patchDate;//更新包日期
	private String status;//记录状态
	private String intactFlag;//是否全量包1-全量  0-增量
	private String dbFlag; //是否包含数据库  1-包含  0-不包含
	
	public String getIntactFlag() {
		return intactFlag;
	}
	public void setIntactFlag(String intactFlag) {
		this.intactFlag = intactFlag;
	}
	public String getDbFlag() {
		return dbFlag;
	}
	public void setDbFlag(String dbFlag) {
		this.dbFlag = dbFlag;
	}
	public String getPatchVerno() {
		return patchVerno;
	}
	public void setPatchVerno(String patchVerno) {
		this.patchVerno = patchVerno;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPatchName() {
		return patchName;
	}
	public void setPatchName(String patchName) {
		this.patchName = patchName;
	}
	public String getPatchMd5() {
		return patchMd5;
	}
	public void setPatchMd5(String patchMd5) {
		this.patchMd5 = patchMd5;
	}

	public String getPatchPath() {
		return patchPath;
	}
	public void setPatchPath(String patchPath) {
		this.patchPath = patchPath;
	}
	public String getPatchRemark() {
		return patchRemark;
	}
	public void setPatchRemark(String patchRemark) {
		this.patchRemark = patchRemark;
	}
	public String getPatchDate() {
		return patchDate;
	}
	public void setPatchDate(String patchDate) {
		this.patchDate = patchDate;
	}
}
