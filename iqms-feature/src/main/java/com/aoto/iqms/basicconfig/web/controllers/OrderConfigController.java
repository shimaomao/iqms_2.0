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
import com.aoto.iqms.basicconfig.models.OrderConfigModel;
import com.aoto.iqms.basicconfig.models.OrderConfigQuery;
import com.aoto.iqms.basicconfig.service.inf.OrderConfigService;

/**
 * 预约控制层
 * @author zhousj
 *
 */
@Controller
public class OrderConfigController {
	@Autowired
	public OrderConfigService orderService;
	
	/**
     * 进入预约配置页面
     * @return
     */
    @RequestMapping(value = "/basicconfig/orderconfig", method = RequestMethod.GET)
    public ModelAndView enterMenuPage(){
        return new ModelAndView("basicconfig/orderconfig/list");
    }
    
    /**
     * 预约配置分页
     * @param model
     * @return
     */
    @RequestMapping(value = "/basicconfig/orderconfig", method = RequestMethod.GET, headers = "accept=application/json")
    @ResponseBody
    public JsonResult getOrderConfigList(OrderConfigQuery model){
        PagingCriteria pagingCriteria = new PagingCriteria(model.getPage()-1, model.getRows(), model.getSort(), 
        		model.getOrder());
        List<Map<String, Object>> list = orderService.procPageOrderConfig(pagingCriteria, model);
        return JsonResult.json(model.getRows(), model.getPage(), pagingCriteria.getTotal(), list);
    }
    
    /**
     * 新增预约配置
     * @param model
     * @return
     */
    @RequestMapping(value = "/basicconfig/orderconfig", method = RequestMethod.POST)
    @ResponseBody
    public JsonResult createMenu(OrderConfigModel model){
    	String errorCode = orderService.callCreateOrderConfigProc(model);
    	return JsonResult.json(errorCode);
    }
    
    /**
     * 编辑预约配置
     * @param model
     * @return
     */
    @RequestMapping(value = "/basicconfig/orderconfig", method = RequestMethod.PUT)
    @ResponseBody
    public JsonResult editOrderConfig(OrderConfigModel model){
        String errorCode = orderService.callUpdateOrderConfigProc(model);
        return JsonResult.json(errorCode);
    }
    
    /**
     * 删除预约配置
     * @param list
     * @return
     */
    @RequestMapping(value = "/basicconfig/orderconfig", method = RequestMethod.DELETE)
    @ResponseBody
    public JsonResult removeMenu(@RequestBody List<String> list){
        String errorCode = orderService.callRemoveOrderConfigProc(list);
        return JsonResult.json(errorCode);
    }
    
    /**
     * 应用到下级机构
     * @param model
     * @return
     */
    @RequestMapping(value = "/basicconfig/orderconfig/copy", method = RequestMethod.POST)
    @ResponseBody
    public JsonResult copy(OrderConfigQuery model){
    	String errorCode = orderService.callSaveCopyProc(model);
    	return JsonResult.json(errorCode);
    }
}
