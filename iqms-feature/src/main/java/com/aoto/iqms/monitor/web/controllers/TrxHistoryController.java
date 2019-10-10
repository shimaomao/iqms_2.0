package com.aoto.iqms.monitor.web.controllers;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.aoto.framework.commons.beans.JsonResult;
import com.aoto.iqms.monitor.service.inf.TrxHistoryService;

/**
 * 历史业务数据控制层
 * @author zhousj
 *
 */
@Controller
public class TrxHistoryController {
	@Autowired
	private TrxHistoryService historyService;
	
	/**
	 * 查询昨日特定业务数据
	 * @param orgId
	 * @return
	 */
	@RequestMapping (value = "/monitor/getTrxYesterday", method = RequestMethod.GET, headers = "accept=application/json")
	public JsonResult getTrxYesterday(String orgId){
		List<Map<String, Object>> list = historyService.procTrxYesterdayQuery(orgId);
		return JsonResult.json(0, list);
	}
}
