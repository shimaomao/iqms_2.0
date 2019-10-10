package com.aoto.iqms.basicconfig.persistence.inf;

import java.util.List;
import java.util.Map;

/**
 * 菜单持久化
 * @author zhousj
 *
 */
public interface BcMenuMapper {
	/**
	 * 调用存储过程进行分页数据查询
	 * @param map
	 * @return
	 */
    public List<Map<String, Object>> callPageMenu(Map<String, Object> map);
    
    /**
     * 调用存储过程增加记录
     * @param map
     */
    public void callInsertMenu(Map<String, Object> map);
    
    /**
     * 调用存储过程更新记录
     * @param map
     */
    public void callUpdteBcMenu(Map<String, Object> map);
    
    /**
     * 执行存储过程进行删除操作
     * @param map
     */
    public void callDeleteMenu(Map<String, Object> map);
    
    /**
     * 执行存储过程查询菜单是否有网点在使用
     * @param map
     */
    public List<Map<String, Object>> callMenuQuery(Map<String, Object> map);
    
}
