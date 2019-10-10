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
import com.aoto.iqms.report.models.CusAnalyseReportQuery;
import com.aoto.iqms.report.service.inf.CusAnalyseReportService;
import com.aoto.iqms.util.ExportExcelUtil;

/**
 * 客户分析报表-控制层
 * @author humz
 *
 */

@Controller
public class CusAnalyseReportController {
	
	@Autowired
	private CusAnalyseReportService analyseReportService; //自动注入service
	
    @RequestMapping(value = "/report/cusanalyse", method = RequestMethod.GET)
    public ModelAndView showCusAnalyseReport()
    {
        return new ModelAndView("report/cusanalyse/list");
    }
    
    /**
     * 分页查询
     * @param model
     * @return
     */
    @RequestMapping(value = "/report/cusanalyse", method = RequestMethod.GET,  headers = "accept=application/json")
    @ResponseBody
    public JsonResult getCusAnalyseList(CusAnalyseReportQuery model){
    	PagingCriteria pagingCriteria = new PagingCriteria(model.getPage() - 1, model.getRows(), model.getSort(),model.getOrder());
    	List<Map<String, Object>> list = analyseReportService.procPageCAReport(pagingCriteria, model);
    	return JsonResult.json(model.getRows(), model.getPage(),pagingCriteria.getTotal(), list);
    }
    
    /**
     * 图形数据
     * @param model
     * @return
     */
    @RequestMapping(value = "/report/cusanalyse/graphic", method = RequestMethod.GET,  headers = "accept=application/json")
    @ResponseBody
    public JsonResult getCusAnalyseListGraphic(CusAnalyseReportQuery model){
    	PagingCriteria pagingCriteria = new PagingCriteria(model.getPage() - 1, model.getRows(), model.getSort(), model.getOrder());
    	List<Map<String, Object>> list = analyseReportService.procPageCAReportGraphic(pagingCriteria, model);
    	return JsonResult.json(pagingCriteria.getTotal(), list);
    }
    
    
    /**
     * 数据导出功能
     * @param model
     * @return
     */
    @RequestMapping(value = "/report/cusanalyse/excel", method = RequestMethod.GET)
    @ResponseBody
    public void exportCusAnalyseList(CusAnalyseReportQuery model,HttpServletRequest request,HttpServletResponse response){
    	PagingCriteria pagingCriteria = new PagingCriteria(model.getPage() - 1, model.getRows(), model.getSort(),model.getOrder());
    	//通过控制页号的值为-1进行不分页查询
        List<Map<String, Object>> map = analyseReportService.procPageCAReport(pagingCriteria, model);
        
      //使用EXCEL表格导出工具类，调用其中的方法，将数据库字段映射到XML文件中对应的id名称中去，最后完成EXCEL表格的下载
        ExportExcelUtil ex = new ExportExcelUtil();
        try {
			ex.exportExcelOfMap(map, "cusanalysereport", response,request, "yyyy-MM-dd HH:mm:ss");
		} catch (Exception e) {
			e.printStackTrace();
		}
    }
}
