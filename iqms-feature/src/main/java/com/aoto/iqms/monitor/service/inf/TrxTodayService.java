package com.aoto.iqms.monitor.service.inf;

import java.util.List;
import java.util.Map;

import com.aoto.framework.commons.pagination.PagingCriteria;
import com.aoto.iqms.monitor.models.TrxTodayQuery;

/**
 * 当日业务数据
 * @author zhousj
 *
 */
public interface TrxTodayService {
	/**
	 * 调用存储过程进行分页数据查询
	 * @param map
	 * @return
	 */
    public List<Map<String, Object>> procPageTrxToday(PagingCriteria pagingCriteria, TrxTodayQuery model);
    
    /**
	 * 调用存储过程进行特定数据查询
	 * @param map
	 * @return
	 */
    public List<Map<String, Object>> procTrxTodayQuery(String orgId);
    
    /**
	 * 调用存储过程查询当天不同业务类型数量并计算百分比
	 * @param map
	 * @return
	 */ 
    public List<Map<String, Object>> procTrxTodayBus(String orgId);
    
    
    /**
     * 计算今天和昨天的百分比
     * @param listQuery
     * @param listYesQuery
     * @return
     */
    public List<Map<String,Object>> getPercentList(List<Map<String,Object>> listQuery, List<Map<String,Object>> listYesQuery);
    /**
     * 更新流水数据
     * @param map
     * @return
     */
    public String updateTrxToday(Map<String,String> map);
}
