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
import com.aoto.iqms.businessconfig.models.CallStrategyModel;
import com.aoto.iqms.businessconfig.models.NumberFormModel;
import com.aoto.iqms.businessconfig.models.NumberFormQuery;
import com.aoto.iqms.businessconfig.service.inf.NumberFormService;

/**
 * 号码设置
 * @author humz
 *
 */
@Controller
public class NumberFormController {
	
	@Autowired
	private NumberFormService numberFormService ;
	
	/**
     * 进入号码设置页面
     * @author humz
     */
    @RequestMapping(value = "/businessconfig/numberform", method = RequestMethod.GET)
    public ModelAndView intoNumberFormPage()
    {
        return new ModelAndView("/businessconfig/numberform/list");
    }
    
    /**
     * 查询号码模板
     * @return
     */
    @RequestMapping(value = "/businessconfig/numberform", method = RequestMethod.GET,  headers = "accept=application/json")
    @ResponseBody
    public List<Map<String, Object>> getNumberFormPage(NumberFormQuery model)
    {
    	List<Map<String, Object>> list = numberFormService.selectNumberForm(model);
    	return list;
    }
    
    /**
     * 新增号码模板，确认后提交到此
     */
    @RequestMapping(value = "/businessconfig/numberform",params="ftype=add", method = RequestMethod.GET,  headers = "accept=application/json")
    @ResponseBody
    public  JsonResult addNumberForm(NumberFormModel model){
    	String errorCode = numberFormService.insertNumberForm(model);
    	return JsonResult.json(errorCode);
    }
    
    /**
     * 新增完成后，查询号码模板
     */
    @RequestMapping(value = "/businessconfig/numberform",params="ftype=select", method = RequestMethod.GET, headers = "accept=application/json")
    @ResponseBody
    public  List<Map<String, Object>> selectNumberForm(NumberFormQuery model){
    	List<Map<String, Object>> list = numberFormService.selectNumberForm(model);
    	return list;
    }
    
    /**
     * 编辑号码模板
     */
    @RequestMapping(value="/businessconfig/numberform",params="ftype=update", method = RequestMethod.GET, headers = "accept=application/json")
    @ResponseBody
    public JsonResult updateNumberForm(NumberFormModel model){
    	String errorCode = numberFormService.updateNumberForm(model);
    	return JsonResult.json(errorCode);
    }
    
    /**
     * 删除号码模板(提交的json数据需要使用@RequestBody，如果是表单序列化的就不需要)
     */
    @RequestMapping(value="/businessconfig/numberform",method = RequestMethod.DELETE)
    @ResponseBody
    public JsonResult deleteNumberForm(@RequestBody NumberFormModel model){
    	String erroeCode = numberFormService.deleteNumberForm(model);
    	return JsonResult.json(erroeCode);
    }
    
    /**
     * 号码模板 应用到下级机构
     * @param model
     * @return
     */
    /*@RequestMapping(value = "/businessconfig/copynumber", method = RequestMethod.POST)
    @ResponseBody
    public JsonResult copyNumber(NumberFormModel model){
    	String errorCode = numberFormService.callCopyNumberProc(model);
    	return JsonResult.json(errorCode);
    }*/
}


