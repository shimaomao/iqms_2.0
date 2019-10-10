package com.aoto.iqms.report.persistence.inf;

import java.util.List;
import java.util.Map;

/****
 * 弃票率报表-持久层接口
 *@author tianjm 20181128
 */
public interface AbandonRateReportMapper {
    
    /**
     * 调用存储过程进行分页数据查询
     * @param map
     * @return
     */
    public List<Map<String, Object>> procPageARReport(Map<String, Object> map);
    
    /**
     * 图像
     */
    public List<Map<String, Object>> procARReportGraphic(Map<String, Object> map);
}
