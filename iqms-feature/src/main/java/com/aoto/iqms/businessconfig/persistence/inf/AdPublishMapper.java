package com.aoto.iqms.businessconfig.persistence.inf;

import java.util.List;
import java.util.Map;

/**
 * 广告发布
 * @author humz
 *
 */
public interface AdPublishMapper {

	/**
	 * 根据设备查询广告
	 * @return
	 */
	public Map<String, Object> selectAdsByDeviceNo(Map<String, Object> map);
	
	/**
	 * 保存并发送广告
	 */
	public void saveAndSend(Map<String, Object> map);
	
	/**
	 * 根据orgId查询所有子节点
	 */
	public List<Map<String, Object>> findByPraendId(Map<String, Object> map);
	
}
