package com.aoto.iqms.businessconfig.service.inf;

import java.util.List;
import java.util.Map;

/**
 * 广告发布
 * @author humz
 *
 */
public interface AdPublishService {
	
	/**
	 * 根据设备查询广告
	 * @return
	 */
	public List<Map<String, Object>> selectAdsByDeviceNo(Map<String, Object> map);
	
	/**
	 * 保存广告
	 */
	public String saveAds(Map<String, Object> map);
	
	/**
	 * 发送广告
	 */
	public void sendAds(Map<String, Object> map);
	
	
}
