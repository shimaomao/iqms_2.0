package com.aoto.iqms.businessconfig.service.inf;

import java.util.List;
import java.util.Map;

import com.aoto.framework.commons.pagination.PagingCriteria;
import com.aoto.iqms.businessconfig.models.BscBranchBusinessQuery;
import com.aoto.iqms.businessconfig.models.BscCustLevelModel;
import com.aoto.iqms.businessconfig.models.BscCustLevelQuery;

/**
 * 客户等级设置接口
 * @author zhousj
 *
 */
public interface BscCustLevelService {
	/**
     * 调用存储过程进行分页数据查询
     * @param map
     * @return
     */
    public List<Map<String, Object>> procPageBscCustLevel(PagingCriteria pagingCriteria,BscCustLevelQuery model);
    
    /**
	 * 调用存储过程查询
	 * @param model
	 * @return
	 */
	public List<Map<String, Object>> procBscCustLevelQuery(BscCustLevelQuery model);
    
    /**
     * 调用存储过程新增业务 包含增改
     * @param model
     * @return
     */
    public String callCreateBscCustLevelProc(List<BscCustLevelModel> list);
    
    /**
     * 调用存储过程更新业务
     * @param model
     * @return
     */
    public String callUpdateBscCustLevelProc(BscCustLevelModel model);
    
    /**
     * 调用存储过程删除业务
     * @param model
     * @return
     */
    public String callRemoveBscCustLevelProc(List<Map<String, String>> list);
    
    /**
     * 调用存储过程应用到下级机构
     * @param model
     * @return
     */
    public String callSaveBscCustLevelProc(BscCustLevelModel model);
    
    /**
     * 执行存储过程查询custLevels.json
     * @param model
     * @return
     */
    public List<Map<String, Object>> procCustLevelsQuery(BscBranchBusinessQuery model);
    
    /**
     * 生成custLevels.json
     * @param model
     */
    public void createCustLevels(BscBranchBusinessQuery model,String path);
    
    /**
     * 一键检测：客户级别设置检测
     * @param model
     * @return
     */
    public List<Map<String, Object>> checkedCustLevel(BscCustLevelModel model);
}
