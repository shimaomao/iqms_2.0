package com.aoto.iqms.report.service.inf;

import java.util.List;
import java.util.Map;

import com.aoto.framework.commons.pagination.PagingCriteria;
import com.aoto.iqms.report.models.BusinessStatisticsReportQuery;

/**
 * 业务统计报表-业务层接口
 * @author humz
 *
 */
public interface BusinessStatisticsReportService {

	/**
     * 调用存储过程进行分页数据查询
     * @param map
     * @return
     */
    public List<Map<String, Object>> procPageBSReport(PagingCriteria pagingCriteria,BusinessStatisticsReportQuery model);
    
    /**
     * 图像
     * @param map
     * @return
     */
    public List<Map<String, Object>>  procPageBSReportGraphic(PagingCriteria pagingCriteria,BusinessStatisticsReportQuery model);
    
   
}
