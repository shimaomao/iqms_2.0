package com.aoto.iqms.basicconfig.service.impl;

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
import com.aoto.iqms.basicconfig.commons.constant.BasicconfigBeanProperty.Teller;
import com.aoto.iqms.basicconfig.models.TellerModel;
import com.aoto.iqms.basicconfig.models.TellerQuery;
import com.aoto.iqms.basicconfig.persistence.inf.TellerMapper;
import com.aoto.iqms.basicconfig.service.inf.TellerService;
import com.aoto.iqms.businessconfig.commons.constant.BusinessconfigBeanProperty.BscBranchBusiness;
import com.aoto.iqms.businessconfig.models.BscBranchBusinessQuery;
import com.aoto.iqms.util.DateUtil;
import com.aoto.iqms.util.FileUtils;
import com.aoto.iqms.util.JsonUtils;
import com.aoto.iqms.util.ProcPageFill;

/**
 * 柜员管理实现
 * @author zhousj
 *
 */
@Service
@Transactional
public class TellerServiceImpl implements TellerService{
    @Autowired
    public TellerMapper tellerMapper;
    
    /**
     * 调用存储过程分页
     */
	@Override
	public List<Map<String, Object>> procPageTeller(PagingCriteria pagingCriteria, TellerQuery model) {
	    Map<String, Object> map = new HashMap<String, Object>();
	    map.put(Teller.ORG_ID, StringUtils4Aoto.trim(model.getOrgId()));
	    map.put(Teller.NAME_, StringUtils4Aoto.trim(model.getName_()));
	    
	    //填充分页和排序信息
	    ProcPageFill.fillProcData(model, map, Teller.class);
	    //执行存储过程
	    List<Map<String, Object>> list = tellerMapper.callPageTeller(map);
	    //获取存储过程的返回值
	    int total = ((BigDecimal)map.get("totalrows")).intValue();
	    pagingCriteria.setTotal(total);
	    
	    list = (List<Map<String, Object>>) map.get("pageDatas");
		return list;
	}
	
	/**
	 * 调用存储过程新增柜员信息
	 */
	@Override
	public String callCreateTellerProc(TellerModel model) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put(Teller.WORK_ID, model.getWorkId());
		map.put(Teller.ORG_ID, model.getOrgId());
		map.put(Teller.CALLER_PWD, model.getCallerPwd());
		map.put(Teller.NAME_, model.getName_());
		map.put(Teller.SEX, model.getSex());
		map.put(Teller.STATUS, model.getStatus());
		
		try {
			tellerMapper.callInsertTeller(map);
			String obj = (String) map.get("ReturnCode");
			return obj;
		} catch (Exception e) {
		    e.printStackTrace();
		    return "1";//执行失败
		}
	}
	
	/**
	 * 更新操作
	 */
	@Override
	public String callUpdateTellerProc(TellerModel model) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put(Teller.WORK_ID, model.getWorkId());
		map.put(Teller.ORG_ID, model.getOrgId());
		map.put(Teller.CALLER_PWD, model.getCallerPwd());
		map.put(Teller.NAME_, model.getName_());
		map.put(Teller.SEX, model.getSex());
		map.put(Teller.STATUS, model.getStatus());
		try {
			tellerMapper.callUpdteTeller(map);
			String obj = (String) map.get("ReturnCode");
			return obj;
		} catch (Exception e) {
			e.printStackTrace();
		    return "1";//执行失败
		}
	}
	
	/**
	 * 删除柜员
	 */
	@Override
	public String callRemoveTellerProc(List<String> list) {
		Map<String, Object> map = new HashMap<String, Object>();
		for(int i=0; i<list.size(); i++){
			map.put(Teller.WORK_ID, list.get(i));
			tellerMapper.callDeleteTeller(map);
		}
		return "0";
	}

	@Override
	public List<Map<String, Object>> procTellersQuery(BscBranchBusinessQuery model) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put(BscBranchBusiness.ORG_ID, StringUtils4Aoto.trim(model.getOrgId()));
		List<Map<String, Object>> list = tellerMapper.callTellers(map);
		list = (List<Map<String, Object>>) map.get("pageDatas");
		return list;
	}

	@Override
	public void createTellers(BscBranchBusinessQuery model,String path) {
		//String path = "iqms-web\\download";
		List<Map<String, Object>> list = procTellersQuery(model);
		if(list.size() == 0){
			return;
		}
		for(int i = 0; i < list.size(); i++){
			if(list.get(i).get("gender")==null || list.get(i).get("gender").equals("")){
				list.get(i).put("gender", "1");
			}
			list.get(i).put("starLevel", "1");
			list.get(i).put("left", false);
		}
		Map<String, Object> tellersMap = new HashMap<String, Object>();
		tellersMap.put("tellers", list);
		try {
			String json = JsonUtils.obj2json(tellersMap);
			FileUtils.outPutFiles(json, path+File.separator+"temp",path+File.separator+"temp"+File.separator+"tellers.json");
			//存放历史文件路径
			String path2 = path+File.separator+model.getOrgId()+"_"+model.getDeviceNo();
			FileUtils.outPutFiles(json, path2,path2+File.separator+"tellers_"+DateUtil.getNow()+".json");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@Override
	public List<Map<String, Object>> findTellerByWorkId(String workId) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put(Teller.WORK_ID, workId);
		List<Map<String, Object>> list = tellerMapper.findTellerByWorkId(map);
		return list;
	}

}
