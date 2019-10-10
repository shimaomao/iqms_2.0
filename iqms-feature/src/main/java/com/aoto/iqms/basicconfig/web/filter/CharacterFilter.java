package com.aoto.iqms.basicconfig.web.filter;

import java.io.IOException;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.filter.OncePerRequestFilter;

import com.aoto.framework.security.util.PropetiesLoader;

/**
 *  过滤非法字符,若有则转义成下划线
 * @author tianjm
 * 20181108
 */
public class CharacterFilter extends OncePerRequestFilter {

	String[] characterParams;
	
	@Override
	protected void doFilterInternal(HttpServletRequest request,HttpServletResponse response, FilterChain filterChain)
			throws ServletException, IOException {
		 characterParams = PropetiesLoader.getSystemConfig().getString("characterParams","<_%_'_>_#").split("_");
		 boolean characterParamsFlag = PropetiesLoader.getSystemConfig().getBoolean("characterParamsFlag",true);
		filterChain.doFilter(new HttpServletRequestWrapper(request) {
			@Override
			public String getParameter(String name) {
				// 返回值之前 先进行过滤
				if(characterParamsFlag){
					return filterDangerString(super.getParameter(name));
				}
				return name;
			}
			@Override
			public String[] getParameterValues(String name) {
				// 返回值之前 先进行过滤
				String[] values = super.getParameterValues(name);
				if(characterParamsFlag){
					if (values != null) {
						for (int i = 0; i < values.length; i++) {
							values[i] = filterDangerString(values[i]);
						}
					}
				}
				return values;
			}
		}, response);
	}

	public String filterDangerString(String value){
		if (value == null) {
		return null;
		}
		//根据自己实际需求过滤
		for (int i = 0; i < characterParams.length; i++) {
			if (value.indexOf(this.characterParams[i]) >= 0) {
				logger.error("参数校验不合法，paramValue="+value);
				value = value.replaceAll(characterParams[i], "_");
			}
		}
		return value;
	}
}
