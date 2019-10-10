package com.aoto.iqms.report.service.impl;

import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.aoto.framework.commons.lang.StringUtils4Aoto;
import com.aoto.framework.commons.pagination.PagingCriteria;
import com.aoto.iqms.report.commons.constant.ReportBeanProperty.ComeTimeReport;
import com.aoto.iqms.report.models.ComeTimeReportQuery;
import com.aoto.iqms.report.persistence.inf.ComeTimeReportMapper;
import com.aoto.iqms.report.service.inf.ComeTimeReportService;
import com.aoto.iqms.util.ProcPageFill;

/**
 * 客户来行时间报表-业务层实现
 * @author humz
 *
 */
@Service
public class ComeTimeReportServiceImpl implements  ComeTimeReportService{
	
	@Autowired
	private ComeTimeReportMapper comeTimeReportMapper; 

	/**
     * 调用存储过程进行分页数据查询
     * @param map
     * @return
     */
	@Override
	public List<Map<String, Object>> procPageComeTimeReport(PagingCriteria pagingCriteria,ComeTimeReportQuery model) {
		 Map<String, Object> map = new HashMap<String, Object>();
		 map.put(ComeTimeReport.ORG_ID, StringUtils4Aoto.trim(model.getOrgId()));
	     map.put(ComeTimeReport.START_DATE, StringUtils4Aoto.trim(model.getStartDate()));
	     map.put(ComeTimeReport.END_DATE, StringUtils4Aoto.trim(model.getEndDate()));
	     
        //填充分页，排序数据
        ProcPageFill.fillProcData(model, map,ComeTimeReport.class);
        //执行查询
        List<Map<String, Object>> list = comeTimeReportMapper.procPageComeTimeReport(map);
        
        //获取存储过程中返回的值
        int total = ((BigDecimal)map.get("totalrows")).intValue();
        pagingCriteria.setTotal(total);
        //获取数据集
        list = (List<Map<String, Object>>)map.get("pageDatas");
		return list;
	}
}
