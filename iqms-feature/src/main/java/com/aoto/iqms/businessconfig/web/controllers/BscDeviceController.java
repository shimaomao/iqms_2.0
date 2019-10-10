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
import com.aoto.framework.commons.pagination.PagingCriteria;
import com.aoto.framework.commons.userdetails.CurrentUserHolder;
import com.aoto.iqms.basicconfig.service.inf.ParameterService;
import com.aoto.iqms.businessconfig.models.BscCustLevelModel;
import com.aoto.iqms.businessconfig.models.BscDeviceModel;
import com.aoto.iqms.businessconfig.models.BscDeviceQuery;
import com.aoto.iqms.businessconfig.service.inf.BscDeviceService;

/**
 * 设备控制层
 * @author daxian
 *
 */
@Controller
public class BscDeviceController {
	
	@Autowired
	private BscDeviceService bscDeviceService;  //注入业务层对象
	@Autowired
	private ParameterService parameterService;
	
	/**
     * 进入设备管理页面
     * @author daxian
     */
    @RequestMapping(value = "/businessconfig/bscdevice", method = RequestMethod.GET)
    public ModelAndView intoDevicePage()
    {
        return new ModelAndView("businessconfig/bscdevice/list");
    }
    
    
    /**
     * 设备管理分页功能。
     * @param model
     * @return
     */
    @RequestMapping(value = "/businessconfig/bscdevice", method = RequestMethod.GET,  headers = "accept=application/json")
    @ResponseBody
    public JsonResult getDevicePageList(BscDeviceQuery model){
    	PagingCriteria pagingCriteria = new PagingCriteria(model.getPage() - 1, model.getRows(), model.getSort(),
                model.getOrder());
    	List<Map<String, Object>> list = bscDeviceService.procPageBscDevice(pagingCriteria, model);//调用存储过程进行分页
    	return JsonResult.json(model.getRows(), model.getPage(), pagingCriteria.getTotal(), list);
    }
    
    
    /**
     * 导航配置创建设备。
     * @param model
     * @return
     */
    @RequestMapping(value = "/businessconfig/bscdevice", method = RequestMethod.POST)
    @ResponseBody
    public JsonResult createDevice(BscDeviceModel model){
    	String errorCode = bscDeviceService.callCreateBscDeviceProc(model);
    	return JsonResult.json(errorCode);
    }
    
    /**
     * 设备管理新增。
     * @param model
     * @return
     */
    @RequestMapping(value = "/businessconfig/bscdevice/navcreate", method = RequestMethod.POST)
    @ResponseBody
    public JsonResult createNavDevice(BscDeviceModel model){
    	String errorCode = bscDeviceService.callCreateNavDeviceProc(model);
    	return JsonResult.json(errorCode);
    }
    
    /**
     * 设备管理编辑
     * @param model
     * @return
     */
    @RequestMapping(value = "/businessconfig/bscdevice", method = RequestMethod.PUT)
    @ResponseBody
    public JsonResult editDevice(BscDeviceModel model)
    {
    	String errorCode = bscDeviceService.callUpdateBscDeviceProc(model);
    	return JsonResult.json(errorCode);
    }
    
    /**
     * 20151102 by hongxz 查询机构下的设备数量
     * @param model
     * @return
     */
    @RequestMapping(value = "/businessconfig/bscdevicecount", method = RequestMethod.GET)
    @ResponseBody
    public JsonResult searchDevCounts(BscDeviceModel model)
    {
    	Map<String, Object> list = bscDeviceService.findDevCount(model);
    	return JsonResult.json(list);
    }
    
    
    
    /**
     * 设备管理删除
     * @param list
     * @return
     */
    @RequestMapping(value = "/businessconfig/bscdevice", method = RequestMethod.DELETE)
    @ResponseBody
    public JsonResult removeDevice(@RequestBody List<Map<String, String>> list)
    {
    	String errorCode = bscDeviceService.callRemoveBscDeviceProc(list);
        return JsonResult.json(errorCode);
    }
    
    
    
    
    /**
     * 进入终端配置页面
     * @author daxian
     */
    @RequestMapping(value = "/businessconfig/deviceconfig", method = RequestMethod.GET)
    public ModelAndView intoDeviceConfigPage()
    {
        return new ModelAndView("businessconfig/deviceconfig/list");
    }
    
    /**
     * 终端管理数据查询。
     * @param model
     * @return
     */
    @RequestMapping(value = "/businessconfig/deviceconfig", method = RequestMethod.GET,  headers = "accept=application/json")
    @ResponseBody
    public JsonResult getInfoDevicePageList(BscDeviceQuery model){
    	PagingCriteria pagingCriteria = new PagingCriteria(model.getPage() - 1, model.getRows(), model.getSort(),
                model.getOrder());
    	List<Map<String, Object>> list = bscDeviceService.procPageBscDevice(pagingCriteria, model);//调用存储过程进行分页
    	return JsonResult.json(pagingCriteria.getTotal(), list);
    }
    
    @RequestMapping(value = "/businessconfig/ztreeorgdevice", method = RequestMethod.GET,  headers = "accept=application/json")
    @ResponseBody
    public JsonResult ztreeOrgDevice(String orgId){
    	List<Map<String, Object>> list = bscDeviceService.ztreeOrgDevice(orgId);
    	return JsonResult.json(0, list);
    }
    @RequestMapping(value = "/businessconfig/ztreefastcopy", method = RequestMethod.GET,  headers = "accept=application/json")
    @ResponseBody
    public JsonResult ztreeFastCopy(String orgId,String deviceNo){
    	List<Map<String, Object>> list = bscDeviceService.ztreeFastCopy(orgId, deviceNo);
    	return JsonResult.json(0, list);
    }
    
    /**
     * tree：查询设备树
     * @param model
     * @return
     */
    @RequestMapping(value = "/businessconfig/deviceconfig/devtree", method = RequestMethod.GET,  headers = "accept=application/json")
    @ResponseBody
    public Object getInfoDevice4Tree(BscDeviceQuery model){
//    	int orgId = CurrentUserHolder.getCurrentUser().getOrgId();
//    	model.setOrgId(orgId+"");
    	//model.setOrgId("1");
    	List<Map<String, Object>> list = bscDeviceService.findBscDevice4TreeByConditon(model);//调用存储过程进行分页
    	return list;
    }
    
    /**
     * 应用到下级机构
     * @param model
     * @return
     */
    @RequestMapping(value = "/businessconfig/bscdevice/copy", method = RequestMethod.POST)
    @ResponseBody
    public JsonResult copy(BscDeviceQuery model){
    	String errorCode = bscDeviceService.callSaveCopyProc(model);
    	return JsonResult.json(errorCode);
    }
    
    /**
     * 快速应用
     * @param model
     * @return
     */
    @RequestMapping(value = "/businessconfig/bscdevice/fastcopy", method = RequestMethod.POST)
    @ResponseBody
    public JsonResult fastCopy(BscDeviceQuery model){
    	String errorCode = bscDeviceService.callSaveFastCopy(model);
    	return JsonResult.json(errorCode);
    }
    
    /**
     * 生成设备号
     * @param model
     * @return
     */
    @RequestMapping(value = "/businessconfig/getDevice", method = RequestMethod.POST,  headers = "accept=application/json")
    @ResponseBody
    public JsonResult createDeviceNo(BscDeviceModel model){
    	String deviceNo = bscDeviceService.createDeviceNo(model);
    	return JsonResult.json(deviceNo);
    }
    /**
     * 导航中号票模板 中用于选择设备的组织树（设备必须包含默认号票模板）
     * @param orgId
     * @return
     */
    @RequestMapping(value = "/businessconfig/bscdevice/ztreeforticket", method = RequestMethod.GET,  headers = "accept=application/json")
    @ResponseBody
    public JsonResult ztreeForTicket(String orgId){
    	List<Map<String, Object>> list = bscDeviceService.ztreeForTicket(orgId);
    	return JsonResult.json(0, list);
    }
    
    /**
     * 获取厂商加载到页面下拉框
     * @return
     */
    /*@RequestMapping(value = "/businessconfig/getProducer", method = RequestMethod.GET, headers = "accept=application/json")
    @ResponseBody
    public JsonResult getProducer(){
        List<Map<String, Object>> list = parameterService.callSysDicQuery("suppliers");//sys_dic里配置的dic_type
        return JsonResult.json(list.size(), list);
    }*/
}
