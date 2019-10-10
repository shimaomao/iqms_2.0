package com.aoto.iqms.report.persistence.inf;

import java.util.List;
import java.util.Map;

/****
 * 业务统计报表-持久层接口
 * @author humz
 *
 */
public interface BusinessStatisticsReportMapper {

	/**
     * 调用存储过程进行分页数据查询
     * @param map
     * @return
     */
    public List<Map<String, Object>> procPageBSReport(Map<String, Object> map);
    
    /**
     * 图像
     * @param map
     * @return
     */
    public List<Map<String, Object>> procPageBSReportGraphic(Map<String, Object> map);
}
