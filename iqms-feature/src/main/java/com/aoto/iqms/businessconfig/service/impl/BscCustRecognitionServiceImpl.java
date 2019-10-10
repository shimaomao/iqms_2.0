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
import com.aoto.iqms.businessconfig.commons.constant.BusinessconfigBeanProperty.BscCustRegconition;
import com.aoto.iqms.businessconfig.commons.constant.BusinessconfigBeanProperty.BscWinConfig;
import com.aoto.iqms.businessconfig.models.BscBranchBusinessQuery;
import com.aoto.iqms.businessconfig.models.BscCustRecognitionModel;
import com.aoto.iqms.businessconfig.models.BscCustRecognitionQuery;
import com.aoto.iqms.businessconfig.persistence.inf.BscCustRecognitionMapper;
import com.aoto.iqms.businessconfig.service.inf.BscCustRecognitionService;
import com.aoto.iqms.businessconfig.service.inf.BscWinConfigService;
import com.aoto.iqms.util.DateUtil;
import com.aoto.iqms.util.FileUtils;
import com.aoto.iqms.util.JsonUtils;
/**
 * 客户识别 实现类
 * @author zhousj
 *
 */
@Service
@Transactional
public class BscCustRecognitionServiceImpl implements BscCustRecognitionService{
	@Autowired
	private BscCustRecognitionMapper custRegconitionMapper;
	@Autowired
	private BscWinConfigService winConfigService;
	@Override
	public List<Map<String, Object>> procCustRecognitionQuery(BscCustRecognitionQuery model) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put(BscCustRegconition.ORG_ID, StringUtils4Aoto.trim(model.getOrgId()));
		map.put(BscCustRegconition.DEVICE_NO, StringUtils4Aoto.trim(model.getDeviceNo()));
		List<Map<String, Object>> list = custRegconitionMapper.callCustRecognitionQuery(map);
		list = (List<Map<String, Object>>) map.get("pageDatas");
		return list;
	}
	@Override
	public String procSaveCustRecognition(List<BscCustRecognitionModel> list) {
		String result = "";
		if(list.get(0).getSaveStatus().equals("deleted")){
			procDeleteCustRecognition(list.get(0));
		}
		for(int i=0; i<list.size(); i++){
			if(list.get(i).getSaveStatus().equals("inserted")){
				Map<String, Object> map = new HashMap<String, Object>();
				map.put(BscCustRegconition.ORG_ID, StringUtils4Aoto.trim(list.get(i).getOrgId()));
				map.put(BscCustRegconition.DEVICE_NO, StringUtils4Aoto.trim(list.get(i).getDeviceNo()));
				map.put(BscCustRegconition.ROW_ID, StringUtils4Aoto.trim(list.get(i).getRowId()));
//				map.put(BscCustRegconition.RECOGNITION_TYPE, StringUtils4Aoto.trim(list.get(i).getRecognitionType()));
				map.put(BscCustRegconition.DATE_TYPE, StringUtils4Aoto.trim(list.get(i).getDateType()));
				map.put(BscCustRegconition.START_POSITION, StringUtils4Aoto.trim(list.get(i).getStartPosition()));
				map.put(BscCustRegconition.MATE_LENGTH, StringUtils4Aoto.trim(list.get(i).getMateLength()));
				map.put(BscCustRegconition.START_MATE_CODE, StringUtils4Aoto.trim(list.get(i).getStartMateCode()));
				map.put(BscCustRegconition.END_MATE_CODE, StringUtils4Aoto.trim(list.get(i).getEndMateCode()));
				map.put(BscCustRegconition.CUST_LEVEL, StringUtils4Aoto.trim(list.get(i).getCustLevel()));
				map.put(BscCustRegconition.EXTEND1, StringUtils4Aoto.trim(list.get(i).getExtend1()));
				map.put(BscCustRegconition.EXTEND2, StringUtils4Aoto.trim(list.get(i).getExtend2()));
				map.put(BscCustRegconition.EXTEND3, StringUtils4Aoto.trim(list.get(i).getExtend3()));
				
				try {
					custRegconitionMapper.callInsertCustRecognition(map);
					result = (String) map.get("ReturnCode");
				} catch (Exception e) {
					// TODO: handle exception
					e.printStackTrace();
					result = "1";//失败
				}
			}
		}
		return result;
	}
	@Override
	public String procDeleteCustRecognition(BscCustRecognitionModel model) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put(BscCustRegconition.ORG_ID, StringUtils4Aoto.trim(model.getOrgId()));
		map.put(BscCustRegconition.DEVICE_NO, StringUtils4Aoto.trim(model.getDeviceNo()));
		custRegconitionMapper.callDeleteCustRecognition(map);
		return "0";
	}
	@Override
	public String procBscCustRecognitionCopy(BscCustRecognitionModel model) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put(BscCustRegconition.ORG_ID, StringUtils4Aoto.trim(model.getOrgId()));
		map.put(BscCustRegconition.DEVICE_NO, StringUtils4Aoto.trim(model.getDeviceNo()));
		List<Map<String, Object>> list = custRegconitionMapper.callCustRecognitionQuery(map);
		list = (List<Map<String, Object>>) map.get("pageDatas");
		if(list.size() == 0){
			return "2";//配置未保存
		}
		list = winConfigService.createOrgIdDeviceNo(model.getOrgDevicelist());
		for(int i=0; i<list.size(); i++){
			map = list.get(i);
			map.put(BscWinConfig.ORG_ID, model.getOrgId());
			map.put(BscWinConfig.DEVICE_NO, model.getDeviceNo());
			custRegconitionMapper.callCopyCustRecognition(map);
		}
		return "0";
	}
	
	@Override
	public List<Map<String, Object>> procCustRecs(BscBranchBusinessQuery model) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put(BscBranchBusiness.ORG_ID, StringUtils4Aoto.trim(model.getOrgId()));
		map.put(BscBranchBusiness.DEVICE_NO, StringUtils4Aoto.trim(model.getDeviceNo()));
		List<Map<String, Object>> list = custRegconitionMapper.callCustRecs(map);
		list = (List<Map<String, Object>>) map.get("pageDatas");
		return list;
	}
	@Override
	public void createCustRecs(BscBranchBusinessQuery model,String path) {
		//String path = "iqms-web\\download";
		List<Map<String, Object>> list = procCustRecs(model);
		if(list.size() == 0){
			return;
		}
		Map<String, Object> custRecsMap = new HashMap<String, Object>(); 
		for(int i = 0; i<list.size(); i++){
			if(list.get(i).get("dateTypeId").equals("N")){
				list.get(i).put("dateTypeId", 1);
			}else if(list.get(i).get("dateTypeId").equals("H")){
				list.get(i).put("dateTypeId", 2);
			}else{
				list.get(i).put("dateTypeId", 3);
			}
			custRecsMap.put("custRecs", list);
		}
		try {
			String json = JsonUtils.obj2json(custRecsMap);
			FileUtils.outPutFiles(json, path+File.separator+"temp",path+File.separator+"temp"+File.separator+"custRecs.json");
			//存放历史文件路径
			String path2 = path+File.separator+model.getOrgId()+"_"+model.getDeviceNo();
			FileUtils.outPutFiles(json, path2,path2+File.separator+"custRecs_"+DateUtil.getNow()+".json");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	@Override
	public String procBscCustRecognitionFastCopy(BscCustRecognitionModel model) {
		List<Map<String, Object>> list = winConfigService.createOrgIdDeviceNo(model.getOrgDevicelist());
		Map<String, Object> map = new HashMap<String, Object>();
		map = list.get(0);
//		map.put(BscCustRegconition.ORG_ID, StringUtils4Aoto.trim(model.getOrgId()));
//		map.put(BscCustRegconition.DEVICE_NO, StringUtils4Aoto.trim(model.getDeviceNo()));
		map.put(BscCustRegconition.ORG_ID, map.get("targetId"));
		map.put(BscCustRegconition.DEVICE_NO, map.get("targetNo"));
		list = custRegconitionMapper.callCustRecognitionQuery(map);
		list = (List<Map<String, Object>>) map.get("pageDatas");
		if(list.size() == 0){
			return "2";//所选设备没有配置客户识别
		}
		for(int i=0; i<list.size(); i++){
			map.put("targetId", StringUtils4Aoto.trim(model.getOrgId()));
			map.put("targetNo", StringUtils4Aoto.trim(model.getDeviceNo()));
			custRegconitionMapper.callCopyCustRecognition(map);
		}
		return "0";
	}


}
