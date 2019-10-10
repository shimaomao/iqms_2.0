package com.aoto.iqms.basicconfig.models;

import com.aoto.framework.commons.beans.Model;

/**
 * 菜单
 * @author zhousj
 *
 */
public class MenuModel implements Model{
    private static final long serialVersionUID = -5065064483313075339L;
    private String menuId;
    private String menuName;//菜单名称 
    private String menuEnName;//菜单英文名
    private String extend1;//扩展字段1
	
    
	public String getMenuId() {
		return menuId;
	}
	public void setMenuId(String menuId) {
		this.menuId = menuId;
	}
	public String getMenuName() {
		return menuName;
	}
	public void setMenuName(String menuName) {
		this.menuName = menuName;
	}
	public String getMenuEnName() {
		return menuEnName;
	}
	public void setMenuEnName(String menuEnName) {
		this.menuEnName = menuEnName;
	}
	public String getExtend1() {
		return extend1;
	}
	public void setExtend1(String extend1) {
		this.extend1 = extend1;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
    

}
