package com.aoto.iqms.businessconfig.persistence.inf;

import java.util.List;
import java.util.Map;

import org.apache.taglibs.standard.extra.spath.Step;

import com.aoto.iqms.businessconfig.models.CallStrategyModel;

/**
 * 叫号策略-持久化层接口
 * @author humz
 *
 */
public interface CallStrategyMapper {

	/**
	 * 查询窗口列表
	 */
	public List<Map<String, Object>> selectWinConfig(Map<String, Object> map);
	
	/**
	 * 查询业务类型
	 */
	public List<Map<String, Object>> selectBuzType(Map<String, Object> map);
	
	/**
	 *查询业务类型与客户等级的笛卡尔乘积
	 */
	public List<Map<String, Object>> selectCounterBuz(Map<String, Object> map);
	
	/**
	 * 查询保存的窗口统计数据
	 */
	public List<Map<String, Object>> selectCounterBuzsByWinId(Map<String, Object> map);
	
	/**
	 * 保存配置到数据库
	 */
	public void saveCounterBuzs(Map<String, Object> map);
	
	/**
	 * 删除
	 */
	public void deleteCounterBuzs(Map<String, Object> map);
	
	/**
	 * 查询设备的所有窗口
	 */
	public List<Map<String, Object>> selectCounterId(Map<String, Object> map);
	
	/**
	 * 根据设备号查询，提供排队机下载
	 */
	public List<Map<String, Object>> selectDevice(Map<String, Object> map);
	
	/**
	 * 应用到下级机构
	 */
	public void callStrategyCopy(Map<String, Object> map);
	
	/**
	 * 一键检测：检测窗口配置
	 */
	public List<Map<String, Object>> checkedWinBuz(Map<String, Object> map);
	
}
