package com.aoto.iqms.monitor.web.controllers;

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
import com.aoto.iqms.monitor.service.inf.TrxTodayService;

/**
 * 评价监控控制层
 * @author zhousj
 *
 */
@Controller
public class AppraiseMonitorController {
	@Autowired
	private TrxTodayService todayService;
	
	/**
	 * 进入评价监控页面
	 * @return
	 */
	@RequestMapping(value = "/monitor/appraise", method = RequestMethod.GET)
	public ModelAndView enterAppraisePage(){
		return new ModelAndView("/monitor/appraise/list");
	}
	
	/**
	 * 查询评价监控分页
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/monitor/appraise", method = RequestMethod.GET, headers = "accept=application/json")
	@ResponseBody
	public JsonResult getAppraiseList(TrxTodayQuery model){
		if(model.getOrgId() == null){
    		model.setOrgId("0");
    	}
		PagingCriteria  pagingCriteria = new PagingCriteria(model.getPage()-1, model.getRows(), model.getSort(), 
				model.getOrder());
		List<Map<String, Object>> list = todayService.procPageTrxToday(pagingCriteria, model);
		return JsonResult.json(model.getRows(), model.getPage(), pagingCriteria.getTotal(), list);
	}
}
