package com.aoto.iqms.businessconfig.service.inf;

import java.util.List;
import java.util.Map;

import com.aoto.iqms.businessconfig.models.BscBranchBusinessQuery;
import com.aoto.iqms.businessconfig.models.CallStrategyModel;

/**
 * 叫号策略-业务层接口
 * @author humz
 *
 */
public interface CallStrategyService {

	/**
	 * 查询窗口列表
	 */
	public Map<String, Object> selectWinConfig(Map<String, Object> map);
	
	/**
	 * 查询业务类型
	 */
	public Map<String, Object> selectBuzType(Map<String, Object> map);
	
	/**
	 * 查询业务类型与客户等级的笛卡尔乘积
	 */
	public Map<String, Object> selectCounterBuz(Map<String, Object> map);
	
	/**
	 * 查询保存的窗口统计数据
	 */
	public Map<String, Object> selectCounterBuzsByWinId(Map<String, Object> map);
	
	/**
	 * 保存配置到数据库
	 */
	public String saveCounterBuzs(Map<String, Object> list);
	
	/**
	 *提供排队机下载
	 */
	public void createCounterBuzs(BscBranchBusinessQuery model,String path);
	
	/**
	 * 应用到下级机构
	 */
	public String callStrategyCopy(CallStrategyModel model);
	
	/**
	 * 一键检测：窗口业务
	 * @param model
	 * @return
	 */
	public List<Map<String, Object>> checkedWinBuz(CallStrategyModel model);
	
}
