package com.aoto.iqms.basicconfig.web.controllers;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.aoto.framework.commons.beans.JsonResult;
import com.aoto.framework.commons.pagination.PagingCriteria;
import com.aoto.iqms.basicconfig.models.MenuModel;
import com.aoto.iqms.basicconfig.models.MenuQuery;
import com.aoto.iqms.basicconfig.service.inf.MenuService;

/**
 * 菜单控制层
 * @author zhousj
 *
 */
@Controller
public class BcMenuController {
    @Autowired
    private MenuService menuService;
    
    /**
     * 进入菜单页面
     * @return
     */
    @RequestMapping(value = "/basicconfig/menu", method = RequestMethod.GET)
    public ModelAndView enterMenuPage(){
        return new ModelAndView("basicconfig/menu/list");
    }
    
    /**
     * 菜单分页
     * @param model
     * @return
     */
    @RequestMapping(value = "/basicconfig/menu", method = RequestMethod.GET, headers = "accept=application/json")
    @ResponseBody
    public JsonResult getMenuPageList(MenuQuery model){
        PagingCriteria pagingCriteria = new PagingCriteria(model.getPage()-1, model.getRows(), model.getSort(), 
        		model.getOrder());
        List<Map<String, Object>> list = menuService.procPageMenu(pagingCriteria, model);
        return JsonResult.json(model.getRows(), model.getPage(), pagingCriteria.getTotal(), list);
    }
    
    /**
     * 新增菜单
     * @param model
     * @return
     */
    @RequestMapping(value = "/basicconfig/menu", method = RequestMethod.POST)
    @ResponseBody
    public JsonResult createMenu(MenuModel model){
    	String errorCode = menuService.callCreateMenuProc(model);
    	return JsonResult.json(errorCode);
    }
    
    /**
     * 编辑菜单
     * @param model
     * @return
     */
    @RequestMapping(value = "/basicconfig/menu", method = RequestMethod.PUT)
    @ResponseBody
    public JsonResult editMenu(MenuModel model){
        String errorCode = menuService.callUpdateBcMenuProc(model);
        return JsonResult.json(errorCode);
    }
    
    /**
     * 删除菜单
     * @param list
     * @return
     */
    @RequestMapping(value = "/basicconfig/menu", method = RequestMethod.DELETE)
    @ResponseBody
    public JsonResult removeMenu(@RequestBody List<String> list){
        String errorCode = menuService.callRemoveMenuProc(list);
        return JsonResult.json(errorCode);
    }
    
    /**
     * 删除菜单前查询是否有网点正在使用该菜单
     * @param list
     * @return
     */
    @RequestMapping(value = "/basicconfig/menuQuery", method = RequestMethod.DELETE)
    @ResponseBody
    public JsonResult queryMenu(@RequestBody List<String> list){
        String errorCode = menuService.callQueryMenuProc(list);
        return JsonResult.json(errorCode);
    }
}
