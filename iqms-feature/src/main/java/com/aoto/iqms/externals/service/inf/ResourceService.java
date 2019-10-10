package com.aoto.iqms.externals.service.inf;

import java.util.List;
import java.util.Map;

import com.aoto.iqms.externals.models.custident.CustIdentityReq;
import com.aoto.iqms.externals.models.deviceheartbeat.DevHeartbeatDataReq;
import com.aoto.iqms.externals.models.deviceheartbeat.DevHeartbeatDataResp;
import com.aoto.iqms.externals.models.flowdata.FlowData;
import com.aoto.iqms.externals.models.patchdlconfirm.PatchDlConfirmReq;
import com.aoto.iqms.externals.models.syncteller.TellerSyncReq;



public interface ResourceService {
	
	
	/**
     * 根据条件查询设备
     * @param map
     */
    public List<Map<String, Object>> findDeviceByConditon(Map<String, String> map);
    
    
    /**
	 * 调用存储过程（保存客户端记录数据）
	 * @param model
	 * @return
	 */
	public String insertTrxtodayProc(FlowData model);
	
	/**
	 * 处理设备心跳
	 * @param map
	 * @return
	 */
	public DevHeartbeatDataResp dealHeartbeat(DevHeartbeatDataReq dataReq);
	
	/**
	 * 客户识别
	 * @param map
	 * @return
	 */
	public List<Map<String, Object>> custIdentify(CustIdentityReq custIdentityReq);
	
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
	 * 查询参数信息
	 * @return
	 */
	public List<Map<String, Object>> findParamInfo();
	
	/**
	 * 柜员数据同步（软呼叫签到）
	 * @param map
	 */
	public String tellerSync(TellerSyncReq tellerSyncReq);
	
	
	/**
	 * 下载成功后的下载确认
	 * @param map
	 */
	public String patchDlConfirm(PatchDlConfirmReq patchDlConfirmReq);
	
	
	/**
	 * 配置更新确认
	 * @param map
	 */
	public String configConfirm(String deviceId);
    
    
	/**
     * 更新设备的配置下载状态
     * @param map
     */
    public void updateDeviceConfigFlag(String deviceId,String updateFlag);
   
}
