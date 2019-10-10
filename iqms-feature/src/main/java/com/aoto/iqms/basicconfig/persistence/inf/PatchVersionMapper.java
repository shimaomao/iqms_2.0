package com.aoto.iqms.basicconfig.persistence.inf;

import java.util.List;
import java.util.Map;

/**
 * 版本管理持久层
 * @author daxian
 *
 */
public interface PatchVersionMapper {
    
    /**
     * 调用存储过程进行分页数据查询
     * @param map
     * @return
     */
    public List<Map<String, Object>> callPagePatchVersion(Map<String, Object> map);
    
    
    /**
     * 调用存储过程增加记录
     * @param map
     */
    public void callInsertPatchVersion(Map<String, Object> map);
    
    /**
     * 调用存储过程更新记录
     * @param map
     */
    public void callUpdtePatchVersion(Map<String, Object> map);
    
    /**
     * 执行存储过程进行删除操作
     * @param map
     */
    public void callDeletePatchVersion(Map<String, String> map);
    
    /**
     * 通过机构id查询机构的业务
     * @param map
     */
    public List<Map<String, Object>> findPatchVersionByConditon(Map<String, Object> map);
    
    /**
     * 20170706 by hongxz 
     * 插入设备更新记录
     * @param map
     */
    public void insertUpgradeProcess(Map<String, Object> map);
    
    /**
     * 资源上传为所有设备更新记录
     * @param map
     */
    public void allInsertUpgradeProcess(Map<String, Object> map);
    
    
}
