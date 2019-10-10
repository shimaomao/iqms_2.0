package com.aoto.iqms.report.service.inf;

import java.util.List;
import java.util.Map;

import com.aoto.framework.commons.pagination.PagingCriteria;
import com.aoto.iqms.report.models.AbandonRateReportQuery;

/**
 * 弃票率报表-业务层接口
 * @author tianjm 20181128
 */
public interface AbandonRateReportService {
	
	/**
     * 调用存储过程进行分页数据查询
     * @param map
     * @return
     */
    public List<Map<String, Object>> procPageARReport(PagingCriteria pagingCriteria,AbandonRateReportQuery model);
	
    /**
     * 图形
     */
    public List<Map<String, Object>>  procPageARReportGraphic(PagingCriteria pagingCriteria,AbandonRateReportQuery model);
}
