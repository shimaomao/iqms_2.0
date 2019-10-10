package com.aoto.iqms.report.service.impl;

import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.aoto.framework.commons.lang.StringUtils4Aoto;
import com.aoto.framework.commons.pagination.PagingCriteria;
import com.aoto.iqms.report.commons.constant.ReportBeanProperty.AbandonRateReport;
import com.aoto.iqms.report.commons.constant.ReportBeanProperty.CusAnalyseReport;
import com.aoto.iqms.report.models.AbandonRateReportQuery;
import com.aoto.iqms.report.persistence.inf.AbandonRateReportMapper;
import com.aoto.iqms.report.service.inf.AbandonRateReportService;
import com.aoto.iqms.util.ProcPageFill;

/**
 * 弃票率报表-业务层实现
 * @author tianjm 20181128
 */
@Service
public class AbandonRateReportServiceImpl implements AbandonRateReportService {
	
	@Autowired
	private AbandonRateReportMapper abandonRateReportMapper; 

	/**
     * 调用存储过程进行分页数据查询
     * @param map
     * @return
     */
	@Override
	public List<Map<String, Object>> procPageARReport(PagingCriteria pagingCriteria,AbandonRateReportQuery model) {
		Map<String, Object> map = new HashMap<String, Object>();
		 map.put(AbandonRateReport.ORG_ID, StringUtils4Aoto.trim(model.getOrgId()));
	     map.put(AbandonRateReport.BUS_TYPE, StringUtils4Aoto.trim(model.getBusType()));
	     map.put(AbandonRateReport.START_DATE, StringUtils4Aoto.trim(model.getStartDate()));
	     map.put(AbandonRateReport.END_DATE, StringUtils4Aoto.trim(model.getEndDate()));

        //填充分页，排序数据
        ProcPageFill.fillProcData(model, map,CusAnalyseReport.class);
        //执行查询
        List<Map<String, Object>> list = abandonRateReportMapper.procPageARReport(map);
        
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
	public List<Map<String, Object>> procPageARReportGraphic(PagingCriteria pagingCriteria,AbandonRateReportQuery model) {
		 Map<String, Object> map = new HashMap<String, Object>();
		 map.put(CusAnalyseReport.ORG_ID, StringUtils4Aoto.trim(model.getOrgId()));
	     map.put(AbandonRateReport.BUS_TYPE, StringUtils4Aoto.trim(model.getBusType()));
	     map.put(CusAnalyseReport.START_DATE, StringUtils4Aoto.trim(model.getStartDate()));
	     map.put(CusAnalyseReport.END_DATE, StringUtils4Aoto.trim(model.getEndDate()));

       //填充分页，排序数据
       ProcPageFill.fillProcData(model, map,CusAnalyseReport.class);
       //执行查询
       List<Map<String, Object>> list = abandonRateReportMapper.procARReportGraphic(map);
       
       //获取存储过程中返回的值
      /* int total = ((BigDecimal)map.get("totalrows")).intValue();
       pagingCriteria.setTotal(total);*/
       //获取数据集
       list = (List<Map<String, Object>>)map.get("pageDatas");
	   return list;
	}

}
