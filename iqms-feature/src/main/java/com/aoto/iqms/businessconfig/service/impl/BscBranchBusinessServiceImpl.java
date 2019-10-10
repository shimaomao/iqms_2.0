package com.aoto.iqms.businessconfig.service.impl;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.context.WebApplicationContext;

import com.aoto.framework.commons.lang.StringUtils4Aoto;
import com.aoto.iqms.businessconfig.commons.constant.BusinessconfigBeanProperty.BscBranchBusiness;
import com.aoto.iqms.businessconfig.commons.constant.BusinessconfigBeanProperty.BscWinConfig;
import com.aoto.iqms.businessconfig.models.BscBranchBusinessModel;
import com.aoto.iqms.businessconfig.models.BscBranchBusinessQuery;
import com.aoto.iqms.businessconfig.persistence.inf.BscBranchBusinessMapper;
import com.aoto.iqms.businessconfig.service.inf.BscBranchBusinessService;
import com.aoto.iqms.businessconfig.service.inf.BscShowTimeService;
import com.aoto.iqms.businessconfig.service.inf.BscWinConfigService;
import com.aoto.iqms.externals.thirdcommunication.SocketRequest;
import com.aoto.iqms.util.DateUtil;
import com.aoto.iqms.util.FileUtils;
import com.aoto.iqms.util.JsonUtils;
import com.aoto.iqms.util.SpringContextUtil;
import com.fasterxml.jackson.databind.JsonNode;


/**
 * 网点业务接口实现
 * @author zhousj
 *
 */
@Service
@Transactional
public class BscBranchBusinessServiceImpl implements BscBranchBusinessService{
	
	private static final Logger logger = LoggerFactory
			.getLogger(BscBranchBusinessServiceImpl.class);
	
	@Autowired
	private BscBranchBusinessMapper branchBusinessMapper;
	@Autowired
	private BscWinConfigService bscWinConfigService;
	@Autowired
	private BscShowTimeService showTimeService;

	
	
	@Override
	public List<Map<String, Object>> ztreeMenuBusiness() {
		Map<String, Object> map = new HashMap<String, Object>();
		List<Map<String, Object>> list = branchBusinessMapper.callTreeMenuBusiness(map);
		list = (List<Map<String, Object>>)map.get("pageDatas");
		
		return list;
	}

	@Override
	public List<Map<String, Object>> procBrancBusiness(BscBranchBusinessQuery model) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put(BscBranchBusiness.ORG_ID, StringUtils4Aoto.trim(model.getOrgId()));
		map.put(BscBranchBusiness.DEVICE_NO, StringUtils4Aoto.trim(model.getDeviceNo()));
		map.put(BscBranchBusiness.TREE_ID, StringUtils4Aoto.trim(model.getTreeId()));
		List<Map<String, Object>> list = branchBusinessMapper.callBranchBusiness(map);
		list = (List<Map<String, Object>>) map.get("pageDatas");
		return list;
	}

	@Override
	public List<Map<String, Object>> procBrancBusinessTree(BscBranchBusinessQuery model) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put(BscBranchBusiness.ORG_ID, StringUtils4Aoto.trim(model.getOrgId()));
		map.put(BscBranchBusiness.DEVICE_NO, StringUtils4Aoto.trim(model.getDeviceNo()));
		map.put(BscBranchBusiness.TREE_ID, model.getTreeId());
		List<Map<String, Object>> list = branchBusinessMapper.callBranchBusiness(map);
		list = (List<Map<String, Object>>) map.get("pageDatas");
//		//去重
//		List<Map<String, Object>> treeList = new ArrayList<>();
//		Set set = new HashSet<>();
//		for (Map<String, Object> treeMap : tmpList) {
//			if(set.add(treeMap)){
//				treeList.add(treeMap);
//			}
//		}
		return list;
	}

	@Override
	public String callCreateBscBranchBusProc(BscBranchBusinessModel model) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put(BscBranchBusiness.ORG_ID, StringUtils4Aoto.trim(model.getOrgId()));
		map.put(BscBranchBusiness.DEVICE_NO, model.getDeviceNo());
		map.put(BscBranchBusiness.TREE_PID, model.getTreePid());
		map.put(BscBranchBusiness.TREE_ID, model.getTreeId());
		map.put(BscBranchBusiness.BUSINESS_EN_NAME, model.getBusinessEnName());
		map.put(BscBranchBusiness.BUSINESS_TYPE, model.getBusinessType());
		map.put(BscBranchBusiness.BUSINESS_CODE, model.getBusinessCode());
		map.put(BscBranchBusiness.CALL_HEAD, model.getCallHead());
		map.put(BscBranchBusiness.PRIOR_TIME, model.getPriorTime());
		map.put(BscBranchBusiness.IS_SWIPE, model.getIsSwipe());
		map.put(BscBranchBusiness.IS_SHOW_EN, model.getIsShowEn());
		map.put(BscBranchBusiness.PICK_UP_ADVICE, model.getPickUpAdvice());
		map.put(BscBranchBusiness.MAX_PICK_UP, model.getMaxPickUp());
		map.put(BscBranchBusiness.SORT_NUM, model.getSortNum());
		map.put(BscBranchBusiness.EXTEND1, model.getExtend1());
		map.put(BscBranchBusiness.EXTEND2, model.getExtend2());
		map.put(BscBranchBusiness.EXTEND3, model.getExtend3());
		map.put(BscBranchBusiness.BUS_ID, model.getTreeId());
		map.put(BscBranchBusiness.LEVELNUM, model.getLevelNum());
		//调用持久化方法
		try {
//			List<Map<String, Object>> list = procLevelQuery(model);
//			if(list.get(0) == null && model.getTreePid().equals("0")){
//				map.put(BscBranchBusiness.LEVELNUM, );
//			}else if(list.get(0) == null && !model.getTreePid().equals("0")){
//				map.put(BscBranchBusiness.LEVELNUM, 2);
//			}else{
//			}
			branchBusinessMapper.callInsertBscBranchBus(map);
			//获取存储过程的输出参数
			String obj = (String)map.get("ReturnCode");
			return obj;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			return "1"; //执行失败
		}
	}

	@Override
	public String callUpdateBscBranchBusProc(BscBranchBusinessModel model) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put(BscBranchBusiness.ORG_ID, StringUtils4Aoto.trim(model.getOrgId()));
		map.put(BscBranchBusiness.DEVICE_NO, model.getDeviceNo());
		map.put(BscBranchBusiness.TREE_PID, model.getTreePid());
		map.put(BscBranchBusiness.TREE_ID, model.getTreeId());
		map.put(BscBranchBusiness.BUSINESS_EN_NAME, model.getBusinessEnName());
		map.put(BscBranchBusiness.BUSINESS_CODE, model.getBusinessCode());
		map.put(BscBranchBusiness.CALL_HEAD, model.getCallHead());
		map.put(BscBranchBusiness.PRIOR_TIME, model.getPriorTime());
		map.put(BscBranchBusiness.IS_SWIPE, model.getIsSwipe());
		map.put(BscBranchBusiness.IS_SHOW_EN, model.getIsShowEn());
		map.put(BscBranchBusiness.PICK_UP_ADVICE, model.getPickUpAdvice());
		map.put(BscBranchBusiness.MAX_PICK_UP, model.getMaxPickUp());
		map.put(BscBranchBusiness.SORT_NUM, model.getSortNum());
		map.put(BscBranchBusiness.EXTEND1, model.getExtend1());
		map.put(BscBranchBusiness.EXTEND2, model.getExtend2());
		map.put(BscBranchBusiness.EXTEND3, model.getExtend3());
		//调用持久化方法
		try {
			branchBusinessMapper.callUpdteBscBranchBus(map);
			//获取存储过程的输出参数
			String obj = (String)map.get("ReturnCode");
			return obj;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			return "1"; //执行失败
		}
	}

	@Override
	public String callRemoveBscBranchBusProc(String orgId, String deviceNo, String treeId) {
		Map<String, String> map = new HashMap<String, String>();
		map.put(BscBranchBusiness.ORG_ID, StringUtils4Aoto.trim(orgId));
		map.put(BscBranchBusiness.DEVICE_NO, StringUtils4Aoto.trim(deviceNo));
		map.put(BscBranchBusiness.TREE_ID, StringUtils4Aoto.trim(treeId));
		branchBusinessMapper.callDeleteBscBranchBus(map);
		return "0";
	}

	@Override
	public String callCopyBscBranchBus(BscBranchBusinessModel model) {
		BscBranchBusinessQuery query = new BscBranchBusinessQuery();
		query.setOrgId(model.getOrgId());
		query.setDeviceNo(model.getDeviceNo());
		query.setTreeId("-1");
		List<Map<String, Object>> queryList = procBrancBusinessTree(query);
		if(queryList.size() == 0){
			return "2";//配置未保存
		}
		List<Map<String, Object>> list = bscWinConfigService.createOrgIdDeviceNo(model.getOrgDevicelist());
		for(int i=0; i<list.size(); i++){
			Map<String, Object> map = list.get(i);
			map.put(BscWinConfig.ORG_ID, model.getOrgId());
			map.put(BscWinConfig.DEVICE_NO, model.getDeviceNo());
			branchBusinessMapper.callCopyBscBranchBus(map);
		}
		return "0";
	}

	@Override
	public List<Map<String, Object>> procBuzTypeQuery(BscBranchBusinessQuery model) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put(BscBranchBusiness.ORG_ID, StringUtils4Aoto.trim(model.getOrgId()));
		map.put(BscBranchBusiness.DEVICE_NO, StringUtils4Aoto.trim(model.getDeviceNo()));
		List<Map<String, Object>> list = branchBusinessMapper.callBuzType(map);
		list = (List<Map<String, Object>>) map.get("pageDatas");
		return list;
	}

	@Override
	public String createBuzList(BscBranchBusinessQuery model) {
		
		ServletContext servletContext = ((WebApplicationContext)SpringContextUtil.getApplicationContext()).getServletContext();
        //by hongxz 20171018 获取实际下载路径
		
		String path = servletContext.getRealPath(File.separator+"download");
		logger.error("配置更新下载绝对路径是："+path);
		//String path = "iqms-web\\download";
		List<Map<String, Object>> buzTypeList = procBuzTypeQuery(model);
		if(buzTypeList.size() == 0){
			return path;
		}
		List<Map<String, Object>> buzTimesList = showTimeService.procBuzTimesQuery(model);
		List<Map<String, Object>> buzList = new ArrayList<Map<String, Object>>();
		List<Map<String, Object>> timesList = new ArrayList<Map<String, Object>>();
		for(int i=0; i<buzTypeList.size(); i++){
			if(buzTypeList.get(i).get("levelNum")==null || buzTypeList.get(i).get("levelNum").equals("")){
				buzTypeList.get(i).put("levelNum", "0");
			}
			if(buzTypeList.get(i).get("enShowed")==null){
				buzTypeList.get(i).put("enShowed", false);
			}
			else if(buzTypeList.get(i).get("enShowed").equals("0")){
				buzTypeList.get(i).put("enShowed", true);
			}else{
				buzTypeList.get(i).put("enShowed", false);
			}
			
			if(buzTypeList.get(i).get("swiped")==null){
				buzTypeList.get(i).put("swiped", false);
			}
			else if(buzTypeList.get(i).get("swiped").equals("0")){
				buzTypeList.get(i).put("swiped", true);
			}else{
				buzTypeList.get(i).put("swiped", false);
			}
			if(buzTypeList.get(i).get("priorityTime")==null){
				buzTypeList.get(i).put("priorityTime", "0");
			}
			if(buzTypeList.get(i).get("sortNum")==null){
				buzTypeList.get(i).put("sortNum", "0");
			}
			if(buzTypeList.get(i).get("prefix")==null){
				buzTypeList.get(i).put("prefix", "0");
			}
			buzTypeList.get(i).put("enabled", true);
			Map<String, Object> map = new HashMap<String, Object>(); 
			
			timesList = new ArrayList<Map<String, Object>>();
			for(int j=0; j<buzTimesList.size(); j++){
				if(buzTimesList.get(j).get("busId").toString().equals(buzTypeList.get(i).get("buzTypeId").toString())){
					buzTimesList.get(j).put("saveStatus", "inserted");
					timesList.add(buzTimesList.get(j));
				}
			}
			map.put("buzTimes", timesList);
			map.put("buzType", buzTypeList.get(i));
			buzList.add(map);
		}
		Map<String, Object> map1 = new HashMap<String, Object>();
		map1.put("buzList", buzList);
		try {
			String json = JsonUtils.obj2json(map1);
			//存放历史文件路径
			String path2 = path+File.separator+model.getOrgId()+"_"+model.getDeviceNo();
			FileUtils.outPutFiles(json, path+File.separator+"temp", path+File.separator+"temp"+File.separator+"buzList.json");
			FileUtils.outPutFiles(json, path2,path2+File.separator+"buzList_"+DateUtil.getNow()+".json");
		} catch (Exception e) {
			logger.info("业务配置文件生成异常：",e);
		}
		return path;
	}

	@Override
	public List<Map<String, Object>> procBuzQuery(BscBranchBusinessQuery model) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put(BscBranchBusiness.ORG_ID, StringUtils4Aoto.trim(model.getOrgId()));
		map.put(BscBranchBusiness.DEVICE_NO, StringUtils4Aoto.trim(model.getDeviceNo()));
		List<Map<String, Object>> list = branchBusinessMapper.callBuz(map);
		list = (List<Map<String, Object>>) map.get("pageDatas");
		return list;
	}

	@Override
	public List<Map<String, Object>> procLevelQuery(BscBranchBusinessModel model) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put(BscBranchBusiness.ORG_ID, StringUtils4Aoto.trim(model.getOrgId()));
		map.put(BscBranchBusiness.DEVICE_NO, StringUtils4Aoto.trim(model.getDeviceNo()));
		map.put(BscBranchBusiness.TREE_PID, StringUtils4Aoto.trim(model.getTreePid()));
		List<Map<String, Object>> list = branchBusinessMapper.callLevel(map);
		list = (List<Map<String, Object>>) map.get("pageDatas");
		return list;
	}

	@Override
	public List<Map<String, Object>> procBusiness(BscBranchBusinessModel model) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put(BscBranchBusiness.ORG_ID, StringUtils4Aoto.trim(model.getOrgId()));
		map.put(BscBranchBusiness.DEVICE_NO, StringUtils4Aoto.trim(model.getDeviceNo()));
		List<Map<String, Object>> list = branchBusinessMapper.callBusiness(map);
		list = (List<Map<String, Object>>) map.get("pageDatas");
		return list;
	}

	@Override
	public List<Map<String, Object>> findBusysForHallMarket(String orgCode, String deviceNo) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("orgCode", orgCode);
		map.put("deviceNo", deviceNo);
		List<Map<String, Object>> list = branchBusinessMapper.findBusysForHallMarket(map);
		list = (List<Map<String, Object>>) map.get("pageDatas");
		return list;
	}

}
