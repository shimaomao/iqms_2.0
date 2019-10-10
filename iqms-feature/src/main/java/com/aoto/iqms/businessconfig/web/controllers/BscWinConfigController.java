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
import com.aoto.iqms.businessconfig.models.BscWinConfigModel;
import com.aoto.iqms.businessconfig.models.BscWinConfigQuery;
import com.aoto.iqms.businessconfig.service.inf.BscWinConfigService;

/**
 * 窗口配置控制层
 * @author zhousj
 *
 */
@Controller
public class BscWinConfigController {
	@Autowired
	private BscWinConfigService bscWinConfigService;
	
	/**
	 * 进入窗口配置页面
	 * @return
	 */
	@RequestMapping(value = "/businessconfig/bscwinconfig", method = RequestMethod.GET)
	public ModelAndView enterWinConfig(){
		return new ModelAndView("/businessconfig/bscwinconfig/list");
	}
	
	/**
	 * 查询对应数据
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/businessconfig/bscwinconfig", method = RequestMethod.GET,  headers = "accept=application/json")
    @ResponseBody
    public JsonResult getWinConfigList(BscWinConfigQuery model){
		if(model.getOrgId() == null || model.getOrgId()==""){
    		model.setOrgId("0");
    	}
		List<Map<String, Object>> list = bscWinConfigService.procBscWinConfigQuery(model);
		return JsonResult.json(0, list);
	}
    
    /**
     * 窗口配置 应用到下级机构
     * @param model
     * @return
     */
    @RequestMapping(value = "/businessconfig/copywinconfig", method = RequestMethod.POST)
    @ResponseBody
    public JsonResult copyWinConfig(BscWinConfigModel model){
    	String errorCode = bscWinConfigService.callCreateBscWinConfigProc(model);
    	return JsonResult.json(errorCode);
    }
	/**
     * 窗口配置 保存 包含 增删改
     * @param model
     * @return
     */
    @RequestMapping(value = "/businessconfig/bscwinconfig/saveWinConfig", method = RequestMethod.DELETE)
    @ResponseBody
    public JsonResult saveWinConfig(@RequestBody List<BscWinConfigModel> list){
    	String errorCode = bscWinConfigService.procSaveWinConfig(list);
    	return JsonResult.json(errorCode);
    }
    /**
     * 窗口配置编辑
     * @param model
     * @return
     */
    @RequestMapping(value = "/businessconfig/bscwinconfig", method = RequestMethod.PUT)
    @ResponseBody
    public JsonResult editDevice(BscWinConfigModel model)
    {
    	String errorCode = bscWinConfigService.callUpdateBscWinConfigProc(model);
    	return JsonResult.json(errorCode);
    }
    
//    /**
//     * 窗口配置删除
//     * @param list
//     * @return
//     */
//    @RequestMapping(value = "/businessconfig/bscwinconfig", method = RequestMethod.DELETE)
//    @ResponseBody
//    public JsonResult removeDevice(@RequestBody List<Map<String, String>> list)
//    {
//    	String errorCode = bscWinConfigService.callRemoveBscWinConfigProc(list);
//        return JsonResult.json(errorCode);
//    }

}
