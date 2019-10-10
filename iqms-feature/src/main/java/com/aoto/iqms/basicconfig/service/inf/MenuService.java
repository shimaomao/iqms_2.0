package com.aoto.iqms.basicconfig.service.inf;

import java.util.List;
import java.util.Map;

import com.aoto.framework.commons.pagination.PagingCriteria;
import com.aoto.iqms.basicconfig.models.MenuModel;
import com.aoto.iqms.basicconfig.models.MenuQuery;

/**
 * 菜单
 * @author zhousj
 *
 */
public interface MenuService {
	/**
	 * 调用存储过程进行分页数据查询
	 * @param pagingCriteria
	 * @param model
	 * @return
	 */
    public List<Map<String, Object>> procPageMenu(PagingCriteria pagingCriteria,MenuQuery model);
	/**
	 * 调用存储过程新增业务
	 * @param model
	 * @return
	 */
    public String callCreateMenuProc(MenuModel model);
    
    /**
     * 调用存储过程更新业务
     * @param model
     * @return
     */
    public String callUpdateBcMenuProc(MenuModel model);
    
    /**
     * 调用存储过程删除业务
     * @param list
     * @return
     */
    public String callRemoveMenuProc(List<String> list);
    
    /**
     * 通过条件查询列表
     * @param pagingCriteria
     * @param model
     * @return
     */
    public List<Map<String, Object>> selectMenuByPage(PagingCriteria pagingCriteria,MenuQuery model);
    
    /**
     * 调用存储过程查询菜单是否有网点在使用
     * @param list
     * @return
     */
    public String callQueryMenuProc(List<String> list);
}
