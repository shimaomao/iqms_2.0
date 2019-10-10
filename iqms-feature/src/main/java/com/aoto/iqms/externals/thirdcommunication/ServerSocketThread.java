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
 * 监控8999端口：对排队机流水数据上传处理
 * @author daxian
 *
 */
public class ServerSocketThread extends Thread
{
    private static final Logger logger = LoggerFactory.getLogger(ServerSocketThread.class);
    private ServerSocket server;
    private Boolean closed = false;
    private int port;

    @Autowired
    private ThreadPoolTaskExecutor taskExecutor;

    public ServerSocketThread(int port) throws IOException
    {
    	logger.error("【ServerSocketThread】开始启动线程-hongxz");
    	this.port = port;
        start();
    }

    public void run()
    {
		//直到ResourceService的初始化完成再打开端口
		while(true){
			if (SpringContextUtil.getApplicationContext() == null || SpringContextUtil.getBean("resourceServiceImp") == null){
				
				logger.error("【ServerSocketThread】ResourceService未初始化完成，延迟1分钟打开端口");
				try {
					Thread.sleep(60*1000);
				} catch (InterruptedException e) {
					logger.error("线程休眠异常",e);
				}
				
			} else {
				try {
					logger.error("【ServerSocketThread】ResourceService已经初始化，开始打开流水数据上报8999端口");
			    	server = new ServerSocket(port);
			    	break;
				} catch (Exception e) {
					logger.error("【ServerSocketThread】打开端口异常",e);
				}
			}
		}
    	
		//开始接收请求
        while (!closed)
        {
            try
            {
            	
                Socket request = server.accept();
                
                taskExecutor.execute(new SocketRequest(request));
            }
            catch (IOException e)
            {
                logger.error("server.accept error", e);
            }
        }
    }

    public void close()
    {
    	closed = true;
        IOUtils.closeQuietly(server);
    }
}
