package com.aoto.iqms.externals.dealprocess;

import java.io.ByteArrayInputStream;
import java.text.SimpleDateFormat;
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
import org.springframework.beans.factory.annotation.Autowired;

import com.aoto.iqms.basicconfig.service.inf.OrderConfigService;
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
import com.aoto.iqms.externals.service.inf.ResourceService;
import com.aoto.iqms.util.JsonUtils;
import com.aoto.iqms.util.PropetiesLoader;
import com.aoto.iqms.util.SendUtil;
import com.fasterxml.jackson.databind.JsonNode;

/**
 * 预约激活处理过程
 * @author hongxz
 *
 */
public class BookActiveProcess {
	private static final Logger logger = LoggerFactory
			.getLogger(BookActiveProcess.class);

	public BookActiveProcess() {
		super();
	}
	//预约本地激活
	public String activeOrder(OrderConfigService orderService, String transCode, JsonNode root){
		//创建响应对象
		BookActiveResp bookActiveResp  = new BookActiveResp();
		
		bookActiveResp.getHead().setTransCode(transCode);
		bookActiveResp.getHead().setTransDateTime(DateFormatUtils.format(new Date(), "yyyy-MM-dd HH:mm:ss"));
		
		try {
			//将json的请求数据封装成对象
			//1.获取数据部分的报文
			JsonNode dataNode = root.findValue("data");
			if (dataNode == null) {
				bookActiveResp.getHead().setTransStatus("9999");
				bookActiveResp.getHead().setTransDescription("预约本地激活失败 ：没有发现data节点数据");
				logger.info("预约本地激活失败 ：没有发现data节点数据");
				return responseJson(transCode, bookActiveResp);
			} 
			String dataJson = dataNode.toString();
			BookActiveReq bookActiveReq = JsonUtils.json2pojo(dataJson, BookActiveReq.class);
			//数据返回对象
			BookActiveDataResp bookActiveDataResp = new BookActiveDataResp();
			
			String deviceId = bookActiveReq.getDeviceId();//设备号
			String mediaType = bookActiveReq.getMediaType(); // 1-身份证；4-激活码；2-银行卡；6-手机号
			String mediaId = bookActiveReq.getMediaId(); //客户内容
			logger.info("激活介质类型："+mediaType+"  激活介质内容："+mediaId);
			List<Map<String, Object>> list = orderService.queryOrderInfo(deviceId,mediaType, mediaId);
			if(list.size() == 0){
				bookActiveResp.getHead().setTransStatus("9999");
				bookActiveResp.getHead().setTransDescription("预约本地激活失败 ：没有预约记录");
				logger.info("预约本地激活失败 ：没有没有预约记录");
				return responseJson(transCode, bookActiveResp);
			}else{
				String orderDate = (String)list.get(0).get("orderDate");
				String rangeEnd = (String)list.get(0).get("rangeEnd");
				mediaType = (String)list.get(0).get("certType");
				mediaId = (String)list.get(0).get("certContent");
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
	    		String bookEndTime = orderDate+" "+rangeEnd;
	    		try {
					Date bookDt = sdf.parse(bookEndTime);
					if (bookDt.before(new Date())){ //当前日期已经超过了预约日期的结束时间，就失效
						bookActiveResp.getHead().setTransStatus("9999");
						bookActiveResp.getHead().setTransDescription("预约本地激活失败 ：预约时间已过");
						logger.info("预约本地激活失败 ：预约时间已过");
						return responseJson(transCode, bookActiveResp);
					}else{
						String orderBuzTypeId = (String)list.get(0).get("orderBusId");//预约业务id
						//封装返回信息
						bookActiveDataResp.setDeviceId(deviceId);
						bookActiveDataResp.setDeviceIp(bookActiveReq.getDeviceIp());
						bookActiveDataResp.setTransNet(bookActiveReq.getTransNet());
						bookActiveDataResp.setMediaId(mediaId);
						bookActiveDataResp.setMediaType(mediaType);
						bookActiveDataResp.setActDate(DateFormatUtils.format(new Date(), "yyyy-MM-dd HH:mm:ss"));
						bookActiveDataResp.setWfFlag("");  //是否填单
						bookActiveDataResp.setCustId(""); //客户号，预约客户号
						bookActiveDataResp.setCustLevel(PropetiesLoader.getAuthTestConfig().getString("custLevel")); //预约的客户类型
						bookActiveDataResp.setOrderbuzTypeId(orderBuzTypeId); //预约业务id
						bookActiveDataResp.setOrderId(list.get(0).get("orderId").toString()); //预约id，用于绑定记录  客户端会再返回过来
						bookActiveDataResp.setOrderNum(""); //预约码 ：也是用于绑定预约记录
						
						bookActiveResp.getHead().setTransDescription("成功");
						bookActiveResp.getHead().setTransStatus("0000");
						bookActiveResp.setData(bookActiveDataResp);
						return  responseJson(transCode, bookActiveResp);
					}
				} catch (Exception e) {
					logger.info("预约本地激活处理异常：预约记录中时间转换异常",e);
					bookActiveResp.getHead().setTransStatus("9999");
					bookActiveResp.getHead().setTransDescription("预约本地激活失败：对象转换异常");
					return  responseJson(transCode, bookActiveResp);
				}
			}
			
		} catch (Exception e) {
			logger.info("BookActiveProcess：预约本地激活处理异常：对象转换异常。",e);
			bookActiveResp.getHead().setTransStatus("9999");
			bookActiveResp.getHead().setTransDescription("预约本地激活失败：对象转换异常");
			return  responseJson(transCode, bookActiveResp);
		}
	}
	
	/**
	 * 预约激活操作
	 * @param resourceService
	 * @param transCode
	 * @param json
	 * @return
	 */
	public String activeBookCode(ResourceService resourceService,
			String transCode,JsonNode root){
		//创建响应对象
		BookActiveResp bookActiveResp  = new BookActiveResp();
		
		bookActiveResp.getHead().setTransCode(transCode);
		bookActiveResp.getHead().setTransDateTime(DateFormatUtils.format(new Date(), "yyyy-MM-dd HH:mm:ss"));
		try {
			//将json的请求数据封装成对象
			//1.获取数据部分的报文
			JsonNode dataNode = root.findValue("data");
			if (dataNode == null) {
				bookActiveResp.getHead().setTransStatus("9999");
				bookActiveResp.getHead().setTransDescription("预约激活失败 ：没有发现data节点数据");
				logger.info("预约激活失败 ：没有发现data节点数据");
				return responseJson(transCode, bookActiveResp);
			} 
			
			String dataJson = dataNode.toString();
			BookActiveReq bookActiveReq = JsonUtils.json2pojo(dataJson, BookActiveReq.class);
			//数据返回对象
			BookActiveDataResp bookActiveDataResp = new BookActiveDataResp();
			
			String mediaType = bookActiveReq.getMediaType(); // 1-二代证  2-刷卡   4-预约取号
			String mediaId = bookActiveReq.getMediaId(); //客户内容
			
			logger.info("激活介质类型："+mediaType+"  激活介质内容："+mediaId);
			
			String orderNum = ""; //预约号码
			String certType = ""; //证件类型
			String certConetent = "";  //证件内容
			String custName = "";  //客户姓名
			String funcCode = "";   //功能id
			
			//输入激活码
			if (mediaType.equals("4")){ 
				logger.info("预约激活方式：输入预约号进行激活");
				orderNum = mediaId;
				funcCode = "1";
			} 
			
			//二代证（需要调用核心接口获取客户全称）
			if (mediaType.equals("1")) { 
				logger.info("预约激活方式：刷身份证激活，开始调用esb接口查询客户全称信息");
				certType = "A"; //身份证
				certConetent = mediaId; //证件内容
				funcCode = "2";
				custName = bookActiveReq.getCertName(); //刷身份证直接送过来 by hongxz 20170823,下面全部注释掉
				/*  无需调用核心去查客户姓名
				//调用核心通过身份证号查询客户信息的接口
				String reqXml = findCustFullNameXml(bookActiveReq.getOrgCode(),certType,certConetent);
				logger.info("预约激活 【调用esb接口查询客户全名接口】请求报文："+reqXml);
				String ip = PropetiesLoader.getSystemConfig().getString("esb.core.ip", "");
				int port = PropetiesLoader.getSystemConfig().getInt("esb.core.port", 10086);
				logger.info("预约激活方式：esb核心地址：ip："+ip+" port:"+port);
				EsbServiceResp esbServiceResp = new EsbServiceResp();
				String respXml = SendUtil.socketSendData(reqXml, ip, port, esbServiceResp, "UTF-8", 7);
				logger.info("预约激活 【调用esb接口查询客户全名接口】报文："+respXml);
				if (esbServiceResp.getStatus().equals("FAIL")){  //
					bookActiveResp.getHead().setTransStatus("9999");
					bookActiveResp.getHead().setTransDescription("预约激活 ：【调用esb接口查询客户全名接口失败】："+esbServiceResp.getDesc());
					logger.info("预约激活 ：【调用esb接口查询客户全名接口失败】："+esbServiceResp.getDesc());
					return responseJson(transCode, bookActiveResp);
				} 
				//解析报文返回的信息
				try{
					respXml = respXml.substring(7);
					SAXReader reader = new SAXReader();
					ByteArrayInputStream bais = new ByteArrayInputStream(respXml.getBytes("UTF-8"));
					Document document = reader.read(bais);
					Node statusNode = document.selectSingleNode("/Service/Service_Header/service_response/status");
					Node descNode = document.selectSingleNode("/Service/Service_Header/service_response/desc");
					logger.info("预约激活：esb核心查询客户全称接口状态："+statusNode.getStringValue()+" 交易描述:"+descNode.getStringValue());
					String transStatus = statusNode.getStringValue();
					if (transStatus.equals("FAIL")){  //处理请求失败
						bookActiveResp.getHead().setTransStatus("9999");
						bookActiveResp.getHead().setTransDescription("预约激活：esb核心查询客户全称接口异常 ："+descNode.getStringValue());
						return  responseJson(transCode, bookActiveResp);
					}
					//获取客户信息
					Node fullName1Node = document.selectSingleNode("/Service/Service_Body/response/FULL-NAM1");
					Node fullName2Node = document.selectSingleNode("/Service/Service_Body/response/FULL-NAM-120-1");
					//核心返回的数据有空格
					if (fullName1Node != null) {
						custName = fullName1Node.getStringValue().trim();
						logger.info("预约激活：esb核心查询客户全称1【FULL-NAM1】："+custName);
					}
					
					if (fullName2Node != null) {
						custName = fullName1Node.getStringValue().trim();
						logger.info("预约激活：esb核心查询客户全称2【FULL-NAM-120-1】："+custName);
					}
					logger.info("预约激活：esb核心查询客户全称：姓名："+custName+" 证件类型："+certType+" 证件内容："+certConetent);
				} catch(Exception e){
					bookActiveResp.getHead().setTransStatus("9999");
					bookActiveResp.getHead().setTransDescription("预约激活：esb核心查询客户全称,xml解析异常");
					logger.info("【预约激活：esb核心查询客户全称】xml解析异常",e);
					return responseJson(transCode, bookActiveResp);
				}
				
				
//				System.out.println("身份证激活");
//				//20170719 手工测试代码，注释上面内容
//				certType = "B"; //身份证
//				certConetent = "1031"; //证件内容
//				funcCode = "2";
//				custName = "1031";
 * */
			} 
			
			//刷卡激活（需要调用核心卡号查询接口，获取客户信息）
			if (mediaType.equals("2")){ 
				funcCode = "2";
				logger.info("预约激活方式：刷卡激活，开始调用esb接口查询客户信息");
				//通过卡号查询客户身份信息
				String reqXml = findCustInfoByAcctXml(bookActiveReq.getOrgCode(),mediaId);
				logger.info("预约激活 【调用esb卡号查询客户信息接口】请求报文："+reqXml);
				String ip = PropetiesLoader.getSystemConfig().getString("esb.core.ip", "");
				int port = PropetiesLoader.getSystemConfig().getInt("esb.core.port", 10086);
				logger.info("预约激活方式：esb核心地址：ip："+ip+" port:"+port);
				EsbServiceResp esbServiceResp = new EsbServiceResp();
				String respXml = SendUtil.socketSendData(reqXml, ip, port, esbServiceResp, "UTF-8", 7);
				logger.info("预约激活 【调用esb卡号查询客户信息接口】返回报文："+respXml);
				if (esbServiceResp.getStatus().equals("FAIL")){  //
					bookActiveResp.getHead().setTransStatus("9999");
					bookActiveResp.getHead().setTransDescription("预约激活失败："+esbServiceResp.getDesc());
					logger.info("预约激活 失败【调用esb卡号查询客户信息接口】："+esbServiceResp.getDesc());
					return responseJson(transCode, bookActiveResp);
				} 
				//解析报文返回的信息
				try{
					respXml = respXml.substring(7);
					SAXReader reader = new SAXReader();
					ByteArrayInputStream bais = new ByteArrayInputStream(respXml.getBytes("UTF-8"));
					Document document = reader.read(bais);
					Node statusNode = document.selectSingleNode("/Service/Service_Header/service_response/status");
					Node descNode = document.selectSingleNode("/Service/Service_Header/service_response/desc");
					logger.info("预约激活：调用esb卡号查询客户信息接口状态："+statusNode.getStringValue()+" 交易描述:"+descNode.getStringValue());
					String transStatus = statusNode.getStringValue();
					if (transStatus.equals("FAIL")){  //处理请求失败
						bookActiveResp.getHead().setTransStatus("9999");
						bookActiveResp.getHead().setTransDescription("预约激活失败："+descNode.getStringValue());
						return  responseJson(transCode, bookActiveResp);
					}
					//获取客户信息
					Node cerTypeNode = document.selectSingleNode("/Service/Service_Body/response/CER-TYP");
					Node cerNoNode = document.selectSingleNode("/Service/Service_Body/response/CER-NO");
					Node fullNameNode = document.selectSingleNode("/Service/Service_Body/response/FULL-NAM");
					if (cerTypeNode == null) {
						logger.info("预约激活：调用esb卡号查询客户信息异常：未能查询到客户信息。");
						bookActiveResp.getHead().setTransStatus("9999");
						bookActiveResp.getHead().setTransDescription("预约激活失败：未能查询到客户信息");
						return  responseJson(transCode, bookActiveResp);
					}
					
					custName =  fullNameNode.getStringValue();
					certConetent = cerNoNode.getStringValue();
					certType =  cerTypeNode.getStringValue();
					
					logger.info("预约激活：调用esb卡号查询客户信息：姓名："+custName+" 证件类型："+certType+" 证件内容："+certConetent);
					
				} catch(Exception e){
					bookActiveResp.getHead().setTransStatus("9999");
					bookActiveResp.getHead().setTransDescription("预约激活失败：调用esb卡号查询客户信息异常,xml解析异常");
					logger.info("【预约激活：调用esb卡号查询客户信息】xml解析异常",e);
					return responseJson(transCode, bookActiveResp);
				}
				
				//20170719测试 上面注释掉
//				System.out.println("卡号激活");
//				certType = "B"; //身份证
//				certConetent = "1031"; //证件内容
//				funcCode = "2";
//				custName = "1031";
			}
			
			//封装esb预约激活的请求报文
			String reqXml = fetchActiveXml(bookActiveReq.getOrgCode(), funcCode, orderNum, custName, certType, certConetent);
			logger.info("预约激活 【调用esb预约激活接口】请求报文："+reqXml);
			//调用发送接口
			String ip = PropetiesLoader.getSystemConfig().getString("esb.core.ip", "");
			int port = PropetiesLoader.getSystemConfig().getInt("esb.core.port", 10086);
			EsbServiceResp esbServiceResp = new EsbServiceResp();
			String respXml = SendUtil.socketSendData(reqXml, ip, port, esbServiceResp, "UTF-8", 7);
			logger.info("BookActiveProcess：esb返回内容："+respXml);
			if (esbServiceResp.getStatus().equals("FAIL")){  //
				bookActiveResp.getHead().setTransStatus("9999");
				bookActiveResp.getHead().setTransDescription("预约激活失败："+esbServiceResp.getDesc());
				logger.info("BookActiveProcess：调用预约激活接口失败："+esbServiceResp.getDesc());
				return  responseJson(transCode, bookActiveResp);
			} //请求成功
			//将前面的报文长度截取掉
			respXml = respXml.substring(7);
			//对返回内容进行解析
			try{
				SAXReader reader = new SAXReader();
				ByteArrayInputStream bais = new ByteArrayInputStream(respXml.getBytes("UTF-8"));
				Document document = reader.read(bais);
				Node statusNode = document.selectSingleNode("/Service/Service_Header/service_response/status");
				Node descNode = document.selectSingleNode("/Service/Service_Header/service_response/desc");
				logger.info("预约激活：esb交易状态："+statusNode.getStringValue()+"  esb交易描述:"+descNode.getStringValue());
				String transStatus = statusNode.getStringValue();
				if (transStatus.equals("FAIL")){  //处理请求失败
					bookActiveResp.getHead().setTransStatus("9999");
					bookActiveResp.getHead().setTransDescription("预约激活失败 ："+descNode.getStringValue());
					logger.info("BookActiveProcess：预约激活接口ESB异常："+esbServiceResp.getDesc());
					return  responseJson(transCode, bookActiveResp);
				} 
				Node bookIdNode = document.selectSingleNode("/Service/Service_Body/response/BOOKING-ID");
				Node bookNoNode = document.selectSingleNode("/Service/Service_Body/response/BOOKING-NO");
				Node busnTypeNode = document.selectSingleNode("/Service/Service_Body/response/BUSN-TYPE");
				Node bookDateNode = document.selectSingleNode("/Service/Service_Body/response/BOOKING-DATE");
				Node strTimeNode = document.selectSingleNode("/Service/Service_Body/response/STR-TIME");
				Node endTimeNode = document.selectSingleNode("/Service/Service_Body/response/END-TIME");
				Node billFlagNode = document.selectSingleNode("/Service/Service_Body/response/BILL-FLAG");
					
				if (bookIdNode == null) { //数据不存在
					bookActiveResp.getHead().setTransStatus("9999");
					bookActiveResp.getHead().setTransDescription("预约激活失败：未能查询到预约信息");
					logger.info("BookActiveProcess预约激活失败：未能查询到预约信息");
					return  responseJson(transCode, bookActiveResp);
				} 
				String bookId = bookIdNode.getStringValue();
				String bookNo = bookNoNode.getStringValue();
				String busnType = busnTypeNode.getStringValue();
				
				//业务类型需要转换
				busnType = PropetiesLoader.getSystemConfig().getString("bustype."+busnType, "");
				
				logger.info("预约激活 预约业务类型转换结果 ："+busnType);
				String bookDate = bookDateNode.getStringValue();
				String strTime = strTimeNode.getStringValue();
				String endTime = endTimeNode.getStringValue();
				String billFlag = billFlagNode.getStringValue();
				//判断预约的有效性
				String orderBeginTime = bookDate+" "+strTime;
				String orderEndTime = bookDate+" "+endTime;
				logger.info("预约激活预约的时间段：开始时间："+orderBeginTime+" 结束时间："+orderEndTime);
				//判断当前时间是否合法
				
				
				//封装返回信息
				bookActiveDataResp.setActDate(DateFormatUtils.format(new Date(), "yyyy-MM-dd HH:mm:ss"));
				bookActiveDataResp.setWfFlag(billFlag);  //是否填单
				bookActiveDataResp.setCustId(""); //客户号，预约客户号
				bookActiveDataResp.setCustLevel("3800"); //预约的客户类型
				bookActiveDataResp.setOrderbuzTypeId(busnType); //预约业务id
				bookActiveDataResp.setOrderId(bookId); //预约id，用于绑定记录  客户端会再返回过来
				bookActiveDataResp.setOrderNum(bookNo); //预约码 ：也是用于绑定预约记录
				
				bookActiveResp.getHead().setTransDescription("成功");
				bookActiveResp.getHead().setTransStatus("0000");
				bookActiveResp.setData(bookActiveDataResp);
				return  responseJson(transCode, bookActiveResp);
			} catch(Exception e){
				bookActiveResp.getHead().setTransStatus("9999");
				bookActiveResp.getHead().setTransDescription("预约激活 ：esb返回报文解析失败");
				logger.info("【EsbRequest】xml解析异常",e);
				return  responseJson(transCode, bookActiveResp);
			}
		} catch (Exception e) {
			logger.info("BookActiveProcess：预约激活处理异常：对象转换异常。",e);
			bookActiveResp.getHead().setTransStatus("9999");
			bookActiveResp.getHead().setTransDescription("预约激活失败：对象转换异常");
			return  responseJson(transCode, bookActiveResp);
		}
	}


	/**
	 * 封装响应的json信息
	 * @param transCode
	 * @param bookActiveResp
	 * @return
	 */
	private String responseJson(String transCode, BookActiveResp bookActiveResp) {
		logger.info("BookActiveProcess：预约激活处理，开始封装返回信息：====》");
		String json = "";
		try {
			json = JsonUtils.obj2json(bookActiveResp);
			logger.info("BookActiveProcess：预约激活，封装返回信息="+json);
		} catch (Exception e) {
			logger.info("BookActiveProcess：预约激活，将返回信息转换成json异常。",e);
			json = "{"+
			    "\"head\":{"+
			        "\"transCode\":\""+transCode+"\","+
			        "\"transDateTime\":\""+DateFormatUtils.format(new Date(), "yyyy-MM-dd HH:mm:ss")+"\","+
			        "\"transStatus\":\"9999\","+
			        "\"transDescription\":\"预约激活，返回信息转换成json异常\""+
			    "}"+
			"}";
		}
		return json;
	}
	
	/**
	 * 查询客户全称的xml
	 * @param orgCode  机构编码
	 * @param acctNO  证件类型
	 * @param funcCode  证件内容
	 * @return
	 * @throws ConfigurationException 
	 */
	private String findCustInfoByAcctXml(String orgCode ,String acctNO) throws ConfigurationException{
		StringBuilder reqXml = new StringBuilder("<?xml version= \"1.0\" encoding= \"UTF-8\" ?>");
		//计算交易流水号
		long coreCustSn = PropetiesLoader.getSystemConfig().getLong("esb.core.sn")+1;
		if (coreCustSn == 309999999) {  //达到最大值，就恢复到初始值
			coreCustSn = 309000000;
		} else {
			coreCustSn++;
		}
		PropetiesLoader.getSystemConfig().setProperty("esb.core.sn", coreCustSn);
	    PropetiesLoader.getSystemConfig().save();
		//流水号 （系统保留就使用0） 第一位固定1,2-3位地市编码济宁58，4-7系统编号0091，8-9系统保留默认0,10系统保留默认0,11-19位流水号13位固定9表示外网系统，流水号三天内不重复
		String requesterId = PropetiesLoader.getSystemConfig().getString("esb.iqms.requester_id");
		String requesterIdSn = PropetiesLoader.getSystemConfig().getString("esb.iqms.requester_id_sn");
	    String service_sn = "158"+requesterIdSn+"000"+coreCustSn;
		reqXml.append("<Service>");
		reqXml.append("<Service_Header>");
		reqXml.append("<service_sn>"+service_sn+"</service_sn>");
		reqXml.append("<requester_id>"+requesterId+"</requester_id>");  //我们系统编号(联盟分配)
		reqXml.append("<channel_id>"+PropetiesLoader.getSystemConfig().getString("esb.iqms.channel_id")+"</channel_id>"); //联盟分配
		reqXml.append("<service_time>"+DateFormatUtils.format(new Date(), "yyyyMMddHHmmss")+"</service_time>"); //年月日时分秒（系统时间）
		reqXml.append("<version_id>01</version_id>");  //固定01
		reqXml.append("<service_id>"+PropetiesLoader.getSystemConfig().getString("esb.custacctno.serviceid")+"</service_id>"); //客户信息全称查询
		reqXml.append("<branch_id>"+orgCode+"</branch_id>");
		reqXml.append("<service_response/>");
		reqXml.append("</Service_Header>");
		reqXml.append("<Service_Body>");
		reqXml.append("<ext_attributes>");
		reqXml.append("<BRANCHID-IDENTIFY>"+PropetiesLoader.getSystemConfig().getString("esb.virtual.tellerno")+"</BRANCHID-IDENTIFY>");//使用虚拟柜员号
		reqXml.append("</ext_attributes>");
		reqXml.append("<request>");
		reqXml.append("<ACCT-NO>"+acctNO+"</ACCT-NO>");  //卡号
		reqXml.append("</request>");
		reqXml.append("<response/>");
		reqXml.append("</Service_Body>");
		reqXml.append("</Service>");
		
		return reqXml.toString();
	}
	
	/**
	 * 查询客户全称的xml
	 * @param orgCode  机构编码
	 * @param certType  证件类型
	 * @param funcCode  证件内容
	 * @return
	 * @throws ConfigurationException 
	 */
	private String findCustFullNameXml(String orgCode ,String certType,String certContent) throws ConfigurationException{
		StringBuilder reqXml = new StringBuilder("<?xml version= \"1.0\" encoding= \"UTF-8\" ?>");
		//计算交易流水号
		long coreCustSn = PropetiesLoader.getSystemConfig().getLong("esb.core.sn")+1;
		if (coreCustSn == 309999999) {  //达到最大值，就恢复到初始值
			coreCustSn = 309000000;
		} else {
			coreCustSn++;
		}
		PropetiesLoader.getSystemConfig().setProperty("esb.core.sn", coreCustSn);
	    PropetiesLoader.getSystemConfig().save();
		//流水号 （系统保留就使用0） 第一位固定1,2-3位地市编码济宁58，4-7系统编号0091，8-9系统保留默认0,10系统保留默认0,11-19位流水号13位固定9表示外网系统，流水号三天内不重复
		String requesterId = PropetiesLoader.getSystemConfig().getString("esb.iqms.requester_id");
		String requesterIdSn = PropetiesLoader.getSystemConfig().getString("esb.iqms.requester_id_sn");
	    String service_sn = "158"+requesterIdSn+"000"+coreCustSn;
		reqXml.append("<Service>");
		reqXml.append("<Service_Header>");
		reqXml.append("<service_sn>"+service_sn+"</service_sn>");
		reqXml.append("<requester_id>"+requesterId+"</requester_id>");  //我们系统编号(联盟分配)
		reqXml.append("<channel_id>"+PropetiesLoader.getSystemConfig().getString("esb.iqms.channel_id")+"</channel_id>"); //联盟分配
		reqXml.append("<service_time>"+DateFormatUtils.format(new Date(), "yyyyMMddHHmmss")+"</service_time>"); //年月日时分秒（系统时间）
		reqXml.append("<version_id>01</version_id>");  //固定01
		reqXml.append("<service_id>"+PropetiesLoader.getSystemConfig().getString("esb.custfullname.serviceid")+"</service_id>"); //客户信息全称查询
		reqXml.append("<branch_id>"+orgCode+"</branch_id>");
		reqXml.append("<service_response/>");
		reqXml.append("</Service_Header>");
		reqXml.append("<Service_Body>");
		reqXml.append("<ext_attributes>");
		//reqXml.append("<INM-TELLER-ID>"+PropetiesLoader.getSystemConfig().getString("esb.virtual.tellerno").replace("@", " ")+"</INM-TELLER-ID>"); //虚拟柜员工号,12位，不够补空格
		reqXml.append("<BRANCHID-IDENTIFY>"+PropetiesLoader.getSystemConfig().getString("esb.virtual.tellerno")+"</BRANCHID-IDENTIFY>");//使用虚拟柜员号
		//reqXml.append("<T_KEY_LABEL>X000PG05</T_KEY_LABEL>"); //esb自动分配虚拟柜员（与上面同时只用一个）
		reqXml.append("</ext_attributes>");
		reqXml.append("<request>");
		reqXml.append("<CER-TYP>"+certType+"</CER-TYP>");  //证件类型
		reqXml.append("<CER-NO>"+certContent+"</CER-NO>");  //证件内容
		reqXml.append("</request>");
		reqXml.append("<response/>");
		reqXml.append("</Service_Body>");
		reqXml.append("</Service>");
		
		return reqXml.toString();
	}
	
	
	/**
	 * 组装预约激活xml报文
	 * @param orgCode  机构编码
	 * @param funcCode  功能id 1-预约号码激活（激活码不能为空）    2-证件激活（客户姓名，证件类型，证件内容不能为空）
	 * @param orderNum 预约号码
	 * @param custName 客户姓名  
	 * @param certType 证件类型
	 * @param certContent  证件内容
	 * @return
	 * @throws ConfigurationException 
	 */
	private String fetchActiveXml(String orgCode,String funcCode,
			String orderNum, String custName ,String certType,String certContent ) throws ConfigurationException{
		StringBuilder reqXml = new StringBuilder("<?xml version= \"1.0\" encoding= \"UTF-8\" ?>");
		//计算交易流水号
		long orderActiveSn = PropetiesLoader.getSystemConfig().getLong("order.active.sn");
		if (orderActiveSn == 109999999) {  //达到最大值，就恢复到初始值
			orderActiveSn = 109000000;
		} else {
			orderActiveSn++;
		}
		
		PropetiesLoader.getSystemConfig().setProperty("order.active.sn", orderActiveSn);
	    PropetiesLoader.getSystemConfig().save();
	    
		//流水号 （系统保留就使用0） 第一位固定1,2-3位地市编码济宁58，4-7系统编号0091，8-9系统保留默认0,10系统保留默认0,11-19位流水号13位固定9表示外网系统，流水号三天内不重复
	    String requesterIdSn = PropetiesLoader.getSystemConfig().getString("esb.iqms.requester_id_sn");
	    String service_sn = "158"+requesterIdSn+"000"+orderActiveSn;
		reqXml.append("<Service>");
		reqXml.append("<Service_Header>");
		reqXml.append("<service_sn>"+service_sn+"</service_sn>");
		reqXml.append("<requester_id>"+PropetiesLoader.getSystemConfig().getString("esb.iqms.requester_id")+"</requester_id>");  //我们系统编号(联盟分配)
		reqXml.append("<channel_id>"+PropetiesLoader.getSystemConfig().getString("esb.iqms.channel_id")+"</channel_id>"); //联盟分配
		reqXml.append("<service_time>"+DateFormatUtils.format(new Date(), "yyyyMMddHHmmss")+"</service_time>"); //年月日时分秒（系统时间）
		reqXml.append("<version_id>01</version_id>");  //固定01
		reqXml.append("<service_id>"+PropetiesLoader.getSystemConfig().getString("order.active.serid")+"</service_id>"); //接口id 这是预约激活
		reqXml.append("<branch_id>"+orgCode+"</branch_id>");
		reqXml.append("<service_response/>");
		reqXml.append("</Service_Header>");
		reqXml.append("<Service_Body>");
		reqXml.append("<ext_attributes>");
		//reqXml.append("<INM-TELLER-ID>"+PropetiesLoader.getSystemConfig().getString("esb.virtual.tellerno").replace("@", " ")+"</INM-TELLER-ID>"); //虚拟柜员工号,12位，不够补空格
		reqXml.append("<BRANCHID-IDENTIFY>"+PropetiesLoader.getSystemConfig().getString("esb.virtual.tellerno")+"</BRANCHID-IDENTIFY>");//使用虚拟柜员号
		reqXml.append("</ext_attributes>");
		reqXml.append("<request>");
		reqXml.append("<FUNC-CODE>"+funcCode+"</FUNC-CODE>");  //功能号id
		reqXml.append("<BOOKING-NO>"+orderNum+"</BOOKING-NO>");  //预约号
		reqXml.append("<CUST-NAME>"+custName+"</CUST-NAME>");  //客户姓名
		reqXml.append("<CUST-CERT-TYPE>"+certType+"</CUST-CERT-TYPE>");  //证件类型
		reqXml.append("<CUST-CERT-ID>"+certContent+"</CUST-CERT-ID>");  //证件内容
		reqXml.append("</request>");
		reqXml.append("<response/>");
		reqXml.append("</Service_Body>");
		reqXml.append("</Service>");
		
		return reqXml.toString();
	}
	
	
	/**
	 * 预约激活测试
	 * @param args
	 */
	public static void main(String[] args) {
		String reqJson = "{"+
			    "\"head\":{"+
			        "\"transCode\":\"Y001\","+
			        "\"transDateTime\":\"2017-7-10 19:20:27\","+
			        "\"transStatus\":\"\","+
			        "\"transDescription\":\"\""+
			    "},"+
			    "\"data\":{"+
			        "\"transNet\":\"33\","+
			        "\"deviceId\":\"9010010201\","+
			        "\"orgCode\":\"815012801\","+  //预约激活测试 机构号-815012401    查询核心数据机构号：815012801
			        "\"deviceIp\":\"172.16.210.99\","+
//			        "\"mediaType\":\"4\","+
//			        "\"mediaId\":\"000015\","+
					"\"mediaType\":\"2\","+
					"\"mediaId\":\"6212000101010766385\","+
			        "\"actDateTime\":\"2017-7-10 19:20:27\""+
			    "}"+
			"}";
		JsonNode rootNode = JsonUtils.getRoot(reqJson);
		BookActiveProcess bookActiveProcess = new BookActiveProcess();
		String respJson = bookActiveProcess.activeBookCode(null, "Y001", rootNode);
		System.out.println(respJson);
		
	}
	
	
	
}
