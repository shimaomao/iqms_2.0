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
import com.aoto.iqms.monitor.service.inf.WinMonitorService;

/**
 * 窗口监控控制层
 * @author zhousj
 *
 */
@Controller
public class WinMonitorController {
	@Autowired
	private WinMonitorService winMonitorService;
	
	/**
	 * 进入窗口监控页面
	 * @return
	 */
	@RequestMapping(value = "/monitor/winmonitor", method = RequestMethod.GET)
	public ModelAndView enterWinMonitorPage(){
		return new ModelAndView("/monitor/winmonitor/list");
	}
	
	/**
	 * 查询窗口监控分页
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/monitor/winmonitor", method = RequestMethod.GET, headers = "accept=application/json")
	@ResponseBody
	public JsonResult getWinMonitorList(TrxTodayQuery model){
		if(model.getOrgId() == null){
    		model.setOrgId("0");
    	}
		PagingCriteria  pagingCriteria = new PagingCriteria(model.getPage()-1, model.getRows(), model.getSort(), 
				model.getOrder());
		List<Map<String, Object>> list = winMonitorService.procPageWinMonitor(pagingCriteria, model);
		return JsonResult.json(model.getRows(), model.getPage(), pagingCriteria.getTotal(), list);
	}
}
