package com.aoto.iqms.basicconfig.persistence.inf;

import java.util.List;
import java.util.Map;

/**
 * 
 * @author zhousj
 *
 */
public interface NearMapper {
	/**
	 * 调用存储过程查询数据
	 * @param map
	 * @return
	 */
    public List<Map<String, Object>> callNear(Map<String, Object> map);
    
    /**
     * 调用存储过程进行修改和保存
     * @param map
     */
    public void callSaveOrUpdateNear(Map<String, Object> map);
    
    /**
     * 调用存储过程查询sysorg表
     * @param map
     * @return
     */
    public List<Map<String, Object>> callOrg(Map<String, Object> map);
    
    /**
     * 调用存储过程进行删除
     * @param map
     */
    public void callRemoveNear(Map<String, Object> map);
    
    /**
     * 调用存储过程 查询临近网点信息 到客户端
     * @param map
     * @return
     */
    public List<Map<String, Object>> callNearsQuery(Map<String, Object> map);
}
