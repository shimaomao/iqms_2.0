package com.aoto.iqms.basicconfig.service.impl;

import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.executor.keygen.Jdbc3KeyGenerator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.aoto.framework.commons.lang.StringUtils4Aoto;
import com.aoto.framework.commons.pagination.PagingCriteria;
import com.aoto.iqms.basicconfig.commons.constant.BasicconfigBeanProperty.CustType;
import com.aoto.iqms.basicconfig.models.CustTypeModel;
import com.aoto.iqms.basicconfig.models.CustTypeQuery;
import com.aoto.iqms.basicconfig.persistence.inf.CustTypeMapper;
import com.aoto.iqms.basicconfig.service.inf.CustTypeService;
import com.aoto.iqms.util.ProcPageFill;


/**
 * 客户等级管理sevice实现
 * @author daxian
 *
 */
@Service
@Transactional
public class CustTypeSeviceImpl implements CustTypeService {
	
	@Autowired
	public CustTypeMapper custTypeMapper;

	/**
	 * 分页查询
	 */
	@Override
	public List<Map<String, Object>> selectCustTypeByPage(PagingCriteria pagingCriteria, CustTypeQuery model) {
		
		
		return null;
	}

	
	/**
	 * 调用存储过程分页
	 */
	@Override
	public List<Map<String, Object>> procPageCustType(
			PagingCriteria pagingCriteria, CustTypeQuery model) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put(CustType.CUST_NAME, StringUtils4Aoto.trim(model.getCustName()));
        
        //填充分页和排序信息
        ProcPageFill.fillProcData(model, map,CustType.class);
        //执行查询
        List<Map<String, Object>> list = custTypeMapper.callPageCustType(map);
        
        //获取存储过程中返回的值
        int total = ((BigDecimal)map.get("totalrows")).intValue();
        pagingCriteria.setTotal(total);
        //获取数据集
        list = (List<Map<String, Object>>)map.get("pageDatas");
		return list;		
	}

	/**
	 * 调用存储过程新增业务类型数据
	 */
	@Override
	public String callCreateCustTypeProc(CustTypeModel model) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put(CustType.CUST_LEVEL, model.getCustLevel());
		map.put(CustType.CUST_NAME, model.getCustName());
		map.put(CustType.VIP_FLAG, model.getVipFlag()); 
		map.put(CustType.SMS_FLAG, model.getSmsFlag());
		map.put(CustType.WAIT_TIMEOUT, model.getWaitTimeout());
		map.put(CustType.PRESENT_FLAG, model.getPresentFlag());
		map.put(CustType.IS_USE, "1");
		map.put(CustType.EXTEND1, model.getExpend1());
		map.put(CustType.EXTEND2, model.getExpend2());
		map.put(CustType.EXTEND3, model.getExpend3());
		
		//调用持久化方法
		try {
			custTypeMapper.callInsertCustType(map);
			//获取存储过程的输出参数
			String obj = (String)map.get("ReturnCode");
			return obj;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			return "1"; //执行失败
		}
	}

	/**
	 * 调用存储过程更新数据
	 */
	@Override
	public String callUpdateCustTypeProc(CustTypeModel model) {
		// TODO Auto-generated method stub
		Map<String, Object> map = new HashMap<String, Object>();
		map.put(CustType.CUST_LEVEL, model.getCustLevel());
		map.put(CustType.CUST_NAME, model.getCustName());
		map.put(CustType.VIP_FLAG, model.getVipFlag()); 
		map.put(CustType.SMS_FLAG, model.getSmsFlag());
		map.put(CustType.WAIT_TIMEOUT, model.getWaitTimeout());
		map.put(CustType.PRESENT_FLAG, model.getPresentFlag());
		map.put(CustType.IS_USE, model.getIsUse());
		map.put(CustType.EXTEND1, model.getExpend1());
		map.put(CustType.EXTEND2, model.getExpend2());
		map.put(CustType.EXTEND3, model.getExpend3());
		//调用持久化方法
		try {
			custTypeMapper.callUpdteCustType(map);
			//获取存储过程的输出参数
			String obj = (String)map.get("ReturnCode");
			return obj;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			return "1"; //执行失败
		}
	}

	/**
	 * 业务删除
	 */
	@Override
	public String callRemoveCustTypeProc(List<String> list) {
		Map<String, Object> map = new HashMap<String, Object>();
		for (int i = 0; i < list.size(); i++) {
			map.put(CustType.CUST_LEVEL, list.get(i));
			custTypeMapper.callDeleteCustType(map);
		}
		return "0";
	}
	
	
	/**
     * 通过条件查询客户等级。
     * @param map
     */
	public List<Map<String, Object>> findCusLevelInfoByConditon(CustTypeModel model){
    	Map<String, Object> map = new HashMap<String, Object>();
    	List<Map<String, Object>> list = custTypeMapper.findCusLevelInfoByConditon(map);
    	return list;
    }
}
