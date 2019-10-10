package com.aoto.iqms.businessconfig.persistence.inf;

import java.util.List;
import java.util.Map;


/**
 * 设备持久层
 * @author daxian
 *
 */
public interface BscDeviceMapper {
    
    /**
     * 调用存储过程进行分页数据查询
     * @param map
     * @return
     */
    public List<Map<String, Object>> callPageBscDevice(Map<String, Object> map);
    
    
    /**
     * 调用存储过程增加记录
     * @param map
     */
    public void callInsertBscDevice(Map<String, Object> map);
    
    /**
     * 导航配置创建设备
     * @param map
     */
    public void callInsertNavDevice(Map<String, Object> map);
    
    /**
     * 调用存储过程更新记录
     * @param map
     */
    public void callUpdteBscDevice(Map<String, Object> map);
    
    
    /**
     * 调用存储过程更新记录（自动升级成功后更新设备版本号和存储过程）
     * @param map
     */
    public void callUpdteBscDeviceForAutoUp(Map<String, Object> map);
    
    /**
     * 2015-11-25 by hongxz (自动升级)根据设备号，更新设备的当前版本号
     * @param model
     * @return
     */
    public String callUpdateDeviceCurrtVersion(Map<String, Object> map);
    
    
    /**
     * 执行存储过程进行删除操作
     * @param map
     */
    public void callDeleteBscDevice(Map<String, String> map);
    
    /**
     * 通过条件查询
     * @param map
     */
    public List<Map<String, Object>> findBscDeviceByConditon(Map<String, Object> map);
    
    /**
     * 20151102 by hongxz 查询设备数量
     * @param map
     * @return
     */
    public Map<String, Object> findDevCount(Map<String, Object> map);
    
    
    /**
     * 通过条件查询（用于预约）
     * @param map
     */
    public List<Map<String, Object>> findBscDeviceForOrder(Map<String, Object> map);

    /**
     * 查询能够更新此版本的设备树
     * @param map
     * @return
     */
    public List<Map<String, Object>> findBscDevice4PatchTree(Map<String, Object> map);
    
    /**
     * 通过登录系统用户的所属机构生成机构下辖设备的机构树
     * @param orgId
     * @return
     */
    public List<Map<String, Object>> ztreeOrgDevice(Map<String, Object> map);
    
    /**
     * 执行存储过程应用到下级机构
     * @param map
     */
    public void callCopy(Map<String, Object> map);
    
    /**
     * 获取当前序列值
     */
    public Map<String, Object> findDeviceNo();
    
    /**
     * 更新设备的配置下载状态
     * @param map
     */
    public void updateDeviceConfigFlag(Map<String, Object> map);
    
    /**
     * 调用存储过程根据设备号查询
     * @param map
     * @return
     */
    public Map<String, Object> callBscDevice(Map<String, Object> map);
    
    /**
     * 通过条件查询
     * @param map
     */
    public List<Map<String, Object>> findByDeviceNo(Map<String, Object> map);
    
    /**
     * 通过登录系统用户的所属机构生成机构下辖设备的机构树(设备必须包含默认号票模板)
     * @param orgId
     * @return
     */
    public List<Map<String, Object>> ztreeForTicket(Map<String, Object> map);
    
    /**
     * 查找机构下所有可预约的设备
     * @param map
     * @return
     */
    public List<Map<String, Object>> findDeviceForOrder(Map<String, Object> map);
    
    /**
     * 通过登录系统用户的所属机构生成快速应用需要的机构下辖设备的机构树
     * @param orgId
     * @return
     */
    public List<Map<String, Object>> ztreeFastCopy(Map<String, Object> map);
}
