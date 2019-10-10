package com.aoto.iqms.monitor.web.controllers;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.aoto.framework.commons.beans.JsonResult;
import com.aoto.framework.commons.pagination.PagingCriteria;
import com.aoto.iqms.monitor.models.TrxTodayQuery;
import com.aoto.iqms.monitor.service.inf.TrxHistoryService;
import com.aoto.iqms.monitor.service.inf.TrxTodayService;

/**
 * 当日业务数据控制层
 * @author zhousj
 *
 */
@Controller
public class TrxTodayController {
	@Autowired
	private TrxTodayService todayService;
	@Autowired
	private TrxHistoryService historyService;
	
	/**
	 * 进入当日业务数据页面
	 * @return
	 */
	@RequestMapping(value = "/monitor/trxtoday", method = RequestMethod.GET)
	public ModelAndView enterTrxTodayPage(){
		return new ModelAndView("/monitor/trxtoday/list");
	}
	
	/**
	 * 查询当日业务分页
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/monitor/trxtoday", method = RequestMethod.GET, headers = "accept=application/json")
	@ResponseBody
	public JsonResult getTrxTodayList(TrxTodayQuery model){
		if(model.getOrgId() == null){
    		model.setOrgId("0");
    	}
		PagingCriteria  pagingCriteria = new PagingCriteria(model.getPage()-1, model.getRows(), model.getSort(), 
				model.getOrder());
		List<Map<String, Object>> list = todayService.procPageTrxToday(pagingCriteria, model);
//		List<Map<String, Object>> listQuery = todayService.procTrxTodayQuery(model.getOrgId());
//		List<Map<String, Object>> listYesQuery = historyService.procTrxYesterdayQuery(model.getOrgId());
//		if(Integer.parseInt(listQuery.get(0).get("total").toString())!=0){
//			list.addAll(listQuery);
//		}
//		if(listYesQuery.get(0)!=null){
//			list.addAll(listYesQuery);
//		}
//		if(Integer.parseInt(listQuery.get(0).get("total").toString())!=0){
//			list.addAll(todayService.getPercentList(listQuery, listYesQuery));
//		}
		return JsonResult.json(model.getRows(), model.getPage(), pagingCriteria.getTotal(), list);
	}
	
	/**
	 * 查询今日和昨日对比所需要的数据
	 * @param orgId
	 * @return
	 */
	@RequestMapping(value = "monitor/getCompare", method = RequestMethod.GET, headers = "accept=application/json")
	@ResponseBody
	public JsonResult getCompare(String orgId){
		if(orgId == null || orgId.equals("")){
    		orgId = "0";
    	}
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		List<Map<String, Object>> listQuery = todayService.procTrxTodayQuery(orgId);
		List<Map<String, Object>> listYesQuery = historyService.procTrxYesterdayQuery(orgId);
//		if(Integer.parseInt(listQuery.get(0).get("total").toString())!=0){
			list.addAll(listQuery);
//		}
//		if(listYesQuery.get(0)!=null){
			list.addAll(listYesQuery);
//		}
		if(Integer.parseInt(listQuery.get(0).get("total").toString())!=0){
			list.addAll(todayService.getPercentList(listQuery, listYesQuery));
		}
		return JsonResult.json(0, list);
	}
	
	/**
	 * 查询饼状图需要的数据
	 * @param orgId
	 * @return
	 */
	@RequestMapping(value = "monitor/getTrxTodayBus", method = RequestMethod.GET, headers = "accept=application/json")
	@ResponseBody
	public JsonResult getTrxTodayBus(String orgId){
		if(orgId.equals("")||orgId == null){
			orgId = "0";
		}
		List<Map<String, Object>> list = todayService.procTrxTodayBus(orgId);
		return JsonResult.json(0, list);
	}
	/**
	 * 查询当日业务特定数据
	 * @param orgId
	 * @return
	 */
	@RequestMapping(value = "monitor/getTrxToday", method = RequestMethod.GET, headers = "accept=application/json")
	public JsonResult getTrxToday(String orgId){
		/*List<Map<String, Object>> list = todayService.procTrxTodayQuery(orgId);
		return JsonResult.json(0, list);*/
		if(orgId == null || orgId.equals("")){
    		orgId = "0";
    	}
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		List<Map<String, Object>> listQuery = todayService.procTrxTodayQuery(orgId);
		List<Map<String, Object>> listYesQuery = historyService.procTrxYesterdayQuery(orgId);
		if(Integer.parseInt(listQuery.get(0).get("total").toString())!=0){
			list.addAll(listQuery);
		}
		if(listYesQuery.get(0)!=null){
			list.addAll(listYesQuery);
		}
		if(Integer.parseInt(listQuery.get(0).get("total").toString())!=0){
			list.addAll(todayService.getPercentList(listQuery, listYesQuery));
		}
		return JsonResult.json(0, list);
	}
}
