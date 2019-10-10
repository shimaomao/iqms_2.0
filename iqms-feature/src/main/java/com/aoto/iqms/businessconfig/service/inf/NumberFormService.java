package com.aoto.iqms.businessconfig.service.inf;

import java.util.List;
import java.util.Map;

import com.aoto.iqms.businessconfig.models.NumberFormModel;
import com.aoto.iqms.businessconfig.models.NumberFormQuery;

/**
 * 新增号码模板 -业务层接口
 * @author humz
 */
public interface NumberFormService {
	/**
	 * 新增号码模板
	 * @param model
	 * @return
	 */
	public String insertNumberForm(NumberFormModel model);
	
	/**
	 * 查询号码模板
	 */
	public List<Map<String, Object>> selectNumberForm(NumberFormQuery model);
	
	/**
	 * 编辑号码模板
	 */
	public String updateNumberForm(NumberFormModel model);
	
	/**
	 * 删除号码模板
	 */
	public String deleteNumberForm(NumberFormModel model);
	
	/**
     * 调用存储过程应用到下级机构
     * @param model
     * @return
     */
    public String callCopyNumberProc(NumberFormModel model);
	
}
