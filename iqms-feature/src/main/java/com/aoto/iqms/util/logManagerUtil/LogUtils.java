package com.aoto.iqms.util.logManagerUtil;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;
import com.aoto.iqms.report.service.inf.OperationLogService;
import com.aoto.iqms.util.SpringContextUtil;

/**
 * 系统交互记录帮助类，在排管系统与其他系统进行数据交互时，如发起客户鉴权，发送短信，将发起交易的时间，交互的报文，交互的类型插入数据库中
 * @author pzw
 *
 */
public class LogUtils {
	
	private static OperationLogService operationLogService;
	private static SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
	
	public static String insertOperationLog(Map<String,Object> map){
		try{
			//获取服务层实例
			operationLogService = (OperationLogService)SpringContextUtil.getBean("operationLogServiceImpl");
			//调用服务层方法
			return operationLogService.insertOpertionLog(df.format(new Date()),(String)map.get("data"), (String)map.get("type"));
		}catch(Exception e){
			return "-1";
		}
	}
}
