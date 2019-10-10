package com.aoto.iqms.report.service.impl;

import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.aoto.framework.commons.lang.StringUtils4Aoto;
import com.aoto.framework.commons.pagination.PagingCriteria;
import com.aoto.iqms.report.commons.constant.ReportBeanProperty.EmpEfficiencyReport;
import com.aoto.iqms.report.models.EmpEfficiencyReportQuery;
import com.aoto.iqms.report.persistence.inf.EmpEfficiencyReportMapper;
import com.aoto.iqms.report.service.inf.EmpEfficiencyReportService;
import com.aoto.iqms.util.ProcPageFill;

/**
 * 柜员效率报表-Service层接口实现类
 * @author humz
 *
 */
@Service
public class EmpEfficiencyReportServiceImpl implements EmpEfficiencyReportService {
	
	@Autowired
	private EmpEfficiencyReportMapper empEfficiencyReportMapper; 

	/**
     * 调用存储过程进行分页数据查询
     * @param map
     * @return
     */
	@Override
	public List<Map<String, Object>> procPageEEreport(PagingCriteria pagingCriteria,EmpEfficiencyReportQuery model) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put(EmpEfficiencyReport.ORG_ID, StringUtils4Aoto.trim(model.getOrgId()));
	    map.put(EmpEfficiencyReport.WORK_NAME, StringUtils4Aoto.trim(model.getWorkName()));
	    map.put(EmpEfficiencyReport.START_DATE, StringUtils4Aoto.trim(model.getStartDate()));
	    map.put(EmpEfficiencyReport.END_DATE, StringUtils4Aoto.trim(model.getEndDate()));
	

	     //填充分页，排序数据
        ProcPageFill.fillProcData(model, map,EmpEfficiencyReport.class);
        //执行查询
        List<Map<String, Object>> list = empEfficiencyReportMapper.procPageEEReport(map);
        
        //获取存储过程中返回的值
        int total = ((BigDecimal)map.get("totalrows")).intValue();
        pagingCriteria.setTotal(total);
        //获取数据集
        list = (List<Map<String, Object>>)map.get("pageDatas");
		return list;
	}
}
