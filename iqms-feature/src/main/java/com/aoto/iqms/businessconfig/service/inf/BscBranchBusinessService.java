package com.aoto.iqms.businessconfig.service.inf;
import java.util.List;
import java.util.Map;

import com.aoto.iqms.businessconfig.models.BscBranchBusinessModel;
import com.aoto.iqms.businessconfig.models.BscBranchBusinessQuery;
/**
 * 网点业务接口
 * @author zhousj
 *
 */
public interface BscBranchBusinessService {
	/**
	 * 生成以菜单和业务为根节点的ztree
	 */
	public List<Map<String, Object>> ztreeMenuBusiness();
	
	/**
	 * 调用存储过程查询网点业务表数据
	 * 加载 网点业务 组织树
	 * @param model
	 * @return
	 */
	public List<Map<String, Object>> procBrancBusinessTree(BscBranchBusinessQuery model);
	
	/**
	 * 调用存储过程查询网点业务表数据
	 * @param model
	 * @return
	 */
	public List<Map<String, Object>> procBrancBusiness(BscBranchBusinessQuery model);
	
	/**
     * 调用存储过程新增业务
     * @param model
     * @return
     */
    public String callCreateBscBranchBusProc(BscBranchBusinessModel model);
    
    /**
     * 调用存储过程更新业务
     * @param model
     * @return
     */
    public String callUpdateBscBranchBusProc(BscBranchBusinessModel model);
    
    /**
     * 调用存储过程删除业务
     * @param model
     * @return
     */
    public String callRemoveBscBranchBusProc(String orgId, String deviceNo, String treeId);
    
    /**
     * 执行存储过程应用到下级机构
     * @param map
     */
    public String callCopyBscBranchBus(BscBranchBusinessModel model);
    
    /**
     * 执行存储过程生成buzType.json
     * @param model
     * @return
     */
    public List<Map<String, Object>> procBuzTypeQuery(BscBranchBusinessQuery model);
    
    /**
     * 生成buzList zip包 到D:\zsj
     * @param model
     */
    public String createBuzList(BscBranchBusinessQuery model);
    
    /**
     * 执行存储过程生成buzType.json
     * @param model
     * @return
     */
    public List<Map<String, Object>> procBuzQuery(BscBranchBusinessQuery model); 
    
    /**
     * 执行存储过程查询节点层级
     * @param model
     * @return
     */
    public List<Map<String, Object>> procLevelQuery(BscBranchBusinessModel model);
    
    /**
     * 执行存储过程查询所有业务
     * @param model
     * @return
     */
    public List<Map<String, Object>> procBusiness(BscBranchBusinessModel model);
    /**
     * 厅堂易请求查询业务相关信息
     * @param orgCode
     * @param deviceNo
     * @param dateType
     * @return
     */
    public List<Map<String, Object>> findBusysForHallMarket(String orgCode, String deviceNo);
    
}
