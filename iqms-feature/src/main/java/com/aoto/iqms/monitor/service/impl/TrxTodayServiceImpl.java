package com.aoto.iqms.monitor.service.impl;

import java.math.BigDecimal;
import java.text.DecimalFormat;
import java.text.NumberFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.aoto.framework.commons.lang.StringUtils4Aoto;
import com.aoto.framework.commons.pagination.PagingCriteria;
import com.aoto.iqms.monitor.commons.constant.MonitorBeanProperty.TrxToday;
import com.aoto.iqms.monitor.models.TrxTodayQuery;
import com.aoto.iqms.monitor.persistence.inf.TrxTodayMapper;
import com.aoto.iqms.monitor.service.inf.TrxTodayService;
import com.aoto.iqms.util.ProcPageFill;

/**
 * 当日业务数据实现
 * @author zhousj
 *
 */
@Service
@Transactional
public class TrxTodayServiceImpl implements TrxTodayService{
	@Autowired
	private TrxTodayMapper trxTodayMapper;
	/**
	 * 调用存储过程分页
	 */
	@Override
	public List<Map<String, Object>> procPageTrxToday(PagingCriteria pagingCriteria, TrxTodayQuery model) {
		Map<String, Object> map = new HashMap<String, Object>();
	    map.put(TrxToday.ORG_ID, StringUtils4Aoto.trim(model.getOrgId()));
	    //填充分页和排序信息
	    ProcPageFill.fillProcData(model, map, TrxToday.class);
	    //执行存储过程
	    List<Map<String, Object>> list = trxTodayMapper.callPageTrxToday(map);
	    //获取存储过程的返回值
	    int total = ((BigDecimal)map.get("totalrows")).intValue();
	    pagingCriteria.setTotal(total);
	    
	    list = (List<Map<String, Object>>) map.get("pageDatas");
		return list;
	}
	/**
	 * 调用存储过程查询特定数据
	 */
	@Override
	public List<Map<String, Object>> procTrxTodayQuery(String orgId) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put(TrxToday.ORG_ID, StringUtils4Aoto.trim(orgId));
		List<Map<String, Object>> list = trxTodayMapper.callTrxTodayQuery(map);
		list = (List<Map<String, Object>>) map.get("pageDatas");
		return list;
	}
	
	/**
	 * 计算今天和昨天的百分比
	 */
	@Override
	public List<Map<String, Object>> getPercentList(List<Map<String, Object>> listQuery,
			List<Map<String, Object>> listYesQuery) {
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		Map<String, Object> map = new HashMap<String,Object>();
		int total_count = 0;
		int vip_total_count = 0;
		int yes_total_count = 0;
		int yes_vip_total = 0;
		for(int i=0; i<listQuery.size(); i++){
			if(listQuery.get(i).containsKey("total")){
				total_count = Integer.parseInt((String) listQuery.get(i).get("total"));
			}
			if(total_count != 0){
				if(listQuery.get(i).containsKey("vipTotal")){
					if(listQuery.get(i).get("vipTotal") == null){
						vip_total_count = 0;
					}else{
						vip_total_count = Integer.parseInt((String) listQuery.get(i).get("vipTotal"));
					}
				}
			}
		}
		
		if(listYesQuery.size() > 0){
			for(int i=0; i<listYesQuery.size(); i++){
				if(listYesQuery.get(i).containsKey("yesTotal")){
					yes_total_count = Integer.parseInt((String)listYesQuery.get(i).get("yesTotal"));
				}
				if(listYesQuery.get(i).containsKey("yesVipTotal")){
					if(listYesQuery.get(i).get("yesVipTotal") == null){
						yes_vip_total = 0;
					}else{
						yes_vip_total = Integer.parseInt((String)listYesQuery.get(i).get("yesVipTotal"));
					}
				}
			}
		}
		//提升或下降标志
		String totalFlag = "up";
		String vipTotalFlag = "up";
		if(total_count<yes_total_count){
			totalFlag = "down";
		}
		if(vip_total_count<yes_vip_total){
			vipTotalFlag = "down";
		}
		String totalPercent = "";
		String vipPercent = "";
		//总取号和vip总取号 同昨天的百分比
		NumberFormat nt = NumberFormat.getPercentInstance();
		nt.setMinimumFractionDigits(0);
		if(yes_total_count!=0){
			double total = (double)total_count/yes_total_count-1;
			totalPercent = nt.format(total).replaceAll("-", "");
		}else{
			totalPercent = "0";
		}
		if(yes_vip_total!=0){
			double vipTotal = (double)vip_total_count/yes_vip_total-1;
		    vipPercent = nt.format(vipTotal).replaceAll("-", "");
		}else{
			vipPercent = "0";
		}
		map.put("totalPercent", totalPercent);
		map.put("vipPercent", vipPercent);
		map.put("totalFlag", totalFlag);
		map.put("vipTotalFlag", vipTotalFlag);
		list.add(map);
		return list;
	}
	/**
	 * 计算当天不同业务的百分比
	 */
	@Override
	public List<Map<String, Object>> procTrxTodayBus(String orgId) {
		Map<String, Object> mapBus = new HashMap<String, Object>();
		mapBus.put(TrxToday.ORG_ID, StringUtils4Aoto.trim(orgId));
		List<Map<String, Object>> listBus = trxTodayMapper.callTrxTodayBus(mapBus);
		listBus = (List<Map<String, Object>>) mapBus.get("pageDatas");
		
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		
		int total = 0;
		int count = 0;
		int other = 0;
		for(int i=0; i<listBus.size(); i++){
			if(i >= 5){//只设置6个颜色，第6个代表剩下所有
				other += Integer.parseInt((String)listBus.get(i).get("busCount"));
			}
			total += Integer.parseInt((String)listBus.get(i).get("busCount"));
		}
//		NumberFormat nt = NumberFormat.getPercentInstance();
//		nt.setMaximumIntegerDigits(2);
		DecimalFormat df = new DecimalFormat("######0.00"); 
		for(int i=0; i<listBus.size(); i++){
			if(i>=5){
				break;
			}
			Map<String, Object> map = new HashMap<String, Object>();
			count = Integer.parseInt((String)listBus.get(i).get("busCount"));
			double privateD = 1;
			String privatePer = "";
			if(total != 0){
				privateD = (double)count/total;
//				privatePer = nt.format(privateD).replace("%", "");
				map.put("privatePer", df.format(privateD*100).toString());
			}else{
				privateD = (double)1/listBus.size();
//				privatePer = nt.format(privateD).replace("%", ""); 
				map.put("privatePer", df.format(privateD*100).toString());
			}
			map.put("businessName", listBus.get(i).get("businessName"));
			list.add(map);
		}
		if(other != 0 && total !=0){
			Map<String, Object> map = new HashMap<String, Object>();
			double otherD = (double)other/total;
//			String otherPer = nt.format(otherD).replace("%", "");
			map.put("otherName", "其他");
			map.put("otherPer", df.format(otherD*100).toString());
		    list.add(map);
		}
		return list;
	}
	@Override
	public String updateTrxToday(Map<String, String> map) {
		trxTodayMapper.updateTrxToday(map);
		return "0";
	}

}
