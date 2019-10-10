package com.aoto.iqms.basicconfig.persistence.inf;

import java.util.List;
import java.util.Map;

import com.aoto.iqms.basicconfig.models.DeviceNoModel;

/**
 * 取号模板
 * @author humz
 *
 */
public interface TakeModelMapper {

	/**
	 * 新增取号模板
	 */
	public void addTakeModel(Map<String, Object> map);
	
	/**
	 * 查询所有取号模板
	 */
	public List<Map<String, Object>> selectTakeModel();
	
	/**
	 * 根据设备号查询模板
	 */
	public List<Map<String, Object>> selectTakeModelBydeviceNo(Map<String, Object> map);
	
	/**
	 * 删除取号模板
	 */
	public void deleteTakeModel(Map<String, Object> map);

	/**
	 * 查询大样式
	 */
	public List<Map<String, Object>> selectSettings();
	
	/**
	 * 根据type查询大样式
	 */
	public List<Map<String, Object>> selectSettingsbyType(Map<String, Object> map);
	
	/**
	 * 查询小样式
	 */
	public List<Map<String, Object>> selectQueueCtrl();
	
	/**
	 * 查询树形业务
	 */
	public List<Map<String, Object>> selectBuzTime(Map<String, Object> map);
	
	/**
	 * 查询模板是否默认
	 */
	public Map<String, Object> selectDef(Map<String, Object> map);
	
	/**
	 * id查询取号模板
	 */
	public String getStyle(Map<String, Object> map);
	
	/**
	 * 保存取号配置
	 */
	public void saveConfig(Map<String, Object> map);
	
	
}
