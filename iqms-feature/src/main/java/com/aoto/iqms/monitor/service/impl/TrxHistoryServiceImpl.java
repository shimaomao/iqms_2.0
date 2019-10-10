package com.aoto.iqms.monitor.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.aoto.iqms.monitor.commons.constant.MonitorBeanProperty.TrxHistory;
import com.aoto.iqms.monitor.persistence.inf.TrxHistoryMapper;
import com.aoto.iqms.monitor.service.inf.TrxHistoryService;

/**
 * 业务历史数据实现
 * @author zhousj
 *
 */
@Service
@Transactional
public class TrxHistoryServiceImpl implements TrxHistoryService{
	@Autowired
	private TrxHistoryMapper trxHistoryMapper;
	
	/**
	 * 查询昨日特点数据
	 */
	@Override
	public List<Map<String, Object>> procTrxYesterdayQuery(String orgId) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put(TrxHistory.ORG_ID, orgId);
		List<Map<String, Object>> list = trxHistoryMapper.callTrxYesterdayQuery(map);
		list = (List<Map<String, Object>>) map.get("pageDatas");
		return list;
	}

}
