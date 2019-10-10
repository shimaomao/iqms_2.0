package com.aoto.iqms.businessconfig.persistence.inf;
import java.util.List;
import java.util.Map;

import com.aoto.iqms.businessconfig.models.BscBranchBusinessQuery;
/**
 * 网点业务持久层
 * @author zhousj
 *
 */
public interface BscBranchBusinessMapper {
	
	/**
	 * 调用存储过程生成以菜单和业务为根节点的组织树
	 * @return
	 */
	public List<Map<String, Object>> callTreeMenuBusiness(Map<String, Object> map);
	
	/**
	 * 调用存储过程查询网点业务表数据
	 * @param map
	 * @return
	 */
	public List<Map<String, Object>> callBranchBusiness(Map<String, Object> map);
	
	 /**
     * 调用存储过程增加记录
     * @param map
     */
    public void callInsertBscBranchBus(Map<String, Object> map);
    
    /**
     * 调用存储过程更新记录
     * @param map
     */
    public void callUpdteBscBranchBus(Map<String, Object> map);
    
    /**
     * 执行存储过程进行删除操作
     * @param map
     */
    public void callDeleteBscBranchBus(Map<String, String> map);
    
    /**
     * 执行存储过程应用到下级机构
     * @param map
     */
    public void callCopyBscBranchBus(Map<String, Object> map);
    
    /**
     * 执行存储过程生成buzType.json
     * @param model
     * @return
     */
    public List<Map<String, Object>> callBuzType(Map<String, Object> map);
    /**
     * 执行存储过程查询 设备下所有业务 不含菜单
     * @param model
     * @return
     */
    public List<Map<String, Object>> callBuz(Map<String, Object> map);
    
    /**
     * 根据pid查询节点的层级
     * @param map
     * @return
     */
    public List<Map<String, Object>> callLevel(Map<String, Object> map);
    
    /**
     * 查询设备下的所有业务
     * @param map
     * @return
     */
    public List<Map<String, Object>> callBusiness(Map<String, Object> map);
    
    /**
     * 厅堂易请求查询业务相关信息
     * @param map
     * @return
     */
    public List<Map<String, Object>> findBusysForHallMarket(Map<String, Object> map);
    
}
