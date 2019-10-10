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
import com.aoto.iqms.monitor.commons.constant.MonitorBeanProperty.TrxToday;
import com.aoto.iqms.monitor.models.TrxTodayQuery;
import com.aoto.iqms.monitor.persistence.inf.WinMonitorMapper;
import com.aoto.iqms.monitor.service.inf.WinMonitorService;
import com.aoto.iqms.util.ProcPageFill;

/**
 * 窗口监控实现
 * @author zhousj
 *
 */
@Service
@Transactional
public class WinMonitorServiceImpl implements WinMonitorService{
	@Autowired
	WinMonitorMapper winMapper;
	/**
	 * 调用存储过程分页
	 */
	@Override
	public List<Map<String, Object>> procPageWinMonitor(PagingCriteria pagingCriteria, TrxTodayQuery model) {
		Map<String, Object> map = new HashMap<String, Object>();
	    map.put(TrxToday.ORG_ID, StringUtils4Aoto.trim(model.getOrgId()));
	    //填充分页和排序信息
	    ProcPageFill.fillProcData(model, map, TrxToday.class);
	    //执行存储过程
	    List<Map<String, Object>> list = winMapper.callPageWinMonitor(map);
	    //获取存储过程的返回值
	    int total = ((BigDecimal)map.get("totalrows")).intValue();
	    pagingCriteria.setTotal(total);
	    list = (List<Map<String, Object>>) map.get("pageDatas");
		return list;
	}

}
