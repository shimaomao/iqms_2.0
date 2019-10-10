package com.aoto.iqms.externals.dealprocess;

import java.util.Date;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.time.DateFormatUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.aoto.iqms.externals.models.bookvalidate.BookActiveDataResp;
import com.aoto.iqms.externals.models.bookvalidate.BookActiveReq;
import com.aoto.iqms.externals.models.bookvalidate.BookActiveResp;
import com.aoto.iqms.externals.models.custident.CustIdentityDataResp;
import com.aoto.iqms.externals.models.custident.CustIdentityReq;
import com.aoto.iqms.externals.models.custident.CustIdentityResp;
import com.aoto.iqms.externals.models.deviceheartbeat.DevHeartbeatDataReq;
import com.aoto.iqms.externals.models.deviceheartbeat.DevHeartbeatDataResp;
import com.aoto.iqms.externals.models.deviceheartbeat.DevHeartbeatResp;
import com.aoto.iqms.externals.models.msgsend.MsgSendDataResp;
import com.aoto.iqms.externals.models.msgsend.MsgSendReq;
import com.aoto.iqms.externals.models.msgsend.MsgSendResp;
import com.aoto.iqms.externals.models.syncteller.TellerSyncDataResp;
import com.aoto.iqms.externals.models.syncteller.TellerSyncReq;
import com.aoto.iqms.externals.models.syncteller.TellerSyncResp;
import com.aoto.iqms.externals.service.inf.ResourceService;
import com.aoto.iqms.util.JsonUtils;
import com.fasterxml.jackson.databind.JsonNode;

/**
 * 柜员同步处理过程
 * @author hongxz
 *
 */
public class TellerSyncProcess {
	private static final Logger logger = LoggerFactory
			.getLogger(TellerSyncProcess.class);

	public TellerSyncProcess() {
		super();
	}
	
	
	/**
	 * 柜员同步
	 * @param resourceService
	 * @param transCode
	 * @param json
	 * @return
	 */
	public String syncTeller(ResourceService resourceService,
			String transCode,JsonNode root){
		//创建响应对象
		TellerSyncResp tellerSyncResp  = new TellerSyncResp();
		
		tellerSyncResp.getHead().setTransCode(transCode);
		tellerSyncResp.getHead().setTransDateTime(DateFormatUtils.format(new Date(), "yyyy-MM-dd HH:mm:ss"));
		try {
			//将json的请求数据封装成对象
			//1.获取数据部分的报文
			JsonNode dataNode = root.findValue("data");
			if (dataNode == null) {
				tellerSyncResp.getHead().setTransStatus("9999");
				tellerSyncResp.getHead().setTransDescription("柜员同步 ：没有发现data节点数据");
			} else {
				String dataJson = dataNode.toString();
				TellerSyncReq tellerSyncReq = JsonUtils.json2pojo(dataJson, TellerSyncReq.class);
				//调用柜员数据同步接口
				String result = resourceService.tellerSync(tellerSyncReq);
				
				if (result.equals("0")){
					TellerSyncDataResp tellerSyncDataResp = new TellerSyncDataResp();
					//保存柜员信息
					tellerSyncResp.getHead().setTransDescription("成功");
					tellerSyncResp.getHead().setTransStatus("0000");
					tellerSyncResp.setData(tellerSyncDataResp);
				} else {
					tellerSyncResp.getHead().setTransDescription("柜员同步失败：存储过程返回-"+result);
					tellerSyncResp.getHead().setTransStatus("9999");
				}
			}
		} catch (Exception e) {
			logger.info("BookActiveProcess：柜员同步处理异常：对象转换异常。",e);
			tellerSyncResp.getHead().setTransStatus("9999");
			tellerSyncResp.getHead().setTransDescription("柜员同步处理异常：对象转换异常");
		}
		logger.info("BookActiveProcess：柜员同步处理异常，开始封装返回信息：====》");
		String json = "";
		try {
			json = JsonUtils.obj2json(tellerSyncResp);
			logger.info("BookActiveProcess：柜员同步，封装返回信息="+json);
		} catch (Exception e) {
			logger.info("BookActiveProcess：柜员同步，将返回信息转换成json异常。",e);
			json = "{"+
			    "\"head\":{"+
			        "\"transCode\":\""+transCode+"\","+
			        "\"transDateTime\":\""+DateFormatUtils.format(new Date(), "yyyy-MM-dd HH:mm:ss")+"\","+
			        "\"transStatus\":\"9999\","+
			        "\"transDescription\":\"柜员同步，返回信息转换成json异常\""+
			    "}"+
			"}";
		}
		return json;
	}
	
}
