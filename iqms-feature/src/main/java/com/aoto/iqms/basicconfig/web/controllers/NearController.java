package com.aoto.iqms.basicconfig.web.controllers;

import java.util.HashMap;
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
import com.aoto.iqms.basicconfig.models.NearModel;
import com.aoto.iqms.basicconfig.service.inf.NearService;

/**
 * 临近网点管理控制层
 * @author zhousj
 *
 */
@Controller
public class NearController {
	@Autowired
	private NearService nearService;
	
	/**
	 * 进入临近网点页面
	 * @return
	 */
	@RequestMapping(value = "/basicconfig/near", method = RequestMethod.GET)
	public ModelAndView enterNearPage(){
	    return new ModelAndView("/basicconfig/near/list");
	}
	/**
	 * 查询临近网点
	 * @param orgId
	 * @return
	 */
	@RequestMapping(value = "/basicconfig/near", method = RequestMethod.GET, headers = "accept=application/json")
	@ResponseBody
	public JsonResult getNearList(String orgId){
		List<Map<String, Object>> list = nearService.callNear(orgId);
		List<Map<String, Object>> orgList = nearService.callOrg();
		Map<String, Object> map = new HashMap<String, Object>();
		for(int i=0; i<orgList.size(); i++){
			map.put(orgList.get(i).get("orgId").toString(), orgList.get(i).get("orgName"));
		}
		list.add(map);
		
		return JsonResult.json(0, list);
	}
	
	/**
	 * 更新和保存临近网点
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/basicconfig/near", method = RequestMethod.POST)
	@ResponseBody
	public JsonResult saveOrUpdateNear(NearModel model){
		String errorCode = nearService.callSaveOrUpdateNear(model);
		return JsonResult.json(errorCode);
	}
    
	/**
	 * 删除临近网点
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/basicconfig/nearRemove", method = RequestMethod.DELETE)
	@ResponseBody
	public JsonResult removeNear(@RequestBody String orgId){
		String errorCode = nearService.callRemoveNear(orgId);
		return JsonResult.json(errorCode);
	}
	
}
