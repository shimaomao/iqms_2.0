package com.aoto.iqms.businessconfig.web.controllers;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import com.aoto.framework.commons.beans.JsonResult;
import com.aoto.iqms.basicconfig.models.DeviceNoModel;
import com.aoto.iqms.basicconfig.models.TakeModelModel;
import com.aoto.iqms.businessconfig.models.BscCustLevelModel;
import com.aoto.iqms.businessconfig.models.BscShowTimeModel;
import com.aoto.iqms.businessconfig.models.BscWinConfigModel;
import com.aoto.iqms.businessconfig.models.BscWinConfigQuery;
import com.aoto.iqms.businessconfig.models.CallStrategyModel;
import com.aoto.iqms.businessconfig.models.TicketFormModel;
import com.aoto.iqms.businessconfig.service.inf.BscCustLevelService;
import com.aoto.iqms.businessconfig.service.inf.BscShowTimeService;
import com.aoto.iqms.businessconfig.service.inf.BscWinConfigService;
import com.aoto.iqms.businessconfig.service.inf.CallStrategyService;
import com.aoto.iqms.businessconfig.service.inf.TakeConfigService;
import com.aoto.iqms.businessconfig.service.inf.TicketFormService;

/**
 * 一键检测
 * @author hongxz
 *
 */
@Controller
public class OnekeyCheckController {
	
	@Autowired
	private BscWinConfigService bscWinConfigService;
	@Autowired
	private CallStrategyService callStrategyService;
	@Autowired
	private TicketFormService ticketFormService;
	@Autowired
	private BscShowTimeService bscShowTimeService;
	
	@Autowired
	private TakeConfigService takeConfigService;
	
	@Autowired
	private BscCustLevelService bscCustLevelService;
	
	/**
     * 进入一键检测界面
     * @author humz
     */
    @RequestMapping(value = "/businessconfig/onekeycheck", method = RequestMethod.GET)
    public ModelAndView intoOnekeyCheckPage()
    {
        return new ModelAndView("/businessconfig/onekeycheck/list");
    }
    
    /**
     * 一键检测：检测窗口
     */
    @RequestMapping(value="/businessconfig/onekeycheck/winNo",method = RequestMethod.GET,headers = "accept=application/json")
    @ResponseBody
    public JsonResult checkWin(BscWinConfigModel model){
    	List<Map<String, Object>> winList = bscWinConfigService.checkedWinInfo(model);
    	return JsonResult.json(0, winList);
    }
    
    /**
     * 一键检测：检测叫号策略
     */
    @RequestMapping(value="/businessconfig/onekeycheck/winNoBuz",method = RequestMethod.GET,headers = "accept=application/json")
    @ResponseBody
    public JsonResult checkWinBuz(CallStrategyModel model){
    	List<Map<String, Object>> winBuzList = callStrategyService.checkedWinBuz(model);
    	return JsonResult.json(0, winBuzList);
    }
    
    /**
     * 一键检测：模板检测
     */
    @RequestMapping(value="/businessconfig/onekeycheck/ticketModel",method = RequestMethod.GET,headers = "accept=application/json")
    @ResponseBody
    public JsonResult checkTicketModel(TicketFormModel model){
    	List<Map<String, Object>> ticketFormList = ticketFormService.checkedTicketModel(model);
    	return JsonResult.json(0, ticketFormList);
    }
    
    /**
     * 一键检测：业务及业务显示时间
     */
    @RequestMapping(value="/businessconfig/onekeycheck/buztime",method = RequestMethod.GET,headers = "accept=application/json")
    @ResponseBody
    public JsonResult checkBuzTime(BscShowTimeModel model){
    	List<Map<String, Object>> buzTimeList = bscShowTimeService.checkedBuzTime(model);
    	return JsonResult.json(0, buzTimeList);
    }
    
    /**
     * 一键检测：取号界面检测
     */
    @RequestMapping(value="/businessconfig/onekeycheck/queueface",method = RequestMethod.GET,headers = "accept=application/json")
    @ResponseBody
    public JsonResult checkQueueface(TakeModelModel model){
    	List<Map<String, Object>> queuefaceList = takeConfigService.checkedQueueface(model);
    	return JsonResult.json(0, queuefaceList);
    }
    
    /**
     * 一键检测：客户级别设置检测
     */
    @RequestMapping(value="/businessconfig/onekeycheck/custlevel",method = RequestMethod.GET,headers = "accept=application/json")
    @ResponseBody
    public JsonResult checkCustlevel(BscCustLevelModel model){
    	List<Map<String, Object>> queuefaceList = bscCustLevelService.checkedCustLevel(model);
    	return JsonResult.json(0, queuefaceList);
    }
    
}
