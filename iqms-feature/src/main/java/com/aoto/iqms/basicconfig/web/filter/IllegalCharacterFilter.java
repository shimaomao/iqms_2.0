package com.aoto.iqms.basicconfig.web.filter;

import java.io.IOException;
import java.util.Arrays;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.aoto.framework.security.util.PropetiesLoader;

/**
 * 防止host头攻击，进行白名单校验 20181114
 * @author tianjm
 *
 */
public class IllegalCharacterFilter implements Filter {
	
	private static final Logger logger = LoggerFactory.getLogger(IllegalCharacterFilter.class);
	
	public void destroy() {
	}

	public void doFilter(ServletRequest request, ServletResponse response,
			FilterChain chain) throws IOException, ServletException {
		boolean status = false;
		HttpServletRequest request2=(HttpServletRequest)request;
		boolean whiteHostflag = PropetiesLoader.getSystemConfig().getBoolean("whiteHostFlag",true);
		if(whiteHostflag){ //是否配置白名单
			 String requestHost = request2.getHeader("host");
			String whiteHost = PropetiesLoader.getSystemConfig().
												getString("whiteHost","127.0.0.1:8080|localhost:8080");
		    String[] host = whiteHost.split("\\|",-1);
		    status =! Arrays.asList(host).contains(requestHost);
		}
		
		if (status) {
			logger.error("【是否配置host白名单】:"+whiteHostflag);
			request.getRequestDispatcher("404error.jsp").forward(request, response); 
			return;
		} else {
			chain.doFilter(request, response);
		}
	}

	public void init(FilterConfig filterConfig) throws ServletException {
		 
	}
}
