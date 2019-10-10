package com.aoto.iqms.monitor.service.inf;

import java.util.List;
import java.util.Map;

import com.aoto.framework.commons.pagination.PagingCriteria;
import com.aoto.iqms.monitor.models.TrxTodayQuery;

/**
 * 窗口监控业务层
 * @author zhousj
 *
 */
public interface WinMonitorService {
	/**
	 * 调用存储过程进行分页数据查询
	 * @param map
	 * @return
	 */
    public List<Map<String, Object>> procPageWinMonitor(PagingCriteria pagingCriteria, TrxTodayQuery model);
}
