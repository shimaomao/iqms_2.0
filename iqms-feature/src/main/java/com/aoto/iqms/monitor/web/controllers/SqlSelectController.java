package com.aoto.iqms.monitor.web.controllers;

import java.sql.Date;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.aoto.framework.commons.beans.JsonResult;
import com.aoto.framework.commons.pagination.PagingCriteria;
import com.aoto.iqms.monitor.models.SqlSelectQuery;
import com.aoto.iqms.monitor.service.inf.SqlSelectService;

/**
 * 数据监控控制层（sql查询）
 * @author tianjm 20190304
 */
@Controller
public class SqlSelectController {
	@Autowired
	private SqlSelectService sqlSelectService;
	
	/**
	 * 进入数据监控页面
	 * @return
	 */
	@RequestMapping(value = "/monitor/sqlselect", method = RequestMethod.GET)
	public ModelAndView enterSqlSelectPage(){
		return new ModelAndView("/monitor/sqlselect/list");
	}
	
	/**
	 * 查询数据监控分页
	 * @param model
	 * @return
	 */
	/*@RequestMapping(value = "/monitor/sqlselect", method = RequestMethod.GET, headers = "accept=application/json")
	@ResponseBody
	public JsonResult getWinMonitorList(SqlSelectQuery model){
		if(model.getSelectInfo() == null){
    		model.setSelectInfo("");
    	}
		PagingCriteria  pagingCriteria = new PagingCriteria(model.getPage()-1, model.getRows(), model.getSort(), 
				model.getOrder());
		List<Map<String, Object>> list = sqlSelectService.procPageSqlSelect(pagingCriteria, model);
		return JsonResult.json(model.getRows(), model.getPage(), pagingCriteria.getTotal(), list);
	}*/
	/**
	 * 查询数据监控分页
	 * @param model
	 * @return
	 * @throws SQLException 
	 */
	@RequestMapping(value = "/monitor/sqlselect", method = RequestMethod.GET, headers = "accept=application/json")
	@ResponseBody
	public JsonResult getWinMonitorList(SqlSelectQuery model) throws SQLException{
//		public List<Map<String, Object>> getWinMonitorList(SqlSelectQuery model) throws SQLException{
		if(model.getSelectInfo() == null){
			model.setSelectInfo("");
		}
		PagingCriteria  pagingCriteria = new PagingCriteria(model.getPage()-1, model.getRows(), model.getSort(), 
				model.getOrder());
		List<Map<String, Object>> list = sqlSelectService.procPageSqlSelect(pagingCriteria, model);
		return JsonResult.json(model.getRows(), model.getPage(), pagingCriteria.getTotal(), list);
	}
}
