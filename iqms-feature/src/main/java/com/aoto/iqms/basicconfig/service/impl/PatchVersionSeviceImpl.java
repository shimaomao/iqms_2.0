package com.aoto.iqms.basicconfig.service.impl;

import java.io.File;
import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.aoto.framework.commons.lang.StringUtils4Aoto;
import com.aoto.framework.commons.pagination.PagingCriteria;
import com.aoto.iqms.basicconfig.commons.constant.BasicconfigBeanProperty.PatchVersion;
import com.aoto.iqms.basicconfig.models.PatchVersionModel;
import com.aoto.iqms.basicconfig.models.PatchVersionQuery;
import com.aoto.iqms.basicconfig.persistence.inf.PatchVersionMapper;
import com.aoto.iqms.basicconfig.service.inf.PatchVersionService;
import com.aoto.iqms.util.ProcPageFill;


/**
 * 版本管理sevice实现
 * @author daxian
 *
 */
@Service
@Transactional
public class PatchVersionSeviceImpl implements PatchVersionService {
	
	@Autowired
	public PatchVersionMapper patchVersionMapper;
	
	/**
	 * 调用存储过程分页
	 */
	@Override
	public List<Map<String, Object>> procPagePatchVersion(
			PagingCriteria pagingCriteria, PatchVersionQuery model) {
		Map<String, Object> map = new HashMap<String, Object>();
        
        //填充分页和排序信息
        ProcPageFill.fillProcData(model, map,PatchVersion.class);
        //执行查询
        List<Map<String, Object>> list = patchVersionMapper.callPagePatchVersion(map);
        
        //获取存储过程中返回的值
        int total = ((BigDecimal)map.get("totalrows")).intValue();
        pagingCriteria.setTotal(total);
        //获取数据集
        list = (List<Map<String, Object>>)map.get("pageDatas");
		return list;		
	}

	/**
	 * 调用存储过程新增业务类型数据
	 */
	@Override
	public String callCreatePatchVersionProc(PatchVersionModel model) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put(PatchVersion.PATCH_NAME, StringUtils4Aoto.trim(model.getPatchName()));
		map.put(PatchVersion.PATCH_VERNO, StringUtils4Aoto.trim(model.getPatchVerno()));
	    map.put(PatchVersion.PATCH_MD5, StringUtils4Aoto.trim(model.getPatchMd5()));
	    map.put(PatchVersion.PATCH_PATH, StringUtils4Aoto.trim(model.getPatchPath()));
	    map.put(PatchVersion.PATCH_REMARK, StringUtils4Aoto.trim(model.getPatchRemark()));
	    map.put(PatchVersion.STATUS, "1");
	    map.put(PatchVersion.DB_FLAG, StringUtils4Aoto.trim(model.getDbFlag()));
	    map.put(PatchVersion.INTACT_FLAG, StringUtils4Aoto.trim(model.getIntactFlag()));
	     
		//调用持久化方法
		try {
			patchVersionMapper.callInsertPatchVersion(map);
			//获取存储过程的输出参数
			String obj = (String)map.get("ReturnCode");
			return obj;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			return "2"; //执行失败
		}
	}

	/**
	 * 调用存储过程更新数据
	*/ 
	@Override
	public String callUpdatePatchVersionProc(PatchVersionModel model) {
		// TODO Auto-generated method stub
		Map<String, Object> map = new HashMap<String, Object>();
//		 map.put(ClientVersion.ORG_CODE, StringUtils.trim(model.getOrgCode()));
//	     map.put(ClientVersion.VENDER_NO, StringUtils.trim(model.getVenderNo()));
//	     map.put(ClientVersion.ATTACHMENT_PATH, StringUtils.trim(model.getAttachmentPath()));
//	     map.put(ClientVersion.MD5_CODE, StringUtils.trim(model.getMd5Code()));
//	     map.put(ClientVersion.VERSION_NAME, StringUtils.trim(model.getVersionName()));
		//调用持久化方法
		try {
			patchVersionMapper.callUpdtePatchVersion(map);
			//获取存储过程的输出参数
			String obj = (String)map.get("ReturnCode");
			return obj;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			return "2"; //执行失败
		}
	}

	/**
	 * 删除
	 */
	@Override
	public String callRemovePatchVersionProc(List<String> list) {
		
		for (int i = 0 ; i < list.size(); i++){
			Map<String, String> map = new HashMap<String, String>();
			map.put(PatchVersion.ID, StringUtils4Aoto.trim(list.get(i)));
			patchVersionMapper.callDeletePatchVersion(map);
			
		}
		
		
		return "0";
	}

	
	/**
     * 2017-07-08：查询版本
     * @param map
     */
	public List<Map<String, Object>> findPatchVersionByConditon(PatchVersionModel model){
    	Map<String, Object> map = new HashMap<String, Object>();
    	map.put(PatchVersion.ID, StringUtils4Aoto.trim(model.getId()));
    	List<Map<String, Object>> list = patchVersionMapper.findPatchVersionByConditon(map);
    	return list;
    }

	/**
	 * 插入设备更新记录
	 */
	@Override
	public String callInsertUpgrade(int patchId, List<String> devNos) {
		String exceptionInfo = "";
		for (String devNo : devNos) {
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("patchId", patchId);
			map.put("deviceNo", devNo);
			try{
				patchVersionMapper.insertUpgradeProcess(map);
			} catch (Exception e) {
				e.printStackTrace();
				//return "1"; //执行失败
				exceptionInfo+="【"+devNo+","+devNos+"】";
			}
		}
		return exceptionInfo;
		
	}

	@Override
	public String callInsertUpgrade(int patchId) {
		
		return null;
	}
	
	
}
