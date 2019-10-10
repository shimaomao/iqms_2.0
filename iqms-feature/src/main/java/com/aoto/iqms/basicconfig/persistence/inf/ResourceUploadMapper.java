package com.aoto.iqms.basicconfig.persistence.inf;

import java.util.List;
import java.util.Map;

public interface ResourceUploadMapper {
    /**
     * 调用存储过程增加记录
     * @param map
     */
    public void callInsertResourceUpload(Map<String, Object> map);
    
    /**
     * 调用存储过程进行分页数据查询
     * @param map
     * @return
     */
    public List<Map<String, Object>> callPageResourceUpload(Map<String, Object> map);
}
