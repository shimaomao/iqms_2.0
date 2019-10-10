package com.aoto.iqms.businessconfig.persistence.inf;

import java.util.List;
import java.util.Map;

import com.aoto.iqms.businessconfig.models.BscShowTimeQuery;

/**
 * 业务显示时间持久层
 * @author zhousj
 *
 */
public interface BscShowTimeMapper {
	/**
	 * 调用存储过程查询
	 * @param map
	 * @return
	 */
	public List<Map<String, Object>> callshowTimeQuery(Map<String, Object> map);
	
	/**
	 * 调用存储过程 保存
	 * @param map
	 * @return
	 */
	public void callInsertBscShowTime(Map<String, Object> map);
	
	/**
     * 执行存储过程进行删除操作
     * @param map
     */
    public void callDeleteShowTime(Map<String, Object> map);
    
    /**
     * 执行存储过程应用到下级机构
     * @param map
     */
    public void callCopyShowTime(Map<String, Object> map);
    
    /**
     * 执行存储过程判断相应机构号和设备号 数据是否存在 
     * @param map
     */
    public String callIsExistShowTime(Map<String, Object> map);
    
    /**
     * 执行存储过程生成buzTimes.json
     * @param model
     * @return
     */
    public List<Map<String, Object>> callBuzTimes(Map<String, Object> map);
    
    /**
     * 一键检测：业务及业务时间检测
     * @param map
     * @return
     */
    public List<Map<String, Object>> checkedBuzTime(Map<String, Object> map);
    /**
     * 根据orgId,deviceNo,busId,dateType查询
     * @param map
     * @return
     */
    public List<Map<String, Object>> findShowTime(Map<String, Object> map);
    
}
