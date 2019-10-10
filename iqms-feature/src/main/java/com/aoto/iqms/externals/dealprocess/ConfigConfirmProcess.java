package com.aoto.iqms.externals.dealprocess;

import java.util.Date;

import org.apache.commons.lang.time.DateFormatUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.aoto.iqms.externals.models.configupdateconfirm.ConfigConfirmDataResp;
import com.aoto.iqms.externals.models.configupdateconfirm.ConfigConfirmResp;
import com.aoto.iqms.externals.models.patchdlconfirm.PatchDlConfirmDataResp;
import com.aoto.iqms.externals.models.patchdlconfirm.PatchDlConfirmReq;
import com.aoto.iqms.externals.models.patchdlconfirm.PatchDlConfirmResp;
import com.aoto.iqms.externals.service.inf.ResourceService;
import com.aoto.iqms.util.JsonUtils;
import com.fasterxml.jackson.databind.JsonNode;

/**
 * 配置更新确认过程
 * @author hongxz
 *
 */
public class ConfigConfirmProcess {
	private static final Logger logger = LoggerFactory
			.getLogger(ConfigConfirmProcess.class);

	public ConfigConfirmProcess() {
		super();
	}
	
	
	/**
	 * 配置更新确认
	 * @param resourceService
	 * @param transCode
	 * @param json
	 * @return
	 */
	public String patchDlConfirm(ResourceService resourceService,
			String transCode,JsonNode root){
		//创建响应对象
		ConfigConfirmResp configConfirmResp  = new ConfigConfirmResp();
		
		configConfirmResp.getHead().setTransCode(transCode);
		configConfirmResp.getHead().setTransDateTime(DateFormatUtils.format(new Date(), "yyyy-MM-dd HH:mm:ss"));
		try {
			//将json的请求数据封装成对象
			//1.获取数据部分的报文
			JsonNode dataNode = root.findValue("deviceId");
			if (dataNode == null) { //异常
				configConfirmResp.getHead().setTransStatus("9999");
				configConfirmResp.getHead().setTransDescription("配置更新确认 ：没有发现data中的deviceId节点数据");
				return responseJson(transCode,configConfirmResp);
			} 
			
			String dataJson = dataNode.toString();
			//调用存储过程执行更新
			
			String result = resourceService.configConfirm(dataJson);
			
			ConfigConfirmDataResp configConfirmDataResp = new ConfigConfirmDataResp();
			if (result.equals("0")) {
				configConfirmResp.getHead().setTransDescription("成功");
				configConfirmResp.getHead().setTransStatus("0000");
			} else {
				configConfirmResp.getHead().setTransDescription("配置更新确认失败：配置更新的设备未能查询到");
				configConfirmResp.getHead().setTransStatus("9999");
			}
				
			
			configConfirmResp.setData(configConfirmDataResp);
			return  responseJson(transCode, configConfirmResp);
				
		} catch (Exception e) {
			logger.info("ConfigConfirmProcess：配置更新确认处理异常：对象转换异常。",e);
			configConfirmResp.getHead().setTransStatus("9999");
			configConfirmResp.getHead().setTransDescription("配置更新确认处理异常：对象转换异常");
		}
		logger.info("ConfigConfirmProcess：配置更新确认处理，开始封装返回信息：====》");
		String json = "";
		try {
			json = JsonUtils.obj2json(configConfirmResp);
			logger.info("ConfigConfirmProcess：配置更新确认，封装返回信息="+json);
		} catch (Exception e) {
			logger.info("ConfigConfirmProcess：配置更新确认，将返回信息转换成json异常。",e);
			json = "{"+
			    "\"head\":{"+
			        "\"transCode\":\""+transCode+"\","+
			        "\"transDateTime\":\""+DateFormatUtils.format(new Date(), "yyyy-MM-dd HH:mm:ss")+"\","+
			        "\"transStatus\":\"9999\","+
			        "\"transDescription\":\"配置更新确认，返回信息转换成json异常\""+
			    "}"+
			"}";
		}
		return json;
	}
	
	/**
	 * 封装响应的json信息
	 * @param transCode
	 * @param bookActiveResp
	 * @return
	 */
	private String responseJson(String transCode, ConfigConfirmResp configConfirmResp) {
		logger.info("PatchDlConfirmProcess：配置更新确认处理，开始封装返回信息：====》");
		String json = "";
		try {
			json = JsonUtils.obj2json(configConfirmResp);
			logger.info("PatchDlConfirmProcess：配置更新确认，封装返回信息="+json);
		} catch (Exception e) {
			logger.info("PatchDlConfirmProcess：配置更新确认，将返回信息转换成json异常。",e);
			json = "{"+
			    "\"head\":{"+
			        "\"transCode\":\""+transCode+"\","+
			        "\"transDateTime\":\""+DateFormatUtils.format(new Date(), "yyyy-MM-dd HH:mm:ss")+"\","+
			        "\"transStatus\":\"9999\","+
			        "\"transDescription\":\"配置更新确认，返回信息转换成json异常\""+
			    "}"+
			"}";
		}
		return json;
	}
}
