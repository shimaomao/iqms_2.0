package com.aoto.iqms.report.persistence.inf;

import java.util.List;
import java.util.Map;

/****
 * 客户分析报表-持久层接口
 * @author humz
 *
 */
public interface CusAnalyseReportMapper {
    
    /**
     * 调用存储过程进行分页数据查询
     * @param map
     * @return
     */
    public List<Map<String, Object>> procPageCAReport(Map<String, Object> map);
    
    /**
     * 图像
     */
    public List<Map<String, Object>> procCAReportGraphic(Map<String, Object> map);
}
