package com.aoto.iqms.basicconfig.web.controllers;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.aoto.framework.commons.beans.JsonResult;
import com.aoto.framework.commons.pagination.PagingCriteria;
import com.aoto.iqms.basicconfig.models.PatchVersionModel;
import com.aoto.iqms.basicconfig.models.PatchVersionQuery;
import com.aoto.iqms.basicconfig.service.inf.PatchVersionService;
import com.aoto.iqms.util.MD5Util;
import com.aoto.iqms.util.PropetiesLoader;


/**
 * (新)版本控制层
 * @author daxian
 *
 */
@Controller
public class PatchVersionController {
	
	private static final Logger logger = LoggerFactory.getLogger(PatchVersionController.class);
	
    
	@Autowired
	private PatchVersionService patchVersionService;  //注入业务层对象
	
	
	/**
     * 版本管理页面
     * @author daxian
     */
    @RequestMapping(value = "/basicconfig/patchversion", method = RequestMethod.GET)
    public ModelAndView enterPatchPage()
    {
        return new ModelAndView("basicconfig/patchversion/list");
    }
    
    
    /**
     * 版本管理分页。
     * @param model
     * @return
     */
    @RequestMapping(value = "/basicconfig/patchversion", method = RequestMethod.GET,  headers = "accept=application/json")
    @ResponseBody
    public JsonResult getPatchPageList(PatchVersionQuery model){
    	
    	PagingCriteria pagingCriteria = new PagingCriteria(model.getPage() - 1, model.getRows(), model.getSort(),
                model.getOrder());
    	List<Map<String, Object>> list = patchVersionService.procPagePatchVersion(pagingCriteria, model);//调用存储过程进行分页
    	
    	return JsonResult.json(pagingCriteria.getTotal(),list);
    	//return JsonResult.Json(model.getRows(), model.getPage(), pagingCriteria.getTotal(), list);
    	
    }
    
    
    /**
     * 版本管理新增/编辑。
     * @param model
     * @return
     * @throws IOException 
     */
    @RequestMapping(value = "/basicconfig/patchversion", method = RequestMethod.POST)
    @ResponseBody
    public void createVersion(PatchVersionModel model,HttpServletRequest request,  
            HttpServletResponse response) throws IOException{
    	String errorCode = "";
    	String opt = request.getParameter("opt");
    	
    	//备注
    	String remark = model.getPatchRemark();
    	remark = URLDecoder.decode(remark, "UTF-8");
    	model.setPatchRemark(remark);
    	
    	response.setContentType("text/html");
//    	HttpHeaders headers = new HttpHeaders();
//    	headers.setContentType(MediaType.TEXT_PLAIN);
    	
    	
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
    	
    	//设置版本名称
    	String versionName = fileName.substring(0, fileName.lastIndexOf("."));
    	model.setPatchName(versionName);
    	
/*    	String rootpath = request.getSession().getServletContext().getRealPath("/");  
    	//配置文件夹
    	String savePath = "/download/patches";
    	String dirPath = rootpath+savePath;*/
    	// 升级包文件移至项目外的指定路径中  by tianjm 20190304
    	String dirPath = PropetiesLoader.getSystemConfig().getString("patch_path","d:/patch_path");
    	File dir = new File(dirPath);
    	if (!dir.exists()){
    		dir.mkdirs(); 
    	}
    	fileName = System.currentTimeMillis()+"_"+fileName;
    	String realPath = dirPath+"/"+fileName;
    	
    	FileOutputStream os = null;
    	InputStream io = null;
    	try {
    		  File f = new File(realPath);
    		  //FileUtils.writeByteArrayToFile(f,multipartFile.getBytes());
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
    		  boolean useMd5 = PropetiesLoader.getSystemConfig().getBoolean("usemd5");
    		  logger.debug("是否使用md5:"+useMd5);
    		  if (useMd5){
    			  //计算文件的md5码
    			  String md5Code = MD5Util.getFileMD5String(f);
    			  logger.debug("上传文件的md5码===>："+md5Code);
    			  model.setPatchMd5(md5Code);
    		  }
    		  
//    		  model.setPatchPath(savePath+"/"+fileName);
    		  model.setPatchPath(fileName);
    		  if (opt.equals("add")){
    			  errorCode = patchVersionService.callCreatePatchVersionProc(model);
    		  } else {
    			  errorCode = patchVersionService.callUpdatePatchVersionProc(model);
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
    	return;
    }
  
    
    
    /**
     * 版本管理删除
     * @param list
     * @return
     */
    @RequestMapping(value = "/basicconfig/clientversion",  method = RequestMethod.DELETE)
    @ResponseBody
    public JsonResult removeVersions(@RequestBody List<String> list,HttpServletRequest request)
    {
    	String rootpath = request.getSession().getServletContext().getRealPath("/")+"version";  
    	String errorCode = patchVersionService.callRemovePatchVersionProc(list);
        return JsonResult.json(errorCode);
    }
    
    /**
     * 更新包应用到设备
     * @param model
     * @return
     */
    @RequestMapping(value = "/basicconfig/patchdeviceapply/{patchId}", method = RequestMethod.POST,  headers = "accept=application/json")
    @ResponseBody
    public JsonResult applyDevs(@PathVariable int patchId ,@RequestBody List<String> devNos){
    	String result = patchVersionService.callInsertUpgrade(patchId, devNos);
    	return JsonResult.json(result);
    }
    
    
    
    /**
     * 处理版本请求和下载
     * @param request
     * @param response
     * @return
     */
    @RequestMapping(value = "/basicconfig/patchdownload", method = RequestMethod.GET)
    @ResponseBody
    public void dealHttpRequest(HttpServletRequest request,  
            HttpServletResponse response) throws Exception{
    	String errorCode = "";
    	String path = "";
    	String downPatchId = request.getParameter("patchId"); //要下载的版本号
    	String deviceId = request.getParameter("deviceId");//设备编号
    	
    	String md5Code = "";
    	//String version = request.getParameter("version");
    	logger.debug("==========================排队机终端版本下载开始==================================");
    	logger.debug("版本下载===>下载的版本号:"+downPatchId);
    	logger.debug("版本下载===>设备id:"+deviceId);
    	PatchVersionModel model = new PatchVersionModel();
    	model.setId(downPatchId);
//    	//查询版本信息
		List<Map<String, Object>> dataMaps = patchVersionService.findPatchVersionByConditon(model);
		if (dataMaps != null && dataMaps.size() > 0){
			Map<String, Object> fields = dataMaps.get(0);
			path = fields.get("patchPath").toString(); //新版本的位置
			
			//有时候版本不一定会记录附件的md5信息
			if (fields.get("patchMd5") != null){
				md5Code = fields.get("patchMd5").toString();//获取md5码
			}
//				
	    	logger.debug("版本下载===>版本地址:"+path);
	    	logger.debug("版本下载===>MD5:"+md5Code);
			 response.setContentType("text/html;charset=UTF-8");   
		     BufferedInputStream in = null;  
		     BufferedOutputStream out = null;  
		     request.setCharacterEncoding("UTF-8");
//		     String rootpath = request.getSession().getServletContext().getRealPath("/");
		    	// 升级包文件移至项目外的指定路径中  by tianjm 20190304
	    	 String dirPath = PropetiesLoader.getSystemConfig().getString("patch_path","d:/patch_path");
		     String filePath = dirPath+"/"+path;
		     String fileName = filePath.substring(filePath.lastIndexOf("/")+1);
		        try {  
		            File f = new File(filePath);
		            response.setContentType("application/x-gzip");
		            response.setCharacterEncoding("UTF-8");  
		            response.setHeader("Content-Disposition", "attachment; filename="+fileName);  
		            response.setHeader("Content-Length",String.valueOf(f.length()));  
		            in = new BufferedInputStream(new FileInputStream(f));
		            out = new BufferedOutputStream(response.getOutputStream());  
		            byte[] data = new byte[1024];  
		            int len = 0;  
		            while (-1 != (len=in.read(data))) {  
		                out.write(data, 0, len);
		                out.flush();
		            }  
		        } catch (Exception e) {  
		            e.printStackTrace();  
		        } finally {  
		            if (in != null) {  
		                in.close();  
		            }  
		            if (out != null) {  
		                out.close();  
		            }  
		        }  
		}
    	logger.debug("==========================排队机终端版本下载结束==================================");
    }
    
    /**
     * 处理浏览器版本包下载 20190304 tianjm
     * @param request
     * @param response
     * @return
     */
    @RequestMapping(value = "/basicconfig/patch/download", method = RequestMethod.GET)
    @ResponseBody
    public void patchDownload(HttpServletRequest request, HttpServletResponse response) throws Exception{
    	logger.debug("==========================浏览器终端下载升级包开始==================================");
    	String filePath = request.getParameter("filePath");
    	logger.debug("版本下载===>filePath:"+filePath);
		response.setContentType("text/html;charset=UTF-8");   
		BufferedInputStream in = null;  
		BufferedOutputStream out = null;  
		request.setCharacterEncoding("UTF-8");
    	String dirPath = PropetiesLoader.getSystemConfig().getString("patch_path","d:/patch_path");
		String fileName = dirPath+"/"+filePath;
		try {  
			File f = new File(fileName);
			response.setContentType("application/x-gzip");
			response.setCharacterEncoding("UTF-8");  
			response.setHeader("Content-Length",String.valueOf(f.length()));  

			String browser = ""; //配置下载的文件名
			try {
				browser = request.getHeader("User-Agent");
				if (-1 < browser.indexOf("MSIE 6.0") || -1 < browser.indexOf("MSIE 7.0")) {
					// IE6, IE7 浏览器
					response.addHeader("content-disposition",
							"attachment;filename=" + new String(filePath.getBytes(), "ISO8859-1"));
				} else if (-1 < browser.indexOf("MSIE 8.0")) {
					// IE8
					response.addHeader("content-disposition",
							"attachment;filename=" + URLEncoder.encode(filePath, "UTF-8"));
				} else if (-1 < browser.indexOf("MSIE 9.0")) {
					// IE9
					response.addHeader("content-disposition",
							"attachment;filename=" + URLEncoder.encode(filePath, "UTF-8"));
				} else if (-1 < browser.indexOf("Chrome")) {
					// 谷歌
					response.addHeader("content-disposition",
							"attachment;filename=" + URLEncoder.encode(filePath, "UTF-8"));
				} else if (-1 < browser.indexOf("Safari")) {
					// 苹果
					response.addHeader("content-disposition",
							"attachment;filename=" + new String(filePath.getBytes(), "ISO8859-1"));
				} else {
					// 火狐或者其他的浏览器
					response.addHeader("content-disposition","attachment;filename*=UTF-8''" + URLEncoder.encode(filePath, "UTF-8"));
//					response.addHeader("content-disposition","attachment;filename=" + URLEncoder.encode(filePath, "UTF-8"));
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
			
			in = new BufferedInputStream(new FileInputStream(f));
			out = new BufferedOutputStream(response.getOutputStream());  
			byte[] data = new byte[1024];  
			int len = 0;  
			while (-1 != (len=in.read(data))) {  
				out.write(data, 0, len);
				out.flush();
			}  
		} catch (Exception e) {  
			e.printStackTrace();  
		} finally {  
			if (in != null) {  
				in.close();  
			}  
			if (out != null) {  
				out.close();  
			}  
		}  
    	logger.debug("==========================浏览器终端下载升级包结束==================================");
    }
    
    
    /**
     * http服务端测试
     * @param request
     * @param response
     * @return
     */
    @RequestMapping(value = "/basicconfig/httptest", method = RequestMethod.POST)
    @ResponseBody
    public void httpServerTest(HttpServletRequest request,  
            HttpServletResponse response) throws Exception{
    	
    	String itemName = PropetiesLoader.getSystemConfig().getString("itemName");
		String floorNO = PropetiesLoader.getSystemConfig().getString("floorNO");
		
		InputStream in =  request.getInputStream();
		
		byte[] data = new byte[1024];
		
		int len = 0;
		
		byte[] destData = new byte[2048];
		
		int index = 0;
		
		//len = in.read(data);
		
		while ((len = in.read(data)) != -1) {
			System.arraycopy(data,0,destData,index,len);
			index += len;
		}
		
		String recivStr = new String(destData,0,index,"UTF-8");
		
//		String recivStr = new String(data,0,len,"UTF-8");
		
		
		logger.info("接收到的请求报文："+recivStr);
		
		
		
		/*String resp = "{"+
			    "\"head\":{"+
	        	"\"transCode\":\"Y001\","+
	        	"\"transDateTime\":\"2017-05-05 12:08:16\","+
	        	"\"transStatus\":\"0000\","+
	        	"\"transDescription\":\"success\""+
	    		"},"+
	    	"\"data\":{"+
	         "\"orgId\":\"2468\","+
	         "\"busType\":\"Y\","+
	         "\"ticketLevel\":\"1\","+
	         "\"itemName\": \""+itemName+"\","+
	         "\"mobileCheckCode\":\"2457\","+
	         "\"winNO\":\"8\","+
	         "\"floorNO\":\""+floorNO+"\","+
	         "\"area\":\"A\""+
	    	"}"+
		"}";*/
		String resp = "{"+"\"rtnCode\":\"0\""+"}";
		
		
//		String resp = "{"+
//					    "\"head\":{"+
//					        "\"transCode\":\""+transCode+"\","+
//					        "\"transDateTime\":\"2017-05-05 12:08:16\","+
//					        "\"transStatus\":\""+transStatus+"\","+
//					        "\"transDescription\":\"成功\""+
//					    "},"+
//					    "\"data\":{"+
//					        "\"result\":\"0\""+
//					    "}"+
//					"}";
		logger.info("输出内容："+resp);
		
		//response.
		
		response.getOutputStream().write(resp.getBytes("UTF-8"));
//		response.getWriter().write(recivStr);
		//response.getWriter().write(resp);
    	
    	
    }
    
    

}
