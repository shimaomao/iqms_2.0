package com.aoto.iqms.externals.dealprocess;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.time.DateFormatUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.aoto.iqms.externals.models.deviceheartbeat.DevHeartbeatDataReq;
import com.aoto.iqms.externals.models.deviceheartbeat.DevHeartbeatDataResp;
import com.aoto.iqms.externals.models.deviceheartbeat.DevHeartbeatResp;
import com.aoto.iqms.externals.models.flowdata.FlowData;
import com.aoto.iqms.externals.service.inf.ResourceService;
import com.aoto.iqms.util.JsonUtils;
import com.fasterxml.jackson.databind.JsonNode;

/**
 * 设备心跳信息处理
 * @author hongxz
 *
 */
public class DeviceHeartbeatProcess {
	private static final Logger logger = LoggerFactory
			.getLogger(DeviceHeartbeatProcess.class);
	
	public DeviceHeartbeatProcess() {
	}
	
	/**
	 * 处理心跳
	 * @param resourceService
	 * @param deviceIp
	 * @param transCode
	 * @param json
	 * @return
	 */
	public String dealDeviceHeartbeat(ResourceService resourceService,
			String transCode,JsonNode root){
		//创建响应对象
		DevHeartbeatResp heartbeatResp  = new DevHeartbeatResp();
		
		heartbeatResp.getHead().setTransCode(transCode);
		heartbeatResp.getHead().setTransDateTime(DateFormatUtils.format(new Date(), "yyyy-MM-dd HH:mm:ss"));
		try {
			//将json的请求数据封装成对象
			//1.获取数据部分的报文
			JsonNode dataNode = root.findValue("data");
			if (dataNode == null) {
				heartbeatResp.getHead().setTransStatus("9999");
				heartbeatResp.getHead().setTransDescription("设备心跳处理异常：没有发现data节点数据");
			} else {
				String dataJson = dataNode.toString();
				DevHeartbeatDataReq devHeartbeatDataReq = JsonUtils.json2pojo(dataJson, DevHeartbeatDataReq.class);
				DevHeartbeatDataResp devHeartbeatDataResp  = resourceService.dealHeartbeat(devHeartbeatDataReq);
				heartbeatResp.setData(devHeartbeatDataResp);
				heartbeatResp.getHead().setTransDescription("成功");
				heartbeatResp.getHead().setTransStatus("0000");
			}
		} catch (Exception e) {
			logger.info("DeviceHeartbeatProcess：心跳处理异常：对象转换或者心跳查询。",e);
			heartbeatResp.getHead().setTransStatus("9999");
			heartbeatResp.getHead().setTransDescription("心跳处理异常：对象转换或者心跳查询");
		}
		logger.info("DeviceHeartbeatProcess：心跳处理，开始封装返回信息：====》");
		String json = "";
		try {
			json = JsonUtils.obj2json(heartbeatResp);
			logger.info("DeviceHeartbeatProcess：心跳处理，封装返回信息="+json);
		} catch (Exception e) {
			logger.info("DeviceHeartbeatProcess：心跳处理，将返回信息转换成json异常。",e);
			json = "{"+
			    "\"head\":{"+
			        "\"transCode\":\""+transCode+"\","+
			        "\"transDateTime\":\""+DateFormatUtils.format(new Date(), "yyyy-MM-dd HH:mm:ss")+"\","+
			        "\"transStatus\":\"9999\","+
			        "\"transDescription\":\"心跳处理，返回信息转换成json异常\""+
			    "}"+
			"}";
		}
		return json;
	}
}
