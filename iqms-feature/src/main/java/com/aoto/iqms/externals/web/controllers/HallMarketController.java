package com.aoto.iqms.externals.web.controllers;

import java.io.IOException;
import java.io.InputStream;
import java.io.InterruptedIOException;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.ConnectException;
import java.net.InetSocketAddress;
import java.net.Socket;
import java.net.SocketTimeoutException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Formatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.time.DateFormatUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.aoto.framework.commons.lang.StringUtils4Aoto;
import com.aoto.iqms.externals.models.HallMarket.BusTransferInfo;
import com.aoto.iqms.externals.models.HallMarket.BusTransferParam;
import com.aoto.iqms.externals.models.HallMarket.BusTransferResp;
import com.aoto.iqms.externals.models.HallMarket.CustInfoReq;
import com.aoto.iqms.externals.models.HallMarket.FindBusysParam;
import com.aoto.iqms.externals.models.HallMarket.FindBusysResp;
import com.aoto.iqms.externals.models.HallMarket.FindBusysServiceInfo;
import com.aoto.iqms.externals.models.HallMarket.PTByIdentityParam;
import com.aoto.iqms.externals.models.HallMarket.PickTicketInfo;
import com.aoto.iqms.externals.models.HallMarket.PickTicketParam;
import com.aoto.iqms.externals.models.HallMarket.PickTicketResp;
import com.aoto.iqms.externals.models.HallMarket.UpdateTicketInfo;
import com.aoto.iqms.externals.models.HallMarket.UpdateTicketStatusParam;
import com.aoto.iqms.externals.models.HallMarket.UpdateTicketStatusResp;
import com.aoto.iqms.businessconfig.models.BscShowTimeModel;
import com.aoto.iqms.businessconfig.service.inf.BscBranchBusinessService;
import com.aoto.iqms.businessconfig.service.inf.BscShowTimeService;
import com.aoto.iqms.externals.service.inf.ResourceService;
import com.aoto.iqms.monitor.service.inf.TrxTodayService;
import com.aoto.iqms.util.DateUtil;
import com.aoto.iqms.util.HttpPostUtil;
import com.aoto.iqms.util.JsonUtils;
import com.aoto.iqms.util.PropetiesLoader;
import com.fasterxml.jackson.databind.JsonNode;

/**
 * 处理厅堂易发送的请求
 * @author zhousj
 *
 */
@Controller
public class HallMarketController {
	private static final Logger logger = LoggerFactory.getLogger(HallMarketController.class);
	private  String  ENCODE = "UTF-8";
	public static int remotePort =Integer.parseInt( PropetiesLoader.getSystemConfig().getString("remotePort"));//远程取号接口
	@Autowired
	private BscBranchBusinessService busService;
	@Autowired
	private BscShowTimeService showTimeService;
	@Autowired
	private ResourceService resourceService;
	@Autowired
	private TrxTodayService trxTodayService;
	@RequestMapping(value = "/padService", method = RequestMethod.POST)
	@ResponseBody
	public void dealRequest(HttpServletRequest request, HttpServletResponse response){
		logger.info("=================================厅堂易请求开始===================================");
		logger.info("***********************"+request.getParameter("operation")+"*******************");
		logger.info("***********************"+request.getParameter("param")+"*******************");
		String reqJson = request.getParameter("param");
		String operation = request.getParameter("operation");
		String responseCode = "-1";
		try {
			if(StringUtils4Aoto.isBlank(reqJson)){
				logger.error("请求报文异常：未获取到请求报文");
				responseJson(responseCode,response);
				return;
			}
			if(operation == null ){
				logger.error("请求报文异常：未能在报文中获取到请求操作类型");
				responseJson(responseCode,response);
				return;
			}
			//获取业务列表
			if(operation.equals("findBusys")){
				FindBusysParam req = JsonUtils.json2pojo(reqJson, FindBusysParam.class);
				String orgCode = req.getOrgCode();
				String deviceNo = req.getDeviceNo();
				//判断当天是否是假日
				SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
				String now=sdf.format(new Date());
				String dateType = "N";//平日
				if(DateUtil.dateToWeek(now)>5){
					dateType = "H";//假日
				}
				//查询业务信息
				List<Map<String, Object>> serviceList =  busService.findBusysForHallMarket(orgCode, deviceNo);
				List<FindBusysServiceInfo> responseObject = new ArrayList<FindBusysServiceInfo>();
				FindBusysResp resp = new FindBusysResp();
				resp.setResponseCode("-1");
				if(serviceList.size() != 0){
					resp.setResponseCode("200");
					for (Map<String, Object>  findBusysServiceInfo : serviceList) {
						String busType = findBusysServiceInfo.get("busType").toString();
						String busCode = findBusysServiceInfo.get("busCode").toString();
						String busName = findBusysServiceInfo.get("busName").toString();
						//查询显示时间
						BscShowTimeModel model = new BscShowTimeModel();
						model.setDeviceNo(findBusysServiceInfo.get("deviceNo").toString());
						model.setBusinessId(busType);
						model.setDateType(dateType);
						List<Map<String, Object>> showTimeList = showTimeService.findShowTime(model);
						String busShowTime = "";
						for(int i=0; i<showTimeList.size(); i++){
							busShowTime += showTimeList.get(i).get("beginTime").toString()+"-"+
									showTimeList.get(i).get("endTime").toString()+";";
						}
						busShowTime = busShowTime.substring(0, busShowTime.length()-1);
						FindBusysServiceInfo info = new FindBusysServiceInfo(busType, busCode, busName, busShowTime);
						responseObject.add(info);
					}
				}
				resp.setResponseObject(JsonUtils.obj2json(responseObject));
				responseJson(resp,response);
			}else if(operation.equals("pickTicketByPwd")){
				PickTicketParam req = JsonUtils.json2pojo(reqJson, PickTicketParam.class);
				String orgCode = req.getOrgCode();
				String deviceNo = req.getDeviceNo();
				String busType = req.getBusCode();
				String custLevel = req.getCustLevel();
				String phoneNo = req.getPhoneNo();
				String smsSned = req.getSmsSned();
				Map<String, String> map = new HashMap<String, String>();
				map.put("orgCode", orgCode);
				map.put("deviceNo", deviceNo);
				//查询网点的设备信息
				List<Map<String, Object>> devListMap = resourceService.findDeviceByConditon(map);
				//返回厅堂易的封装类
				PickTicketResp resp = new PickTicketResp();
				PickTicketInfo responseObject = new PickTicketInfo();
				resp.setResponseCode("-1");
				//获取设备IP
				if (devListMap == null || devListMap.size() == 0){
					logger.error("【厅堂易:直接取号】：根据机构号和设备号未能查询到后台注册的设备信息，机构编码："+orgCode);
					responseJson(resp, response);
				}
				String devIp = devListMap.get(0).get("ipAddr").toString();
				String orgId = devListMap.get(0).get("orgId").toString();
				String pdjReq = "{"+
									    "\"head\":{"+
									        "\"transCode\":\"F002\","+
									        "\"transDateTime\":\""+DateFormatUtils.format(new Date(), "yyyy-MM-dd HH:mm:ss")+"\","+
									        "\"transStatus\":\"\","+
									        "\"transDescription\":\"\""+
									    "},"+
									    "\"data\":{"+
									        "transNet:\""+orgId+"\","+
									        "busType:\""+busType+"\","+
									        "ticketLevel:\""+custLevel+"\","+
									        "custId:\""+""+"\","+
									        "mediaType:\""+00+"\","+
									        "mediaId:\"\","+
									        "isPrint:\""+0+"\""+//TODO 是否打印号票 要增加的字段
									     "}"+
									"}";
				
				//开始给客户端发送请求消息
				logger.error("【厅堂易直接取号】：给排队机客户端发送请求消息"+pdjReq);
				String pdjResp = socketSendData(pdjReq,devIp,remotePort);
				logger.error("【厅堂易直接取号】：直接取号信息："+pdjResp);
				//对排队机返回的数据进行处理，然后返回
				if (pdjResp != null && !pdjResp.equals("")){  //封装返回的新
					pdjResp = pdjResp.substring(6);
					JsonNode rootNode = JsonUtils.getRoot(pdjResp);
					JsonNode transStatusNode = rootNode.findValue("transStatus");
					JsonNode transDescriptionNode = rootNode.findValue("transDescription");
					if (!transStatusNode.asText().equals("0000")){ //异常
						logger.error("排队机返回信息异常："+transDescriptionNode.asText());
						responseJson(resp, response);
					}else{
						String ticketNo = rootNode.findValue("ticketNo").asText(); 
						String waitNum = rootNode.findValue("waitNum").asText(); //TODO客户端要增加
						String printTime = rootNode.findValue("actDateTime").asText(); //TODO客户端要增加hh:MM:ss
						
						responseObject.setTicketNo(ticketNo);
						responseObject.setWaitNum(waitNum);
						responseObject.setPrintTime(printTime);
						resp.setResponseCode("200");
					}
				}
				resp.setResponseObject(JsonUtils.obj2json(responseObject));
				responseJson(resp, response);//返回给厅堂易
			}else if(operation.equals("pTByIdentity")){
				//返回厅堂易的封装类
				PTByIdentityParam req = JsonUtils.json2pojo(reqJson, PTByIdentityParam.class);
				String orgCode = req.getOrgCode();
				String deviceNo = req.getDeviceNo();
				String busType = req.getBusCode();
				String phoneNo = req.getPhoneNo();
				String smsSned = req.getSmsSned();
				String certType = req.getCertType();
				String certNo = req.getCertNo();
				String ticketLevel = "";
				//调用营销系统查询客户等级（号票等级）
				String url = PropetiesLoader.getSystemConfig().getString("HallMarket.YX.IP")+
						PropetiesLoader.getSystemConfig().getString("HallMarket.custInfo");
				CustInfoReq custInfoReq = HttpPostUtil.getCustNoByHallMarket(url,certType.substring(1, 2),certNo);
				ticketLevel = custInfoReq.getGrade()==null?"":custInfoReq.getGrade();//需要调用厅堂易3.1接口
				String Error_code = custInfoReq.getError_code();
				logger.info("厅堂易查询营销系统信息返回客户等级："+ticketLevel);
				//向厅堂易发送刷卡到达接口
				String custNo = custInfoReq.getCustNo()==null?"":custInfoReq.getCustNo();
				Map<String, String> paramsMap = new HashMap<String, String>();
				paramsMap.put("custNo", custNo);
				paramsMap.put("orgCode", orgCode);
				paramsMap.put("deviceNo", deviceNo);
				logger.info("向厅堂易刷卡到达接口发送信息："+paramsMap.toString());
				url = PropetiesLoader.getSystemConfig().getString("HallMarket.TTY.IP")+
						PropetiesLoader.getSystemConfig().getString("HallMarket.custCardArrival");
				String result = HttpPostUtil.sendPostParams(url, paramsMap);
				logger.info("厅堂易刷卡到达接口返回信息："+result);
				
				//返回厅堂易的封装类
				PickTicketResp resp = new PickTicketResp();
				PickTicketInfo responseObject = new PickTicketInfo();
				resp.setResponseCode("-1");
				
				if(!Error_code.equals("0")){
					resp.setResponseObject("");
					responseJson(resp, response);
					logger.info("营销系统返回错误，身份识别取号失败，Error_code："+Error_code);
					return;
				}
				
				if(ticketLevel.equals("") || ticketLevel == null){
					resp.setResponseObject("");
					responseJson(resp, response);
					logger.info("营销系统未找到客户等级，身份识别取号失败");
					return;
				}
				
				//转换为排队机终端需要的类型
				if(certType.equals("02")){
					certType = "03";
				}else if(certType.equals("03")){
					certType = "02";
				}
				
				Map<String, String> map = new HashMap<String, String>();
				map.put("orgCode", orgCode);
				map.put("deviceNo", deviceNo);
				//查询网点的设备信息
				List<Map<String, Object>> devListMap = resourceService.findDeviceByConditon(map);
				
				//获取设备IP
				if (devListMap == null || devListMap.size() == 0){
					logger.error("【厅堂易:身份识别取号】：根据机构号和设备号未能查询到后台注册的设备信息，机构编码："+orgCode);
					resp.setResponseObject("");
					responseJson(resp, response);
					return;
				}
				String devIp = devListMap.get(0).get("ipAddr").toString();
				String orgId = devListMap.get(0).get("orgId").toString();
				String pdjReq = "{"+
									    "\"head\":{"+
									        "\"transCode\":\"F002\","+
									        "\"transDateTime\":\""+DateFormatUtils.format(new Date(), "yyyy-MM-dd HH:mm:ss")+"\","+
									        "\"transStatus\":\"\","+
									        "\"transDescription\":\"\""+
									    "},"+
									    "\"data\":{"+
									        "transNet:\""+orgId+"\","+
									        "busType:\""+busType+"\","+
									        "ticketLevel:\""+ticketLevel+"\","+
									        "mediaType:\""+certType+"\","+// 卡类型01：01 卡；02 身份证；03存折
									        "mediaId:\""+certNo+"\","+// 对应卡类型的卡号
									        "custId:\"\","+//TODO 要和客户端确定
									        "isPrint:\""+1+"\""+// 是否打印号票 要增加的字段
									     "}"+
									"}";
				//开始给客户端发送请求消息
				logger.error("【厅堂易身份识别取号】：给排队机客户端发送请求消息"+pdjReq);
				String pdjResp = socketSendData(pdjReq,devIp,remotePort);
				logger.error("【厅堂易身份识别取号】：排队机客户端返回身信息："+pdjResp);
				//对排队机返回的数据进行处理，然后返回
				if (pdjResp != null && !pdjResp.equals("")){  //封装返回的新
					pdjResp = pdjResp.substring(6);
					JsonNode rootNode = JsonUtils.getRoot(pdjResp);
					JsonNode transStatusNode = rootNode.findValue("transStatus");
					JsonNode transDescriptionNode = rootNode.findValue("transDescription");
					if (!transStatusNode.asText().equals("0000")){ //异常
						logger.error("排队机返回信息异常："+transDescriptionNode.asText());
						resp.setResponseObject("");
						responseJson(resp, response);
						return;
					}else{
						String ticketNo = rootNode.findValue("ticketNo").asText(); 
						String waitNum = rootNode.findValue("waitNum").asText(); //TODO客户端要增加
						String printTime = rootNode.findValue("actDateTime").asText(); //TODO客户端要增加hh:MM:ss
						
						responseObject.setTicketNo(ticketNo);
						responseObject.setWaitNum(waitNum);
						responseObject.setPrintTime(printTime);
						responseObject.setCustLevel(ticketLevel);
						resp.setResponseCode("200");
					}
				}
				resp.setResponseObject(JsonUtils.obj2json(responseObject));
				responseJson(resp, response);//返回给厅堂易
			}else if(operation.equals("updateTicketStatus")){
				//测试
				UpdateTicketStatusParam req = JsonUtils.json2pojo(reqJson, UpdateTicketStatusParam.class);
				String orgCode = req.getOrgCode();
				String deviceNo = req.getDeviceNo();
				String ticketNo = req.getTicketNo();
				String status = req.getStatus();
				String tmpStatus = status;
				if(status.equals("3")){
					status = "7";
				}else if(status.equals("8")){
					status = "6";
				}else if(status.equals("0")){
					status = "1";
				}
				Map<String, String> map = new HashMap<String, String>();
				map.put("orgCode", orgCode);
				map.put("deviceNo", deviceNo);
				//查询网点的设备信息
				List<Map<String, Object>> devListMap = resourceService.findDeviceByConditon(map);
				//返回厅堂易的封装类
				UpdateTicketStatusResp resp = new UpdateTicketStatusResp();
				UpdateTicketInfo responseObject = new UpdateTicketInfo();
				//获取设备IP
				if (devListMap == null || devListMap.size() == 0){
					logger.error("【厅堂易:更新号票状态】：根据机构号和设备号未能查询到后台注册的设备信息，机构编码："+orgCode);
					responseJson(resp, response);
				}
				String devIp = devListMap.get(0).get("ipAddr").toString();
				String orgId = devListMap.get(0).get("orgId").toString();
				String pdjReq = "{"+
									    "\"head\":{"+
									        "\"transCode\":\"U001\","+
									        "\"transDateTime\":\""+DateFormatUtils.format(new Date(), "yyyy-MM-dd HH:mm:ss")+"\","+
									        "\"transStatus\":\"\","+
									        "\"transDescription\":\"\""+
									    "},"+
									    "\"data\":{"+
									        "transNet:\""+orgId+"\","+
									        "ticketNo:\""+ticketNo+"\","+
									        "status:\""+status+"\""+
									     "}"+
									"}";
				//开始给客户端发送请求消息
				String pdjResp = socketSendData(pdjReq,devIp,remotePort);
				logger.info("【厅堂易】更新号票状态客户端返回信息："+pdjResp);
				//对排队机返回的数据进行处理，然后返回
				if (pdjResp != null && !pdjResp.equals("")){  
					pdjResp = pdjResp.substring(6);
					JsonNode rootNode = JsonUtils.getRoot(pdjResp);
					JsonNode transStatusNode = rootNode.findValue("transStatus");
					JsonNode transDescriptionNode = rootNode.findValue("transDescription");
					responseObject.setStatusMessage(transDescriptionNode.asText());
					if (!transStatusNode.asText().equals("0000")){ //异常
						logger.error("排队机返回信息异常："+transDescriptionNode.asText());
						responseObject.setStatusCode("1");//失败
						resp.setResponseCode("-1");
						resp.setResponseObject(JsonUtils.obj2json(responseObject));
						responseJson(resp, response);
					}else{
						/*//发起客户号票到达请求
						Map<String, String> paramsMap = new HashMap<String, String>();
						paramsMap.put("busType", "");
						paramsMap.put("busCode", "");
						paramsMap.put("busTypeName", "");
						paramsMap.put("ticketNo", ticketNo);
						paramsMap.put("status", tmpStatus);
						paramsMap.put("printTime", "");
						paramsMap.put("callTime", "");
						paramsMap.put("endTime", "");
						paramsMap.put("appValue", "");
						paramsMap.put("winNo", "");
						paramsMap.put("tellerNo", "");
						paramsMap.put("tellerName", "");
						paramsMap.put("custNo", "");
						paramsMap.put("orgCode", orgCode);
						paramsMap.put("deviceNo", deviceNo);
						paramsMap.put("flowNo", "");
						logger.info("向厅堂易系统发起客户号票到达请求："+paramsMap.toString());
						String url = PropetiesLoader.getSystemConfig().getString("HallMarket.TTY.IP")+
								PropetiesLoader.getSystemConfig().getString("HallMarket.custTicketArrival");
						String result = HttpPostUtil.sendPostParams(url, paramsMap);
						logger.info("向厅堂易系统发起客户号票到达请求，返回："+result);
						//修改流水数据
						Map<String, String> trxMap = new HashMap<String, String>();
						trxMap.put("deviceNo", deviceNo);
						trxMap.put("ticketNo", ticketNo);
						trxMap.put("trxStatus", status);
						trxTodayService.updateTrxToday(trxMap);*/
						
						responseObject.setStatusCode("200");//成功
						resp.setResponseCode("200");
						resp.setResponseObject(JsonUtils.obj2json(responseObject));
						logger.info("排队机返回信息："+transDescriptionNode.asText());
						responseJson(resp, response);
					}
				}else{
					logger.error("排队机返回信息异常：排队机未返回信息");
					resp.setResponseCode("-1");//失败
					responseObject.setStatusMessage("排队机未返回信息");
					responseObject.setStatusCode("1");
					resp.setResponseObject(JsonUtils.obj2json(responseObject));
					responseJson(resp, response);
				}
			}else if(operation.equals("busTransfer")){//号票业务转移
				BusTransferParam req = JsonUtils.json2pojo(reqJson, BusTransferParam.class);
				String orgCode = req.getOrgCode();
				String deviceNo = req.getDeviceNo();
				String ticketNo = req.getTicketNo();
				String busType = req.getBusType();
				String busCode = req.getBusCode();
				String custLevel = req.getCustLevel();
				String isCreateT = req.getIsCreateT();
				
				Map<String, String> map = new HashMap<String, String>();
				map.put("orgCode", orgCode);
				map.put("deviceNo", deviceNo);
				//查询网点的设备信息
				List<Map<String, Object>> devListMap = resourceService.findDeviceByConditon(map);
				//返回厅堂易的封装类
				BusTransferResp resp = new BusTransferResp();
				BusTransferInfo responseObject = new BusTransferInfo();
				//获取设备IP
				if (devListMap == null || devListMap.size() == 0){
					logger.error("【厅堂易:号票业务转移】：根据机构号和设备号未能查询到后台注册的设备信息，机构编码："+orgCode);
					responseJson(resp, response);
				}
				String orgId = devListMap.get(0).get("orgId").toString();
				String devIp = devListMap.get(0).get("ipAddr").toString();
				String pdjReq = "{"+
									    "\"head\":{"+
									        "\"transCode\":\"T001\","+
									        "\"transDateTime\":\""+DateFormatUtils.format(new Date(), "yyyy-MM-dd HH:mm:ss")+"\","+
									        "\"transStatus\":\"\","+
									        "\"transDescription\":\"\""+
									    "},"+
									    "\"data\":{"+
									    "\"transNet\":\""+orgId+"\","+
									    "\"ticketNo\":\""+ticketNo+"\","+
									    "\"busTypeId\":\""+busType+"\","+
									    "\"busCode\":\""+busCode+"\","+
									    "\"ticketLevel\":\""+custLevel+"\","+
									    "\"isCreateT\":\""+isCreateT+"\""+
									     "}"+
									"}";
				//开始给客户端发送请求消息
				String pdjResp = socketSendData(pdjReq,devIp,remotePort);
				logger.info("【厅堂易】号票业务转移客户端返回信息："+pdjResp);
				//对排队机返回的数据进行处理，然后返回
				if (pdjResp != null && !pdjResp.equals("")){  
					pdjResp = pdjResp.substring(6);
					JsonNode rootNode = JsonUtils.getRoot(pdjResp);
					JsonNode transStatusNode = rootNode.findValue("transStatus");
					JsonNode transDescriptionNode = rootNode.findValue("transDescription");
					JsonNode statusNode = rootNode.findValue("status");
					JsonNode newBusCodeNode = rootNode.findValue("newBusCode");
					JsonNode newLevelNode = rootNode.findValue("newLevel");
					JsonNode newTicketNode = rootNode.findValue("newTicket");
					if (!transStatusNode.asText().equals("0000")){ //异常
						logger.error("排队机返回信息异常："+transDescriptionNode.asText());
						responseObject.setStatus(statusNode.asText());//失败
						resp.setResponseCode("-1");
						resp.setResponseObject(JsonUtils.obj2json(responseObject));
						responseJson(resp, response);
					}else{
						/*//发起客户号票到达请求
						Map<String, String> paramsMap = new HashMap<String, String>();
						paramsMap.put("busType", busType);
						paramsMap.put("busCode", busCode);
						paramsMap.put("busTypeName", "");
						paramsMap.put("ticketNo", ticketNo);
						paramsMap.put("status", "9");
						paramsMap.put("printTime", "");
						paramsMap.put("callTime", "");
						paramsMap.put("endTime", "");
						paramsMap.put("appValue", "");
						paramsMap.put("winNo", "");
						paramsMap.put("tellerNo", "");
						paramsMap.put("tellerName", "");
						paramsMap.put("custNo", "");
						paramsMap.put("orgCode", orgCode);
						paramsMap.put("deviceNo", deviceNo);
						paramsMap.put("flowNo", "");
						logger.info("向厅堂易系统发起客户号票到达请求："+paramsMap.toString());
						String url = PropetiesLoader.getSystemConfig().getString("HallMarket.TTY.IP")+
								PropetiesLoader.getSystemConfig().getString("HallMarket.custTicketArrival");
						String result = HttpPostUtil.sendPostParams(url, paramsMap);
						logger.info("向厅堂易系统发起客户号票到达请求，返回："+result);
						//修改流水数据
						Map<String, String> trxMap = new HashMap<String, String>();
						trxMap.put("deviceNo", deviceNo);
						trxMap.put("ticketNo", ticketNo);
						trxMap.put("busType", busType);
						trxMap.put("busCode", busCode);
						trxTodayService.updateTrxToday(trxMap);*/
						
						responseObject.setStatus(statusNode.asText());//成功
						responseObject.setNewBusCode(newBusCodeNode.asText());
						responseObject.setNewLevel(newLevelNode.asText());
						responseObject.setNewTicket(newTicketNode.asText());
						resp.setResponseCode("200");
						resp.setResponseObject(JsonUtils.obj2json(responseObject));
						logger.info("排队机返回信息："+transDescriptionNode.asText());
						responseJson(resp, response);
					}
				}else{
					logger.error("排队机返回信息异常：排队机未返回信息");
					resp.setResponseCode("-1");//失败
					responseObject.setStatus("1");
					resp.setResponseObject(JsonUtils.obj2json(responseObject));
					responseJson(resp, response);
				}
			}
		} catch (IOException e) {
			e.printStackTrace();
		} catch (Exception e) {
			logger.error("厅堂易请求-将json请求转换成请求对象异常：",e);
			e.printStackTrace();
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
			logger.error("【HallMarket-formatData】格式化数据异常：",e);
		}
		return formatData;
	}
	
	/**
     * 向排队机发送请求报文（取号）
     * @param msg
     * @param ipAddr
     * @return
     */
    private String socketSendData(String msg,String ipAddr, int port){
		try {
			String fmtMsg = formatData(msg,6,"GBK");
			byte[] destMsg = fmtMsg.getBytes("GBK");
			//定义个一个用于接收返回数据的报文数组
			byte[] bRecvBuf = new byte[8192];
			//获取远程取号的连接超时次数
			int socketConnTimes = PropetiesLoader.getSystemConfig().getInt("socketConnTimes", 2);
			//int socketConnTimes = 2;
			logger.info("【socketSendData】socket连接失败重连次数配置："+socketConnTimes);
			int nErr = sendMsg(ipAddr,port,destMsg,destMsg.length,bRecvBuf,socketConnTimes);
			if (nErr > 0){
				String pdjResp = new String(bRecvBuf,0,nErr,"GBK");
				logger.info("排队机返回的报文："+pdjResp);
				return pdjResp;
			}
		}catch(Exception e){
			logger.error("和排队机通讯异常：",e);
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
	private int sendMsg(String ip,int port,byte[] content, int len, byte[] bRecvBuf, int nTimeOut){
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
		} catch (Exception e) {
			logger.error("未知的异常2",e);
			timeEnd = System.currentTimeMillis();
			logger.error("耗时："+(timeEnd-timeStart));
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
	 * 厅堂易的响应报文
	 * @param obj
	 * @param response
	 */
	private void responseJson(Object obj,HttpServletResponse response){
		String json = "";
		try {
			json = JsonUtils.obj2json(obj);
		} catch (Exception e) {
			logger.error("厅堂易请求响应转换异常：",e);
		}
		
		logger.error("厅堂易请求响应内容json："+json);
		try {
			response.getOutputStream().write(json.getBytes("UTF-8"));
		} catch (UnsupportedEncodingException e) {
			logger.error("响应客户端JSON异常（发送内容编码）：",e);
		} catch (IOException e) {
			logger.error("响应客户端JSON异常：",e);
		}
	}
}
