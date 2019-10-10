package com.aoto.iqms.report.service.inf;

import java.util.List;
import java.util.Map;

import com.aoto.framework.commons.pagination.PagingCriteria;
import com.aoto.iqms.report.models.BusinessCountReportQuery;

/**
 * 业务量报表-业务层接口
 * @author humz
 *
 */
public interface BusinessCountReportService {
	
	/**
     * 调用存储过程进行分页数据查询
     * @param map
     * @return
     */
    public List<Map<String, Object>> procPageBcreport(PagingCriteria pagingCriteria,BusinessCountReportQuery model);
	
    /**
     * 图像
     * @param map
     * @return
     */
    public List<Map<String, Object>> procPageBcreportGraphic(PagingCriteria pagingCriteria,BusinessCountReportQuery model);
}
