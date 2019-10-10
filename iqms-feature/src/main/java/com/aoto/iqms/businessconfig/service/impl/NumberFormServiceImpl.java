package com.aoto.iqms.businessconfig.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.aoto.iqms.businessconfig.commons.constant.BusinessconfigBeanProperty.BscCustLevel;
import com.aoto.iqms.businessconfig.models.NumberFormModel;
import com.aoto.iqms.businessconfig.models.NumberFormQuery;
import com.aoto.iqms.businessconfig.persistence.inf.NumberFormMapper;
import com.aoto.iqms.businessconfig.service.inf.BscWinConfigService;
import com.aoto.iqms.businessconfig.service.inf.NumberFormService;

/**
 * 号码模板 -业务层
 * @author humz
 */
@Service
public class NumberFormServiceImpl implements NumberFormService{

	@Autowired
	private NumberFormMapper numberFormMapper ;
	
	@Autowired
	private BscWinConfigService bscWinConfigService;
	/**
	 * 新增号码模板
	 */
	@Override
	public String insertNumberForm(NumberFormModel model) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("tktFormatId", model.getTktFormatId());
		map.put("tktFormat", model.getTktFormat());
		try {
			numberFormMapper.insertNumberForm(map);
			//获取存储过程的输出参数
			String obj = (String)map.get("ReturnCode");
			return obj;
		} catch (Exception e) {
			e.printStackTrace();
			return "1"; //执行失败
		}
		
	}

	/**
	 * 查询号码模板
	 */
	@Override
	public List<Map<String, Object>> selectNumberForm(NumberFormQuery model) {
		List<Map<String, Object>> list = numberFormMapper.selectNumberForm(model);
		Map<String, Object> map = new HashMap<String,Object>();
		map.put("tktFormats", list);
		List<Map<String, Object>> list2 = new ArrayList<Map<String, Object>>();
		list2.add(map);
		return list2;
	}

	/**
	 * 编辑号码模板
	 */
	@Override
	public String updateNumberForm(NumberFormModel model) {
		Map<String, Object> map = new HashMap<String,Object>();
		map.put("tktFormatId", model.getTktFormatId());
		map.put("tktFormat", model.getTktFormat());
		map.put("orgId", model.getOrgId());
		map.put("deviceNo", model.getDeviceNo());
		try {
			numberFormMapper.updateNumberForm(map);
			String obj = (String)map.get("ReturnCode");
			return obj;
		} catch (Exception e) {
			e.printStackTrace();
			return "1"; //执行失败
		}
	}

	/**
	 * 删除号码模板
	 */
	@Override
	public String deleteNumberForm(NumberFormModel model) {
		Map<String, Object> map = new HashMap<String,Object>();
		map.put("tktFormatId", model.getTktFormatId());
//		map.put("orgId", model.getOrgId());
//		map.put("deviceNo", model.getDeviceNo());
		try {
			numberFormMapper.deleteNumberForm(map);
			String obj = (String) map.get("ReturnCode");
			return obj;
		} catch (Exception e) {
			e.printStackTrace();
			return "1";
		}
	}

	@Override
	public String callCopyNumberProc(NumberFormModel model) {
		List<Map<String, Object>> list = bscWinConfigService.createOrgIdDeviceNo(model.getOrgDevicelist());
		for(int i=0; i<list.size(); i++){
			Map<String, Object> map = list.get(i);
			map.put(BscCustLevel.ORG_ID, model.getOrgId());
			map.put(BscCustLevel.DEVICE_NO, model.getDeviceNo());
			numberFormMapper.callCopyNumber(map);
		}
		return "0";
	}
	
}
