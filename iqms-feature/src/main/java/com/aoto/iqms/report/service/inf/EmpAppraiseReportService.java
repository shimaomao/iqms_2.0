package com.aoto.iqms.report.service.inf;

import java.util.List;
import java.util.Map;

import com.aoto.framework.commons.pagination.PagingCriteria;
import com.aoto.iqms.report.models.EmpAppraiseReportQuery;

/**
 * 柜员评价报表-业务层接口
 * @author humz
 *
 */
public interface EmpAppraiseReportService {
	
	/**
     * 调用存储过程进行分页数据查询
     * @param map
     * @return
     */
    public List<Map<String, Object>> procPageEAreport(PagingCriteria pagingCriteria,EmpAppraiseReportQuery model);
	
}
