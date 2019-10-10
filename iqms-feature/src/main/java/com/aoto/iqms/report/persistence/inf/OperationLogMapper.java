package com.aoto.iqms.report.persistence.inf;

import java.util.Map;

/**
 * 系统交互日志记录-持久层
 *
 */
public interface OperationLogMapper {
   
	/**
     * 调用存储过程增加记录
     * @param map
     */
    public void callInsertOperationLog(Map<String, Object> map);
    
}
