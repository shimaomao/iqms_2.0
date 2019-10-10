package com.aoto.iqms.businessconfig.web.controllers;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.aoto.framework.commons.beans.JsonResult;
import com.aoto.iqms.basicconfig.service.inf.BusinessManageService;
import com.aoto.iqms.businessconfig.models.BscBranchBusinessModel;
import com.aoto.iqms.businessconfig.models.BscBranchBusinessQuery;
import com.aoto.iqms.businessconfig.service.inf.BscBranchBusinessService;

/**
 * 网点业务控制层
 * @author zhousj
 *
 */
@Controller
public class BscBranchBusinessController {
	@Autowired
	private BscBranchBusinessService branchBusinessService;
	@Autowired
	private BusinessManageService busManageService;
	
	@RequestMapping(value = "/businessconfig/bscbranchbus", method = RequestMethod.GET)
	public ModelAndView enterBranchBusiness(){
		return new ModelAndView("/businessconfig/bscbranchbus/list");
	}
	/**
	 * 查询BscBranchBusiness表 加载 网点业务 组织树
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/businessconfig/branchBusTree", method = RequestMethod.GET,  headers = "accept=application/json")
    @ResponseBody
    public JsonResult getBranchBusTreeList(BscBranchBusinessQuery model){
		if(model.getOrgId() == null || model.getOrgId()==""){
    		model.setOrgId("0");
    	}
		if(model.getTreeId() == null || model.getTreeId()==""){
    		model.setTreeId("-1");
    	}
		List<Map<String, Object>> list = branchBusinessService.procBrancBusinessTree(model);
		return JsonResult.json(0, list);
	}
	
	/**
	 * 点击组织树 查询业务对应的数据
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/businessconfig/bscbranchbus", method = RequestMethod.GET,  headers = "accept=application/json")
    @ResponseBody
    public JsonResult getBranchBusinessList(BscBranchBusinessQuery model){
		if(model.getOrgId() == null || model.getOrgId()==""){
    		model.setOrgId("0");
    	}
		if(model.getTreeId() == null || model.getTreeId()==""){
    		model.setTreeId("-1");
    	}
		List<Map<String, Object>> list = branchBusinessService.procBrancBusiness(model);
		if(list.size()==0){
			list = busManageService.findBusManageById(model.getTreeId());
		}
		return JsonResult.json(0, list);
	}
	
	/**
	 * 加载菜单和业务
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/businessconfig/bscbranchbus/getMenuBusiness", method = RequestMethod.GET,  headers = "accept=application/json")
    @ResponseBody
    public JsonResult getMenuBusinessTree(){
		List<Map<String, Object>> list = branchBusinessService.ztreeMenuBusiness();
		return JsonResult.json(0, list);
	}
	
	/**
     * 网点业务新增。
     * @param model
     * @return
     */
    @RequestMapping(value = "/businessconfig/bscbranchbus", method = RequestMethod.POST)
    @ResponseBody
    public JsonResult createBranchBus(BscBranchBusinessModel model){
    	if(model.getBusinessType()==null || model.getBusinessType().equals("")){
    		return JsonResult.json("1");
    	}
    	if(model.getBusinessType()=="0"){
    		model.setIsShowEn(null);
    		model.setIsSwipe(null);
    	}
    	if(model.getTreePid()==null || model.getTreePid().equals("")){
    		model.setTreePid("0");
    	}
    	String errorCode = branchBusinessService.callCreateBscBranchBusProc(model);
    	return JsonResult.json(errorCode);
    }
    
    /**
     * 网点业务编辑
     * @param model
     * @return
     */
    @RequestMapping(value = "/businessconfig/bscbranchbus", method = RequestMethod.PUT)
    @ResponseBody
    public JsonResult editBranchBus(BscBranchBusinessModel model)
    {
    	String errorCode = branchBusinessService.callUpdateBscBranchBusProc(model);
    	return JsonResult.json(errorCode);
    }
    
    /**
     * 网点业务删除
     * @param list
     * @return
     */
    @RequestMapping(value = "/businessconfig/branchRemove", method = RequestMethod.GET)
    @ResponseBody
    public JsonResult branchbusRemove(String orgId, String deviceNo, String treeId)
    {
    	String errorCode = branchBusinessService.callRemoveBscBranchBusProc(orgId, deviceNo, treeId);
        return JsonResult.json(errorCode);
    }
    
    /**
     * 网点业务 应用到下级机构
     * @param model
     * @return
     */
    @RequestMapping(value = "/businessconfig/copybranchbus", method = RequestMethod.POST)
    @ResponseBody
    public JsonResult copyBranchBus(BscBranchBusinessModel model){
    	String errorCode = branchBusinessService.callCopyBscBranchBus(model);
    	return JsonResult.json(errorCode);
    }
    
    /**
	 * 查询BscBranchBusiness表 获取buzType.json
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/businessconfig/getBuzListZip", method = RequestMethod.GET,  headers = "accept=application/json")
    @ResponseBody
    public JsonResult getBuzListZip(BscBranchBusinessQuery model){
		branchBusinessService.createBuzList(model);
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		return JsonResult.json(0, list);
	}
	
	/**
	 * 查询BscBranchBusiness表 获取设备下的所有业务
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/businessconfig/getBuzList", method = RequestMethod.GET,  headers = "accept=application/json")
    @ResponseBody
    public JsonResult getBuzList(BscBranchBusinessQuery model){
		List<Map<String, Object>> list = branchBusinessService.procBuzQuery(model);
		return JsonResult.json(0, list);
	}
	
	/**
	 * 查询BscBranchBusiness表 获取设备下的所有业务 不包含菜单
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/businessconfig/getBusiness", method = RequestMethod.GET,  headers = "accept=application/json")
    @ResponseBody
    public JsonResult getBuz(BscBranchBusinessModel model){
		List<Map<String, Object>> list = branchBusinessService.procBusiness(model);
		return JsonResult.json(0, list);
	}
}
