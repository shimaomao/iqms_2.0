package com.aoto.framework.security.web.authentication;

import java.io.IOException;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.DefaultRedirectStrategy;
import org.springframework.security.web.RedirectStrategy;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.authentication.SimpleUrlAuthenticationFailureHandler;

import com.aoto.framework.security.service.inf.UserService;
import com.aoto.framework.security.util.PropetiesLoader;


public class LoginFailureHandler extends SimpleUrlAuthenticationFailureHandler implements AuthenticationSuccessHandler {
	
	private String defaultFailureUrl;
	private boolean forwardToDestination = false;
	private RedirectStrategy redirectStrategy = new DefaultRedirectStrategy();
	private int errorTimes  = PropetiesLoader.getSystemConfig().getInt("errorTimes",5);// 配置的密码输错次数
	private boolean errorTimesFlag  = PropetiesLoader.getSystemConfig().getBoolean("errorTimesFlag",true);// 是否开启密码输错次数锁定机制

	public LoginFailureHandler() {
	}
	public LoginFailureHandler(String defaultFailureUrl) {
		setDefaultFailureUrl(defaultFailureUrl);
	}

	@Autowired
	private UserService userService;

	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response, Authentication authentication)
	throws IOException, ServletException {
		
	}
	
	@Override
	public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response,
				AuthenticationException exce) throws IOException, ServletException{
		String targeturl ="";
		Authentication authentication = exce.getAuthentication();
		String detailMsg = exce.getMessage();
		String userName = (String) authentication.getPrincipal();
		String ip = request.getRemoteAddr();
		Map<String, Object> user = userService.getUserinfoByUsername(userName);
		
		if(user!=null && errorTimesFlag){
			if(detailMsg!=null && detailMsg.equals("User account is locked")){
				targeturl = response.encodeRedirectURL(request.getContextPath()+"/login/error?msg=userlock");//url重写
				
			}else if(detailMsg!=null && detailMsg.equals("Bad credentials")){
				int error_time = (Integer) user.get("errorTime") == null ? 0 : (Integer) user.get("errorTime");
				int userId = (Integer) user.get("userId");
				if(error_time ==(errorTimes-1)){//密码输错到了配置的次数,锁定账户
					userService.lockUsersByUserId(userId);  
					targeturl = response.encodeRedirectURL(request.getContextPath()+"/login/error?msg=errorTimes&errorTimes="+errorTimes);//url重写
				}else if (error_time==errorTimes){
					targeturl = response.encodeRedirectURL(request.getContextPath()+"/login/error?msg=errorTimes&errorTimes="+errorTimes);//url重写
				}else{
					userService.updateUserErrorTimes(userId); //增加一次密码输入错误次数
					if(error_time == (errorTimes-2) && error_time>=1){
						targeturl = response.encodeRedirectURL(request.getContextPath()+"/login/error?msg=pwdWarn&errorTimes="+errorTimes);//url重写
					}else  targeturl = response.encodeRedirectURL(request.getContextPath()+"/login/error?msg=pwdError");//url重写
				}
				logger.info("【密码错误】用户名："+userName+";输错次数："+(error_time+1));
				
			}
		}else{
			targeturl = response.encodeRedirectURL(request.getContextPath()+"/login/error?msg=pwdError");//url重写
		}
		
//		20180620 插除验证码信息     渗透测试二维码后台未刷新
		request.getSession().removeAttribute("validateCode");
//		String validateCode = (String) request.getSession().getAttribute("validateCode");
		
		
		if (this.defaultFailureUrl == null) {
		      this.logger.error("No failure URL set, sending 401 Unauthorized error");
//		      response.sendError(401, "Authentication Failed: " + exce.getMessage());
			response.sendRedirect(targeturl);
		    } else {
		      saveException(request, exce);

		      if (this.forwardToDestination) {
		        this.logger.debug("Forwarding to " + this.defaultFailureUrl);

		        request.getRequestDispatcher(this.defaultFailureUrl).forward(request, response);
		      } else {
		        this.logger.debug("Redirecting to " + this.defaultFailureUrl);
		        this.redirectStrategy.sendRedirect(request, response, this.defaultFailureUrl);
		      }
		    }
	}

}
