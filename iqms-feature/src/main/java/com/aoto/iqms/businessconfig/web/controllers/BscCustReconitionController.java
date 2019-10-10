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
import com.aoto.iqms.basicconfig.service.inf.ParameterService;
import com.aoto.iqms.businessconfig.models.BscCustRecognitionModel;
import com.aoto.iqms.businessconfig.models.BscCustRecognitionQuery;
import com.aoto.iqms.businessconfig.service.inf.BscCustRecognitionService;

/**
 * 客户识别 控制层
 * @author zhousj
 *
 */
@Controller
public class BscCustReconitionController {
	@Autowired
	private BscCustRecognitionService bscCustRecognitionService;
	@Autowired
	private ParameterService parameterService;
	
	@RequestMapping(value = "/businessconfig/bsccustrecogni", method = RequestMethod.GET)
	public ModelAndView enterCustRecognition(){
		return new ModelAndView("/businessconfig/bsccustrecognition/list");
	}
	
	/**
	 * 查询对应数据
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/businessconfig/bsccustrecogni", method = RequestMethod.GET,  headers = "accept=application/json")
    @ResponseBody
    public JsonResult getCustRecognitionList(BscCustRecognitionQuery model){
		if(model.getOrgId() == null || model.getOrgId()==""){
    		model.setOrgId("0");
    	}
		List<Map<String, Object>> list = bscCustRecognitionService.procCustRecognitionQuery(model);
		return JsonResult.json(0, list);
	}
	
	/**
     * 客户识别 保存 包含 增删改
     * @param model
     * @return
     */
    @RequestMapping(value = "/businessconfig/bsccustrecogni/saveCustRecogni", method = RequestMethod.DELETE)
    @ResponseBody
    public JsonResult saveCustRecognition(@RequestBody List<BscCustRecognitionModel> list){
    	String errorCode = bscCustRecognitionService.procSaveCustRecognition(list);
    	return JsonResult.json(errorCode);
    }
    
    
    /**
     * 查询字典表客户类型  生成下拉框
     * @return
     */
    /*@RequestMapping(value = "/businessconfig/custtype", method = RequestMethod.GET, headers = "accept=application/json")
    @ResponseBody
    public JsonResult getCustType(){
        List<Map<String, Object>> list = parameterService.callSysDicQuery("levelName");//sys_dic里配置的dic_type
        return JsonResult.json(list.size(), list);
    }*/
    
    /**
     * 客户识别 应用到下级机构
     * @param model
     * @return
     */
    @RequestMapping(value = "/businessconfig/copycustrecognition", method = RequestMethod.POST)
    @ResponseBody
    public JsonResult copyCustRecognition(BscCustRecognitionModel model){
    	String errorCode = bscCustRecognitionService.procBscCustRecognitionCopy(model);
    	return JsonResult.json(errorCode);
    }
    
    /**
     * 客户识别快速应用
     * @param model
     * @return
     */
    @RequestMapping(value = "/businessconfig/fastcopycustrecognition", method = RequestMethod.POST)
    @ResponseBody
    public JsonResult fastCopyCustRecognition(BscCustRecognitionModel model){
    	String errorCode = bscCustRecognitionService.procBscCustRecognitionFastCopy(model);
    	return JsonResult.json(errorCode);
    }
}
