package com.aoto.iqms.businessconfig.service.impl;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintStream;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.apache.commons.io.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.aoto.framework.commons.lang.StringUtils4Aoto;
import com.aoto.iqms.businessconfig.commons.constant.BusinessconfigBeanProperty.BscBranchBusiness;
import com.aoto.iqms.businessconfig.commons.constant.BusinessconfigBeanProperty.BscCustLevel;
import com.aoto.iqms.businessconfig.models.BscBranchBusinessQuery;
import com.aoto.iqms.businessconfig.models.BscWinConfigModel;
import com.aoto.iqms.businessconfig.models.CallStrategyModel;
import com.aoto.iqms.businessconfig.persistence.inf.CallStrategyMapper;
import com.aoto.iqms.businessconfig.service.inf.BscWinConfigService;
import com.aoto.iqms.businessconfig.service.inf.CallStrategyService;
import com.aoto.iqms.util.DateUtil;
import com.aoto.iqms.util.FileUtils;
import com.aoto.iqms.util.JsonUtils;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.mysql.cj.api.xdevapi.Result;

/**
 * 叫号策略-业务实现层
 * @author humz
 *
 */
@Service
public class CallStrategyServiceImpl implements CallStrategyService{

	@Autowired
	private CallStrategyMapper callStrategyMapper;
	@Autowired
	private BscWinConfigService bscWinConfigService;
	/**
	 * 查询窗口列表
	 */
	@Override
	public Map<String, Object> selectWinConfig(Map<String, Object> map) {
		String orgId = (String) map.get("orgId");
		String deviceNo = (String) map.get("deviceNo");
		
		Map<String, Object> map2 = new HashMap<String,Object>();
		map2.put("orgId", orgId);
		map2.put("deviceNo", deviceNo);
		
		callStrategyMapper.selectWinConfig(map2);
		List<Map<String, Object>> list = (List<Map<String, Object>>) map2.get("pageDatas");
		Map<String, Object> map3 = new HashMap<String, Object>();
		map3.put("counters", list);
		return map3;
	}

	/**
	 * 查询业务类型
	 */
	@Override
	public Map<String, Object> selectBuzType(Map<String, Object> map) {
		String orgId = (String) map.get("orgId");
		String deviceNo = (String) map.get("deviceNo");
		
		Map<String, Object> map2 = new HashMap<String,Object>();
		map2.put("orgId", orgId);
		map2.put("deviceNo", deviceNo);
		
		callStrategyMapper.selectBuzType(map2);
		List<Map<String, Object>> list = (List<Map<String, Object>>) map2.get("pageDatas");
		Map<String, Object> map3 = new HashMap<String, Object>();
		map3.put("buzTypes", list);
		return map3;
	}

	/**
	 * 查询业务类型与客户等级的笛卡尔乘积
	 */
	@Override
	public Map<String, Object> selectCounterBuz(Map<String, Object> map) {
		String orgId = (String) map.get("orgId");
		String deviceNo = (String) map.get("deviceNo");
		
		Map<String, Object> map2 = new HashMap<String,Object>();
		map2.put("orgId", orgId);
		map2.put("deviceNo", deviceNo);
		
		callStrategyMapper.selectCounterBuz(map2);
		List<Map<String, Object>> list =  (List<Map<String, Object>>) map2.get("pageDatas");
		Map<String, Object> map3 = new HashMap<String, Object>();
		map3.put("counterBuzs", list);
		return map3;
	}

	/**
	 * 查询保存的窗口统计数据
	 */
	@Override
	public Map<String, Object> selectCounterBuzsByWinId(Map<String, Object> map) {
		String orgId = (String) map.get("orgId");
		String deviceNo = (String) map.get("deviceNo");
		String winId = (String) map.get("winId");
		
		Map<String, Object> map2 = new HashMap<String,Object>();
		map2.put("orgId", orgId);
		map2.put("deviceNo", deviceNo);
		map2.put("winId",winId);
		
	    callStrategyMapper.selectCounterBuzsByWinId(map2);
	    List<Map<String, Object>> list =  (List<Map<String, Object>>) map2.get("pageDatas");
		Map<String, Object> map3 = new HashMap<String,Object>();
		map3.put("counterId", winId);
		map3.put("counterBuzs", list);
		return map3;
	}


	/**
	 * 保存配置到数据库
	 */
	@Override
	public String saveCounterBuzs(Map<String, Object> map) {
		String errorCode = "";
		//遍历集合，循环插入数据到数据库中
		List<Map<String, Object>> strList = (List<Map<String, Object>>) map.get("counterId");
		List<Map<String, Object>> list = (List<Map<String, Object>>) map.get("counterBuzs");
		String orgId = (String) map.get("orgId");
		String deviceNo = (String) map.get("deviceNo");
		
		Map<String, Object> map2 = new HashMap<String, Object>();
		Map<String, Object> map3 = new HashMap<String,Object>();
		
		/**
		 * 先删除所有数据，再进行增加和修改数据
		 */
		for (int i = 0; i < strList.size(); i++) {
			map3.put("orgId", orgId);
			map3.put("deviceNo", deviceNo);
			map3.put("winId", strList.get(i));
			callStrategyMapper.deleteCounterBuzs(map3);
		}
		
		for (int i = 0; i < list.size(); i++) {
			map2.put("orgId", orgId);
			map2.put("deviceNo", deviceNo);
			map2.putAll(list.get(i));;
			callStrategyMapper.saveCounterBuzs(map2);
			errorCode = (String) map2.get("ReturnCode");
		}
		
		return errorCode;
	}

	/**
	 * 根据设备号查询，提供排队机下载
	 */
	@Override
	public void createCounterBuzs(BscBranchBusinessQuery model,String path) {
		try {
		//		String classPath = this.getClass().getResource("/").getPath().replaceFirst("/", "");//E:/apache-tomcat-7.0.75/webapps/iqms-web/WEB-INF/classes/
//		String webappRoot = classPath.replaceAll("WEB-INF/classes/", "");//E:/apache-tomcat-7.0.75/webapps/iqms-web/
//		webappRoot = webappRoot.replaceAll("////", "\\");//E:\apache-tomcat-7.0.75\webapps\iqms-web\
//		String path = webappRoot +"\\download";
		//String path = "iqms-web\\download";
		Map<String, Object> map = new HashMap<String,Object>();
		map.put("orgId", model.getOrgId());
		map.put("deviceNo", model.getDeviceNo());
		
		callStrategyMapper.selectCounterId(map);
		List<Map<String, Object>> list = (List<Map<String, Object>>) map.get("pageDatas");
		if(list.size() == 0){
			return;
		}
		List<String> counters = new ArrayList<String>();
		for(int i = 0; i < list.size(); i++ ){
			counters.add(list.get(i).get("counterId").toString());
		}
		callStrategyMapper.selectDevice(map);
		List<Map<String, Object>> list2 = (List<Map<String, Object>>) map.get("pageDatas");
		
		Map<String, Object> map2 = new HashMap<String,Object>();
		map2.put("counterId", counters);
		map2.put("counterBuzs", list2);
		
		
			String json = JsonUtils.obj2json(map2);
			FileUtils.outPutFiles(json, path+File.separator+"temp",path+File.separator+"temp"+File.separator+"counterBuzs.json");
			//存放历史文件路径
			String path2 = path+File.separator+model.getOrgId()+"_"+model.getDeviceNo();
			FileUtils.outPutFiles(json, path2,path2+File.separator+"counterBuzs_"+DateUtil.getNow()+".json");
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public String callStrategyCopy(CallStrategyModel model) {
		List<Map<String, Object>> list = bscWinConfigService.createOrgIdDeviceNo(model.getOrgDevicelist());
		for(int i=0; i<list.size(); i++){
			Map<String, Object> map = list.get(i);
			map.put(BscCustLevel.ORG_ID, model.getOrgId());
			map.put(BscCustLevel.DEVICE_NO, model.getDeviceNo());
			callStrategyMapper.callStrategyCopy(map);
		}
		return "0";
	}
	
	 
	 public List<Map<String, Object>> checkedWinBuz(CallStrategyModel model){
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("deviceNo", StringUtils4Aoto.trim(model.getDeviceNo()));
		map.put("winId", StringUtils4Aoto.trim(model.getWinId()));
		List<Map<String, Object>> list = callStrategyMapper.checkedWinBuz(map);
		return list;
	 }
	
	
}
