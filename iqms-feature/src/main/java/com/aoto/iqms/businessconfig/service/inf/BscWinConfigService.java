package com.aoto.iqms.businessconfig.service.inf;

import java.util.List;
import java.util.Map;

import com.aoto.framework.commons.pagination.PagingCriteria;
import com.aoto.iqms.businessconfig.models.BscBranchBusinessQuery;
import com.aoto.iqms.businessconfig.models.BscWinConfigModel;
import com.aoto.iqms.businessconfig.models.BscWinConfigQuery;

/**
 * 窗口配置接口
 * @author zhousj
 *
 */
public interface BscWinConfigService {
	/**
     * 调用存储过程进行分页数据查询
     * @param map
     * @return
     */
    public List<Map<String, Object>> procPageBscWinConfig(PagingCriteria pagingCriteria,BscWinConfigQuery model);
    
    /**
	 * 查询
	 * @param model
	 * @return
	 */
	public List<Map<String, Object>> procBscWinConfigQuery(BscWinConfigQuery model);
    
    /**
     * 调用存储过程应用到下级机构
     * @param model
     * @return
     */
    public String callCreateBscWinConfigProc(BscWinConfigModel model);
    
    /**
	 * 调用存储过程保存
	 * @param model
	 * @return
	 */
	public String procSaveWinConfig(List<BscWinConfigModel> list);
    
    /**
     * 调用存储过程更新业务
     * @param model
     * @return
     */
    public String callUpdateBscWinConfigProc(BscWinConfigModel model);
    
    /**
     * 调用存储过程删除业务
     * @param model
     * @return
     */
    public String callRemoveBscWinConfigProc(BscWinConfigModel model);
    
    /**
     * 用于解析‘机构和设备的组织树’生成包含orgId和deviceNo的map的list的公共方法
     * @param orgDevicelist
     * @return
     */
    public List<Map<String, Object>> createOrgIdDeviceNo(String orgDevicelist);
    
    /**
     * 执行存储过程生成counters.json
     * @param model
     * @return
     */
    public List<Map<String, Object>> procCountersQuery(BscBranchBusinessQuery model);
    
    /**
     * 生成counters zip包 到D:\zsj
     * @param model
     */
    public void createCounters(BscBranchBusinessQuery model,String path);
    
    /**
     * 一键检测：查询所有可用窗口
     * @param model
     * @return
     */
    public List<Map<String, Object>> checkedWinInfo(BscWinConfigModel model);
}
