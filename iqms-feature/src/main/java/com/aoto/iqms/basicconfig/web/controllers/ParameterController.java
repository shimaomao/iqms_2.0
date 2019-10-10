package com.aoto.iqms.basicconfig.web.controllers;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.aoto.framework.commons.beans.JsonResult;
import com.aoto.framework.commons.userdetails.CurrentUserHolder;
import com.aoto.framework.security.service.inf.OrgService;
import com.aoto.iqms.basicconfig.models.ParameterModel;
import com.aoto.iqms.basicconfig.service.inf.ParameterService;

/**
 * 参数配置控制层
 * @author zhousj
 *
 */
@Controller
public class ParameterController {
	
	@Autowired
    private ParameterService parameterService;
	
	@Autowired
    protected OrgService orgService;
	
	/**
     * 进入参数配置页面
     * @author zhousj
     */
    @RequestMapping(value = "/basicconfig/parameter", method = RequestMethod.GET)
    public ModelAndView enterParameterPage()
    {
        return new ModelAndView("basicconfig/parameter/list");
    }
    
    
    /**
     * 查询参数功能。
     * @param model
     * @return
     */
    @RequestMapping(value = "/basicconfig/parameter", method = RequestMethod.GET,  headers = "accept=application/json")
    @ResponseBody
    public JsonResult getParamterList(){
    	
        List<Map<String, Object>> list = parameterService.callParameter();//调用存储过程进行查询
    	if(list.size()>0){
    		return JsonResult.json(list.get(0));
    	}else{
    		return JsonResult.json("0");
    	}
    }
    
    
//    /**
//     * 查询参数里鉴权模式到页面下拉框
//     * @return
//     */
//    @RequestMapping(value = "/basicconfig/authentication", method = RequestMethod.GET, headers = "accept=application/json")
//    @ResponseBody
//    public JsonResult getAuthenticationType(){
//        List<Map<String, Object>> list = parameterService.callSysDicQuery("recognitionType");//sys_dic里配置的dic_type
//        return JsonResult.json(list.size(), list);
//    }
    
    
    /**
     * by hongxz 20170926 根据字典类型查询字典数据
     * @return
     */
    @RequestMapping(value = "/basicconfig/sysdic/{dicType}", method = RequestMethod.GET, headers = "accept=application/json")
    @ResponseBody
    public JsonResult querySysDic(@PathVariable String dicType){
        List<Map<String, Object>> list = parameterService.callSysDicQuery(dicType);//sys_dic里配置的dic_type
        return JsonResult.json(list.size(), list);
    }
    
    
    
    /**
     * 参数保存
     * @param model
     * @return
     */
    @RequestMapping(value = "/basicconfig/parameter", method = RequestMethod.POST)
    @ResponseBody
    public JsonResult createParameter(ParameterModel model){
    	String errorCode = parameterService.callSaveOrUpdateParameter(model);
    	return JsonResult.json(errorCode);
    }
    
    /**
     * 生成机构组织树
     * @return
     */
    @RequestMapping(value = "/basicconfig/parameter/ztree", method = RequestMethod.GET, produces = { "application/json" })
    @ResponseBody
    public Object getOrgsZtreeJson(String orgId)
    {
        List<Map<String, Object>> list = orgService.getOrgsForZtree(Integer.parseInt(orgId));
        return list;
    }
    
}
