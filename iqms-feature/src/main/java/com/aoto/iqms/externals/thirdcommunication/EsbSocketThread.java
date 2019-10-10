package com.aoto.iqms.externals.thirdcommunication;

import java.io.IOException;
import java.net.ServerSocket;
import java.net.Socket;

import org.apache.commons.io.IOUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.concurrent.ThreadPoolTaskExecutor;

import com.aoto.iqms.util.SpringContextUtil;

/**
 * 山东联盟-esb请求处理接口
 * @author hongxz
 *
 */
public class EsbSocketThread extends Thread{
	private static final Logger logger = LoggerFactory.getLogger(EsbSocketThread.class);
	
	private ServerSocket server; //服务端socket
	private Boolean closed = false; //是否关闭
	private int port;//端口
	
    @Autowired
    private ThreadPoolTaskExecutor taskExecutorEsb;
    
    //构造函数启动服务
    public EsbSocketThread(int port) throws IOException{
    	this.port = port;
    	start();
    }
    
    public void run() {
		
		//直到ResourceService的初始化完成再打开端口
		while(true){
			if (SpringContextUtil.getApplicationContext() == null || SpringContextUtil.getBean("resourceServiceImp") == null){
				
				logger.error("【EsbSocketThread】ResourceService未初始化完成，延迟1分钟打开端口");
				try {
					Thread.sleep(10*1000);
				} catch (InterruptedException e) {
					logger.error("线程休眠异常",e);
				}
				
			} else {
				try {
					logger.error("【EsbSocketThread】ResourceService已经初始化，开始打开远程预约接口"+port+"端口");
			    	server = new ServerSocket(port);
			    	break;
				} catch (Exception e) {
					logger.error("打开端口异常",e);
				}
			}
		}
		
		//处理接收请求
		while(!closed){
			try{
				
				Socket request = server.accept();
				taskExecutorEsb.execute(new EsbRequest(request));
			} catch (Exception e) {
				 logger.error("server.accept error", e);
			}
		}
	}
	
	//关闭服务端socket
	public void close()
    {
    	closed = true;
        IOUtils.closeQuietly(server);
    }
}
