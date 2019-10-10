package com.aoto.iqms.businessconfig.web.controllers;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.aoto.framework.commons.beans.JsonResult;
import com.aoto.iqms.businessconfig.models.CallStrategyModel;
import com.aoto.iqms.businessconfig.service.inf.CallStrategyService;

/**
 * 叫号策略-控制层
 * @author humz
 *
 */
@Controller
public class CallStrategyController {

	@Autowired
	private CallStrategyService callStrategyService;
	
	/**
	 * 进入页面
	 */
	@RequestMapping(value="/businessconfig/callstrategy", method = RequestMethod.GET)
	public ModelAndView intoCallStrategyPage(){
		return new ModelAndView("/businessconfig/callstrategy/list");
	}
	
	/**
	 * 查询窗口列表
	 */
	@RequestMapping(value="/businessconfig/callstrategy/selectWinConfig",method = RequestMethod.POST,  headers = "accept=application/json")
	@ResponseBody
	public Map<String, Object> selectWinConfig(@RequestBody Map<String, Object> map){
		Map<String, Object> map2 = callStrategyService.selectWinConfig(map);
		return map2;
	}
	
	/**
	 * 查询业务类型
	 */
	@RequestMapping(value="/businessconfig/callstrategy/selectBuzType", method = RequestMethod.POST,  headers = "accept=application/json")
	@ResponseBody
	public Map<String, Object> selectBuzType(@RequestBody Map<String, Object> map){
		Map<String, Object> map2 = callStrategyService.selectBuzType(map);
		return map2;
	}
	
	/**
	 * 查询业务类型与客户等级的笛卡尔乘积
	 */
	@RequestMapping(value="/businessconfig/callstrategy/selectCounterBuz",method = RequestMethod.POST,  headers = "accept=application/json")
	@ResponseBody
	public Map<String, Object> selectCounterBuz(@RequestBody Map<String, Object> map){
		Map<String, Object> map2 = callStrategyService.selectCounterBuz(map);
		return map2;
	}
	
	/**
	 * 查询保存的窗口统计数据
	 */
	@RequestMapping(value="/businessconfig/callstrategy/selectCounterBuzsByWinId", method = RequestMethod.POST,  headers = "accept=application/json")
	@ResponseBody
	public Map<String, Object> selectCounterBuzsByWinId(@RequestBody Map<String, Object> map){
		Map<String, Object> map2 = callStrategyService.selectCounterBuzsByWinId(map);
		return map2;
	}
	
	/**
	 * 保存配置到数据库
	 */
	@RequestMapping(value="/businessconfig/callstrategy", params ="ftype=saveCounterBuzs", method = RequestMethod.POST,  headers = "accept=application/json")
	@ResponseBody
	public JsonResult saveCounterBuzs(@RequestBody Map<String, Object> map){ //前台转换为json数据的数组参数映射到list集合中
		String errorCode = callStrategyService.saveCounterBuzs(map);
		return JsonResult.json(errorCode);
	}
	
}
