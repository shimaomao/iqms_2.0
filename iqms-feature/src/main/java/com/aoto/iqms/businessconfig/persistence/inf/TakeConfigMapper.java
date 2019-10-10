package com.aoto.iqms.businessconfig.persistence.inf;

import java.util.List;
import java.util.Map;

import com.aoto.iqms.basicconfig.models.DeviceNoModel;

/**
 * 取号配置
 * @author humz
 *
 */
public interface TakeConfigMapper {

	/**
	 * 新增取号模板
	 */
	public void addTakeConfig(Map<String, Object> map);
	
	/**
	 * by hongxz 20171213 用于取号界面导航中中的配置
	 * @param map
	 */
	public void addTakeConfig4nav(Map<String, Object> map);
	
	
	/**
	 * 查询所有取号模板
	 */
	public List<Map<String, Object>> selectTakeConfig();
	
	/**
	 * 根据设备号查询模板
	 */
	public List<Map<String, Object>> selectTakeConfigBydeviceNo(Map<String, Object> map);
	
	/**
	 * 删除取号模板
	 */
	public void deleteTakeConfig(Map<String, Object> map);

	/**
	 * 查询大样式
	 */
	/*public List<Map<String, Object>> selectSettings();*/
	
	/**
	 * 根据type查询大样式
	 */
	/*public List<Map<String, Object>> selectSettingsbyType(Map<String, Object> map);*/
	
	/**
	 * 查询小样式
	 */
	/*public List<Map<String, Object>> selectQueueCtrl();*/
	
	/**
	 * 查询树形业务
	 */
	public List<Map<String, Object>> selectBuzTime(Map<String, Object> map);
	
	/**
	 * 查询模板是否默认
	 */
	public Map<String, Object> selectDef(Map<String, Object> map);
	
	/**
	 * 查询取号模板样式
	 */
	public String getStyle(Map<String, Object> map);
	
	/**
	 * 保存取号配置
	 */
	public void saveConfig(Map<String, Object> map);
	
	/**
	 * 查询取号模板样式，提供排队机下载
	 */
	public String getStyleByDevice(Map<String, Object> map);
	
	/**
	 * 保存取号界面元素
	 */
	public void saveQueueElement(Map<String, Object> map);
	
	/**
     * 执行存储过程应用到下级机构
     * @param map
     */
    public void callCopyTakeConfig(Map<String, Object> map);
    
    /**
     * 一键检测：检测取号界面
     * @param map
     * @return
     */
    public List<Map<String, Object>> checkedQueueface(Map<String, Object> map);
    
    
    /**
     * 导航配置-查询设备的默认模板
     * @param map
     * @return
     */
    public List<Map<String, Object>> navQueuefaceModel(Map<String, Object> map);
}
