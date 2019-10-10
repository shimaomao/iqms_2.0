package com.aoto.iqms.basicconfig.service.inf;

import java.util.List;
import java.util.Map;

import com.aoto.framework.commons.pagination.PagingCriteria;
import com.aoto.iqms.basicconfig.models.PatchVersionModel;
import com.aoto.iqms.basicconfig.models.PatchVersionQuery;


/**
 * 版本管理接口
 * @author daxian
 *
 */
public interface PatchVersionService {
	
	
	/**
     * 调用存储过程进行分页数据查询
     * @param map
     * @return
     */
    public List<Map<String, Object>> procPagePatchVersion(PagingCriteria pagingCriteria,PatchVersionQuery model);
	
    /**
     * 调用存储过程新增业务
     * @param model
     * @return
     */
    public String callCreatePatchVersionProc(PatchVersionModel model);
    
    /**
     * 调用存储过程更新业务
     * @param model
     * @return
     */
    public String callUpdatePatchVersionProc(PatchVersionModel model);
    
    /**
     * 调用存储过程删除业务
     * @param model
     * @return
     */
    public String callRemovePatchVersionProc(List<String> list);
    
    /**
     * 通过条件查询列表
     * @param map
     */
    public List<Map<String, Object>> findPatchVersionByConditon(PatchVersionModel model);
    
    /**
     * 20151120 by hongxz
     * @param patchId
     * @param devNos
     * @return
     */
    public String callInsertUpgrade(int patchId,List<String> devNos);
    
    /**
     * 资源上传后为所有设备下发
     * @param patchId
     * @return
     */
    public String callInsertUpgrade(int patchId);
}
