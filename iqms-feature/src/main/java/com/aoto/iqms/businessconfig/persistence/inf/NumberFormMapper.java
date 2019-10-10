package com.aoto.iqms.businessconfig.persistence.inf;

import java.util.List;
import java.util.Map;

import com.aoto.iqms.businessconfig.models.BscBranchBusinessQuery;
import com.aoto.iqms.businessconfig.models.NumberFormQuery;

/**
 * 号码模板-持久化层
 * @author humz
 */
public interface NumberFormMapper {
	/**
	 * 新增号码模板
	 * @param map
	 */
	public void insertNumberForm(Map<String, Object> map);
	
	/**
	 * 查询号码模板
	 */
	public List<Map<String, Object>> selectNumberForm(NumberFormQuery model);
	
	/**
	 * 编辑号码模板
	 */
	public void updateNumberForm(Map<String, Object> map);
	
	/**
	 * 号码模板删除
	 */
	public void deleteNumberForm(Map<String, Object> map);
	
	/**
     * 执行存储过程应用到下级机构
     * @param map
     */
    public void callCopyNumber(Map<String, Object> map);
    
    /**
	 * 根据deviceNo 查询 号票模板
	 */
	public List<Map<String, Object>> callTktFormatsFormQuery(Map<String, Object> map);
	/**
	 * 根据tktFormatId 查询 号码模板
	 * @param map
	 * @return
	 */
	public List<Map<String, Object>> callTktFormatsByTktId();
}
