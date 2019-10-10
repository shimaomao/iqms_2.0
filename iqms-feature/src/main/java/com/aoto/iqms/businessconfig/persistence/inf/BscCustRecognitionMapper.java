package com.aoto.iqms.businessconfig.persistence.inf;

import java.util.List;
import java.util.Map;

/**
 * 客户识别持久层
 * @author zhousj
 *
 */
public interface BscCustRecognitionMapper {
	/**
	 * 调用存储过程查询
	 * @param map
	 * @return
	 */
	public List<Map<String, Object>> callCustRecognitionQuery(Map<String, Object> map);
	
	/**
	 * 调用存储过程 保存
	 * @param map
	 * @return
	 */
	public void callInsertCustRecognition(Map<String, Object> map);
	
	/**
     * 执行存储过程进行删除操作
     * @param map
     */
    public void callDeleteCustRecognition(Map<String, Object> map);
    
    /**
     * 执行存储过程应用到下级机构
     * @param map
     */
    public void callCopyCustRecognition(Map<String, Object> map);
    
    /**
     * 执行存储过程生成custRecs.json
     * @param model
     * @return
     */
    public List<Map<String, Object>> callCustRecs(Map<String, Object> map);
}
