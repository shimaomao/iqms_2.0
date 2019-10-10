package com.aoto.iqms.monitor.service.inf;

import java.util.List;
import java.util.Map;

/**
 * 业务历史数据
 * @author zhousj
 *
 */
public interface TrxHistoryService {
	/**
	 * 调用存储过程查询昨天数据
	 * @param orgId
	 * @return
	 */
	public List<Map<String, Object>> procTrxYesterdayQuery(String orgId);
}
