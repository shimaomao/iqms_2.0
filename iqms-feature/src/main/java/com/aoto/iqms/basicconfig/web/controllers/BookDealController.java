package com.aoto.iqms.basicconfig.web.controllers;

import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Formatter;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.aoto.framework.commons.lang.StringUtils4Aoto;
import com.aoto.iqms.basicconfig.models.book.BookActInfo;
import com.aoto.iqms.basicconfig.models.book.BookActNoStatus;
import com.aoto.iqms.basicconfig.models.book.BookCancel;
import com.aoto.iqms.basicconfig.models.book.BookDevInfo;
import com.aoto.iqms.basicconfig.models.book.BookNetRoomInfo;
import com.aoto.iqms.basicconfig.models.book.BookRangeInfo;
import com.aoto.iqms.basicconfig.models.book.BookReqHeader;
import com.aoto.iqms.basicconfig.models.book.BookResp;
import com.aoto.iqms.basicconfig.models.book.BookRespHeader;
import com.aoto.iqms.basicconfig.models.book.BookServiceInfo;
import com.aoto.iqms.basicconfig.models.book.BookX001Req;
import com.aoto.iqms.basicconfig.models.book.BookX001Resp;
import com.aoto.iqms.basicconfig.models.book.BookX002Req;
import com.aoto.iqms.basicconfig.models.book.BookX002Resp;
import com.aoto.iqms.basicconfig.models.book.BookX003Req;
import com.aoto.iqms.basicconfig.models.book.BookX003Resp;
import com.aoto.iqms.basicconfig.models.book.BookX004Resp;
import com.aoto.iqms.basicconfig.service.inf.OrderConfigService;
import com.aoto.iqms.businessconfig.models.BscShowTimeModel;
import com.aoto.iqms.businessconfig.service.inf.BscDeviceService;
import com.aoto.iqms.businessconfig.service.inf.BscShowTimeService;
import com.aoto.iqms.util.DateUtil;
import com.aoto.iqms.util.JsonUtils;
import com.fasterxml.jackson.databind.JsonNode;

/**
 * 预约接口 相关处理
 * @author zhousj
 *
 */
@Controller
public class BookDealController {
	private static final Logger logger = LoggerFactory.getLogger(BookDealController.class);
	@Autowired
	private BscDeviceService devService;
	@Autowired
	private OrderConfigService orderConfigService;
	@Autowired
	private BscShowTimeService showTimeService;
	private  String  ENCODE = "UTF-8";
	
	/**
	 * 预约请求处理
	 * @param request
	 * @param response
	 */
	@RequestMapping(value = "/basicconfig/book", method = RequestMethod.POST)
    @ResponseBody
    public void dealOrder(HttpServletRequest request,  
          HttpServletResponse response){
		logger.error("=================================预约请求开始===================================");
		//响应报文
		BookRespHeader respHeader = new BookRespHeader();
		String reqJson = "";
		//获取请求报文
		try {
			InputStream in = request.getInputStream();
			
			byte[] packLen = new byte[6];
			int len = in.read(packLen, 0, 6);
			if (len != 6) {
				return;
			}
			int reqLen = Integer.parseInt(new String(packLen, "UTF-8"));
			logger.error("【http】-->解析的到数据长度为：" + reqLen);
			// 创建报文数组
			byte[] datas = new byte[reqLen];
			// 将输入流中的数据读入到报文数组中
			int exclen = in.read(datas, 0, reqLen);
			BookResp resp = new BookResp();
			if (exclen != reqLen) {
				logger.error("【http fail】-->实际获取到的报文字节数和指定的字节数不相等，获取到的字节数："
						+ exclen + "指定获取的字节数：" + reqLen);
				resp.getHead().setTransStatus("9999");
				resp.getHead().setRespDate(DateUtil.getNow().replace(" ", ""));
				resp.getHead().setStatusDescribe("获取到的长度和实际长度不符合");
				responseJson(resp, response);
				return;
			}
			reqJson = new String(datas, ENCODE);
			/*System.out.println("packageData"+packageData);
			byte[] dataBytes =  new byte[2048];
			len = 0;
			while((len = in.read(dataBytes)) != -1){
				reqJson = new String(dataBytes, 0, len, "UTF-8");
			}*/
			
			if(StringUtils4Aoto.isBlank(reqJson)){
				logger.error("请求报文异常：未获取到请求报文");
				resp.getHead().setTransStatus("9999");
				resp.getHead().setRespDate(DateUtil.getNow().replace(" ", ""));
				resp.getHead().setStatusDescribe("未获取到请求报文");
				responseJson(resp, response);
				return;
			}
			
			try {
				//解析报文获取交易码
				JsonNode rootNode = JsonUtils.getRoot(reqJson);
				JsonNode transCodeNode = rootNode.findValue("transCode"); 
				JsonNode orgCodeNode = rootNode.findValue("orgCode"); 
//				BookX001Req x001Req = JsonUtils.json2pojo(reqJson, BookX001Req.class);
//				BookX001Resp x001 = new BookX001Resp();
//				BookReqHeader reqHeader = x001Req.getHead();
//				String transCode = reqHeader.getTransCode();//交易码
//				String orgCode = reqHeader.getOrgCode();//机构编码
//				String channel = reqHeader.getChannel();//渠道
				
				if(transCodeNode == null ){
					logger.error("请求报文异常：未能在报文中获取到交易码");
					resp.getHead().setTransStatus("9999");
					resp.getHead().setRespDate(DateUtil.getNow().replace(" ", ""));
					resp.getHead().setStatusDescribe("请求报文异常：未能在报文中获取到交易码");
					responseJson(resp, response);
					return;
				}
				//获取交易码成功
				String  transCode = transCodeNode.textValue();
				if(orgCodeNode == null){
					logger.error("请求报文异常：未能在报文中获取到机构号");
					resp.getHead().setTransStatus("9999");
					resp.getHead().setRespDate(DateUtil.getNow().replace(" ", ""));
					resp.getHead().setStatusDescribe("请求报文异常：未能在报文中获取到机构号");
					responseJson(resp, response);
					return;
				}
				String orgCode = orgCodeNode.textValue();
				//通过机构号查询网点设备(提供预约的网点设备)
				List<Map<String, Object>> devs = devService.findDeviceForOrder(orgCode, "1");
				if (devs == null || devs.size() == 0){
					logger.error("查询提供预约排队机异常：网点没有提供预约的排队机");
					resp.getHead().setOrgCode(orgCode);
					resp.getHead().setTransCode(transCode);
					resp.getHead().setTransStatus("9999");
					resp.getHead().setRespDate(DateUtil.getNow().replace(" ", ""));
					resp.getHead().setStatusDescribe("查询提供预约排队机异常：网点没有提供预约的排队机");
					responseJson(resp, response);
					return;
				}
				
				if ("X001".equals(transCode)){ //营业厅信息接口
					BookX001Req x001Req = JsonUtils.json2pojo(reqJson, BookX001Req.class);
					BookReqHeader reqHeader = x001Req.getHead();
					BookX001Resp x001 = new BookX001Resp();
					String orderDt = reqHeader.getOrderDt(); //获取预约日期
					BookNetRoomInfo roomInfo = new BookNetRoomInfo();
					x001.getHead().setChannel(reqHeader.getChannel());
					x001.getHead().setOrgCode(orgCode);
					x001.getHead().setRespDate(DateUtil.getNow().replace(" ", ""));
					x001.getHead().setTransCode(transCode);
					//设备信息
					List<BookDevInfo> devInfoList = new ArrayList<BookDevInfo>();
					for(Map<String, Object> devMap : devs){
						String devNo = (String)devMap.get("deviceNo");
						String remark = (String)devMap.get("hostName");
						//查询网点配置的预约时间段
						List<Map<String, Object>> orderRanageListMap =  orderConfigService.findOrderRange(devNo, orderDt);
						//预约时间段信息
						List<BookRangeInfo> rangeInfosList = new ArrayList<BookRangeInfo>();
						for (Map<String, Object> map : orderRanageListMap) {
							String beginTime = (String)map.get("beginTime");
							String endTime = (String)map.get("endTime");
							String total = (String)map.get("total");
							String orderCount = (String)map.get("order_count");
							BookRangeInfo rangeTmp = new BookRangeInfo(beginTime, endTime, total, orderCount);
							rangeInfosList.add(rangeTmp);
						}
						
						
						String dateType = "N";//平日
						if(DateUtil.dateToWeek(orderDt)>5){
							dateType = "H";//假日
						}
						//查询业务信息
						List<Map<String, Object>> orderBusListMap = orderConfigService.findBusiness(devNo);
						//业务信息
						List<BookServiceInfo> serviceInfosList = new ArrayList<BookServiceInfo>();
						for (Map<String, Object> map : orderBusListMap) {
							String serviceId = (String)map.get("busId");
							String serviceCode = (String)map.get("busCode");
							String serviceName = (String)map.get("busName");
							//查询显示时间
							BscShowTimeModel model = new BscShowTimeModel();
							model.setDeviceNo(devNo);
							model.setBusinessId(serviceId);
							model.setDateType(dateType);
							List<Map<String, Object>> showTimeList = showTimeService.findShowTime(model);
							String[] serviceShowTime = new String[showTimeList.size()];
							for(int i=0; i<showTimeList.size(); i++){
								serviceShowTime[i] = showTimeList.get(i).get("beginTime").toString()+"-"+
										showTimeList.get(i).get("endTime").toString();
							}
//							String serviceShowTime = (String)map.get("serviceShowTime");
							BookServiceInfo serviceTmp = new BookServiceInfo(serviceId, serviceCode, serviceName, serviceShowTime);
							serviceInfosList.add(serviceTmp);
						}
						
						BookDevInfo devInfoTmp = new BookDevInfo(devNo, remark, serviceInfosList, rangeInfosList);
						devInfoList.add(devInfoTmp);
					}
					roomInfo.setDeviceInfos(devInfoList);
					//固定返回成功
					x001.getHead().setTransStatus("0000");
					x001.getHead().setStatusDescribe("成功");
					x001.setData(roomInfo);
					responseJson(x001, response);
				}else if("X002".equals(transCode)){//客户预约
					BookX002Req x002Req = JsonUtils.json2pojo(reqJson, BookX002Req.class);
					//获取预约相关的信息
					String certType = x002Req.getData().getCertType();
					String certContent = x002Req.getData().getCertContent();
					String orderDt = x002Req.getHead().getOrderDt();
					String orderTime = x002Req.getData().getOrderTime(); //预约时间点不做要求
					String rangeBegin = x002Req.getData().getRangeBegin(); //预约开始时间段
					String rangeEnd = x002Req.getData().getRangeEnd();     //预约结束时间段
					String orderServiceCode = x002Req.getData().getOrderServiceCode(); //预约业务编码
					String orderServiceId = x002Req.getData().getOrderServiceId(); //预约业务id
					
					logger.error("预约请求-验证类型（1-身份证； 2-银行卡；6-手机号："+certType);
					logger.error("预约请求-验证内容"+certContent);
					logger.error("预约请求-预约日期"+orderDt);
					logger.error("预约请求-预约时间点（废弃）"+orderTime);
					logger.error("预约请求-预约开始时间段："+rangeBegin);
					logger.error("预约请求-预约结束时间段："+rangeEnd);
					logger.error("预约请求-预约业务编码"+orderServiceCode);
					logger.error("预约请求-预约业务ID"+orderServiceId);
					BookX002Resp x002 = new BookX002Resp();
					BookActInfo actInfo = new BookActInfo();
					x002.getHead().setChannel(x002Req.getHead().getChannel());
					actInfo.setDevNo(x002Req.getData().getDevNo());
					x002.getHead().setOrgCode(orgCode);
					x002.getHead().setTransCode(transCode);
					
					//先判断是否可以预约
					int existResult = orderConfigService.existBook(x002Req);
					if(existResult == 0){
						//生成随机数
						Random random = new Random();
						String actNo = "";
						while(true){
							int actNoInt = random.nextInt(9999);
							Formatter f = new Formatter();
							f.format("%04d", actNoInt);
							actNo = f.toString();
							x002Req.getData().setActNo(actNo);
							//判断是否存在的激活码（这里面最后一次保存的就是正确的激活码）
							boolean existActBoolean = orderConfigService.existActNo(x002Req);
							if (existActBoolean){
								break;
							}
						}
						//保存预约记录
						orderConfigService.insertOrderInfo(x002Req);
						actInfo.setActNo(x002Req.getData().getActNo());
						x002.getHead().setRespDate(DateUtil.getNow().replace(" ", ""));
						actInfo.setOrderDate(x002Req.getHead().getOrderDt());
						actInfo.setOrderServiceCode(orderServiceCode);
						actInfo.setRangeBegin(rangeBegin);
						actInfo.setRangeEnd(rangeEnd);
						actInfo.setOrderTime(orderTime);
						x002.getHead().setTransStatus("0000");
						x002.getHead().setStatusDescribe("预约成功");
					}else {
						x002.getHead().setTransStatus("9999");
						x002.getHead().setRespDate(DateUtil.getNow().replace(" ", ""));
						if (existResult == 1){
							x002.getHead().setStatusDescribe("预约失败：该客户已经预约过了");
						} else if (existResult == 2) {
							x002.getHead().setStatusDescribe("预约失败：预约时间点，没有找到对应的时间段");
						} else if (existResult == 3) {
							x002.getHead().setStatusDescribe("预约失败：该网点预约号，已经被预约完");
						}
					}
					x002.setData(actInfo);
					//响应客户端
					responseJson(x002, response);
					
				}else if ("X003".equals(transCode)) { //查询激活码的状态
					BookX003Req x003Req = JsonUtils.json2pojo(reqJson, BookX003Req.class);
					BookX003Resp x003 = new BookX003Resp();
					BookActNoStatus bookActNoStatus = new BookActNoStatus();
					x003.getHead().setChannel(x003Req.getHead().getChannel());
					x003.getHead().setOrgCode(orgCode);
					x003.getHead().setRespDate(DateUtil.getNow().replace(" ", ""));
					x003.getHead().setTransCode(transCode);
					bookActNoStatus.setOrderDt(x003Req.getHead().getOrderDt());
					//获取请求的激活码
				    String reqActNo = x003Req.getData().getActNo();
				    logger.debug("预约状态查询：获取到的激活码===》"+reqActNo);
				    bookActNoStatus.setActNo(reqActNo);
				    
				    //查询激活码的有效状态()
				    List<Map<String, Object>> actStatusList = orderConfigService.queryActNoStatus(x003Req);
				    
				    if (actStatusList == null || actStatusList.size() == 0){
				    	  //没有激活码信息
				    	x003.getHead().setTransStatus("9999");
				    	x003.getHead().setStatusDescribe("激活码不存在或者已经过期");
				     } else {
				    	 //查询到激活码信息
				    	Map<String, Object> map = actStatusList.get(0);
				    	String orderDate = map.get("orderDate") == null ? "" :map.get("orderDate").toString();
				    	String devNo = map.get("devNo") == null ? "" :map.get("devNo").toString();
				    	String orderBusId = map.get("orderBusId") == null ? "" :map.get("orderBusId").toString();
				    	String orderBusCode = map.get("orderBusCode") == null ? "" :map.get("orderBusCode").toString();
				    	String certType = map.get("certType") == null ? "" :map.get("certType").toString();
				    	String certCount = map.get("certCount") == null ? "" :map.get("certCount").toString();
				    	String orderTime = map.get("orderTime") == null ? "" :map.get("orderTime").toString();
				    	String rangeBegin = map.get("rangeBegin") == null ? "" :map.get("rangeBegin").toString();
				    	String rangeEnd = map.get("rangeEnd") == null ? "" :map.get("rangeEnd").toString();
				    	String orderStatus = map.get("orderStatus") == null ? "" :map.get("orderStatus").toString();
				    	
				    	//预约状态： 0-未激活   1-已激活    2-取消
				    	if(StringUtils4Aoto.isBlank(orderStatus)){
				    		bookActNoStatus.setActStatus("4"); //未知
				    	} else if (orderStatus.equals("0")){
				    		bookActNoStatus.setActStatus("0"); //未激活
				    		//当前日期已经大于预约日期的结束时间，预约记录就失效
				    		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
				    		String bookEndTime = orderDate+" "+rangeEnd;
				    		try {
								Date bookDt = sdf.parse(bookEndTime);
								if (bookDt.before(new Date())){ //当前日期已经超过了预约日期的结束时间，就失效
									bookActNoStatus.setActStatus("3");  //已失效
								}
							} catch (Exception e) {
								bookActNoStatus.setActStatus("4"); //未知
							}
				    		
				    		
				    	} else if (orderStatus.equals("1")){
				    		bookActNoStatus.setActStatus("1"); //已激活
				    	} else if (orderStatus.equals("2")){
				    		bookActNoStatus.setActStatus("2"); //已取消
				    	}
				    	x003.getHead().setTransStatus("0000");
				    	x003.getHead().setStatusDescribe("成功");
				    	bookActNoStatus.setOrderDt(orderDate);
				    	bookActNoStatus.setDevNo(devNo);
				    	bookActNoStatus.setOrderBusId(orderBusId);
				    	bookActNoStatus.setOrderBusCode(orderBusCode);
				    	bookActNoStatus.setOrderTime(orderTime);
				    	bookActNoStatus.setRangeBegin(rangeBegin);
				    	bookActNoStatus.setRangeEnd(rangeEnd);
				     }
				    x003.setData(bookActNoStatus);
				    responseJson(x003, response);
				}else if ("X004".equals(transCode)) { //预约取消接口
					BookX003Req x003Req = JsonUtils.json2pojo(reqJson, BookX003Req.class);//同x003共用
					BookX004Resp x004 = new BookX004Resp();
					BookCancel bookCancel = new BookCancel();
					x004.getHead().setChannel(x003Req.getHead().getChannel());
					x004.getHead().setOrgCode(orgCode);
					x004.getHead().setRespDate(DateUtil.getNow().replace(" ", ""));
					x004.getHead().setTransCode(transCode);
					x004.getHead().setTransStatus("0000");
					String result = orderConfigService.bookCancel(x003Req);
					if ("0".equals(result)){
						x004.getHead().setStatusDescribe("取消预约成功");
					} else {
						x004.getHead().setStatusDescribe("取消的预约记录不存在，无法取消");
					}
					x004.setData(bookCancel);
					responseJson(x004, response);
				}
			} catch (Exception e) {
				logger.error("预约请求-将json请求转换成请求对象异常：",e);
				resp.getHead().setTransStatus("9999");
				resp.getHead().setRespDate(DateUtil.getNow().replace(" ", ""));
				resp.getHead().setStatusDescribe("预约请求-将json请求转换成请求对象异常");
				responseJson(resp, response);
				return;
			}
			
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	/**
	 * 返回预约的响应报文
	 * @param obj
	 * @param response
	 */
	private void responseJson(Object obj,HttpServletResponse response){
		String json = "";
		String respPackage = "";
		try {
			json = JsonUtils.obj2json(obj);
			//1.计算整个报文的长度
			byte[] datas = json.getBytes(ENCODE);
			int dataLen = datas.length;
			Formatter formatter = new Formatter();
			String datalenstr = formatter.format("%06d", dataLen).toString();
			respPackage = datalenstr+json;
		} catch (Exception e) {
			logger.error("预约请求响应转换异常：",e);
		}
		
		logger.error("预约请求响应内容json："+respPackage);
		try {
			response.getOutputStream().write(respPackage.getBytes("UTF-8"));
		} catch (UnsupportedEncodingException e) {
			logger.error("响应客户端JSON异常（发送内容编码）：",e);
		} catch (IOException e) {
			logger.error("响应客户端JSON异常：",e);
		}
	}
}
