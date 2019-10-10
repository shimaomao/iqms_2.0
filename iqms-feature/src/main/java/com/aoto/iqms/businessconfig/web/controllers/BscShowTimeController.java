package com.aoto.iqms.businessconfig.web.controllers;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.aoto.framework.commons.beans.JsonResult;
import com.aoto.iqms.businessconfig.models.BscShowTimeModel;
import com.aoto.iqms.businessconfig.models.BscShowTimeQuery;
import com.aoto.iqms.businessconfig.service.inf.BscShowTimeService;

/**
 * 业务显示控制层
 * @author zhousj
 *
 */
@Controller
public class BscShowTimeController {
	@Autowired
	private BscShowTimeService showTimeService;
	
	@RequestMapping(value = "/businessconfig/bscshowtime", method = RequestMethod.GET)
	public ModelAndView enterShowTime(){
		return new ModelAndView("/businessconfig/bscshowtime/list");
	}
	
	/**
	 * 点击组织树 查询业务对应的数据
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/businessconfig/bscshowtime", method = RequestMethod.GET,  headers = "accept=application/json")
    @ResponseBody
    public JsonResult getBranchBusinessList(BscShowTimeQuery model){
		if(model.getOrgId() == null || model.getOrgId()==""){
    		model.setOrgId("0");
    	}
		List<Map<String, Object>> list = showTimeService.procShowTimeQuery(model);
		return JsonResult.json(0, list);
	}
	
	/**
     * 业务显示保存 包含 增删改
     * @param model
     * @return
     */
    @RequestMapping(value = "/businessconfig/bscshowtime", method = RequestMethod.DELETE)
    @ResponseBody
    public JsonResult saveShowTime(@RequestBody List<BscShowTimeModel> list){
    	String errorCode = showTimeService.procSaveShowTime(list);
    	return JsonResult.json(errorCode);
    }
    
    /**
     * 业务显示 应用到下级机构
     * @param model
     * @return
     */
    @RequestMapping(value = "/businessconfig/copyshowtime", method = RequestMethod.POST)
    @ResponseBody
    public JsonResult copyBranchBus(BscShowTimeModel model){
    	String errorCode = showTimeService.callCopyBscShowTime(model);
    	return JsonResult.json(errorCode);
    }
}
