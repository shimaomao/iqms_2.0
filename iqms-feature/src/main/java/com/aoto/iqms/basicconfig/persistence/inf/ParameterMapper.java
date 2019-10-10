package com.aoto.iqms.basicconfig.persistence.inf;

import java.util.List;
import java.util.Map;
/**
 * 
 * @author zhousj
 *
 */
public interface ParameterMapper {
	/**
	 * 调用存储过程查询数据
	 * @param map
	 * @return
	 */
    public List<Map<String, Object>> callParameter(Map<String, Object> map);

    /**
     * 调用存储过程进行修改和保存
     * @param map
     */
    public void callSaveOrUpdateParameter(Map<String, Object> map);
    
    /**
     * 查询字典表信息
     * @param map
     * @return
     */
    public List<Map<String, Object>> callSysDicQuery(Map<String, Object> map);
}
