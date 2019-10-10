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
import com.aoto.iqms.report.models.BusinessCountReportQuery;
import com.aoto.iqms.report.service.inf.BusinessCountReportService;
import com.aoto.iqms.util.ExportExcelUtil;

/**
 * 业务量报表-控制层
 * @author humz
 *
 */

@Controller
public class BusinessCountReportController {
	
	@Autowired
	private BusinessCountReportService businessCountReportService; //自动注入service
	
    @RequestMapping(value = "/report/businesscount", method = RequestMethod.GET)
    public ModelAndView showBusinessCountReport()
    {
        return new ModelAndView("report/businesscount/list");
    }
    
    /**
     * 分页查询
     * @param model
     * @return
     */
    @RequestMapping(value = "/report/businesscount", method = RequestMethod.GET,  headers = "accept=application/json")
    @ResponseBody
    public JsonResult getBusinessCountList(BusinessCountReportQuery model){
    	PagingCriteria pagingCriteria = new PagingCriteria(model.getPage() - 1, model.getRows(), model.getSort(),model.getOrder());
    	List<Map<String, Object>> list = businessCountReportService.procPageBcreport(pagingCriteria, model);
    	return JsonResult.json(model.getRows(), model.getPage(),pagingCriteria.getTotal(), list);
    }
    
    /**
     * 图形报表数据
     * @param model
     * @return
     */
    @RequestMapping(value = "/report/businesscount/graphic", method = RequestMethod.GET,  headers = "accept=application/json")
    @ResponseBody
    public JsonResult getBusinessCountGraphic(BusinessCountReportQuery model){
    	PagingCriteria pagingCriteria = new PagingCriteria(model.getPage() - 1, model.getRows(), model.getSort(),model.getOrder());
    	List<Map<String, Object>> list = businessCountReportService.procPageBcreportGraphic(pagingCriteria, model);
    	return JsonResult.json(pagingCriteria.getTotal(), list);
    }
    
    
    
    /**
     * 数据导出功能
     * @param model
     * @return
     */
    @RequestMapping(value = "/report/businesscount/excel", method = RequestMethod.GET)
    @ResponseBody
    public void exportBusinessCountList(BusinessCountReportQuery model,HttpServletRequest request,HttpServletResponse response){
    	PagingCriteria pagingCriteria = new PagingCriteria(model.getPage() - 1, model.getRows(), model.getSort(),model.getOrder());
    	//通过控制页号的值为-1进行不分页查询
        List<Map<String, Object>> map = businessCountReportService.procPageBcreport(pagingCriteria, model);
        
        //使用EXCEL表格导出工具类，调用其中的方法，将数据库字段映射到XML文件中对应的id名称中去，最后完成EXCEL表格的下载
        ExportExcelUtil ex = new ExportExcelUtil();
        try {
			ex.exportExcelOfMap(map, "businesscountreport", response,request, "yyyy-MM-dd HH:mm:ss");
			
		} catch (Exception e) {
			e.printStackTrace();
		}
    }
}
