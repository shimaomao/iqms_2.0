package com.aoto.iqms.externals.service.imp;

import java.util.Date;
import java.util.HashMap;

import java.util.List;
import java.util.Map;

import org.apache.commons.lang.time.DateFormatUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.aoto.iqms.businessconfig.models.BscDeviceModel;
import com.aoto.iqms.externals.models.custident.CustIdentityReq;
import com.aoto.iqms.externals.models.deviceheartbeat.DevHeartbeatDataReq;
import com.aoto.iqms.externals.models.deviceheartbeat.DevHeartbeatDataResp;
import com.aoto.iqms.externals.models.flowdata.FlowData;
import com.aoto.iqms.externals.models.patchdlconfirm.PatchDlConfirmReq;
import com.aoto.iqms.externals.models.syncteller.TellerSyncReq;
import com.aoto.iqms.externals.persistence.inf.ResourceMapper;
import com.aoto.iqms.externals.service.inf.ResourceService;
import com.aoto.iqms.report.commons.constant.ReportBeanProperty.Trxtoday;


@Service
@Transactional
public class ResourceServiceImp implements ResourceService {
	 private static final Logger logger = LoggerFactory.getLogger(ResourceServiceImp.class);
	@Autowired
	private ResourceMapper resourceMapper;

	/**
	 * 根据条件查询设备信息
	 */
	@Override
	public List<Map<String, Object>> findDeviceByConditon(Map<String, String> map) {
    	List<Map<String, Object>> list = resourceMapper.findDeviceByCondition(map);
    	return list;
	}
	

	/**
	 * 流水数据保存
	 */
	@Override
	public String insertTrxtodayProc(FlowData model) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put(Trxtoday.ORG_ID, model.getTransNet());
		map.put(Trxtoday.DEVICE_NO, model.getDeviceId());
		map.put(Trxtoday.TRX_DATE, model.getTickDate().replace("-", ""));
		map.put(Trxtoday.FLOW_NO, model.getFlowId());
		map.put(Trxtoday.BUS_ID, model.getBuzTypeId());
		map.put(Trxtoday.BUS_TYPE, model.getBuzCode());
		map.put(Trxtoday.CUST_TYPE, model.getCustLevel());
		map.put(Trxtoday.PDJ_LEVEL, model.getCustPrefix());
		map.put(Trxtoday.TICKET_TYPE, model.getFetchType());
		map.put(Trxtoday.TICKET_NO, model.getTickNo());
		map.put(Trxtoday.CUST_ID, model.getCustId());
		map.put(Trxtoday.CARD_TYPE, model.getMediaType());
		map.put(Trxtoday.CARD_NO, model.getCertNo());
		map.put(Trxtoday.MANAGER_NO, "");
		map.put(Trxtoday.TRX_TYPE, model.getType());
		map.put(Trxtoday.TRX_STATUS, model.getTickNoStatus());
		map.put(Trxtoday.PRINT_TIME, model.getFetchedDate());
		map.put(Trxtoday.CALL_TIME, model.getCalledDate());
		map.put(Trxtoday.BEGIN_TIME, model.getStartDate());
		map.put(Trxtoday.END_TIME, model.getFinishedDate());
		map.put(Trxtoday.APP_VALUE, model.getRate());
		map.put(Trxtoday.WIN_NO, model.getCounterNo());
		map.put(Trxtoday.TELLER_NO, model.getTellerNo());
		map.put(Trxtoday.RECALL_COUNT, model.getRecallNo());
		map.put(Trxtoday.PAUSE_BEGINTIME, model.getPauseDate());
		map.put(Trxtoday.PAUSE_ENDTIME, model.getFinishedpauseDate());
		map.put(Trxtoday.CALL_TYPE, model.getCallType());
		map.put(Trxtoday.TRANSFER_COUNT, model.getTransferNo());
		map.put(Trxtoday.BUZ_FLAG, model.getBuzFlag());
		
		map.put(Trxtoday.EXTEND1, "");
		map.put(Trxtoday.EXTEND2, "");
		map.put(Trxtoday.EXTEND3, "");
		//map.put("ReturnCode", "");
		
		//调用持久化方法
		try {
			resourceMapper.saveFlowData(map);
			//获取存储过程的输出参数
			Object obj = map.get("ReturnCode");
			if (obj != null){
				if (obj.toString().equals("0")){
					return "成功";
				} else {
					return "失败";
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			return "失败";
		}
		
		return "成功";
	}

	
	/**
	 * 处理设备心跳
	 */
	@Override
	public DevHeartbeatDataResp dealHeartbeat(DevHeartbeatDataReq model) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("orgId", model.getTransNet());
		map.put("deviceNo", model.getDeviceId());
		map.put("cpuRatio", model.getCpuRatio());
		map.put("memRatio", model.getMemRatio());
		map.put("diskRatio", model.getDiskRatio());
		map.put("versionSeq", model.getVersionSeq());
		map.put("thermalPrinterStatus", model.getThermalPrinterStatus());
		map.put("needlePrinterStatus", model.getNeedlePrinterStatus());
		map.put("idReaderStatus", model.getIdReaderStatus());
		map.put("swReadStatus", model.getSwReadStatus());
		map.put("icReaderStatus", model.getIcReaderStatus());
		map.put("barStatus", model.getBarStatus());
		map.put("compStatus", model.getCompStatus());
		
		resourceMapper.dealHeartBeat(map);
		
		//获取返回值
		String configUpdaeFlag = map.get("configUpdaeFlag").toString();//是否有配置更新
		String clientUpdateFlag = map.get("clientUpdateFlag").toString();
		String clentiVerSeq = map.get("clentiVerSeq") == null ? "" : map.get("clentiVerSeq").toString();
		String clientVerName = map.get("clientVerName") == null ? "" : map.get("clientVerName").toString();
		String clientPatchMd5 = map.get("clientPatchMd5") == null ? "" : map.get("clientPatchMd5").toString();
		String hearBeatInterval = map.get("hearBeatInterval").toString();
		String authenticationType = map.get("authenticationType").toString();
		String returnCodeObj = map.get("ReturnCode").toString();
		
		//封装返回的对象
		DevHeartbeatDataResp devHeartbeatDataResp = new DevHeartbeatDataResp();
		devHeartbeatDataResp.setClentiVerSeq(clentiVerSeq);
		devHeartbeatDataResp.setClientPatchMd5(clientPatchMd5);
		devHeartbeatDataResp.setClientUpdateFlag(clientUpdateFlag);
		devHeartbeatDataResp.setClientVerName(clientVerName);
		devHeartbeatDataResp.setConfigUpdaeFlag(configUpdaeFlag);
		devHeartbeatDataResp.setHearBeatInterval(hearBeatInterval);
		devHeartbeatDataResp.setAuthenticationType(authenticationType);
		devHeartbeatDataResp.setServerTime(DateFormatUtils.format(new Date(), "yyyy-MM-dd HH:mm:ss"));
		
		
		return devHeartbeatDataResp;
	}


	/**
	 * 客户识别
	 */
	public List<Map<String, Object>> custIdentify(CustIdentityReq custIdentityReq) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("mediaId", custIdentityReq.getMediaId());
		List<Map<String, Object>> list = resourceMapper.findCustInfoByCondition(map);
		return list;
	}
	
	
	/**
	 * 根据条件查询设备信息
	 */
	@Override
	public List<Map<String, Object>> flowData4Pad(Map<String, Object> map) {
    	List<Map<String, Object>> list = resourceMapper.flowData4Pad(map);
    	list = (List<Map<String, Object>>) map.get("pageDatas");
    	return list;
	}
	
	
	/**
	 * 根据条件查询设备信息
	 */
	@Override
	public List<Map<String, Object>> nearOrg4Pad(Map<String, Object> map) {
		List<Map<String, Object>> list = resourceMapper.nearOrg4Pad(map);
		list = (List<Map<String, Object>>) map.get("pageDatas");
		return list;
	}


	@Override
	public String tellerSync(TellerSyncReq model) {
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("orgId", model.getOrgId());
		map.put("workId", model.getWorkId());
		map.put("name", model.getName());
		map.put("sex", model.getSex());
		map.put("status", model.getStatus());
		map.put("callerPwd", model.getCallerPwd());
		
		resourceMapper.tellerSync(map);
		
		//获取返回值
		String returnCodeObj = map.get("ReturnCode").toString();
		
		return returnCodeObj;
	}


	public String patchDlConfirm(PatchDlConfirmReq model) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("deviceId", model.getDeviceId());
		map.put("versionSeq", model.getVersionSeq());
		
		resourceMapper.patchDlConfirm(map);
		
		//获取返回值
		String returnCodeObj = map.get("ReturnCode").toString();
		
		return returnCodeObj;
		
	}
	
	public String configConfirm(String deviceId) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("deviceId", deviceId);
		
		resourceMapper.configConfirm(map);
		
		//获取返回值
		String returnCodeObj = map.get("ReturnCode").toString();
		
		return returnCodeObj;
		
	}
	
	/**
	 * 查询参数信息
	 */
	@Override
	public List<Map<String, Object>> findParamInfo() {
    	List<Map<String, Object>> list = resourceMapper.findParamInfo();
    	return list;
	}


	@Override
	public void updateDeviceConfigFlag(String deviceId, String updateFlag) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("deviceId", deviceId);
		map.put("updateFlag", updateFlag);
		resourceMapper.updateDeviceConfigFlag(map);
	}
	
}
