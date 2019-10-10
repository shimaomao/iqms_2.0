package com.aoto.iqms.externals.dealprocess;

import java.io.ByteArrayInputStream;
import java.util.Date;
import java.util.HashMap;
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
import com.aoto.iqms.externals.models.HallMarket.CustInfoReq;
import com.aoto.iqms.externals.models.bookvalidate.BookActiveResp;
import com.aoto.iqms.externals.models.custident.CustIdentityDataResp;
import com.aoto.iqms.externals.models.custident.CustIdentityReq;
import com.aoto.iqms.externals.models.custident.CustIdentityResp;
import com.aoto.iqms.externals.models.deviceheartbeat.DevHeartbeatDataReq;
import com.aoto.iqms.externals.models.deviceheartbeat.DevHeartbeatDataResp;
import com.aoto.iqms.externals.models.deviceheartbeat.DevHeartbeatResp;
import com.aoto.iqms.externals.service.inf.ResourceService;
import com.aoto.iqms.util.HttpPostUtil;
import com.aoto.iqms.util.JsonUtils;
import com.aoto.iqms.util.PropetiesLoader;
import com.aoto.iqms.util.SendUtil;
import com.fasterxml.jackson.databind.JsonNode;

/**
 * 客户识别处理过程
 * @author hongxz
 *
 */
public class CustIdentityProcess {
	private static final Logger logger = LoggerFactory
			.getLogger(CustIdentityProcess.class);

	public CustIdentityProcess() {
		super();
	}
	
	
	/**
	 * 客户识别操作（需要查询出客户的三要素，然后调用客户识别接口）
	 * @param resourceService
	 * @param transCode
	 * @param json
	 * @return
	 */
	public String identityCust(ResourceService resourceService,
			String transCode,JsonNode root){
		//创建响应对象
		CustIdentityResp custIdentityResp  = new CustIdentityResp();
		
		custIdentityResp.getHead().setTransCode(transCode);
		custIdentityResp.getHead().setTransDateTime(DateFormatUtils.format(new Date(), "yyyy-MM-dd HH:mm:ss"));
		if(!PropetiesLoader.getAuthTestConfig().getBoolean("custFlag")){
			try {
				//将json的请求数据封装成对象
				//1.获取数据部分的报文
				JsonNode dataNode = root.findValue("data");
				if (dataNode == null) {
					custIdentityResp.getHead().setTransStatus("9999");
					custIdentityResp.getHead().setTransDescription("客户识别 ：没有发现data节点数据");
				} else {
					String dataJson = dataNode.toString();
					CustIdentityReq custIdentityReq = JsonUtils.json2pojo(dataJson, CustIdentityReq.class);
					
					//方式2：调用核心接口进行客户识别
					String mediaType = custIdentityReq.getMediaType(); // 1-二代证  2-刷卡    3-存在
					String mediaId = custIdentityReq.getMediaId(); //客户内容
					logger.info("客户识别介质类型："+mediaType+"  客户识别介质内容："+mediaId);
					String certType = ""; //证件类型
					String certConetent = "";  //证件内容
					String custName = "";  //客户姓名
					String funcCode = "";   //功能id
					
					//二代证（需要调用核心接口获取客户全称）
					if (mediaType.equals("03")) { 
						logger.info("客户识别方式：刷身份证，直接使用客户端送过来的客户姓名");
						certType = "A"; //身份证
						certConetent = mediaId; //证件内容
						funcCode = "2";
						custName = custIdentityReq.getCertName();
					} 
					
					//刷卡（需要调用核心卡号查询接口，获取客户信息）
					if (mediaType.equals("01")){ 
						funcCode = "2";
						logger.info("客户识别方式：刷卡激活，开始调用esb接口查询客户信息");
						//通过卡号查询客户身份信息
						String reqXml = findCustInfoByAcctXml(custIdentityReq.getOrgCode(),mediaId,mediaType);
						logger.info("客户识别 【调用esb卡号查询客户信息接口】请求报文："+reqXml);
						String ip = PropetiesLoader.getSystemConfig().getString("esb.core.ip", "");
						int port = PropetiesLoader.getSystemConfig().getInt("esb.core.port", 10086);
						logger.info("客户识别方式：esb核心地址：ip："+ip+" port:"+port);
						EsbServiceResp esbServiceResp = new EsbServiceResp();
						String respXml = SendUtil.socketSendData(reqXml, ip, port, esbServiceResp, "UTF-8", 7);
						logger.info("客户识别 【调用esb卡号查询客户信息接口】返回报文："+respXml);
						if (esbServiceResp.getStatus().equals("FAIL")){  //
							custIdentityResp.getHead().setTransStatus("9999");
							custIdentityResp.getHead().setTransDescription("客户识别 失败【调用esb卡号查询客户信息接口】："+esbServiceResp.getDesc());
							logger.info("客户识别 失败【调用esb卡号查询客户信息接口】："+esbServiceResp.getDesc());
							custIdentityResp.getData().setCustLevel("-2"); //设置客户等级
							return responseJson(transCode, custIdentityResp);
						} 
						//解析报文返回的信息
						try{
							respXml = respXml.substring(7);
							SAXReader reader = new SAXReader();
							ByteArrayInputStream bais = new ByteArrayInputStream(respXml.getBytes("UTF-8"));
							Document document = reader.read(bais);
							Node statusNode = document.selectSingleNode("/Service/Service_Header/service_response/status");
							Node descNode = document.selectSingleNode("/Service/Service_Header/service_response/desc");
							logger.info("客户识别：调用esb卡号查询客户信息接口状态："+statusNode.getStringValue()+" 交易描述:"+descNode.getStringValue());
							String transStatus = statusNode.getStringValue();
							if (transStatus.equals("FAIL")){  //处理请求失败
								custIdentityResp.getHead().setTransStatus("9999");
								custIdentityResp.getHead().setTransDescription("客户识别：调用esb卡号查询客户信息接口状态，异常："+descNode.getStringValue());
								custIdentityResp.getData().setCustLevel("-2"); //设置客户等级
								return  responseJson(transCode, custIdentityResp);
							}
							//获取客户信息
							Node cerTypeNode = document.selectSingleNode("/Service/Service_Body/response/CER-TYP");
							Node cerNoNode = document.selectSingleNode("/Service/Service_Body/response/CER-NO");
							Node fullNameNode = document.selectSingleNode("/Service/Service_Body/response/FULL-NAM");
							if (cerTypeNode == null) {
								logger.info("客户识别：调用esb卡号查询客户信息异常：未能查询到客户信息。");
								custIdentityResp.getHead().setTransStatus("9999");
								custIdentityResp.getHead().setTransDescription("客户识别：调用esb卡号查询客户信息异常：未能查询到客户信息");
								custIdentityResp.getData().setCustLevel("-2"); //设置客户等级
								return  responseJson(transCode, custIdentityResp);
							}
							
							custName =  fullNameNode.getStringValue();
							certConetent = cerNoNode.getStringValue();
							certType =  cerTypeNode.getStringValue();
							
							logger.info("客户识别：调用esb卡号查询客户信息：姓名："+custName+" 证件类型："+certType+" 证件内容："+certConetent);
							
						} catch(Exception e){
							custIdentityResp.getHead().setTransStatus("9999");
							custIdentityResp.getHead().setTransDescription("客户识别：调用esb卡号查询客户信息异常,xml解析异常");
							logger.info("【客户识别：调用esb卡号查询客户信息】xml解析异常",e);
							custIdentityResp.getData().setCustLevel("-2"); //设置客户等级
							return responseJson(transCode, custIdentityResp);
						}
						
						//20170719测试 上面注释掉
//						System.out.println("卡号激活");
//						certType = "B"; //身份证
//						certConetent = "1031"; //证件内容
//						funcCode = "2";
//						custName = "1031";
					}
					
					
					logger.info("客户识别 三要素信息：客户姓名："+custName+"  证件类型："+certType+" 证件内容："+certConetent);
					
					//调用客户识别接口
					String reqXml = custidentityXml(custIdentityReq.getOrgCode(), custName, certType, certConetent);
					logger.info("客户识别 【调用esb客户识别接口】请求报文："+reqXml);
					//调用发送接口
					String ip = PropetiesLoader.getSystemConfig().getString("esb.core.ip", "");
					int port = PropetiesLoader.getSystemConfig().getInt("esb.core.port", 10086);
					EsbServiceResp esbServiceResp = new EsbServiceResp();
					String respXml = SendUtil.socketSendData(reqXml, ip, port, esbServiceResp, "UTF-8", 7);
					logger.info("CustIdentityProcess返回内容："+respXml);
					if (esbServiceResp.getStatus().equals("FAIL")){  //
						custIdentityResp.getHead().setTransStatus("9999");
						custIdentityResp.getHead().setTransDescription("客户识别 ：【调用esb客户识别接口失败】："+esbServiceResp.getDesc());
						logger.info("BookActiveProcess：调用客户识别接口失败："+esbServiceResp.getDesc());
						custIdentityResp.getData().setCustLevel("-2"); //设置客户等级
						return  responseJson(transCode, custIdentityResp);
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
						logger.info("客户识别：esb交易状态："+statusNode.getStringValue()+"esb交易描述:"+descNode.getStringValue());
						String transStatus = statusNode.getStringValue();
						if (transStatus.equals("FAIL")){  //处理请求失败
							custIdentityResp.getHead().setTransStatus("9999");
							custIdentityResp.getHead().setTransDescription("客户识别接口ESB异常 ："+descNode.getStringValue());
							logger.info("BookActiveProcess：客户识别接口ESB异常："+esbServiceResp.getDesc());
							custIdentityResp.getData().setCustLevel("-2"); //设置客户等级
							return  responseJson(transCode, custIdentityResp);
						} 
						Node custLevelNode = document.selectSingleNode("/Service/Service_Body/response/EC-EVA-LEV");
							
						if (custLevelNode == null) { //数据不存在
							custIdentityResp.getHead().setTransStatus("9999");
							custIdentityResp.getHead().setTransDescription("客户识别 失败：未能查询到预约信息");
							logger.info("BookActiveProcess客户识别失败：未能查询到预约信息");
							custIdentityResp.getData().setCustLevel("-1"); //设置客户等级,没有查询到客户信息，非本行银行卡
							return  responseJson(transCode, custIdentityResp);
						} 
						String custLevel = custLevelNode.getStringValue();
						
						
						logger.info("客户识别 识别出客户等级 ："+custLevel);
						
						
						CustIdentityDataResp custIdentityDataResp = new CustIdentityDataResp();
						custIdentityDataResp.setCustLevel(custLevel);
						custIdentityDataResp.setProdList("");
						custIdentityDataResp.setMarkInfo("");
						custIdentityResp.getHead().setTransDescription("成功");
						custIdentityResp.getHead().setTransStatus("0000");
						custIdentityResp.setData(custIdentityDataResp);
						return  responseJson(transCode, custIdentityResp);
					} catch(Exception e){
						custIdentityResp.getHead().setTransStatus("9999");
						custIdentityResp.getHead().setTransDescription("预约激活 ：esb返回报文解析异常");
						custIdentityResp.getData().setCustLevel("-2"); //设置客户等级,
						logger.info("【EsbRequest】xml解析异常",e);
						return  responseJson(transCode, custIdentityResp);
					}
				}
			} catch (Exception e) {
				logger.info("CustIdentityProcess：客户识别处理异常：对象转换异常。",e);
				custIdentityResp.getHead().setTransStatus("9999");
				custIdentityResp.getHead().setTransDescription("客户识别处理异常：对象转换异常");
				custIdentityResp.getData().setCustLevel("-2"); //设置客户等级,
			}
		}else{
			JsonNode dataNode = root.findValue("data");
			if (dataNode == null) {
				custIdentityResp.getHead().setTransStatus("9999");
				custIdentityResp.getHead().setTransDescription("客户识别 ：没有发现data节点数据");
			} else {
					String dataJson = dataNode.toString();
					CustIdentityReq custIdentityReq;
					try {
						custIdentityReq = JsonUtils.json2pojo(dataJson, CustIdentityReq.class);
						//方式2：调用核心接口进行客户识别
						String mediaType = custIdentityReq.getMediaType(); // 1-二代证  2-刷卡    3-存折
						String mediaId = custIdentityReq.getMediaId(); //客户内容
						logger.info("客户识别介质类型："+mediaType+"  客户识别介质内容："+mediaId);
						if(PropetiesLoader.getSystemConfig().getBoolean("isHallMarket")){//是否和厅堂易交互
							String url = PropetiesLoader.getSystemConfig().getString("HallMarket.YX.IP")+
									PropetiesLoader.getSystemConfig().getString("HallMarket.custInfo");
							CustInfoReq req = HttpPostUtil.getCustNoByHallMarket(url,mediaType.substring(1,2),mediaId);
							String custNo = req.getCustNo()==null?"":req.getCustNo();//需要调用厅堂易3.1接口
							String Error_code = req.getError_code();
							logger.info("厅堂易查询营销系统信息返回客户号："+custNo+",Error_code:"+Error_code);
							if(custNo.equals("") || custNo == null){
								logger.info("营销系统未找到客户号，刷卡失败");
							}else if(!Error_code.equals("0")){
								logger.info("营销系统返回错误，刷卡失败，Error_code:"+Error_code);
							}else{
								String orgCode = custIdentityReq.getOrgCode();
								String deviceNo = custIdentityReq.getDeviceId();
								Map<String, String> paramsMap = new HashMap<String, String>();
								paramsMap.put("custNo", custNo);
								paramsMap.put("orgCode", orgCode);
								paramsMap.put("deviceNo", deviceNo);
								logger.info("向厅堂易刷卡到达接口发送信息："+paramsMap.toString());
								url = PropetiesLoader.getSystemConfig().getString("HallMarket.TTY.IP")+
										PropetiesLoader.getSystemConfig().getString("HallMarket.custCardArrival");
								String result = HttpPostUtil.sendPostParams(url, paramsMap);
								logger.info("厅堂易刷卡到达接口返回信息："+result);
								String custLevel = "";
								custLevel = req.getGrade();
								if(custLevel.equals("")||custLevel == null){
									custIdentityResp.getHead().setTransStatus("9999");
									custIdentityResp.getHead().setTransDescription("客户识别 失败：营销系统未能查询到相关信息");
									logger.info("BookActiveProcess客户识别 失败：营销系统未能查询到相关信息");
									custIdentityResp.getData().setCustLevel("-1"); //设置客户等级,没有查询到客户信息，非本行银行卡
									return  responseJson(transCode, custIdentityResp);
								}
								logger.info("客户识别 识别出客户等级 ："+custLevel);
								CustIdentityDataResp custIdentityDataResp = new CustIdentityDataResp();
								custIdentityDataResp.setCustLevel(custLevel);
								custIdentityDataResp.setProdList("");
								custIdentityDataResp.setMarkInfo("");
								custIdentityResp.getHead().setTransDescription("成功");
								custIdentityResp.getHead().setTransStatus("0000");
								custIdentityResp.setData(custIdentityDataResp);
								return  responseJson(transCode, custIdentityResp);
							}
						}else{
							List<Object> list = PropetiesLoader.getAuthTestConfig().getList("custMap");
							String custLevel = "";
							for(int i = 0; i < list.size(); i++){
								String[] strs = list.get(i).toString().split(":");
								if(strs[0].equals(mediaId)){
									custLevel = strs[1];
								}
							}
							if(custLevel.equals("")){
								custIdentityResp.getHead().setTransStatus("9999");
								custIdentityResp.getHead().setTransDescription("客户识别 失败：未能查询到预约信息");
								logger.info("BookActiveProcess客户识别失败：未能查询到预约信息");
								custIdentityResp.getData().setCustLevel("-1"); //设置客户等级,没有查询到客户信息，非本行银行卡
								return  responseJson(transCode, custIdentityResp);
							}
							logger.info("客户识别 识别出客户等级 ："+custLevel);
							
							
							CustIdentityDataResp custIdentityDataResp = new CustIdentityDataResp();
							custIdentityDataResp.setCustLevel(custLevel);
							custIdentityDataResp.setProdList("");
							custIdentityDataResp.setMarkInfo("");
							custIdentityResp.getHead().setTransDescription("成功");
							custIdentityResp.getHead().setTransStatus("0000");
							custIdentityResp.setData(custIdentityDataResp);
							return  responseJson(transCode, custIdentityResp);
						}
					} catch (Exception e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
					
			}
		}
		
		logger.info("CustIdentityProcess：客户识别处理异常，开始封装返回信息：====》");
		String json = "";
		try {
			json = JsonUtils.obj2json(custIdentityResp);
			logger.info("CustIdentityProcess：客户识别，封装返回信息="+json);
		} catch (Exception e) {
			logger.info("CustIdentityProcess：客户识别，将返回信息转换成json异常。",e);
			json = "{"+
			    "\"head\":{"+
			        "\"transCode\":\""+transCode+"\","+
			        "\"transDateTime\":\""+DateFormatUtils.format(new Date(), "yyyy-MM-dd HH:mm:ss")+"\","+
			        "\"transStatus\":\"9999\","+
			        "\"transDescription\":\"客户识别，返回信息转换成json异常\""+
			    "}"+
			"}";
		}
		return json;
	}
	
	
	/**
	 * 组装客户识别xml报文
	 * @param orgCode  机构编码
	 * @param custName 客户姓名  
	 * @param certType 证件类型
	 * @param certContent  证件内容
	 * @return
	 * @throws ConfigurationException 
	 */
	private String custidentityXml(String orgCode,String custName ,String certType,String certContent ) throws ConfigurationException{
		StringBuilder reqXml = new StringBuilder("<?xml version= \"1.0\" encoding= \"UTF-8\" ?>");
		//计算交易流水号
		long custidentitySn = PropetiesLoader.getSystemConfig().getLong("esb.custidentity.sn");
		if (custidentitySn == 509999999) {  //达到最大值，就恢复到初始值
			custidentitySn = 509000000;
		} else {
			custidentitySn++;
		}
		
		PropetiesLoader.getSystemConfig().setProperty("esb.custidentity.sn", custidentitySn);
	    PropetiesLoader.getSystemConfig().save();
	    
		//流水号 （系统保留就使用0） 第一位固定1,2-3位地市编码济宁58，4-7系统编号0091，8-9系统保留默认0,10系统保留默认0,11-19位流水号13位固定9表示外网系统，流水号三天内不重复
	    String requesterIdSn = PropetiesLoader.getSystemConfig().getString("esb.iqms.requester_id_sn");
	    String service_sn = "158"+requesterIdSn+"000"+custidentitySn;
		reqXml.append("<Service>");
		reqXml.append("<Service_Header>");
		reqXml.append("<service_sn>"+service_sn+"</service_sn>");
		reqXml.append("<requester_id>"+PropetiesLoader.getSystemConfig().getString("esb.iqms.requester_id")+"</requester_id>");  //我们系统编号(联盟分配)
		reqXml.append("<channel_id>"+PropetiesLoader.getSystemConfig().getString("esb.iqms.channel_id")+"</channel_id>"); //联盟分配
		reqXml.append("<service_time>"+DateFormatUtils.format(new Date(), "yyyyMMddHHmmss")+"</service_time>"); //年月日时分秒（系统时间）
		reqXml.append("<version_id>01</version_id>");  //固定01
		reqXml.append("<service_id>"+PropetiesLoader.getSystemConfig().getString("esb.custidentity.serid")+"</service_id>"); //接口id 客户识别
		reqXml.append("<branch_id>"+orgCode+"</branch_id>");
		reqXml.append("<service_response/>");
		reqXml.append("</Service_Header>");
		reqXml.append("<Service_Body>");
		reqXml.append("<ext_attributes>");
		reqXml.append("<INM-TELLER-ID>"+PropetiesLoader.getSystemConfig().getString("esb.virtual.tellerno").replace("@", " ")+"</INM-TELLER-ID>"); //虚拟柜员工号,12位，不够补空格
		reqXml.append("</ext_attributes>");
		reqXml.append("<request>");
		reqXml.append("<FULL-NAM-120>"+custName+"</FULL-NAM-120>");  //客户姓名
		reqXml.append("<CER-TYP>"+certType+"</CER-TYP>");  //证件类型
		reqXml.append("<CER-NO-60>"+certContent+"</CER-NO-60>");  //证件内容
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
		//reqXml.append("<T_KEY_LABEL>X000PG05</T_KEY_LABEL>"); //esb自动分配虚拟柜员（与上面同时只用一个）
		reqXml.append("<BRANCHID-IDENTIFY>"+PropetiesLoader.getSystemConfig().getString("esb.virtual.tellerno")+"</BRANCHID-IDENTIFY>");//使用虚拟柜员号
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
	 * 查询客户全称的xml
	 * @param orgCode  机构编码
	 * @param acctNO  卡号/存折号
	 * @param type    2-卡号   3-存折号
	 * @param funcCode  证件内容
	 * @return
	 * @throws ConfigurationException 
	 */
	private String findCustInfoByAcctXml(String orgCode ,String acctNO,String type) throws ConfigurationException{
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
		//reqXml.append("<INM-TELLER-ID>"+PropetiesLoader.getSystemConfig().getString("esb.virtual.tellerno").replace("@", " ")+"</INM-TELLER-ID>"); //虚拟柜员工号,12位，不够补空格
		reqXml.append("<BRANCHID-IDENTIFY>"+PropetiesLoader.getSystemConfig().getString("esb.virtual.tellerno")+"</BRANCHID-IDENTIFY>");//使用虚拟柜员号
		reqXml.append("</ext_attributes>");
		reqXml.append("<request>");
		if (type.equals("2")) {
			reqXml.append("<ACCT-NO>"+acctNO+"</ACCT-NO>");  //卡号
		} else {
			reqXml.append("<PSBK-NO>"+acctNO+"</PSBK-NO>");  //卡号
		}
 		reqXml.append("</request>");
		reqXml.append("<response/>");
		reqXml.append("</Service_Body>");
		reqXml.append("</Service>");
		
		return reqXml.toString();
	}
	
	/**
	 * 封装响应的json信息
	 * @param transCode
	 * @param bookActiveResp
	 * @return
	 */
	private String responseJson(String transCode, CustIdentityResp custIdentityResp) {
		logger.info("CustIdentityProcess：客户识别处理，开始封装返回信息：====》");
		String json = "";
		try {
			json = JsonUtils.obj2json(custIdentityResp);
			logger.info("CustIdentityProcess：客户识别，封装返回信息="+json);
		} catch (Exception e) {
			logger.info("CustIdentityProcess：客户识别，将返回信息转换成json异常。",e);
			json = "{"+
			    "\"head\":{"+
			        "\"transCode\":\""+transCode+"\","+
			        "\"transDateTime\":\""+DateFormatUtils.format(new Date(), "yyyy-MM-dd HH:mm:ss")+"\","+
			        "\"transStatus\":\"9999\","+
			        "\"transDescription\":\"客户识别，返回信息转换成json异常\""+
			    "}"+
			"}";
		}
		return json;
	}
	
	
	/**
	 * 客户识别测试
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
		CustIdentityProcess custIdentityProcess = new CustIdentityProcess();
		String respJson = custIdentityProcess.identityCust(null, "Y001", rootNode);
		System.out.println(respJson);
		
	}
	
}
