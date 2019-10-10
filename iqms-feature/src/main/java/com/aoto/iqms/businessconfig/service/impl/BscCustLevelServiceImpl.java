package com.aoto.iqms.businessconfig.service.impl;

import java.io.File;
import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.aoto.framework.commons.lang.StringUtils4Aoto;
import com.aoto.framework.commons.pagination.PagingCriteria;
import com.aoto.iqms.businessconfig.commons.constant.BusinessconfigBeanProperty.BscBranchBusiness;
import com.aoto.iqms.businessconfig.commons.constant.BusinessconfigBeanProperty.BscCustLevel;
import com.aoto.iqms.businessconfig.commons.constant.BusinessconfigBeanProperty.BscDevice;
import com.aoto.iqms.businessconfig.commons.constant.BusinessconfigBeanProperty.BscWinConfig;
import com.aoto.iqms.businessconfig.models.BscBranchBusinessQuery;
import com.aoto.iqms.businessconfig.models.BscCustLevelModel;
import com.aoto.iqms.businessconfig.models.BscCustLevelQuery;
import com.aoto.iqms.businessconfig.persistence.inf.BscCustLevelMapper;
import com.aoto.iqms.businessconfig.service.inf.BscCustLevelService;
import com.aoto.iqms.businessconfig.service.inf.BscWinConfigService;
import com.aoto.iqms.util.DateUtil;
import com.aoto.iqms.util.FileUtils;
import com.aoto.iqms.util.JsonUtils;
import com.aoto.iqms.util.ProcPageFill;

/**
 *客户等级设置 实现 
 * @author zhousj
 *
 */
@Service
@Transactional
public class BscCustLevelServiceImpl implements BscCustLevelService{
	@Autowired
	private BscCustLevelMapper custLevelMapper;
	
	@Autowired
	private BscWinConfigService bscWinConfigService;
	
	@Override
	public List<Map<String, Object>> procPageBscCustLevel(PagingCriteria pagingCriteria, BscCustLevelQuery model) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put(BscCustLevel.ORG_ID, StringUtils4Aoto.trim(model.getOrgId()));
		map.put(BscCustLevel.DEVICE_NO, StringUtils4Aoto.trim(model.getDeviceNo()));
		ProcPageFill.fillProcData(model, map,BscCustLevel.class);
		List<Map<String, Object>> list = custLevelMapper.callPageBscCustLevel(map);
		
		int total = ((BigDecimal)map.get("totalrows")).intValue();
        pagingCriteria.setTotal(total);
        list = (List<Map<String, Object>>) map.get("pageDatas");
		return list;
	}
	
	/**
	 * 调用存储过程保存包含 增改
	 */
	@Override
	public String callCreateBscCustLevelProc(List<BscCustLevelModel> list) {
		for(int i=0; i<list.size(); i++){
			Map<String, Object> map = new HashMap<String, Object>();
			map.put(BscWinConfig.ORG_ID, StringUtils4Aoto.trim(list.get(i).getOrgId()));
			map.put(BscWinConfig.DEVICE_NO, StringUtils4Aoto.trim(list.get(i).getDeviceNo()));
			map.put(BscCustLevel.CUST_LEVEL, list.get(i).getCustLevel());
			map.put(BscCustLevel.LEVEL_NAME, list.get(i).getLevelName());
			map.put(BscCustLevel.BUSINESS_ID, list.get(i).getBusinessId());
			map.put(BscCustLevel.PRIOR_TIME, list.get(i).getPriorTime());
			map.put(BscCustLevel.CALL_HEAD, list.get(i).getCallHead());
			map.put(BscCustLevel.MAX_WAIT_TIME, list.get(i).getMaxWaitTime());
			map.put(BscCustLevel.TICKET_TEMPLATE, list.get(i).getTicketTemplate());
			map.put(BscCustLevel.IS_START, list.get(i).getIsStart());
			map.put(BscCustLevel.EXTEND1, list.get(i).getExtend1());
			map.put(BscCustLevel.EXTEND2, list.get(i).getExtend2());
			map.put(BscCustLevel.EXTEND3, list.get(i).getExtend3());
//			map.put(BscCustLevel.ROW_ID, list.get(i).getRowId());
			if(map.get(BscCustLevel.BUSINESS_ID) == null || map.get(BscCustLevel.BUSINESS_ID)==""){
				map.put(BscCustLevel.BUSINESS_ID, "0");
	    	}
			custLevelMapper.callInsertBscCustLevel(map);
		}
		return "0";
	}

	@Override
	public String callUpdateBscCustLevelProc(BscCustLevelModel model) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put(BscDevice.ORG_ID, StringUtils4Aoto.trim(model.getOrgId()));
		map.put(BscDevice.DEVICE_NO, model.getDeviceNo());
		map.put(BscCustLevel.CUST_LEVEL, model.getCustLevel());
//		map.put(BscCustLevel.LEVEL_NAME, model.getLevelName());
		map.put(BscCustLevel.BUSINESS_ID, model.getBusinessId());
		map.put(BscCustLevel.PRIOR_TIME, model.getPriorTime());
		map.put(BscCustLevel.CALL_HEAD, model.getCallHead());
		map.put(BscCustLevel.MAX_WAIT_TIME, model.getMaxWaitTime());
		map.put(BscCustLevel.TICKET_TEMPLATE, model.getTicketTemplate());
		map.put(BscCustLevel.IS_START, model.getIsStart());
		map.put(BscCustLevel.EXTEND1, model.getExtend1());
		map.put(BscCustLevel.EXTEND2, model.getExtend2());
		map.put(BscCustLevel.EXTEND3, model.getExtend3());
		try {
			custLevelMapper.callUpdteBscCustLevel(map);
			String obj = (String)map.get("ReturnCode");
			return obj;
		} catch (Exception e) {
			e.printStackTrace();
			return "1"; //执行失败
		}
	}

	@Override
	public String callRemoveBscCustLevelProc(List<Map<String, String>> list) {
		for(int i = 0; i < list.size(); i++){
			Map<String, String> map = list.get(i);
			custLevelMapper.callDeleteBscCustLevel(map);
		}
		return "0";
	}

	@Override
	public List<Map<String, Object>> procBscCustLevelQuery(BscCustLevelQuery model) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put(BscCustLevel.ORG_ID, StringUtils4Aoto.trim(model.getOrgId()));
		map.put(BscCustLevel.DEVICE_NO, StringUtils4Aoto.trim(model.getDeviceNo()));
		List<Map<String, Object>> list = custLevelMapper.callBscCustLevelQuery(map);
		list = (List<Map<String, Object>>) map.get("pageDatas");
		return list;
	}

	@Override
	public String callSaveBscCustLevelProc(BscCustLevelModel model) {
		BscCustLevelQuery query = new BscCustLevelQuery();
		query.setOrgId(model.getOrgId());
		query.setDeviceNo(model.getDeviceNo());
		List<Map<String, Object>> queryList = procBscCustLevelQuery(query);
		if(queryList.size() == 0){
			return "2";//配置未保存
		}
		List<Map<String, Object>> list = bscWinConfigService.createOrgIdDeviceNo(model.getOrgDevicelist());
		for(int i=0; i<list.size(); i++){
			Map<String, Object> map = list.get(i);
			map.put(BscCustLevel.ORG_ID, model.getOrgId());
			map.put(BscCustLevel.DEVICE_NO, model.getDeviceNo());
			custLevelMapper.callCopyBscCustLevel(map);
		}
		return "0";
	}

	@Override
	public List<Map<String, Object>> procCustLevelsQuery(BscBranchBusinessQuery model) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put(BscBranchBusiness.ORG_ID, StringUtils4Aoto.trim(model.getOrgId()));
		map.put(BscBranchBusiness.DEVICE_NO, StringUtils4Aoto.trim(model.getDeviceNo()));
		List<Map<String, Object>> list = custLevelMapper.callCustLevels(map);
		list = (List<Map<String, Object>>) map.get("pageDatas");
		return list;
	}

	@Override
	public void createCustLevels(BscBranchBusinessQuery model,String path) {
		//String path = "iqms-web\\download";
		List<Map<String, Object>> list = procCustLevelsQuery(model);
		if(list.size() == 0){
			return;
		}
		Map<String, Object> custLevelsMap = new HashMap<String, Object>(); 
		if(list.get(0).get("levelName")==null){
			return;
		}
		for(int i = 0; i<list.size(); i++){
			if(list.get(i).get("enabled").equals("1")){
				list.get(i).put("enabled", true);
			}else{
				list.get(i).put("enabled", false);
			}
			if(list.get(i).get("tktTmpId")==null){
				list.get(i).put("tktTmpId", "");
			}
		}
		custLevelsMap.put("custLevels", list);
		try {
			String json = JsonUtils.obj2json(custLevelsMap);
			FileUtils.outPutFiles(json, path+File.separator+"temp",path+File.separator+"temp"+File.separator+"custLevels.json");
			//存放历史文件路径
			String path2 = path+File.separator+model.getOrgId()+"_"+model.getDeviceNo();
			FileUtils.outPutFiles(json, path2,path2+File.separator+"custLevels_"+DateUtil.getNow()+".json");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public List<Map<String, Object>> checkedCustLevel(BscCustLevelModel model){
		Map<String, Object> map = new HashMap<String, Object>();
		map.put(BscBranchBusiness.DEVICE_NO, StringUtils4Aoto.trim(model.getDeviceNo()));
		List<Map<String, Object>> list = custLevelMapper.checkedCustLevel(map);
		return list;
	}

}
