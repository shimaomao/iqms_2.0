package com.aoto.iqms.basicconfig.web.controllers;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.aoto.framework.commons.beans.JsonResult;
import com.aoto.framework.commons.pagination.PagingCriteria;
import com.aoto.iqms.basicconfig.models.BusinessManageModel;
import com.aoto.iqms.basicconfig.models.BusinessManageQuery;
import com.aoto.iqms.basicconfig.models.CustTypeQuery;
import com.aoto.iqms.basicconfig.service.inf.BusinessManageService;

/**
 * 业务管理控制层
 * @author humz
 *
 */
@Controller
public class BusinessManageController {

	@Autowired
	private BusinessManageService businessManageService;  //自动注入业务层接口
	
	/**
     * 进入业务管理页面
     * @author humz
     */
    @RequestMapping(value = "/basicconfig/businessmanage", method = RequestMethod.GET)
    public ModelAndView enterBusManagePage()
    {
        return new ModelAndView("basicconfig/businessmanage/list");
    }
    
    /**
     * 业务管理分页功能。
     * @param model
     * @return
     */
    @RequestMapping(value = "/basicconfig/businessmanage", method = RequestMethod.GET,  headers = "accept=application/json")
    @ResponseBody
    public JsonResult getBusManagePageList(BusinessManageQuery model){
    	PagingCriteria pagingCriteria = new PagingCriteria(model.getPage() - 1, model.getRows(), model.getSort(),model.getOrder());
    	List<Map<String, Object>> list = businessManageService.procPageBusManage(pagingCriteria, model);//调用存储过程进行分页
    	
    	return JsonResult.json(model.getRows(), model.getPage(), pagingCriteria.getTotal(), list);
    }
    
    
    /**
     * 业务类型查询。
     * @param model
     * @return
     */
    @RequestMapping(value = "/basicconfig/businessmanage",params="ftype=all", method = RequestMethod.GET,  headers = "accept=application/json")
    @ResponseBody
    public List<Map<String, Object>> getAll(BusinessManageQuery model,HttpServletRequest request){
    	String nflag = request.getParameter("n_flag");
    	List<Map<String, Object>> all = new ArrayList<Map<String,Object>>();
    	if (nflag == null || nflag.equals("")){
    		Map<String, Object> map = new HashMap<String, Object>();
    		map.put("businessName", "--请选择--");
    		map.put("businessId", "");
    		all.add(map);
    	}
    	List<Map<String, Object>> list = businessManageService.findBusManageByConditon(null);//传入参数为空，此处不能为model
    	all.addAll(list);
    	return all;
    }
    
    
    /**
     * 业务类型查询。
     * @param model
     * @return
     */
    @RequestMapping(value = "/basicconfig/selectBusinessmanage",params="ftype=all", method = RequestMethod.GET,  headers = "accept=application/json")
    @ResponseBody
    public List<Map<String, Object>> getAllBus(BusinessManageQuery model,HttpServletRequest request){
    	String nflag = request.getParameter("n_flag");
    	List<Map<String, Object>> all = new ArrayList<Map<String,Object>>();
    	if (nflag == null || nflag.equals("")){
    		Map<String, Object> map = new HashMap<String, Object>();
    		map.put("businessName", "--请选择--");
    		map.put("businessId", "");
    		all.add(map);
    	}
    	List<Map<String, Object>> list = businessManageService.findBusManageByConditon(null);//传入参数为空，此处不能为model
    	all.addAll(list);
    	return all;
    }
    
    
    /**
     * 业务管理新增。
     * @param model
     * @return
     */
    @RequestMapping(value = "/basicconfig/businessmanage", method = RequestMethod.POST)
    @ResponseBody
    public JsonResult createBusManage(BusinessManageModel model){
    	String errorCode = businessManageService.callCreateBusManageProc(model);
    	return JsonResult.json(errorCode);
    }
    
    /**
     * 业务管理编辑
     * @param model
     * @return
     */
    @RequestMapping(value = "/basicconfig/businessmanage", method = RequestMethod.PUT)
    @ResponseBody
    public JsonResult editBusManage(BusinessManageModel model)
    {
    	String errorCode = businessManageService.callUpdateBusManageProc(model);
    	return JsonResult.json(errorCode);
    }
    
    /**
     * 业务管理删除
     * @param list
     * @return
     */
    @RequestMapping(value = "/basicconfig/businessmanage", method = RequestMethod.DELETE)
    @ResponseBody
    public JsonResult removeBusManages(@RequestBody List<String> list)
    {
    	String errorCode = businessManageService.callRemoveBusManageProc(list);
        return JsonResult.json(errorCode);
    }
	
    /**
     * 查询所有业务
     * @return
     */
    @RequestMapping(value = "/basicconfig/allbusinessmanage", method = RequestMethod.GET)
    @ResponseBody
    public JsonResult selectBusManagesALl()
    {
    	List<Map<String, Object>> list = businessManageService.selectBusManage();
        return JsonResult.json(0,list);
    }
}
