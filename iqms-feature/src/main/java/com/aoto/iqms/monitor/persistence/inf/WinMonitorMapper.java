package com.aoto.iqms.monitor.persistence.inf;

import java.util.List;
import java.util.Map;

/**
 * 窗口监控持久化
 * @author zhousj
 *
 */
public interface WinMonitorMapper {
	/**
	 * 调用存储过程进行分页数据查询
	 * @param map
	 * @return
	 */
    public List<Map<String, Object>> callPageWinMonitor(Map<String, Object> map);
    
}
