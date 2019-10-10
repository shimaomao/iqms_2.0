package com.aoto.iqms.report.service.impl;

import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.aoto.framework.commons.lang.StringUtils4Aoto;
import com.aoto.framework.commons.pagination.PagingCriteria;
import com.aoto.iqms.report.commons.constant.ReportBeanProperty.EmpAppraiseReport;
import com.aoto.iqms.report.models.EmpAppraiseReportQuery;
import com.aoto.iqms.report.persistence.inf.EmpAppraiseReportMapper;
import com.aoto.iqms.report.service.inf.EmpAppraiseReportService;
import com.aoto.iqms.util.ProcPageFill;

/**
 * 柜员评价报表-Service层接口实现类
 * @author humz
 *
 */
@Service
public class EmpAppraiseReportServiceImpl implements EmpAppraiseReportService {
	
	@Autowired
	private EmpAppraiseReportMapper empAppraiseReportMapper; 

	/**
     * 调用存储过程进行分页数据查询
     * @param map
     * @return
     */
	@Override
	public List<Map<String, Object>> procPageEAreport(PagingCriteria pagingCriteria,EmpAppraiseReportQuery model) {
		 Map<String, Object> map = new HashMap<String, Object>();
		 map.put(EmpAppraiseReport.ORG_ID, StringUtils4Aoto.trim(model.getOrgId()));
		 map.put(EmpAppraiseReport.WORK_NAME, StringUtils4Aoto.trim(model.getWorkName()));
	     map.put(EmpAppraiseReport.START_DATE, StringUtils4Aoto.trim(model.getStartDate()));
	     map.put(EmpAppraiseReport.END_DATE, StringUtils4Aoto.trim(model.getEndDate()));
	    
        //填充分页，排序数据
        ProcPageFill.fillProcData(model, map,EmpAppraiseReport.class);
        //执行查询
        List<Map<String, Object>> list = empAppraiseReportMapper.procPageEAReport(map);
        
        //获取存储过程中返回的值
        int total = ((BigDecimal)map.get("totalrows")).intValue();
        pagingCriteria.setTotal(total);
        //获取数据集
        list = (List<Map<String, Object>>)map.get("pageDatas");
		return list;
	}
}
