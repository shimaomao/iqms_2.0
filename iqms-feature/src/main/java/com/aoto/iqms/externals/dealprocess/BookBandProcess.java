package com.aoto.iqms.externals.dealprocess;

import java.io.ByteArrayInputStream;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.time.DateFormatUtils;
import org.dom4j.Document;
import org.dom4j.Node;
import org.dom4j.io.SAXReader;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.aoto.iqms.basicconfig.service.inf.OrderConfigService;
import com.aoto.iqms.externals.models.EsbServiceResp;
import com.aoto.iqms.externals.models.bookband.BookBandDataResp;
import com.aoto.iqms.externals.models.bookband.BookBandReq;
import com.aoto.iqms.externals.models.bookband.BookBandResp;
import com.aoto.iqms.externals.models.bookvalidate.BookActiveDataResp;
import com.aoto.iqms.externals.models.bookvalidate.BookActiveReq;
import com.aoto.iqms.externals.models.bookvalidate.BookActiveResp;
import com.aoto.iqms.externals.models.custident.CustIdentityDataResp;
import com.aoto.iqms.externals.models.custident.CustIdentityReq;
import com.aoto.iqms.externals.models.custident.CustIdentityResp;
import com.aoto.iqms.externals.models.deviceheartbeat.DevHeartbeatDataReq;
import com.aoto.iqms.externals.models.deviceheartbeat.DevHeartbeatDataResp;
import com.aoto.iqms.externals.models.deviceheartbeat.DevHeartbeatResp;
import com.aoto.iqms.externals.service.inf.ResourceService;
import com.aoto.iqms.util.JsonUtils;
import com.aoto.iqms.util.PropetiesLoader;
import com.aoto.iqms.util.SendUtil;
import com.fasterxml.jackson.databind.JsonNode;

/**
 * 预约绑定过程
 * @author hongxz
 *
 */
public class BookBandProcess {
	private static final Logger logger = LoggerFactory
			.getLogger(BookBandProcess.class);

	public BookBandProcess() {
		super();
	}
	/**
	 * 预约绑定 本地操作
	 * @param orderService
	 * @param transCode
	 * @param root
	 * @return
	 */
	public String bandOrderInfo(OrderConfigService orderService,
			String transCode,JsonNode root){
		//创建响应对象
		BookBandResp bookBandResp  = new BookBandResp();
				
		bookBandResp.getHead().setTransCode(transCode);
		bookBandResp.getHead().setTransDateTime(DateFormatUtils.format(new Date(), "yyyy-MM-dd HH:mm:ss"));
		try {
			//将json的请求数据封装成对象
			//1.获取数据部分的报文
			JsonNode dataNode = root.findValue("data");
			if (dataNode == null) {
				bookBandResp.getHead().setTransStatus("9999");
				bookBandResp.getHead().setTransDescription("预约本地绑定 ：没有发现data节点数据");
			}else{
				String dataJson = dataNode.toString();
				BookBandReq bookBandReq = JsonUtils.json2pojo(dataJson, BookBandReq.class);
				//请求返回报文
				BookBandDataResp bookBandDataResp = new BookBandDataResp();
				String orderId = bookBandReq.getOrderId();
				String ticketNo = bookBandReq.getTicketNo();
				String result = orderService.updateOrderInfo(orderId, ticketNo);
				if(result.equals("0")){
					bookBandResp.getHead().setTransStatus("0000");
					bookBandResp.getHead().setTransDescription("成功");
					bookBandResp.setData(bookBandDataResp);
				}else{
					bookBandResp.getHead().setTransStatus("9999");
					bookBandResp.getHead().setTransDescription("预约本地绑定 ：未找到预约记录");
					bookBandResp.setData(bookBandDataResp);
				}
			}
		} catch (Exception e) {
			logger.info("BookActiveProcess：预约本地绑定处理异常：对象转换异常。",e);
			bookBandResp.getHead().setTransStatus("9999");
			bookBandResp.getHead().setTransDescription("预约本地绑定处理异常：对象转换异常");
		}
		logger.info("BookActiveProcess：预约本地绑定处理完成，开始封装返回信息：====》");
		String json = "";
		try {
			json = JsonUtils.obj2json(bookBandResp);
			logger.info("BookActiveProcess：预约本地绑定，封装返回信息="+json);
		} catch (Exception e) {
			logger.info("BookActiveProcess：预约本地绑定，将返回信息转换成json异常。",e);
			json = "{"+
			    "\"head\":{"+
			        "\"transCode\":\""+transCode+"\","+
			        "\"transDateTime\":\""+DateFormatUtils.format(new Date(), "yyyy-MM-dd HH:mm:ss")+"\","+
			        "\"transStatus\":\"9999\","+
			        "\"transDescription\":\"预约本地绑定，返回信息转换成json异常\""+
			    "}"+
			"}";
		}
		return json;
	}
	/**
	 * 预约激活操作
	 * @param resourceService
	 * @param transCode
	 * @param json
	 * @return
	 */
	public String bandBookCode(ResourceService resourceService,
			String transCode,JsonNode root){
		//创建响应对象
		BookBandResp bookBandResp  = new BookBandResp();
		
		bookBandResp.getHead().setTransCode(transCode);
		bookBandResp.getHead().setTransDateTime(DateFormatUtils.format(new Date(), "yyyy-MM-dd HH:mm:ss"));
		try {
			//将json的请求数据封装成对象
			//1.获取数据部分的报文
			JsonNode dataNode = root.findValue("data");
			if (dataNode == null) {
				bookBandResp.getHead().setTransStatus("9999");
				bookBandResp.getHead().setTransDescription("预约绑定 ：没有发现data节点数据");
			} else {
				String dataJson = dataNode.toString();
				BookBandReq bookBandReq = JsonUtils.json2pojo(dataJson, BookBandReq.class);
				
				//请求返回报文
				BookBandDataResp bookBandDataResp = new BookBandDataResp();
				
				//调用第三方接口进行激活
				//封装esb预约激活的请求报文
				StringBuilder reqXml = new StringBuilder("<?xml version= \"1.0\" encoding= \"UTF-8\" ?>");
				//计算交易流水号
				long orderBandSn = PropetiesLoader.getSystemConfig().getLong("order.band.sn");
				
				if (orderBandSn == 209999999) {  //达到最大值，就恢复到初始值
					orderBandSn = 209000000;
				} else {
					orderBandSn++;
				}
				
				PropetiesLoader.getSystemConfig().setProperty("order.band.sn", orderBandSn);
				PropetiesLoader.getSystemConfig().save();
				//流水号 （系统保留就使用0） 第一位固定1,2-3位地市编码济宁58，4-7系统编号0091，8-9系统保留默认0,10系统保留默认0,11-19位流水号13位固定9表示外网系统，流水号三天内不重复
				String requesterIdSn = PropetiesLoader.getSystemConfig().getString("esb.iqms.requester_id_sn");
				String service_sn = "158"+requesterIdSn+"000"+orderBandSn;
				reqXml.append("<Service>");
				reqXml.append("<Service_Header>");
				reqXml.append("<service_sn>"+service_sn+"</service_sn>");
				reqXml.append("<requester_id>"+PropetiesLoader.getSystemConfig().getString("esb.iqms.requester_id")+"</requester_id>");  //我们系统编号(联盟分配)
				reqXml.append("<channel_id>"+PropetiesLoader.getSystemConfig().getString("esb.iqms.channel_id")+"</channel_id>"); //联盟分配
				reqXml.append("<service_time>"+DateFormatUtils.format(new Date(), "yyyyMMddHHmmss")+"</service_time>"); //年月日时分秒（系统时间）
				reqXml.append("<version_id>01</version_id>");  //固定01
				reqXml.append("<service_id>"+PropetiesLoader.getSystemConfig().getString("order.band.serid")+"</service_id>"); //预约绑定id
				reqXml.append("<branch_id>"+bookBandReq.getOrgCode()+"</branch_id>");
				reqXml.append("<service_response/>");
				reqXml.append("</Service_Header>");
				reqXml.append("<Service_Body>");
				reqXml.append("<ext_attributes>");
				//reqXml.append("<INM-TELLER-ID>815010101001</INM-TELLER-ID>");
				reqXml.append("<BRANCHID-IDENTIFY>"+PropetiesLoader.getSystemConfig().getString("esb.virtual.tellerno")+"</BRANCHID-IDENTIFY>");//使用虚拟柜员号
				reqXml.append("</ext_attributes>");
				reqXml.append("<request>");
				reqXml.append("<FUNC-CODE>1</FUNC-CODE>");  //
				reqXml.append("<BOOKING-ID>"+bookBandReq.getOrderId()+"</BOOKING-ID>");  //预约id
				reqXml.append("<BOOKING-NO>"+bookBandReq.getOrderNum()+"</BOOKING-NO>");  //预约号
				reqXml.append("<QUEUE-NO>"+bookBandReq.getTicketNo()+"</QUEUE-NO>");  //排队号
				reqXml.append("</request>");
				reqXml.append("<response/>");
				reqXml.append("</Service_Body>");
				reqXml.append("</Service>");
				
				//调用发送接口
				String ip = PropetiesLoader.getSystemConfig().getString("esb.core.ip", "");
				int port = PropetiesLoader.getSystemConfig().getInt("esb.core.port", 10086);
				EsbServiceResp esbServiceResp = new EsbServiceResp();
				String respXml = SendUtil.socketSendData(reqXml.toString(), ip, port, esbServiceResp, "UTF-8", 7);
				logger.info("BookBandProcess：esb返回内容："+respXml);
				if (esbServiceResp.getStatus().equals("FAIL")){  //esb返回交易失败
					bookBandResp.getHead().setTransStatus("9999");
					bookBandResp.getHead().setTransDescription("预约绑定 失败【调用esb接口】："+esbServiceResp.getDesc());
				} else { //请求成功
					
					//将前面的报文长度截取掉
					respXml = respXml.substring(7);
					
					//对返回内容进行解析
					try{
						SAXReader reader = new SAXReader();
						ByteArrayInputStream bais = new ByteArrayInputStream(respXml.getBytes("UTF-8"));
						Document document = reader.read(bais);
						Node statusNode = document.selectSingleNode("/Service/Service_Header/service_response/status");
						Node descNode = document.selectSingleNode("/Service/Service_Header/service_response/desc");
						logger.info("预约绑定：esb交易状态："+statusNode.getStringValue()+"  esb交易描述:"+descNode.getStringValue());
						String transStatus = statusNode.getStringValue();
						if (transStatus.equals("FAIL")){  //处理请求失败
							bookBandResp.getHead().setTransStatus("9999");
							bookBandResp.getHead().setTransDescription("预约绑定ESB异常 ："+descNode.getStringValue());
						} else {
							bookBandResp.getHead().setTransStatus("0000");
							bookBandResp.getHead().setTransDescription("预约绑定ESB返回 ："+descNode.getStringValue());
							bookBandResp.setData(bookBandDataResp);
						}
					} catch(Exception e){
						bookBandResp.getHead().setTransStatus("9999");
						bookBandResp.getHead().setTransDescription("预约绑定 ：esb返回报文解析异常");
						logger.info("【EsbRequest】xml解析异常",e);
					}
				}
			}
		} catch (Exception e) {
			logger.info("BookActiveProcess：预约绑定处理异常：对象转换异常。",e);
			bookBandResp.getHead().setTransStatus("9999");
			bookBandResp.getHead().setTransDescription("预约绑定处理异常：对象转换异常");
		}
		logger.info("BookActiveProcess：预约绑定处理完成，开始封装返回信息：====》");
		String json = "";
		try {
			json = JsonUtils.obj2json(bookBandResp);
			logger.info("BookActiveProcess：预约绑定，封装返回信息="+json);
		} catch (Exception e) {
			logger.info("BookActiveProcess：预约绑定，将返回信息转换成json异常。",e);
			json = "{"+
			    "\"head\":{"+
			        "\"transCode\":\""+transCode+"\","+
			        "\"transDateTime\":\""+DateFormatUtils.format(new Date(), "yyyy-MM-dd HH:mm:ss")+"\","+
			        "\"transStatus\":\"9999\","+
			        "\"transDescription\":\"预约绑定，返回信息转换成json异常\""+
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
			        "\"transCode\":\"Y002\","+
			        "\"transDateTime\":\"2017-7-10 19:20:27\","+
			        "\"transStatus\":\"\","+
			        "\"transDescription\":\"\""+
			    "},"+
			    "\"data\":{"+
			        "\"transNet\":\"33\","+
			        "\"deviceId\":\"9010010201\","+
			        //"\"orgCode\":\"815777777\","+
			        "\"orgCode\":\"815010101\","+
			        "\"deviceIp\":\"172.16.210.99\","+
			        "\"mediaType\":\"4\","+
			        "\"mediaId\":\"000015\","+
			        "\"orderId\":\"81501010120170513A012\","+
			        "\"orderNum\":\"000015\","+
			        "\"ticketNo\":\"3009\""+
			        
			    "}"+
			"}";
		JsonNode rootNode = JsonUtils.getRoot(reqJson);
		BookBandProcess bookBandProcess = new BookBandProcess();
		String respJson = bookBandProcess.bandBookCode(null, "Y002", rootNode);
		System.out.println(respJson);
	}
	
}
