package com.aoto.iqms.businessconfig.persistence.inf;

import java.util.List;
import java.util.Map;

/**
 * 客户等级 持久层
 * @author zhousj
 *
 */
public interface BscCustLevelMapper {
	/**
     * 调用存储过程进行分页数据查询
     * @param map
     * @return
     */
    public List<Map<String, Object>> callPageBscCustLevel(Map<String, Object> map);
    
    /**
	 * 调用存储过程查询
	 * @param map
	 * @return
	 */
	public List<Map<String, Object>> callBscCustLevelQuery(Map<String, Object> map);
    
    /**
     * 调用存储过程增加记录
     * @param map
     */
    public void callInsertBscCustLevel(Map<String, Object> map);
    
    /**
     * 调用存储过程更新记录
     * @param map
     */
    public void callUpdteBscCustLevel(Map<String, Object> map);
    
    /**
     * 执行存储过程进行删除操作
     * @param map
     */
    public void callDeleteBscCustLevel(Map<String, String> map);
    
    /**
     * 执行存储过程应用到下级机构
     * @param map
     */
    public void callCopyBscCustLevel(Map<String, Object> map);
    
    /**
     * 执行存储过程生成custLevels.json
     * @param model
     * @return
     */
    public List<Map<String, Object>> callCustLevels(Map<String, Object> map);
    
    /**
     * 一键检测：客户级别检测
     * @param map
     * @return
     */
    public List<Map<String, Object>> checkedCustLevel(Map<String, Object> map);
}
