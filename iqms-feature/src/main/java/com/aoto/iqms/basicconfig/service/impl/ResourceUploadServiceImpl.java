package com.aoto.iqms.basicconfig.service.impl;

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.math.BigDecimal;
import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.context.WebApplicationContext;

import com.aoto.framework.commons.lang.StringUtils4Aoto;
import com.aoto.framework.commons.pagination.PagingCriteria;
import com.aoto.iqms.basicconfig.commons.constant.BasicconfigBeanProperty.PatchVersion;
import com.aoto.iqms.basicconfig.commons.constant.BasicconfigBeanProperty.ResourceUpload;
import com.aoto.iqms.basicconfig.models.PatchVersionModel;
import com.aoto.iqms.basicconfig.models.ResourceUploadModel;
import com.aoto.iqms.basicconfig.models.ResourceUploadQuery;
import com.aoto.iqms.basicconfig.persistence.inf.PatchVersionMapper;
import com.aoto.iqms.basicconfig.persistence.inf.ResourceUploadMapper;
import com.aoto.iqms.basicconfig.service.inf.PatchVersionService;
import com.aoto.iqms.basicconfig.service.inf.ResourceUploadService;
import com.aoto.iqms.externals.persistence.inf.ResourceMapper;
import com.aoto.iqms.util.FileUtils;
import com.aoto.iqms.util.MD5Util;
import com.aoto.iqms.util.ProcPageFill;
import com.aoto.iqms.util.PropetiesLoader;
import com.aoto.iqms.util.SpringContextUtil;

/**
 * 资源上传的实现
 * @author zhousj
 *
 */
@Service
@Transactional
public class ResourceUploadServiceImpl implements ResourceUploadService{
	
	private static final Logger logger = LoggerFactory.getLogger(ResourceUploadServiceImpl.class);
	@Autowired
	public ResourceUploadMapper uploadMapper;
	@Autowired
	public ResourceMapper resourceMapper;
	@Autowired
	public PatchVersionMapper versionMapper;
	@Override
	public List<Map<String, Object>> fileTree(String dirPath,String cId) {
		String path = "";
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		Map<String, Object> map = new HashMap<String, Object>();
		if(StringUtils4Aoto.isEmpty(dirPath)){
			ServletContext servletContext = ((WebApplicationContext)SpringContextUtil.getApplicationContext()).getServletContext();
			String imagePath = PropetiesLoader.getSystemConfig().getString("imagePath", "");
			path = servletContext.getRealPath(File.separator+imagePath);
			File f = new File(path);
			map.put("pId", 0);
			map.put("cId", 1);
			map.put("dirPath", f.getPath());
			map.put("dirName", f.getName());
			map.put("isParent", true);
			// 加载一级节点
	        List<Map<String, Object>> returnList1 = new ArrayList<Map<String, Object>>();
	        tree(f,returnList1,1);
	        map.put("children", returnList1);
	        list.add(map);
	        return list;
		}else{
			// 加载子节点
			File f = new File(dirPath);
			tree(f,list,Integer.parseInt(cId));
			return list;
		}
		
	}
	
	private void tree(File file, List<Map<String, Object>> list,int cId){
		File[] childs = file.listFiles();
//		boolean isDir = false;//是否是目录
		for (int i = 0; i < childs.length; i++) {
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("pId", cId);
			map.put("cId", cId+i+1);
			map.put("dirPath", childs[i].getPath());
			map.put("dirName", childs[i].getName());
			if (childs[i].isDirectory()) {
				map.put("isParent", true);
            }else{
            	map.put("isParent", false);
            }
			list.add(map);
		}
	}
	public static void main(String[] args) {
//		String s = "D:/zsj/apache-tomcat-7.0.77/apache-tomcat-7.0.77/webapps/iqms-web/static/components/ticket/images/background";
//		String[] ss = s.split("webapps");
//		System.out.println(ss[1]);
	}

	@Override
	public List<Map<String, Object>> getFileList(String dirPath) {
		File file = new File(dirPath);
		File[] childs = file.listFiles();
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		String filePath = (dirPath.split("webapps"))[1];
		for (int i = 0; i < childs.length; i++) {
			String name = childs[i].getName(); 
			if(name.endsWith(".jpg")||name.endsWith(".png")){
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("fileName", name);
				map.put("filePath", filePath+File.separator+name);
				list.add(map);
			}
		}
		return list;
	}


	@Override
	public String callCreateResourceUploadProc(ResourceUploadModel model) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put(ResourceUpload.FILE_NAME, StringUtils4Aoto.trim(model.getFileName()));
		map.put(ResourceUpload.FILE_PATH, StringUtils4Aoto.trim(model.getFilePath()));
	    map.put(ResourceUpload.FILE_TYPE, StringUtils4Aoto.trim(model.getFileType()));
	    map.put(ResourceUpload.FILE_REMARK, StringUtils4Aoto.trim(model.getFileRemark()));
	  //调用持久化方法
	    try {
  			uploadMapper.callInsertResourceUpload(map);
  			//获取存储过程的输出参数
  			String obj = (String)map.get("ReturnCode");
  			return obj;
  		} catch (Exception e) {
  			// TODO: handle exception
  			e.printStackTrace();
  			return "1"; //执行失败
  		}
	}


	@Override
	public List<Map<String, Object>> procPageResourceUpload(PagingCriteria pagingCriteria, ResourceUploadQuery model) {
		Map<String, Object> map = new HashMap<String, Object>();
		//填充分页和排序信息
        ProcPageFill.fillProcData(model, map,ResourceUpload.class);
        //执行查询
        List<Map<String, Object>> list = uploadMapper.callPageResourceUpload(map);
        //获取存储过程中返回的值
        int total = ((BigDecimal)map.get("totalrows")).intValue();
        pagingCriteria.setTotal(total);
        //获取数据集
        list = (List<Map<String, Object>>)map.get("pageDatas");
		return list;		
	}

	
	@Override
	public String createPatchZip(String dirPath, String dirName, String remark) {
		//备注
    	try {
    		PatchVersionModel model = new PatchVersionModel();
			remark = URLDecoder.decode(remark, "UTF-8");
			//设置版本名称
			ServletContext servletContext = ((WebApplicationContext)SpringContextUtil.getApplicationContext()).getServletContext();
			String imagePath = PropetiesLoader.getSystemConfig().getString("imagePath", "");
			String path = servletContext.getRealPath(File.separator+imagePath);
	    	String patchName = "delete";
	    	//设置文件路径
	    	String fileName = System.currentTimeMillis()+"_"+patchName+".zip";
	    	logger.info("资源上传：打包的文件名为"+fileName);
	    	String patchPath = "/download/patches/"+fileName;
	    	String realPath = servletContext.getRealPath(File.separator+patchPath);
	    	logger.info("资源上传：打包的文件路径为"+realPath);
	    	//生成压缩包到/download/patches/
	    	//创建符合客户端结构的文件夹打包后删除
	    	String tmp = servletContext.getRealPath(File.separator+PropetiesLoader.getSystemConfig().getString("clientPath", ""));
	    	logger.info("资源上传：用于打包的源文件夹路径为"+tmp);
	    	File resource = new File(tmp);
	    	if (!resource.exists()) {
	    		resource.mkdirs();
			}
	    	File file = new File(path);
	    	org.apache.commons.io.FileUtils.copyDirectory(file, resource);
	    	
	    	FileUtils.createZip(servletContext.getRealPath(File.separator+"/client"), servletContext.getRealPath(File.separator+"/download/patches/"), fileName);
	    	File tmpFile = new File(servletContext.getRealPath(File.separator+"/client"));
	    	FileUtils.deleteFile(tmpFile);
	    	File f = new File(realPath);
	    	String md5Code = MD5Util.getFileMD5String(f);
	    	
	    	model.setPatchName(patchName);
	    	model.setPatchVerno("");
	    	model.setPatchMd5(md5Code);
	    	model.setPatchPath(patchPath);
	    	model.setPatchRemark(remark);
	    	model.setDbFlag("0");
	    	model.setIntactFlag("1");
	    	//插入数据到bc_patchversion
	    	Map<String, Object> map = new HashMap<String, Object>();
			map.put(PatchVersion.PATCH_NAME, StringUtils4Aoto.trim(model.getPatchName()));
			map.put(PatchVersion.PATCH_VERNO, StringUtils4Aoto.trim(model.getPatchVerno()));
		    map.put(PatchVersion.PATCH_MD5, StringUtils4Aoto.trim(model.getPatchMd5()));
		    map.put(PatchVersion.PATCH_PATH, StringUtils4Aoto.trim(model.getPatchPath()));
		    map.put(PatchVersion.PATCH_REMARK, StringUtils4Aoto.trim(model.getPatchRemark()));
		    map.put(PatchVersion.STATUS, "1");
		    map.put(PatchVersion.DB_FLAG, StringUtils4Aoto.trim(model.getDbFlag()));
		    map.put(PatchVersion.INTACT_FLAG, StringUtils4Aoto.trim(model.getIntactFlag()));
		    versionMapper.callInsertPatchVersion(map);
	    	//应用到设备
		    Map<String, Object> map1 = new HashMap<String, Object>();
		    String patchId = map.get("patchId") == null ? "" : map.get("patchId").toString();
			map1.put("patchId", patchId);
	    	versionMapper.allInsertUpgradeProcess(map);
		} catch (UnsupportedEncodingException e) {
			logger.info("编码转换异常:"+e);
			e.printStackTrace();
		} catch (IOException e) {
			logger.info("生成md5异常:"+e);
			e.printStackTrace();
		} catch (Exception e) {
			logger.info("生成zip异常:"+e);
			e.printStackTrace();
		}
    	
		return "0";
	}
}
