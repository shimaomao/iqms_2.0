package com.aoto.iqms.businessconfig.service.inf;

import java.util.List;
import java.util.Map;

import com.aoto.iqms.basicconfig.models.DeviceNoModel;
import com.aoto.iqms.basicconfig.models.TakeModelModel;
import com.aoto.iqms.businessconfig.models.BscBranchBusinessQuery;
import com.aoto.iqms.businessconfig.models.BscDeviceQuery;

/**
 * 取号模板
 * @author humz
 *
 */
public interface TakeConfigService {

	/**
	 * 新增取号模板
	 */
	public String addTakeConfig(TakeModelModel model);
	
	/**
	 * 查询取号模板
	 */
	public List<Map<String, Object>> selectTakeConfig();
	
	/**
	 * 根据设备号查询模板
	 */
	public List<Map<String, Object>> selectTakeConfigBydeviceNo(DeviceNoModel model);
	
	/**
	 * 删除取号模板
	 */
	public String deleteTakeConfig(TakeModelModel model);
	
	/**
	 * 获取轮播图片广告
	 */
	public List<Map<String, Object>> getPictureList();
	
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
	 * 查询树形业务
	 */
	public List<Map<String, Object>> selectBuzTime(String deviceNo);
	
	
	/**
	 * id获取模板
	 */
	public Map<String, Object> getStyle(Map<String, Object> map);
	
	/**
	 * 保存取号配置
	 */
	public String saveConfig(Map<String, Object> map);
	
	/**
	 * 提供排队机下载
	 */
	public void createTakeConfig(BscBranchBusinessQuery model,String path);
	
	/**
	 * 检测取号界面
	 * @param model
	 * @return
	 */
	public List<Map<String, Object>> checkedQueueface(TakeModelModel model);
	
	/**
	 * 导航配置-取号模板查询
	 * @param model
	 * @return
	 */
	public List<Map<String, Object>> navQueuefaceModel(TakeModelModel model);
	
	
	/**
	 * 保存取号配置
	 */
	public String saveConfig4nav(Map<String, Object> map);
	
	/**
     * 调用存储过程应用到下级机构
     * @param model
     * @return
     */
    public String callSaveTakeConfigProc(BscDeviceQuery model);
}
