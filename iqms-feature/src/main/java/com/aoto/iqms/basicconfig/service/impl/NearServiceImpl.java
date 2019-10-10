package com.aoto.iqms.basicconfig.service.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.apache.commons.lang.time.DateFormatUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.aoto.framework.commons.lang.StringUtils4Aoto;
import com.aoto.iqms.basicconfig.commons.constant.BasicconfigBeanProperty.Near;
import com.aoto.iqms.basicconfig.models.NearModel;
import com.aoto.iqms.basicconfig.persistence.inf.NearMapper;
import com.aoto.iqms.basicconfig.service.inf.NearService;
import com.aoto.iqms.monitor.persistence.inf.TrxTodayMapper;
import com.aoto.iqms.util.JsonUtils;

/**
 * 临近网点管理service实现
 * @author zhousj
 *
 */
@Service
@Transactional
public class NearServiceImpl implements NearService{
    @Autowired
    private NearMapper nearMapper;
    
    /**
     * 调用存储过程查询
     */
	@Override
	public List<Map<String, Object>> callNear(String orgId) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put(Near.ORG_ID, StringUtils4Aoto.trim(orgId));
		
		List<Map<String, Object>> list = nearMapper.callNear(map);
		list = (List<Map<String, Object>>) map.get("pageDatas");
		
		return list;
	}
	
	/**
	 *调用存储过程更新或插入 
	 */
	@Override
	public String callSaveOrUpdateNear(NearModel model) {
		//判断是否有重复
		Map<String, Object> map = new HashMap<String, Object>();
		map.put(Near.ORG_ID, model.getOrgId());
		map.put(Near.ORG_ID1, model.getOrgId1());
		map.put(Near.ORG_ID2, model.getOrgId2());
		map.put(Near.ORG_ID3, model.getOrgId3());
		map.put(Near.ORG_ID4, model.getOrgId4());
		map.put(Near.ORG_ID5, model.getOrgId5());
		map.put(Near.ORG_ID6, model.getOrgId6());
		
		List<String> repeatOrg  = new ArrayList<>();
		
		
		boolean isRepeat = false;  //无重复
		
		//记录null 和 空值有多少
		for (String key : map.keySet()) {
			
			String orgIdTemp = map.get(key) == null ? "" : map.get(key).toString();
			
			if (StringUtils4Aoto.isBlank(orgIdTemp)) {
				continue;
			}
			
			//list是否有此值
			if(repeatOrg.contains(orgIdTemp)){
				isRepeat = true;
				break;
			} 
			repeatOrg.add(orgIdTemp);
		}
		if(isRepeat){
			return "2";//存在重复的临近网点
		}
		
		try {
			nearMapper.callSaveOrUpdateNear(map);
			String returnCode = (String) map.get("ReturnCode"); 
			return returnCode;
		} catch (Exception e) {
		    return "1";//执行失败
		}
	}

	@Override
	public List<Map<String, Object>> callOrg() {
		Map<String, Object> map = new HashMap<String, Object>();
		List<Map<String, Object>> list = nearMapper.callOrg(map);
		list = (List<Map<String, Object>>) map.get("pageDatas");
		return list;
	}
	
	/**
	 * 调用存储过程清空某一列
	 */
	@Override
	public String callRemoveNear(String orgId) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put(Near.ORG_ID, StringUtils4Aoto.trim(orgId.replace("\"", "")));
		try {
			nearMapper.callRemoveNear(map);
			return "0";
		} catch (Exception e) {
			e.printStackTrace();
			return "1";//执行失败
		}
	}

	@Override
	public String createNearsJson(String orgId, String transCode) {
		Map<String, Object> nearMap = new HashMap<String, Object>();
		nearMap.put(Near.ORG_ID, StringUtils4Aoto.trim(orgId));
		
		List<Map<String, Object>> nearList = nearMapper.callNear(nearMap);
		nearList = (List<Map<String, Object>>) nearMap.get("pageDatas");
		List<Map<String, Object>> nears = new ArrayList<Map<String, Object>>();
		if(nearList.size()!=0){
			for(int i = 1; i < 5; i++){
				Map<String, Object> map = new HashMap<String, Object>();
				if(nearList.get(0).get("ORG_ID"+i)!=null){
					map.put(Near.ORG_ID, nearList.get(0).get("ORG_ID"+i));
					
					List<Map<String, Object>> list = nearMapper.callNearsQuery(map);
					list = (List<Map<String, Object>>) map.get("pageDatas");
					if(list.size()>0){
						for(int j = 0; j < list.size(); j++){
							Map<String, Object> map1 = new HashMap<String, Object>();
							map1.put("transNet", nearList.get(0).get("ORG_ID"+i));
							map1.put("orgName", list.get(j).get("orgName"));
							map1.put("total", list.get(j).get("totalGetNums"));
							map1.put("totalWait", list.get(j).get("totalWait"));
							map1.put("totalFinished", list.get(j).get("totalFinished"));
							map1.put("totalDeal", list.get(j).get("totalDeal"));
							nears.add(map1);
						}
					}
				}
			}
		}
		Map<String, Object> map2 = new HashMap<String, Object>();
		Map<String, Object> headMap = new HashMap<String, Object>();
		headMap.put("transCode", transCode);
		headMap.put("transDateTime", DateFormatUtils.format(new Date(), "yyyy-MM-dd HH:mm:ss"));
		String json = "";
		if(nears.size()>0){
			headMap.put("transStatus", "0000");
			headMap.put("transDescription", "成功");
		}else{
			headMap.put("transStatus", "9999");
			headMap.put("transDescription", "未获取到临时网点流水");
		}
		map2.put("head", headMap);
		map2.put("data", nears);
		try {
		    json = JsonUtils.obj2json(map2);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return json;
	}
    
}
