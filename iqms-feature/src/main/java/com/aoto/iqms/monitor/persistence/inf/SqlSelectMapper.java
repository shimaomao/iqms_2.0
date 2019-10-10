package com.aoto.iqms.monitor.persistence.inf;

import java.util.List;
import java.util.Map;

/**
 * 数据监控持久化
 * @author  tianjm 20190304
 *
 */
public interface SqlSelectMapper {
	/**
	 * 调用存储过程进行分页数据查询
	 * @param map
	 * @return
	 */
    public List<Map<String, Object>> callPageSqlSelect(Map<String, Object> map);
    
}
