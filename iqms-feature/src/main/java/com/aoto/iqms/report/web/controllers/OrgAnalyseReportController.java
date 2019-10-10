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
import com.aoto.iqms.report.models.OrgAnalyseReportQuery;
import com.aoto.iqms.report.service.inf.OrgAnalyseReportService;
import com.aoto.iqms.util.ExportExcelUtil;


/**
 * 机构分析报表-控制层
 * @author humz
 *
 */

@Controller
public class OrgAnalyseReportController {
	
	@Autowired
	private OrgAnalyseReportService orgAnalyseReportService; //自动注入service
	
    @RequestMapping(value = "/report/organalyse", method = RequestMethod.GET)
    public ModelAndView showOrgAnalyseReport()
    {
        return new ModelAndView("report/organalyse/list");
    }
    
    /**
     * 分页查询
     * @param model
     * @return
     */
    @RequestMapping(value = "/report/organalyse", method = RequestMethod.GET,  headers = "accept=application/json")
    @ResponseBody
    public JsonResult getOrgAnalyseList(OrgAnalyseReportQuery model){
    	PagingCriteria pagingCriteria = new PagingCriteria(model.getPage() - 1, model.getRows(), model.getSort(),
                model.getOrder());
    	List<Map<String, Object>> list = orgAnalyseReportService.procPageOAReport(pagingCriteria, model);
    	
    	return JsonResult.json(model.getRows(), model.getPage(),pagingCriteria.getTotal(), list);
    }
    
    /**
     * 获取图形报表数据
     * @param model
     * @return
     */
    @RequestMapping(value = "/report/organalyse/graphic", method = RequestMethod.GET,  headers = "accept=application/json")
    @ResponseBody
    public JsonResult getOrgAnalyseListGraphic(OrgAnalyseReportQuery model){
    	PagingCriteria pagingCriteria = new PagingCriteria(model.getPage() - 1, model.getRows(), model.getSort(),
                model.getOrder());
    	List<Map<String, Object>> list = orgAnalyseReportService.procPageOAReport(pagingCriteria, model);
    	
    	return JsonResult.json(pagingCriteria.getTotal(), list);
    }
    
    
    /**
     * 数据报表导出功能
     * @param model
     * @return
     */
    @RequestMapping(value = "/report/organalyse/excel", method = RequestMethod.GET)
    @ResponseBody
    public void exportOrgAnalyseList(OrgAnalyseReportQuery model,HttpServletRequest request,HttpServletResponse response){
    	
    	PagingCriteria pagingCriteria = new PagingCriteria(model.getPage() - 1, model.getRows(), model.getSort(),model.getOrder());
    	
    	//通过控制页号的值为-1进行不分页查询
        List<Map<String, Object>> map = orgAnalyseReportService.procPageOAReport(pagingCriteria, model);
       
        //使用EXCEL表格导出工具类，调用其中的方法，将数据库字段映射到XML文件中对应的id名称中去，最后完成EXCEL表格的下载
        ExportExcelUtil ex = new ExportExcelUtil();
        
        try {
			ex.exportExcelOfMap(map, "organalysereport", response, request,"yyyy-MM-dd HH:mm:ss");
			
		} catch (Exception e) {
			e.printStackTrace();
		}
    }
}
