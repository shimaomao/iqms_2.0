package com.aoto.iqms.basicconfig.service.impl;

import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.aoto.framework.commons.beans.JsonResult;
import com.aoto.framework.commons.lang.StringUtils4Aoto;
import com.aoto.framework.commons.pagination.PagingCriteria;
import com.aoto.iqms.basicconfig.commons.constant.BasicconfigBeanProperty.BusinessManage;
import com.aoto.iqms.basicconfig.commons.constant.BasicconfigBeanProperty.CustType;
import com.aoto.iqms.basicconfig.models.BusinessManageModel;
import com.aoto.iqms.basicconfig.models.BusinessManageQuery;
import com.aoto.iqms.basicconfig.models.CustTypeModel;
import com.aoto.iqms.basicconfig.persistence.inf.BusinessManageMapper;
import com.aoto.iqms.basicconfig.service.inf.BusinessManageService;
import com.aoto.iqms.util.ProcPageFill;

/**
 *业务管理sevice层接口实现类
 * @author humz
 *
 */
@Service
@Transactional
public class BusinessManageServiceImpl implements BusinessManageService{

	/**
	 * 自动注入持久化层接口
	 */
	@Autowired
	public BusinessManageMapper businessManageMapper;
	
	/**
	 * 分页查询
	 */
	@Override
	public List<Map<String, Object>> selectBusManageByPage(PagingCriteria pagingCriteria, BusinessManageQuery model) {
		return null;
	}

	/**
	 * 调用存储过程分页
	 */
	@Override
	public List<Map<String, Object>> procPageBusManage(PagingCriteria pagingCriteria, BusinessManageQuery model) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put(BusinessManage.BUSINESS_NAME, StringUtils4Aoto.trim(model.getBusinessName()));
        
        //填充分页和排序信息
        ProcPageFill.fillProcData(model, map,BusinessManage.class);
        //执行查询
        List<Map<String, Object>> list = businessManageMapper.callPageBusManage(map);
        
        //获取存储过程中返回的值
        int total = ((BigDecimal)map.get("totalrows")).intValue();
        pagingCriteria.setTotal(total);
        //获取数据集
        list = (List<Map<String, Object>>)map.get("pageDatas");
		return list;		
	}

	/**
	 * 调用存储过程新增数据
	 */
	@Override
	public String callCreateBusManageProc(BusinessManageModel model) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put(BusinessManage.BUSINESS_NAME, model.getBusinessName());
		map.put(BusinessManage.BUSINESS_ENAME, model.getBusinessEName());
		map.put(BusinessManage.AVERAGE_TIME, model.getAverageTime().replaceAll("^(0+)", ""));
		map.put(BusinessManage.ORDER_FLAG, model.getOrderFlag());
		
		//调用持久化方法
		try {
			businessManageMapper.callInsertBusManage(map);
			//获取存储过程的输出参数
			String obj = (String)map.get("ReturnCode");
			return obj;
		} catch (Exception e) {
			e.printStackTrace();
			return "1"; //执行失败
		}
	}

	/**
	 * 调用存储过程更新数据
	 */
	@Override
	public String callUpdateBusManageProc(BusinessManageModel model) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put(BusinessManage.BUSINESS_ID, model.getBusinessId());
		map.put(BusinessManage.BUSINESS_NAME, model.getBusinessName());
		map.put(BusinessManage.BUSINESS_ENAME, model.getBusinessEName());
		map.put(BusinessManage.AVERAGE_TIME, model.getAverageTime().replaceAll("^(0+)", ""));
		map.put(BusinessManage.ORDER_FLAG, model.getOrderFlag());

		//调用持久化方法
		try {
			businessManageMapper.callUpdteBusManage(map);
			//获取存储过程的输出参数
			String obj = (String)map.get("ReturnCode");
			return obj;
		} catch (Exception e) {
			e.printStackTrace();
			return "1"; //执行失败
		}
	}


	/**
	 * 调用存储过程删除数据
	 */
	@Override
	public String callRemoveBusManageProc(List<String> list) {
		Map<String, Object> map = new HashMap<String, Object>();
		for (int i = 0; i < list.size(); i++) {
			map.put(BusinessManage.BUSINESS_ID, list.get(i));
			businessManageMapper.callDeleteBusManage(map);
		}
		return "0";
	}

	@Override
	public List<Map<String, Object>> selectBusManage() {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put(BusinessManage.BUSINESS_ID, "0");
		List<Map<String, Object>> list = businessManageMapper.callSelectBusManage(map);
		list = (List<Map<String, Object>>)map.get("pageDatas");
		return list;
	}
	
	/**
     * 通过条件查询业务类型。
     * @param map
     */
	@Override
	public List<Map<String, Object>> findBusManageByConditon(BusinessManageModel model) {
		Map<String, Object> map = new HashMap<String, Object>();
    	List<Map<String, Object>> list = businessManageMapper.findBusManageByConditon(map);
    	return list;
	}

	@Override
	public List<Map<String, Object>> findBusManageById(String busId) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put(BusinessManage.BUSINESS_ID, busId);
		List<Map<String, Object>> list = businessManageMapper.findBusManageById(map);
		return list;
	}
}

