package com.aoto.iqms.businessconfig.persistence.inf;

import java.util.List;
import java.util.Map;

/**
 * 特殊日期持久层
*@author zsj
*@创建时间：2018年10月9日下午4:36:41
*/
public interface BscSpecialDateMapper {
	/**
	 * 调用存储过程查询
	 * @param map
	 * @return
	 */
	public List<Map<String, Object>> callSpecialDateQuery(Map<String, Object> map);
	
	/**
	 * 调用存储过程 保存
	 * @param map
	 * @return
	 */
	public void callInsertSpecialDate(Map<String, Object> map);
	
	/**
     * 执行存储过程进行删除操作
     * @param map
     */
    public void callDeleteSpecialDate(Map<String, Object> map);
    
    /**
     * 执行存储过程应用到下级机构
     * @param map
     */
    public void callCopySpecialDate(Map<String, Object> map);
    
    /**
     * 执行存储过程生成specialDates.json
     * @param model
     * @return
     */
    public List<Map<String, Object>> callSpecialDates(Map<String, Object> map);
}
