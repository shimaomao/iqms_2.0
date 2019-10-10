package com.aoto.iqms.util;


import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

public class ReturnConfig {
	
	//类名
	private String className = null;
	
	//标题
	private String title;

	//属性名
	private Map propertyMap = new LinkedHashMap();
	
	//列做key
	private Map columnMap = new LinkedHashMap();
	
	//flag
	private Map flagMap = new LinkedHashMap();
	
	//消息
	private Map messageMap = new LinkedHashMap();
	
	public Map getFlagMap() {
		return flagMap;
	}

	public void setFlagMap(Map flagMap) {
		this.flagMap = flagMap;
	}

	public Map getMessageMap() {
		return messageMap;
	}

	public void setMessageMap(Map messageMap) {
		this.messageMap = messageMap;
	}

	public String getClassName() {
		return className;
	}

	public void setClassName(String className) {
		this.className = className;
	}

	public Map getPropertyMap() {
		return propertyMap;
	}

	public void setPropertyMap(Map propertyMap) {
		this.propertyMap = propertyMap;
	}

	public Map getColumnMap() {
		return columnMap;
	}

	public void setColumnMap(Map columnMap) {
		this.columnMap = columnMap;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}
}
