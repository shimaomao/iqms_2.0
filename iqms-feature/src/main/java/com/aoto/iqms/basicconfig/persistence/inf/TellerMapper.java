package com.aoto.iqms.basicconfig.persistence.inf;

import java.util.List;
import java.util.Map;

public interface TellerMapper {
	/**
     * 调用存储过程进行分页数据查询
     * @param map
     * @return
     */
    public List<Map<String, Object>> callPageTeller(Map<String, Object> map);
    
    
    /**
     * 调用存储过程增加记录
     * @param map
     */
    public void callInsertTeller(Map<String, Object> map);
//    
    /**
     * 调用存储过程更新记录
     * @param map
     */
    public void callUpdteTeller(Map<String, Object> map);
    
    /**
     * 执行存储过程进行删除操作
     * @param map
     */
    public void callDeleteTeller(Map<String, Object> map);
    
    /**
     * 执行存储过程生成tellers.json
     * @param model
     * @return
     */
    public List<Map<String, Object>> callTellers(Map<String, Object> map);
    
    /**
     * 根据柜员工号查询
     * @param map
     * @return
     */
    public List<Map<String, Object>> findTellerByWorkId(Map<String, Object> map);
}
