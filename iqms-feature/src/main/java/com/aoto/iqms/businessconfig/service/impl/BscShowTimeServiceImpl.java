package com.aoto.iqms.businessconfig.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.aoto.framework.commons.lang.StringUtils4Aoto;
import com.aoto.iqms.businessconfig.commons.constant.BusinessconfigBeanProperty.BscBranchBusiness;
import com.aoto.iqms.businessconfig.commons.constant.BusinessconfigBeanProperty.BscShowTime;
import com.aoto.iqms.businessconfig.models.BscBranchBusinessQuery;
import com.aoto.iqms.businessconfig.models.BscShowTimeModel;
import com.aoto.iqms.businessconfig.models.BscShowTimeQuery;
import com.aoto.iqms.businessconfig.persistence.inf.BscBranchBusinessMapper;
import com.aoto.iqms.businessconfig.persistence.inf.BscShowTimeMapper;
import com.aoto.iqms.businessconfig.service.inf.BscShowTimeService;
import com.aoto.iqms.businessconfig.service.inf.BscWinConfigService;

/**
 * 业务显示时间service层实现类
 * @author zhousj
 *
 */
@Service
@Transactional
public class BscShowTimeServiceImpl implements BscShowTimeService{
	@Autowired
	private BscShowTimeMapper showTimeMapper;
	@Autowired
	private BscWinConfigService bscWinConfigService;
	@Autowired
	private BscBranchBusinessMapper branchBusMapper;
	
	@Override
	public List<Map<String, Object>> procShowTimeQuery(BscShowTimeQuery model) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put(BscBranchBusiness.ORG_ID, StringUtils4Aoto.trim(model.getOrgId()));
		map.put(BscBranchBusiness.DEVICE_NO, StringUtils4Aoto.trim(model.getDeviceNo()));
		map.put(BscShowTime.BUSINESS_ID, StringUtils4Aoto.trim(model.getBusinessId()));
		List<Map<String, Object>> list = showTimeMapper.callshowTimeQuery(map);
		list = (List<Map<String, Object>>) map.get("pageDatas");
		return list;
	}


	@Override
	public String procSaveShowTime(List<BscShowTimeModel> list) {
		String result = "";
		if(list.get(0).getSaveStatus().equals("deleted")){
			procDeleteShowTime(list.get(0));
		}
		for(int i=0; i<list.size(); i++){
			if(list.get(i).getSaveStatus().equals("inserted")){
				Map<String, Object> map = new HashMap<String, Object>();
				map.put(BscShowTime.ORG_ID, StringUtils4Aoto.trim(list.get(i).getOrgId()));
				map.put(BscShowTime.DEVICE_NO, StringUtils4Aoto.trim(list.get(i).getDeviceNo()));
				map.put(BscShowTime.BUSINESS_ID, StringUtils4Aoto.trim(list.get(i).getBusinessId()));
				map.put(BscShowTime.DATE_TYPE, StringUtils4Aoto.trim(list.get(i).getDateType()));
				map.put(BscShowTime.BEGIN_TIME, StringUtils4Aoto.trim(list.get(i).getBeginTime()));
				map.put(BscShowTime.END_TIME, StringUtils4Aoto.trim(list.get(i).getEndTime()));
				map.put(BscShowTime.ROW_ID, StringUtils4Aoto.trim(list.get(i).getRowId()));
				map.put(BscShowTime.MAX_NUM, StringUtils4Aoto.trim(list.get(i).getMaxNum()));
				map.put(BscShowTime.EXTEND1, "");
				map.put(BscShowTime.EXTEND2, "");
				map.put(BscShowTime.EXTEND3, "");
				try {
					showTimeMapper.callInsertBscShowTime(map);;
					result = (String) map.get("ReturnCode");
				} catch (Exception e) {
					// TODO: handle exception
					e.printStackTrace();
					result = "1";//失败
				}
			}
		}
		return result;
	}

	@Override
	public String procDeleteShowTime(BscShowTimeModel model) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put(BscShowTime.ORG_ID, StringUtils4Aoto.trim(model.getOrgId()));
		map.put(BscShowTime.DEVICE_NO, StringUtils4Aoto.trim(model.getDeviceNo()));
		map.put(BscShowTime.BUSINESS_ID, StringUtils4Aoto.trim(model.getBusinessId()));
		showTimeMapper.callDeleteShowTime(map);
		return "0";
	}


	@Override
	public String callCopyBscShowTime(BscShowTimeModel model) {
		String code = procIsExistShowTime(model);
		if(code.equals("1")){
			return "2";//配置未保存
		}
		List<Map<String, Object>> list = bscWinConfigService.createOrgIdDeviceNo(model.getOrgDevicelist());
		for(int i=0; i<list.size(); i++){
			Map<String, Object> map = list.get(i);
			map.put(BscShowTime.ORG_ID, model.getOrgId());
			map.put(BscShowTime.DEVICE_NO, model.getDeviceNo());
			branchBusMapper.callCopyBscBranchBus(map);
			showTimeMapper.callCopyShowTime(map);
		}
		return "0";
	}


	@Override
	public String procIsExistShowTime(BscShowTimeModel model) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put(BscShowTime.ORG_ID, StringUtils4Aoto.trim(model.getOrgId()));
		map.put(BscShowTime.DEVICE_NO, StringUtils4Aoto.trim(model.getDeviceNo()));
		showTimeMapper.callIsExistShowTime(map);
		String result = (String) map.get("ReturnCode");
		return result;
	}


	@Override
	public List<Map<String, Object>> procBuzTimesQuery(BscBranchBusinessQuery model) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put(BscShowTime.ORG_ID, StringUtils4Aoto.trim(model.getOrgId()));
		map.put(BscShowTime.DEVICE_NO, StringUtils4Aoto.trim(model.getDeviceNo()));
		List<Map<String, Object>> list = showTimeMapper.callBuzTimes(map);
		list = (List<Map<String, Object>>) map.get("pageDatas");
		return list;
	}
	
	
	public List<Map<String, Object>> checkedBuzTime(BscShowTimeModel model) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put(BscShowTime.DEVICE_NO, StringUtils4Aoto.trim(model.getDeviceNo()));
		List<Map<String, Object>> list = showTimeMapper.checkedBuzTime(map);
		return list;
	}


	@Override
	public List<Map<String, Object>> findShowTime(BscShowTimeModel model) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put(BscShowTime.DEVICE_NO, StringUtils4Aoto.trim(model.getDeviceNo()));
		map.put(BscShowTime.BUSINESS_ID, StringUtils4Aoto.trim(model.getBusinessId()));
		map.put(BscShowTime.DATE_TYPE, StringUtils4Aoto.trim(model.getDateType()));
		List<Map<String, Object>> list = showTimeMapper.findShowTime(map);
		list = (List<Map<String, Object>>) map.get("pageDatas");
		return list;
	}
}
