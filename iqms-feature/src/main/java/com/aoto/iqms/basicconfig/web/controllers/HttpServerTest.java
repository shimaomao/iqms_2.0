package com.aoto.iqms.basicconfig.web.controllers;

import java.io.BufferedInputStream;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.InetAddress;
import java.net.URL;
import java.net.URLDecoder;
import java.net.UnknownHostException;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.aoto.framework.commons.beans.JsonResult;
import com.aoto.framework.commons.pagination.PagingCriteria;
import com.aoto.iqms.basicconfig.models.PatchVersionModel;
import com.aoto.iqms.basicconfig.models.PatchVersionQuery;
import com.aoto.iqms.basicconfig.service.inf.PatchVersionService;
import com.aoto.iqms.util.MD5Util;
import com.aoto.iqms.util.PropetiesLoader;


/**
 * http服务端模拟
 * @author daxian
 *
 */
@Controller
public class HttpServerTest {
	
	private static final Logger logger = LoggerFactory.getLogger(HttpServerTest.class);
	
    
	 /**
     * http服务端测试(黑龙江邮储测试)
     * @param request
     * @param response
     * @return
     */
    @RequestMapping(value = "/httpservertest/hljyc", method = RequestMethod.POST)
    @ResponseBody
    public void httpServerTest(HttpServletRequest request,  
            HttpServletResponse response) throws Exception{
    	
    	
    	
		String recivStr = request.getParameter("data");
		recivStr = URLDecoder.decode(recivStr,"UTF-8");
//		String recivStr = new String(data,0,len,"UTF-8");
		logger.info("接收到的请求报文："+recivStr);
		
		//解析获取到的报文
		String[] fields = recivStr.split("\\|",-1);
		String transCode = fields[1];
		String resp = "";
		if (transCode.contains("B001")) { //客户识别
			//返回报文
			 resp = "0035|B001|0000|成功|05|VIP钻石级客户|宣传广告|提示语";
		}  else if (transCode.contains("B002")) {  //流水数据上报
			 resp = "0035|B002|0000|成功";
		}
		response.getOutputStream().write(resp.getBytes("UTF-8"));
    }
    

}
