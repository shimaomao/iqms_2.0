package com.aoto.iqms.businessconfig.persistence.inf;

import java.util.List;
import java.util.Map;

public interface SysOrgExtendMapper {
	/**
     * 执行存储过程进行删除操作 返回机构下所有设备号
     * @param map
     */
    public String callDeleteOrgExtend(Map<String, Object> map);
    
    public List<Map<String, Object>> findOrgByOrgId(Map<String, Object> map);
}
