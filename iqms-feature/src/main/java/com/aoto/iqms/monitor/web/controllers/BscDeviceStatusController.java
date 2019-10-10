package com.aoto.iqms.monitor.web.controllers;

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
import com.aoto.iqms.monitor.models.BscDeviceStatusQuery;
import com.aoto.iqms.monitor.service.inf.BscDeviceStatusService;

/**
 * 设备监控控制层
 * @author zhousj
 *
 */
@Controller
public class BscDeviceStatusController {
	@Autowired
	private BscDeviceStatusService deviceStatusService;
	
	/**
	 * 进入设备监控页面
	 * @return
	 */
	@RequestMapping(value ="/monitor/bscdevicestatus", method = RequestMethod.GET)
	public ModelAndView enterBscDeviceStatusPage(){
		return new ModelAndView("/monitor/bscdevicestatus/list");
	}
	
	/**
	 * 设备监控页面分页查询
	 * @param model
	 * @return
	 */
	@RequestMapping(value ="/monitor/bscdevicestatus", method = RequestMethod.GET, headers = "accept=application/json")
	@ResponseBody
	public JsonResult getBscDeviceStatusPageList(BscDeviceStatusQuery model){
		PagingCriteria pagingCriteria = new PagingCriteria(model.getPage()-1, model.getRows(), model.getSort(), model.getOrder());
		List<Map<String, Object>> list = deviceStatusService.procPageDeviceStatus(pagingCriteria, model);
		return JsonResult.json(model.getRows(), model.getPage(), pagingCriteria.getTotal(), list);
	}
	
	/**
     * 查询详情功能。
     * @param model
     * @return
     */
    @RequestMapping(value = "/monitor/bscdevicestatus/getBscDeviceStatus", method = RequestMethod.GET,  headers = "accept=application/json")
    @ResponseBody
    public JsonResult getBscDeviceStatusList(String orgId, String deviceNo){
    	
        List<Map<String, Object>> list = deviceStatusService.procShowDevicesStatus(orgId, deviceNo);//调用存储过程进行查询
    	return JsonResult.json(list.get(0));
    }
}
