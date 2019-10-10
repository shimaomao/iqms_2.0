package com.aoto.iqms.businessconfig.service.impl;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.aoto.framework.commons.lang.StringUtils4Aoto;
import com.aoto.iqms.businessconfig.commons.constant.BusinessconfigBeanProperty.BscBranchBusiness;
import com.aoto.iqms.businessconfig.commons.constant.BusinessconfigBeanProperty.BscSpecialDate;
import com.aoto.iqms.businessconfig.commons.constant.BusinessconfigBeanProperty.BscWinConfig;
import com.aoto.iqms.businessconfig.models.BscBranchBusinessQuery;
import com.aoto.iqms.businessconfig.models.BscCustRecognitionQuery;
import com.aoto.iqms.businessconfig.models.BscSpecialDateModel;
import com.aoto.iqms.businessconfig.persistence.inf.BscSpecialDateMapper;
import com.aoto.iqms.businessconfig.service.inf.BscSpecialDateService;
import com.aoto.iqms.businessconfig.service.inf.BscWinConfigService;
import com.aoto.iqms.util.DateUtil;
import com.aoto.iqms.util.FileUtils;
import com.aoto.iqms.util.JsonUtils;

/**
*@author zsj
*@创建时间：2018年10月9日下午6:45:17
*特殊日期实现类
*/
@Service
@Transactional
public class BscSpecialDateServiceImpl implements BscSpecialDateService{
	@Autowired
	private BscSpecialDateMapper specialDateMapper;
	@Autowired
	private BscWinConfigService winConfigService;
	
	@Override
	public List<Map<String, Object>> procSpecialDateQuery(BscCustRecognitionQuery model) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put(BscSpecialDate.DEVICE_NO, StringUtils4Aoto.trim(model.getDeviceNo()));
		List<Map<String, Object>> list = specialDateMapper.callSpecialDateQuery(map);
		list = (List<Map<String, Object>>) map.get("pageDatas");
		return list;
	}

	@Override
	public String procSaveSpecialDate(List<BscSpecialDateModel> list) {
		String result = "";
		if(list.get(0).getSaveStatus().equals("deleted")){
			procDeleteSpecialDate(list.get(0));
		}
		for(int i=0; i<list.size(); i++){
			if(list.get(i).getSaveStatus().equals("inserted")){
				Map<String, Object> map = new HashMap<String, Object>();
				map.put(BscSpecialDate.DEVICE_NO, StringUtils4Aoto.trim(list.get(i).getDeviceNo()));
				map.put(BscSpecialDate.SPECIAL_DATE, StringUtils4Aoto.trim(list.get(i).getSpecialDate()));
				map.put(BscSpecialDate.DATE_TYPE, StringUtils4Aoto.trim(list.get(i).getDateType()));
				try {
					specialDateMapper.callInsertSpecialDate(map);
					result = (String) map.get("ReturnCode");
				} catch (Exception e) {
					e.printStackTrace();
					result = "1";//失败
				}
			}
		}
		return result;
	}
	
	
	@Override
	public String procDeleteSpecialDate(BscSpecialDateModel model) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put(BscSpecialDate.DEVICE_NO, StringUtils4Aoto.trim(model.getDeviceNo()));
		specialDateMapper.callDeleteSpecialDate(map);
		return "0";
	}
	
	
	@Override
	public String procSpecialDateCopy(BscSpecialDateModel model) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put(BscSpecialDate.DEVICE_NO, StringUtils4Aoto.trim(model.getDeviceNo()));
		List<Map<String, Object>> list = specialDateMapper.callSpecialDateQuery(map);
		list = (List<Map<String, Object>>) map.get("pageDatas");
		if(list.size() == 0){
			return "2";//配置未保存
		}
		list = winConfigService.createOrgIdDeviceNo(model.getOrgDevicelist());
		for(int i=0; i<list.size(); i++){
			map = list.get(i);
			map.put(BscWinConfig.DEVICE_NO, model.getDeviceNo());
			specialDateMapper.callCopySpecialDate(map);
		}
		return "0";
	}

	@Override
	public void createSpecialDates(BscBranchBusinessQuery model, String path) {
		List<Map<String, Object>> list = procSpecialDates(model);
		if(list.size() == 0){
			return;
		}
		Map<String, Object> specialDateMap = new HashMap<String, Object>(); 
		for(int i = 0; i<list.size(); i++){
			specialDateMap.put("specialDates", list);
		}
		try {
			String json = JsonUtils.obj2json(specialDateMap);
			FileUtils.outPutFiles(json, path+File.separator+"temp",path+File.separator+"temp"+File.separator+"specialDates.json");
			//存放历史文件路径
			String path2 = path+File.separator+model.getOrgId()+"_"+model.getDeviceNo();
			FileUtils.outPutFiles(json, path2,path2+File.separator+"specialDates_"+DateUtil.getNow()+".json");
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}

	@Override
	public List<Map<String, Object>> procSpecialDates(BscBranchBusinessQuery model) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put(BscBranchBusiness.DEVICE_NO, StringUtils4Aoto.trim(model.getDeviceNo()));
		List<Map<String, Object>> list = specialDateMapper.callSpecialDates(map);
		list = (List<Map<String, Object>>) map.get("pageDatas");
		return list;
	}

}
