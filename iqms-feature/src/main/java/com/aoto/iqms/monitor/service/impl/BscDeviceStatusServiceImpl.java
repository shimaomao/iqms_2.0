package com.aoto.iqms.monitor.service.impl;

import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.aoto.framework.commons.lang.StringUtils4Aoto;
import com.aoto.framework.commons.pagination.PagingCriteria;
import com.aoto.iqms.monitor.commons.constant.MonitorBeanProperty.BscDeviceStatus;
import com.aoto.iqms.monitor.models.BscDeviceStatusQuery;
import com.aoto.iqms.monitor.persistence.inf.BscDeviceStatusMapper;
import com.aoto.iqms.monitor.service.inf.BscDeviceStatusService;
import com.aoto.iqms.util.ProcPageFill;
/**
 * 查询设备数据 实现
 * @author zhousj
 *
 */
@Service
@Transactional
public class BscDeviceStatusServiceImpl implements BscDeviceStatusService{
	@Autowired
	private BscDeviceStatusMapper deviceMapper;
	
	/**
	 * 调用存储过程分页
	 */
	@Override
	public List<Map<String, Object>> procPageDeviceStatus(PagingCriteria pagingCriteria, BscDeviceStatusQuery model) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put(BscDeviceStatus.ORG_ID, StringUtils4Aoto.trim(model.getOrgId()));
		map.put(BscDeviceStatus.ONLINE_FLAG, StringUtils4Aoto.trim(model.getOnLineFlag()));
		//填充分页和排序信息
	    ProcPageFill.fillProcData(model, map, BscDeviceStatus.class);
	    //执行存储过程
	    List<Map<String, Object>> list = deviceMapper.callPageMoBscDeviceStatus(map);
	    //获取存储过程的返回值
	    int total = ((BigDecimal)map.get("totalrows")).intValue();
	    pagingCriteria.setTotal(total);
	    
	    list = (List<Map<String, Object>>) map.get("pageDatas");
		return list;
	}
	
	/**
	 * 查询详情
	 */
	@Override
	public List<Map<String, Object>> procShowDevicesStatus(String orgId, String deviceNo) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("orgId", orgId);
		map.put("deviceNo", deviceNo);
		List<Map<String, Object>> list = deviceMapper.callBscDeviceStatusShow(map);
        list = (List<Map<String, Object>>)map.get("pageDatas");
		return list;
	}
	
}
