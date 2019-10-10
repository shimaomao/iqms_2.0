package com.aoto.iqms.basicconfig.persistence.inf;

import java.util.List;
import java.util.Map;

/**
 * 预约配置 持久化
 * @author zhousj
 *
 */
public interface OrderConfigMapper {
	/**
	 * 调用存储过程进行分页数据查询
	 * @param map
	 * @return
	 */
    public List<Map<String, Object>> callPageOrderConfig(Map<String, Object> map);
    
    /**
     * 调用存储过程增加记录
     * @param map
     */
    public void callInsertOrderConfig(Map<String, Object> map);
    
    /**
     * 调用存储过程更新记录
     * @param map
     */
    public void callUpdteOrderConfig(Map<String, Object> map);
    
    /**
     * 执行存储过程进行删除操作
     * @param map
     */
    public void callDeleteOrderConfig(Map<String, Object> map);
    
    /**
     * 执行存储过程应用到下级机构
     * @param map
     */
    public void callCopyOrderConfig(Map<String, Object> map);
    /**
     * 根据机构号和预约时间查询
     * @param map
     * @return
     */
    public List<Map<String, Object>> findOrderRange(Map<String, Object> map);
    
    /**
     * 根据设备号查询预约所需业务信息
     * @param map
     * @return
     */
    public List<Map<String, Object>> findBusiness(Map<String, Object> map);
    
    /**
     * 是否可以预约
     * @param map
     */
    public void callExistBook(Map<String, Object> map);
    
    /**
     * 判断激活码是否可用
     * @param map
     */
    public void callExistActNo(Map<String, Object> map);
    
    /**
     * 增加预约记录
     * @param map
     */
    public void callInsertOrderInfo(Map<String, Object> map);
    
    /**
     * 查询激活码的状态信息
     * @param map
     */
    public List<Map<String, Object>> callQueryActNoStatus(Map<String, Object> map);
    
    /**
     * 预约取消接口
     * @param map
     */
    public void callBookCancel(Map<String, Object> map);
    
    /**
     *预约激活 查询预约信息
     * @param map
     */
    public List<Map<String, Object>> callQueryOrderInfo(Map<String, Object> map);
    
    /**
     * 修改预约状态为已激活
     * @param map
     */
    public void callUpdateOrderInfo(Map<String, Object> map);
}
