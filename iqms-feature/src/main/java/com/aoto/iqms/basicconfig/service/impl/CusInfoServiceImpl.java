package com.aoto.iqms.basicconfig.service.impl;

import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.aoto.framework.commons.lang.StringUtils4Aoto;
import com.aoto.framework.commons.pagination.PagingCriteria;
import com.aoto.iqms.basicconfig.commons.constant.BasicconfigBeanProperty.BusinessManage;
import com.aoto.iqms.basicconfig.commons.constant.BasicconfigBeanProperty.CusInfo;
import com.aoto.iqms.basicconfig.models.CusInfoModel;
import com.aoto.iqms.basicconfig.models.CusInfoQuery;
import com.aoto.iqms.basicconfig.persistence.inf.BusinessManageMapper;
import com.aoto.iqms.basicconfig.persistence.inf.CusInfoMapper;
import com.aoto.iqms.basicconfig.service.inf.CusInfoService;
import com.aoto.iqms.util.ProcPageFill;

/**
 * 本地客户Service层接口实现类
 * @author humz
 *
 */
@Service
@Transactional
public class CusInfoServiceImpl implements CusInfoService{
	/**
	 * 自动注入持久化层接口
	 */
	@Autowired
	public CusInfoMapper cusInfoMapper;
	

	/**
	 * 调用存储过程查询分页
	 */
	@Override
	public List<Map<String, Object>> procPageCusInfo(PagingCriteria pagingCriteria, CusInfoQuery model) {
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put(CusInfo.ORG_ID, StringUtils4Aoto.trim(model.getOrgId()));
		map.put(CusInfo.CUST_ID, StringUtils4Aoto.trim(model.getCustId()));
		map.put(CusInfo.CUST_NAME, StringUtils4Aoto.trim(model.getCustName()));
		map.put(CusInfo.CUST_LEVEL, StringUtils4Aoto.trim(model.getCustLevel()));
        
        //填充分页和排序信息
        ProcPageFill.fillProcData(model, map,CusInfo.class);
        //执行查询
        List<Map<String, Object>> list = cusInfoMapper.callPageCusInfo(map);
        
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
	public String callCreateCusInfoProc(CusInfoModel model) {
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put(CusInfo.ORG_ID, StringUtils4Aoto.trim(model.getOrgId()));
		map.put(CusInfo.CUST_ID, StringUtils4Aoto.trim(model.getCustId()));
		map.put(CusInfo.CUST_NAME, StringUtils4Aoto.trim(model.getCustName()));
		map.put(CusInfo.CUST_LEVEL, StringUtils4Aoto.trim(model.getCustLevel()));
		map.put(CusInfo.CUST_PDUT, StringUtils4Aoto.trim(model.getCustPdut()));
		map.put(CusInfo.CUST_AD, StringUtils4Aoto.trim(model.getCustAd()));
		map.put(CusInfo.ISBANK_EFTVE, StringUtils4Aoto.trim(model.getIsBankEftve()));
		
		//调用持久化方法
		try {
			cusInfoMapper.callInsertCusInfo(map);
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
	public String callUpdateCusInfoProc(CusInfoModel model) {
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put(CusInfo.ORG_ID, StringUtils4Aoto.trim(model.getOrgId()));
		map.put(CusInfo.CUST_ID, StringUtils4Aoto.trim(model.getCustId()));
		map.put(CusInfo.CUST_NAME, StringUtils4Aoto.trim(model.getCustName()));
		map.put(CusInfo.CUST_LEVEL, StringUtils4Aoto.trim(model.getCustLevel()));
		map.put(CusInfo.CUST_PDUT, StringUtils4Aoto.trim(model.getCustPdut()));
		map.put(CusInfo.CUST_AD, StringUtils4Aoto.trim(model.getCustAd()));
		map.put(CusInfo.ISBANK_EFTVE, StringUtils4Aoto.trim(model.getIsBankEftve()));
		//调用持久化方法
		try {
			cusInfoMapper.callUpdteCusInfo(map);
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
	public String callRemoveCusInfoProc(List<String> list) {
		Map<String, Object> map = new HashMap<String, Object>();
		for (int i = 0; i < list.size(); i++) {
			map.put(CusInfo.CUST_ID, list.get(i));
			cusInfoMapper.callDeleteCusInfo(map);
		}
		return "0";
	}

	
	/**
	 * 批量保存导入的本地客户信息 
	 * @param models  本地客户信息列表
	 * @param rownums 对应客户信息在excel中的行号
	 * @param errMap  封装错误信息
	 * @return
	 */
	public String callCreateCusInfoBatchProc(List<CusInfoModel> models,List<String> rownums,List<Map<String, String>> errMaps){
		
		for (int i = 0; i < models.size();i++){
			CusInfoModel model = models.get(i);
			Map<String, Object> map = new HashMap<String, Object>();
			map.put(CusInfo.ORG_CODE, StringUtils4Aoto.trim(model.getOrgCode()));
			map.put(CusInfo.CUST_ID, StringUtils4Aoto.trim(model.getCustId()));
			map.put(CusInfo.CUST_NAME, StringUtils4Aoto.trim(model.getCustName()));
			map.put(CusInfo.CUST_LEVEL, StringUtils4Aoto.trim(model.getCustLevel()));
			map.put(CusInfo.CUST_PDUT, StringUtils4Aoto.trim(model.getCustPdut()));
			map.put(CusInfo.CUST_AD, StringUtils4Aoto.trim(model.getCustAd()));
			map.put(CusInfo.ISBANK_EFTVE, StringUtils4Aoto.trim(model.getIsBankEftve()));
			//调用持久化方法
			try {
				cusInfoMapper.callInsertCusInfoByFile(map);
				//获取存储过程的输出参数
				String obj = (String)map.get("ReturnCode");
				if (obj != null && obj.equals("2")){
					Map<String, String> errMap = new HashMap<String, String>();
					errMap.put("rownum", "第"+rownums.get(i)+"行"); //行号
					errMap.put("errMsg", "客户识别码已经存在了"); //保存失败的信息
					errMaps.add(errMap);
				}
			} catch (Exception e) {
				Map<String, String> errMap = new HashMap<String, String>();
				errMap.put("rownum", "第"+rownums.get(i)+"行"); //行号
				errMap.put("errMsg", e.getMessage()); //保存失败的信息
				errMaps.add(errMap);
				e.printStackTrace();
			}
		}
		return "";
	}

}
