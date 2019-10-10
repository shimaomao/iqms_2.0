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
 * ServerSocket:监控8998端口
 * @author daxian
 *
 */
public class ServSocketMonitor extends Thread {
	private static final Logger logger = LoggerFactory.getLogger(ServSocketMonitor.class);
	
	private ServerSocket server; //服务端socket
	private Boolean closed = false; //是否关闭
	private int port;//端口
	
    @Autowired
    private ThreadPoolTaskExecutor taskExecutorMonitor;
    
    //构造函数启动服务
    public ServSocketMonitor(int port) throws IOException{
    	this.port = port;
    	start();
    }
	
    //运行服务
	@Override
	public void run() {
		
		//直到ResourceService的初始化完成再打开端口
		while(true){
			if (SpringContextUtil.getApplicationContext() == null || SpringContextUtil.getBean("resourceServiceImp") == null){
				
				logger.error("【ServSocketMonitor】ResourceService未初始化完成，延迟1分钟打开端口");
				try {
					Thread.sleep(60*1000);
				} catch (InterruptedException e) {
					logger.error("线程休眠异常",e);
				}
				
			} else {
				try {
					logger.error("【ServSocketMonitor】ResourceService已经初始化，开始打开8998端口");
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
				taskExecutorMonitor.execute(new SocketRequest(request));
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
