package com.aoto.iqms.businessconfig.service.impl;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.imageio.ImageIO;
import javax.servlet.ServletContext;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.WebApplicationContext;

import com.aoto.framework.commons.lang.StringUtils4Aoto;
import com.aoto.iqms.basicconfig.models.DeviceNoModel;
import com.aoto.iqms.basicconfig.models.TakeModelModel;
import com.aoto.iqms.businessconfig.commons.constant.BusinessconfigBeanProperty.BscBranchBusiness;
import com.aoto.iqms.businessconfig.commons.constant.BusinessconfigBeanProperty.BscDevice;
import com.aoto.iqms.businessconfig.models.BscBranchBusinessQuery;
import com.aoto.iqms.businessconfig.models.BscDeviceQuery;
import com.aoto.iqms.businessconfig.persistence.inf.BscDeviceMapper;
import com.aoto.iqms.businessconfig.persistence.inf.TakeConfigMapper;
import com.aoto.iqms.businessconfig.service.inf.BscWinConfigService;
import com.aoto.iqms.businessconfig.service.inf.TakeConfigService;
import com.aoto.iqms.externals.thirdcommunication.SocketRequest;
import com.aoto.iqms.util.DateUtil;
import com.aoto.iqms.util.FileUtils;
import com.aoto.iqms.util.JsonUtils;
import com.aoto.iqms.util.SpringContextUtil;
import com.fasterxml.jackson.core.JsonParseException;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;

/**
 * 取号模板
 * @author humz
 *
 */
@Service
public class TakeConfigServiceImpl implements TakeConfigService{
	
	
	private static final Logger logger = LoggerFactory
			.getLogger(TakeConfigServiceImpl.class);
	

	@Autowired
	private TakeConfigMapper takeConfigMapper;
	@Autowired
	private BscDeviceMapper deviceMapper;
	
	@Autowired
	private BscWinConfigService bscWinConfigService;
	/**
	 * 新增取号模板
	 */
	@Override
	public String addTakeConfig(TakeModelModel model) {
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
			takeConfigMapper.addTakeConfig(map);
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
	public List<Map<String, Object>> selectTakeConfig() {
		List<Map<String, Object>> list = takeConfigMapper.selectTakeConfig();
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
	public List<Map<String, Object>> selectTakeConfigBydeviceNo(DeviceNoModel model) {
		Map<String, Object> map  = new HashMap<String,Object>();
		map.put("orgId", model.getOrgId());
		map.put("deviceNo", model.getDeviceNo());
		takeConfigMapper.selectTakeConfigBydeviceNo(map);
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
	public String deleteTakeConfig(TakeModelModel model) {
		Map<String, Object> map = new HashMap<String,Object>();
		map.put("styleId", model.getStyleId());
		
		try {
			takeConfigMapper.deleteTakeConfig(map);
			String returnCode = (String) map.get("ReturnCode");
			return returnCode;
		} catch (Exception e) {
			e.printStackTrace();
			return "1";
		}
	}

	/**
	 * 获取轮播图片广告
	 */
	@Override
	public List<Map<String, Object>> getPictureList() {
		ServletContext servletContext = ((WebApplicationContext)SpringContextUtil.getApplicationContext()).getServletContext();
        //by hongxz 20171018 获取实际下载路径
		String path = servletContext.getRealPath(File.separator+"WEB-INF");
		
		logger.debug("视频广告地址hongxz编写："+path);
		String webappRoot = path.replaceAll("WEB-INF", "");
		String filePath = webappRoot+"static/components/ticket/images/advs" ;
		File root = new File(filePath);
		File[] files = root.listFiles();
		
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		
		for (File file : files) {
			String fileName = file.getName();
			String[] arr = fileName.split("_");
			Map<String, Object> map = new HashMap<String,Object>();
			map.put("id", arr[0]);
			map.put("name", arr[1]);
			map.put("timeout", arr[2]);
			map.put("ext", arr[3]);
			list.add(map);
		}
		
		return list;
	}

	/**
	 * 获取视频
	 */
	@Override
	public List<Map<String, Object>> getVideoList() {
		
		ServletContext servletContext = ((WebApplicationContext)SpringContextUtil.getApplicationContext()).getServletContext();
        //by hongxz 20171018 获取实际下载路径
		String path = servletContext.getRealPath(File.separator+"WEB-INF");
		
		logger.debug("视频广告地址hongxz编写："+path);
		String webappRoot = path.replaceAll("WEB-INF", "");
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
		ServletContext servletContext = ((WebApplicationContext)SpringContextUtil.getApplicationContext()).getServletContext();
        //by hongxz 20171018 获取实际下载路径
		String path = servletContext.getRealPath(File.separator+"WEB-INF");
		logger.debug("视频广告地址hongxz编写："+path);
		String webappRoot = path.replaceAll("WEB-INF", "");
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
		ServletContext servletContext = ((WebApplicationContext)SpringContextUtil.getApplicationContext()).getServletContext();
        //by hongxz 20171018 获取实际下载路径
		String path = servletContext.getRealPath(File.separator+"WEB-INF");
		logger.debug("视频广告地址hongxz编写："+path);
		String webappRoot = path.replaceAll("WEB-INF", "");
		String filePath = webappRoot +"static/components/ticket/images/background" ;
		logger.debug("视频广告地址hongxz编写："+filePath);
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		
		try {
			File root = new File(filePath);
			File[] files = root.listFiles();
			
			for (File file : files) {
				logger.debug("背景图片绝对路径："+file.getAbsolutePath());
				BufferedImage bfi = ImageIO.read(file);
				int width = bfi.getWidth();  
				int height = bfi.getHeight();
				String imgName = file.getName();
				String fullPath = file.getAbsolutePath();
				fullPath = fullPath.replaceAll("\\\\", "/");
				String[] strarr = fullPath.split("webapps");
				fullPath = strarr[1];
				Map<String, Object> map = new HashMap<String,Object>();
				map.put("width", width);   //背景图片长
				map.put("height", height); //背景图片高
				map.put("imgName", imgName); //图片名称
				map.put("fullPath", fullPath); //图片物理位置
				list.add(map);
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
		return list;
	}

	/**
	 * 查询树形业务
	 */
	@Override
	public List<Map<String, Object>> selectBuzTime(String deviceNo) {
		Map<String, Object> map = new HashMap<String,Object>();
		map.put("treePid", 0);
		map.put("deviceNo", deviceNo);
		List<Map<String, Object>> list = takeConfigMapper.selectBuzTime(map);
		return list;
  }

	/**
	 * 根据设备查询取号模板样式
	 */
	@Override
	public Map<String, Object> getStyle(Map<String, Object> map) {
		String styleId = (String) map.get("styleId");
		String screenResolution = (String) map.get("screenResolution");
		String dateTypeId = (String) map.get("dateTypeId");
		String stylePath = (String) map.get("stylePath");
		String orgId = (String) map.get("orgId");
		String deviceNo = (String) map.get("deviceNo");
		
		String styleName ="";
		String styleType = "";
		String copyStatus= "";
		
		
			
		//查询模板样式
		Map<String, Object> map2 = new HashMap<String,Object>();
		
		map2.put("styleId", styleId);
		map2.put("screenResolution", screenResolution);
		map2.put("dateTypeId", dateTypeId);
		map2.put("orgId", orgId);
		map2.put("deviceNo", deviceNo);
		
		takeConfigMapper.getStyle(map2);
		
		//查询出模板的基本信息(查询一条信息)
		List<Map<String, Object>> modelStyleInfos = (List<Map<String, Object>>) map2.get("modelStyleInfo");
		
		//查询出的模板信息
		if (modelStyleInfos != null && modelStyleInfos.size() > 0){
			Map<String, Object> modelSyleMap = modelStyleInfos.get(0);
			styleId = modelSyleMap.get("styleId") == null ? "" : modelSyleMap.get("styleId").toString();
			styleName = modelSyleMap.get("styleName") == null ? "" : modelSyleMap.get("styleName").toString();
			styleType = modelSyleMap.get("styleType") == null ? "" : modelSyleMap.get("styleType").toString();
			screenResolution = modelSyleMap.get("screenResolution") == null ? "" : modelSyleMap.get("screenResolution").toString();
			stylePath = modelSyleMap.get("stylePath") == null ? "" : modelSyleMap.get("stylePath").toString();
			copyStatus = modelSyleMap.get("copyStatus") == null ? "" : modelSyleMap.get("copyStatus").toString();
			dateTypeId = modelSyleMap.get("dateTypeId") == null ? "" : modelSyleMap.get("dateTypeId").toString();
		}
		
		//查询出来就是 界面元素
		List<Map<String, Object>> list = (List<Map<String, Object>>) map2.get("pageDatas");
		
		Map<String, Object> mapOffest = new HashMap<String,Object>();
		mapOffest.put("x", 0);
		mapOffest.put("y", 0);
		Map<String, Object> mapPrint = new HashMap<String,Object>();
		mapPrint.put("offset", mapOffest);
		mapPrint.put("dpi", 100);
		mapPrint.put("items", list);
		
		Map<String, Object> mapQueueTemplate = new HashMap<String,Object>();
		mapQueueTemplate.put("screenResolution", screenResolution);
		mapQueueTemplate.put("dateTypeId", dateTypeId);
		mapQueueTemplate.put("copyStatus", copyStatus.equals("1")?true:false);
		mapQueueTemplate.put("stylePath", stylePath);
		mapQueueTemplate.put("print", mapPrint);
		
		Map<String, Object> mapStyle = new HashMap<String,Object>();
		mapStyle.put("styleId", styleId);
		mapStyle.put("styleName", styleName);
		mapStyle.put("styleType", styleType);
		
		Map<String, Object> mapModelQueue = new HashMap<String,Object>();
		mapModelQueue.put("style", mapStyle);
		mapModelQueue.put("queueTemplate", mapQueueTemplate);
		
		return mapModelQueue;
	}

	/**
	 * 保存取号配置
	 */
	@Override
	public String saveConfig(Map<String, Object> map) {
		//获取提交的参数
		String styleId = (String) map.get("styleId");  //模板id
		String styleName = (String) map.get("styleName"); //模板名称
		int styleType = (int) map.get("styleType"); //固定为3
		String screenResolution = (String) map.get("screenResolution"); //屏幕分辨率
		String dateTypeId = (String) map.get("dateTypeId");  //日期类型
		boolean copyStatus = (boolean) map.get("copyStatus");  //是否工作日和假日相同
		//String stylePath = (String) map.get("stylePath");  
		Map<String, Object> printMap = (Map<String, Object>) map.get("print");  //取号界面配置内容
		boolean defboolean=  (boolean) map.get("def");  //是否默认模板
		int def = (defboolean==true?1:0);
		String copyStatusStr = (copyStatus==true?"1":"0");
		String orgId = (String) map.get("orgId");  //机构id
		String deviceNo = (String) map.get("deviceNo");  //设备编号
		
		Map<String, Object> map2= new HashMap<String,Object>();
		map2.put("styleId", styleId);
		map2.put("styleName", styleName);
		map2.put("styleType", styleType);
		map2.put("screenResolution", screenResolution);
		map2.put("dateTypeId", dateTypeId);
		map2.put("def", def);
		map2.put("orgId", orgId);
		map2.put("deviceNo", deviceNo);
		map2.put("copyStatus", copyStatusStr);
		
		//保存模板信息
		takeConfigMapper.saveConfig(map2);  
		String ReturnCode = "";
		ReturnCode = (String) map2.get("ReturnCode");
		String modeStyelId = (String) map2.get("modeStyelId");
		
		if(ReturnCode.equals("0") && printMap.get("items") != null){  //保存界面元素
			//界面元素项
			List<Map<String, Object>> items = (List<Map<String,Object>>)printMap.get("items");
			
			for (Map<String, Object> itemMap : items) {
				itemMap.put("modelStyleId", modeStyelId);
				itemMap.put("orgId", orgId);
				itemMap.put("deviceNo", deviceNo);
				if (itemMap.get("buzTypeId") ==null) {
					itemMap.put("buzTypeId", "");
				}
				if (itemMap.get("type") == null) {
					itemMap.put("type", "");
				}
				if (itemMap.get("orgType") ==null) {
					itemMap.put("orgType", "");
				}
				if (itemMap.get("x") ==null) {
					itemMap.put("x", 0);
				}
				if (itemMap.get("y") ==null) {
					itemMap.put("y", 0);
				}
				if (itemMap.get("width") ==null) {
					itemMap.put("width", 0);
				}
				if (itemMap.get("height") ==null) {
					itemMap.put("height", 0);
				}
				if (itemMap.get("family") ==null) {
					itemMap.put("family", "");
				}
				if (itemMap.get("style") ==null) {
					itemMap.put("style", "normal");
				}
				if (itemMap.get("backgroundColor") ==null) {
					itemMap.put("backgroundColor", "");
				}
				if (itemMap.get("fontColor") ==null) {
					itemMap.put("fontColor", "");
				}
				if (itemMap.get("size") ==null) {
					itemMap.put("size", "");
				}
				if (itemMap.get("icon") ==null) {
					itemMap.put("icon", "");
				}
				if (itemMap.get("iconPosition") ==null) {
					itemMap.put("iconPosition", "");
				}
				if (itemMap.get("borderRadius") ==null) {
					itemMap.put("borderRadius", "normal");
				}
				if (itemMap.get("topLeft1") ==null) {
					itemMap.put("topLeft1", 0);
				}
				if (itemMap.get("topRight1") ==null) {
					itemMap.put("topRight1", 0);
				}
				if (itemMap.get("bottomRight1") ==null) {
					itemMap.put("bottomRight1", 0);
				}
				if (itemMap.get("bottomLeft1") ==null) {
					itemMap.put("bottomLeft1", 0);
				}
				if (itemMap.get("bottomLeft2") ==null) {
					itemMap.put("bottomLeft2", 0);
				}
				if (itemMap.get("bottomRight2") ==null) {
					itemMap.put("bottomRight2", 0);
				}
				if (itemMap.get("topRight2") ==null) {
					itemMap.put("topRight2", 0);
				}
				if (itemMap.get("topLeft2") ==null) {
					itemMap.put("topLeft2", 0);
				}
				if (itemMap.get("shape") ==null) {
					itemMap.put("shape", "normal");
				}
				if (itemMap.get("shadow") ==null) {
					itemMap.put("shadow", "normal");
				}
				if (itemMap.get("shadowH") ==null) {
					itemMap.put("shadowH", 0);
				}
				if (itemMap.get("shadowV") ==null) {
					itemMap.put("shadowV", 0);
				}
				if (itemMap.get("shadowBlur") ==null) {
					itemMap.put("shadowBlur", 0);
				}
				if (itemMap.get("skew") ==null) {
					itemMap.put("skew", "normal");
				}
				if (itemMap.get("skewH") ==null) {
					itemMap.put("skewH", 0);
				}
				if (itemMap.get("skewV") ==null) {
					itemMap.put("skewV", 0);
				}
				if (itemMap.get("rotate") ==null) {
					itemMap.put("rotate", "normal");
				}
				if (itemMap.get("angleOfRotationX") ==null) {
					itemMap.put("angleOfRotationX", 0);
				}
				if (itemMap.get("angleOfRotationY") ==null) {
					itemMap.put("angleOfRotationY", 0);
				}
				if (itemMap.get("angleOfRotationZ") ==null) {
					itemMap.put("angleOfRotationZ", 0);
				}
				if (itemMap.get("effect") ==null) {
					itemMap.put("effect", "normal");
				}
				if (itemMap.get("scrollAmount") ==null) {
					itemMap.put("scrollAmount", 0);
				}
				if (itemMap.get("direction") ==null) {
					itemMap.put("direction", "");
				}
				if (itemMap.get("childrenPageImg") ==null) {
					itemMap.put("childrenPageImg", "");
				}
				if (itemMap.get("childrenPageColor") ==null) {
					itemMap.put("childrenPageColor", "");
				}
				if (itemMap.get("backgroundImage") ==null) {
					itemMap.put("backgroundImage", "");
				}
				if (itemMap.get("text") ==null) {
					itemMap.put("text", "");
				}
				//保存界面元素
				takeConfigMapper.saveQueueElement(itemMap);
			}
		}
		return ReturnCode;
	}
	
	
	/**
	 * 保存取号配置（用于导航配置）
	 */
	@Override
	public String saveConfig4nav(Map<String, Object> map) {
		//获取提交的参数
		String styleId = (String) map.get("styleId");  //模板id
		String styleName = (String) map.get("styleName"); //模板名称
		boolean defboolean=  (boolean) map.get("def");  //是否默认模板
		int def = (defboolean==true?1:0);
		String orgId = (String) map.get("orgId");  //机构id
		String deviceNo = (String) map.get("deviceNo");  //设备编号
		String ReturnCode = "";
		
		//模板不存在，就先保存一个模板(给Map添加一个模板id)
		if (StringUtils4Aoto.isBlank(styleId)) {
			Map<String, Object> takeModeMap= new HashMap<String,Object>();
			takeModeMap.put("styleName", styleName);
			takeModeMap.put("def", def);
			takeModeMap.put("orgId", orgId);
			takeModeMap.put("deviceNo", deviceNo);
			takeConfigMapper.addTakeConfig4nav(takeModeMap);  
			ReturnCode = (String) takeModeMap.get("ReturnCode");
			styleId = (String) takeModeMap.get("styleId");
			if(!ReturnCode.equals("0")){
				return ReturnCode;
			}
			map.put("styleId", styleId);
		} 
		
		//调用保存样式
		ReturnCode = saveConfig(map);
		
		return ReturnCode;
	}


	
	/**
	 * 根据设备号查询，提供排队机下载
	 */
	@Override
	public void createTakeConfig(BscBranchBusinessQuery model,String path) {
//		String classPath = this.getClass().getResource("/").getPath().replaceFirst("/", "");//E:/apache-tomcat-7.0.75/webapps/iqms-web/WEB-INF/classes/
//		String webappRoot = classPath.replaceAll("WEB-INF/classes/", "");//E:/apache-tomcat-7.0.75/webapps/iqms-web/
//		webappRoot = webappRoot.replaceAll("////", "\\");//E:\apache-tomcat-7.0.75\webapps\iqms-web\
//		String path = webappRoot +"\\download";
		//String path = "iqms-web\\download";
		//注意：由于排队机只提供了机构和设备号，并没有精确到分辨率、日期等条件，因此会查询出多个样式
		Map<String, Object> map = new HashMap<String,Object>();
		map.put("orgId", model.getOrgId());
		map.put("deviceNo", model.getDeviceNo());
		
		takeConfigMapper.selectTakeConfigBydeviceNo(map);
		List<Map<String, Object>> list = (List<Map<String, Object>>) map.get("pageDatas");
		if(list.size() == 0){
			return;
		}
		for (Map<String, Object> map2 : list) {
			if(map2.get("def").equals("1")){
				map.put("screenResolution", map2.get("screenResolution"));
				map.put("styleId", map2.get("styleId"));
				for(int i=1; i<3; i++){//dateTypeId
					map.put("dateTypeId", i+"");
					String fileName = map.get("screenResolution")+"_"+map.get("dateTypeId");
					if(map.get("styleId")!=null){
						fileName += "_"+map2.get("styleId");
					}
					Map<String, Object> map3 = new HashMap<String,Object>();
					map3 = getStyle(map);
					try {
						String json = JsonUtils.obj2json(map3);
						FileUtils.outPutFiles(json, path+File.separator+"temp",path+File.separator+"temp"+File.separator+fileName+".json");
						//存放历史文件路径
						String path2 = path+File.separator+model.getOrgId()+"_"+model.getDeviceNo();
						FileUtils.outPutFiles(json, path2,path2+File.separator+fileName+"_"+DateUtil.getNow()+".json");
						
					} catch (Exception e) {
						e.printStackTrace();
					}
				
				}
			}
		}
	}
	
	
	public List<Map<String, Object>> checkedQueueface(TakeModelModel model){
		Map<String, Object> map = new HashMap<String, Object>();
		map.put(BscBranchBusiness.DEVICE_NO, StringUtils4Aoto.trim(model.getDeviceNo()));
		List<Map<String, Object>> list = takeConfigMapper.checkedQueueface(map);
		return list;
	}
	
	 
	 public List<Map<String, Object>> navQueuefaceModel(TakeModelModel model){
		Map<String, Object> map = new HashMap<String, Object>();
		map.put(BscBranchBusiness.DEVICE_NO, StringUtils4Aoto.trim(model.getDeviceNo()));
		List<Map<String, Object>> list = takeConfigMapper.navQueuefaceModel(map);
		return list;
	 }

	@Override
	public String callSaveTakeConfigProc(BscDeviceQuery model) {
		List<Map<String, Object>> list = bscWinConfigService.createOrgIdDeviceNo(model.getOrgDevicelist());
		//根据用户所属机构查询所有下级机构和设备号
//		List<Map<String, Object>> orgList = ztreeOrgDevice(model.getTargetId());
		for(int i=0; i<list.size(); i++){
			Map<String, Object> map = list.get(i);
			map.put(BscDevice.ORG_ID, model.getOrgId());
			map.put(BscDevice.DEVICE_NO, model.getDeviceNo());
			takeConfigMapper.callCopyTakeConfig(map);
		}
		return "0";
	}

	
}