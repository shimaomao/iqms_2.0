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
import com.aoto.iqms.report.models.AbandonRateReportQuery;
import com.aoto.iqms.report.service.inf.AbandonRateReportService;
import com.aoto.iqms.util.ExportExcelUtil;

/**
 * 弃票率报表-控制层
 * @author tianjm 20181128
 */

@Controller
public class AbandonRateReportController {
	
	@Autowired
	private AbandonRateReportService abandonRateReportService; //自动注入service
	
    @RequestMapping(value = "/report/abandonrate", method = RequestMethod.GET)
    public ModelAndView showAbandonRateReport()
    {
        return new ModelAndView("report/abandonrate/list");
    }
    
   /**
     * 分页查询
     * @param model
     * @return
     */
    @RequestMapping(value = "/report/abandonrate", method = RequestMethod.GET,  headers = "accept=application/json")
    @ResponseBody
    public JsonResult getCusAnalyseList(AbandonRateReportQuery model){
    	PagingCriteria pagingCriteria = new PagingCriteria(model.getPage() - 1, model.getRows(), model.getSort(),model.getOrder());
    	List<Map<String, Object>> list = abandonRateReportService.procPageARReport(pagingCriteria, model);
    	return JsonResult.json(model.getRows(), model.getPage(),pagingCriteria.getTotal(), list);
    }
    
    /**
     * 图形数据
     * @param model
     * @return
     */
    @RequestMapping(value = "/report/abandonrate/graphic", method = RequestMethod.GET,  headers = "accept=application/json")
    @ResponseBody
    public JsonResult getCusAnalyseListGraphic(AbandonRateReportQuery model){
    	PagingCriteria pagingCriteria = new PagingCriteria(model.getPage() - 1, model.getRows(), model.getSort(), model.getOrder());
    	List<Map<String, Object>> list = abandonRateReportService.procPageARReportGraphic(pagingCriteria, model);
    	return JsonResult.json(pagingCriteria.getTotal(), list);
    }
    
    
    /**
     * 数据导出功能
     * @param model
     * @return
     */
    @RequestMapping(value = "/report/abandonrate/excel", method = RequestMethod.GET)
    @ResponseBody
    public void exportCusAnalyseList(AbandonRateReportQuery model,HttpServletRequest request,HttpServletResponse response){
    	PagingCriteria pagingCriteria = new PagingCriteria(model.getPage() - 1, model.getRows(), model.getSort(),model.getOrder());
    	//通过控制页号的值为-1进行不分页查询
        List<Map<String, Object>> map = abandonRateReportService.procPageARReport(pagingCriteria, model);
        
      //使用EXCEL表格导出工具类，调用其中的方法，将数据库字段映射到XML文件中对应的id名称中去，最后完成EXCEL表格的下载
        ExportExcelUtil ex = new ExportExcelUtil();
        try {
			ex.exportExcelOfMap(map, "abandonratereport", response,request, "yyyy-MM-dd HH:mm:ss");
		} catch (Exception e) {
			e.printStackTrace();
		}
    }
}
