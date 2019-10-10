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
import com.aoto.iqms.businessconfig.service.inf.AdPublishService;

/**
 * 广告发布
 * @author humz
 *
 */
@Controller
public class AdPublishController {
	
	@Autowired
	private AdPublishService adPublishService;
	
	/**
	 * 点击界面上的菜单，里面已经设置好请求url地址，这里映射该url即可进入页面
	 */
	@RequestMapping(value = "/businessconfig/adpublish", method = RequestMethod.GET)
	public ModelAndView intoAdPublish(){
		return new ModelAndView("/businessconfig/adpublish/list");
	}
	
	/**
	 * 根据设备查询广告
	 */
	@RequestMapping(value="/businessconfig/adpublish/selectByDeviceNo",method = RequestMethod.POST, headers = "accept=application/json")
	@ResponseBody
	public List<Map<String, Object>> selectAdsByDeviceNo(@RequestBody Map<String, Object> map){
		List<Map<String, Object>> list = adPublishService.selectAdsByDeviceNo(map);
		return list;
	}
	
	/**
	 * 保存并发送广告
	 */
	@RequestMapping(value="/businessconfig/adpublish/saveandsend",method = RequestMethod.POST, headers = "accept=application/json")
	@ResponseBody
	public JsonResult saveAndSend(@RequestBody Map<String, Object> map){
		//adPublishService.sendAds(map);
		String errorCode = adPublishService.saveAds(map);
		return JsonResult.json(errorCode);
	}
}
