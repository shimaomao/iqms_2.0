package com.aoto.iqms.monitor.persistence.inf;
import java.util.List;
import java.util.Map;
/**
 * 查询设备状态
 * @author zhousj
 *
 */
public interface BscDeviceStatusMapper {
	/**
	 * 调用存储过程进行分页查询
	 * @param map
	 * @return
	 */
	public List<Map<String,Object>> callPageMoBscDeviceStatus(Map<String, Object> map);
	
	/**
	 * 调用存储过程查询详情
	 * @param map
	 * @return
	 */
	public List<Map<String, Object>> callBscDeviceStatusShow(Map<String, Object> map);
}
