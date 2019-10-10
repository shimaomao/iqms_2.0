package com.aoto.iqms.externals.models.HallMarket;

import java.io.Serializable;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
/**
 * 向营销系统请求客户号及客户的其他信息
 * @author zhousj
 *
 */
@JsonIgnoreProperties(ignoreUnknown = true)
public class CustInfoReq implements Serializable{
	private static final long serialVersionUID = -1533104057809092300L;
	private String Error_code;
	private String Error_msg;
	private String custNo;
	private String grade;
	private String custType;
	private String custName;
	private String custGender;
	private String custBirthday;
	
	
	public String getGrade() {
		return grade;
	}
	public void setGrade(String grade) {
		this.grade = grade;
	}
	public String getError_code() {
		return Error_code;
	}
	public void setError_code(String error_code) {
		Error_code = error_code;
	}
	public String getError_msg() {
		return Error_msg;
	}
	public void setError_msg(String error_msg) {
		Error_msg = error_msg;
	}
	public String getCustNo() {
		return custNo;
	}
	public void setCustNo(String custNo) {
		this.custNo = custNo;
	}
	
	public String getCustType() {
		return custType;
	}
	public void setCustType(String custType) {
		this.custType = custType;
	}
	public String getCustName() {
		return custName;
	}
	public void setCustName(String custName) {
		this.custName = custName;
	}
	public String getCustGender() {
		return custGender;
	}
	public void setCustGender(String custGender) {
		this.custGender = custGender;
	}
	public String getCustBirthday() {
		return custBirthday;
	}
	public void setCustBirthday(String custBirthday) {
		this.custBirthday = custBirthday;
	}
	
	
}
