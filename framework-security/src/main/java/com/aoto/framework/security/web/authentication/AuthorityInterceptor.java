package com.aoto.framework.security.web.authentication;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import com.aoto.framework.commons.userdetails.CurrentUser;
import com.aoto.framework.security.service.inf.OrgService;

/**
 * 对用户操作进行越权校验   20181114
 * @author tianjm
 *
 */
public class AuthorityInterceptor implements HandlerInterceptor {

	private static final Logger logger = LoggerFactory.getLogger(AuthorityInterceptor.class);
	
	@Autowired
    private OrgService orgService;
	/** 
     * 在页面渲染完成返回给客户端之前执行 
     * */ 
	@Override
	public void afterCompletion(HttpServletRequest arg0,
			HttpServletResponse arg1, Object arg2, Exception arg3)
			throws Exception {
	}

	/** 
     * 在controller执行之后的DispatcherServlet之后执行 
     * */
	@Override
	public void postHandle(HttpServletRequest arg0, HttpServletResponse response,
			Object arg2, ModelAndView arg3) throws Exception {
	}

	/** 
     * 在DispatcherServlet之前执行 
     * */ 
	@Override
	public boolean preHandle(HttpServletRequest request,HttpServletResponse response, Object arg2) {
		
		boolean auth = false; // 越权校验
		String orgCode = request.getParameter("orgCode");
		String orgId = request.getParameter("orgId");
		String parentId = request.getParameter("parentId");
		CurrentUser currentUser  = null;
		try{
			currentUser = (CurrentUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		}catch (Exception e) {
			logger.error(e.getMessage());
			return true;
		}
			
		int orgIdAuth = currentUser.getOrgId();
		String orgCodeAuth = currentUser.getOrgCode();

		List<Map<String, Object>> list = orgService.getAllOrgIdByParentId(orgIdAuth);

		logger.info("用户操作请求orgCode=" + orgCode + ",安全框架中记录orgCode="+ orgCodeAuth);
		logger.info("用户操作请求orgId=" + orgId + ",安全框架中记录orgId=" + orgIdAuth);
		// 有些请求只有orgId或者orgCode或者两者都没有
		// 验证机构id是否越权
		if (orgId != null) {
			for (int i = 0; i < list.size(); i++) {
				if (String.valueOf(list.get(i).get("orgId")).equals(orgId)) {
					auth = true;
					break;	
				}
			}
			if (!auth) {
				logger.error("【系统操作异常】：传入机构id有误！");
				logger.error("【系统操作异常】：进行签退操作！");
				String targeturl = response.encodeRedirectURL(request.getContextPath()+"/logout");//url重写
				try {
					response.sendRedirect(targeturl);
				} catch (IOException e) {
					e.printStackTrace();
				} 
				return false;
			}
		}
		// 验证机构编码是否越权
		else if (orgCode != null) {
			if (parentId == null) {
				for (int i = 0; i < list.size(); i++) {
					if (String.valueOf(list.get(i).get("orgCode")).equals(orgCode)) {
						auth = true;
						break;
					}
				}
			} else {// 新增机构信息的时候传的是parentId
				for (int i = 0; i < list.size(); i++) {
//					String checkId =  String.valueOf(list.get(i).get("orgId"));
					if (String.valueOf(list.get(i).get("orgId")).equals(parentId)) {
						auth = true;
						break;
					}
				}
			}
			if (!auth) {
				String targeturl = response.encodeRedirectURL(request.getContextPath()+"/logout");//url重写
				try {
					response.sendRedirect(targeturl);
				} catch (IOException e) {
					e.printStackTrace();
					logger.error(e.getMessage());
				} 
				logger.error("【系统操作异常】：传入机构id或机构编码有误！");
				logger.error("【系统操作异常】：进行签退操作！");
				return false;
			}
		}

		return true;
	}

}
