package com.aoto.iqms.externals.dealprocess;

import java.util.Date;

import org.apache.commons.lang.time.DateFormatUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.aoto.iqms.externals.models.patchdlconfirm.PatchDlConfirmDataResp;
import com.aoto.iqms.externals.models.patchdlconfirm.PatchDlConfirmReq;
import com.aoto.iqms.externals.models.patchdlconfirm.PatchDlConfirmResp;
import com.aoto.iqms.externals.service.inf.ResourceService;
import com.aoto.iqms.util.JsonUtils;
import com.fasterxml.jackson.databind.JsonNode;

/**
 * 版本下载成功确认过程
 * @author hongxz
 *
 */
public class PatchDlConfirmProcess {
	private static final Logger logger = LoggerFactory
			.getLogger(PatchDlConfirmProcess.class);

	public PatchDlConfirmProcess() {
		super();
	}
	
	
	/**
	 * 版本下载成功确认
	 * @param resourceService
	 * @param transCode
	 * @param json
	 * @return
	 */
	public String patchDlConfirm(ResourceService resourceService,
			String transCode,JsonNode root){
		//创建响应对象
		PatchDlConfirmResp patchDlConfirmResp  = new PatchDlConfirmResp();
		
		patchDlConfirmResp.getHead().setTransCode(transCode);
		patchDlConfirmResp.getHead().setTransDateTime(DateFormatUtils.format(new Date(), "yyyy-MM-dd HH:mm:ss"));
		try {
			//将json的请求数据封装成对象
			//1.获取数据部分的报文
			JsonNode dataNode = root.findValue("data");
			if (dataNode == null) { //异常
				patchDlConfirmResp.getHead().setTransStatus("9999");
				patchDlConfirmResp.getHead().setTransDescription("版本下载确认 ：没有发现data节点数据");
				return responseJson(transCode,patchDlConfirmResp);
			} 
			
			String dataJson = dataNode.toString();
			PatchDlConfirmReq patchDlConfirmReq = JsonUtils.json2pojo(dataJson, PatchDlConfirmReq.class);
			//调用存储过程执行更新
			
			String result = resourceService.patchDlConfirm(patchDlConfirmReq);
			
			PatchDlConfirmDataResp patchDlConfirmDataResp = new PatchDlConfirmDataResp();
			if (result.equals("0")) {
				patchDlConfirmResp.getHead().setTransDescription("成功");
				patchDlConfirmResp.getHead().setTransStatus("0000");
			} else {
				patchDlConfirmResp.getHead().setTransDescription("失败：更新的设备记录不存在");
				patchDlConfirmResp.getHead().setTransStatus("9999");
			}
				
			
			patchDlConfirmResp.setData(patchDlConfirmDataResp);
			return  responseJson(transCode, patchDlConfirmResp);
				
		} catch (Exception e) {
			logger.info("PatchDlConfirmProcess：版本下载确认处理异常：对象转换异常。",e);
			patchDlConfirmResp.getHead().setTransStatus("9999");
			patchDlConfirmResp.getHead().setTransDescription("版本下载确认处理异常：对象转换异常");
		}
		logger.info("PatchDlConfirmProcess：版本下载确认处理，开始封装返回信息：====》");
		String json = "";
		try {
			json = JsonUtils.obj2json(patchDlConfirmResp);
			logger.info("PatchDlConfirmProcess：版本下载确认，封装返回信息="+json);
		} catch (Exception e) {
			logger.info("PatchDlConfirmProcess：版本下载确认，将返回信息转换成json异常。",e);
			json = "{"+
			    "\"head\":{"+
			        "\"transCode\":\""+transCode+"\","+
			        "\"transDateTime\":\""+DateFormatUtils.format(new Date(), "yyyy-MM-dd HH:mm:ss")+"\","+
			        "\"transStatus\":\"9999\","+
			        "\"transDescription\":\"版本下载确认，返回信息转换成json异常\""+
			    "}"+
			"}";
		}
		return json;
	}
	
	/**
	 * 封装响应的json信息
	 * @param transCode
	 * @param bookActiveResp
	 * @return
	 */
	private String responseJson(String transCode, PatchDlConfirmResp patchDlConfirmResp) {
		logger.info("PatchDlConfirmProcess：短信发送处理，开始封装返回信息：====》");
		String json = "";
		try {
			json = JsonUtils.obj2json(patchDlConfirmResp);
			logger.info("PatchDlConfirmProcess：短信发送，封装返回信息="+json);
		} catch (Exception e) {
			logger.info("PatchDlConfirmProcess：短信发送，将返回信息转换成json异常。",e);
			json = "{"+
			    "\"head\":{"+
			        "\"transCode\":\""+transCode+"\","+
			        "\"transDateTime\":\""+DateFormatUtils.format(new Date(), "yyyy-MM-dd HH:mm:ss")+"\","+
			        "\"transStatus\":\"9999\","+
			        "\"transDescription\":\"短信发送，返回信息转换成json异常\""+
			    "}"+
			"}";
		}
		return json;
	}
}
