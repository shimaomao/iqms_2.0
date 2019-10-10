package com.aoto.iqms.report.web.controllers;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.aoto.framework.commons.beans.JsonResult;
import com.aoto.framework.commons.pagination.PagingCriteria;
import com.aoto.iqms.report.models.BusinessFlowReportQuery;
import com.aoto.iqms.report.service.inf.BusinessFlowReportService;
import com.aoto.iqms.util.ExportExcelUtil;

/**
 *业务流水报表-控制层
 * @author humz
 *
 */
@Controller
public class BusinessFlowReportController {

	@Autowired
	private BusinessFlowReportService businessFlowReportService;
	
    @RequestMapping(value = "/report/businessflow", method = RequestMethod.GET)
    public ModelAndView showBusinessFlowReport()
    {
        return new ModelAndView("report/businessflow/list");
    }
    
    /**
     * 分页查询
     * @param model
     * @return
     */
    @RequestMapping(value = "/report/businessflow", method = RequestMethod.GET,  headers = "accept=application/json")
    @ResponseBody
    public JsonResult getBusinessFlowList(BusinessFlowReportQuery model){
    	PagingCriteria pagingCriteria = new PagingCriteria(model.getPage() - 1, model.getRows(), model.getSort(),model.getOrder());
    	List<Map<String, Object>> list = businessFlowReportService.procPageBFReport(pagingCriteria, model);
    	return JsonResult.json(model.getRows(), model.getPage(),pagingCriteria.getTotal(), list);
    }
    
    /**
     * 图形数据
     * @param model
     * @return
     */
    @RequestMapping(value = "/report/businessflow/graphic", method = RequestMethod.GET,  headers = "accept=application/json")
    @ResponseBody
    public JsonResult getBusinessFlowListGraphic(BusinessFlowReportQuery model){
    	PagingCriteria pagingCriteria = new PagingCriteria(model.getPage() - 1, model.getRows(), model.getSort(), model.getOrder());
    	List<Map<String, Object>> list = businessFlowReportService.procPageBFReport(pagingCriteria, model);
    	return JsonResult.json(pagingCriteria.getTotal(), list);
    }
    
    /**
     * 数据导出功能
     * @param model
     * @return
     */
    @RequestMapping(value = "/report/businessflow/excel", method = RequestMethod.GET)
    @ResponseBody
    public void exportBusinessFlowList(BusinessFlowReportQuery model,HttpServletRequest request,HttpServletResponse response){
    	PagingCriteria pagingCriteria = new PagingCriteria(model.getPage() - 1, model.getRows(), model.getSort(),model.getOrder());
    	//通过控制页号的值为-1进行不分页查询
        List<Map<String, Object>> map = businessFlowReportService.procPageBFReport(pagingCriteria, model);
        
      //使用EXCEL表格导出工具类，调用其中的方法，将数据库字段映射到XML文件中对应的id名称中去，最后完成EXCEL表格的下载
        ExportExcelUtil ex = new ExportExcelUtil();
        try {
			ex.exportExcelOfMap(map, "businessflowreport", response,request, "yyyy-MM-dd HH:mm:ss");
		} catch (Exception e) {
			e.printStackTrace();
		}
    }
    
}
