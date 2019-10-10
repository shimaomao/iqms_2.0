package com.aoto.iqms.businessconfig.service.inf;

import java.util.List;
import java.util.Map;

import com.aoto.iqms.businessconfig.models.SysOrgExtendModel;

public interface SysOrgExtendService {
	/**
     * 删除机构并级联删除设备
     * @param model
     * @return
     */
    public String callRemoveOrgExtend(String OrgId);
    
    /**
     * 根据orgId查询
     * @param OrgId
     * @return
     */
    public SysOrgExtendModel findOrgByOrgId(String OrgId);
}
