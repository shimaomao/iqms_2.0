package com.aoto.iqms.basicconfig.service.inf;

import java.util.List;
import java.util.Map;

import com.aoto.framework.commons.pagination.PagingCriteria;
import com.aoto.iqms.basicconfig.models.CusInfoModel;
import com.aoto.iqms.basicconfig.models.CusInfoQuery;

/**
 * 本地客户Service层接口
 * @author humz
 *
 */
public interface CusInfoService {
	
	/**
     * 调用存储过程进行分页数据查询
     * @param map
     * @return
     */
    public List<Map<String, Object>> procPageCusInfo(PagingCriteria pagingCriteria,CusInfoQuery model);
	
    /**
     * 调用存储过程新增业务
     * @param model
     * @return
     */
    public String callCreateCusInfoProc(CusInfoModel model);
    
    /**
     * 调用存储过程更新业务
     * @param model
     * @return
     */
    public String callUpdateCusInfoProc(CusInfoModel model);
    
    /**
     * 调用存储过程删除业务
     * @param model
     * @return
     */
    public String callRemoveCusInfoProc(List<String> list);
    
    
    /**
	 * 批量保存导入的本地客户信息 
	 * @param models  本地客户信息列表
	 * @param rownums 对应客户信息在excel中的行号
	 * @param errMap  封装错误信息
	 * @return
	 */
	public String callCreateCusInfoBatchProc(List<CusInfoModel> models,List<String> rownums,List<Map<String, String>> errMaps);

}
