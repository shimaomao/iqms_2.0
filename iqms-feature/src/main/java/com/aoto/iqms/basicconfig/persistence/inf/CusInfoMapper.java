package com.aoto.iqms.basicconfig.persistence.inf;

import java.util.List;
import java.util.Map;

/**
 * 本地客户持久化层接口
 * @author humz
 *
 */
public interface CusInfoMapper {
    
	/**
     * 调用存储过程进行分页数据查询
     * @param map
     * @return
     */
    public List<Map<String, Object>> callPageCusInfo(Map<String, Object> map);
    
    /**
     * 调用存储过程增加记录
     * @param map
     */
    public void callInsertCusInfo(Map<String, Object> map);
    
    /**
     * 根据导入文件调用存储过程增加记录
     * @param map
     */
    public void callInsertCusInfoByFile(Map<String, Object> map);
   
    /**
     * 调用存储过程更新记录
     * @param map
     */
    public void callUpdteCusInfo(Map<String, Object> map);
    
    /**
     * 执行存储过程进行删除操作
     * @param map
     */
    public void callDeleteCusInfo(Map<String, Object> map);
    
    
}
