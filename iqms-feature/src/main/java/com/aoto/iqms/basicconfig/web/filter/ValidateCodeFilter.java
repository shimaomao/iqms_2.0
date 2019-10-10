package com.aoto.iqms.basicconfig.web.filter;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.lang.reflect.InvocationHandler;
import java.lang.reflect.Method;
import java.lang.reflect.Proxy;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;


/**
 * 验证码过滤器
 * @author Administrator
 *
 */
public class ValidateCodeFilter implements Filter {

	private static final Logger logger = LoggerFactory.getLogger(ValidateCodeFilter.class);
	
	private boolean isValidateCode;
	
	@Override
	public void init(FilterConfig paramFilterConfig) throws ServletException {
		isValidateCode = Boolean.parseBoolean(paramFilterConfig.getInitParameter("isVaidateCode"));//获取web.xml配置文件中过滤器中的初始化值
	}

	@Override
	public void doFilter(ServletRequest paramServletRequest,
			ServletResponse paramServletResponse, FilterChain paramFilterChain)
			throws IOException, ServletException {
		
		ServletRequest newReq=null;
			if (isValidateCode) {  //需要验证码验证
				HttpServletRequest request = (HttpServletRequest)paramServletRequest;//因为下面的getsession()方法是HttpServletRequest中的，而不是父接口ServletRequest中的，所以要向上强转，以保证安全
				HttpServletResponse response = (HttpServletResponse)paramServletResponse;//如上同理，子调用父里面的方法是安全的，即向下（隐形）转型。而父调用子里面的方法则是不安全的，即向上强转。
				String validateCode = (String) request.getSession().getAttribute("validateCode");//从session中获取图片中生成的验证码				
				String u_validateCode = request.getParameter("j_veryCode");//从用户输入的输入框中获取验证码


				InvocationHandler reqHandler = new HttpServletRequestInvocationHandler(paramServletRequest);
				newReq = (ServletRequest) Proxy.newProxyInstance(
						HttpServletRequestInvocationHandler.class.getClassLoader(), new Class[] { HttpServletRequest.class },
						reqHandler);
				
				if (validateCode == null) { 
					logger.info("没有获取到验证码");
					
//					20180620 插除验证码信息     渗透测试二维码后台未刷新
					request.getSession().removeAttribute("validateCode");
					
					String targeturl = response.encodeRedirectURL(request.getContextPath()+"/login/error?msg=novaliate");//url重写
					response.sendRedirect(targeturl);//重定向到提示错误的页面
					return;
				} else {
					
					logger.info("session验证码："+validateCode +"，用户输入验证码："+u_validateCode);
					if (!u_validateCode.equalsIgnoreCase(validateCode)){
						logger.info("用户验证码输入错误");
						
//						20180620 插除验证码信息     渗透测试二维码后台未刷新
						request.getSession().removeAttribute("validateCode");
						
						String targeturl = response.encodeRedirectURL(request.getContextPath()+"/login/error?msg=nomatch");
						response.sendRedirect(targeturl);
						return;
					}
				}
			}
			
			//如果上面过滤验证码通过，那么接着执行下一个过滤器Filter，如果没有其他过滤器就执行到登录用户名验证j_spring_security_check
			paramFilterChain.doFilter(newReq, paramServletResponse);
			
		
	}

	@Override
	public void destroy() {
		
	}
	

	public boolean isValidateCode() {
		return isValidateCode;
	}

	public void setValidateCode(boolean isValidateCode) {
		this.isValidateCode = isValidateCode;
	}
	
}


/**
 * 对后台系统登录时加密传输的用户名和密码进行解密 20181106
 * @author tianjm
 *
 */
class HttpServletRequestInvocationHandler implements InvocationHandler {

	private static final Logger log = LoggerFactory.getLogger(HttpServletRequestInvocationHandler.class);
	/**
	 * invoke方法中只有代理类的实例，而被代理类的实例需要自行注入
	 */
	private ServletRequest req;
	
	public HttpServletRequestInvocationHandler(ServletRequest req) {
		this.req = req;
	}
	
	private static byte[] base64DecodeChars = new byte[] { -1, -1, -1, -1, -1,  
	        -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,  
	        -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,  
	        -1, -1, -1, -1, 62, -1, -1, -1, 63, 52, 53, 54, 55, 56, 57, 58, 59,  
	        60, 61, -1, -1, -1, -1, -1, -1, -1, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9,  
	        10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, -1,  
	        -1, -1, -1, -1, -1, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37,  
	        38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, -1, -1, -1,  
	        -1, -1 };  
	
	/**
	 * proxy为代理类实例
	 * method为调用的方法
	 * args为传递到方法的参数值（实际值）
	 * 返回值为方法method执行后的返回值
	 */
	@Override
	public Object invoke(Object proxy, Method method, Object[] args) throws Throwable {
		// 拦截getParameter方法，当参数为“name”时进行替换
		if ("getParameter".equals(method.getName()) && args.length > 0 && "j_username".equals(String.valueOf(args[0]))) {
			String username = req.getParameter("j_username");
			log.info("=======登陆用户名加密为："+username );
			String newName =new String(decode(username));
			log.info("=======登陆用户名解密为："+newName);
			return newName;
		}
		if ("getParameter".equals(method.getName()) && args.length > 0 && "j_password".equals(String.valueOf(args[0]))) {
			String pwd = req.getParameter("j_password");
			String newPwd =new String(decode(pwd));
			log.info("密码加密为："+pwd +"，密码解密为："+newPwd);
//			System.out.println("密码加密为："+pwd+"，密码解密为："+newPwd);
			return newPwd;
		}

		// 不需要替换的参数就返回原始值
		return method.invoke(req, args);
	}
	/** 
	 * 解密 
	 * @param str 
	 * @return 
	 */  
	public static byte[] decode(String str) {
	    byte[] data = str.getBytes();  
	    int len = data.length;  
	    ByteArrayOutputStream buf = new ByteArrayOutputStream(len);  
	    int i = 0;  
	    int b1, b2, b3, b4;  
	  
	    while (i < len) {  
	        do {  
	            b1 = base64DecodeChars[data[i++]];  
	        } while (i < len && b1 == -1);  
	        if (b1 == -1) {  
	            break;  
	        }  
	  
	        do {  
	            b2 = base64DecodeChars[data[i++]];  
	        } while (i < len && b2 == -1);  
	        if (b2 == -1) {  
	            break;  
	        }  
	        buf.write((int) ((b1 << 2) | ((b2 & 0x30) >>> 4)));  
	  
	        do {  
	            b3 = data[i++];  
	            if (b3 == 61) {  
	                return buf.toByteArray();  
	            }  
	            b3 = base64DecodeChars[b3];  
	        } while (i < len && b3 == -1);  
	        if (b3 == -1) {  
	            break;  
	        }  
	        buf.write((int) (((b2 & 0x0f) << 4) | ((b3 & 0x3c) >>> 2)));  
	  
	        do {  
	            b4 = data[i++];  
	            if (b4 == 61) {  
	                return buf.toByteArray();  
	            }  
	            b4 = base64DecodeChars[b4];  
	        } while (i < len && b4 == -1);  
	        if (b4 == -1) {  
	            break;  
	        }  
	        buf.write((int) (((b3 & 0x03) << 6) | b4));  
	    }  
	    return buf.toByteArray();  
	}  

}

