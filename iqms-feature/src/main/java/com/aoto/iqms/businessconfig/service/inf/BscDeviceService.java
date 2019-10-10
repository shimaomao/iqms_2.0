package com.aoto.iqms.businessconfig.service.inf;

import java.util.List;
import java.util.Map;

import com.aoto.framework.commons.pagination.PagingCriteria;
import com.aoto.iqms.businessconfig.models.BscDeviceModel;
import com.aoto.iqms.businessconfig.models.BscDeviceQuery;

/**
 * 设备管理接口
 * @author daxian
 *
 */
public interface BscDeviceService {
	
	
	/**
     * 调用存储过程进行分页数据查询
     * @param map
     * @return
     */
    public List<Map<String, Object>> procPageBscDevice(PagingCriteria pagingCriteria,BscDeviceQuery model);
	
    /**
     * 调用存储过程新增业务
     * @param model
     * @return
     */
    public String callCreateBscDeviceProc(BscDeviceModel model);
    
    /**
     * 导航配置新增设备
     * @param model
     * @return
     */
    public String callCreateNavDeviceProc(BscDeviceModel model);
    /**
     * 调用存储过程更新业务
     * @param model
     * @return
     */
    public String callUpdateBscDeviceProc(BscDeviceModel model);
    
    /**
     * 调用存储过程删除业务
     * @param model
     * @return
     */
    public String callRemoveBscDeviceProc(List<Map<String, String>> list);
    
    
    /**
     * 2015-11-25 by hongxz (自动升级)根据设备号，更新设备的当前版本号
     * @param model
     * @return
     */
    public String callUpdateDeviceCurrtVersionProc(BscDeviceModel model);
    
    /**
     * 通过条件查询列表
     * @param map
     */
    public List<Map<String, Object>> findBscDeviceByConditon(BscDeviceModel model);

    /**
     * 调用存储过程更新业务(自动升级使用)
     * @param model
     * @return
     */
	public String callUpdateBscDeviceProcForAutoUp(BscDeviceModel model);
	
	 /**
     * 20151102 by hongxz 查询设备数量
     * @param map
     */
    public Map<String, Object> findDevCount(BscDeviceModel model);
    
    
    /**
     * 通过条件查询列表(预约使用)
     * @param map
     */
    public List<Map<String, Object>> findBscDeviceForOrder(BscDeviceModel model);
    
    
    /**
     * 通过条件查询列表
     * @param map
     */
    public List<Map<String, Object>> findBscDevice4TreeByConditon(BscDeviceQuery model);
    
    
    /**
     * 通过登录系统用户的所属机构生成机构下辖设备的机构树
     * @param orgId
     * @return
     */
    public List<Map<String, Object>> ztreeOrgDevice(String orgId);
    
    /**
     * 生成快速应用所需的机构下辖设备的机构树
     * @param orgId
     * @return
     */
    public List<Map<String, Object>> ztreeFastCopy(String orgId, String deviceNo);
    
    /**
     * 通过登录系统用户的所属机构生成机构下辖设备的机构树(设备必须包含默认号票模板)
     * @param orgId
     * @return
     */
    public List<Map<String, Object>> ztreeForTicket(String orgId);
    
    /**
     * 调用存储过程应用到下级机构
     * @param model
     * @return
     */
    public String callSaveCopyProc(BscDeviceQuery model);
    
    /**
     * 快速应用
     * @param model
     * @return
     */
    public String callSaveFastCopy(BscDeviceQuery model);
    
    /**返回导航 创建设备
     * 根据设备号查询
     * @param model
     * @return
     */
    public List<Map<String, Object>> findByDeviceNo(BscDeviceQuery model);
    
    /**
     * 生成设备号
     * @return
     */
    public String createDeviceNo(BscDeviceModel model);
    
    public List<Map<String, Object>> findDeviceForOrder(String orgCode, String orderFlag);
    
}
