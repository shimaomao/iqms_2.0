package com.aoto.iqms.externals.persistence.inf;

import java.util.List;
import java.util.Map;

import com.aoto.iqms.externals.models.custident.CustIdentityReq;

public interface ResourceMapper {
	
	/**
     * 根据条件查询设备信息
     * 1、根据IP查询设备信息。
     * @param map
     */
    public List<Map<String, Object>> findDeviceByCondition(Map<String, String> map);
    
    
    /**
     * 客户识别
     * @param map
     * @return
     */
    public List<Map<String, Object>> findCustInfoByCondition(Map<String, Object> map);
    
    
    /**
     * 流水数据上报
     * @param map
     */
    public void saveFlowData(Map<String, Object> map);
    
    
    /**
     * 心跳处理
     * @param map
     */
    public void dealHeartBeat(Map<String, Object> map);
    
	/**
	 * 为pad查询流水数据
	 * @param custIdentityReq
	 * @return
	 */
	public List<Map<String, Object>> flowData4Pad(Map<String, Object> map);
	
	
	/**
	 * 为pad查询临近网点
	 * @param custIdentityReq
	 * @return
	 */
	public List<Map<String, Object>> nearOrg4Pad(Map<String, Object> map);
	
	/**
     * 柜员数据同步（软呼叫签到时做的柜员数据同步）
     * @param map
     */
    public void tellerSync(Map<String, Object> map);
    
    /**
     * 下载成功后的下载确认
     * @param map
     */
    public void patchDlConfirm(Map<String, Object> map);

    /**
     * 配置更新确认
     * @param map
     */
    public void configConfirm(Map<String, Object> map);
    
    /**
	 * 查询参数信息
	 * @return
	 */
	public List<Map<String, Object>> findParamInfo();
	
	
    /**
     * 更新设备的配置下载状态
     * @param map
     */
    public void updateDeviceConfigFlag(Map<String, Object> map);
    
}
