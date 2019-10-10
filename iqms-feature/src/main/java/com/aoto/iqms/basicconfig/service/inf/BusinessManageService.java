package com.aoto.iqms.basicconfig.service.inf;

import java.util.List;
import java.util.Map;

import com.aoto.framework.commons.pagination.PagingCriteria;
import com.aoto.iqms.basicconfig.models.BusinessManageModel;
import com.aoto.iqms.basicconfig.models.BusinessManageQuery;
import com.aoto.iqms.basicconfig.models.CustTypeModel;

/**
 * 业务管理Service层接口
 * @author humz
 *
 */
public interface BusinessManageService {

	 /**
     * 通过条件查询列表
     * @param map
     */
    public List<Map<String, Object>> selectBusManageByPage(PagingCriteria pagingCriteria,BusinessManageQuery model);
    
	/**
     * 调用存储过程进行分页数据查询
     * @param map
     * @return
     */
    public List<Map<String, Object>> procPageBusManage(PagingCriteria pagingCriteria,BusinessManageQuery model);
	
    /**
     * 调用存储过程新增业务
     * @param model
     * @return
     */
    public String callCreateBusManageProc(BusinessManageModel model);
    
    /**
     * 调用存储过程更新业务
     * @param model
     * @return
     */
    public String callUpdateBusManageProc(BusinessManageModel model);
    
    /**
     * 调用存储过程删除业务
     * @param model
     * @return
     */
    public String callRemoveBusManageProc(List<String> list);
    
    /**
     * 查询业务类型列表
     * @param map
     */
    public List<Map<String, Object>> findBusManageByConditon(BusinessManageModel model);
    
    /**
     * 查询所有
     * @return
     */
    public List<Map<String, Object>> selectBusManage();
    
    /**
     * 根据busId 查询数据
     * @param busId
     * @return
     */
    public List<Map<String, Object>> findBusManageById(String busId);
}