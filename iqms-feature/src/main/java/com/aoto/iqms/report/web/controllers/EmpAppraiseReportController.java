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
import com.aoto.iqms.report.models.EmpAppraiseReportQuery;
import com.aoto.iqms.report.service.inf.EmpAppraiseReportService;
import com.aoto.iqms.util.ExportExcelUtil;

/**
 * 柜员评价报表-Controller层
 * @author humz
 *
 */
@Controller
public class EmpAppraiseReportController {
	
	@Autowired
	private EmpAppraiseReportService empAppraiseReportService; //自动注入service
	
    @RequestMapping(value = "/report/empappraise", method = RequestMethod.GET)
    public ModelAndView showEmpAppraise()
    {
        return new ModelAndView("report/empappraise/list");
    }
    
    /**
     * 分页查询
     * @param model
     * @return
     */
    @RequestMapping(value = "/report/empappraise", method = RequestMethod.GET,  headers = "accept=application/json")
    @ResponseBody
    public JsonResult getEmpAppraise(EmpAppraiseReportQuery model){
    	PagingCriteria pagingCriteria = new PagingCriteria(model.getPage() - 1, model.getRows(), model.getSort(),model.getOrder());
    	List<Map<String, Object>> list = empAppraiseReportService.procPageEAreport(pagingCriteria, model);
    	return JsonResult.json(model.getRows(), model.getPage(),pagingCriteria.getTotal(), list);
    }
    
    /**
     * 获取图形报表数据
     * @param model
     * @return
     */
    @RequestMapping(value = "/report/empappraise/graphic", method = RequestMethod.GET,  headers = "accept=application/json")
    @ResponseBody
    public JsonResult getEmpAppraiseGraphic(EmpAppraiseReportQuery model){
    	PagingCriteria pagingCriteria = new PagingCriteria(model.getPage() - 1, model.getRows(), model.getSort(), model.getOrder());
    	List<Map<String, Object>> list = empAppraiseReportService.procPageEAreport(pagingCriteria, model);
    	return JsonResult.json(pagingCriteria.getTotal(), list);
    }
    
    
    /**
     * 数据导出功能
     * @param model
     * @return
     */
    @RequestMapping(value = "/report/empappraise/excel", method = RequestMethod.GET)
    @ResponseBody
    public void exportEmpAppraise(EmpAppraiseReportQuery model,HttpServletRequest request,HttpServletResponse response){
    	PagingCriteria pagingCriteria = new PagingCriteria(model.getPage() - 1, model.getRows(), model.getSort(),model.getOrder());
    	
    	//通过控制页号的值为-1进行不分页查询
        List<Map<String, Object>> map = empAppraiseReportService.procPageEAreport(pagingCriteria, model);
        
        //使用EXCEL表格导出工具类，调用其中的方法，将数据库字段映射到XML文件中对应的id名称中去，最后完成EXCEL表格的下载
        ExportExcelUtil ex = new ExportExcelUtil();
        
        try {
			ex.exportExcelOfMap(map, "empappraisereport", response, request,"yyyy-MM-dd HH:mm:ss");
		} catch (Exception e) {
			e.printStackTrace();
		}
    }
}
