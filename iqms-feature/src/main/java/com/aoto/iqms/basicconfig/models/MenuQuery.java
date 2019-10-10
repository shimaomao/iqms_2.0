package com.aoto.iqms.basicconfig.models;

import com.aoto.framework.commons.pagination.PaginationQuery;

/**
 * 查询对象
 * @author zhousj
 *
 */
public class MenuQuery extends PaginationQuery{
    private static final long serialVersionUID = 4658288798692590055L;
    private String menuName;//查询名称
	public String getMenuName() {
		return menuName;
	}
	public void setMenuName(String menuName) {
		this.menuName = menuName;
	}
    
}
