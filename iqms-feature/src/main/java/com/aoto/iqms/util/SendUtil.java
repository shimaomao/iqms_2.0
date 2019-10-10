package com.aoto.iqms.util;

import java.io.IOException;
import java.io.InputStream;
import java.io.InterruptedIOException;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.ConnectException;
import java.net.InetSocketAddress;
import java.net.Socket;
import java.net.SocketTimeoutException;
import java.util.Formatter;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.aoto.iqms.externals.models.EsbServiceResp;
import com.aoto.iqms.externals.thirdcommunication.EsbRequest;

/**
 * socket 发送通用方法
 * @author hongxz
 *
 */
public class SendUtil {
	
	private static final Logger logger = LoggerFactory.getLogger(SendUtil.class);
	
	/**
     * 向排队机发送请求报文（预约）
     * @param msg
     * @param ipAddr
     * @return
     */
    public static String socketSendData(String msg,String ipAddr, int port,EsbServiceResp esbServiceResp,String ENCODE,int headerLen){
    	long startMill = System.currentTimeMillis();
    	try {
			String fmtMsg = formatData(msg,headerLen,ENCODE);
			byte[] destMsg = fmtMsg.getBytes(ENCODE);
			//定义个一个用于接收返回数据的报文数组
			byte[] bRecvBuf = new byte[8192];
			//获取远程取号的等级
			int socketConnTimes = PropetiesLoader.getSystemConfig().getInt("socketConnTimes", 2);
			//int socketConnTimes = 2;
			logger.info("【socketSendData】socket连接失败重连次数配置："+socketConnTimes);
			int nErr = sendMsg(ipAddr,port,destMsg,destMsg.length,bRecvBuf,1, esbServiceResp,headerLen,ENCODE);
			if (nErr > 0){
				String pdjResp = new String(bRecvBuf,0,nErr,ENCODE);
				//logger.info("第三方返回的："+pdjResp);
				long endMill = System.currentTimeMillis();
				logger.info("调用socket接口耗时【成功】："+(endMill-startMill)+"ms");
				return pdjResp;
			}
			long endMill = System.currentTimeMillis();
			logger.info("调用socket接口耗时【无数据返回】："+(endMill-startMill)+"ms");
		}catch(Exception e){
			logger.info("第三方通讯异常：",e);
			esbServiceResp.setStatus("FAIL");
			esbServiceResp.setCode("3001");
			esbServiceResp.setDesc("和第三方通讯异常");
			long endMill = System.currentTimeMillis();
			logger.info("调用socket接口耗时【异常】："+(endMill-startMill)+"ms");
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
	 * @param esbServiceResp esb的信息
	 * @param headerLen 头部长度
	 * @param encode 字符编码
	 * @return -1失败， >0成功
	 */
	public static int sendMsg(String ip,int port,byte[] content, int len, byte[] bRecvBuf, int nTimeOut,EsbServiceResp esbServiceResp,int headerLen,String encode){
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
					int nPacketLen = is.read(bRecvBuf, 0, headerLen);
					if (nPacketLen != headerLen){
						logger.error("接收数据异常：耗时："+(System.currentTimeMillis()-timeStart)+"nPacketLen===="+nPacketLen);
						esbServiceResp.setStatus("FAIL");
						esbServiceResp.setCode("3003");
						esbServiceResp.setDesc("读取排队机返回报文的长度异常。");
						break;
					}
					
					//获取返回报文的长度
					String dataLenStr = new String(bRecvBuf, 0, headerLen, encode);
					int dataLen = Integer.parseInt(dataLenStr);
					//判断服务端返回的数据是否超过了接收数据的数组长度
					if ((dataLen+headerLen) > (bRecvBuf.length)){
						logger.error("服务端返回数据的长度，超过了接收缓冲区的长度，");
						logger.error("服务端返回数据的长度是："+dataLen+headerLen+" 客户端定义的接收缓冲区长度为："+bRecvBuf.length);
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
					//循环接受余下的字节数
					int count = 0;
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
						System.arraycopy(datas, 0, bRecvBuf, headerLen+totalRecvLen, nTempLen);
						
						totalRecvLen += nTempLen;
						logger.error("totalRecvLen："+totalRecvLen +" dataLen:"+dataLen);
						
						if (totalRecvLen == dataLen){ //读取到指定长度字节数，就停止接收
							//接收到了指定长度读的响应数据，
							logger.error("将数据存放到缓冲区中");
							//System.out.println("响应报文："+new String(datas,"UTF-8"));
							//System.arraycopy(datas, 0, bRecvBuf, headerLen, datas.length);
							nErr = totalRecvLen+headerLen;//读取到的数据长度
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
	
	public static void main(String[] args) {
		String xml = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>"+
						"<Service>"+
						  "<Service_Header>"+
						    "<service_sn>1580018000009695571</service_sn>"+
						    "<service_id>00910000100001</service_id>"+
						    "<requester_id>0018</requester_id>"+
						    "<branch_id>815060101</branch_id>"+
						    "<channel_id>01</channel_id>"+
						    "<service_time>20170711160312</service_time>"+
						    "<version_id>01</version_id>"+
						    "<need_request>true</need_request>"+
						    "<org_service_sn/>"+
						    "<org_service_date/>"+
						  "</Service_Header>"+
						  "<Service_Body>"+
						    "<ext_attributes>"+
						      "<INM-SYS-TX-CODE>TCCB</INM-SYS-TX-CODE>"+
						      "<INM-BUS-OP-CODE>TA007</INM-BUS-OP-CODE>"+
						      "<INM-BRANCH-ID>815060101</INM-BRANCH-ID>"+
						      "<INM-TERM-TYP>A</INM-TERM-TYP>"+
						      "<INM-LAN-ID>01</INM-LAN-ID>"+
						      "<INM-TERM-SRL>002</INM-TERM-SRL>"+
						      "<INM-SPV-A/>"+
						      "<INM-SPV-B/>"+
						      "<INM-LCL-OR-RSN/>"+
						      "<INM-SPV-PWD/>"+
						      "<T_KEY_LABEL>NC8150</T_KEY_LABEL>"+
						      "<INM_CRD_NO/>"+
						      "<INM_CRD_SEQ_NO/>"+
						      "<INM_CRD_EC_BAL/>"+
						      "<INM_F55_DATA/>"+
						      "<INM-TELLER-ID>80300299    </INM-TELLER-ID>"+
						      "<INM-F55-LENGTH>0</INM-F55-LENGTH>"+
						      "<encryflag>10000</encryflag>"+
						      "<CLEAN_MO>N</CLEAN_MO>"+
						      "<ORI_FRONT_T_KEY_LABEL>NC8150</ORI_FRONT_T_KEY_LABEL>"+
						      "<PRO_GLB_APPS_SYS_ID>8150091</PRO_GLB_APPS_SYS_ID>"+
						      "<PRO_SUB_APPS_SYS_ID>0000</PRO_SUB_APPS_SYS_ID>"+
						      "<INNER_DataProcPara>0,0,1</INNER_DataProcPara>"+
						    "</ext_attributes>"+
						    "<request>"+
						      "<TRANS-ID>100001</TRANS-ID>"+
						      "<BRANCH-ID>815012401</BRANCH-ID>"+
						    "</request>"+
						    "<response/>"+
						  "</Service_Body>"+
						"</Service>";
		
		String resp = socketSendData(xml,"127.0.0.1",10050,new EsbServiceResp(),"UTF-8",7);
		System.out.println(resp);
	}
	
}
