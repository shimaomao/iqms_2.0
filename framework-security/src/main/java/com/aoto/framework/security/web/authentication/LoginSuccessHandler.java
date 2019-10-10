/*
 * 版权信息：Copyright (c) 2013, Aoto. All rights reserved.
 * 文件编号：LoginSuccessHandler.java
 * 文件名称：LoginSuccessHandler.java
 * 系统编号：mips
 * 系统名称：mips
 * 模块编号：
 * 模块名称：
 * 作          者：jiangp
 * 完成日期：2013年9月23日
 * 设计文档：<列出相关设计文档的编号、名称。>
 * 内容摘要：<说明文件包含的类、类的性质/版型、类的状态说明、主要功能、系统相关界面、包含的区段、关键词及其一般说明、文件调用等。>
 */
package com.aoto.framework.security.web.authentication;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.SavedRequestAwareAuthenticationSuccessHandler;

import com.aoto.framework.commons.userdetails.CurrentUser;
import com.aoto.framework.logging.models.LoginLogModel;
import com.aoto.framework.logging.service.inf.LogService;
import com.aoto.framework.security.models.UserModel;
import com.aoto.framework.security.util.PropetiesLoader;

/**
 * 〈一句话功能简述〉 〈功能详细描述〉
 * 
 * @author jiangp
 * @see [相关类/方法]（可选）
 * @since [产品/模块版本] （必须）
 */
public class LoginSuccessHandler extends SavedRequestAwareAuthenticationSuccessHandler
{
    /**
     * [简要描述]:
     * @author zongwj
     */
    @Autowired
    protected LogService logService;
    private static final Logger logger = LoggerFactory.getLogger(LoginSuccessHandler.class);

    /**
     * 〈一句话功能简述〉
     * 
     * @author jiangp
     * @param request HttpServletRequest
     * @param response HttpServletResponse
     * @param authentication Authentication
     * @exception/throws [异常类型] [异常说明]（可选）
     * @see [类、类#方法、类#成员]（可选）
     * @since [起始版本]（可选）
     */
    @Override
    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
            Authentication authentication) throws IOException, ServletException
    {
    	//-------------增加对用户密码的合法校验，不符合要求强制重新设置   tianjm20181106     start ------------------
    	/**
    	 * 1.先校验用户密码合法性
    	 * 2.再校验用户名合法性，在前段有校验，但放置抓包修改，再次校验
    	 * 3.校验密码使用时间是否超过设定的时间
    	 */
    	boolean checkUserNameFlag = PropetiesLoader.getSystemConfig().getBoolean("checkUserNameFlag", true);
    	String checkUserName = PropetiesLoader.getSystemConfig().getString("checkUserName", "root|admin|administrator|guanliyuan");
    	
    	String targeturl ="";
    	boolean isLegal =true;
    	String pwd = request.getParameter("j_password");
    	int result1 = pwd.matches(".*[a-z]{1,}.*") == true ? 1 : 0;
		int result2 = pwd.matches(".*[A-Z]{1,}.*") == true ? 1 : 0;
		int result3 = pwd.matches(".*\\d{1,}.*")== true ? 1 : 0;
		int result4 = pwd.matches(".*[~!@#$%^&*()><?]{1,}.*")== true ? 1 : 0;
		int sumary = result1 + result2 + result3 + result4;
		if (sumary >= 3 && pwd.length()>=8 ) {
			isLegal = false; //不需要重置密码  用户密码至少包含大写字母、小写字母、数字、特殊字符中的 3类且至少8位
		}
    	if(isLegal){
    		logger.error("密码不合法，重置密码");
	    	targeturl = response.encodeRedirectURL(request.getContextPath()+"/login/pwd");//url重写
	    	response.sendRedirect(targeturl);
	    	return;
    	}else{
    		// '用户名不合法（由4-16位长度的字母数字下划线组成，不得使用root、admin、姓名简拼等 )'
	    	String username = request.getParameter("j_username");
	    	String[] fields = checkUserName.split("\\|",-1);
	    	if(checkUserNameFlag){
		    	for (String usernameCheck : fields) {
					if(username!=null && !username.equals(usernameCheck) && username.matches(".*[a-zA-Z0-9_]{4,16}.*")){
					}else{
						logger.error("用户名不合法,直接注销用户名");
						targeturl = response.encodeRedirectURL(request.getContextPath()+"/logout");//退出登录
						response.sendRedirect(targeturl);
						return;
					}
				}
	    	}
    	}
    	
    	CurrentUser user = (CurrentUser)(SecurityContextHolder.getContext().getAuthentication().getPrincipal());//获取系统验证实体，然后强转为自定义的CurrentUser
     	Date createdDate = user.getCreatedDate();//再从自定义的验证实体中获取里面的属性值createdDate
 		Date date=new Date();       		        		
 		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
     	String currentTime=sdf.format(date); //当前系统时间
     	String createdTime=sdf.format(createdDate);       
			
     	boolean pwdTimeLengthFlag = PropetiesLoader.getSystemConfig().getBoolean("pwdTimeLengthFlag", true);
     	int pwdTimeLength = PropetiesLoader.getSystemConfig().getInt("pwdTimeLength", 90);
     	if(pwdTimeLengthFlag){
			try {
				long a1 = sdf.parse(currentTime).getTime();//转换为毫秒
				long a2 = sdf.parse(createdTime).getTime();			
				long a3 =(a1-a2)/(1000*60*60*24);//转换为相隔天数
				if(a3<pwdTimeLength){  
					
				}else{
					logger.error("密码过期，重置密码，设置时长为"+pwdTimeLength+"天");
					targeturl = response.encodeRedirectURL(request.getContextPath()+"/login/pwdOverdue?pwdTimeLength="+pwdTimeLength);//退出登录
					response.sendRedirect(targeturl);
					return;
				}
			} catch (ParseException e) {
				e.printStackTrace();
			}
     	}
    	
    	// -------------------------------------------      tianjm20181106    end ----------------------------------------------
    	
        CurrentUser currentUser = (CurrentUser) authentication.getPrincipal();
        String ip = request.getRemoteAddr();
        HttpSession session = request.getSession(true);
        String sessionId = session.getId();
        Date now = new Date();
        currentUser.setLoginInfo(ip, now, sessionId);
        
        super.onAuthenticationSuccess(request, response, authentication);
        
        LoginLogModel model = new LoginLogModel();        
        model.setSessionId(sessionId);
        model.setUserId(currentUser.getUserId());
        model.setUsername(currentUser.getUsername());
        model.setRealName(currentUser.getRealName());
        model.setIp(ip);
        model.setOrgId(currentUser.getOrgId());
        model.setOrgName(currentUser.getOrgName());
        model.setInheritedName(currentUser.getInheritedName());
        model.setLoginDate(now);
        model.setUserAgent(request.getHeader("USER-AGENT"));
        
        logService.createLoginLog(model);
    }
}
