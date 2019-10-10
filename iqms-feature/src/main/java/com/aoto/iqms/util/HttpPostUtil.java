package com.aoto.iqms.util;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLConnection;
import java.util.HashMap;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.aoto.iqms.externals.models.HallMarket.CustInfoReq;
import com.fasterxml.jackson.databind.JsonNode;


public class HttpPostUtil {
	private final static Logger logger = LoggerFactory.getLogger(HttpPostUtil.class);
	
	/**
	 * 向营销系统请求根据卡类型和卡号获取客户信息
	 * @param checkType
	 * @param custCode
	 * @return
	 */
	public static CustInfoReq getCustNoByHallMarket(String url, String checkType, String custCode){
		Map<String, String> paramsMap = new HashMap<String, String>();
		paramsMap.put("cardType", checkType);
		paramsMap.put("cardNo", custCode);
		String result = HttpPostUtil.sendPostParams(url, paramsMap);
		logger.info("向营销系统请求根据卡类型和卡号获取客户信息："+result);
		CustInfoReq req = new CustInfoReq();
		try {
			req = JsonUtils.json2pojo(result, CustInfoReq.class);
			JsonNode node = JsonUtils.getRoot(result);
			JsonNode codeNode = node.findValue("Error_code");
			req.setError_code(codeNode.asText());
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return req;
	}
	/**
	 * 发送json形式post请求
	 */
	public static String sendPostByJson(String url, Map<String, String> paramsMap ){
		OutputStreamWriter out = null;
        BufferedReader in = null;
        String result = "";
        String params = "";
		if (paramsMap != null && !paramsMap.isEmpty()){
			URL realUrl;
			try {
				params = JsonUtils.obj2json(paramsMap);
				logger.error("请求的json:"+params);
				realUrl = new URL(url);
				// 打开和URL之间的连接
				URLConnection conn = realUrl.openConnection();
				// 设置通用的请求属性
	            conn.setRequestProperty("accept", "*/*");
	            conn.setRequestProperty("connection", "Keep-Alive");
	            conn.setRequestProperty("user-agent",
	                    "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1;SV1)");
	         // 发送POST请求必须设置如下两行
	            conn.setDoOutput(true);
	            conn.setDoInput(true);
	         // 获取URLConnection对象对应的输出流
//	            out = new PrintWriter(conn.getOutputStream());
	            out = new OutputStreamWriter(conn  
	                    .getOutputStream(), "UTF-8"); 
	            // 发送请求参数
//	            out.print(params);
	            out.write(params);
	            // flush输出流的缓冲
	            out.flush();
	            // 定义BufferedReader输入流来读取URL的响应
	            in = new BufferedReader(
	                    new InputStreamReader(conn.getInputStream()));
	            String line;
	            while ((line = in.readLine()) != null) {
	                result += line;
	            }
			} catch (MalformedURLException e1) {
				logger.error("post发送请求异常"+e1);
				e1.printStackTrace();
			} catch (IOException e) {
				logger.error("post发送请求异常"+e);
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}finally{
				try{
	                if(out!=null){
	                    out.close();
	                }
	                if(in!=null){
	                    in.close();
	                }
	            }
	            catch(IOException ex){
	                ex.printStackTrace();
	            }
			}
		}
		return result;
	}
	
	/**
	 * 发送非json形式post请求
	 */
	public static String sendPostParams(String url, Map<String, String> paramsMap ){
//		PrintWriter out = null;
		OutputStreamWriter out = null;
        BufferedReader in = null;
        String result = "";
        String params = "";
		if (paramsMap != null && !paramsMap.isEmpty()){
			StringBuffer sb = new StringBuffer();
			for (Map.Entry<String, String> entry : paramsMap.entrySet()){
				sb.append(entry.getKey()+"=");
				sb.append(entry.getValue()+"&");
			}
			params = sb.toString().substring(0, sb.toString().length()-1);
			URL realUrl;
			try {
				realUrl = new URL(url);
				// 打开和URL之间的连接
				URLConnection conn = realUrl.openConnection();
				// 设置通用的请求属性
	            conn.setRequestProperty("accept", "*/*");
	            conn.setRequestProperty("connection", "Keep-Alive");
	            conn.setRequestProperty("user-agent",
	                    "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1;SV1)");
	            conn.setRequestProperty("Accept-Charset", "UTF-8");
	            conn.setRequestProperty("contentType", "UTF-8");
	         // 发送POST请求必须设置如下两行
	            conn.setDoOutput(true);
	            conn.setDoInput(true);
	         // 获取URLConnection对象对应的输出流
//	            out = new PrintWriter(conn.getOutputStream());
	            out = new OutputStreamWriter(conn  
	                    .getOutputStream(), "UTF-8"); 
	            // 发送请求参数
//	            out.print(params);
	            out.write(params);
	            // flush输出流的缓冲
	            out.flush();
	            // 定义BufferedReader输入流来读取URL的响应
	            in = new BufferedReader(
	                    new InputStreamReader(conn.getInputStream(),"UTF-8"));
	            String line;
	            while ((line = in.readLine()) != null) {
	                result += line;
	            }
			} catch (MalformedURLException e1) {
				logger.error("post发送请求异常"+e1);
				e1.printStackTrace();
			} catch (IOException e) {
				logger.error("post发送请求异常"+e);
				// TODO Auto-generated catch block
				e.printStackTrace();
			}finally{
				try{
	                if(out!=null){
	                    out.close();
	                }
	                if(in!=null){
	                    in.close();
	                }
	            }
	            catch(IOException ex){
	                ex.printStackTrace();
	            }
			}
		}
		return result;
	}
	public static void main(String[] args) {
		
//		Map<String, String> paramsMap = new HashMap<String, String>();
		//2.1厅堂易请求排管系统获取相应网点和子系统对应的排队机上的可办理的业务列表
//		paramsMap.put("operation", "findBusys");
//		paramsMap.put("param", "{"+"\"orgCode\":\"1\","+"\"deviceNo\":\"qms_1_22\""+"}");
		
		//2.2 直接取号
//		paramsMap.put("operation", "pickTicketByPwd");
//		paramsMap.put("param", "{"+"\"orgCode\":\"111\","+"\"deviceNo\":\"qms_2468_84\","+"\"custLevel\":\"2\","+"\"busType\":\"261\","+"\"busCode\":\"P\","+"\"smsSned\":\"1\","+"\"phoneNo\":\"15811112222\""+"}");
		
		//2.3身份识别取号
		/*paramsMap.put("operation", "pTByIdentity");
		paramsMap.put("param", "{"+"\"orgCode\":\"1\","+"\"deviceNo\":\"qms_1_22\","
				+ ""+"\"certType\":\"2\","+"\"certNo\":\"261\","+"\"busType\":\"261\","
						+ ""+"\"busCode\":\"1\","+"\"smsSned\":\"1\","+"\"phoneNo\":\"15811112222\""+"}");*/
		//2.4更新号票状态
//		paramsMap.put("operation", "updateTicketStatus");
//		paramsMap.put("param", "{"+"\"orgCode\":\"111\","+"\"deviceNo\":\"qms_2468_84\","
//				+ ""+"\"ticketNo\":\"P3001\","+"\"status\":\"3\""+"}");
		//2.5号票转移
		/*paramsMap.put("operation", "busTransfer");
		paramsMap.put("param", "{"+"\"orgCode\":\"1\","+"\"deviceNo\":\"qms_1_22\","
				+ ""+"\"ticketNo\":\"2\","+"\"busType\":\"261\","
				+ ""+"\"busCode\":\"1\","+"\"custLevel\":\"1\","+"\"isCreateT\":\"15811112222\""+"}");
		String result = HttpPostUtil.sendPostParams("http://172.16.210.181:8081/iqms/padService", paramsMap);*/
		//3.1客户信息查询
		HttpPostUtil.getCustNoByHallMarket("http://172.16.210.203:8880/marketing/services/manage/cust/custDisting","3", "340223199401085119");
		
		Map<String, String> paramsMap = new HashMap<String, String>();
		//-------------------------------1.1--------------------------------------------
//		paramsMap.put("custNo", "888888");
//		paramsMap.put("orgCode", "1");
//		paramsMap.put("deviceNo", "qms_1_22");
//		String result = HttpPostUtil.sendPostParams("http://172.16.210.133:8080/HallMarket/service/custCardArrival", paramsMap);
		//-------------------------------1.2--------------------------------------------
//		paramsMap.put("busType", "262");
//		paramsMap.put("busCode", "G");
//		paramsMap.put("busTypeName", "个人业务");
//		paramsMap.put("flowNo", "2468qms_2468_8420180208G2001");
//		paramsMap.put("ticketNo", "G2001");
//		paramsMap.put("status", "1");
//		paramsMap.put("printTime", "");
//		paramsMap.put("callTime", "2017-12-25 17:11:21");
//		paramsMap.put("endTime", "2017-12-25 17:11:21");
//		paramsMap.put("appValue", "2");
//		paramsMap.put("winNo", "1");
//		paramsMap.put("tellerNo", "34432");
//		paramsMap.put("tellerName", "亚索");
//		paramsMap.put("custNo", "");
//		paramsMap.put("orgCode", "111");
//		paramsMap.put("deviceNo", "qms_2468_84");
//		String result = HttpPostUtil.sendPostParams("http://172.16.210.203:8080/HallMarket/service/custTicketArrival", paramsMap);
		//-------------------------------1.3--------------------------------------------
//		paramsMap.put("orgCode", "111");
//		paramsMap.put("deviceNo", "qms_2468_84");
//		paramsMap.put("createTime", "13:57:50");
//		paramsMap.put("warnTypeId", "2");
//		paramsMap.put("warnContent", "1号窗口有差评");
//		String result = HttpPostUtil.sendPostParams("http://172.16.210.203:8080/HallMarket/service/manage/warn", paramsMap);
//		String result = HttpPostUtil.sendPostParams("http://172.16.210.181:8081/iqms/padService", paramsMap);
		
//		System.out.println("result:"+result);
		
	}
}
