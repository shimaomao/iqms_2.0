package com.aoto.iqms.report.web.controllers;

import static com.aoto.iqms.util.logManagerUtil.RarUtils.unRarFile;
import static com.aoto.iqms.util.logManagerUtil.TargzUtils.unTargzFile;
import static com.aoto.iqms.util.logManagerUtil.ZipUtils.unZipFiles;
import static com.aoto.iqms.util.logManagerUtil.ZipUtils.zipFiles;
import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.URLConnection;
import java.net.URLEncoder;
import java.nio.file.DirectoryStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.attribute.BasicFileAttributes;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.zip.ZipOutputStream;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.io.FileUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.servlet.ModelAndView;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.aoto.framework.commons.beans.JsonResult;
import com.aoto.framework.commons.pagination.PagingCriteria;
import com.aoto.iqms.basicconfig.models.BusinessManageQuery;
import com.aoto.iqms.basicconfig.models.PatchVersionQuery;
import com.aoto.iqms.basicconfig.service.inf.PatchVersionService;
import com.aoto.iqms.util.PropetiesLoader;
import com.aoto.iqms.util.SpringContextUtil;
import com.aoto.iqms.util.logManagerUtil.LogUtils;

/**
 * (新)日志管理控制层 
 * 接受日志管理相关的所有请求，包括请求界面显示数据、文件下载、文件预览、文件夹压缩、解压zip格式文件、重命名文件...
 * @author pzw
 * 
 */
@Controller
public class LogDownLoadController {

	private static final Logger logger = LoggerFactory.getLogger(LogDownLoadController.class);
	/*
	 * 文件管理根目录
	 */
	public static String ROOT = PropetiesLoader.getSystemConfig().getString("logManager.path");

	/**
	 * 日志管理页面
	 * 
	 * @author pzw
	 */
	@RequestMapping(value = "/report/logManager", method = RequestMethod.GET)
	public ModelAndView enterLogManagerPage() {
		return new ModelAndView("report/logManager/list");
	}

	/**
	 * 查询日志目录结构
	 * 
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/basicconfig/fileTree1", method = RequestMethod.GET)
	@ResponseBody
	public JsonResult getAllBus(BusinessManageQuery model, HttpServletRequest request) {

		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		
//		Map<String,Object> map = new HashMap<String,Object>();
//		map.put("data", "xxx");
//		map.put("type", "001");
//		System.out.println(LogUtils.insertOperationLog(map));
		
		return JsonResult.json(0, list);
		
		//return null;
	}


	/**
	 * 展示日志文件目录列表
	 */
	@RequestMapping("/fileManager/list")
	@ResponseBody
	public Object list(@RequestBody JSONObject json) throws ServletException {

		try {
			//ROOT = PropetiesLoader.getSystemConfig().getString("logManager.path");
			// 需要显示的目录路径
			String path = json.getString("path");

			// 返回的结果集
			List<JSONObject> fileItems = new ArrayList<>();

			try (DirectoryStream<Path> directoryStream = Files.newDirectoryStream(Paths.get(ROOT, path))) {

				String DATE_FORMAT = "yyyy-MM-dd HH:mm:ss";
				SimpleDateFormat dt = new SimpleDateFormat(DATE_FORMAT);
				for (Path pathObj : directoryStream) {
					// 获取文件基本属性
					BasicFileAttributes attrs = Files.readAttributes(pathObj, BasicFileAttributes.class);

					// 封装返回JSON数据
					JSONObject fileItem = new JSONObject();
					fileItem.put("name", pathObj.getFileName().toString());
					// fileItem.put("rights",
					// com.example.demo.shaofan.utils.FileUtils.getPermissions(pathObj));
					// 获取文件权限
					fileItem.put("date", dt.format(new Date(attrs.lastModifiedTime().toMillis())));
					fileItem.put("size", attrs.size());
					fileItem.put("type", attrs.isDirectory() ? "dir" : "file");
					fileItems.add(fileItem);
				}
			} catch (IOException e) {
				logger.error("展示日志文件目录列表发生异常！" + e.getMessage());
				e.printStackTrace();
			}
			JSONObject jsonObject = new JSONObject();
			jsonObject.put("result", fileItems);
			return jsonObject;
		} catch (Exception e) {
			logger.error("展示日志文件目录列表发生异常！" + e.getMessage());
			return error(e.getMessage());
		}
	}

	/**
	 * 文件上传
	 * 此功能废弃
	 */
	@RequestMapping("/fileManager/upload")
	@ResponseBody
	public Object upload(@RequestParam("destination") String destination, HttpServletRequest request) {

		try {
			// Servlet3.0方式上传文件
			/*
			 Collection<Part> parts = request.getParts();
			 for (Part part : parts) {
			 	if (part.getContentType() != null) { // 忽略路径字段,只处理文件类型
			 	String path = ROOT + destination;
			
			 	File f = new File(path,
			 	com.example.demo.shaofan.utils.FileUtils.getFileName(part.getHeader("content-disposition")));
			 	if(!com.example.demo.shaofan.utils.FileUtils.write(part.getInputStream(),f)) {		
			 		throw new Exception("文件上传失败");
			 	}
			 }
		  }
			 */
			return success();
		} catch (Exception e) {
			return error(e.getMessage());
		}
	}

	/**
	 * 文件下载/预览 GET
	 */
	@RequestMapping("/fileManager/preview")
	@ResponseBody
	public void preview(HttpServletResponse response, String path) throws IOException {

		File file = new File(ROOT, path);
		if (!file.exists()) {
			response.sendError(HttpServletResponse.SC_NOT_FOUND, "Resource Not Found");
			return;
		}

		/*
		 * 获取mimeType
		 */
		String mimeType = URLConnection.guessContentTypeFromName(file.getName());
		if (mimeType == null) {
			mimeType = "application/octet-stream";
		}

		response.setContentType(mimeType);
		response.setHeader("Content-disposition",
				String.format("attachment; filename=\"%s\"", URLEncoder.encode(file.getName(), "UTF-8")));
		response.setContentLength((int) file.length());

		try (InputStream inputStream = new BufferedInputStream(new FileInputStream(file))) {
			FileCopyUtils.copy(inputStream, response.getOutputStream());
		}
	}

	/**
	 * 创建目录 post
	 */
	@RequestMapping("/fileManager/createFolder")
	@ResponseBody
	public Object createFolder(@RequestBody JSONObject json) {
		try {
			String newPath = json.getString("newPath");
			File newDir = new File(ROOT + newPath);
			if (!newDir.mkdir()) {
				throw new Exception("不能创建目录: " + newPath);
			}
			return success();
		} catch (Exception e) {
			return error(e.getMessage());
		}
	}

	/**
	 * 修改文件或目录权限 
	 * 该功能已经废弃
	 */
	@RequestMapping("/fileManager/changePermissions")
	@ResponseBody
	public Object changePermissions(@RequestBody JSONObject json) {
		try {

			String perms = json.getString("perms"); // 权限
			boolean recursive = json.getBoolean("recursive"); // 子目录是否生效

			JSONArray items = json.getJSONArray("items");
			for (int i = 0; i < items.size(); i++) {
				String path = items.getString(i);
				File f = new File(ROOT, path);
				com.aoto.iqms.util.logManagerUtil.FileUtils.setPermissions(f, perms, recursive); // 设置权限
			}
			return success();
		} catch (Exception e) {
			return error(e.getMessage());
		}
	}

	/**
	 * 复制文件或目录 post
	 */
	@RequestMapping("/fileManager/copy")
	@ResponseBody
	public Object copy(@RequestBody JSONObject json, HttpServletRequest request) {
		try {
			String newpath = json.getString("newPath");
			JSONArray items = json.getJSONArray("items");

			for (int i = 0; i < items.size(); i++) {
				String path = items.getString(i);

				File srcFile = new File(ROOT, path);
				File destFile = new File(ROOT + newpath, srcFile.getName());

				FileCopyUtils.copy(srcFile, destFile);
			}
			return success();
		} catch (Exception e) {
			return error(e.getMessage());
		}
	}

	/**
	 * 移动文件或目录 post
	 */
	@RequestMapping("/fileManager/move")
	@ResponseBody
	public Object move(@RequestBody JSONObject json) {
		try {
			String newpath = json.getString("newPath");
			JSONArray items = json.getJSONArray("items");

			for (int i = 0; i < items.size(); i++) {
				String path = items.getString(i);

				File srcFile = new File(ROOT, path);
				File destFile = new File(ROOT + newpath, srcFile.getName());

				if (srcFile.isFile()) {
					FileUtils.moveFile(srcFile, destFile);
				} else {
					FileUtils.moveDirectory(srcFile, destFile);
				}
			}
			return success();
		} catch (Exception e) {
			return error(e.getMessage());
		}
	}

	/**
	 * 删除文件或目录 post
	 */
	@RequestMapping("/fileManager/remove")
	@ResponseBody
	public Object remove(@RequestBody JSONObject json) {
		try {
			JSONArray items = json.getJSONArray("items");
			for (int i = 0; i < items.size(); i++) {
				String path = items.getString(i);
				File srcFile = new File(ROOT, path);
				if (!FileUtils.deleteQuietly(srcFile)) {
					throw new Exception("删除失败: " + srcFile.getAbsolutePath());
				}
			}
			return success();
		} catch (Exception e) {
			return error(e.getMessage());
		}
	}

	/**
	 * 重命名文件或目录 post
	 */
	@RequestMapping("/fileManager/rename")
	@ResponseBody
	public Object rename(@RequestBody JSONObject json) {
		try {
			String path = json.getString("item");
			String newPath = json.getString("newItemPath");

			File srcFile = new File(ROOT, path);
			File destFile = new File(ROOT, newPath);
			if (srcFile.isFile()) {
				FileUtils.moveFile(srcFile, destFile);
			} else {
				FileUtils.moveDirectory(srcFile, destFile);
			}
			return success();
		} catch (Exception e) {
			return error(e.getMessage());
		}
	}

	/**
	 * 查看文件内容,针对html、txt等可编辑文件 post
	 */
	@RequestMapping("/fileManager/getContent")
	@ResponseBody
	public Object getContent(@RequestBody JSONObject json) {
		try {
			String path = json.getString("item");
			File srcFile = new File(ROOT, path);

			String content = FileUtils.readFileToString(srcFile);

			JSONObject jsonObject = new JSONObject();
			jsonObject.put("result", content);
			return jsonObject;
		} catch (Exception e) {
			return error(e.getMessage());
		}
	}

	/**
	 * 修改文件内容,针对html、txt等可编辑文件 post
	 */
	@RequestMapping("/fileManager/edit")
	@ResponseBody
	public Object edit(@RequestBody JSONObject json) {
		try {
			String path = json.getString("item");
			String content = json.getString("content");

			File srcFile = new File(ROOT, path);
			FileUtils.writeStringToFile(srcFile, content);

			return success();
		} catch (Exception e) {
			return error(e.getMessage());
		}
	}

	/**
	 * 文件压缩 post
	 */
	@RequestMapping("/fileManager/compress")
	@ResponseBody
	public Object compress(@RequestBody JSONObject json) {
		try {
			String destination = json.getString("destination");
			String compressedFilename = json.getString("compressedFilename");
			JSONArray items = json.getJSONArray("items");
			List<File> files = new ArrayList<>();
			for (int i = 0; i < items.size(); i++) {
				File f = new File(ROOT, items.getString(i));
				files.add(f);
			}

			File zip = new File(ROOT + destination, compressedFilename);

			try (ZipOutputStream out = new ZipOutputStream(new FileOutputStream(zip))) {
				zipFiles(out, "", files.toArray(new File[files.size()]));
			}
			return success();
		} catch (Exception e) {
			return error(e.getMessage());
		}
	}

	/**
	 * 文件解压 post
	 */
	@RequestMapping("/fileManager/extract")
	@ResponseBody
	public Object extract(@RequestBody JSONObject json) {
		try {
			String destination = json.getString("destination");
			String zipName = json.getString("item");
			String folderName = json.getString("folderName");
			File file = new File(ROOT, zipName);

			String extension = com.aoto.iqms.util.logManagerUtil.FileUtils.getExtension(zipName);
			switch (extension) {
			case ".zip":
				unZipFiles(file, ROOT + destination);
				break;
			case ".gz":
				unTargzFile(file, ROOT + destination);
				break;
			case ".rar":
				unRarFile(file, ROOT + destination);
			}
			return success();
		} catch (Exception e) {
			return error(e.getMessage());
		}
	}

	/**
	 * 返回错误信息
	 * @param msg
	 * @return
	 */
	private JSONObject error(String msg) {
		// { "result": { "success": false, "error": "msg" } }
		JSONObject result = new JSONObject();
		result.put("success", false);
		result.put("error", msg);
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("result", result);
		return jsonObject;

	}
	
	/**
	 * 返回成功信息
	 * @return
	 */
	private JSONObject success() {
		// { "result": { "success": true, "error": null } }
		JSONObject result = new JSONObject();
		result.put("success", true);
		result.put("error", null);
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("result", result);
		return jsonObject;
	}

}
