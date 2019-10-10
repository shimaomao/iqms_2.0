package com.aoto.iqms.businessconfig.web.controllers;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.aoto.iqms.basicconfig.models.TakeModelModel;
import com.aoto.iqms.businessconfig.commons.constant.BusinessconfigBeanProperty.BscDevice;
import com.aoto.iqms.businessconfig.models.BscDeviceQuery;
import com.aoto.iqms.businessconfig.models.TicketFormModel;
import com.aoto.iqms.businessconfig.service.inf.BscDeviceService;
import com.aoto.iqms.businessconfig.service.inf.TakeConfigService;
import com.aoto.iqms.businessconfig.service.inf.TicketFormService;

/**
 * 导航配置控制层
 * @author zhousj
 *
 */
@Controller
public class NavConfigController {
	@Autowired
	private BscDeviceService bscDeviceService;
	
	@Autowired
	private TakeConfigService takeConfigService;
	
	@Autowired
	private TicketFormService ticketFormService;
	
	
	/**
	 * 进入导航配置页面 创建设备
	 * @return
	 */
	@RequestMapping(value = "/businessconfig/navconfig", method = RequestMethod.GET)
	public ModelAndView enterCreateDevice(){
		return new ModelAndView("/businessconfig/navconfig/device");
	}
	
	/**
	 * 进入导航配置页面 快速应用
	 * @return
	 */
	@RequestMapping(value = "/businessconfig/navconfig/copyToOrg", method = RequestMethod.GET)
	@ResponseBody
	public ModelAndView enterCopy(BscDeviceQuery model){
		ModelAndView mov = new ModelAndView("/businessconfig/navconfig/copy");
		mov.getModel().put(BscDevice.ORG_ID, model.getOrgId());
		mov.getModel().put(BscDevice.DEVICE_NO, model.getDeviceNo());
		return mov;
	}
	
	/**
	 * 从快速应用返回创建设备
	 * @return
	 */
	@RequestMapping(value = "/businessconfig/navconfig/backdevice", method = RequestMethod.GET)
	@ResponseBody
	public ModelAndView backDevice(BscDeviceQuery model){
		List<Map<String, Object>> list = bscDeviceService.findByDeviceNo(model);
		ModelAndView mov = new ModelAndView("/businessconfig/navconfig/device");
		mov.getModel().put(BscDevice.ORG_ID, list.get(0).get("orgId"));
		mov.getModel().put(BscDevice.DEVICE_NO, list.get(0).get("deviceNo"));
		mov.getModel().put(BscDevice.HOST_NAME, list.get(0).get("hostName"));
		mov.getModel().put(BscDevice.IP_ADDR, list.get(0).get("ipAddr"));
		mov.getModel().put(BscDevice.MAC_ADDR, list.get(0).get("macAddr"));
		mov.getModel().put(BscDevice.PRODUCER, list.get(0).get("producer"));
		mov.getModel().put(BscDevice.SCREEN_RESOLUTION, list.get(0).get("screenResolution"));
		mov.getModel().put(BscDevice.INSTALL_DATE, list.get(0).get("installDate"));
		mov.getModel().put(BscDevice.ADMIN_NAME, list.get(0).get("adminName"));
		mov.getModel().put(BscDevice.ADMIN_PHONE, list.get(0).get("adminPhone"));
		mov.getModel().put(BscDevice.ORDER_FLAG, list.get(0).get("orderFlag"));
		mov.getModel().put(BscDevice.ONLINE_MODEL, list.get(0).get("onlineModel"));
		mov.getModel().put(BscDevice.TPSCROLL_FLAG, list.get(0).get("tpscrollFlag"));
		mov.getModel().put("orgName", list.get(0).get("orgName"));
		mov.getModel().put("devNo", list.get(0).get("deviceNo"));
		return mov;
	}
	
	/**
	 * 进入导航配置页面 窗口配置
	 * @return
	 */
	@RequestMapping(value = "/businessconfig/navconfig/winconfig", method = RequestMethod.GET)
	@ResponseBody
	public ModelAndView enterWinConfig(BscDeviceQuery model){
		ModelAndView mov = new ModelAndView("/businessconfig/navconfig/winconfig");
		mov.getModel().put(BscDevice.ORG_ID, model.getOrgId());
		mov.getModel().put(BscDevice.DEVICE_NO, model.getDeviceNo());
		/*mov.getModel().put("orgName", model.getOrgName());
		mov.getModel().put("devName", model.getDevName());*/
		return mov;
	}
	
	/**
	 * 进入导航配置页面 网点业务
	 * @return
	 */
	@RequestMapping(value = "/businessconfig/navconfig/branchbus", method = RequestMethod.GET)
	@ResponseBody
	public ModelAndView enterBranchBus(BscDeviceQuery model){
		ModelAndView mov = new ModelAndView("/businessconfig/navconfig/branchbus");
		mov.getModel().put(BscDevice.ORG_ID, model.getOrgId());
		mov.getModel().put(BscDevice.DEVICE_NO, model.getDeviceNo());
		/*mov.getModel().put("orgName", model.getOrgName());
		mov.getModel().put("devName", model.getDevName());*/
		return mov;
	}
	
	/**
	 * 进入导航配置页面 业务显示
	 * @return
	 */
	@RequestMapping(value = "/businessconfig/navconfig/showtime", method = RequestMethod.GET)
	@ResponseBody
	public ModelAndView enterShowTime(BscDeviceQuery model){
		ModelAndView mov = new ModelAndView("/businessconfig/navconfig/showtime");
		mov.getModel().put(BscDevice.ORG_ID, model.getOrgId());
		mov.getModel().put(BscDevice.DEVICE_NO, model.getDeviceNo());
		/*mov.getModel().put("orgName", model.getOrgName());
		mov.getModel().put("devName", model.getDevName());*/
		return mov;
	}
	
	/**
	 * 进入导航配置页面 客户等级
	 * @return
	 */
	@RequestMapping(value = "/businessconfig/navconfig/custlevel", method = RequestMethod.GET)
	@ResponseBody
	public ModelAndView enterCustLevel(BscDeviceQuery model){
		ModelAndView mov = new ModelAndView("/businessconfig/navconfig/custlevel");
		mov.getModel().put(BscDevice.ORG_ID, model.getOrgId());
		mov.getModel().put(BscDevice.DEVICE_NO, model.getDeviceNo());
		/*mov.getModel().put("orgName", model.getOrgName());
		mov.getModel().put("devName", model.getDevName());*/
		return mov;
	}
	
	/**
	 * 进入导航配置页面 客户识别
	 * @return
	 */
	@RequestMapping(value = "/businessconfig/navconfig/recognition", method = RequestMethod.GET)
	@ResponseBody
	public ModelAndView enterRecoginton(BscDeviceQuery model){
		ModelAndView mov = new ModelAndView("/businessconfig/navconfig/recognition");
		mov.getModel().put(BscDevice.ORG_ID, model.getOrgId());
		mov.getModel().put(BscDevice.DEVICE_NO, model.getDeviceNo());
		/*mov.getModel().put("orgName", model.getOrgName());
		mov.getModel().put("devName", model.getDevName());*/
		return mov;
	}
	
	/**
	 * 进入导航配置页面 叫号策略
	 * @return
	 */
	@RequestMapping(value = "/businessconfig/navconfig/callstrategy", method = RequestMethod.GET)
	@ResponseBody
	public ModelAndView enterCallStrategy(BscDeviceQuery model){
		ModelAndView mov = new ModelAndView("/businessconfig/navconfig/callstrategy");
		mov.getModel().put(BscDevice.ORG_ID, model.getOrgId());
		mov.getModel().put(BscDevice.DEVICE_NO, model.getDeviceNo());
		return mov;
	}
	
	/**
	 * 进入导航配置页面 号票模板ticketform
	 * @return
	 */
	@RequestMapping(value = "/businessconfig/navconfig/ticketform", method = RequestMethod.GET)
	@ResponseBody
	public ModelAndView enterTicketForm(TicketFormModel model){
		ModelAndView mov = new ModelAndView("/businessconfig/navconfig/ticketform");
		mov.getModel().put("orgId", model.getOrgId());
		mov.getModel().put("deviceNo", model.getDeviceNo());
		//查询是否有默认模板(默认模板信息下发到页面)
		List<Map<String, Object>> devDefTickets = ticketFormService.navDefDevTicketfrom(model);
		if (devDefTickets != null && devDefTickets.size() > 0) {
			Map<String, Object> map = devDefTickets.get(0);
			mov.getModel().put("orgId", map.get("orgId"));
			mov.getModel().put("deviceNo", map.get("deviceNo"));
			mov.getModel().put("screenResolution", map.get("screenResolution"));
			mov.getModel().put("tktTmpId", map.get("tktTmpId"));
			mov.getModel().put("tktTmpName", map.get("tktTmpName"));
			mov.getModel().put("def", map.get("def"));
			mov.getModel().put("tktFormatId", map.get("tktFormatId"));
		}
		
		return mov;
	}
	
	/**
	 * 导航配置-取号界面
	 * @return
	 */
	@RequestMapping(value = "/businessconfig/navconfig/queueface", method = RequestMethod.GET)
	public ModelAndView entryQueueface(TakeModelModel model){
		ModelAndView mov = new ModelAndView("/businessconfig/navconfig/queueface");
		
		
		mov.getModel().put("orgId", model.getOrgId());
		mov.getModel().put("deviceNo", model.getDeviceNo());
		List<Map<String, Object>> queueModelList = takeConfigService.navQueuefaceModel(model);
		
		if (queueModelList != null && queueModelList.size() > 0) {
			Map<String, Object> devQueueMap = queueModelList.get(0);
			
			mov.getModel().put("styleId", devQueueMap.get("styleId")); //模板id
			mov.getModel().put("styleName", devQueueMap.get("styleName")); //模板名称
			mov.getModel().put("orgId", devQueueMap.get("orgId")); //机构id
			mov.getModel().put("deviceNo", devQueueMap.get("deviceNo")); //设备号
			mov.getModel().put("deviceName", devQueueMap.get("hostName")); //设备名称
			mov.getModel().put("screenResolution", devQueueMap.get("screenResolution")); //屏幕分辨率
			mov.getModel().put("def", devQueueMap.get("def")); //是否默认模板
		}
		
		return mov;
	}
	
	
	/**
	 * 进入导航配置页面 配置检测
	 * @return
	 */
	@RequestMapping(value = "/businessconfig/navconfig/check", method = RequestMethod.GET)
	@ResponseBody
	public ModelAndView enterCheck(BscDeviceQuery model){
		ModelAndView mov = new ModelAndView("/businessconfig/navconfig/check");
		mov.getModel().put(BscDevice.ORG_ID, model.getOrgId());
		mov.getModel().put(BscDevice.DEVICE_NO, model.getDeviceNo());
		return mov;
	}
}
