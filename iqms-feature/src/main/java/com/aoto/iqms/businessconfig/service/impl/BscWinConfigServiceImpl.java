package com.aoto.iqms.businessconfig.service.impl;

import java.io.File;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.aoto.framework.commons.lang.StringUtils4Aoto;
import com.aoto.framework.commons.pagination.PagingCriteria;
import com.aoto.iqms.businessconfig.commons.constant.BusinessconfigBeanProperty.BscBranchBusiness;
import com.aoto.iqms.businessconfig.commons.constant.BusinessconfigBeanProperty.BscCustRegconition;
import com.aoto.iqms.businessconfig.commons.constant.BusinessconfigBeanProperty.BscDevice;
import com.aoto.iqms.businessconfig.commons.constant.BusinessconfigBeanProperty.BscWinConfig;
import com.aoto.iqms.businessconfig.models.BscBranchBusinessQuery;
import com.aoto.iqms.businessconfig.models.BscWinConfigModel;
import com.aoto.iqms.businessconfig.models.BscWinConfigQuery;
import com.aoto.iqms.businessconfig.persistence.inf.BscWinConfigMapper;
import com.aoto.iqms.businessconfig.service.inf.BscWinConfigService;
import com.aoto.iqms.util.DateUtil;
import com.aoto.iqms.util.FileUtils;
import com.aoto.iqms.util.JsonUtils;
import com.aoto.iqms.util.ProcPageFill;

/**
 * 窗口配置 service实现
 * @author zhousj
 *
 */
@Service
@Transactional
public class BscWinConfigServiceImpl implements BscWinConfigService{
	@Autowired
	public BscWinConfigMapper bscWinConfigMapper;
	
	/**
	 * 调用存储过程分页
	 */
	@Override
	public List<Map<String, Object>> procPageBscWinConfig(PagingCriteria pagingCriteria, BscWinConfigQuery model) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put(BscWinConfig.ORG_ID, StringUtils4Aoto.trim(model.getOrgId()));
		map.put(BscWinConfig.DEVICE_NO, StringUtils4Aoto.trim(model.getDeviceNo()));
		ProcPageFill.fillProcData(model, map,BscWinConfig.class);
		List<Map<String, Object>> list = bscWinConfigMapper.callPageBscWinConfig(map);
		
		int total = ((BigDecimal)map.get("totalrows")).intValue();
        pagingCriteria.setTotal(total);
        list = (List<Map<String, Object>>) map.get("pageDatas");
		return list;
	}
	
	/**
	 * 调用存储过程 应用下级机构
	 */
	@Override
	public String callCreateBscWinConfigProc(BscWinConfigModel model) {
		BscWinConfigQuery query = new BscWinConfigQuery();
		query.setOrgId(model.getOrgId());
		query.setDeviceNo(model.getDeviceNo());
		List<Map<String, Object>> queryList = procBscWinConfigQuery(query);
		if(queryList.size() == 0){
			return "2";//配置未保存
		}
		List<Map<String, Object>> list = createOrgIdDeviceNo(model.getOrgDevicelist());
		for(int i=0; i<list.size(); i++){
			Map<String, Object> map = list.get(i);
			map.put(BscWinConfig.ORG_ID, model.getOrgId());
			map.put(BscWinConfig.DEVICE_NO, model.getDeviceNo());
			bscWinConfigMapper.callCopyBscWinConfig(map);
		}
		return "0";
	}
	
	/**
	 * 调用存储过程更新数据
	 */
	@Override
	public String callUpdateBscWinConfigProc(BscWinConfigModel model) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put(BscDevice.ORG_ID, StringUtils4Aoto.trim(model.getOrgId()));
		map.put(BscDevice.DEVICE_NO, model.getDeviceNo());
		map.put(BscWinConfig.WIN_NO, model.getWinNo());
		map.put(BscWinConfig.IS_CALL, model.getIsCall());
		map.put(BscWinConfig.IS_JUDGE, model.getIsJudge());
		map.put(BscWinConfig.IS_START, model.getIsStart());
		map.put(BscWinConfig.WIN_SCREEN, model.getWinScreen());
		map.put(BscWinConfig.MULTIPLE_SCREEN, model.getMultipleScreen());
		map.put(BscWinConfig.EXTEND1, model.getExtend1());
		map.put(BscWinConfig.EXTEND2, model.getExtend2());
		map.put(BscWinConfig.EXTEND3, model.getExtend3());
		try {
			bscWinConfigMapper.callUpdteBscWinConfig(map);
			//获取存储过程的输出参数
			String obj = (String)map.get("ReturnCode");
			return obj;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			return "1"; //执行失败
		}
	}
	

	/**
     * 用于解析‘机构和设备的组织树’生成包含orgId和deviceNo的map的公共方法
     * @param orgDevicelist
     * @return
     */
	@Override
	public List<Map<String, Object>> createOrgIdDeviceNo(String orgDevicelist) {
		String[] devices = orgDevicelist.split(";");
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		for(int i=0; i<devices.length; i++){
			String[] strs = devices[i].split(",");
			if(strs[1].startsWith("D")){
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("targetId", StringUtils4Aoto.trim(strs[2]));
				map.put("targetNo", strs[1].substring(1, strs[1].length()));
				list.add(map);
			}
		}
		return list;
	}
	
	@Override
	public List<Map<String, Object>> procBscWinConfigQuery(BscWinConfigQuery model) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put(BscWinConfig.ORG_ID, StringUtils4Aoto.trim(model.getOrgId()));
		map.put(BscWinConfig.DEVICE_NO, StringUtils4Aoto.trim(model.getDeviceNo()));
		List<Map<String, Object>> list = bscWinConfigMapper.callBscWinConfigQuery(map);
		list = (List<Map<String, Object>>) map.get("pageDatas");
		return list;
	}
	
	/**
	 * 调用存储过程保存包含 增删改
	 */
	@Override
	public String procSaveWinConfig(List<BscWinConfigModel> list) {
		String result = "";
//		if(list.get(0).getSaveStatus().equals("deleted")){
//			callRemoveBscWinConfigProc(list.get(0));
//		}
		for(int i=0; i<list.size(); i++){
			if(list.get(i).getSaveStatus().equals("inserted")){
				Map<String, Object> map = new HashMap<String, Object>();
				map.put(BscWinConfig.ORG_ID, StringUtils4Aoto.trim(list.get(i).getOrgId()));
				map.put(BscWinConfig.DEVICE_NO, StringUtils4Aoto.trim(list.get(i).getDeviceNo()));
				map.put(BscWinConfig.ROW_ID, StringUtils4Aoto.trim(list.get(i).getRowId()));
				map.put(BscWinConfig.WIN_NO, list.get(i).getWinNo());
				map.put(BscWinConfig.IS_CALL, list.get(i).getIsCall());
				map.put(BscWinConfig.IS_JUDGE, list.get(i).getIsJudge());
				map.put(BscWinConfig.IS_START, list.get(i).getIsStart());
				map.put(BscWinConfig.WIN_SCREEN, list.get(i).getWinScreen());
				map.put(BscWinConfig.MULTIPLE_SCREEN, list.get(i).getMultipleScreen());
				map.put(BscWinConfig.EXTEND1, list.get(i).getExtend1());
				map.put(BscWinConfig.EXTEND2, list.get(i).getExtend2());
				map.put(BscWinConfig.EXTEND3, list.get(i).getExtend3());
				try {
					bscWinConfigMapper.callInsertBscWinConfig(map);
					result = (String) map.get("ReturnCode");
				} catch (Exception e) {
					// TODO: handle exception
					e.printStackTrace();
					result = "1";//失败
				}
			}else if(list.get(i).getSaveStatus().equals("deleted")){
				callRemoveBscWinConfigProc(list.get(i));
			}
		}
		return result;
	}

	@Override
	public String callRemoveBscWinConfigProc(BscWinConfigModel model) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put(BscCustRegconition.ORG_ID, StringUtils4Aoto.trim(model.getOrgId()));
		map.put(BscCustRegconition.DEVICE_NO, StringUtils4Aoto.trim(model.getDeviceNo()));
		map.put(BscCustRegconition.WIN_NO, StringUtils4Aoto.trim(model.getWinNo()));
		bscWinConfigMapper.callDeleteBscWinConfig(map);
		return "0";
	}

	@Override
	public void createCounters(BscBranchBusinessQuery model,String path) {
		List<Map<String, Object>> list = procCountersQuery(model);
		if(list.size() == 0){
			return;
		}
		List<Map<String, Object>> countersList = new ArrayList<Map<String, Object>>();
		for(int i=0; i<list.size(); i++){
			Map<String, Object> countersMap = new HashMap<String, Object>(); 
			Map<String, Object> peripheralMap = new HashMap<String, Object>(); 
			countersMap.put("counterId", list.get(i).get("counterId"));
			countersMap.put("saveStatus", list.get(i).get("saveStatus"));
			countersMap.put("counterNo", list.get(i).get("counterNo"));
			countersMap.put("enabled", list.get(i).get("enabled").equals("0")?false:true);
			if(list.get(i).get("enabled").equals("0")){
				peripheralMap.put("caller", "");
				peripheralMap.put("evaluator", "");
			}else{
				peripheralMap.put("caller", list.get(i).get("caller"));
				peripheralMap.put("evaluator", list.get(i).get("evaluator"));
			}
			peripheralMap.put("barscn", list.get(i).get("barscn"));
			peripheralMap.put("cmpscn", list.get(i).get("cmpscn"));
			countersMap.put("peripheral", peripheralMap);
			countersList.add(countersMap);
		}
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("counters", countersList);
		try {
			String json = JsonUtils.obj2json(map);
			FileUtils.outPutFiles(json, path+File.separator+"temp",path+File.separator+"temp"+File.separator+"counters.json");
			//存放历史文件路径
			String path2 = path+File.separator+model.getOrgId()+"_"+model.getDeviceNo();
			FileUtils.outPutFiles(json, path2,path2+File.separator+"counters_"+DateUtil.getNow()+".json");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@Override
	public List<Map<String, Object>> procCountersQuery(BscBranchBusinessQuery model) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put(BscBranchBusiness.ORG_ID, StringUtils4Aoto.trim(model.getOrgId()));
		map.put(BscBranchBusiness.DEVICE_NO, StringUtils4Aoto.trim(model.getDeviceNo()));
		List<Map<String, Object>> list = bscWinConfigMapper.callCounters(map);
		list = (List<Map<String, Object>>) map.get("pageDatas");
		return list;
	}
	
	 public List<Map<String, Object>> checkedWinInfo(BscWinConfigModel model){
		Map<String, Object> map = new HashMap<String, Object>();
		map.put(BscBranchBusiness.DEVICE_NO, StringUtils4Aoto.trim(model.getDeviceNo()));
		List<Map<String, Object>> list = bscWinConfigMapper.checkedWinInfo(map);
		return list;
	 }
	
}
