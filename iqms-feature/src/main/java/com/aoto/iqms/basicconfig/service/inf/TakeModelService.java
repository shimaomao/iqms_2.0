package com.aoto.iqms.basicconfig.service.inf;

import java.util.List;
import java.util.Map;

import com.aoto.iqms.basicconfig.models.DeviceNoModel;
import com.aoto.iqms.basicconfig.models.TakeModelModel;

/**
 * 取号模板
 * @author humz
 *
 */
public interface TakeModelService {

	/**
	 * 新增取号模板
	 */
	public String addTakeModel(TakeModelModel model);
	
	/**
	 * 查询取号模板
	 */
	public List<Map<String, Object>> selectTakeModel();
	
	/**
	 * 根据设备号查询模板
	 */
	public List<Map<String, Object>> selectTakeModelBydeviceNo(DeviceNoModel model);
	
	/**
	 * 删除取号模板
	 */
	public String deleteTakeModel(TakeModelModel model);
	
	/**
	 * 查询大样式
	 */
	public Map<String, Object> selectSettings();
	
	/**
	 * 根据type查询大样式
	 */
	public List<Map<String, Object>> selectSettingsbyType(Map<String, Object> map);
	
	/**
	 * 获取视频
	 */
	public List<Map<String, Object>> getVideoList();
	
	/**
	 * 获取音乐
	 */
	public List<Map<String, Object>> getMusicList();
	
	/**
	 * 获取背景图片
	 */
	public List<Map<String, Object>> getBackgroundImgs();
	
	/**
	 * 查询小样式
	 */
	public List<Map<String, Object>> selectQueueCtrl();
	
	/**
	 * 查询树形业务
	 */
	public List<Map<String, Object>> selectBuzTime(int treePid);
	
	
	/**
	 * id获取模板
	 */
	public Map<String, Object> getStyle(Map<String, Object> map);
	
	/**
	 * 保存取号配置
	 */
	public String saveConfig(Map<String, Object> map);
}
