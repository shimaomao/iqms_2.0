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
import com.aoto.iqms.businessconfig.models.NumberFormModel;
import com.aoto.iqms.businessconfig.models.SettingsModel;
import com.aoto.iqms.businessconfig.models.TicketFormModel;
import com.aoto.iqms.businessconfig.service.inf.TicketFormService;

/**
 * 号票设置
 * @author humz
 *
 */
@Controller
public class TicketFormController {
	
	@Autowired
	private TicketFormService ticketFormService;
	
	/**
     * 进入号票设置页面
     * @author humz
     */
    @RequestMapping(value = "/businessconfig/ticketform", method = RequestMethod.GET)
    public ModelAndView intoTicketFormPage()
    {
        return new ModelAndView("/businessconfig/ticketform/list");
    }

    /**
     * 查询号票模板
     */
    @RequestMapping(value = "/businessconfig/ticketform", method = RequestMethod.GET,  headers = "accept=application/json")
    @ResponseBody
    public List<Map<String, Object>> getTicketFormPage(TicketFormModel model)
    {
    	List<Map<String, Object>> list = ticketFormService.selectTicketForm(model);
    	return list;
    }
    
    /**
     * 新增号票模板
     */
    @RequestMapping(value = "/businessconfig/ticketform" ,params="ftype=add", method = RequestMethod.GET,  headers = "accept=application/json")
    @ResponseBody
    public JsonResult addTicketForm(TicketFormModel model){
    	String errorCode = ticketFormService.addTicketForm(model);
    	return JsonResult.json(errorCode);
    }
    
    /**
     * 编辑号票模板
     */
    @RequestMapping(value = "/businessconfig/ticketform" ,params="ftype=update", method = RequestMethod.GET,  headers = "accept=application/json")
    @ResponseBody
    public JsonResult updateTicketForm(TicketFormModel model){
    	String errorCode = ticketFormService.updateTicketForm(model);
    	return JsonResult.json(errorCode);
    }
    
    /**
     * 删除号票模板
     */
    @RequestMapping(value="/businessconfig/ticketform",params="ftype=delete",method = RequestMethod.GET,  headers = "accept=application/json") 
    @ResponseBody
    public JsonResult deleteTicketform(TicketFormModel model){
    	String errorCode = ticketFormService.deleteTicketForm(model);
    	return JsonResult.json(errorCode);
    }
    
    /**
     * 号票预览
     */
    @RequestMapping(value="/businessconfig/ticketform",params="ftype=preview",method = RequestMethod.GET,  headers = "accept=application/json") 
    @ResponseBody
    public JsonResult previewTicketform(TicketFormModel model){
    	String tktTmpStyle = ticketFormService.previewTicketform(model);
    	return JsonResult.json(tktTmpStyle);
    }
    
    /**
     * 进入号票定制页面
     */
    @RequestMapping(value="/businessconfig/ticketform/edit", method = RequestMethod.GET)
    public ModelAndView intoTicketFormEditPage(){
        return new ModelAndView("/businessconfig/ticketform/edit");
    }
    
    /**
     * 根据ID查询单条号票数据
     */
    @RequestMapping(value="/businessconfig/ticketform/edit",params="ftype=select",method = RequestMethod.GET,  headers = "accept=application/json")
    @ResponseBody
    public Map<String, Object> selectOneTicketform(TicketFormModel model){
    	Map<String, Object> map = ticketFormService.selectOneTicketForm(model);
    	return map;
    }
    
    
    /**
     * 保存号票样式
     */
    @RequestMapping(value="/businessconfig/ticketform/saveconfig",method = RequestMethod.POST,  headers = "accept=application/json") 
    @ResponseBody
    public JsonResult saveTicketform(@RequestBody Map<String, Object> map){
    	//add by tianjm 20181113
    	String mapString = map.toString();
    	String[] Symbol = {"<",">","#","$"};
    	boolean hefa = false;
    	for (String check : Symbol) {
			if(mapString.contains(check)){
				hefa = true;
				break;
			}
		}
    	if(hefa){
    		return JsonResult.json("1");
    	}
    	String tktTmpStyle = ticketFormService.saveTicketform(map);
    	return JsonResult.json(tktTmpStyle);
    }
    
    /**
     * 保存号票（导航使用）
     */
    @RequestMapping(value="/businessconfig/ticketform/addnavticket",method = RequestMethod.POST,  headers = "accept=application/json") 
    @ResponseBody
    public JsonResult saveNavTicketform(@RequestBody Map<String, Object> map){
    	//add by tianjm 20181113
    	String mapString = map.toString();
    	String[] Symbol = {"<",">","#","$"};
    	boolean hefa = false;
    	for (String check : Symbol) {
			if(mapString.contains(check)){
				hefa = true;
				break;
			}
		}
    	if(hefa){
    		return JsonResult.json("1");
    	}
    	
    	String errorCode = ticketFormService.addTicketFormFormNav(map);
    	return JsonResult.json(errorCode);
    }
    
    /**
     * 号票模板 应用到下级机构
     * @param model
     * @return
     */
    @RequestMapping(value = "/businessconfig/copyticketform", method = RequestMethod.POST)
    @ResponseBody
    public JsonResult copyCustRecognition(TicketFormModel model){
    	String errorCode = ticketFormService.callCopyTicketProc(model);
    	return JsonResult.json(errorCode);
    }
    
}
