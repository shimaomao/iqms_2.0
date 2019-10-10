package com.aoto.iqms.businessconfig.service.impl;

import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.net.ServerSocket;
import java.net.Socket;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.time.DateFormatUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.aoto.iqms.businessconfig.persistence.inf.AdPublishMapper;
import com.aoto.iqms.businessconfig.persistence.inf.BscDeviceMapper;
import com.aoto.iqms.businessconfig.service.inf.AdPublishService;
import com.aoto.iqms.externals.models.EsbServiceResp;
import com.aoto.iqms.externals.thirdcommunication.EsbRequest;
import com.aoto.iqms.util.JsonUtils;
import com.aoto.iqms.util.SendUtil;

/**
 * 广告发布
 * @author humz
 *
 */
@Service
public class AdPublishServiceImpl implements AdPublishService{
	private static final Logger logger = LoggerFactory.getLogger(AdPublishServiceImpl.class);
	@Autowired
	private AdPublishMapper adPublishMapper;
	@Autowired
	private BscDeviceMapper deviceMapper;
	
	/**
	 * 根据设备查询广告
	 * @return
	 */
	@Override
	public List<Map<String, Object>>  selectAdsByDeviceNo(Map<String, Object> map) {
		adPublishMapper.selectAdsByDeviceNo(map);
		List<Map<String, Object>> list = (List<Map<String, Object>>) map.get("pageDatas");
		if(list.size()==0){
			Map<String, Object> map1 = new HashMap<>();
			map1.put("deviceNo", map.get("deviceNo"));
			list.add(deviceMapper.callBscDevice(map1));
		}
		return list;
	}

	/**
	 * 发送广告
	 */
	@Override
	public void sendAds(Map<String, Object> map) {
		long startMill = System.currentTimeMillis();
		List<Map<String, Object>> list = adPublishMapper.findByPraendId(map);
		for(int i = 0; i<list.size(); i++){
			//以json格式向客户端发送广告
			String json = "" ;
			Map<String, Object> headMap = new HashMap<String, Object>();
			headMap.put("transCode", "F004");
			headMap.put("transDateTime", DateFormatUtils.format(new Date(), "yyyy-MM-dd HH:mm:ss"));
			headMap.put("transStatus", "");
			headMap.put("transDescription", "");
			
			Map<String, Object> dataMap = new HashMap<String, Object>();
			dataMap.put("transNet", list.get(i).get("orgId"));
			dataMap.put("advType", map.get("advType"));
			dataMap.put("advContent", map.get("advContent"));
			
			Map<String, Object> map1 = new HashMap<String, Object>();
			map1.put("head", headMap);
			map1.put("data", dataMap);
			if(list.get(i).get("ipAddr").toString().equals("")){
				break;
			}
			try {
				 json = JsonUtils.obj2json(map1);
				 EsbServiceResp esbServiceResp = new EsbServiceResp();
				 String advResp = SendUtil.socketSendData(json,list.get(i).get("ipAddr").toString(),8066,esbServiceResp,"GBK",6);
				 logger.error("【广告发送】：排队机返回的信息："+advResp);
			} catch (Exception e) {
				e.printStackTrace();
				logger.info("与"+map.get("devName").toString()+"通讯异常：",e);
				long endMill = System.currentTimeMillis();
				logger.info("调用socket接口耗时【异常】："+(endMill-startMill)+"ms");
			}
		}
		
	}
	
	/**
	 * 保存广告
	 */
	@Override
	public  String saveAds(Map<String, Object> map) {
		adPublishMapper.saveAndSend(map);
		sendAds(map);
		String errorCode = (String) map.get("ReturnCode");
		return errorCode;
	}
	
	

}
