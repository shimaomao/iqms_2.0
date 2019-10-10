package com.aoto.iqms.basicconfig.web.controllers;

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
import com.aoto.framework.commons.pagination.PagingCriteria;
import com.aoto.iqms.basicconfig.models.TellerModel;
import com.aoto.iqms.basicconfig.models.TellerQuery;
import com.aoto.iqms.basicconfig.service.inf.ParameterService;
import com.aoto.iqms.basicconfig.service.inf.TellerService;

/**
 * 
 * @author zhousj
 *
 */
@Controller
public class TellerController {
    @Autowired
    private TellerService tellerService;
    @Autowired
    private ParameterService parameterService;
    
    /**
     * 进入柜员页面
     * @return
     */
    @RequestMapping(value = "/basicconfig/teller", method = RequestMethod.GET)
    public ModelAndView enterTellerPage(){
        return new ModelAndView("/basicconfig/teller/list");
    }
    
    /**
     * 柜员分页
     * @param model
     * @return
     */
    @RequestMapping(value = "/basicconfig/teller", method = RequestMethod.GET, headers = "accept=application/json")
    @ResponseBody
    public JsonResult getTellerPageList(TellerQuery model){
    	if(model.getOrgId() == null){
    		model.setOrgId("0");
    	}
        PagingCriteria pagingCriteria = new PagingCriteria(model.getPage()-1, model.getRows(), model.getSort(), model.getOrder());
        List<Map<String, Object>> list = tellerService.procPageTeller(pagingCriteria, model);
        return JsonResult.json(model.getRows(), model.getPage(), pagingCriteria.getTotal(), list);
    }
    
    
    /**
     * 获取性别加载到页面下拉框
     * @return
     */
    /*@RequestMapping(value = "/basicconfig/getSexType", method = RequestMethod.GET, headers = "accept=application/json")
    @ResponseBody
    public JsonResult getSexType(){
        List<Map<String, Object>> list = parameterService.callSysDicQuery("sexType");//sys_dic里配置的dic_type
        return JsonResult.json(list.size(), list);
    }*/
    
    /**
     * 获取状态加载到页面下拉框
     * @return
     */
    /*@RequestMapping(value = "/basicconfig/getTellerStatus", method = RequestMethod.GET, headers = "accept=application/json")
    @ResponseBody
    public JsonResult getTellerStatus(){
        List<Map<String, Object>> list = parameterService.callSysDicQuery("tellerStatus");//sys_dic里配置的dic_type
        return JsonResult.json(list.size(), list);
    }*/
    
    /**
     * 新增
     * @param model
     * @return
     */
    @RequestMapping(value= "/basicconfig/teller", method = RequestMethod.POST)
    @ResponseBody
    public JsonResult createTeller(TellerModel model){
        String errorCode = tellerService.callCreateTellerProc(model);
        return JsonResult.json(errorCode);
    }
    
    /**
     * 修改
     * @param model
     * @return
     */
    @RequestMapping(value = "/basicconfig/teller", method = RequestMethod.PUT)
    @ResponseBody
    public JsonResult editTeller(TellerModel model){
    	String errorCode = tellerService.callUpdateTellerProc(model);
        return JsonResult.json(errorCode);
    }
    
    /**
     * 删除柜员
     * @param list
     * @return
     */
    @RequestMapping(value = "/basicconfig/teller", method = RequestMethod.DELETE)
    @ResponseBody
    public JsonResult removeTeller(@RequestBody List<String> list){
    	String errorCode = tellerService.callRemoveTellerProc(list);
    	return JsonResult.json(errorCode);
    }
}
