package com.aoto.iqms.monitor.service.inf;

import java.util.List;
import java.util.Map;

import com.aoto.framework.commons.pagination.PagingCriteria;
import com.aoto.iqms.monitor.commons.constant.MonitorBeanProperty.BscDeviceStatus;
import com.aoto.iqms.monitor.models.BscDeviceStatusQuery;
/**
 * 设备相关数据监控
 * @author zhousj
 *
 */
public interface BscDeviceStatusService {
	/**
	 * 调用存储过程进行分页查询
	 * @param pagingCriteria
	 * @param model
	 * @return
	 */
	public List<Map<String, Object>> procPageDeviceStatus(PagingCriteria pagingCriteria, BscDeviceStatusQuery model);
	
	/**
	 * 调用存储过程查询详情
	 * @param orgId
	 * @param deviceNo
	 * @return
	 */
	public List<Map<String, Object>> procShowDevicesStatus(String orgId, String deviceNo);
}
