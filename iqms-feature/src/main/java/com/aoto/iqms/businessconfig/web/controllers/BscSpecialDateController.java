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
import com.aoto.iqms.businessconfig.models.BscCustRecognitionModel;
import com.aoto.iqms.businessconfig.models.BscCustRecognitionQuery;
import com.aoto.iqms.businessconfig.models.BscSpecialDateModel;
import com.aoto.iqms.businessconfig.service.inf.BscSpecialDateService;

/**
 * 特殊日期配置控制层
*@author zsj
*@创建时间：2018年10月9日上午10:10:58
*/
@Controller
public class BscSpecialDateController {
	@Autowired
	private BscSpecialDateService spDateService;
	/**
	 * 进入特殊日期配置页面
	 * @return
	 */
	@RequestMapping(value = "/businessconfig/specialdate", method = RequestMethod.GET)
	public ModelAndView enterWinConfig(){
		return new ModelAndView("/businessconfig/specialdate/list");
	}
	
	/**
	 * 查询对应数据
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/businessconfig/specialdate", method = RequestMethod.GET,  headers = "accept=application/json")
    @ResponseBody
    public JsonResult getBscCustLevelList(BscCustRecognitionQuery model){
		List<Map<String, Object>> list = spDateService.procSpecialDateQuery(model);
		return JsonResult.json(0, list);
	}
	
	/**
     * 特殊日期 保存 包含 增删改
     * @param model
     * @return
     */
    @RequestMapping(value = "/businessconfig/specialdate/saveSpecialDate", method = RequestMethod.DELETE)
    @ResponseBody
    public JsonResult saveCustRecognition(@RequestBody List<BscSpecialDateModel> list){
    	String errorCode = spDateService.procSaveSpecialDate(list);
    	return JsonResult.json(errorCode);
    }
    
    /**
     * 客户识别 应用到下级机构
     * @param model
     * @return
     */
    @RequestMapping(value = "/businessconfig/copyspecialdate", method = RequestMethod.POST)
    @ResponseBody
    public JsonResult copySpecialDate(BscSpecialDateModel model){
    	String errorCode = spDateService.procSpecialDateCopy(model);
    	return JsonResult.json(errorCode);
    }
	
}
