package com.aoto.iqms.basicconfig.service.inf;

import java.util.List;
import java.util.Map;

import com.aoto.iqms.basicconfig.models.NearModel;
import com.aoto.iqms.basicconfig.models.ParameterModel;

/**
 * 临近网点管理
 * @author zhousj
 *
 */
public interface NearService {
	/**
	 * 调用存储过程 查询
	 * @return
	 */
    public List<Map<String, Object>> callNear(String orgId);
    
    /**
     * 调用存储过程进行修改和保存
     * @param map
     */
    public String callSaveOrUpdateNear(NearModel model);
    
    /**
     * 调用存储过程查询sysorg表
     * @param map
     * @return
     */
    public List<Map<String, Object>> callOrg();
    
    /**
     * 调用存储过程进行清空操作
     * @param orgId
     * @return
     */
    public String callRemoveNear(String orgId);
    
    /**
     * 调用存储过程查询临近网点信息到客户端
     * @param orgId
     * @return
     */
    public String createNearsJson(String orgId,String transCode);
    
}
