package com.aoto.iqms.basicconfig.models;

import com.aoto.framework.commons.beans.Model;

public class ResourceUploadModel implements Model {
	private static final long serialVersionUID = 7463351655202220566L;
	private String id;//
	private String fileName;//文件名称
	private String filePath; //文件路径
	private String fileType;//文件类型
	private String fileRemark;//备注
	private String uploadDate;//上传日期
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public String getFilePath() {
		return filePath;
	}
	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}
	public String getFileType() {
		return fileType;
	}
	public void setFileType(String fileType) {
		this.fileType = fileType;
	}
	public String getFileRemark() {
		return fileRemark;
	}
	public void setFileRemark(String fileRemark) {
		this.fileRemark = fileRemark;
	}
	public String getUploadDate() {
		return uploadDate;
	}
	public void setUploadDate(String uploadDate) {
		this.uploadDate = uploadDate;
	}
	
	

}
