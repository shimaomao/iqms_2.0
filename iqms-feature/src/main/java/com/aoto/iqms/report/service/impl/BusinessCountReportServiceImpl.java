package com.aoto.iqms.report.service.impl;

import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.aoto.framework.commons.lang.StringUtils4Aoto;
import com.aoto.framework.commons.pagination.PagingCriteria;
import com.aoto.iqms.report.commons.constant.ReportBeanProperty.BusinessCountReport;
import com.aoto.iqms.report.models.BusinessCountReportQuery;
import com.aoto.iqms.report.persistence.inf.BusinessCountReportMapper;
import com.aoto.iqms.report.service.inf.BusinessCountReportService;
import com.aoto.iqms.util.ProcPageFill;


/**
 * 业务量报表-业务层实现
 * @author humz
 *
 */
@Service
public class BusinessCountReportServiceImpl implements BusinessCountReportService {
	
	@Autowired
	private BusinessCountReportMapper businessCountReportMapper; 

	/**
     * 调用存储过程进行分页数据查询
     * @param map
     * @return
     */
	@Override
	public List<Map<String, Object>> procPageBcreport(PagingCriteria pagingCriteria,BusinessCountReportQuery model) {
		 Map<String, Object> map = new HashMap<String, Object>();
		 map.put(BusinessCountReport.ORG_ID, StringUtils4Aoto.trim(model.getOrgId()));
		 map.put(BusinessCountReport.BUS_TYPE, StringUtils4Aoto.trim(model.getBusType()));
	     map.put(BusinessCountReport.START_DATE, StringUtils4Aoto.trim(model.getStartDate()));
	     map.put(BusinessCountReport.END_DATE, StringUtils4Aoto.trim(model.getEndDate()));
	    
        //填充分页，排序数据
        ProcPageFill.fillProcData(model, map,BusinessCountReport.class);
        //执行查询
        List<Map<String, Object>> list = businessCountReportMapper.procPageBcReport(map);
        
        //获取存储过程中返回的值
        int total = ((BigDecimal)map.get("totalrows")).intValue();
        pagingCriteria.setTotal(total);
        //获取数据集
        list = (List<Map<String, Object>>)map.get("pageDatas");
		return list;
	}

	/**
	 * 图像
	 */
	@Override
	public List<Map<String, Object>> procPageBcreportGraphic(PagingCriteria pagingCriteria,BusinessCountReportQuery model) {
		 Map<String, Object> map = new HashMap<String, Object>();
		 map.put(BusinessCountReport.ORG_ID, StringUtils4Aoto.trim(model.getOrgId()));
		 map.put(BusinessCountReport.BUS_TYPE, StringUtils4Aoto.trim(model.getBusType()));
	     map.put(BusinessCountReport.START_DATE, StringUtils4Aoto.trim(model.getStartDate()));
	     map.put(BusinessCountReport.END_DATE, StringUtils4Aoto.trim(model.getEndDate()));
	    
        //填充分页，排序数据
        ProcPageFill.fillProcData(model, map,BusinessCountReport.class);
        //执行查询
        List<Map<String, Object>> list = businessCountReportMapper.procPageBcreportGraphic(map);
        
        //获取存储过程中返回的值
       /* int total = ((BigDecimal)map.get("totalrows")).intValue();
        pagingCriteria.setTotal(total);*/
        //获取数据集
        list = (List<Map<String, Object>>)map.get("pageDatas");
		return list;
	}
}
