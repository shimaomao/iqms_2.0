package com.aoto.iqms.businessconfig.service.inf;

import java.util.List;
import java.util.Map;

import com.aoto.iqms.businessconfig.models.BscBranchBusinessQuery;
import com.aoto.iqms.businessconfig.models.BscCustRecognitionModel;
import com.aoto.iqms.businessconfig.models.BscCustRecognitionQuery;

/**
 * 客户识别
 * @author zhousj
 *
 */
public interface BscCustRecognitionService {
	/**
	 * 查询
	 * @param model
	 * @return
	 */
	public List<Map<String, Object>> procCustRecognitionQuery(BscCustRecognitionQuery model);
	
	/**
	 * 调用存储过程保存
	 * @param model
	 * @return
	 */
	public String procSaveCustRecognition(List<BscCustRecognitionModel> list);
	
	/**
	 * 调用存储过程删除
	 * @param model
	 * @return
	 */
	public String procDeleteCustRecognition(BscCustRecognitionModel model);
	
	/**
     * 调用存储过程应用到下级机构
     * @param model
     * @return
     */
    public String procBscCustRecognitionCopy(BscCustRecognitionModel model);
    
    /**
     * 生成CustRecs.json
     * @param model
     */
    public List<Map<String, Object>> procCustRecs(BscBranchBusinessQuery model);
    
    /**
     * 生成CustRecs zip包 到D:\zsj
     * @param model
     */
    public void createCustRecs(BscBranchBusinessQuery model,String path);
    
    /**
     * 调用存储过程快速应用(导航配置)
     * @param model
     * @return
     */
    public String procBscCustRecognitionFastCopy(BscCustRecognitionModel model);
}
