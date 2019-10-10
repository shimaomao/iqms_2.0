package com.aoto.iqms.basicconfig.service.inf;

import java.util.List;
import java.util.Map;

import com.aoto.framework.commons.pagination.PagingCriteria;
import com.aoto.iqms.basicconfig.models.CustTypeModel;
import com.aoto.iqms.basicconfig.models.CustTypeQuery;


/**
 * 客户类型
 * @author daxian
 *
 */
public interface CustTypeService {
	
	
	/**
     * 调用存储过程进行分页数据查询
     * @param map
     * @return
     */
    public List<Map<String, Object>> procPageCustType(PagingCriteria pagingCriteria,CustTypeQuery model);
	
    /**
     * 调用存储过程新增业务
     * @param model
     * @return
     */
    public String callCreateCustTypeProc(CustTypeModel model);
    
    /**
     * 调用存储过程更新业务
     * @param model
     * @return
     */
    public String callUpdateCustTypeProc(CustTypeModel model);
    
    /**
     * 调用存储过程删除业务
     * @param model
     * @return
     */
    public String callRemoveCustTypeProc(List<String> list);
    
    /**
     * 通过条件查询列表
     * @param map
     */
    public List<Map<String, Object>> selectCustTypeByPage(PagingCriteria pagingCriteria,CustTypeQuery model);
    
    /**
     * 查询客户等级列表
     * @param map
     */
    public List<Map<String, Object>> findCusLevelInfoByConditon(CustTypeModel model);
}
