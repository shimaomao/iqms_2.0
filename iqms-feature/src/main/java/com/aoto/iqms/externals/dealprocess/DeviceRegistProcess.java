package com.aoto.iqms.externals.dealprocess;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.time.DateFormatUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.aoto.iqms.externals.models.deviceregist.DeviceRegistResp;
import com.aoto.iqms.externals.service.inf.ResourceService;
import com.aoto.iqms.util.JsonUtils;

/**
 * 客户端设备注册（返回客户端设备在后台登记的信息）
 * @author hongxz
 *
 */
public class DeviceRegistProcess {
	private static final Logger logger = LoggerFactory
			.getLogger(DeviceRegistProcess.class);
	
	public DeviceRegistProcess() {
	}
	
	/**
	 * 根据IP地址查询，设备信息
	 * @param resourceService  资源对象
	 * @param deviceIp         设备ip地址
	 * @return  json
	 */
	public String registDevice(ResourceService resourceService,
			String deviceIp,String transCode){
		//创建响应对象
		DeviceRegistResp deviceRegistResp = new DeviceRegistResp();
		
		deviceRegistResp.getHead().setTransCode(transCode);
		deviceRegistResp.getHead().setTransDateTime(DateFormatUtils.format(new Date(), "yyyy-MM-dd HH:mm:ss"));
		try {
			//数据查询
			Map<String, String> map = new HashMap<String,String>();
			map.put("ipAddr", deviceIp);
			List<Map<String, Object>> deviceList = resourceService.findDeviceByConditon(map);
			
			//业务逻辑判断
			if (deviceList == null || deviceList.size() == 0){
				//未能查询到设备信息
				logger.info("DeviceRegistProcess：设备注册，未能查询到ip对应的登记信息。"+deviceIp);
				deviceRegistResp.getHead().setTransStatus("9999");
				deviceRegistResp.getHead().setTransDescription("根据IP地址，未能查询到后台登记的设备信息");
			} else {
				
				Map<String, Object> deviceInfo = deviceList.get(0);
				//获取设备信息
				String orgId = (String)deviceInfo.get("orgId");
				String deviceNo = (String)deviceInfo.get("deviceNo");
				String orgCode = (String)deviceInfo.get("orgCode");
				String orgName = (String)deviceInfo.get("orgName");
				String orderFlag = (String)deviceInfo.get("orderFlag");
				String screenResolution = (String)deviceInfo.get("screenResolution");
				String onlineModel = (String)deviceInfo.get("onlineModel");
				String tpscrollflag = (String)deviceInfo.get("tpscrollflag");
				
				//封装响应部分数据
				deviceRegistResp.getData().setDeviceId(deviceNo);
				deviceRegistResp.getData().setOrderFlag(orderFlag);
				deviceRegistResp.getData().setOrgCode(orgCode);
				deviceRegistResp.getData().setOrgId(orgId);
				deviceRegistResp.getData().setOrgName(orgName);
				deviceRegistResp.getData().setScreenResolution(screenResolution);
				deviceRegistResp.getData().setOnlineModel(onlineModel.equals("1")?true:false);
				deviceRegistResp.getData().setTpscrollflag(tpscrollflag.equals("")?"0":"1");
				
				
				//查询参数信息
				List<Map<String, Object>> params = resourceService.findParamInfo();
				if (params != null && params.size() > 0){
					Map<String, Object> paramMap = params.get(0);
					String flowPort = paramMap.get("flowPort") == null ?"8999":paramMap.get("flowPort").toString();
					String identPort = paramMap.get("identPort") == null ?"8998":paramMap.get("identPort").toString();
					String httpPort = paramMap.get("httpPort") == null ?"7001":paramMap.get("httpPort").toString();
					String appRoot = paramMap.get("appRoot") == null ?"/iqms":paramMap.get("appRoot").toString();
					deviceRegistResp.getData().setFlowPort(flowPort);
					deviceRegistResp.getData().setIdentPort(identPort);
					deviceRegistResp.getData().setHttpPort(httpPort);
					deviceRegistResp.getData().setAppRoot(appRoot);
				} else {
					deviceRegistResp.getData().setFlowPort("8999");
					deviceRegistResp.getData().setIdentPort("8998");
					deviceRegistResp.getData().setHttpPort("7001");
					deviceRegistResp.getData().setAppRoot("/iqms");
				}

				//封装响应头信息
				deviceRegistResp.getHead().setTransDescription("成功");
				deviceRegistResp.getHead().setTransStatus("0000");
			}
		} catch (Exception e) {
			logger.info("DeviceRegistProcess：设备注册，根据IP，查询设备信息异常。",e);
			deviceRegistResp.getHead().setTransStatus("9999");
			deviceRegistResp.getHead().setTransDescription("设备注册，根据IP，查询设备信息异常");
		}
		String json = "";
		try {
			json = JsonUtils.obj2json(deviceRegistResp);
			logger.info("DeviceRegistProcess：设备注册，封装返回信息="+json);
		} catch (Exception e) {
			logger.info("DeviceRegistProcess：设备注册，将返回信息转换成json异常。",e);
			json = "{"+
			    "\"head\":{"+
			        "\"transCode\":\""+transCode+"\","+
			        "\"transDateTime\":\""+DateFormatUtils.format(new Date(), "yyyy-MM-dd HH:mm:ss")+"\","+
			        "\"transStatus\":\"9999\","+
			        "\"transDescription\":\"设备注册，返回信息转换成json异常\""+
			    "}"+
			"}";
		}
		return json;
	}
}
