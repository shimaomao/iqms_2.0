package com.aoto.iqms.businessconfig.service.impl;

import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.aoto.iqms.businessconfig.commons.constant.BusinessconfigBeanProperty.BscDevice;
import com.aoto.iqms.businessconfig.models.BscDeviceModel;
import com.aoto.iqms.businessconfig.models.BscDeviceQuery;
import com.aoto.iqms.businessconfig.models.TicketFormModel;
import com.aoto.iqms.businessconfig.persistence.inf.BscBranchBusinessMapper;
import com.aoto.iqms.businessconfig.persistence.inf.BscCustLevelMapper;
import com.aoto.iqms.businessconfig.persistence.inf.BscCustRecognitionMapper;
import com.aoto.iqms.businessconfig.persistence.inf.BscDeviceMapper;
import com.aoto.iqms.businessconfig.persistence.inf.BscShowTimeMapper;
import com.aoto.iqms.businessconfig.persistence.inf.BscWinConfigMapper;
import com.aoto.iqms.businessconfig.persistence.inf.CallStrategyMapper;
import com.aoto.iqms.businessconfig.persistence.inf.NumberFormMapper;
import com.aoto.iqms.businessconfig.persistence.inf.TakeConfigMapper;
import com.aoto.iqms.businessconfig.persistence.inf.TicketFormMapper;
import com.aoto.iqms.businessconfig.service.inf.BscBranchBusinessService;
import com.aoto.iqms.businessconfig.service.inf.BscCustLevelService;
import com.aoto.iqms.businessconfig.service.inf.BscCustRecognitionService;
import com.aoto.iqms.businessconfig.service.inf.BscDeviceService;
import com.aoto.iqms.businessconfig.service.inf.BscShowTimeService;
import com.aoto.iqms.businessconfig.service.inf.BscWinConfigService;
import com.aoto.iqms.businessconfig.service.inf.CallStrategyService;
import com.aoto.iqms.businessconfig.service.inf.NumberFormService;
import com.aoto.iqms.businessconfig.service.inf.TicketFormService;
import com.aoto.iqms.util.ProcPageFill;
import com.aoto.framework.commons.lang.StringUtils4Aoto;
import com.aoto.framework.commons.pagination.PagingCriteria;

/**
 * 设备管理sevice实现
 * @author daxian
 *
 */
@Service
@Transactional
public class BscDeviceSeviceImpl implements BscDeviceService {
	
	@Autowired
	public BscDeviceMapper bscDeviceMapper;
	@Autowired
	private NumberFormMapper numMapper;
	@Autowired
	private TicketFormMapper ticketFormMapper;
	@Autowired
	private BscWinConfigMapper bscWinConfigMapper;
	@Autowired
	private BscBranchBusinessMapper branchMapper;
	@Autowired
	private BscShowTimeMapper showTimeMapper;
	@Autowired
	private BscCustLevelMapper custLevelMapper;
	@Autowired
	private CallStrategyMapper callMapper;
	@Autowired
	private BscCustRecognitionMapper recognitionMapper;
	@Autowired
	private TakeConfigMapper takeMapper;
	@Autowired
	private BscWinConfigService bscWinConfigService;
	/**
	 * 调用存储过程分页
	 */
	@Override
	public List<Map<String, Object>> procPageBscDevice(
			PagingCriteria pagingCriteria, BscDeviceQuery model) {
		Map<String, Object> map = new HashMap<String, Object>();
        map.put(BscDevice.ORG_ID, StringUtils4Aoto.trim(model.getOrgId()));
        map.put(BscDevice.IS_LSTVERSION, StringUtils4Aoto.trim(model.getIslstversion()));
        
        //填充分页和排序信息
        ProcPageFill.fillProcData(model, map,BscDevice.class);
        //执行查询
        List<Map<String, Object>> list = bscDeviceMapper.callPageBscDevice(map);
        
        //获取存储过程中返回的值
        int total = ((BigDecimal)map.get("totalrows")).intValue();
        pagingCriteria.setTotal(total);
        //获取数据集
        list = (List<Map<String, Object>>)map.get("pageDatas");
		return list;		
	}

	/**
	 * 调用存储过程新增业务类型数据
	 */
	@Override
	public String callCreateBscDeviceProc(BscDeviceModel model) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put(BscDevice.ORG_ID, StringUtils4Aoto.trim(model.getOrgId()));
		map.put(BscDevice.ADMIN_NAME, model.getAdminName());
		map.put(BscDevice.ADMIN_PHONE, model.getAdminPhone());
		map.put(BscDevice.DEVICE_NO, model.getDeviceNo());
		map.put(BscDevice.HOST_NAME, model.getHostName());
		map.put(BscDevice.INSTALL_DATE, model.getInstallDate());
		map.put(BscDevice.IP_ADDR, model.getIpAddr());
		map.put(BscDevice.MAC_ADDR, model.getMacAddr());
		map.put(BscDevice.PRODUCER, model.getProducer());
		map.put(BscDevice.CURRT_VER, model.getCurrtVer());
		
		//20151231 by hongxz 
		map.put(BscDevice.NET_ORGCODE, model.getNetOrgCode());
		map.put(BscDevice.ORDER_FLAG, model.getOrderFlag());
		map.put(BscDevice.EXTEND1, model.getExtend1());
		map.put(BscDevice.EXTEND2, model.getExtend2());
		map.put(BscDevice.EXTEND3, model.getExtend3());
		map.put(BscDevice.SCREEN_RESOLUTION, model.getScreenResolution());
		//20171017 by zhousj
		map.put(BscDevice.ONLINE_MODEL, model.getOnlineModel());
		map.put(BscDevice.TPSCROLL_FLAG, model.getTpscrollFlag());
		//调用持久化方法
		try {
			bscDeviceMapper.callInsertBscDevice(map);
			//获取存储过程的输出参数
			String obj = (String)map.get("ReturnCode");
			return obj;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			return "1"; //执行失败
		}
	}

	/**
	 * 调用存储过程更新数据
	 */
	@Override
	public String callUpdateBscDeviceProc(BscDeviceModel model) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put(BscDevice.ORG_ID, StringUtils4Aoto.trim(model.getOrgId()));
		map.put(BscDevice.ADMIN_NAME, model.getAdminName());
		map.put(BscDevice.ADMIN_PHONE, model.getAdminPhone());
		map.put(BscDevice.DEVICE_NO, model.getDeviceNo());
		map.put(BscDevice.HOST_NAME, model.getHostName());
		map.put(BscDevice.INSTALL_DATE, model.getInstallDate());
		map.put(BscDevice.IP_ADDR, model.getIpAddr());
		map.put(BscDevice.MAC_ADDR, model.getMacAddr());
		map.put(BscDevice.PRODUCER, model.getProducer1());
		map.put(BscDevice.CURRT_VER, model.getCurrtVer());
		
		//20151231 by hongxz 
		map.put(BscDevice.NET_ORGCODE, model.getNetOrgCode());
		map.put(BscDevice.ORDER_FLAG, model.getOrderFlag());
		map.put(BscDevice.EXTEND1, model.getExtend1());
		map.put(BscDevice.EXTEND2, model.getExtend2());
		map.put(BscDevice.EXTEND3, model.getExtend3());
		map.put(BscDevice.SCREEN_RESOLUTION, model.getScreenResolution1());
		//20171017 by zhousj
		map.put(BscDevice.ONLINE_MODEL, model.getOnlineModel());
		map.put(BscDevice.TPSCROLL_FLAG, model.getTpscrollFlag());
		//调用持久化方法
		try {
			bscDeviceMapper.callUpdteBscDevice(map);
			//获取存储过程的输出参数
			String obj = (String)map.get("ReturnCode");
			return obj;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			return "1"; //执行失败
		}
	}
	
	
	/**
	 * 调用存储过程更新数据
	 */
	@Override
	public String callUpdateBscDeviceProcForAutoUp(BscDeviceModel model) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put(BscDevice.ORG_ID, StringUtils4Aoto.trim(model.getOrgId()));
		map.put(BscDevice.ADMIN_NAME, model.getAdminName());
		map.put(BscDevice.ADMIN_PHONE, model.getAdminPhone());
		map.put(BscDevice.DEVICE_NO, model.getDeviceNo());
		map.put(BscDevice.HOST_NAME, model.getHostName());
		map.put(BscDevice.INSTALL_DATE, model.getInstallDate());
		map.put(BscDevice.IP_ADDR, model.getIpAddr());
		map.put(BscDevice.MAC_ADDR, model.getMacAddr());
		map.put(BscDevice.PRODUCER, model.getProducer());
		map.put(BscDevice.CURRT_VER, model.getCurrtVer());
		
		//调用持久化方法
		try {
			bscDeviceMapper.callUpdteBscDeviceForAutoUp(map);
			//获取存储过程的输出参数
			String obj = (String)map.get("ReturnCode");
			return obj;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			return "1"; //执行失败
		}
	}

	/**
	 * 业务删除
	 */
	@Override
	public String callRemoveBscDeviceProc(List<Map<String, String>> list) {
		for (int i = 0; i < list.size(); i++) {
			Map<String, String> map = list.get(i);
			bscDeviceMapper.callDeleteBscDevice(map);
		}
		return "0";
	}
	
	/**
     * 通过条件查询列表(版本升级专用)
     * @param map
     */
	public List<Map<String, Object>> findBscDeviceByConditon(BscDeviceModel model){
    	Map<String, Object> map = new HashMap<String, Object>();
    	map.put(BscDevice.ORG_ID, StringUtils4Aoto.trim(model.getOrgId()));
    	//map.put(BscDevice.IP_ADDR, model.getIpAddr());
    	map.put(BscDevice.DEVICE_NO, model.getDeviceNo());
    	map.put(BscDevice.ORG_ID, model.getOrgId());   //机构条件
    	map.put(BscDevice.CURRT_VER, model.getCurrtVer());   //选择的上传的更新包的id，低于这个版本的设备记录才会被查询
    	List<Map<String, Object>> list = bscDeviceMapper.findBscDeviceByConditon(map);
    	return list;
    }
	
	
	/**
     * 20151102 by hongxz 通过条件查询列表
     * @param map
     */
	public Map<String, Object> findDevCount(BscDeviceModel model){
    	Map<String, Object> map = new HashMap<String, Object>();
    	map.put(BscDevice.ORG_ID, StringUtils4Aoto.trim(model.getOrgId()));
    	//map.put(BscDevice.IP_ADDR, model.getIpAddr());
    	map.put(BscDevice.DEVICE_NO, model.getDeviceNo());
    	Map<String, Object> list = bscDeviceMapper.findDevCount(map);
    	return list;
    }

	@Override
	public String callUpdateDeviceCurrtVersionProc(BscDeviceModel model) {
		Map<String, Object> map = new HashMap<String, Object>();
    	map.put(BscDevice.DEVICE_NO, model.getDeviceNo());
    	map.put(BscDevice.CURRT_VER, model.getCurrtVer());   //选择的上传的更新包的id，低于这个版本的设备记录才会被查询
    	try {
			bscDeviceMapper.callUpdateDeviceCurrtVersion(map);
			//获取存储过程的输出参数
			String obj = (String)map.get("ReturnCode");
			return obj;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			return "1"; //执行失败
		}
	}
	
	
	/**
     * 通过条件查询列表(预约使用)
     * @param map
     */
	public List<Map<String, Object>> findBscDeviceForOrder(BscDeviceModel model){
    	Map<String, Object> map = new HashMap<String, Object>();
    	map.put(BscDevice.ORG_ID, StringUtils4Aoto.trim(model.getOrgId()));
    	map.put(BscDevice.ORDER_FLAG, model.getOrderFlag());
    	List<Map<String, Object>> list = bscDeviceMapper.findBscDeviceForOrder(map);
    	return list;
    }


	/**
	 * 根据机构id及更新包版本id，查询能够应用此更新包的设备
	 */
	@Override
	public List<Map<String, Object>> findBscDevice4TreeByConditon(BscDeviceQuery model) {
		Map<String, Object> map = new HashMap<String, Object>();
    	map.put(BscDevice.ORG_ID, StringUtils4Aoto.trim(model.getOrgId()));
    	map.put("patchId", StringUtils4Aoto.trim(model.getPatchId()));
        bscDeviceMapper.findBscDevice4PatchTree(map);
    	List<Map<String, Object>> list =  (List<Map<String, Object>>)map.get("pageDatas");
		return list;
	}


	@Override
	public List<Map<String, Object>> ztreeOrgDevice(String orgId) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("orgId", orgId);
		List<Map<String, Object>> list = bscDeviceMapper.ztreeOrgDevice(map);
		list = (List<Map<String, Object>>)map.get("pageDatas");
		return list;
	}

	@Override
	public String callSaveCopyProc(BscDeviceQuery model) {
		List<Map<String, Object>> list = bscWinConfigService.createOrgIdDeviceNo(model.getOrgDevicelist());
		//根据用户所属机构查询所有下级机构和设备号
//		List<Map<String, Object>> orgList = ztreeOrgDevice(model.getTargetId());
		Map<String, Object> map1 = new HashMap<String,Object>();
		for(int i=0; i<list.size(); i++){
			Map<String, Object> map = list.get(i);
			map.put(BscDevice.ORG_ID, model.getOrgId());
			map.put(BscDevice.DEVICE_NO, model.getDeviceNo());
			
			map1.put("updateFlag", "1");
			map1.put("deviceId", map.get("targetNo"));
//			numMapper.callCopyNumber(map);
		    ticketFormMapper.callCopyTicket(map);
		    bscWinConfigMapper.callCopyBscWinConfig(map);
			branchMapper.callCopyBscBranchBus(map);
			showTimeMapper.callCopyShowTime(map);
			takeMapper.callCopyTakeConfig(map);
			custLevelMapper.callCopyBscCustLevel(map);
			callMapper.callStrategyCopy(map);
			recognitionMapper.callCopyCustRecognition(map);
			bscDeviceMapper.updateDeviceConfigFlag(map1);
		
		
		}
		return "0";
	}

	@Override
	public String createDeviceNo(BscDeviceModel model) {
		Map<String, Object> map = bscDeviceMapper.findDeviceNo();
		String deviceNo = "qms_"+model.getOrgId()+"_"+Integer.parseInt(map.get("devCount").toString());
		return deviceNo;
	}

	@Override
	public String callSaveFastCopy(BscDeviceQuery model) {
		List<Map<String, Object>> list = bscWinConfigService.createOrgIdDeviceNo(model.getOrgDevicelist());
		//根据用户所属机构查询所有下级机构和设备号
//		List<Map<String, Object>> orgList = ztreeOrgDevice(model.getTargetId());
		Map<String, Object> map1 = new HashMap<String,Object>();
		for(int i=0; i<list.size(); i++){
			Map<String, Object> map = list.get(i);
			map.put(BscDevice.ORG_ID, map.get("targetId"));
			map.put(BscDevice.DEVICE_NO, map.get("targetNo"));
			map.put("targetId", model.getOrgId());
			map.put("targetNo", model.getDeviceNo());
			
			map1.put("updateFlag", "1");
			map1.put("deviceId", map.get("targetNo"));
//			numMapper.callCopyNumber(map);
		    ticketFormMapper.callCopyTicket(map);
		    bscWinConfigMapper.callCopyBscWinConfig(map);
			branchMapper.callCopyBscBranchBus(map);
			showTimeMapper.callCopyShowTime(map);
			takeMapper.callCopyTakeConfig(map);
			custLevelMapper.callCopyBscCustLevel(map);
			callMapper.callStrategyCopy(map);
			recognitionMapper.callCopyCustRecognition(map);
			bscDeviceMapper.updateDeviceConfigFlag(map1);
		}
		return "0";
	}

	@Override
	public List<Map<String, Object>> findByDeviceNo(BscDeviceQuery model) {
		Map<String, Object> map = new HashMap<String, Object>();
    	map.put(BscDevice.DEVICE_NO, model.getDeviceNo());
    	List<Map<String, Object>> list = bscDeviceMapper.findByDeviceNo(map);
    	return list;
	}

	@Override
	public List<Map<String, Object>> ztreeForTicket(String orgId) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("orgId", orgId);
		List<Map<String, Object>> list = bscDeviceMapper.ztreeForTicket(map);
		list = (List<Map<String, Object>>)map.get("pageDatas");
		return list;
	}

	@Override
	public String callCreateNavDeviceProc(BscDeviceModel model) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put(BscDevice.ORG_ID, StringUtils4Aoto.trim(model.getOrgId()));
		map.put(BscDevice.ADMIN_NAME, model.getAdminName());
		map.put(BscDevice.ADMIN_PHONE, model.getAdminPhone());
		map.put(BscDevice.DEVICE_NO, model.getDeviceNo());
		map.put(BscDevice.HOST_NAME, model.getHostName());
		map.put(BscDevice.INSTALL_DATE, model.getInstallDate());
		map.put(BscDevice.IP_ADDR, model.getIpAddr());
		map.put(BscDevice.MAC_ADDR, model.getMacAddr());
		map.put(BscDevice.PRODUCER, model.getProducer());
		map.put(BscDevice.CURRT_VER, model.getCurrtVer());
		
		//20151231 by hongxz 
		map.put(BscDevice.NET_ORGCODE, model.getNetOrgCode());
		map.put(BscDevice.ORDER_FLAG, model.getOrderFlag());
		map.put(BscDevice.EXTEND1, model.getExtend1());
		map.put(BscDevice.EXTEND2, model.getExtend2());
		map.put(BscDevice.EXTEND3, model.getExtend3());
		map.put(BscDevice.SCREEN_RESOLUTION, model.getScreenResolution());
		//20171017 by zhousj
		map.put(BscDevice.ONLINE_MODEL, model.getOnlineModel());
		map.put(BscDevice.TPSCROLL_FLAG, model.getTpscrollFlag());
		//调用持久化方法
		try {
			bscDeviceMapper.callInsertNavDevice(map);
			//获取存储过程的输出参数
			String obj = (String)map.get("ReturnCode");
			return obj;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			return "1"; //执行失败
		}
	}

	@Override
	public List<Map<String, Object>> findDeviceForOrder(String orgCode, String orderFlag) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("orgCode", orgCode);
		map.put("orderFlag", orderFlag);
		List<Map<String, Object>> list = bscDeviceMapper.findDeviceForOrder(map);
		return list;
	}

	@Override
	public List<Map<String, Object>> ztreeFastCopy(String orgId, String deviceNo) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("orgId", orgId);
		map.put("deviceNo", deviceNo);
		List<Map<String, Object>> list = bscDeviceMapper.ztreeFastCopy(map);
		list = (List<Map<String, Object>>)map.get("pageDatas");
		return list;
	}

}
