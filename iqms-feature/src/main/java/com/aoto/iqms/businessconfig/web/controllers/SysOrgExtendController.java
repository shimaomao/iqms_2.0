package com.aoto.iqms.businessconfig.web.controllers;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.aoto.framework.commons.beans.JsonResult;
import com.aoto.framework.security.service.inf.OrgService;
import com.aoto.iqms.businessconfig.service.inf.SysOrgExtendService;

/**
 * 机构的扩展控制类
 * @author zhousj
 *
 */
@Controller
public class SysOrgExtendController {
	@Autowired
	private SysOrgExtendService orgExtendService;
	@Autowired
    protected OrgService orgService;
	/**
     * 删除机构
     * @param list
     * @return
     */
    @RequestMapping(value = "/system/orgs/extendDel/{orgId}", method = RequestMethod.DELETE)
    @ResponseBody
    public JsonResult removeMenu(@PathVariable String orgId){
    	orgService.removeOrg(Integer.parseInt(orgId));
    	String errorCode = orgExtendService.callRemoveOrgExtend(orgId);
    	return JsonResult.json(errorCode);
    }
    
    
}
