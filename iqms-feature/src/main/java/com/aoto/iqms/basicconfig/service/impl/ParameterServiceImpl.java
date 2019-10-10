package com.aoto.iqms.basicconfig.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.aoto.iqms.basicconfig.commons.constant.BasicconfigBeanProperty.Parameter;
import com.aoto.iqms.basicconfig.models.ParameterModel;
import com.aoto.iqms.basicconfig.persistence.inf.ParameterMapper;
import com.aoto.iqms.basicconfig.service.inf.ParameterService;

/**
 * 参数配置service实现
 * @author zhousj
 *
 */
@Service
@Transactional
public class ParameterServiceImpl implements ParameterService{
	@Autowired
    ParameterMapper mapper;
	
	/**
	 * 调用存储过程查询
	 */
    @Override
	public List<Map<String, Object>> callParameter() {
        Map<String, Object> map = new HashMap<String, Object>();
        List<Map<String, Object>> list = mapper.callParameter(map);
    	
    	//获取数据集
        list = (List<Map<String, Object>>)map.get("pageDatas");
		return list;
	}

	@Override
	public String callSaveOrUpdateParameter(ParameterModel model) {
		// TODO Auto-generated method stub
		Map<String, Object> map = new HashMap<String, Object>();
		map.put(Parameter.HB_INTERVAL, model.getHbInterval());
		map.put(Parameter.AUTHENTICATION_TYPE, model.getAuthenticationType());
		map.put(Parameter.FLOW_PORT, model.getFlowPort());
		map.put(Parameter.HTTP_PORT, model.getHttpPort());
		map.put(Parameter.IDENT_PORT, model.getIdentPort());
		map.put(Parameter.APP_ROOT, model.getAppRoot());
		try {
			mapper.callSaveOrUpdateParameter(map);
			String obj = (String)map.get("ReturnCode");
			return obj;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			return "1"; //执行失败
		}
	}

	@Override
	public List<Map<String, Object>> callSysDicQuery(String dicType) {
		// TODO Auto-generated method stub
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("dicType", dicType);
		//获取数据集
		List<Map<String, Object>> list = mapper.callSysDicQuery(map);
        list = (List<Map<String, Object>>)map.get("pageDatas");
		return list;
	}

}
