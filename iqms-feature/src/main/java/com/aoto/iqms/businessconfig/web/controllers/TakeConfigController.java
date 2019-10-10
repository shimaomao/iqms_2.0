package com.aoto.iqms.businessconfig.web.controllers;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import com.aoto.framework.commons.beans.JsonResult;
import com.aoto.iqms.basicconfig.models.DeviceNoModel;
import com.aoto.iqms.basicconfig.models.TakeModelModel;
import com.aoto.iqms.businessconfig.models.BscDeviceQuery;
import com.aoto.iqms.businessconfig.service.inf.TakeConfigService;

/**
 * 取号配置 
 * @author humz
 *
 */
@Controller
public class TakeConfigController {
	
	@Autowired
	private TakeConfigService takeConfigService;
	
	/**
     * 进入取号模板页面
     * @author humz
     */
    @RequestMapping(value = "/businessconfig/takeconfig", method = RequestMethod.GET)
    public ModelAndView intoTakeConfigPage()
    {
        return new ModelAndView("/businessconfig/takeconfig/list");
    }
    
    /**
     * 查询所有取号模板
     */
    @RequestMapping(value="/businessconfig/takeconfig",method = RequestMethod.GET,headers = "accept=application/json")
    @ResponseBody
    public List<Map<String, Object>> selectTakeConfig(){
    	List<Map<String, Object>> list = takeConfigService.selectTakeConfig();
    	return list;
    }
    
    /**
     * 根据设备号查询取号模板
     */
    @RequestMapping(value="/businessconfig/takeconfig/BydeviceNo",method = RequestMethod.GET,headers = "accept=application/json")
    @ResponseBody
    public List<Map<String, Object>> selectTakeConfigBydeviceNo(DeviceNoModel model){
    	List<Map<String, Object>> list = takeConfigService.selectTakeConfigBydeviceNo(model);
    	return list;
    }
    
    /**
     * 新增取号模板
     */
    @RequestMapping(value = "/businessconfig/takeconfig",params = "ftype=add" ,method = RequestMethod.GET)
    @ResponseBody
    public JsonResult addTakeConfig(TakeModelModel model){
    	String returnCode = takeConfigService.addTakeConfig(model) ;
    	return JsonResult.json(returnCode);
    }
    
   /**
    * 删除取号模板
    */
    @RequestMapping(value="/businessconfig/takeconfig",params="ftype=delete",method = RequestMethod.GET)
    @ResponseBody
    public JsonResult deleteTakeConfig(TakeModelModel model){
    	String returnCode = takeConfigService.deleteTakeConfig(model);
    	return JsonResult.json(returnCode);
    }
    
    /**
     * 进入配置取号模板
     */
    @RequestMapping(value="/businessconfig/takeconfig/edit",method = RequestMethod.GET)
    public ModelAndView updateTakeConfig(){
    	return new ModelAndView("/businessconfig/takeconfig/edit");
    }
    
    /**
     * 获取轮播图片广告
     */
     @RequestMapping(value="/businessconfig/takeconfig/getPicture",method = RequestMethod.GET)
     @ResponseBody
     public List<Map<String, Object>> getPictureList(){
     	List<Map<String, Object>> list = takeConfigService.getPictureList();
     	return list;
     }
     
    /**
     * 获取视频
     */
     @RequestMapping(value="/businessconfig/takeconfig/getVideoList",method = RequestMethod.GET)
     @ResponseBody
     public List<Map<String, Object>> getVideoList(){
     	List<Map<String, Object>> list = takeConfigService.getVideoList();
     	return list;
     }
     
     /**
      * 获取音乐
      */
     @RequestMapping(value="/businessconfig/takeconfig/getMusicList",method = RequestMethod.GET)
     @ResponseBody
     public List<Map<String, Object>> getMusicList(){
      	List<Map<String, Object>> list = takeConfigService.getMusicList();
      	return list;
     }
     
     /**
      * 获取背景图片
      */
     @RequestMapping(value="/businessconfig/takeconfig/getBackgroundImgs",method = RequestMethod.GET)
     @ResponseBody
     public List<Map<String, Object>> getBackgroundImgs(){
      	List<Map<String, Object>> list = takeConfigService.getBackgroundImgs();
      	return list;
     }
     
     
     /**
      * 获取树形业务
      */
     @RequestMapping(value="/businessconfig/takeconfig/bustree",method = RequestMethod.POST,  headers = "accept=application/json")
     @ResponseBody
     public List<Map<String, Object>> selectBuzTime(@RequestBody Map<String, Object> map){
    	
    	//获取设备编号
    	String deviceNo = (String)map.get("deviceNo");
     	List<Map<String, Object>> list = takeConfigService.selectBuzTime(deviceNo);
     	return list;
     }

     /**
      * 根据ID查询取号模板样式
      */
     @RequestMapping(value="/businessconfig/takeconfig/getStyle",method = RequestMethod.POST,  headers = "accept=application/json")
     @ResponseBody
     public Map<String, Object> getStyle(@RequestBody Map<String, Object> map){
     	Map<String, Object> map2 = takeConfigService.getStyle(map);
     	return map2;
     }
     
     /**
      * 保存取号模板
      */
     @RequestMapping(value="/businessconfig/takeconfig/saveConfig",method = RequestMethod.POST,  headers = "accept=application/json")
     @ResponseBody
     public JsonResult saveConfig(@RequestBody Map<String, Object> map){
    	//add by tianjm 20181113
     	String mapString = map.toString();
     	String[] Symbol = {"<",">","'","\"","$"};
     	boolean hefa = false;
     	for (String check : Symbol) {
 			if(mapString.contains(check)){
 				hefa = true;
 				break;
 			}
 		}
     	if(hefa){
     		return JsonResult.json("1");
     	}
    	 String errorCode = takeConfigService.saveConfig(map);
    	 return JsonResult.json(errorCode);
     }
     
     
     
     /**
      * 保存取号模板（用于导航配置）
      */
     @RequestMapping(value="/businessconfig/takeconfig/saveConfig4nav",method = RequestMethod.POST,  headers = "accept=application/json")
     @ResponseBody
     public JsonResult saveConfig4nav(@RequestBody Map<String, Object> map){
    	//add by tianjm 20181113
      	String mapString = map.toString();
      	String[] Symbol = {"<",">","'","\"","$"};
      	boolean hefa = false;
      	for (String check : Symbol) {
  			if(mapString.contains(check)){
  				hefa = true;
  				break;
  			}
  		}
      	if(hefa){
      		return JsonResult.json("1");
      	}
      	
    	 String errorCode = takeConfigService.saveConfig4nav(map);
    	 
    	 String styleId = "";
    	 
    	 if (errorCode.equals("0")){ //保存成功后，
    		 styleId = (String)map.get("styleId");
    	 }
    	 
    	 return JsonResult.json(errorCode+"#"+styleId);
     }
     
     
     /**
      * 取号界面设置 应用到下级机构
      * @param model
      * @return
      */
     @RequestMapping(value = "/businessconfig/copytakeconfig", method = RequestMethod.POST)
     @ResponseBody
     public JsonResult copyTakeConfig(BscDeviceQuery model){
     	String errorCode = takeConfigService.callSaveTakeConfigProc(model);
     	return JsonResult.json(errorCode);
     }
     
     
     
     
     
     
     
}
