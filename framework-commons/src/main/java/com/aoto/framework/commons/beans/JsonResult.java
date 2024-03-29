/*
 * 版权信息：Copyright (c) 2014, Aoto. All rights reserved.
 * 文件编号：Model.java
 * 文件名称：Model.java
 * 系统编号：aotoframework
 * 系统名称：aotoframework
 * 模块编号：
 * 模块名称：
 * 作          者：jiangp
 * 完成日期：2014年5月19日
 * 设计文档：<列出相关设计文档的编号、名称。>
 * 内容摘要：<说明文件包含的类、类的性质/版型、类的状态说明、主要功能、系统相关界面、包含的区段、关键词及其一般说明、文件调用等。>
 */
package com.aoto.framework.commons.beans;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
/**
 * 〈一句话功能简述〉
 * 〈功能详细描述〉
 * @author jiangp
 * @see    [相关类/方法]（可选）
 * @since  [产品/模块版本] （必须）
 */
public final class JsonResult extends HashMap<String, Object>
{
    private static final long serialVersionUID = 6386020104518399989L;

    /**
     * [简要描述]:<br/>
     * [详细描述]:<br/>
     *
     * @author zongwj
     * @param initialCapacity int
     */
    private JsonResult(int initialCapacity)
    {
        super(initialCapacity);
    }
    
    /**
     * [简要描述]:<br/>
     * [详细描述]:<br/>
     *
     * @author zongwj
     * @param map Map<String, Object>
     */
    private JsonResult(Map<String, Object> map)
    {
        super(map);
    }
    
    /**
     * [简要描述]:<br/>
     * [详细描述]:<br/>
     * 
     * @author zongwj
     * @return JsonResult
     */
    public static JsonResult json()
    {
        return json(StringUtils.EMPTY);
    }
    
    /**
     * [简要描述]:<br/>
     * [详细描述]:<br/>
     * 
     * @author zongwj
     * @param errorCode String
     * @return JsonResult
     */
    public static JsonResult json(String errorCode)
    {
        JsonResult result = new JsonResult(1);
        result.put("errorCode", StringUtils.isEmpty(errorCode) ? StringUtils.EMPTY : errorCode);

        return result;
    }
    
    /**
     * [简要描述]:<br/>
     * [详细描述]:<br/>
     * 
     * @author zongwj
     * @param map Map<String, Object>
     * @return JsonResult
     */
    public static JsonResult json(Map<String, Object> map)
    {
        JsonResult result = new JsonResult(map);
        return result;
    }
    
    /**
     * [简要描述]:<br/>
     * [详细描述]:<br/>
     * 
     * @author zongwj
     * @param total int
     * @param list List<Map<String, Object>>
     * @return JsonResult
     */
    public static JsonResult json(int total, List<Map<String, Object>> list)
    {
        JsonResult result = new JsonResult(2);
        result.put("total", total);
        result.put("rows", list);
        
        return result;
    }
    
    
    /**
     * [简要描述]:<br/>
     * [详细描述]:<br/>
     * @author hongxz
     * hongxz 构造jqGrid插件需要的分页数据
     * @param pageSize  每页展示条数
     * @param pageNo    //当前业务号
     * @param total     //总记录数
     * @param list      //数据列表
     * @return JsonResult
     */
    public static JsonResult json(int pageSize,int pageNo,int total, List<Map<String, Object>> list) {
        JsonResult result = new JsonResult(2);
        result.put("total", total); //总记录数
        result.put("rows", list);   //列表数据
        result.put("totalPage", total%pageSize == 0?(total/pageSize):(total/pageSize)+1); //总页数
        result.put("pageNo", pageNo); //当前页
        
        return result;
    }
    
    /**
     * [简要描述]:<br/>
     * [详细描述]:<br/>
     * 
     * @author zongwj
     * @param list List<Object>
     * @param total int
     * @return JsonResult
     */
    public static JsonResult json(List<Object> list, int total)
    {
        JsonResult result = new JsonResult(2);
        result.put("total", total);
        result.put("rows", list);
        
        return result;
    }
}
