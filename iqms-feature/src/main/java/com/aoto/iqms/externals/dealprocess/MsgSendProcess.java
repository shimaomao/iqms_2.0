package com.aoto.iqms.externals.dealprocess;

import java.io.ByteArrayInputStream;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.apache.commons.configuration.ConfigurationException;
import org.apache.commons.lang.time.DateFormatUtils;
import org.dom4j.Document;
import org.dom4j.Node;
import org.dom4j.io.SAXReader;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.aoto.iqms.externals.models.EsbServiceResp;
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
import com.aoto.iqms.externals.service.inf.ResourceService;
import com.aoto.iqms.util.JsonUtils;
import com.aoto.iqms.util.PropetiesLoader;
import com.aoto.iqms.util.SendUtil;
import com.fasterxml.jackson.databind.JsonNode;

/**
 * 短信提醒处理过程
 * @author hongxz
 *
 */
public class MsgSendProcess {
	private static final Logger logger = LoggerFactory
			.getLogger(MsgSendProcess.class);

	public MsgSendProcess() {
		super();
	}
	
	
	/**
	 * 短信提醒操作
	 * @param resourceService
	 * @param transCode
	 * @param json
	 * @return
	 */
	public String sendMsgContent(ResourceService resourceService,
			String transCode,JsonNode root){
		//创建响应对象
		MsgSendResp msgSendResp  = new MsgSendResp();
		
		msgSendResp.getHead().setTransCode(transCode);
		msgSendResp.getHead().setTransDateTime(DateFormatUtils.format(new Date(), "yyyy-MM-dd HH:mm:ss"));
		try {
			//将json的请求数据封装成对象
			//1.获取数据部分的报文
			JsonNode dataNode = root.findValue("data");
			if (dataNode == null) { //异常
				msgSendResp.getHead().setTransStatus("9999");
				msgSendResp.getHead().setTransDescription("短信提醒 ：没有发现data节点数据");
				return responseJson(transCode,msgSendResp);
			} 
			
			String dataJson = dataNode.toString();
			MsgSendReq msgSendReq = JsonUtils.json2pojo(dataJson, MsgSendReq.class);
			//调用第三方接口进行激活
			String reqXml = fetchMsgXml(msgSendReq);
			logger.info("短信发送 【调用济宁银行短信发送】请求报文："+reqXml);
			String ip = PropetiesLoader.getSystemConfig().getString("jn.msg.ip", "");
			int port = PropetiesLoader.getSystemConfig().getInt("jn.msg.port", 10086);
			logger.info("短信发送：短信平台地址：ip："+ip+" port:"+port);
			EsbServiceResp esbServiceResp = new EsbServiceResp();
			String respXml = SendUtil.socketSendData(reqXml, ip, port, esbServiceResp, "UTF-8", 5);
			logger.info("短信发送 【调用济宁银行短信发送】返回报文："+respXml);
			if (esbServiceResp.getStatus().equals("FAIL")){  //
				msgSendResp.getHead().setTransStatus("9999");
				msgSendResp.getHead().setTransDescription("短信发送【调用短信平台短信发送】："+esbServiceResp.getDesc());
				logger.info("短信发送 失败【调用短信平台短信发送】："+esbServiceResp.getDesc());
				return responseJson(transCode, msgSendResp);
			} 
			
			//分析返回报文
			
			//将前面的报文长度截取掉
			respXml = respXml.substring(5);
			//对返回内容进行解析
			try{
				SAXReader reader = new SAXReader();
				ByteArrayInputStream bais = new ByteArrayInputStream(respXml.getBytes("UTF-8"));
				Document document = reader.read(bais);
				Node statusNode = document.selectSingleNode("/BEAR/RSPCODE");
				Node descNode = document.selectSingleNode("/BEAR/RSPDESC");
				logger.info("短信发送：短信平台交易状态："+statusNode.getStringValue()+"  短信平台交易描述:"+descNode.getStringValue());
				String transStatus = statusNode.getStringValue();
				if (!transStatus.equals("JNML0000")){  //处理请求失败
					msgSendResp.getHead().setTransStatus("9999");
					msgSendResp.getHead().setTransDescription("短信提醒,短信平台接收异常 ："+descNode.getStringValue());
					logger.info("MsgSendProcess：短信提醒,短信平台接收异常："+esbServiceResp.getDesc());
					return  responseJson(transCode, msgSendResp);
				} 
				
				MsgSendDataResp msgSendDataResp = new MsgSendDataResp();
				msgSendResp.getHead().setTransDescription("成功");
				msgSendResp.getHead().setTransStatus("0000");
				msgSendResp.setData(msgSendDataResp);
				return  responseJson(transCode, msgSendResp);
				
				
			} catch(Exception e){
				msgSendResp.getHead().setTransStatus("9999");
				msgSendResp.getHead().setTransDescription("短信提醒 ：短信平台返回报文解析异常");
				logger.info("【EsbRequest】xml解析异常",e);
				return  responseJson(transCode, msgSendResp);
			}
				
		} catch (Exception e) {
			logger.info("MsgSendProcess：短信提醒处理异常：对象转换异常。",e);
			msgSendResp.getHead().setTransStatus("9999");
			msgSendResp.getHead().setTransDescription("短信提醒处理异常：对象转换异常");
		}
		logger.info("MsgSendProcess：短信提醒处理，开始封装返回信息：====》");
		String json = "";
		try {
			json = JsonUtils.obj2json(msgSendResp);
			logger.info("MsgSendProcess：短信提醒，封装返回信息="+json);
		} catch (Exception e) {
			logger.info("MsgSendProcess：短信提醒，将返回信息转换成json异常。",e);
			json = "{"+
			    "\"head\":{"+
			        "\"transCode\":\""+transCode+"\","+
			        "\"transDateTime\":\""+DateFormatUtils.format(new Date(), "yyyy-MM-dd HH:mm:ss")+"\","+
			        "\"transStatus\":\"9999\","+
			        "\"transDescription\":\"短信提醒，返回信息转换成json异常\""+
			    "}"+
			"}";
		}
		return json;
	}
	
	/**
	 * 短信发送的xml（esb,不调用此接口）
	 * @param msgSendReq  排队机发送过来的消息对象
	 * @return
	 * @throws ConfigurationException 
	 */
	private String fetchMsgXmlEsb(MsgSendReq msgSendReq) throws ConfigurationException{
		StringBuilder reqXml = new StringBuilder("<?xml version= \"1.0\" encoding= \"UTF-8\" ?>");
		//计算交易流水号
		long coreMsgSn = PropetiesLoader.getSystemConfig().getLong("esb.msg.sn")+1;
		if (coreMsgSn == 409999999) {  //达到最大值，就恢复到初始值
			coreMsgSn = 409000000;
		} else {
			coreMsgSn++;
		}
		PropetiesLoader.getSystemConfig().setProperty("esb.msg.sn", coreMsgSn);
	    PropetiesLoader.getSystemConfig().save();
		//流水号 （系统保留就使用0） 第一位固定1,2-3位地市编码济宁58，4-7系统编号0091，8-9系统保留默认0,10系统保留默认0,11-19位流水号13位固定9表示外网系统，流水号三天内不重复
		String requesterId = PropetiesLoader.getSystemConfig().getString("esb.iqms.requester_id");
	    String service_sn = "158"+requesterId+"000"+coreMsgSn;
		reqXml.append("<Service>");
		reqXml.append("<Service_Header>");
		reqXml.append("<service_sn>"+service_sn+"</service_sn>");
		reqXml.append("<requester_id>"+requesterId+"</requester_id>");  //我们系统编号(联盟分配)
		reqXml.append("<channel_id>"+PropetiesLoader.getSystemConfig().getString("esb.iqms.channel_id")+"</channel_id>"); //联盟分配
		reqXml.append("<service_time>"+DateFormatUtils.format(new Date(), "yyyyMMddHHmmss")+"</service_time>"); //年月日时分秒（系统时间）
		reqXml.append("<version_id>01</version_id>");  //固定01
		reqXml.append("<service_id>"+PropetiesLoader.getSystemConfig().getString("esb.msg.serviceid")+"</service_id>"); //外围短信
		reqXml.append("<branch_id>"+msgSendReq.getOrgCode()+"</branch_id>");
		reqXml.append("<service_response/>");
		reqXml.append("</Service_Header>");
		reqXml.append("<Service_Body>");
		reqXml.append("<ext_attributes>");
		reqXml.append("<INM-TELLER-ID>81500905    </INM-TELLER-ID>"); //虚拟柜员工号,12位，不够补空格
		reqXml.append("</ext_attributes>");
		reqXml.append("<request>");
		reqXml.append("<yybs>"+PropetiesLoader.getSystemConfig().getString("esb.msg.yybs")+"</yybs>");  //应用标识  017
		reqXml.append("<cpdm>"+PropetiesLoader.getSystemConfig().getString("esb.msg.cpdm")+"</cpdm>");  //产品代码  9990001701
		reqXml.append("<jydm>"+PropetiesLoader.getSystemConfig().getString("esb.msg.jydm")+"</jydm>");  //交易码  825000
		reqXml.append("<srvid>"+PropetiesLoader.getSystemConfig().getString("esb.msg.srvid")+"</srvid>");  //外围编码  W01
		reqXml.append("<branchno></branchno>");  //签约机构号  非必填
		reqXml.append("<immedflag>"+PropetiesLoader.getSystemConfig().getString("esb.msg.immedflag")+"</immedflag>");  //短信实时行  1-实时    0-非实时（工作时间段发送）
		reqXml.append("<lastsndtime>"+PropetiesLoader.getSystemConfig().getString("esb.msg.lastsndtime")+"</lastsndtime>");  //是否预约发送   0-不预约发送   预约发送天预约时间   
		reqXml.append("<custno></custno>");  //客户号，非必填
		reqXml.append("<srvaccno></srvaccno>");  //账号非必填
		reqXml.append("<objaddr1>"+msgSendReq.getTelNo()+"</objaddr1>");  //手机号1 必填   
		reqXml.append("<objaddr2></objaddr2>");  //手机号2非 必填   
		reqXml.append("<objaddr3></objaddr3>");  //手机号3非 必填   
		reqXml.append("<objaddr4></objaddr4>");  //手机号4 非必填   
		reqXml.append("<objaddr5></objaddr5>");  //手机号5 非必填   
		reqXml.append("<msgcont>"+msgSendReq.getMsgContent()+"</msgcont>");  //手机号1 非必填   
		reqXml.append("<mac></mac>");  //校验 非必填   
		reqXml.append("<apex1></apex1>");  //扩展1 非必填   
		reqXml.append("<apex2></apex2>");  //扩展2非必填   
		reqXml.append("<apex3></apex3>");  //扩展3 非必填   
		reqXml.append("</request>");
		reqXml.append("<response/>");
		reqXml.append("</Service_Body>");
		reqXml.append("</Service>");
		
		return reqXml.toString();
	}
	
	/**
	 * 短信发送的xml（esb）
	 * @param msgSendReq  排队机发送过来的消息对象
	 * @return
	 * @throws ConfigurationException 
	 */
	private String fetchMsgXml(MsgSendReq msgSendReq) throws ConfigurationException{
		//StringBuilder reqXml = new StringBuilder("<?xml version= \"1.0\" encoding= \"UTF-8\" ?>");
		StringBuilder reqXml = new StringBuilder("");
		reqXml.append("<BEAR>");
		reqXml.append("<ORDERNO>"+System.currentTimeMillis()+"</ORDERNO>"); //必须唯一：建议日期+序号(我这边使用系统毫秒数)
		reqXml.append("<SVRID>"+PropetiesLoader.getSystemConfig().getString("jn.msg.svrid")+"</SVRID>");  //服务代码：排队机为pdj
		reqXml.append("<TRADECODE>"+PropetiesLoader.getSystemConfig().getString("jn.msg.transcode")+"</TRADECODE>"); //交易码：PDJ01
		reqXml.append("<BRANCHNO>"+msgSendReq.getOrgCode()+"</BRANCHNO>"); //机构号码
		reqXml.append("<ACCNO></ACCNO>");  //账号
		reqXml.append("<ISATTIME>"+PropetiesLoader.getSystemConfig().getString("jn.msg.isattime")+"</ISATTIME>"); //是否实时
		reqXml.append("<ATTIME></ATTIME>"); //定时发送：yymmddhhmmss  实时发送，此处为空
		reqXml.append("<PHONE>"+msgSendReq.getTelNo()+"</PHONE>");  //手机号
		reqXml.append("<MSGCONTENT>"+msgSendReq.getMsgContent()+"</MSGCONTENT>");  //消息内容
		reqXml.append("</BEAR>");
		
		return reqXml.toString();
	}
	
	/**
	 * 封装响应的json信息
	 * @param transCode
	 * @param bookActiveResp
	 * @return
	 */
	private String responseJson(String transCode, MsgSendResp msgSendResp) {
		logger.info("MsgSendProcess：短信发送处理，开始封装返回信息：====》");
		String json = "";
		try {
			json = JsonUtils.obj2json(msgSendResp);
			logger.info("MsgSendProcess：短信发送，封装返回信息="+json);
		} catch (Exception e) {
			logger.info("MsgSendProcess：短信发送，将返回信息转换成json异常。",e);
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
	
	
	/**
	 * 预约激活测试
	 * @param args
	 */
	public static void main(String[] args) {
		String reqJson = "{"+
			    "\"head\":{"+
			        "\"transCode\":\"C001\","+
			        "\"transDateTime\":\"2017-7-10 19:20:27\","+
			        "\"transStatus\":\"\","+
			        "\"transDescription\":\"\""+
			    "},"+
			    "\"data\":{"+
			        "\"transNet\":\"33\","+
			        "\"deviceId\":\"9010010201\","+
			        "\"orgCode\":\"815012801\","+  //预约激活测试 机构号-815012401    查询核心数据机构号：815012801
			        "\"deviceIp\":\"172.16.210.99\","+
			        "\"telNo\":\"17751047676\","+
			        "\"ticketNo\":\"A1001\","+
					"\"busName\":\"个人业务\","+
					"\"busId\":\"32\","+
					"\"busWait\":\"32\","+
					"\"msgContent\":\"测试短信\","+
			        "\"actDateTime\":\"2017-7-10 19:20:27\""+
			    "}"+
			"}";
		JsonNode rootNode = JsonUtils.getRoot(reqJson);
		MsgSendProcess msgSendProcess = new MsgSendProcess();
		String respJson = msgSendProcess.sendMsgContent(null, "C001", rootNode);
		System.out.println(respJson);
		
	}
	
}
