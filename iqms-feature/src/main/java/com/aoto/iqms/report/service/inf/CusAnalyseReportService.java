package com.aoto.iqms.report.service.inf;

import java.util.List;
import java.util.Map;

import com.aoto.framework.commons.pagination.PagingCriteria;
import com.aoto.iqms.report.models.CusAnalyseReportQuery;

/**
 * 客户分析报表-业务层接口
 * @author humz
 *
 */
public interface CusAnalyseReportService {
	
	/**
     * 调用存储过程进行分页数据查询
     * @param map
     * @return
     */
    public List<Map<String, Object>> procPageCAReport(PagingCriteria pagingCriteria,CusAnalyseReportQuery model);
	
    /**
     * 图形
     */
    public List<Map<String, Object>>  procPageCAReportGraphic(PagingCriteria pagingCriteria,CusAnalyseReportQuery model);
}
