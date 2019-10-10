package com.aoto.iqms.basicconfig.service.impl;

import java.awt.image.BufferedImage;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileOutputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.imageio.ImageIO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.aoto.iqms.basicconfig.models.DeviceNoModel;
import com.aoto.iqms.basicconfig.models.TakeModelModel;
import com.aoto.iqms.basicconfig.persistence.inf.TakeModelMapper;
import com.aoto.iqms.basicconfig.service.inf.TakeModelService;
import com.fasterxml.jackson.annotation.JsonInclude.Include;
import com.fasterxml.jackson.core.JsonParseException;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

/**
 * 取号模板
 * @author humz
 *
 */
@Service
public class TakeModelServiceImpl implements TakeModelService{

	@Autowired
	private TakeModelMapper takeModelMapper;
	
	/**
	 * 新增取号模板
	 */
	@Override
	public String addTakeModel(TakeModelModel model) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("styleId", model.getStyleId());
		map.put("styleName", model.getStyleName());
		String defstr = model.getDef();
		if(defstr.equals("true")){
			defstr = "1";
		}else{
			defstr = "0";
		}
		int def = Integer.parseInt(defstr);
		map.put("def", def);
		map.put("styleType", model.getStyleType());
		map.put("orgId", model.getOrgId());
		map.put("deviceNo", model.getDeviceNo());
		try {
			takeModelMapper.addTakeModel(map);
			String returnCode = (String) map.get("ReturnCode");
			return returnCode;
		} catch (Exception e) {
			e.printStackTrace();
			return "1";//执行失败
		}
	}

	/**
	 * 查询所有取号模板
	 */
	@Override
	public List<Map<String, Object>> selectTakeModel() {
		List<Map<String, Object>> list = takeModelMapper.selectTakeModel();
		Map<String, Object> map = new HashMap<String,Object>();
		map.put("takeModels", list);
		List<Map<String, Object>> list2 = new ArrayList<Map<String, Object>>();
		list2.add(map);
		return list2;
	}

	/**
     * 根据设备号查询取号模板
     */
	@Override
	public List<Map<String, Object>> selectTakeModelBydeviceNo(DeviceNoModel model) {
		Map<String, Object> map  = new HashMap<String,Object>();
		map.put("orgId", model.getOrgId());
		map.put("deviceNo", model.getDeviceNo());
		takeModelMapper.selectTakeModelBydeviceNo(map);
		List<Map<String, Object>> list = (List<Map<String, Object>>) map.get("pageDatas");
		
		Map<String, Object> map2 = new HashMap<String,Object>();
		map2.put("takeModels", list);
		List<Map<String, Object>> list2 = new ArrayList<Map<String, Object>>();
		list2.add(map2);
		return list2;
	}
	
	/**
	 * 删除取号模板
	 */
	@Override
	public String deleteTakeModel(TakeModelModel model) {
		Map<String, Object> map = new HashMap<String,Object>();
		map.put("styleId", model.getStyleId());
		
		try {
			takeModelMapper.deleteTakeModel(map);
			String returnCode = (String) map.get("ReturnCode");
			return returnCode;
		} catch (Exception e) {
			e.printStackTrace();
			return "1";
		}
	}

	 /**
     * 查询大元素列表
     */
	@Override
	public Map<String, Object> selectSettings() {
		List<Map<String, Object >> list = takeModelMapper.selectSettings();
		List<String> list2 = new ArrayList<String>();
		
		for (Map<String, Object > map : list) {
			for (String key : map.keySet()) {
				String value = (String) map.get(key);
				list2.add(value);
			}
		}
		List<String> list3 = new ArrayList<String>();
		List<String> list4 = new ArrayList<String>();
		for (int i = 0; i < list2.size(); i++) {
			if (i%2 == 0) {
				list3.add(list2.get(i));//存放所有偶数下标的值为值
			} else {
				list4.add(list2.get(i));//存放所有奇数下标的值为键
			}
		}
		Map<String, Object> newMap = new HashMap<String,Object>();
		for (int i = 0; i < list4.size(); i++) {
			String key = list4.get(i);
			String value = list3.get(i);
			newMap.put(key, value);
		}
		return newMap;
	}
	
	 /**
     * 根据type查询大元素列表
     */
	@Override
	public List<Map<String, Object>> selectSettingsbyType(Map<String, Object> map) {
		List<Map<String, Object >> list = takeModelMapper.selectSettingsbyType(map);
		return list;
	}
	/**
	 * 获取视频
	 */
	@Override
	public List<Map<String, Object>> getVideoList() {
		String classPath = this.getClass().getResource("/").getPath().replaceFirst("/", "");
		String webappRoot = classPath.replaceAll("WEB-INF/classes/", "");
		String filePath = webappRoot+"static/lib2/media/video" ;
		File root = new File(filePath);
		File[] files = root.listFiles();
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		
		for (File file : files) {
			String fileName = file.getName();
			String fullPath = file.getAbsolutePath();
			Map<String, Object> map = new HashMap<String,Object>();
			map.put("fileName", fileName);
			map.put("fullPath", fullPath);
			list.add(map);
		}
		return list;
	}

	/**
	 * 获取音乐
	 */
	@Override
	public List<Map<String, Object>> getMusicList() {
		String classPath = this.getClass().getResource("/").getPath().replaceFirst("/", "");
		String webappRoot = classPath.replaceAll("WEB-INF/classes/", "");
		String filePath = webappRoot+"static/lib2/media/music" ;
		File root = new File(filePath);
		File[] files = root.listFiles();
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		
		for (File file : files) {
			String fileName = file.getName();
			String fullPath = file.getAbsolutePath();
			Map<String, Object> map = new HashMap<String,Object>();
			map.put("fileName", fileName);
			map.put("fullPath", fullPath);
			list.add(map);
		}
		return list;
	}

	/**
	 * 获取背景图片
	 */
	@Override
	public List<Map<String, Object>> getBackgroundImgs() {
		String classPath = this.getClass().getResource("/").getPath().replaceFirst("/", "");
		String webappRoot = classPath.replaceAll("WEB-INF/classes/", "");
		String filePath = webappRoot +"static/components/ticket/images/background" ;
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		
		try {
			File root = new File(filePath);
			File[] files = root.listFiles();
			
			for (File file : files) {
				BufferedImage bfi = ImageIO.read(file);
				int width = bfi.getWidth();
				int height = bfi.getHeight();
				String imgName = file.getName();
				String fullPath = file.getAbsolutePath();
				fullPath = fullPath.replaceAll("\\\\", "/");
				String[] strarr = fullPath.split("webapps");
				fullPath = strarr[1];
				Map<String, Object> map = new HashMap<String,Object>();
				map.put("width", width);
				map.put("height", height);
				map.put("imgName", imgName);
				map.put("fullPath", fullPath);
				list.add(map);
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
		return list;
	}


	/**
     * 获取小元素列表
     */
	@Override
	public List<Map<String, Object>> selectQueueCtrl() {
		List<Map<String, Object>> list = takeModelMapper.selectQueueCtrl();
		return list;
	}

	/**
	 * 查询树形业务
	 */
	@Override
	public List<Map<String, Object>> selectBuzTime(int treePid) {
		Map<String, Object> map = new HashMap<String,Object>();
		map.put("treePid", treePid);
		List<Map<String, Object>> list = takeModelMapper.selectBuzTime(map);
		return list;
  }

	/**
	 * 根据ID查询取号模板样式
	 */
	@Override
	public Map<String, Object> getStyle(Map<String, Object> map) {
		String styleId = (String) map.get("styleId");
		String screenResolution = (String) map.get("screenResolution");
		String dateTypeId = (String) map.get("dateTypeId");
		String stylePath = (String) map.get("stylePath");
		String orgId = (String) map.get("orgId");
		String deviceNo = (String) map.get("deviceNo");
		
		//查询是否为默认模板
		Map<String, Object> def = new HashMap<String,Object>();
		def.put("styleId", styleId);
		Map<String, Object> defMap = takeModelMapper.selectDef(def);
		String defstr = (String) defMap.get("def");
		
		//查询模板样式
		Map<String, Object> map2 = new HashMap<String,Object>();
		
		map2.put("styleId", styleId);
		map2.put("screenResolution", screenResolution);
		map2.put("dateTypeId", dateTypeId);
		map2.put("orgId", orgId);
		map2.put("deviceNo", deviceNo);
		
		takeModelMapper.getStyle(map2);
		List<Map<String, Object>> list = (List<Map<String, Object>>) map2.get("pageDatas");
		Map<String, Object> styleMap = new HashMap<String, Object>();
		for (Map<String, Object> returnMap : list) {
			styleMap = returnMap;
		}
		String strResult = (String) styleMap.get("styleValue");
		
		ObjectMapper objMapper = new ObjectMapper();  
		Map<String, Object> map3 = new HashMap<String,Object>();
		Map<String, Object> map4 = new HashMap<String,Object>();
		Map<String, Object> map5 = new HashMap<String,Object>();
		Map<String, Object> map6 = new HashMap<String,Object>();
		
		if (null!= strResult) {
			try {
				map3 = objMapper.readValue(strResult, Map.class);//json转为map集合
				map4.put("screenResolution", screenResolution);
				map4.put("dateTypeId", dateTypeId);
				map4.put("stylePath", stylePath);
				map4.put("print", map3);
				map5.put("styleId", styleId);
				map6.put("style", map5);
				map6.put("queueTemplate", map4);
				map6.put("def", defstr);
				
			} catch (JsonParseException e) {
				e.printStackTrace();
			} catch (JsonMappingException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}else {
				map4.put("screenResolution", screenResolution);
				map4.put("dateTypeId", dateTypeId);
				map4.put("stylePath", stylePath);
				map5.put("styleId", styleId);
				map6.put("style", map5);
				map6.put("queueTemplate", map4);
				map6.put("def", defstr);
		}
		return map6;
	}

	/**
	 * 保存取号配置
	 */
	@Override
	public String saveConfig(Map<String, Object> map) {
		String styleId = (String) map.get("styleId");
		String styleName = (String) map.get("styleName");
		int styleType = (int) map.get("styleType");
		String screenResolution = (String) map.get("screenResolution");
		String dateTypeId = (String) map.get("dateTypeId");
		boolean copyStatus = (boolean) map.get("copyStatus");
		//String stylePath = (String) map.get("stylePath");
		Map<String, Object> printMap = (Map<String, Object>) map.get("print");
		ObjectMapper mapper = new ObjectMapper();
		String print = "";
		try {
			print = mapper.writeValueAsString(printMap);//map转json 
		} catch (JsonProcessingException e1) {
			e1.printStackTrace();
		}
		boolean defboolean=  (boolean) map.get("def");
		int def = (defboolean==true?1:0);
		String orgId = (String) map.get("orgId");
		String deviceNo = (String) map.get("deviceNo");
		
		Map<String, Object> map2= new HashMap<String,Object>();
		map2.put("styleId", styleId);
		map2.put("styleName", styleName);
		map2.put("styleType", styleType);
		map2.put("screenResolution", screenResolution);
		map2.put("dateTypeId", dateTypeId);
		map2.put("styleValue", print);
		map2.put("def", def);
		map2.put("orgId", orgId);
		map2.put("deviceNo", deviceNo);
		
		String ReturnCode = "";
		if (copyStatus==false) {
			takeModelMapper.saveConfig(map2);
		    ReturnCode = (String) map2.get("ReturnCode");
		}else{
			if (dateTypeId.equals("1")) {
				takeModelMapper.saveConfig(map2);//执行第一次
				map2.replace("dateTypeId",2);
				takeModelMapper.saveConfig(map2);//执行第二次
				ReturnCode = (String) map2.get("ReturnCode");
			}else{
				takeModelMapper.saveConfig(map2);//执行第一次
				map2.replace("dateTypeId",1);
				takeModelMapper.saveConfig(map2);//执行第二次
				ReturnCode = (String) map2.get("ReturnCode");
			}
		}
		
		return ReturnCode;
	}

	
}