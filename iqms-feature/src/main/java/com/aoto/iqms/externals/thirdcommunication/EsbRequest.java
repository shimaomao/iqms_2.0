package com.aoto.iqms.externals.thirdcommunication;



import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InterruptedIOException;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.ConnectException;
import java.net.InetSocketAddress;
import java.net.Socket;
import java.net.SocketAddress;
import java.net.SocketTimeoutException;
import java.util.Arrays;
import java.util.Date;
import java.util.Formatter;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.time.DateFormatUtils;
import org.dom4j.Document;
import org.dom4j.Element;
import org.dom4j.Node;
import org.dom4j.io.SAXReader;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.aoto.framework.commons.lang.StringUtils4Aoto;
import com.aoto.iqms.externals.models.EsbServiceResp;
import com.aoto.iqms.externals.service.inf.ResourceService;
import com.aoto.iqms.util.JsonUtils;
import com.aoto.iqms.util.PropetiesLoader;
import com.aoto.iqms.util.SendUtil;
import com.aoto.iqms.util.SpringContextUtil;
import com.fasterxml.jackson.databind.JsonNode;


//处理远程取号请求
public class EsbRequest implements Runnable {

	private static final Logger logger = LoggerFactory.getLogger(EsbRequest.class);
	public static int remotePort =Integer.parseInt( PropetiesLoader.getSystemConfig().getString("remotePort"));//远程取号接口
	private Socket socket;

	private ResourceService resourceService;
	private final String  ENCODE = "UTF-8";
	private String requestIp = "";
	public EsbRequest(Socket request) {
		this.socket = request;

		resourceService = (ResourceService)SpringContextUtil.getBean("resourceServiceImp");
	}
	
	public EsbRequest() {
	}
	
	@Override
	public void run() {
		
		InputStream in = null;
		OutputStream out = null;

		try {
			// 获取客户端上传的数据流对象
			in = socket.getInputStream();
			out = socket.getOutputStream();
			logger.error("【EsbRequest】-->-------------------------处理请求开始-----------------------。");
			
			SocketAddress clientAddress = socket.getRemoteSocketAddress();
			requestIp = clientAddress.toString();
			logger.error("【EsbRequest】客户端请求的ip地址： "+ requestIp);
			
			byte[] packLen = new byte[7];
			int len = in.read(packLen, 0, 7);
			if (len != 7) {
				logger.error("【EsbRequest fail】-->接收的数据长度有格式不对，请确定数据长度是7位。");
				out.write(packLen);

			}else
			{
				int reqLen = Integer.parseInt(new String(packLen, ENCODE));
				logger.error("【EsbRequest 】-->解析的到数据长度为：" + reqLen);
				
				// 将输入流中的数据读入到报文数组中
				//int exclen = in.read(datas, 0, reqLen);
				
				//分包读取数据   开始：
				long timeStart = System.currentTimeMillis();  //读取数据开始时间
				//创建数据存放区
				byte[] datas = new byte[reqLen];    //保存最终的数据
				byte[] bRecvBuf = new byte[reqLen]; //临时接受数据
				//定义一些常用变量
				int nTempLen = 0; //每次read到的字节数
				int totalRecvLen = 0; //总字节数长度
				int count = 0;  //循环次数
				boolean recvFlag = false; //接受请求数据是否成功
				//循环接受余下的字节数
				while ((nTempLen=in.read(bRecvBuf)) != -1){//服务端没有中断，就一直接收
					if (nTempLen == 0){ //没有接收到数据
						if (Math.abs(System.currentTimeMillis()-timeStart) > 2000){ //超时,停止读取数据
							logger.error("读取包体超时，数据获取失败，结束时间："+System.currentTimeMillis());
							break;
						}
						//没有超时，等待1毫秒时间，在去读数据
						Thread.sleep(1);
						continue;
					}
					
					//接收到数据的情况
					logger.error("循环读取数据第【"+(count++)+"】次，接收到数据的长度："+nTempLen);
					//将datas里面的数据拷贝到brecvBuf里面
					System.arraycopy(bRecvBuf, 0, datas, totalRecvLen, nTempLen);
					
					totalRecvLen += nTempLen;
					logger.error("收到数据-totalRecvLen："+totalRecvLen +" 总报文数据-dataLen:"+reqLen);
					
					if (totalRecvLen == reqLen){ //读取到指定长度字节数，就停止接收
						//接收到了指定长度读的响应数据，
						logger.error("接受数据成功：接受到完成数据");
						recvFlag = true;
						break;
					}
				}
				
				//分包读取数据结束
				
				if (!recvFlag) {
					logger.error("【EsbRequest fail】-->实际获取到的报文字节数和指定的字节数不相等，获取到的字节数："
							+ totalRecvLen + "  指定获取的字节数：" + reqLen);
					responseClient(out,"【EsbRequest】获取的数据长度与实际长度不一致。");
					return;
				}	
				String packageData = new String(datas, ENCODE);
				logger.error("【EsbRequest】-->请求的数据内容为：" + packageData);
					
				//转换成dom
				Document doc = parseXml(packageData);
				if (doc == null) {
					responseClient(out,"【EsbRequest】请求数据转换异常");
					return;
				} 
				
				//对数据进行处理
				String respXml = dealRequest(doc);
				
				//响应数据
				responseClient(out, respXml);	
			}
		} catch (Exception e) {
			logger.error("EsbRequest run error",e);
		} finally {

			
			if (in != null){ //关闭输入流
				try {
					in.close();
					in = null;
					logger.error("关闭输入流成功");
				} catch (Exception e2) {
					logger.error("关闭输入流失败");
				}
			}
			
			if (out != null) {
				try {
					out.close();
					out = null;
					logger.error("关闭输出流成功");
				} catch (Exception e2) {
					logger.error("关闭输出流害失败");
				}
			}
			
			if (socket != null) {
				try {
					socket.close();
					socket = null;
					logger.error("关闭输出流成功");
				} catch (Exception e2) {
					logger.error("关闭输出流害失败");
				}
			}

		}
	}
	
	
	/**
	 * 将xml字符串转换成Document
	 * @param respXml
	 * @return
	 */
	public  Document parseXml(String respXml){
		try{
			SAXReader reader = new SAXReader();
			ByteArrayInputStream bais = new ByteArrayInputStream(respXml.getBytes(ENCODE));
			Document document = reader.read(bais);
			return document;
		} catch(Exception e){
			logger.error("【EsbRequest】xml解析异常",e);
		}
		return null;
	}
	
	
	/**
	 * 响应客户端数据
	 * 
	 * @param out
	 * @param responseText
	 */
	private void responseClient(OutputStream out, String respXml) {
		try {
			
			//1.计算整个报文的长度
			byte[] datas = respXml.getBytes(ENCODE);
			int dataLen = datas.length;
			Formatter formatter = new Formatter();
			String respPackage = formatter.format("%07d%s", dataLen,respXml).toString();
			logger.error("【EsbRequest】返回客户端报文："+respPackage);
			
			//返回的字节数据：
			byte[] destMsg = respPackage.getBytes(ENCODE);
			out.write(destMsg);
		} catch (Exception e) {
			logger.error("【EsbRequest】数据发送到客户端异常：" + e);
		}
	}
	
	/**
	 * 将字符串前面加上n位的字节长度
	 * @param packageData  原始报文
	 * @param headlen      字节长度位数，不足前补0
	 * @param encode       字符编码
	 * @return   0000234******************
	 */
	public static String formatData(String packageData,int headlen,String encode){
		String formatData = "";
		try {
			//1.计算整个报文的长度
			byte[] datas = packageData.getBytes(encode);
			int dataLen = datas.length;
			Formatter formatter = new Formatter();
			formatData = formatter.format("%0"+headlen+"d%s", dataLen,packageData).toString();
		} catch (Exception e) {
			logger.error("【EsbRequest-formatData】格式化数据异常：",e);
		}
		return formatData;
	}
	
	
    /**
     * 处理esb的客户请求
     * @param doc 原始请求doc
     * @return
     */
	private String dealRequest(Document document) {
	    
		String respXml = "";
		
		//1.获取请求的交易码
		Node transIdNode = document.selectSingleNode("/Service/Service_Body/request/TRANS-ID");
		if (transIdNode == null){ //未能获取到交易码
			logger.error("【EsbRequest-dealRequest】未能获取到交易码");
			return fillResponse("FAIL", "2001", "未能获取到交易码", "", "", "", document);
		}
		
		//根据分类码进行分类处理
		String transId = transIdNode.getStringValue();
		if (transId.equals("R002")){  //远程取号
			logger.error("【EsbRequest-dealRequest:远程取号-》网点信息查询】开始");
			respXml = getDevInfo(document);
			logger.error("【EsbRequest-dealRequest:远程取号-》网点信息查询】结束");
		}
		
		if (transId.equals("100002")){
			logger.error("【EsbRequest-dealRequest:远程取号-》远程取号】开始");
			respXml = remoteFetchTicketNo(document);
			logger.error("【EsbRequest-dealRequest:远程取号-》远程取号】结束");
		}
		
		if (transId.equals("100003")){
			logger.error("【EsbRequest-dealRequest:远程取号-》远程取号】开始");
			respXml = queryTicketNoStatus(document);
			logger.error("【EsbRequest-dealRequest:远程取号-》远程取号】结束");
		}
		
		if (transId.equals("100004")){
			logger.error("【EsbRequest-dealRequest:Pad数据查询开始");
			respXml = flowData4Pad(document);
			logger.error("【EsbRequest-dealRequest:Pad数据查询】结束");
		}
		
		if (transId.equals("100005")){
			logger.error("【EsbRequest-dealRequest:Pad临近网点机构查询");
			respXml = nearOrg4Pad(document);
			logger.error("【EsbRequest-dealRequest:Pad临近网点机构查询】结束");
		}
	
		return respXml;
	}
	
	
	/**
	 * 远程取号-pad数据查询
	 * @param docment
	 * @return
	 */
	private String flowData4Pad(Document document){
		//获取机构编码
		//获取请求信息
		Node branchIdNode = document.selectSingleNode("/Service/Service_Body/request/BRANCH-ID");
		Node showCountNode = document.selectSingleNode("/Service/Service_Body/request/SHOW-COUNT");
		String branchId = branchIdNode.getStringValue();
		String showCount = showCountNode.getStringValue();
		
		//查询流水数据
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("orgCode", branchId);
		map.put("showCount", showCount);
		List<Map<String, Object>> flowDataList = resourceService.flowData4Pad(map);
		//封装查询的数据结果
		
		StringBuilder sb = new StringBuilder("<response>");
		sb.append("<list>");
		for (int i = 0; i < flowDataList.size(); i++) {
			sb.append("<map ID=\""+i+"\">");
			Map<String, Object> rowMap = flowDataList.get(i);
			String orgCode = rowMap.get("orgCode") == null ? "" : rowMap.get("orgCode").toString();
			String orgName = rowMap.get("orgName") == null ? "" : rowMap.get("orgName").toString();
			String trxDate = rowMap.get("trxDate") == null ? "" : rowMap.get("trxDate").toString();
			String businessName = rowMap.get("businessName") == null ? "" : rowMap.get("businessName").toString();
			String ticketNo = rowMap.get("ticketNo") == null ? "" : rowMap.get("ticketNo").toString();
			String custName = rowMap.get("custName") == null ? "" : rowMap.get("custName").toString();
			String trxStatus = rowMap.get("trxStatus") == null ? "" : rowMap.get("trxStatus").toString();
			String printTime = rowMap.get("printTime") == null ? "" : rowMap.get("printTime").toString();
			String callTime = rowMap.get("callTime") == null ? "" : rowMap.get("callTime").toString();
			String beginTime = rowMap.get("beginTime") == null ? "" : rowMap.get("beginTime").toString();
			String endTime = rowMap.get("endTime") == null ? "" : rowMap.get("endTime").toString();
			String appValue = rowMap.get("appValue") == null ? "" : rowMap.get("appValue").toString();
			String winNo = rowMap.get("winNo") == null ? "" : rowMap.get("winNo").toString();
			String tellerNo = rowMap.get("tellerNo") == null ? "" : rowMap.get("tellerNo").toString();
			String pdjLevel = rowMap.get("pdjLevel") == null ? "" : rowMap.get("pdjLevel").toString();
			String cardType = rowMap.get("cardType") == null ? "" : rowMap.get("cardType").toString();
			String cardNo = rowMap.get("cardNo") == null ? "" : rowMap.get("cardNo").toString();
			String waitNum = rowMap.get("waitNum") == null ? "" : rowMap.get("waitNum").toString();
			
			sb.append("<BRANCH-ID>"+orgCode+"</BRANCH-ID>");
			sb.append("<BANK-NAME>"+orgName+"</BANK-NAME>");
			sb.append("<TRX-DATE>"+trxDate+"</TRX-DATE>");
			sb.append("<BUSI-NAME>"+businessName+"</BUSI-NAME>");
			sb.append("<TICKET-NO>"+ticketNo+"</TICKET-NO>");
			sb.append("<CUST-TYPE>"+custName+"</CUST-TYPE>");
			sb.append("<PDJ-LEVEL>"+pdjLevel+"</PDJ-LEVEL>");
			sb.append("<CARD-TYPE>"+cardType+"</CARD-TYPE>");
			sb.append("<CARD-NO>"+cardNo+"</CARD-NO>");
			sb.append("<TRX-STATUS>"+trxStatus+"</TRX-STATUS>");
			sb.append("<PRINT-TIME>"+printTime+"</PRINT-TIME>");
			sb.append("<CALL-TIME>"+callTime+"</CALL-TIME>");
			sb.append("<BEGIN-TIME>"+beginTime+"</BEGIN-TIME>");
			sb.append("<END-TIME>"+endTime+"</END-TIME>");
			sb.append("<APP-VALUE>"+appValue+"</APP-VALUE>");
			sb.append("<WIN-NO>"+winNo+"</WIN-NO>");
			sb.append("<TELLER-NO>"+tellerNo+"</TELLER-NO>");
			sb.append("<QUE-NUM>"+waitNum+"</QUE-NUM>");
			sb.append("</map>");
		}
		sb.append("</list>");
		sb.append("</response>");
		
		
		//对排队机返回的数据进行处理，然后返回
		String respXml = sb.toString();
		return fillResponse("COMPLETE", "0000", "交易完成", "", "", respXml, document);
	}
	
	/**
	 * 远程取号-pad临近网点机构查询
	 * @param docment
	 * @return
	 */
	private String nearOrg4Pad(Document document){
		//获取机构编码
		//获取请求信息
		Node branchIdNode = document.selectSingleNode("/Service/Service_Body/request/BRANCH-ID");
		String branchId = branchIdNode.getStringValue();
		
		//查询流水数据
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("orgCode", branchId);
		List<Map<String, Object>> nearOrgList = resourceService.nearOrg4Pad(map);
		//封装查询的数据结果
		
		StringBuilder sb = new StringBuilder("<response>");
		sb.append("<list>");
		for (int i = 0; i < nearOrgList.size(); i++) {
			sb.append("<map ID=\""+i+"\">");
			Map<String, Object> rowMap = nearOrgList.get(i);
			String orgCode = rowMap.get("orgCode") == null ? "" : rowMap.get("orgCode").toString();
			String orgName = rowMap.get("orgName") == null ? "" : rowMap.get("orgName").toString();
			sb.append("<BRANCH-ID>"+orgCode+"</BRANCH-ID>");
			sb.append("<BANK-NAME>"+orgName+"</BANK-NAME>");
			sb.append("</map>");
		}
		sb.append("</list>");
		sb.append("</response>");
		
		
		//对排队机返回的数据进行处理，然后返回
		String respXml = sb.toString();
		return fillResponse("COMPLETE", "0000", "交易完成", "", "", respXml, document);
	}
	
	
	
	/**
	 * 远程取号-状态查询
	 * @param docment
	 * @return
	 */
	private String queryTicketNoStatus(Document document){
		//获取机构编码
		//获取请求信息
		Node branchIdNode = document.selectSingleNode("/Service/Service_Body/request/BRANCH-ID");
		Node idNoNode = document.selectSingleNode("/Service/Service_Body/request/ID-NO");
		Node ticketNoNode = document.selectSingleNode("/Service/Service_Body/request/TICKET-NO");
		String branchId = branchIdNode.getStringValue();
		String ticketNo = ticketNoNode.getStringValue();
		String idNo = idNoNode.getStringValue();
		Map<String, String> map = new HashMap<String, String>();
		map.put("orgCode", branchId);
		
		//查询网点的设备信息
		List<Map<String, Object>> devListMap = resourceService.findDeviceByConditon(map);
		//获取设备IP
		if (devListMap == null || devListMap.size() == 0){
			logger.error("【EsbRequest-remoteFetchTicketNo:远程取号-远程取号】：根据机构号未能查询到后台注册的设备信息，机构编码："+branchId);
			return fillResponse("FAIL", "2002", "根据机构编码未能查询到设备信息", "", "", "", document);
		}
		
		String devIp = devListMap.get(0).get("ipAddr").toString();
		String orgId = devListMap.get(0).get("orgId").toString();
		String orgName = devListMap.get(0).get("orgName").toString();
		EsbServiceResp esbServiceResp = new EsbServiceResp();
		
		//封装要发送的报文
		String pdjReq = "{"+
							    "\"head\":{"+
							        "\"transCode\":\"F003\","+
							        "\"transDateTime\":\""+DateFormatUtils.format(new Date(), "yyyy-MM-dd HH:mm:ss")+"\","+
							        "\"transStatus\":\"\","+
							        "\"transDescription\":\"\""+
							    "},"+
							    "\"data\":{"+
							        "transNet:\""+orgId+"\","+
							        "ticketNo:\""+ticketNo+"\""+
							    "}"+
							"}";
		
		
		//开始给客户端发送请求消息
		String pdjResp = socketSendData(pdjReq,devIp,remotePort,esbServiceResp);
		
		//String pdjResp = SendUtil.socketSendData(pdjReq, devIp, remotePort, esbServiceResp, "GBK", 6);
		
		
		logger.error("【EsbRequest-remoteFetchTicketNo:远程取号-远程取号】：远程取号信息："+pdjResp);
		
		//对排队机返回的数据进行处理，然后返回
		String respXml = "";
		//解析json
		if (pdjResp != null && !pdjResp.equals("") ){  //封装返回的新
			pdjResp = pdjResp.substring(6);
			JsonNode rootNode = JsonUtils.getRoot(pdjResp);
			JsonNode transStatusNode = rootNode.findValue("transStatus");
			JsonNode transDescriptionNode = rootNode.findValue("transDescription");
			if (!transStatusNode.asText().equals("0000")){ //异常
				return fillResponse("FAIL", "2003",transDescriptionNode.asText() , "", "", "", document);
			}
			JsonNode ticketNode = rootNode.findValue("ticketNo"); //
			JsonNode ticketStatusNode = rootNode.findValue("ticketStatus"); //
			JsonNode busNameNode = rootNode.findValue("busName"); //
			JsonNode buswaitNode = rootNode.findValue("buswait"); //
//			JsonNode orgIdNode = rootNode.findValue("orgId"); //
//			JsonNode orgNameNode = rootNode.findValue("orgName"); //
			StringBuilder sb = new StringBuilder("<response>");
			sb.append("<BRANCH-ID>"+branchId+"</BRANCH-ID>");
			sb.append("<BANK-NAME>"+orgName+"</BANK-NAME>");
			sb.append("<QUE-STAT>"+ticketStatusNode.asText()+"</QUE-STAT>");
			sb.append("<BUSI-NAME>"+busNameNode.asText()+"</BUSI-NAME>");
			sb.append("<TICKET-NO>"+ticketNode.asText()+"</TICKET-NO>");
			sb.append("<QUE-NUM>"+buswaitNode.asText()+"</QUE-NUM>");
			sb.append("</response>");
			respXml = sb.toString();
		}
		return fillResponse(esbServiceResp.getStatus(), esbServiceResp.getCode(), esbServiceResp.getDesc(), "", "", respXml, document);
	}
	
	/**
	 * 远程取号-远程取号
	 * @param docment
	 * @return
	 */
	private String remoteFetchTicketNo(Document document){
		//获取请求信息
		Node branchIdNode = document.selectSingleNode("/Service/Service_Body/request/BRANCH-ID");
		Node ticketLevelNode = document.selectSingleNode("/Service/Service_Body/request/TICKET-LEVEL");
		Node busiTypeNode = document.selectSingleNode("/Service/Service_Body/request/BUSI-TYPE");
		Node idNoNode = document.selectSingleNode("/Service/Service_Body/request/ID-NO");
		Node queLimitNode = document.selectSingleNode("/Service/Service_Body/request/QUE-LIMIT");
		String branchId = branchIdNode.getStringValue();
		String ticketLevel = ticketLevelNode.getStringValue();
		String busiType = busiTypeNode.getStringValue();
		String idNo = idNoNode.getStringValue();
		String queLimit = queLimitNode.getStringValue();
		Map<String, String> map = new HashMap<String, String>();
		map.put("orgCode", branchId);
		
		//查询网点的设备信息
		List<Map<String, Object>> devListMap = resourceService.findDeviceByConditon(map);
		//获取设备IP
		if (devListMap == null || devListMap.size() == 0){
			logger.error("【EsbRequest-remoteFetchTicketNo:远程取号-远程取号】：根据机构号未能查询到后台注册的设备信息，机构编码："+branchId);
			return fillResponse("FAIL", "2002", "根据机构编码未能查询到设备信息", "", "", "", document);
		}
		
		String devIp = devListMap.get(0).get("ipAddr").toString();
		String orgId = devListMap.get(0).get("orgId").toString();
		EsbServiceResp esbServiceResp = new EsbServiceResp();
		//封装要发送的报文
		String pdjReq = "{"+
							    "\"head\":{"+
							        "\"transCode\":\"F002\","+
							        "\"transDateTime\":\""+DateFormatUtils.format(new Date(), "yyyy-MM-dd HH:mm:ss")+"\","+
							        "\"transStatus\":\"\","+
							        "\"transDescription\":\"\""+
							    "},"+
							    "\"data\":{"+
							        "transNet:\""+orgId+"\","+
							        "busType:\""+busiType+"\","+
							        "ticketLevel:\""+ticketLevel+"\","+
							        "custId:\""+idNo+"\","+
							        "mediaType:\"\","+// 卡类型01：01 卡；02 身份证；03存折
							        "mediaId:\"\","+//
							        "isPrint:\""+1+"\""+
							    "}"+
							"}";
		
		//开始给客户端发送请求消息
		String pdjResp = socketSendData(pdjReq,devIp,remotePort,esbServiceResp);
		logger.error("【EsbRequest-remoteFetchTicketNo:远程取号-远程取号】：远程取号信息："+pdjResp);
		
		//对排队机返回的数据进行处理，然后返回
		String respXml = "";
		//解析json
		if (pdjResp != null && !pdjResp.equals("")){  //封装返回的新
			pdjResp = pdjResp.substring(6);
			JsonNode rootNode = JsonUtils.getRoot(pdjResp);
			JsonNode transStatusNode = rootNode.findValue("transStatus");
			JsonNode transDescriptionNode = rootNode.findValue("transDescription");
			if (!transStatusNode.asText().equals("0000")){ //异常
				return fillResponse("FAIL", "2003",transDescriptionNode.asText() , "", "", "", document);
			}
			JsonNode ticketNode = rootNode.findValue("ticketNo"); //
			StringBuilder sb = new StringBuilder("<response>");
			sb.append("<QUE-NO>"+ticketNode.asText()+"</QUE-NO>");
			sb.append("</response>");
			respXml = sb.toString();
		}

		return fillResponse(esbServiceResp.getStatus(), esbServiceResp.getCode(), esbServiceResp.getDesc(), "", "", respXml, document);
	}
	
	
	/**
	 * 远程取号-查询网点信息
	 * @param docment
	 * @return
	 */
	private String getDevInfo(Document document){
		//获取机构编码
		Node branchIdNode = document.selectSingleNode("/Service/Service_Body/request/BRANCH-ID");
		String branchId = branchIdNode.getStringValue();
		Map<String, String> map = new HashMap<String, String>();
		map.put("orgCode", branchId);
		
		//查询网点的设备信息
		List<Map<String, Object>> devListMap = resourceService.findDeviceByConditon(map);
		//获取设备IP
		if (devListMap == null || devListMap.size() == 0){
			logger.error("【EsbRequest-getDevInfo:远程取号-网点信息查询】：根据机构号未能查询到后台注册的设备信息，机构编码："+branchId);
			return fillResponse("FAIL", "2002", "根据机构编码未能查询到设备信息", "", "", "", document);
		}
		
		String devIp = devListMap.get(0).get("ipAddr").toString();
		String orgId = devListMap.get(0).get("orgId").toString();
		EsbServiceResp esbServiceResp = new EsbServiceResp();
		//封装要发送的报文
		String clientPack = "{"+
							    "\"head\":{"+
							        "\"transCode\":\"F001\","+
							        "\"transDateTime\":\""+DateFormatUtils.format(new Date(), "yyyy-MM-dd HH:mm:ss")+"\","+
							        "\"transStatus\":\"\","+
							        "\"transDescription\":\"\""+
							    "},"+
							    "\"data\":{"+
							        "transNet:\""+orgId+"\""+
							    "}"+
							"}";
		//开始给客户端发送请求消息
		String pdjResp = socketSendData(clientPack,devIp,remotePort,esbServiceResp);
		logger.error("【EsbRequest-getDevInfo:远程取号-网点信息查询】：排队机返回的网点信息："+pdjResp);
		//对排队机返回的数据进行处理，然后返回
		String respXml = "";
		//解析json
		if (pdjResp != null && !pdjResp.equals("")){  //封装返回的新
			pdjResp = pdjResp.substring(6);
			JsonNode rootNode = JsonUtils.getRoot(pdjResp);
			JsonNode transStatusNode = rootNode.findValue("transStatus");
			JsonNode transDescriptionNode = rootNode.findValue("transDescription");
			if (!transStatusNode.asText().equals("0000")){ //异常
				return fillResponse("FAIL", "2003",transDescriptionNode.asText() , "", "", "", document);
			}
			
			JsonNode buzlistNode = rootNode.findValue("buzlist"); //
			Iterator<JsonNode> jsonNodes = buzlistNode.elements();
			StringBuilder sb = new StringBuilder("<response>");
			sb.append("<list>");
			int i = 1;
			while (jsonNodes.hasNext()){
				JsonNode jn = jsonNodes.next();
				sb.append("<map ID=\""+i+"\">");
				sb.append("<BUSI-TYPE>"+jn.get("buztype").asText()+"</BUSI-TYPE>");
				sb.append("<BUSI-NAME>"+jn.get("cnname").asText()+"</BUSI-NAME>");
				sb.append("<QUE-NUM>"+jn.get("waitno").asText()+"</QUE-NUM>");
				sb.append("</map>");
				i++;
			}
			sb.append("</list>");
			sb.append("</response>");
			respXml = sb.toString();
		} 
		
		return fillResponse(esbServiceResp.getStatus(), esbServiceResp.getCode(), esbServiceResp.getDesc(), "", "", respXml, document);
	}
	
	
	
	
	
	
	/**
	 * 获取返回的报文
	 * @param status  COMPLETE-表明交易成功    FAIL-表明交易处理失败
	 * @param code  提供方响应码
	 * @param desc  提供方响应描述
	 * @param requester_code 请求方响应码
	 * @param requester_desc  请求方响应描述
	 * @param respContent   响应的数据内容
	 * @param doc      整体doc文件（请求的doc中加入service_response和response节点）
	 * @return
	 */
	private String fillResponse(String status,String code,String desc,
			String requester_code,String requester_desc,String respContent,Document doc){
		
		
		
		//获取更节点
		Element root = doc.getRootElement();
		System.out.println(root.asXML());
		Element headerEle = root.element("Service_Header");
		
		
		//干掉response节点
		Element serviceRespEle =  headerEle.element("service_response");
		if (serviceRespEle == null) { //节点不存在就创建
			serviceRespEle = headerEle.addElement("service_response");
		}
		
		//service_response
		Element statusElement = serviceRespEle.addElement("status");
		Element codeElement = serviceRespEle.addElement("code");
		Element descElement = serviceRespEle.addElement("desc");
		Element requesterCodeElement = serviceRespEle.addElement("requester_code");
		Element requester_descElement = serviceRespEle.addElement("requester_desc");
		
		statusElement.setText(status);
		codeElement.setText(code);		
		descElement.setText(desc);
		requesterCodeElement.setText(requester_code);
		requester_descElement.setText(requester_desc);
		
		Element bodyElement = root.element("Service_Body");
		//干掉response节点
		Element responseNode =  bodyElement.element("response");
		if (responseNode != null) { //如果响应节点存在，就删除
			bodyElement.remove(responseNode);
		}
		Document respDoc = null;
		if (!StringUtils4Aoto.isBlank(respContent)){ //响应内容不为空，进行转换
			respDoc = parseXml(respContent);
			if (respDoc == null){  //响应内容转换成成responsedoc出现错误
				statusElement.setText("FAIL");
				codeElement.setText("1001");		
				descElement.setText("响应报文转换成xml格式doc出现异常");
				bodyElement.addElement("response");
				logger.error("EsbRequest's fillResponse响应报文转换成xml格式doc出现异常");
				return root.asXML();
			}
			//将respDoc添加到原doc中
			bodyElement.add(respDoc.getRootElement());
		} else { //为空就手工添加一个response节点
			bodyElement.addElement("response");
		}
		
		String respXml = root.asXML();
		logger.error("EsbRequest's fillResponse返回的响应xml："+respXml);
		return respXml;
	}
	
	/**
     * 向排队机发送请求报文（预约）
     * @param msg
     * @param ipAddr
     * @return
     */
    private String socketSendData(String msg,String ipAddr, int port,EsbServiceResp esbServiceResp){
		try {
			String fmtMsg = formatData(msg,6,"GBK");
			byte[] destMsg = fmtMsg.getBytes("GBK");
			//定义个一个用于接收返回数据的报文数组
			byte[] bRecvBuf = new byte[8192];
			//获取远程取号的等级
			int socketConnTimes = PropetiesLoader.getSystemConfig().getInt("socketConnTimes", 2);
			//int socketConnTimes = 2;
			logger.info("【socketSendData】socket连接失败重连次数配置："+socketConnTimes);
			int nErr = sendMsg(ipAddr,port,destMsg,destMsg.length,bRecvBuf,socketConnTimes, esbServiceResp);
			if (nErr > 0){
				String pdjResp = new String(bRecvBuf,0,nErr,"GBK");
				logger.info("排队机返回的报文："+pdjResp);
				return pdjResp;
			}
		}catch(Exception e){
			logger.error("和排队机通讯异常：",e);
			esbServiceResp.setStatus("FAIL");
			esbServiceResp.setCode("3001");
			esbServiceResp.setDesc("连接远程排队机异常");
		}
    	return null;
    }
    
    
    
    
    
    /**
	 * 发送数据方法，重发n次（存在丢包问题）
	 * @param ip 服务端ip地址
	 * @param port 服务端端口号
	 * @param content 发送的数据内容
	 * @param len  发送数据包长度
	 * @param bRecvBuf 接收到的包
	 * @param nTimeOut 最大重发次数
	 * @return -1失败， >0成功
	 */
	private int sendMsg(String ip,int port,byte[] content, int len, byte[] bRecvBuf, int nTimeOut,EsbServiceResp esbServiceResp){
		logger.error("[发送消息至排队机]发送的目标主机："+ip+"  端口："+port+" 数据长度："+len);
		int nErr = 0;
		Socket clientSocket = null;
		OutputStream os = null;
		InputStream is = null;
		long timeStart = 0; 
		long timeEnd = 0;
		
		try {
			int nSendTimes = 1; //初始发送次数
			while (true){
				if (nSendTimes++ > nTimeOut){ //数据发送nTimeOut次都没有成功，直接返回失败
					logger.error("[sendMsg]数据重发了"+nTimeOut+"次仍然失败，发送数据失败。");
					esbServiceResp.setStatus("FAIL");
					esbServiceResp.setCode("3002");
					esbServiceResp.setDesc("远程排队机网络不通。");
					nErr = -1;
					break;
				} else {
					if (clientSocket != null){ //如果客户端socket存在，就关闭重新创建socket去连接服务器
						try {
							clientSocket.close();
							clientSocket = null;
						} catch (Exception e) {
							logger.error("[sendMsg]关闭客户端失败，");
						}
					}
				}
				
				//开始记录发送请求的开始时间
				timeStart = System.currentTimeMillis();
				clientSocket = new Socket();
				clientSocket.setReuseAddress(true); //允许在一个超时状态的套接字上绑定地址，在调用socket的绑定方法之前启用才有效果
				InetSocketAddress address = new InetSocketAddress(ip, port);
				try {
					logger.error("开始连接服务端");
					int socketTimeout = PropetiesLoader.getSystemConfig().getInt("socketConnTimeout", 5);
					logger.info("配置的socket连接超时时间为："+socketTimeout+"秒");
					
					clientSocket.connect(address, socketTimeout*1000);//设置连接超时
					
				} catch (ConnectException e) {
					nErr = -1;
					logger.error("this ip is :"+ip+" ; port is :"+port+"",e);
					timeEnd = System.currentTimeMillis();
					logger.error("连接超时异常1耗时："+(timeEnd-timeStart));
					continue;
				} catch (SocketTimeoutException e) {
					nErr = -1;
					logger.error("this ip is timeout2 :"+ip+" ; port is :"+port+"",e);
					timeEnd = System.currentTimeMillis();
					logger.error("连接超时异常2耗时："+(timeEnd-timeStart));
					continue;
				}
				
				clientSocket.setSoTimeout(1000*30); //设置读写数据超时  30秒
				try {
					
					//发送数据
					os = clientSocket.getOutputStream();
					os.write(content, 0, len);
					
					logger.error("预约-写入数据时间差："+(System.currentTimeMillis()-timeStart));
				} catch (InterruptedIOException e) {
					logger.error("发送数据异常：",e);
					clientSocket.close();
					clientSocket = null;
					timeEnd = System.currentTimeMillis();
					logger.error("发送数据异常耗时："+(timeEnd-timeStart));
					continue;
				}
				
				//等待数据接收
				try {
					is = clientSocket.getInputStream();
					timeStart = System.currentTimeMillis();
					//先接收6个字节的数据
					int nPacketLen = is.read(bRecvBuf, 0, 6);
					if (nPacketLen != 6){
						logger.error("接收数据异常：耗时："+(System.currentTimeMillis()-timeStart)+"nPacketLen===="+nPacketLen);
						esbServiceResp.setStatus("FAIL");
						esbServiceResp.setCode("3003");
						esbServiceResp.setDesc("读取排队机返回报文的长度异常。");
						break;
					}
					
					//获取返回报文的长度
					String dataLenStr = new String(bRecvBuf, 0, 6, ENCODE);
					int dataLen = Integer.parseInt(dataLenStr);
					//判断服务端返回的数据是否超过了接收数据的数组长度
					if ((dataLen+6) > (bRecvBuf.length)){
						logger.error("服务端返回数据的长度，超过了接收缓冲区的长度，");
						logger.error("服务端返回数据的长度是："+dataLen+6+" 客户端定义的接收缓冲区长度为："+bRecvBuf.length);
						logger.error("停止接收数据，退出");
						esbServiceResp.setStatus("FAIL");
						esbServiceResp.setCode("3004");
						esbServiceResp.setDesc("排队机端返回数据的长度，超过了接收缓冲区的长度。");
						nErr = -1;
						break;
					}
					
					//创建数据存放区
					byte[] datas = new byte[dataLen];
					//定义一些常用变量
					int nTempLen = 0; //每次read到的字节数
					int totalRecvLen = 0; //总字节数长度
					int count = 0;
					//循环接受余下的字节数
					while ((nTempLen=is.read(datas)) != -1){//服务端没有中断，就一直接收
						if (nTempLen == 0){ //没有接收到数据
							if (Math.abs(System.currentTimeMillis()-timeStart) > 2000){ //超时,停止读取数据
								logger.error("读取包体超时，数据获取失败，结束时间："+System.currentTimeMillis());
								esbServiceResp.setStatus("FAIL");
								esbServiceResp.setCode("3005");
								esbServiceResp.setDesc("读取包体超时，数据获取失败。");
								break;
							}
							//没有超时，等待1毫秒时间，在去读数据
							Thread.sleep(1);
							continue;
						}
						
						//接收到数据的情况
						logger.error("循环读取数据第【"+(count++)+"】次，接收到数据的长度："+nTempLen);
						//将datas里面的数据拷贝到brecvBuf里面
						System.arraycopy(datas, 0, bRecvBuf, 6+totalRecvLen, nTempLen);
						
						totalRecvLen += nTempLen;
						logger.error("totalRecvLen："+totalRecvLen +" dataLen:"+dataLen);
						
						if (totalRecvLen == dataLen){ //读取到指定长度字节数，就停止接收
							//接收到了指定长度读的响应数据，
							logger.error("将数据存放到缓冲区中");
							//System.out.println("响应报文："+new String(datas,"UTF-8"));
							//System.arraycopy(datas, 0, bRecvBuf, headerLen, datas.length);
							nErr = totalRecvLen+6;//读取到的数据长度
							break;
						}
					}
					
					//接收到正确的数据，退出外层循环
					if (nErr > 0){
						esbServiceResp.setStatus("COMPLETE");
						esbServiceResp.setCode("0000");
						esbServiceResp.setDesc("交易成功。");
						return nErr;
					}
				} catch (Exception e) { //接收超时
					nErr = -1;
					logger.error("接收异常：",e);
					clientSocket.close();
					clientSocket = null;
					timeEnd = System.currentTimeMillis();
					logger.error("接收异常，耗时："+(timeEnd-timeStart));
					continue;
				}
			}
		} catch (IOException e) {
			logger.error("未知的异常1",e);
			timeEnd = System.currentTimeMillis();
			logger.error("耗时："+(timeEnd-timeStart));
			esbServiceResp.setStatus("FAIL");
			esbServiceResp.setCode("3006");
			esbServiceResp.setDesc("排队机端处理请求异常1："+e);
		} catch (Exception e) {
			logger.error("未知的异常2",e);
			timeEnd = System.currentTimeMillis();
			logger.error("耗时："+(timeEnd-timeStart));
			esbServiceResp.setStatus("FAIL");
			esbServiceResp.setCode("3007");
			esbServiceResp.setDesc("排队机端处理请求异常2："+e);
		} finally{
			if (clientSocket != null) { //关闭客户单连接
				try {
					clientSocket.close();
					clientSocket = null;
					logger.error("关闭客户端连接成功");
				} catch (Exception e2) {
					logger.error("关闭客户端连接失败",e2);
				}
			}
			
			if (is != null){ //关闭输入流
				try {
					is.close();
					is = null;
					logger.error("关闭输入流成功");
				} catch (Exception e2) {
					logger.error("关闭输入流失败",e2);
				}
			}
			
			if (os != null) {
				try {
					os.close();
					os = null;
					logger.error("关闭输出流成功");
				} catch (Exception e2) {
					logger.error("关闭输出流害失败");
				}
			}
		}
		return -1;
	}
	
	
	/**
	 * dom4j测试代码
	 * @param args
	 */
	public static void main(String[] args) {
		
//		String reqXml = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"+
//			"<Service>"+
//			 "<Service_Header>"+
//				"<service_id>00260001004006</service_id>"+
//			        "<requester_id>0018</requester_id>"+
//			        "<branch_id>802777777</branch_id>"+
//			        "<channel_id>01</channel_id>"+
//			        "<version_id>01</version_id>"+
//			        "<service_time>20090715192647</service_time>"+
//			        "<service_sn>8027777770439019264</service_sn>"+
//			 "</Service_Header>"+
//			    "<Service_Body>"+
//			        "<ext_attributes>"+
//			            "<T_KEY_LABEL>X802PS05</T_KEY_LABEL>"+
//			        "</ext_attributes>"+
//			        "<request>"+
//			            "<TRANS-ID>4006</TRANS-ID>"+
//			            "<BRANCH-ID>6462</BRANCH-ID>"+
//			            "<ID-NO>CT</ID-NO>"+
//			            "<TICKET_NO>011235</TICKET_NO>"+
//			        "</request>"+
//			    "</Service_Body>"+
//			"</Service>";
//		
//		EsbRequest esbRequest = new EsbRequest();
//		
//		Document document = esbRequest.parseXml(reqXml);
//		
//		System.out.println(document.asXML());
//		
//		
//		Node branchIdNode = document.selectSingleNode("/Service/Service_Body/request/BRANCH-ID");
//		Node ticketLevelNode = document.selectSingleNode("/Service/Service_Body/request/TICKET_LEVEL");
//		Node busiTypeNode = document.selectSingleNode("/Service/Service_Body/request/BUSI-TYPE");
//		Node idNoNode = document.selectSingleNode("/Service/Service_Body/request/ID-NO");
//		Node queLimitNode = document.selectSingleNode("/Service/Service_Body/request/QUE-LIMIT");
//		
//		
//		String respXml = "<service_response><status>COMPLETE</status><code>S000A000</code><desc>交易成功</desc></service_response>";
//		Element root = document.getRootElement();
//		Element headerEle = root.element("Service_Header");
//		
//		Document documentResp = esbRequest.parseXml(respXml);
//		System.out.println(documentResp.asXML());
//		headerEle.add(documentResp.getRootElement());
//		
//		
//		System.out.println(document.asXML());
		
//		网点业务查询
		String clientPack = "{"+
			    "\"head\":{"+
			        "\"transCode\":\"F001\","+
			        "\"transDateTime\":\""+DateFormatUtils.format(new Date(), "yyyy-MM-dd HH:mm:ss")+"\","+
			        "\"transStatus\":\"\","+
			        "\"transDescription\":\"\""+
			    "},"+
			    "\"data\":{"+
			        "transNet:\"33\""+
			    "}"+
			"}";
		
		
		//封装要发送的报文 （查询号票状态）
		String pdjReq = "{"+
							    "\"head\":{"+
							        "\"transCode\":\"F003\","+
							        "\"transDateTime\":\""+DateFormatUtils.format(new Date(), "yyyy-MM-dd HH:mm:ss")+"\","+
							        "\"transStatus\":\"\","+
							        "\"transDescription\":\"\""+
							    "},"+
							    "\"data\":{"+
							        "transNet:\"33\","+
							        "ticketNo:\"A1054\""+
							    "}"+
							"}";
		//远程取号
		String pdjRemoeReq = "{"+
			    "\"head\":{"+
			        "\"transCode\":\"F002\","+
			        "\"transDateTime\":\""+DateFormatUtils.format(new Date(), "yyyy-MM-dd HH:mm:ss")+"\","+
			        "\"transStatus\":\"\","+
			        "\"transDescription\":\"\""+
			    "},"+
			    "\"data\":{"+
			        "transNet:\"312\","+
			        "busType:\"A\","+
			        "ticketLevel:\"4\","+
			        "custId:\"WE1231232\","+
			        "mediaType:\"\","+// 卡类型01：01 卡；02 身份证；03存折
			        "mediaId:\"\","+//
			        "isPrint:\""+1+"\""+
			    "}"+
			"}";
		EsbServiceResp esbServiceResp = new EsbServiceResp();
		EsbRequest esbRequest = new EsbRequest();
		//开始给客户端发送请求消息
		String pdjResp = esbRequest.socketSendData(pdjRemoeReq,"172.100.14.127",remotePort,esbServiceResp);
		
//		System.out.println("网点信息查询："+pdjResp);
		System.out.println("号票状态信息："+pdjResp);
		
		
	}
}
