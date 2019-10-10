package com.aoto.iqms.basicconfig.web.controllers;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.aoto.framework.commons.beans.JsonResult;
import com.aoto.iqms.basicconfig.models.DeviceNoModel;
import com.aoto.iqms.basicconfig.models.TakeModelModel;
import com.aoto.iqms.basicconfig.service.inf.TakeModelService;
import com.aoto.iqms.businessconfig.models.SettingsModel;

/**
 * 取号模板
 * @author humz
 *
 */
@Controller
public class TakeModelController {
	
	@Autowired
	private TakeModelService takeModelService;
	
	/**
     * 进入取号模板页面
     * @author humz
     */
    @RequestMapping(value = "/basicconfig/takemodel", method = RequestMethod.GET)
    public ModelAndView intoTakeModelPage()
    {
        return new ModelAndView("/basicconfig/takemodel/list");
    }
    
    /**
     * 查询所有取号模板
     */
    @RequestMapping(value="/basicconfig/takemodel",method = RequestMethod.GET,headers = "accept=application/json")
    @ResponseBody
    public List<Map<String, Object>> selectTakeModel(){
    	List<Map<String, Object>> list = takeModelService.selectTakeModel();
    	return list;
    }
    
    /**
     * 根据设备号查询取号模板
     */
    @RequestMapping(value="/basicconfig/takemodelBydeviceNo",method = RequestMethod.GET,headers = "accept=application/json")
    @ResponseBody
    public List<Map<String, Object>> selectTakeModelBydeviceNo(DeviceNoModel model){
    	List<Map<String, Object>> list = takeModelService.selectTakeModelBydeviceNo(model);
    	return list;
    }
    
    /**
     * 新增取号模板
     */
    @RequestMapping(value = "/basicconfig/takemodel",params = "ftype=add" ,method = RequestMethod.GET)
    @ResponseBody
    public JsonResult addTakeModel(TakeModelModel model){
    	String returnCode = takeModelService.addTakeModel(model) ;
    	return JsonResult.json(returnCode);
    }
    
   /**
    * 删除取号模板
    */
    @RequestMapping(value="/basicconfig/takemodel",params="ftype=delete",method = RequestMethod.GET)
    @ResponseBody
    public JsonResult deleteTakeModel(TakeModelModel model){
    	String returnCode = takeModelService.deleteTakeModel(model);
    	return JsonResult.json(returnCode);
    }
    
    /**
     * 进入配置取号模板
     */
    @RequestMapping(value="/basicconfig/takemodeledit",method = RequestMethod.GET)
    public ModelAndView updateTakeModel(){
    	return new ModelAndView("/basicconfig/takemodel/edit");
    }
    
    /**
     * 查询大元素列表
     */
    @RequestMapping(value="/basicconfig/settings",method = RequestMethod.GET,  headers = "accept=application/json")
    @ResponseBody
    public Map<String, Object> selectSettings(){
    	Map<String, Object> map = takeModelService.selectSettings();
    	return map;
    }
    
    /**
     * 根据type查询大元素列表
     */
    @RequestMapping(value="/basicconfig/settingsbyType",method = RequestMethod.POST,  headers = "accept=application/json")
    @ResponseBody
    public List<Map<String, Object>> selectSettingsbyType(@RequestBody Map<String, Object> map){
    	List<Map<String, Object>> list = takeModelService.selectSettingsbyType(map);
    	return list;
    }
    
    /**
     * 获取视频
     */
     @RequestMapping(value="/basicconfig/getVideoList",method = RequestMethod.GET)
     @ResponseBody
     public List<Map<String, Object>> getVideoList(){
     	List<Map<String, Object>> list = takeModelService.getVideoList();
     	return list;
     }
     
     /**
      * 获取音乐
      */
     @RequestMapping(value="/basicconfig/getMusicList",method = RequestMethod.GET)
     @ResponseBody
     public List<Map<String, Object>> getMusicList(){
      	List<Map<String, Object>> list = takeModelService.getMusicList();
      	return list;
     }
     
     /**
      * 获取背景图片
      */
     @RequestMapping(value="/basicconfig/getBackgroundImgs",method = RequestMethod.GET)
     @ResponseBody
     public List<Map<String, Object>> getBackgroundImgs(){
      	List<Map<String, Object>> list = takeModelService.getBackgroundImgs();
      	return list;
     }
     
     /**
      * 获取小元素列表
      */
     @RequestMapping(value="/basicconfig/queueCtrl",method = RequestMethod.GET,  headers = "accept=application/json")
     @ResponseBody
     public List<Map<String, Object>> selectQueueCtrl(){
     	List<Map<String, Object>> list = takeModelService.selectQueueCtrl();
     	return list;
     }
     
     /**
      * 获取树形业务
      */
     @RequestMapping(value="/basicconfig/buztime",method = RequestMethod.GET,  headers = "accept=application/json")
     @ResponseBody
     public List<Map<String, Object>> selectBuzTime(){
     	List<Map<String, Object>> list = takeModelService.selectBuzTime(0);
     	return list;
     }

     /**
      * 根据ID查询取号模板样式
      */
     @RequestMapping(value="/basicconfig/getStyle",method = RequestMethod.POST,  headers = "accept=application/json")
     @ResponseBody
     public Map<String, Object> getStyle(@RequestBody Map<String, Object> map){
     	Map<String, Object> map2 = takeModelService.getStyle(map);
     	return map2;
     }
     
     /**
      * 保存取号模板
      */
     @RequestMapping(value="/basicconfig/saveConfig",method = RequestMethod.POST,  headers = "accept=application/json")
     @ResponseBody
     public JsonResult saveConfig(@RequestBody Map<String, Object> map){
    	 String errorCode = takeModelService.saveConfig(map);
    	 return JsonResult.json(errorCode);
     }
}
