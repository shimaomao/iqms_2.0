package com.aoto.iqms.util;

import java.util.Map;

import com.aoto.framework.commons.pagination.PaginationQuery;
import com.aoto.framework.commons.pagination.PagingCriteria;
import com.aoto.iqms.basicconfig.commons.constant.BasicconfigBeanProperty.PageInfo;

public class ProcPageFill {
	/**
	 * 填充分页的属性，同时将排序字段的值转换成数据库的字段名
	 * @param pagingCriteria
	 * @param map
	 */
	public static void fillProcData(PaginationQuery model, Map map,Class clazz){
        map.put(PageInfo.PAGEINDEX, model.getPage());
		map.put(PageInfo.PAGESIZE, model.getRows());
		
		//获取去排序字段
		String dbClomun = "";
		try {
			 dbClomun = MapField.getFieldName(clazz, model.getSort());
		} catch (IllegalArgumentException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IllegalAccessException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		map.put(PageInfo.SORTFIELD, dbClomun); //排序字段
		map.put(PageInfo.SORTDERECTION, model.getOrder()); //排序方向
		
	}
}
