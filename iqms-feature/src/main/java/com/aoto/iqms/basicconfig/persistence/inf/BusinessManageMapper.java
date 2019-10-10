package com.aoto.iqms.basicconfig.persistence.inf;

import java.util.List;
import java.util.Map;

/**
 * 业务管理持久化层接口
 * @author humz
 *
 */
public interface BusinessManageMapper {

	/**
     * 分页查询业务管理
     * @param map
     * @return
     */
    List<Map<String, Object>> selectBusManageByPage(Map<String, Object> map);
    
	/**
     * 调用存储过程进行分页数据查询
     * @param map
     * @return
     */
    public List<Map<String, Object>> callPageBusManage(Map<String, Object> map);
    
    /**
     * 调用存储过程增加记录
     * @param map
     */
    public void callInsertBusManage(Map<String, Object> map);
   
    /**
     * 调用存储过程更新记录
     * @param map
     */
    public void callUpdteBusManage(Map<String, Object> map);
    
    /**
     * 执行存储过程进行删除操作
     * @param map
     */
    public void callDeleteBusManage(Map<String, Object> map);
    
    /**
     * 查询所有
     * @return
     */
    public List<Map<String, Object>> callSelectBusManage(Map<String, Object> map);
    
    /**
     * 业务类型查询
     * @param map
     */
    public List<Map<String, Object>> findBusManageByConditon(Map<String, Object> map);
    
    /**
     * 根据id查询
     * @param map
     * @return
     */
    public List<Map<String, Object>> findBusManageById(Map<String, Object> map);

}
