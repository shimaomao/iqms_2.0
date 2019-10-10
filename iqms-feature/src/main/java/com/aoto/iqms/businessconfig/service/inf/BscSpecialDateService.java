package com.aoto.iqms.businessconfig.service.inf;

import java.util.List;
import java.util.Map;

import com.aoto.iqms.businessconfig.models.BscBranchBusinessQuery;
import com.aoto.iqms.businessconfig.models.BscCustRecognitionQuery;
import com.aoto.iqms.businessconfig.models.BscSpecialDateModel;

/**
*@author zsj
*@创建时间：2018年10月9日下午5:31:26
*
*/
public interface BscSpecialDateService {
	/**
	 * 查询
	 * @param model
	 * @return
	 */
	public List<Map<String, Object>> procSpecialDateQuery(BscCustRecognitionQuery model);
	
	/**
	 * 调用存储过程保存
	 * @param model
	 * @return
	 */
	public String procSaveSpecialDate(List<BscSpecialDateModel> list);
	
	/**
	 * 调用存储过程删除
	 * @param model
	 * @return
	 */
	public String procDeleteSpecialDate(BscSpecialDateModel model);
	
	/**
     * 调用存储过程应用到下级机构
     * @param model
     * @return
     */
    public String procSpecialDateCopy(BscSpecialDateModel model);
    
    /**
     * 生成CustRecs.json
     * @param model
     */
    public List<Map<String, Object>> procSpecialDates(BscBranchBusinessQuery model);
    
    /**
     * 生成CustRecs zip包 到D:\zsj
     * @param model
     */
    public void createSpecialDates(BscBranchBusinessQuery model,String path);
}
