package com.aoto.iqms.report.service.inf;
/**
 * 系统交互日志记录服务接口
 * 
 */
public interface OperationLogService {
	
	/**
	 * 插入记录
	 * @param data
	 * @param type
	 * @return
	 */
	public String insertOpertionLog(String date,String data,String type);
	
}
