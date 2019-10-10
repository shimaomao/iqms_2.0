package com.aoto.iqms.util;

import java.util.List;

import org.apache.commons.configuration.ConfigurationException;

import org.apache.commons.configuration.PropertiesConfiguration;
import org.apache.commons.configuration.reloading.FileChangedReloadingStrategy;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;


public class PropetiesLoader {
	private static final Logger logger = LoggerFactory.getLogger(PropetiesLoader.class);
	
	private static PropertiesConfiguration systemConfig;  //使用外部配置文件
	private static PropertiesConfiguration authTestConfig;  //使用外部配置文件测试客户识别
	private static PropertiesConfiguration outsideConfig;  //使用项目外的路径中配置文件  20190304
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
	
	/*增加配置文件放置项目目录外*/
	public static PropertiesConfiguration getAuthOutsideConfig() {
		if (outsideConfig == null)
			reloadOutsideConfig();
		return outsideConfig;
	}
	
	public static void reloadOutsideConfig() {
		try{
			PropetiesLoader.outsideConfig = new PropertiesConfiguration("D:/outsideConfig.properties");
			outsideConfig.setReloadingStrategy(new FileChangedReloadingStrategy());
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
