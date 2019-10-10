package com.aoto.iqms.basicconfig.service.inf;

import java.util.List;
import java.util.Map;

import com.aoto.framework.commons.pagination.PagingCriteria;
import com.aoto.iqms.basicconfig.models.TellerModel;
import com.aoto.iqms.basicconfig.models.TellerQuery;
import com.aoto.iqms.businessconfig.models.BscBranchBusinessQuery;

/**
 * 柜员管理
 * @author zhousj
 *
 */
public interface TellerService {
	/**
     * 调用存储过程进行分页数据查询
     * @param map
     * @return
     */
    public List<Map<String, Object>> procPageTeller(PagingCriteria pagingCriteria,TellerQuery model);
	
    /**
     * 调用存储过程新增业务
     * @param model
     * @return
     */
    public String callCreateTellerProc(TellerModel model);
    
    /**
     * 调用存储过程更新业务
     * @param model
     * @return
     */
    public String callUpdateTellerProc(TellerModel model);
    
    /**
     * 调用存储过程删除业务
     * @param model
     * @return
     */
    public String callRemoveTellerProc(List<String> list);
    
    /**
     * 执行存储过程查询tellers.json
     * @param model
     * @return
     */
    public List<Map<String, Object>> procTellersQuery(BscBranchBusinessQuery model);
    
    /**
     * 生成tellers.json
     * @param model
     */
    public void createTellers(BscBranchBusinessQuery model,String path);
    /**
     * 根据柜员工号查询
     * @param workId
     * @return
     */
    public List<Map<String, Object>> findTellerByWorkId(String workId);
}
