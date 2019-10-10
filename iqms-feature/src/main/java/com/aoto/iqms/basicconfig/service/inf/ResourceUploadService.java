package com.aoto.iqms.basicconfig.service.inf;
import java.util.List;
import java.util.Map;

import com.aoto.framework.commons.pagination.PagingCriteria;
import com.aoto.iqms.basicconfig.models.PatchVersionQuery;
import com.aoto.iqms.basicconfig.models.ResourceUploadModel;
import com.aoto.iqms.basicconfig.models.ResourceUploadQuery;
/**
 * 资源上传接口
 * @author zhousj
 *
 */
public interface ResourceUploadService {
	/**
	 * 生成项目目录的树形结构需要的数据
	 * @return
	 */
	public List<Map<String,Object>> fileTree(String dirPath,String cId);
	
	/**
	 *查询选择目录下的所有文件
	 * @param path
	 * @return
	 */
	public List<Map<String,Object>> getFileList(String path);
	
	/**
     * 调用存储过程新增业务
     * @param model
     * @return
     */
    public String callCreateResourceUploadProc(ResourceUploadModel model);
    
    /**
     * 调用存储过程进行分页数据查询
     * @param map
     * @return
     */
    public List<Map<String, Object>> procPageResourceUpload(PagingCriteria pagingCriteria,ResourceUploadQuery model);
   
    /**
     *打包文件夹用于客户端版本更新 
     * @param dirPath
     * @return
     */
    public String createPatchZip(String dirPath,String dirName, String remark); 
}
