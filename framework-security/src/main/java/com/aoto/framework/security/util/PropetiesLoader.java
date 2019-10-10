package com.aoto.framework.security.util;

import org.apache.commons.configuration.ConfigurationException;

import org.apache.commons.configuration.PropertiesConfiguration;
import org.apache.commons.configuration.reloading.FileChangedReloadingStrategy;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;


public class PropetiesLoader {
private static final Logger logger = LoggerFactory.getLogger(PropetiesLoader.class);
	
	private static PropertiesConfiguration systemConfig;  //使用外部配置文件
	private static PropertiesConfiguration authTestConfig;  //使用外部配置文件测试客户识别
	public static PropertiesConfiguration getSystemConfig() {
		if (systemConfig == null)
			reloadConfigConfig();
		return systemConfig;
	}
	
	public static void reloadConfigConfig() {
		try{
			PropetiesLoader.systemConfig = new PropertiesConfiguration("config.properties");
			systemConfig.setReloadingStrategy(new FileChangedReloadingStrategy());
		} catch (ConfigurationException e) {
			// TODO: handle exception
			logger.debug(e.getMessage());
		}
	}
	
	public static PropertiesConfiguration getAuthTestConfig() {
		if (authTestConfig == null)
			reloadAuthTestConfig();
		return authTestConfig;
	}
	
	public static void reloadAuthTestConfig() {
		try{
			PropetiesLoader.authTestConfig = new PropertiesConfiguration("Auth_Test_Config.properties");
			authTestConfig.setReloadingStrategy(new FileChangedReloadingStrategy());
		} catch (ConfigurationException e) {
			// TODO: handle exception
			logger.debug(e.getMessage());
		}
	}
	
	public static void main(String[] args) {
//		PropetiesLoader.getSystemConfig().getString("proxool.user");
//		List<Object> list = PropetiesLoader.getAuthTestConfig().getList("custMap");
		
		System.out.println(PropetiesLoader.getSystemConfig().getBoolean("isbook"));
	}
}
