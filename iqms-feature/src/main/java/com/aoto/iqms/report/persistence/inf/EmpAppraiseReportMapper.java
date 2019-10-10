package com.aoto.iqms.report.persistence.inf;

import java.util.List;
import java.util.Map;

/**
 * 柜员评价报表-持久层接口
 * @author humz
 *
 */
public interface EmpAppraiseReportMapper {
    
    /**
     * 调用存储过程进行分页数据查询
     * @param map
     * @return
     */
    public List<Map<String, Object>> procPageEAReport(Map<String, Object> map);
    
}
