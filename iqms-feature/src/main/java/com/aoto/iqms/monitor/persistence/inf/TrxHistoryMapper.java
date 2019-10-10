package com.aoto.iqms.monitor.persistence.inf;

import java.util.List;
import java.util.Map;
/**
 * 业务历史数据持久化
 * @author zhousj
 *
 */
public interface TrxHistoryMapper {
	/**
	 * 调用存储过程进行昨天的特定数据查询
	 * @param map
	 * @return
	 */
    public List<Map<String, Object>> callTrxYesterdayQuery(Map<String, Object> map);
    
}
