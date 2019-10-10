package com.aoto.iqms.businessconfig.service.inf;

import java.util.List;
import java.util.Map;

import com.aoto.iqms.businessconfig.models.BscBranchBusinessQuery;
import com.aoto.iqms.businessconfig.models.BscShowTimeModel;
import com.aoto.iqms.businessconfig.models.BscShowTimeQuery;

/**
 * 业务显示时间
 * @author zhousj
 *
 */
public interface BscShowTimeService {
	
	/**
	 * 查询
	 * @param model
	 * @return
	 */
	public List<Map<String, Object>> procShowTimeQuery(BscShowTimeQuery model);
	
	/**
	 * 调用存储过程保存
	 * @param model
	 * @return
	 */
	public String procSaveShowTime(List<BscShowTimeModel> list);
	
	/**
	 * 调用存储过程删除
	 * @param model
	 * @return
	 */
	public String procDeleteShowTime(BscShowTimeModel model);
	
	/**
     * 执行存储过程应用到下级机构
     * @param map
     */
    public String callCopyBscShowTime(BscShowTimeModel model);
    
    /**
     * 执行存储过程判断相应机构号和设备号 数据是否存在 
     * @param map
     */
    public String procIsExistShowTime(BscShowTimeModel model);
    
    /**
     * 执行存储过程生成buzTimes.json
     * @param model
     * @return
     */
    public List<Map<String, Object>> procBuzTimesQuery(BscBranchBusinessQuery model);
    
    /**
     * 一键检测：业务及业务显示时间检测
     * @param model
     * @return
     */
    public List<Map<String, Object>> checkedBuzTime(BscShowTimeModel model);
    /**
     * 查询显示时间
     * @param map
     * @return
     */
    public List<Map<String, Object>> findShowTime(BscShowTimeModel model);
}
