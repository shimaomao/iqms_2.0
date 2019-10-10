package com.aoto.iqms.monitor.service.inf;

import java.util.List;
import java.util.Map;

import com.aoto.framework.commons.pagination.PagingCriteria;
import com.aoto.iqms.monitor.models.SqlSelectQuery;

/**
 * 数据监控业务层
 * @author tianjm 20190304
 */
public interface SqlSelectService {
	
	/**
	 * 调用存储过程进行分页数据查询
	 * @param map
	 * @return
	 */
    public List<Map<String, Object>> procPageSqlSelect(PagingCriteria pagingCriteria, SqlSelectQuery model);
}
