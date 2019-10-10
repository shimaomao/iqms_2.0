package com.aoto.iqms.monitor.persistence.inf;

import java.util.List;
import java.util.Map;

/**
 * 当天业务队列数据持久化
 * @author zhousj
 *
 */
public interface TrxTodayMapper {
	/**
	 * 调用存储过程进行分页数据查询
	 * @param map
	 * @return
	 */
    public List<Map<String, Object>> callPageTrxToday(Map<String, Object> map);
    
    /**
	 * 调用存储过程进行特定数据查询
	 * @param map
	 * @return
	 */
    public List<Map<String, Object>> callTrxTodayQuery(Map<String, Object> map);
    
    /**
     * 调用存储过程查询当天不同业务类型数量
     * @param map
     * @return
     */
    public List<Map<String, Object>> callTrxTodayBus(Map<String, Object> map);
    
    /**
     * 更新流水数据
     * @param map
     */
    public void updateTrxToday(Map<String, String> map);
    
}
