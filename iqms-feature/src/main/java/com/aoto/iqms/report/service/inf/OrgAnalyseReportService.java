package com.aoto.iqms.report.service.inf;

import java.util.List;
import java.util.Map;

import com.aoto.framework.commons.pagination.PagingCriteria;
import com.aoto.iqms.report.models.OrgAnalyseReportQuery;

/**
 * 机构分析报表-业务层接口
 * @author humz
 *
 */
public interface OrgAnalyseReportService {
	
	/**
     * 调用存储过程进行分页数据查询
     * @param map
     * @return
     */
    public List<Map<String, Object>> procPageOAReport(PagingCriteria pagingCriteria,OrgAnalyseReportQuery model);
	
}
