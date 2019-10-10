package com.aoto.iqms.report.service.impl;

import java.util.HashMap;
import java.util.Map;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.aoto.iqms.report.commons.constant.ReportBeanProperty.OperationInfo;
import com.aoto.iqms.report.persistence.inf.OperationLogMapper;
import com.aoto.iqms.report.service.inf.OperationLogService;

/**
 * 系统交互日志记录服务层具体实现
 * @author pzw
 *
 */
@Service
public class OperationLogServiceImpl implements OperationLogService {

	private static final Logger logger = LoggerFactory.getLogger(OperationLogServiceImpl.class);
	
	@Autowired
	private OperationLogMapper operationLogMapper;
	
	@Override
	public String insertOpertionLog(String date,String data, String type) {
		// TODO Auto-generated method stub
		
		try{
			Map<String, Object> map = new HashMap<String, Object>();
			map.put(OperationInfo.data, data);
			map.put(OperationInfo.type, type);
			map.put(OperationInfo.date, date);
			operationLogMapper.callInsertOperationLog(map);		
			return "0";
		}catch(Exception e){
			logger.error("系统交互日志记录发生了异常！异常信息为：" + e);
			return "-1";
		}
		
	}

}
