package com.aoto.iqms.basicconfig.persistence.inf;

import java.util.List;
import java.util.Map;


public interface CustTypeMapper {
    
    /**
     * 调用存储过程进行分页数据查询
     * @param map
     * @return
     */
    public List<Map<String, Object>> callPageCustType(Map<String, Object> map);
    
    
    /**
     * 调用存储过程增加记录
     * @param map
     */
    public void callInsertCustType(Map<String, Object> map);
//    
    /**
     * 调用存储过程更新记录
     * @param map
     */
    public void callUpdteCustType(Map<String, Object> map);
    
    /**
     * 执行存储过程进行删除操作
     * @param map
     */
    public void callDeleteCustType(Map<String, Object> map);
//    
//    /**
//     * 通过机构id查询机构的业务
//     * @param map
//     */
//    public List<Map<String, Object>> findCustTypeByConditon(Map<String, Object> map);
//    
    
    /**
     * 分页查询客户类型
     * @param map
     * @return
     */
    List<Map<String, Object>> selectCustTypeByPage(Map<String, Object> map);
    
    /**
     * 查询客户等级
     * @param map
     */
    public List<Map<String, Object>> findCusLevelInfoByConditon(Map<String, Object> map);
    
}
