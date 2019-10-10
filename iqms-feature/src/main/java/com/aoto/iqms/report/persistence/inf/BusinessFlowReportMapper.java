package com.aoto.iqms.report.persistence.inf;

import java.util.List;
import java.util.Map;

/****
 *业务流水报表-持久层接口
 * @author humz
 *
 */
public interface BusinessFlowReportMapper {
	
	  /**
     * 调用存储过程进行分页数据查询
     * @param map
     * @return
     */
    public List<Map<String, Object>> procPageBFReport(Map<String, Object> map);
    
}
