package com.aoto.iqms.report.service.inf;

import java.util.List;
import java.util.Map;

import com.aoto.framework.commons.pagination.PagingCriteria;
import com.aoto.iqms.report.models.BusinessFlowReportQuery;

/**
 * 业务流水报表-业务层接口
 * @author humz
 *
 */
public interface BusinessFlowReportService {

	/**
     * 调用存储过程进行分页数据查询
     * @param map
     * @return
     */
    public List<Map<String, Object>> procPageBFReport(PagingCriteria pagingCriteria,BusinessFlowReportQuery model);
    
}
