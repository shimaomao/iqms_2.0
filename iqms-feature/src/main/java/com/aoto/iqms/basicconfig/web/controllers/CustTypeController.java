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
import com.aoto.iqms.basicconfig.models.CustTypeModel;
import com.aoto.iqms.basicconfig.models.CustTypeQuery;
import com.aoto.iqms.basicconfig.service.inf.CustTypeService;


/**
 * 客户等级控制层
 * @author daxian
 *
 */
@Controller
public class CustTypeController {
	
	@Autowired
	private CustTypeService custTypeService;  //注入业务层对象
	
	
	/**
     * 进入客户等级页面
     * @author daxian
     */
    @RequestMapping(value = "/basicconfig/custtype", method = RequestMethod.GET)
    public ModelAndView enterCustTypePage()
    {
    	String name = "洪仙知";
    	System.out.println(name);
        return new ModelAndView("basicconfig/custtype/list");
    }
    
    
    /**
     * 客户等级分页功能。
     * @param model
     * @return
     */
    @RequestMapping(value = "/basicconfig/custtype", method = RequestMethod.GET,  headers = "accept=application/json")
    @ResponseBody
    public JsonResult getcustTypePageList(CustTypeQuery model){
    	PagingCriteria pagingCriteria = new PagingCriteria(model.getPage() - 1, model.getRows(), model.getSort(),
                model.getOrder());
    	List<Map<String, Object>> list = custTypeService.procPageCustType(pagingCriteria, model);//调用存储过程进行分页
    	
    	return JsonResult.json(model.getRows(), model.getPage(), pagingCriteria.getTotal(), list);
    }
    
    /**
     * 客户等级查询。
     * @param model
     * @return
     */
    @RequestMapping(value = "/basicconfig/custtype",params="ftype=all", method = RequestMethod.GET,  headers = "accept=application/json")
    @ResponseBody
    public List<Map<String, Object>> getAll(CustTypeQuery model,HttpServletRequest request){
    	String nflag = request.getParameter("n_flag");
    	List<Map<String, Object>> all = new ArrayList<Map<String,Object>>();
    	if (nflag == null || nflag.equals("")){
    		Map<String, Object> map = new HashMap<String, Object>();
    		map.put("custName", "--请选择--");
    		map.put("custLevel", "");
    		all.add(map);
    	}
    	List<Map<String, Object>> list = custTypeService.findCusLevelInfoByConditon(null);//传入参数为空，此处不能为model
    	all.addAll(list);
    	return all;
    }
    
    
    /**
     * 客户等级查询。
     * @param model
     * @return
     */
    @RequestMapping(value = "/basicconfig/selectCusttype",params="ftype=all", method = RequestMethod.GET,  headers = "accept=application/json")
    @ResponseBody
    public List<Map<String, Object>> getAllForSelect(CustTypeQuery model,HttpServletRequest request){
    	String nflag = request.getParameter("n_flag");
    	List<Map<String, Object>> all = new ArrayList<Map<String,Object>>();
    	if (nflag == null || nflag.equals("")){
    		Map<String, Object> map = new HashMap<String, Object>();
    		map.put("custName", "--请选择--");
    		map.put("custLevel", "");
    		all.add(map);
    	}
    	List<Map<String, Object>> list = custTypeService.findCusLevelInfoByConditon(null);//传入参数为空，此处不能为model
    	all.addAll(list);
    	return all;
    }
    
    /**
     * 客户类型新增。
     * @param model
     * @return
     */
    @RequestMapping(value = "/basicconfig/custtype", method = RequestMethod.POST)
    @ResponseBody
    public JsonResult createcustType(CustTypeModel model){
    	String errorCode = custTypeService.callCreateCustTypeProc(model);
    	return JsonResult.json(errorCode);
    }
    
    /**
     * 客户类型编辑
     * @param model
     * @return
     */
    @RequestMapping(value = "/basicconfig/custtype", method = RequestMethod.PUT)
    @ResponseBody
    public JsonResult editcusType(CustTypeModel model)
    {
    	String errorCode = custTypeService.callUpdateCustTypeProc(model);
    	return JsonResult.json(errorCode);
    }
    
    /**
     * 客户等级删除
     * @param list
     * @return
     */
    @RequestMapping(value = "/basicconfig/custtype", method = RequestMethod.DELETE)
    @ResponseBody
    public JsonResult removecusTypes(@RequestBody List<String> list)
    {
    	String errorCode = custTypeService.callRemoveCustTypeProc(list);
        return JsonResult.json(errorCode);
    }
}
