package com.aoto.iqms.basicconfig.service.inf;

import java.util.List;
import java.util.Map;

import com.aoto.iqms.basicconfig.models.ParameterModel;


/**
 * 参数配置
 * @author zhousj
 *
 */
public interface ParameterService {
	/**
	 * 调用存储过程查询数据
	 * @param map
	 * @return
	 */
    public List<Map<String, Object>> callParameter();
    
    /**
     * 调用存储过程进行修改和保存
     * @param map
     */
    public String callSaveOrUpdateParameter(ParameterModel model);
    
    /**
     * 调用存储过程查询字典表(SYS_DIC)
     * @param map
     * @return
     */
    public List<Map<String, Object>> callSysDicQuery(String dicType);
}
