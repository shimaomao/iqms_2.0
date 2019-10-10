package com.aoto.iqms.report.persistence.inf;

import java.util.List;
import java.util.Map;

/**
 * 柜员效率报表-持久层接口
 * @author humz
 *
 */
public interface EmpEfficiencyReportMapper {
    
    /**
     * 调用存储过程进行分页数据查询
     * @param map
     * @return
     */
    public List<Map<String, Object>> procPageEEReport(Map<String, Object> map);
    
}
