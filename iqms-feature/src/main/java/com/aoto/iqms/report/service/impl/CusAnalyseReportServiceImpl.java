package com.aoto.iqms.report.service.impl;

import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.aoto.framework.commons.lang.StringUtils4Aoto;
import com.aoto.framework.commons.pagination.PagingCriteria;
import com.aoto.iqms.report.commons.constant.ReportBeanProperty.CusAnalyseReport;
import com.aoto.iqms.report.models.CusAnalyseReportQuery;
import com.aoto.iqms.report.persistence.inf.CusAnalyseReportMapper;
import com.aoto.iqms.report.service.inf.CusAnalyseReportService;
import com.aoto.iqms.util.ProcPageFill;

/**
 * 客户分析报表-业务层实现
 * @author humz
 *
 */
@Service
public class CusAnalyseReportServiceImpl implements CusAnalyseReportService {
	
	@Autowired
	private CusAnalyseReportMapper analyseReportMapper; 

	/**
     * 调用存储过程进行分页数据查询
     * @param map
     * @return
     */
	@Override
	public List<Map<String, Object>> procPageCAReport(PagingCriteria pagingCriteria,CusAnalyseReportQuery model) {
		Map<String, Object> map = new HashMap<String, Object>();
		 map.put(CusAnalyseReport.ORG_ID, StringUtils4Aoto.trim(model.getOrgId()));
	     map.put(CusAnalyseReport.CUST_LEVEL, StringUtils4Aoto.trim(model.getCustLevel()));
	     map.put(CusAnalyseReport.START_DATE, StringUtils4Aoto.trim(model.getStartDate()));
	     map.put(CusAnalyseReport.END_DATE, StringUtils4Aoto.trim(model.getEndDate()));

        //填充分页，排序数据
        ProcPageFill.fillProcData(model, map,CusAnalyseReport.class);
        //执行查询
        List<Map<String, Object>> list = analyseReportMapper.procPageCAReport(map);
        
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
	public List<Map<String, Object>> procPageCAReportGraphic(PagingCriteria pagingCriteria,CusAnalyseReportQuery model) {
		 Map<String, Object> map = new HashMap<String, Object>();
		 map.put(CusAnalyseReport.ORG_ID, StringUtils4Aoto.trim(model.getOrgId()));
	     map.put(CusAnalyseReport.CUST_LEVEL, StringUtils4Aoto.trim(model.getCustLevel()));
	     map.put(CusAnalyseReport.START_DATE, StringUtils4Aoto.trim(model.getStartDate()));
	     map.put(CusAnalyseReport.END_DATE, StringUtils4Aoto.trim(model.getEndDate()));

       //填充分页，排序数据
       ProcPageFill.fillProcData(model, map,CusAnalyseReport.class);
       //执行查询
       List<Map<String, Object>> list = analyseReportMapper.procCAReportGraphic(map);
       
       //获取存储过程中返回的值
      /* int total = ((BigDecimal)map.get("totalrows")).intValue();
       pagingCriteria.setTotal(total);*/
       //获取数据集
       list = (List<Map<String, Object>>)map.get("pageDatas");
	   return list;
	}

}
