package com.aoto.iqms.businessconfig.service.impl;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.aoto.framework.commons.beans.JsonUtils;
import com.aoto.framework.commons.lang.StringUtils4Aoto;
import com.aoto.iqms.businessconfig.commons.constant.BusinessconfigBeanProperty.BscBranchBusiness;
import com.aoto.iqms.businessconfig.commons.constant.BusinessconfigBeanProperty.BscCustLevel;
import com.aoto.iqms.businessconfig.commons.constant.BusinessconfigBeanProperty.BscCustRegconition;
import com.aoto.iqms.businessconfig.commons.constant.BusinessconfigBeanProperty.BscDevice;
import com.aoto.iqms.businessconfig.commons.constant.BusinessconfigBeanProperty.BscWinConfig;
import com.aoto.iqms.businessconfig.models.BscBranchBusinessQuery;
import com.aoto.iqms.businessconfig.models.BscCustRecognitionModel;
import com.aoto.iqms.businessconfig.models.BscCustRecognitionQuery;
import com.aoto.iqms.businessconfig.models.SettingsModel;
import com.aoto.iqms.businessconfig.models.TicketFormModel;
import com.aoto.iqms.businessconfig.persistence.inf.NumberFormMapper;
import com.aoto.iqms.businessconfig.persistence.inf.TicketFormMapper;
import com.aoto.iqms.businessconfig.service.inf.BscWinConfigService;
import com.aoto.iqms.businessconfig.service.inf.TicketFormService;
import com.aoto.iqms.util.DateUtil;
import com.aoto.iqms.util.FileUtils;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

/**
 * 号票模板-业务层
 * @author humz
 *
 */
@Service
public class TicketFormServiceImpl implements TicketFormService{

	@Autowired
	private TicketFormMapper ticketFormMapper;
	@Autowired
	private NumberFormMapper numberFormMapper;
	
	@Autowired
	private BscWinConfigService bscWinConfigService;
	/**
	 * 号票模板新增
	 */
	@Override
	public String addTicketForm(TicketFormModel model) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("tktTmpId", model.getTktTmpId());
		map.put("tktTmpName", model.getTktTmpName());
		map.put("orgId", model.getOrgId());
		map.put("deviceNo", model.getDeviceNo());
		String defstr = model.getDef();
		if(defstr.equals("true")){
			defstr = "1";
		}else{
			defstr = "0";
		}
		int def = Integer.parseInt(defstr);
		map.put("def", def);
		map.put("tktFormatId", model.getTktFormatId());
		map.put("tktFormat", model.getTktFormat());
		
		try {
			ticketFormMapper.addTicketForm(map);
			String obj = (String) map.get("ReturnCode");
			return obj;
		} catch (Exception e) {
			e.printStackTrace();
			return "1";//执行失败
		}
	}

	/**
	 * 号票模板查询
	 */
	@Override
	public List<Map<String, Object>> selectTicketForm(TicketFormModel model) {
		List<Map<String, Object>> list = ticketFormMapper.selectTicketForm(model);
		Map<String, Object> map = new HashMap<String,Object>();
		map.put("tktFormats", list);
		List<Map<String, Object>> list2 = new ArrayList<Map<String, Object>>();
		list2.add(map);
		return list2;
	}


	/**
	 * 号票模板编辑
	 */
	@Override
	public String updateTicketForm(TicketFormModel model) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("tktTmpId", model.getTktTmpId());
		map.put("tktTmpName", model.getTktTmpName());
		map.put("orgId", model.getOrgId());
		map.put("deviceNo", model.getDeviceNo());
		String defstr = model.getDef();
		if(defstr.equals("true")){
			defstr = "1";
		}else{
			defstr = "0";
		}
		int def = Integer.parseInt(defstr);
		map.put("def", def);
		map.put("tktFormatId", model.getTktFormatId());
		map.put("tktFormat", model.getTktFormat());
		
		try {
			ticketFormMapper.updateTicketForm(map);
			String obj = (String) map.get("ReturnCode");
			return obj;
		} catch (Exception e) {
			e.printStackTrace();
			return "1";//执行失败
		}
	}
	
	/**
	 * 号票模板删除
	 */
	@Override
	public String deleteTicketForm(TicketFormModel model) {
		Map<String, Object> map = new HashMap<String,Object>();
		map.put("tktTmpId",model.getTktTmpId());
		map.put("orgId", model.getOrgId());
		map.put("deviceNo", model.getDeviceNo());
		try {
			ticketFormMapper.deleteTicketForm(map);
			String obj = (String) map.get("ReturnCode");
			return obj;
		} catch (Exception e) {
			e.printStackTrace();
			return "1";//执行失败
		}
	}

	/**
	 * 根据ID查询单条号票数据
	 */
	@Override
	public Map<String, Object> selectOneTicketForm(TicketFormModel model) {
		Map<String, Object> map = new HashMap<String,Object>();
		map.put("tktTmpId", model.getTktTmpId());
		map.put("orgId", model.getOrgId());
		map.put("deviceNo", model.getDeviceNo());
		map = ticketFormMapper.selectOneTicketForm(map);
		return map;
	}

	/**
	 * 根据类型查询元素列表配置
	 */
	@Override
	public Map<String, Object> selectSettings(SettingsModel model) {
		Map<String, Object> map = new HashMap<String,Object>();
		map.put("type", model.getType());
		List<Map<String, Object>> list = ticketFormMapper.selectSettings(map); 
		map.put("settings", list);
		return map;
	}
	
	/**
	 * 号票预览
	 */
	@Override
	public String previewTicketform(TicketFormModel model) {
		String tktTmpStyle = ticketFormMapper.previewTicketform(model);
		//String json = "";
		
		if("".equals(tktTmpStyle) || tktTmpStyle==null){
			return "0";
		}else{
			/*if(tktTmpStyle.indexOf("\"")== 0){
				tktTmpStyle = tktTmpStyle.substring(1, tktTmpStyle.length());//去掉第一个"
			}
			if(tktTmpStyle.lastIndexOf("\"")==(tktTmpStyle.length()-1)){
				tktTmpStyle = tktTmpStyle.substring(0, tktTmpStyle.length()-1);//去掉最后一个 " 
			}
			
			ObjectMapper mapper = new ObjectMapper();//转换器
			try {
				json = mapper.writeValueAsString(tktTmpStyle);//map转json字符串
				
			} catch (JsonProcessingException e) {
				e.printStackTrace();
			}
			return json;	*/
			return tktTmpStyle;
		}
	}

	/**
	 * 保存号票样式
	 */
	@Override
	public String saveTicketform(Map<String, Object> map) {
		
		//获取模板数据
		Map<String, Object> map2  = (Map<String, Object>) map.get("ticketTemplate");
		String tktTmpId =  (String) map2.get("tktTmpId");  //号票模板id
		String tktTmpName =  (String) map2.get("tktTmpName");  //号票模板名称
		boolean defstr =  (boolean) map2.get("def");  //是否默认模板
		String tktFormatId =  (String) map2.get("tktFormatId");  //号码模板id
		String tktFormat =  (String) map2.get("tktFormat");    //号码模板格式
		String orgId =  (String) map2.get("orgId");    //号码模板格式
		String deviceNo =  (String) map2.get("deviceNo");    //号码模板格式
		
		//保存的参数
		Map<String, Object> map3 = new HashMap<String,Object>();
		map3.put("tktTmpId", tktTmpId);
		map3.put("tktTmpName", tktTmpName);
		
		int def = (defstr==true?1:0);
		
		map3.put("def", def);
		map3.put("tktFormatId", tktFormatId);
		map3.put("tktFormat", tktFormat);
		
		map3.put("orgId", orgId);
		map3.put("deviceNo", deviceNo);
		
		
		ObjectMapper mapper = new ObjectMapper();
		try {
			//获取号票打印内容
			map.remove("ticketTemplate"); //删除ticketTemplate里面的内容
			String json = mapper.writeValueAsString(map);//里面只有打印的内容{"print":{......}}
			map3.put("tktTmpStyle",json);
		} catch (JsonProcessingException e1) {
			e1.printStackTrace();
		}
		
		try {
			ticketFormMapper.saveTicketform(map3);
			String obj = (String) map3.get("ReturnCode");
			return obj;
		} catch (Exception e) {
			e.printStackTrace();
			return "1";//执行失败
		}
	}

	@Override
	public String callCopyTicketProc(TicketFormModel model) {
		List<Map<String, Object>> list = bscWinConfigService.createOrgIdDeviceNo(model.getOrgDevicelist());
		for(int i=0; i<list.size(); i++){
			Map<String, Object> map = list.get(i);
			map.put(BscCustLevel.ORG_ID, model.getOrgId());
			map.put(BscCustLevel.DEVICE_NO, model.getDeviceNo());
			ticketFormMapper.callCopyTicket(map);
		}
		return "0";
	}
	
	@Override
	public void createTktFormats(BscBranchBusinessQuery model,String path) {
		//String path = "iqms-web\\download";
		List<Map<String, Object>> list = procTktFormatsQuery(model);
		if(list.size() == 0){
			return;
		}
		List<Map<String, Object>> tktFormatsList = new ArrayList<Map<String, Object>>();
		List<Map<String, Object>> tktFormatsList1 = numberFormMapper.callTktFormatsByTktId();
		for(int i=0; i<tktFormatsList1.size(); i++){
//			Map<String, Object> tktMap = new HashMap<String, Object>(); 
//			tktMap.put("tktFormatId", list.get(i).get("tktFormatId"));
			
			
//			Map<String, Object> tktFormatMap = new HashMap<String, Object>();
//			tktFormatMap.put("tktFormatId", tktFormatsList1.get(0).get("tktFormatId"));
//			tktFormatMap.put("tktFormat", tktFormatsList1.get(0).get("tktFormat"));
			
			Map<String, Object> map1 = new HashMap<String, Object>();
			map1.put("tktFormat", tktFormatsList1.get(i));
			tktFormatsList.add(map1);
		}
		try {
			Map<String, Object> map2 = new HashMap<String, Object>();
			map2.put("tktFormat", tktFormatsList);
			String json = JsonUtils.obj2json(map2);
			FileUtils.outPutFiles(json, path+File.separator+"temp",path+File.separator+"temp"+File.separator+"tktFormats.json");
			//存放历史文件路径
			String path2 = path+File.separator+model.getOrgId()+"_"+model.getDeviceNo();
			FileUtils.outPutFiles(json, path2,path2+File.separator+"tktFormat_"+DateUtil.getNow()+".json");
		} catch (Exception e) {
			e.printStackTrace();
		}
		for(int i=0; i<list.size(); i++){
			Map<String, Object> ticketTemplateMap = new HashMap<String, Object>(); 
			ticketTemplateMap.put("tktTmpId", list.get(i).get("tktTmpId"));
			ticketTemplateMap.put("tktTmpName", list.get(i).get("tktTmpName"));
			ticketTemplateMap.put("def", ((list.get(i).get("def").toString()).equals("1")?true:false));
			ticketTemplateMap.put("tktFormatId", list.get(i).get("tktFormatId"));
			ticketTemplateMap.put("tktFormat", list.get(i).get("tktFormat"));
			
			
			Map<String, Object> map = new HashMap<String, Object>();
			String print = "";
			if(list.get(i).get("print")!=null){
				print = list.get(i).get("print").toString();
				print = print.toString().substring(9, print.toString().length()-1);
			}else{
				print = "";
			}
		
			map.put("ticketTemplate", ticketTemplateMap);
			try {
				String json = JsonUtils.obj2json(map);
				json = json.substring(0, json.length()-1)+",\"print\":"+print+"}";
				FileUtils.outPutFiles(json, path+File.separator+"temp",path+File.separator+"temp"+File.separator+"ticketTemplate_"+list.get(i).get("tktTmpId")+".json");
				//存放历史文件路径
				String path2 = path+File.separator+model.getOrgId()+"_"+model.getDeviceNo();
				FileUtils.outPutFiles(json, path2,path2+File.separator+"tktFormat_"+list.get(i).get("tktTmpId")+"_"+DateUtil.getNow()+".json");
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}

	@Override
	public List<Map<String, Object>> procTktFormatsQuery(BscBranchBusinessQuery model) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put(BscBranchBusiness.ORG_ID, StringUtils4Aoto.trim(model.getOrgId()));
		map.put(BscBranchBusiness.DEVICE_NO, StringUtils4Aoto.trim(model.getDeviceNo()));
		List<Map<String, Object>> list = ticketFormMapper.callTktFormats(map);
		list = (List<Map<String, Object>>) map.get("pageDatas");
		return list;
	}

	@Override
	public String procTicketFormCopy(TicketFormModel model) {
		List<Map<String, Object>> list = bscWinConfigService.createOrgIdDeviceNo(model.getOrgDevicelist());
		Map<String, Object> map1 = new HashMap<String,Object>();
		for(int i=0; i<list.size(); i++){
			Map<String, Object> map = list.get(i);
			map.put(BscDevice.ORG_ID, model.getOrgId());
			map.put(BscDevice.DEVICE_NO, model.getDeviceNo());
			
		    ticketFormMapper.callCopyTicket(map);
		}
		return "0";
	}
	
	public List<Map<String, Object>> checkedTicketModel(TicketFormModel model){
		Map<String, Object> map = new HashMap<String, Object>();
		map.put(BscBranchBusiness.DEVICE_NO, StringUtils4Aoto.trim(model.getDeviceNo()));
		List<Map<String, Object>> list = ticketFormMapper.checkedTicketModel(map);
		return list;
	}
	
	/**
	 * 新增号票模板（导航使用）
	 */
	@Override
	public String addTicketFormFormNav(Map<String, Object> map) {
		//获取模板数据
		Map<String, Object> map2  = (Map<String, Object>) map.get("ticketTemplate");
		String tktTmpId =  (String) map2.get("tktTmpId");  //号票模板id
		String tktTmpName =  (String) map2.get("tktTmpName");  //号票模板名称
		boolean defstr =  (boolean) map2.get("def");  //是否默认模板
		String tktFormatId =  (String) map2.get("tktFormatId");  //号码模板id
		String tktFormat =  (String) map2.get("tktFormat");    //号码模板格式
		String orgId =  (String) map2.get("orgId");    //号码模板格式
		String deviceNo =  (String) map2.get("deviceNo");    //号码模板格式
		
		//保存的参数
		Map<String, Object> map3 = new HashMap<String,Object>();
		map3.put("tktTmpId", tktTmpId);
		map3.put("tktTmpName", tktTmpName);
		
		int def = (defstr==true?1:0);
		
		map3.put("def", def);
		map3.put("tktFormatId", tktFormatId);
		map3.put("tktFormat", tktFormat);
		
		map3.put("orgId", orgId);
		map3.put("deviceNo", deviceNo);
		
		
		ObjectMapper mapper = new ObjectMapper();
		try {
			//获取号票打印内容
			map.remove("ticketTemplate"); //删除ticketTemplate里面的内容
			String json = mapper.writeValueAsString(map);//里面只有打印的内容{"print":{......}}
			map3.put("tktTmpStyle",json);
		} catch (JsonProcessingException e1) {
			e1.printStackTrace();
			return "2";//执行失败
		}
		
		try {
			ticketFormMapper.saveNavTicketform(map3);
			String obj = (String) map3.get("ReturnCode");
			String retTtkTmpId = (String) map3.get("RetTtkTmpId");  //模板id
			return obj+"#"+retTtkTmpId;
		} catch (Exception e) {
			e.printStackTrace();
			return "1";//执行失败
		}
	}
	
	
	/**
	 * 导航配置：查询设备的默认号票模板
	 * @param model
	 * @return
	 */
	 public List<Map<String, Object>> navDefDevTicketfrom(TicketFormModel model){
		 Map<String, Object> map = new HashMap<String, Object>();
		 map.put(BscBranchBusiness.DEVICE_NO, StringUtils4Aoto.trim(model.getDeviceNo()));
		 List<Map<String, Object>> list = ticketFormMapper.navDefDevTicketfrom(map);
		 return list;
	 }

}
