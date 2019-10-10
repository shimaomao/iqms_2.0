package com.aoto.iqms.basicconfig.web.controllers;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.aoto.framework.commons.beans.JsonResult;
import com.aoto.framework.commons.pagination.PagingCriteria;
import com.aoto.iqms.basicconfig.models.PatchVersionQuery;
import com.aoto.iqms.basicconfig.models.ResourceUploadModel;
import com.aoto.iqms.basicconfig.models.ResourceUploadQuery;
import com.aoto.iqms.basicconfig.service.inf.ResourceUploadService;
import com.aoto.iqms.businessconfig.models.BscCustLevelModel;

/**
 * 资源上传控制类
 * @author zhousj
 *
 */
@Controller
public class ResourceUploadController {
	private static final Logger logger = LoggerFactory.getLogger(ResourceUploadController.class);
	@Autowired
	private ResourceUploadService resourceUploadService;
	
	@RequestMapping(value = "/basicconfig/upload", method = RequestMethod.GET)
	public ModelAndView enterResourceUpload(){
		return new ModelAndView("/basicconfig/resourceupload/list");
	}
	
	/**
     * 查询文件上传历史记录
     * @param model
     * @return
     */
    @RequestMapping(value = "/basicconfig/resourceupload", method = RequestMethod.GET,  headers = "accept=application/json")
    @ResponseBody
    public JsonResult getUploadPageList(ResourceUploadQuery model){
    	
    	PagingCriteria pagingCriteria = new PagingCriteria(model.getPage() - 1, model.getRows(), model.getSort(),
                model.getOrder());
    	List<Map<String, Object>> list = resourceUploadService.procPageResourceUpload(pagingCriteria, model);//调用存储过程进行分页


    	return JsonResult.json(pagingCriteria.getTotal(),list);
    }
	
	@RequestMapping(value = "/basicconfig/fileTree", method = RequestMethod.GET)
    @ResponseBody
    public JsonResult getfileTreeList(String dirPath,String cId){
		List<Map<String, Object>> list = resourceUploadService.fileTree(dirPath,cId);
		return JsonResult.json(0, list);
	}
	
	@RequestMapping(value = "/basicconfig/getFiles", method = RequestMethod.GET)
    @ResponseBody
    public JsonResult getfileList(String dirPath){
		List<Map<String, Object>> list = resourceUploadService.getFileList(dirPath);
		return JsonResult.json(0, list);
	}
	/**
	 * 下发客户端
	 * @return
	 */
	@RequestMapping(value = "/basicconfig/resourceupload/zip", method = RequestMethod.GET)
    @ResponseBody
    public JsonResult zipToClient(){
		resourceUploadService.createPatchZip("", "", "");
		return JsonResult.json("0");
	}
	
	/**
     * 文件上传 并 打包上传后的文件夹 下发客户端
     * @param model
     * @return
     * @throws IOException 
     */
    @RequestMapping(value = "/basicconfig/uploadfile", method = RequestMethod.POST)
    @ResponseBody
    public void createVersion(ResourceUploadModel model,HttpServletRequest request,  
            HttpServletResponse response) throws IOException{
    	String errorCode = "";
    	String opt = request.getParameter("opt");
    	
    	//备注
    	String remark = model.getFileRemark();
    	remark = URLDecoder.decode(remark, "UTF-8");
    	model.setFileRemark(remark);
    	
    	response.setContentType("text/html");
    	
    	
    	//获取上传文件
    	MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
    	//获取上传的文件信息
    	String fName = "";
    	if (opt.equals("add")){
    		fName = "patchFile";
    	} else {
    		fName = "clientInstallEdit";
    	}
    	MultipartFile multipartFile = multipartRequest.getFile(fName);
    	String fileName = multipartFile.getOriginalFilename();
    	
    	//获取文件类型
    	String fileType = fileName.substring(fileName.lastIndexOf("."),fileName.length());
    	model.setFileType(fileType);
    	//设置文件名称
    	fileName = fileName.substring(0, fileName.lastIndexOf("."));
    	model.setFileName(fileName);
//    	String rootpath = request.getSession().getServletContext().getRealPath("/");  
//    	//配置文件夹
//    	String savePath = "/download/patches";
    	String dirPath = model.getFilePath();
    	File dir = new File(dirPath);

    	String realPath = dirPath+"/"+fileName+fileType;
    	
    	FileOutputStream os = null;
    	InputStream io = null;
    	try {
    		  File f = new File(realPath);
    		  os = new FileOutputStream(f);
    		  io = multipartFile.getInputStream();
    		  byte[] datas = new byte[1024];
    		  int len = 0;
    		  while ( -1 != ( len = io.read(datas))){
    			  os.write(datas,0,len);
    			  os.flush();
    		  }
    		  io.close();
    		  os.close();
    		  
    		  if (opt.equals("add")){
    			  errorCode = resourceUploadService.callCreateResourceUploadProc(model);
    		  } 
		} catch (Exception e) {
			logger.debug("上传文件异常：",e);
			errorCode = "3"; //上传文件失败
			io.close();
			os.close();
			response.getOutputStream().write("{\"errorCode\":\"1\"}".getBytes("UTF-8"));
			return ;
		} finally {
			io.close();
			os.close();
		}
        //删除附件
        if (!errorCode.equals("0")){
        	File delFile = new File(realPath);
        	if (delFile.exists()){
        		delFile.delete();
        	}
        }
        if(errorCode.equals("1")){
        	response.getOutputStream().write("{\"errorCode\":\"1\"}".getBytes("UTF-8"));
        }else{
        	response.getOutputStream().write("{\"errorCode\":\"0\"}".getBytes("UTF-8"));
        }
        //打包下发
//        String temp[] = dirPath.split("\\\\"); 
//        resourceUploadService.createPatchZip(dirPath, temp[temp.length-1], remark);
    	return;
    }
    /**
     * 删除服务器上的文件 并将新的文件夹打包 下发到客户端
     * @param list
     * @return
     */
    @RequestMapping(value = "/basicconfig/resourceupload/delete", method = RequestMethod.DELETE)
    @ResponseBody
    public JsonResult delete(@RequestBody List<ResourceUploadModel> list){
    	if(list.size()==0){
    		return JsonResult.json("2");//请选择图片
    	}
    	String dirPath = list.get(0).getFilePath();
    	String dirName = list.get(0).getFileType();
    	//删除文件
    	String remark = "删除图片:";
    	for(int i=0; i<list.size(); i++){
    		String realPath = list.get(i).getFilePath()+"/"+list.get(i).getFileName();
    		if(i != list.size()-1){
    			remark =  remark + list.get(i).getFileName()+",";
    		}else{
    			remark =  remark + list.get(i).getFileName();
    		}
    		File delFile = new File(realPath);
    		if (delFile.exists()){
        		delFile.delete();
        	}
    	}
    	//打包下发
    	resourceUploadService.createPatchZip(dirPath, dirName, remark);
    	return JsonResult.json("0");
    }
}
