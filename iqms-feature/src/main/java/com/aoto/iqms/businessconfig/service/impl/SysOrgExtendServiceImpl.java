package com.aoto.iqms.businessconfig.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.aoto.iqms.businessconfig.models.SysOrgExtendModel;
import com.aoto.iqms.businessconfig.persistence.inf.BscDeviceMapper;
import com.aoto.iqms.businessconfig.persistence.inf.SysOrgExtendMapper;
import com.aoto.iqms.businessconfig.service.inf.SysOrgExtendService;
import com.aoto.iqms.externals.dealprocess.CustIdentityProcess;

@Service
@Transactional
public class SysOrgExtendServiceImpl implements SysOrgExtendService{
	private static final Logger logger = LoggerFactory
			.getLogger(SysOrgExtendServiceImpl.class);
	@Autowired
	public SysOrgExtendMapper orgMapper;
	@Autowired
	public BscDeviceMapper deviceMapper;
	@Override
	public String callRemoveOrgExtend(String OrgId) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("orgId", OrgId);
		String result = orgMapper.callDeleteOrgExtend(map);
		/*list = (List<Map<String, String>>) map.get("pageDatas");
		for (int i = 0; i < list.size(); i++) {
			Map<String, String> listMap= list.get(i);
			deviceMapper.callDeleteBscDevice(listMap);
		}*/
		return "0";
	}
	@Override
	public SysOrgExtendModel findOrgByOrgId(String OrgId) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("orgId", OrgId);
		SysOrgExtendModel model = new SysOrgExtendModel();
		try {
			List<Map<String, Object>> list = orgMapper.findOrgByOrgId(map);
			model.setOrgId(list.get(0).get("orgId").toString());
			model.setOrgCode(list.get(0).get("orgCode").toString());
			model.setOrgName(list.get(0).get("orgName").toString());
		} catch (Exception e) {
			logger.error("异常：",e);
		}
		return model;
	}

}
