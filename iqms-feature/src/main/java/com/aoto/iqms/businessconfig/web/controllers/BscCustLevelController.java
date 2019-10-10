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
import com.aoto.iqms.basicconfig.service.inf.BusinessManageService;
import com.aoto.iqms.basicconfig.service.inf.ParameterService;
import com.aoto.iqms.businessconfig.models.BscCustLevelModel;
import com.aoto.iqms.businessconfig.models.BscCustLevelQuery;
import com.aoto.iqms.businessconfig.service.inf.BscCustLevelService;

/**
 * 客户等级配置 控制层
 * @author zhousj
 *
 */
@Controller
public class BscCustLevelController {
	@Autowired
	private BscCustLevelService bscCustLevelService;
	
	@Autowired
	private ParameterService parameterService; 
	
	@Autowired
	private BusinessManageService busManageService;
	/**
	 * 进入客户等级配置页面
	 * @return
	 */
	@RequestMapping(value = "/businessconfig/bsccustlevel", method = RequestMethod.GET)
	public ModelAndView enterWinConfig(){
		return new ModelAndView("/businessconfig/bsccustlevel/list");
	}
	
	/**
	 * 查询对应数据
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/businessconfig/bsccustlevel", method = RequestMethod.GET,  headers = "accept=application/json")
    @ResponseBody
    public JsonResult getBscCustLevelList(BscCustLevelQuery model){
		if(model.getOrgId() == null || model.getOrgId()==""){
    		model.setOrgId("0");
    	}
		List<Map<String, Object>> list = bscCustLevelService.procBscCustLevelQuery(model);
		return JsonResult.json(0, list);
	}
	
//	/**
//     * 客户等级配置分页功能。
//     * @param model
//     * @return
//     */
//    @RequestMapping(value = "/businessconfig/bsccustlevel", method = RequestMethod.GET,  headers = "accept=application/json")
//    @ResponseBody
//    public JsonResult getWinConfigPageList(BscCustLevelQuery model){
//    	if(model.getOrgId() == null || model.getOrgId()==""){
//    		model.setOrgId("0");
//    	}
//    	PagingCriteria pagingCriteria = new PagingCriteria(model.getPage() - 1, model.getRows(), model.getSort(),
//                model.getOrder());
//    	List<Map<String, Object>> list = new ArrayList<Map<String,Object>>();
//    	if(model.getDeviceNo() == null || model.getDeviceNo()==""){
//    		return JsonResult.json(model.getRows(), model.getPage(), pagingCriteria.getTotal(), list);
//    	}
//    	list = bscCustLevelService.procPageBscCustLevel(pagingCriteria, model);//调用存储过程进行分页
//    	return JsonResult.json(model.getRows(), model.getPage(), pagingCriteria.getTotal(), list);
//    }
    
    /**
     * 获取客户等级名称加载到页面下拉框
     * @return
     */
    /*@RequestMapping(value = "/businessconfig/getcustlevel", method = RequestMethod.GET, headers = "accept=application/json")
    @ResponseBody
    public JsonResult getCustLevel(){
        List<Map<String, Object>> list = parameterService.callSysDicQuery("levelName");//sys_dic里配置的dic_type
        return JsonResult.json(list.size(), list);
    }*/
    
    /**
     * 获取业务名称加载到页面下拉框
     * @return
     */
    @RequestMapping(value = "/businessconfig/getAllBusiness", method = RequestMethod.GET, headers = "accept=application/json")
    @ResponseBody
    public JsonResult getAllBusiness(){
        List<Map<String, Object>> list = busManageService.findBusManageByConditon(null);
        return JsonResult.json(list.size(), list);
    }
    
    /**
     * 客户等级新增。包含增改
     * @param model
     * @return
     */
    @RequestMapping(value = "/businessconfig/bsccustlevel/saveBscCustlevel", method = RequestMethod.DELETE)
    @ResponseBody
    public JsonResult createCustLevel(@RequestBody List<BscCustLevelModel> list){
    	String errorCode = bscCustLevelService.callCreateBscCustLevelProc(list);
    	return JsonResult.json(errorCode);
    }
    
    /**
     * 客户等级配置编辑
     * @param model
     * @return
     */
//    @RequestMapping(value = "/businessconfig/bsccustlevel", method = RequestMethod.PUT)
//    @ResponseBody
//    public JsonResult editCustLevel(BscCustLevelModel model)
//    {
//    	String errorCode = bscCustLevelService.callUpdateBscCustLevelProc(model);
//    	return JsonResult.json(errorCode);
//    }
//    
//    /**
//     * 客户等级配置删除
//     * @param list
//     * @return
//     */
//    @RequestMapping(value = "/businessconfig/bsccustlevel", method = RequestMethod.DELETE)
//    @ResponseBody
//    public JsonResult removeDevice(@RequestBody List<Map<String, String>> list)
//    {
//    	String errorCode = bscCustLevelService.callRemoveBscCustLevelProc(list);
//        return JsonResult.json(errorCode);
//    }
    
    /**
     * 客户等级设置 应用到下级机构
     * @param model
     * @return
     */
    @RequestMapping(value = "/businessconfig/copycustLevel", method = RequestMethod.POST)
    @ResponseBody
    public JsonResult copyCustLevel(BscCustLevelModel model){
    	String errorCode = bscCustLevelService.callSaveBscCustLevelProc(model);
    	return JsonResult.json(errorCode);
    }
}
