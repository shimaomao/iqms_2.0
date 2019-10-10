package com.aoto.iqms.report.service.impl;

import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.aoto.framework.commons.lang.StringUtils4Aoto;
import com.aoto.framework.commons.pagination.PagingCriteria;
import com.aoto.iqms.report.commons.constant.ReportBeanProperty.BusinessFlowReport;
import com.aoto.iqms.report.commons.constant.ReportBeanProperty.CusAnalyseReport;
import com.aoto.iqms.report.models.BusinessFlowReportQuery;
import com.aoto.iqms.report.persistence.inf.BusinessFlowReportMapper;
import com.aoto.iqms.report.service.inf.BusinessFlowReportService;
import com.aoto.iqms.util.ProcPageFill;

/**
 * 业务流水报表-业务层实现
 * @author humz
 *
 */
@Service
public class BusinessFlowReportServiceImpl implements BusinessFlowReportService{

	@Autowired
	private BusinessFlowReportMapper businessFlowReportMapper ;
	
	/**
     * 调用存储过程进行分页数据查询
     * @param map
     * @return
     */
	@Override
	public List<Map<String, Object>> procPageBFReport(PagingCriteria pagingCriteria, BusinessFlowReportQuery model) {
		 Map<String, Object> map = new HashMap<String, Object>();
		 map.put(BusinessFlowReport.ORG_ID, StringUtils4Aoto.trim(model.getOrgId()));
	     map.put(BusinessFlowReport.CUST_LEVEL, StringUtils4Aoto.trim(model.getCustLevel()));
	     map.put(BusinessFlowReport.APP_VALUE, StringUtils4Aoto.trim(model.getAppValue()));
	     map.put(BusinessFlowReport.START_DATE, StringUtils4Aoto.trim(model.getStartDate()));
	     map.put(BusinessFlowReport.END_DATE, StringUtils4Aoto.trim(model.getEndDate()));
	     
	     //填充分页，排序数据
        ProcPageFill.fillProcData(model, map,BusinessFlowReport.class);
        //执行查询
        List<Map<String, Object>> list = businessFlowReportMapper.procPageBFReport(map);
        
        //获取存储过程中返回的值
        int total = ((BigDecimal)map.get("totalrows")).intValue();
        pagingCriteria.setTotal(total);
        //获取数据集
        list = (List<Map<String, Object>>)map.get("pageDatas");
		return list;
		
	}
	
	
}
