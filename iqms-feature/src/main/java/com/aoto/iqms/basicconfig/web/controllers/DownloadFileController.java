package com.aoto.iqms.basicconfig.web.controllers;

import java.io.BufferedInputStream;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.context.WebApplicationContext;

import com.aoto.iqms.util.SpringContextUtil;

/**
 * 请求模板下载
 * @author humz
 *
 */

@Controller
public class DownloadFileController {
	
    @RequestMapping(value = "/basicconfig/cusinfo/downloadfile", method = RequestMethod.GET)
    public void download(HttpServletRequest request,HttpServletResponse response) throws Exception {  
    	
    	request.setCharacterEncoding("UTF-8");  
        response.setContentType("text/html;charset=UTF-8");   
        
        BufferedInputStream in = null;  
        BufferedOutputStream out = null;  
        
        ServletContext servletContext = ((WebApplicationContext)SpringContextUtil.getApplicationContext()).getServletContext();
		
		String path = servletContext.getRealPath(File.separator);
        
        String rootpath = request.getSession().getServletContext().getRealPath("/");  
        String fileName = request.getParameter("f");  //获取请求参数的文件名
        
        try {  
            File f = new File(path + "/download/" + fileName);
            response.setContentType("application/x-excel");
            //response.setContentType("application/x-gzip");
            response.setCharacterEncoding("UTF-8");  
            response.setHeader("Content-Disposition", "attachment; filename="+fileName);  
            response.setHeader("Content-Length",String.valueOf(f.length()));  
            in = new BufferedInputStream(new FileInputStream(f));//获取输入流，将文件写入到内存中
            out = new BufferedOutputStream(response.getOutputStream());  //获取输出流，将文件从内存中取出来给浏览器下载
            byte[] data = new byte[1024];  
            int len = 0;  
            while (-1 != (len=in.read(data, 0, data.length))) {  
                out.write(data, 0, len);  
            }  
        } catch (Exception e) {  
            e.printStackTrace();  
        } finally {  
            if (in != null) {  
                in.close();  
            }  
            if (out != null) {  
                out.close();  
            }  
        }  
    }
}
