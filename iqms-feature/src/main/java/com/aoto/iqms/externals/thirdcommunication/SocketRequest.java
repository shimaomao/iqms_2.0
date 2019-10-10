package com.aoto.iqms.externals.thirdcommunication;

import java.io.ByteArrayOutputStream;
import java.io.DataInputStream;

import java.io.DataOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InterruptedIOException;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.ConnectException;
import java.net.InetAddress;
import java.net.InetSocketAddress;
import java.net.Socket;
import java.net.SocketAddress;
import java.net.SocketTimeoutException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Formatter;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.apache.commons.io.IOUtils;
import org.apache.commons.lang.time.DateFormatUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.BeanFactory;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.aoto.iqms.util.FileUtils;
import com.aoto.iqms.util.HttpPostUtil;
import com.aoto.iqms.util.JsonUtils;
import com.aoto.iqms.util.PropetiesLoader;
import com.aoto.iqms.basicconfig.service.inf.BusinessManageService;
import com.aoto.iqms.basicconfig.service.inf.NearService;
import com.aoto.iqms.basicconfig.service.inf.OrderConfigService;
import com.aoto.iqms.basicconfig.service.inf.TellerService;
import com.aoto.iqms.businessconfig.models.BscBranchBusinessQuery;
import com.aoto.iqms.businessconfig.models.BscDeviceModel;
import com.aoto.iqms.businessconfig.service.impl.TicketFormServiceImpl;
import com.aoto.iqms.businessconfig.service.inf.BscBranchBusinessService;
import com.aoto.iqms.businessconfig.service.inf.BscCustLevelService;
import com.aoto.iqms.businessconfig.service.inf.BscCustRecognitionService;
import com.aoto.iqms.businessconfig.service.inf.BscDeviceService;
import com.aoto.iqms.businessconfig.service.inf.BscWinConfigService;
import com.aoto.iqms.businessconfig.service.inf.CallStrategyService;
import com.aoto.iqms.businessconfig.service.inf.SysOrgExtendService;
import com.aoto.iqms.businessconfig.service.inf.TicketFormService;
import com.aoto.iqms.businessconfig.service.inf.TakeConfigService;
import com.aoto.iqms.externals.dealprocess.BookActiveProcess;
import com.aoto.iqms.externals.dealprocess.BookBandProcess;
import com.aoto.iqms.externals.dealprocess.CustIdentityProcess;
import com.aoto.iqms.externals.dealprocess.DeviceHeartbeatProcess;
import com.aoto.iqms.externals.dealprocess.DeviceRegistProcess;
import com.aoto.iqms.externals.dealprocess.MsgSendProcess;
import com.aoto.iqms.externals.dealprocess.PatchDlConfirmProcess;
import com.aoto.iqms.externals.dealprocess.TellerSyncProcess;
import com.aoto.iqms.externals.models.RespHeader;
import com.aoto.iqms.externals.models.HallMarket.CustInfoReq;
import com.aoto.iqms.externals.models.deviceregist.DeviceRegistResp;
import com.aoto.iqms.externals.models.flowdata.FlowData;
import com.aoto.iqms.externals.models.flowdata.FlowDataResp;
import com.aoto.iqms.externals.service.inf.ResourceService;
import com.aoto.iqms.util.SpringContextUtil;
import com.aoto.iqms.util.testdata.HttpJsonData;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
/**
 * 〈一句话功能简述〉 〈功能详细描述〉
 * 
 * @author jiangp
 * @see [相关类/方法]（可选）
 * @since [产品/模块版本] （必须）
 */
public class SocketRequest implements Runnable {
	private static final Logger logger = LoggerFactory
			.getLogger(SocketRequest.class);
	private Socket socket;
	private ResourceService resourceService;
	private BscBranchBusinessService branchBusinessService;
	private BscWinConfigService winConfigService;
	private CallStrategyService callStrategyService;
	private TakeConfigService takeConfigService;
	private BscCustLevelService bscCustLevelService;
	private BscCustRecognitionService bscCustRecognitionService;
	private TellerService tellerService;
	private TicketFormService tktFormService;
	private NearService nearService;
	private OrderConfigService orderService;
	private BusinessManageService businessService;
	private SysOrgExtendService orgService;
	private String requestIp = "";
	
	private final String  ENCODE = "GBK";

	public SocketRequest(Socket request) {
		this.socket = request;
		resourceService = (ResourceService)SpringContextUtil.getBean("resourceServiceImp");
		branchBusinessService = (BscBranchBusinessService)SpringContextUtil.getBean("bscBranchBusinessServiceImpl");
		winConfigService = (BscWinConfigService)SpringContextUtil.getBean("bscWinConfigServiceImpl");
		callStrategyService = (CallStrategyService)SpringContextUtil.getBean("callStrategyServiceImpl");
		takeConfigService = (TakeConfigService)SpringContextUtil.getBean("takeConfigServiceImpl");
		bscCustLevelService = (BscCustLevelService)SpringContextUtil.getBean("bscCustLevelServiceImpl");
		bscCustRecognitionService = (BscCustRecognitionService)SpringContextUtil.getBean("bscCustRecognitionServiceImpl");
		tellerService = (TellerService)SpringContextUtil.getBean("tellerServiceImpl");
		tktFormService = (TicketFormService)SpringContextUtil.getBean("ticketFormServiceImpl");
		nearService = (NearService)SpringContextUtil.getBean("nearServiceImpl");
		orderService = (OrderConfigService)SpringContextUtil.getBean("orderConfigServiceImpl");
		businessService = (BusinessManageService)SpringContextUtil.getBean("businessManageServiceImpl");
		orgService = (SysOrgExtendService)SpringContextUtil.getBean("sysOrgExtendServiceImpl");
	}

	@Override
	public void run() {
		DataInputStream input = null;
		DataOutputStream output = null;
		InputStream in = null;
		OutputStream out = null;

		try {
			// 获取客户端上传的数据流对象
			in = socket.getInputStream();
			out = socket.getOutputStream();
			
			SocketAddress clientAddress = socket.getRemoteSocketAddress();
			InetAddress ipAdder = socket.getInetAddress();
			
			String clientReqIp = clientAddress.toString();
			requestIp = ipAdder.toString().replace("/", "");
			logger.error("客户端请求的ip地址： "+ requestIp);
			logger.error("客户端请求的ip地址及端口： "+ clientReqIp);
			
			byte[] packLen = new byte[6];
			int len = in.read(packLen, 0, 6);
			if (len != 6) {
				return;
			}
			
			logger.error("【SocketRequest】-->-------------------------处理请求开始-----------------------。");
			
			int reqLen = Integer.parseInt(new String(packLen, ENCODE));
			logger.error("【SocketRequest 】-->解析的到数据长度为：" + reqLen);
			// 创建报文数组
			byte[] datas = new byte[reqLen];
			// 将输入流中的数据读入到报文数组中
			int exclen = in.read(datas, 0, reqLen);
			if (exclen != reqLen) {
				logger.error("【SocketRequest fail】-->实际获取到的报文字节数和指定的字节数不相等，获取到的字节数："
						+ exclen + "  指定获取的字节数：" + reqLen);
				String errInfo = "A000|9999|获取到的长度和实际长度不符合";
				responseClient(out,errInfo);
				return;
			}
			String packageData = new String(datas, ENCODE);
			logger.error("【SocketRequest】-->请求的数据内容为：" + packageData);
			//zhousj 下载文件
			String respJson = "";
			//报文解析异常时的信息
			StringBuilder sb = new StringBuilder("{");
										sb.append("\"head\":{");
									        sb.append("\"transCode\":\"\",");
									        sb.append("\"transDateTime\":\""+DateFormatUtils.format(new Date(), "yyyy-MM-dd HH:mm:ss")+"\",");
									        sb.append("\"transStatus\":\"9999\",");
			//解析报文获取交易码
			JsonNode rootNode = JsonUtils.getRoot(packageData);
			if (rootNode == null) {
				 sb.append("\"transDescription\":\"【SocketRequest】请求json解析异常\"");
				    sb.append("}}");
				logger.info("【SocketRequest】请求json解析异常："+packageData);
				respJson = sb.toString();
			}
			
			JsonNode transCodeNode = rootNode.findValue("transCode"); //
			if (transCodeNode == null ){
				sb.append("\"transDescription\":\"【SocketRequest】请求的json格式正确，缺少节点transCode\"");
			    sb.append("}}");
				logger.info("【SocketRequest】请求的json格式正确，缺少节点transCode："+packageData);
				respJson = sb.toString();
			}
			
			//获取交易码成功
			String  transCode = transCodeNode.textValue();
			logger.info("【SocketRequest】transCode："+transCode);
			//
			if(transCode.equals("D004")){
				byte[] bytes = dealRequest2(packageData,out);
			}else{
				// 解析请求数据
				respJson = dealRequest(packageData);
				
				// 响应数据
				responseClient(out, respJson);
			}

			logger.error("【SocketRequest】-->-------------------------处理请求结束-----------------------。");

		} catch (Exception e) {
			logger.error("SocketRequest run error", e);
		} finally {
			IOUtils.closeQuietly(in);
			IOUtils.closeQuietly(out);
			//IOUtils.closeQuietly(input);
			//IOUtils.closeQuietly(output);
			IOUtils.closeQuietly(socket);
		}
	}

	/**
	 * 响应客户端数据
	 * 
	 * @param out
	 * @param responseText
	 */
	private void responseClient(OutputStream out, String respJson) {
		try {
			
			//1.计算整个报文的长度
			byte[] datas = respJson.getBytes(ENCODE);
			int dataLen = datas.length;
			Formatter formatter = new Formatter();
			String datalenstr = formatter.format("%06d", dataLen).toString();
			String respPackage = datalenstr+respJson;
			logger.error("SocketRequest返回客户端报文："+respPackage);
			
			//返回的字节数据：
			byte[] destMsg = respPackage.getBytes(ENCODE);
			out.write(destMsg);
		} catch (Exception e) {
			logger.error("SocketRequest数据发送到客户端异常：" + e);
		}
	}
	/**
	 * 处理客户请求 返回byte 数组
	 * @param reqJson
	 * @return
	 */
	private byte[] dealRequest2(String reqJson,OutputStream output){
		//解析报文获取交易码
		JsonNode rootNode = JsonUtils.getRoot(reqJson);
		//机构id
		String orgId = rootNode.findValue("transNet").textValue();
		//设备号
		String deviceNo =  rootNode.findValue("deviceId").textValue();
		BscBranchBusinessQuery model = new BscBranchBusinessQuery();
		model.setOrgId(orgId);model.setDeviceNo(deviceNo);
		//创建.json文件返回文件路径
		String path = branchBusinessService.createBuzList(model);
		winConfigService.createCounters(model,path);
		callStrategyService.createCounterBuzs(model,path);
		takeConfigService.createTakeConfig(model,path);
		bscCustLevelService.createCustLevels(model,path);
		bscCustRecognitionService.createCustRecs(model,path);
		tellerService.createTellers(model,path);
		tktFormService.createTktFormats(model,path);
		//创建orgId_deviceNo.zip
		String name = model.getOrgId()+"_"+model.getDeviceNo()+".zip";
		
		logger.debug("配置下载，path位置："+path);
		logger.debug("配置下载，配置包名称："+name);
		String path2 = path+File.separator+model.getOrgId()+"_"+model.getDeviceNo();
		try {
			logger.debug("配置下载，path2位置："+name);
			//生成压缩包
			FileUtils.createZip(path+File.separator+"temp", path+File.separator+model.getOrgId()+"_"+model.getDeviceNo(),name);
			//删除temp目录
			File file = new File(path+File.separator+"temp");
			FileUtils.deleteFile(file);
			
			//将zip包下发
	        ByteArrayOutputStream out = new ByteArrayOutputStream();
	        String zipPath = path2+File.separator+name;
	        logger.debug("配置下载，zipPath位置："+zipPath);  
	        
	        file = new File(zipPath);
	        FileInputStream fin = new FileInputStream(file);
	         
	        int read;
	        byte[] bytes=new byte[1024];
	        while((read = fin.read(bytes)) >0){
	            out.write(bytes, 0, read); 
	            output.write(bytes, 0, read);
	        }
	        fin.close();
	         
	        bytes = out.toByteArray(); // 全部的字节数组了。
	        out.close();
	        output.close();
	        return bytes;
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return new byte[0];
	}

	/**
	 * 处理客户端请求
	 * 
	 * @return
	 */
	private String dealRequest(String reqJson) {
		
		//报文解析异常时的信息
		StringBuilder sb = new StringBuilder("{");
									sb.append("\"head\":{");
								        sb.append("\"transCode\":\"\",");
								        sb.append("\"transDateTime\":\""+DateFormatUtils.format(new Date(), "yyyy-MM-dd HH:mm:ss")+"\",");
								        sb.append("\"transStatus\":\"9999\",");
		
		//解析报文获取交易码
		JsonNode rootNode = JsonUtils.getRoot(reqJson);
		if (rootNode == null) {
			 sb.append("\"transDescription\":\"【SocketRequest】请求json解析异常\"");
			    sb.append("}}");
			logger.info("【SocketRequest】请求json解析异常："+reqJson);
			return sb.toString();
		}
		
		JsonNode transCodeNode = rootNode.findValue("transCode"); //
		if (transCodeNode == null ){
			sb.append("\"transDescription\":\"【SocketRequest】请求的json格式正确，缺少节点transCode\"");
		    sb.append("}}");
			logger.info("【SocketRequest】请求的json格式正确，缺少节点transCode："+reqJson);
			return sb.toString();
		}
		
		//获取交易码成功
		String  transCode = transCodeNode.textValue();
		logger.info("【SocketRequest】transCode："+transCode);
		boolean bookFlag = PropetiesLoader.getSystemConfig().getBoolean("isbook");
		//设备注册
		if (transCode.equals("S001")){
			long startMill = System.currentTimeMillis();
			logger.info("【SocketRequest】：开始执行登记设备新查询：");
			DeviceRegistProcess deviceRegistProcess = new DeviceRegistProcess();
			String  deviceRegistRespJson =  deviceRegistProcess.registDevice(
					resourceService, requestIp, transCode);
			logger.info("【SocketRequest】：设备信息查询执行完成：");
			long endMill = System.currentTimeMillis();
			logger.info("【设备注册总耗时】："+(endMill-startMill)+"ms");
			return deviceRegistRespJson;
		} 
		
		//流水数据保存
		if (transCode.equals("A002")){
			long startMill = System.currentTimeMillis();
			logger.debug("【SocketRequest】：开始执行流水数据上报：");
			String respJson = trxTodaySave(transCode,rootNode);
			logger.debug("【SocketRequest】：流水数据上报执行完成：");
			long endMill = System.currentTimeMillis();
			logger.debug("【流水数据上报总耗时】："+(endMill-startMill)+"ms");
			return respJson;
		}
		
		//设备心跳上送
		if (transCode.equals("D001")){
			long startMill = System.currentTimeMillis();
			logger.info("【SocketRequest】：设备心跳开始处理：");
			DeviceHeartbeatProcess deviceHeartbeatProcess = new DeviceHeartbeatProcess();
			String respJson = deviceHeartbeatProcess.dealDeviceHeartbeat(resourceService, transCode, rootNode);
			logger.info("【SocketRequest】：设备心跳处理结束：");
			long endMill = System.currentTimeMillis();
			logger.info("【心跳处理总耗时】："+(endMill-startMill)+"ms");
			return respJson;
		}
		
		
		//客户端端更新包下载下载确认
		if (transCode.equals("D002")){
			long startMill = System.currentTimeMillis();
			logger.info("【SocketRequest】：客户端更新包下载确认开始处理：");
			PatchDlConfirmProcess patchDlConfirmProcess = new PatchDlConfirmProcess();
			String respJson = patchDlConfirmProcess.patchDlConfirm(resourceService, transCode, rootNode);
			logger.info("【SocketRequest】：客户端更新包下载确认处理结束：");
			long endMill = System.currentTimeMillis();
			logger.info("【心跳处理总耗时】："+(endMill-startMill)+"ms");
			return respJson;
		}
		
		
		//客户端配置更新确认
		if (transCode.equals("D003")){
			long startMill = System.currentTimeMillis();
			logger.info("【SocketRequest】：客户端配置更新确认开始处理：");
			PatchDlConfirmProcess patchDlConfirmProcess = new PatchDlConfirmProcess();
			String respJson = patchDlConfirmProcess.patchDlConfirm(resourceService, transCode, rootNode);
			logger.info("【SocketRequest】：客户端配置更新确认确认处理结束：");
			long endMill = System.currentTimeMillis();
			logger.info("【心跳处理总耗时】："+(endMill-startMill)+"ms");
			return respJson;
		}
		
		
		//客户识别
		if (transCode.equals("A001")){
			long startMill = System.currentTimeMillis();
			logger.info("【SocketRequest】：客户识别，开始处理：");
			CustIdentityProcess custIdentityProcess = new CustIdentityProcess();
			String respJson = custIdentityProcess.identityCust(resourceService, transCode, rootNode);
			logger.info("【SocketRequest】：客户识别处理结束");
			long endMill = System.currentTimeMillis();
			logger.info("【客户识别总耗时】："+(endMill-startMill)+"ms");
			return respJson;
		}
		//预约激活
		if (transCode.equals("Y001")){
			if(bookFlag){
				long startMill = System.currentTimeMillis();
				logger.info("【SocketRequest】：预约激活，开始本地处理：");
				BookActiveProcess bookActiveProcess = new BookActiveProcess();
				String respJson = bookActiveProcess.activeOrder(orderService, transCode, rootNode);
				logger.info("【SocketRequest】：预约激活本地处理结束");
				long endMill = System.currentTimeMillis();
				logger.info("【预约激活总耗时】："+(endMill-startMill)+"ms");
				return respJson;
			}else{
				long startMill = System.currentTimeMillis();
				logger.info("【SocketRequest】：预约激活，开始处理：");
				BookActiveProcess bookActiveProcess = new BookActiveProcess();
				String respJson = bookActiveProcess.activeBookCode(resourceService, transCode, rootNode);
				logger.info("【SocketRequest】：预约激活处理结束");
				long endMill = System.currentTimeMillis();
				logger.info("【预约激活总耗时】："+(endMill-startMill)+"ms");
				return respJson;
			}
		}
		//预约绑定（济宁银行）
		if (transCode.equals("Y002")){
			if (bookFlag){
				long startMill = System.currentTimeMillis();
				logger.info("【SocketRequest】：预约绑定，开始本地处理：");
				BookBandProcess bookBandProcess = new BookBandProcess();
				String respJson = bookBandProcess.bandOrderInfo(orderService, transCode, rootNode);
				logger.info("【SocketRequest】：预约绑定本地处理结束");
				long endMill = System.currentTimeMillis();
				logger.info("【预约绑定总耗时】："+(endMill-startMill)+"ms");
				return respJson;
			} else {
				long startMill = System.currentTimeMillis();
				logger.info("【SocketRequest】：预约绑定，开始esb处理：");
				BookBandProcess bookBandProcess = new BookBandProcess();
				String respJson = bookBandProcess.bandBookCode(resourceService, transCode, rootNode);
				logger.info("【SocketRequest】：预约绑定esb处理结束");
				long endMill = System.currentTimeMillis();
				logger.info("【预约绑定总耗时】："+(endMill-startMill)+"ms");
				return respJson;
			}
		}
		
		
		//短信提醒
		if (transCode.equals("C001")){
			long startMill = System.currentTimeMillis();
			logger.info("【SocketRequest】：短信提醒，开始处理：");
			MsgSendProcess msgSendProcess  = new MsgSendProcess();
			String respJson = msgSendProcess.sendMsgContent(resourceService, transCode, rootNode);
			logger.info("【SocketRequest】：短信提醒处理结束");
			long endMill = System.currentTimeMillis();
			logger.info("【短信提醒总耗时】："+(endMill-startMill)+"ms");
			return respJson;
		}
		
		//柜员同步
		if (transCode.equals("C002")){
			long startMill = System.currentTimeMillis();
			logger.info("【SocketRequest】：柜员同步，开始处理：");
			TellerSyncProcess tellerSyncProcess = new TellerSyncProcess();
			String respJson = tellerSyncProcess.syncTeller(resourceService, transCode, rootNode);
			logger.info("【SocketRequest】：柜员同步，处理结束");
			long endMill = System.currentTimeMillis();
			logger.info("【柜员同步总耗时】："+(endMill-startMill)+"ms");
			return respJson;
		}
		//临近网点
		if (transCode.equals("D005")){
			long startMill = System.currentTimeMillis();
			logger.info("【SocketRequest】：临近网点，开始处理：");
			String orgId = rootNode.findValue("transNet").textValue();
			String respJson = nearService.createNearsJson(orgId,transCode);
			logger.info("【SocketRequest】：临近网点，处理结束");
			long endMill = System.currentTimeMillis();
			logger.info("【临近网点总耗时】："+(endMill-startMill)+"ms");
			return respJson;
		}
		
		//更新设备的配置更新状态
		if (transCode.equals("D006")){
			long startMill = System.currentTimeMillis();
			logger.info("【SocketRequest】：更新设备配置状态，开始处理：");
			String deviceId = rootNode.findValue("deviceId").textValue();
			String updateFlag = rootNode.findValue("updateFlag").textValue();
			resourceService.updateDeviceConfigFlag(deviceId,updateFlag);
			String respJson = "{"+
				    "\"head\":{"+
			        "\"transCode\":\""+transCode+"\","+
			        "\"transDateTime\":\""+DateFormatUtils.format(new Date(), "yyyy-MM-dd HH:mm:ss")+"\","+
			        "\"transStatus\":\"0000\","+
			        "\"transDescription\":\"\""+
			    "}"+
			"}";
			logger.info("【SocketRequest】：更新设备配置状态结束");
			long endMill = System.currentTimeMillis();
			logger.info("【更新设备配置状态】："+(endMill-startMill)+"ms");
			return respJson;
		}
		
		//交易码不存在
		sb.append("\"transDescription\":\"【SocketRequest】非法的交易码，无法对请求进行处理"+transCode+"\"");
	    sb.append("}}");
		return sb.toString();
		
	}
	
	/**
	 * 流水数据保存
	 * @param transCode
	 * @param json
	 * @return
	 */
	public String trxTodaySave(String transCode,JsonNode root){
		FlowDataResp flowDataResp = new FlowDataResp();
		//响应信息
		flowDataResp.getHead().setTransCode(transCode);
		flowDataResp.getHead().setTransDateTime(DateFormatUtils.format(new Date(), "yyyy-MM-dd HH:mm:ss"));
		
		//1.获取数据部分的报文
		JsonNode dataNode = root.findValue("data");
		if (dataNode == null) {
			flowDataResp.getHead().setTransStatus("9999");
			flowDataResp.getHead().setTransDescription("流水数据上报异常：没有发现data节点数据");
		} else {
			String dataJson = dataNode.toString();
			try {
				FlowData flowData = JsonUtils.json2pojo(dataJson, FlowData.class);
				logger.info("流水上报数据："+flowData.toString());
				if(PropetiesLoader.getSystemConfig().getBoolean("isHallMarket")){//排队机客户号票到达接口
					String custNo = "";
					if(flowData.getFetchType().equals("01")||//刷二代证取票01，刷卡取票02，刷存折03
							flowData.getFetchType().equals("02")||
								flowData.getFetchType().equals("03")||
								flowData.getFetchType().equals("05")){
						String url = PropetiesLoader.getSystemConfig().getString("HallMarket.YX.IP")+
								PropetiesLoader.getSystemConfig().getString("HallMarket.custInfo");
						String cardType = "1";
						//转换为营销系统需要的类型 1为银行卡，2为存折，3为身份证
						if(flowData.getMediaType().equals("02")){
							cardType = "3";
						}else if(flowData.getMediaType().equals("03")){
							cardType = "2";
						}
						CustInfoReq custInfo = HttpPostUtil.getCustNoByHallMarket(url,cardType, flowData.getCertNo());
						custNo = custInfo.getCustNo()==null?"":custInfo.getCustNo();
					}
					String appValue = flowData.getRate();
					String deviceNo = flowData.getDeviceId();
					String orgCode = orgService.findOrgByOrgId(flowData.getTransNet()).getOrgCode();
					String busType = flowData.getBuzTypeId();
					String busCode = flowData.getBuzCode();
					String busTypeName = businessService.findBusManageById(busType).get(0).get("businessName").toString();
					String ticketNo = flowData.getTickNo();
					String status = flowData.getTickNoStatus();
					String fetchType = flowData.getFetchType();
					List<Object> tkstatus = PropetiesLoader.getSystemConfig().getList("HallMarket.tkstatus");
					for(int i = 0; i < tkstatus.size(); i++){
						String[] strs = tkstatus.get(i).toString().split(":");
						if(strs[0].equals(status)){
							status = strs[1];
						}
					}
					//如果为取号状态且号票号码第一位同业务代码不同则为转移号票
					if((!ticketNo.substring(0, 1).equals(busCode))&&status.equals("0")){
						status = "9";
					}
					String printTime = flowData.getFetchedDate();
					String callTime = flowData.getCalledDate();
					String endTime = flowData.getFinishedDate();
					String winNo = flowData.getCounterNo();
					String tellerNo = flowData.getTellerNo();
					List<Map<String, Object>> tellerNameList = new ArrayList<>();
					if(tellerNo!=null){
						tellerNameList = tellerService.findTellerByWorkId(tellerNo);
					}
					String tellerName = (tellerNameList.size() == 0
							?"":tellerNameList.get(0).get("name_").toString());
					String flowNo = flowData.getFlowId();
					if(appValue.equals("1")){
						Map<String, String> map = new HashMap<String, String>();
						map.put("orgCode", orgCode);
						map.put("deviceNo", deviceNo);
						map.put("createTime", endTime);
						map.put("warnTypeId", "2");
						map.put("warnContent", winNo+"号窗口有客户差评，请处理");
						logger.info("排管系统向厅堂易发起差评警告请求:orgCode:"+orgCode+"deviceNo:"+deviceNo+"createTime:"+endTime+"warnTypeId:2"+
						"warnContent:"+winNo+"号窗口有客户差评，请处理");
						String url = PropetiesLoader.getSystemConfig().getString("HallMarket.TTY.IP")+
								PropetiesLoader.getSystemConfig().getString("HallMarket.WARN");
						String result = HttpPostUtil.sendPostParams(url, map);
						logger.info("排管系统向厅堂易发起差评警告请求，返回："+result);
					}else{
						appValue = "";
					}
					Map<String, String> paramsMap = new HashMap<String, String>();
					paramsMap.put("busType", busType);
					paramsMap.put("busCode", busCode);
					paramsMap.put("busTypeName", busTypeName);
					paramsMap.put("ticketNo", ticketNo);
					paramsMap.put("status", status);
					paramsMap.put("printTime", printTime);
					paramsMap.put("callTime", callTime);
					paramsMap.put("endTime", endTime);
					paramsMap.put("appValue", appValue);
					paramsMap.put("winNo", winNo);
					paramsMap.put("tellerNo", tellerNo);
					paramsMap.put("tellerName", tellerName);
					paramsMap.put("custNo", custNo);
					paramsMap.put("orgCode", orgCode);
					paramsMap.put("deviceNo", deviceNo);
					paramsMap.put("flowNo", flowNo);
					paramsMap.put("fetchTicketType",fetchType.substring(1, 2));
					logger.info("向厅堂易系统发起客户号票到达请求："+paramsMap.toString());
					String url = PropetiesLoader.getSystemConfig().getString("HallMarket.TTY.IP")+
							PropetiesLoader.getSystemConfig().getString("HallMarket.custTicketArrival");
					String result = HttpPostUtil.sendPostParams(url, paramsMap);
					logger.info("向厅堂易系统发起客户号票到达请求，返回："+result);
					}
					
				String result = resourceService.insertTrxtodayProc(flowData);
				if (result.equals("成功")){
					flowDataResp.getHead().setTransStatus("0000");
					flowDataResp.getHead().setTransDescription("流水数据上报成功");
				} else {
					flowDataResp.getHead().setTransStatus("9999");
					flowDataResp.getHead().setTransDescription("流水数据保存失败");
				}
				
			} catch (Exception e) {
				flowDataResp.getHead().setTransStatus("9999");
				flowDataResp.getHead().setTransDescription("流水数据上报异常：data节点json数据转换成流水数据对象异常");
			}
		}
		
		//转换成json
		String json = "";
		try {
			json = JsonUtils.obj2json(flowDataResp);
			logger.debug("flowdata：流水数据报，封装返回信息="+json);
		} catch (Exception e) {
			logger.debug("flowdata：流水数据报，将返回信息转换成json异常。",e);
			json = "{"+
			    "\"head\":{"+
			        "\"transCode\":\""+transCode+"\","+
			        "\"transDateTime\":\""+DateFormatUtils.format(new Date(), "yyyy-MM-dd HH:mm:ss")+"\","+
			        "\"transStatus\":\"9999\","+
			        "\"transDescription\":\"flowdata：流水数据报，返回对象信息转换成json异常\""+
			    "}"+
			"}";
		}
		return json;
	}
	
	/**
	 * 测试信息
	 * @param args
	 */
	public static void main(String[] args) {
		String str = "{"+
					    "\"head\":{"+
					        "\"transCode\":\"F001\","+
					"\"transDateTime\":\"2017-7-9 10:18:17\","+
					"\"transStatus\":\"0000\","+
					"\"transDescription\":\"成功\""+
					    "},"+
					    "\"data\":{"+
					        "\"buzlist\":["+
					           "{\"buztype\":\"A\",\"cnname\":\"个人业务\",\"waitno\":\"2\"},"+
					   "{\"buztype\":\"V\",\"cnname\":\"会员业务\",\"waitno\":\"0\"},"+
					   "{\"buztype\":\"G\",\"cnname\":\"国外业务\",\"waitno\":\"0\"}"+
					  "]"+
					    "}"+
					"}";
		
		JsonNode rootNode = JsonUtils.getRoot(str);
		JsonNode buzlistNode = rootNode.findValue("buzlist"); //
		
		Iterator<JsonNode> jsonNodes = buzlistNode.elements();
		while (jsonNodes.hasNext()){
			JsonNode jn = jsonNodes.next();
			System.out.println(jn.get("buztype").asText());
		}
	}
	
}
