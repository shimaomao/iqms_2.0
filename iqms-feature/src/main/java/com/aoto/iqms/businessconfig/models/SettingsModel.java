package com.aoto.iqms.businessconfig.models;

import com.aoto.framework.commons.beans.Model;

/**
 * 元素列表配置
 * @author humz
 */
public class SettingsModel implements Model{

	private static final long serialVersionUID = -3574468472113293771L;
	
	private String type;

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

}
