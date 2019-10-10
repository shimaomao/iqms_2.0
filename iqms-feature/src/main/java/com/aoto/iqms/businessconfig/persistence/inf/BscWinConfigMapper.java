package com.aoto.iqms.businessconfig.persistence.inf;

import java.util.List;
import java.util.Map;

/**
 * 窗口配置持久层
 * @author zhousj
 *
 */
public interface BscWinConfigMapper {
	/**
     * 调用存储过程进行分页数据查询
     * @param map
     * @return
     */
    public List<Map<String, Object>> callPageBscWinConfig(Map<String, Object> map);
    
    /**
	 * 调用存储过程查询
	 * @param map
	 * @return
	 */
	public List<Map<String, Object>> callBscWinConfigQuery(Map<String, Object> map);
    
    /**
     * 调用存储过程保存
     * @param map
     */
    public void callInsertBscWinConfig(Map<String, Object> map);
    
    /**
     * 调用存储过程更新记录
     * @param map
     */
    public void callUpdteBscWinConfig(Map<String, Object> map);
    
    /**
     * 执行存储过程进行删除操作
     * @param map
     */
    public void callDeleteBscWinConfig(Map<String, Object> map);
    
    /**
     * 执行存储过程应用到下级机构
     * @param map
     */
    public void callCopyBscWinConfig(Map<String, Object> map);
    
    /**
     * 执行存储过程生成counters.json
     * @param model
     * @return
     */
    public List<Map<String, Object>> callCounters(Map<String, Object> map);
    
    /**
     * 一键检测：查询可用窗口
     * @param map
     * @return
     */
    public List<Map<String, Object>> checkedWinInfo(Map<String, Object> map);
}
