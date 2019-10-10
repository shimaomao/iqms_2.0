package com.aoto.iqms.basicconfig.web.controllers;

import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
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
import com.aoto.framework.commons.beans.JsonUtils;
import com.aoto.framework.commons.lang.StringUtils4Aoto;
import com.aoto.framework.commons.pagination.PagingCriteria;
import com.aoto.iqms.basicconfig.models.CusInfoModel;
import com.aoto.iqms.basicconfig.models.CusInfoQuery;
import com.aoto.iqms.basicconfig.models.CustTypeQuery;
import com.aoto.iqms.basicconfig.service.inf.CusInfoService;

/**
 *本地客户控制层
 * @author humz
 *
 */
@Controller
public class CusInfoController {
	
	@Autowired
	private CusInfoService cusInfoService;//自动注入业务层接口
	
	/**
     * 进入本地客户页面
     * @author humz
     */
    @RequestMapping(value = "/basicconfig/cusinfo", method = RequestMethod.GET)
    public ModelAndView enterCusInfoPage()
    {
        return new ModelAndView("basicconfig/cusinfo/list");
    }
    
    /**
     * 本地客户分页功能。
     * @param model
     * @return
     */
    @RequestMapping(value = "/basicconfig/cusinfo", method = RequestMethod.GET,  headers = "accept=application/json")
    @ResponseBody
    public JsonResult getCusInfoPageList(CusInfoQuery model){
    	PagingCriteria pagingCriteria = new PagingCriteria(model.getPage() - 1, model.getRows(), model.getSort(),model.getOrder());
    	List<Map<String, Object>> list = cusInfoService.procPageCusInfo(pagingCriteria, model);//调用存储过程进行分页
    	
    	return JsonResult.json(model.getRows(), model.getPage(), pagingCriteria.getTotal(), list);
    }
    
    
    /**
     * 本地客户新增。
     * @param model
     * @return
     */
    @RequestMapping(value = "/basicconfig/cusinfo", method = RequestMethod.POST)
    @ResponseBody
    public JsonResult createCusInfo(CusInfoModel model){
    	String errorCode = cusInfoService.callCreateCusInfoProc(model);
    	return JsonResult.json(errorCode);
    }
    
    /**
     * 本地客户编辑
     * @param model
     * @return
     */
    @RequestMapping(value = "/basicconfig/cusinfo", method = RequestMethod.PUT)
    @ResponseBody
    public JsonResult editCusInfo(CusInfoModel model)
    {
    	String errorCode = cusInfoService.callUpdateCusInfoProc(model);
    	return JsonResult.json(errorCode);
    }
    
    /**
     * 本地客户删除
     * @param list
     * @return
     */
    @RequestMapping(value = "/basicconfig/cusinfo", method = RequestMethod.DELETE)
    @ResponseBody
    public JsonResult removeCusInfos(@RequestBody List<String> list)
    {
    	String errorCode = cusInfoService.callRemoveCusInfoProc(list);
        return JsonResult.json(errorCode);
    }
	
    
    /**
     * 本地客户导入表格
     * @param list
     * @return
     */
    @RequestMapping(value = "/basicconfig/cusinfo/import", method = RequestMethod.POST)
    @ResponseBody
    public void importCusInfo(HttpServletRequest request,HttpServletResponse response)
    {	 
    	response.setContentType("text/html");
    	MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
    	
    	//获取上传的文件信息
    	MultipartFile multipartFile = multipartRequest.getFile("cusinfoimport");
    	
    	List<CusInfoModel> cusInfos = new ArrayList<CusInfoModel>();
    	List<String> rownums = new ArrayList<String>(); //行号信息
    	List<Map<String, String>> errorsList = new ArrayList<Map<String,String>>(); //分装错误的信息
    	
    	try {
			InputStream in = multipartFile.getInputStream(); 
			//解析excel
			HSSFWorkbook wb = new HSSFWorkbook(in);
			//获取第一个表格
			HSSFSheet sheet = wb.getSheetAt(0);
			
			//获取最后行数
			int rowCount = sheet.getLastRowNum();
			
			if (rowCount <= 1){ //提示没有要导入的数据
				System.out.println("没有要导入的数据");
				Map<String, String> errInfo = new HashMap<String, String>();
				errInfo.put("result", "1");
				try {
					String json = JsonUtils.obj2json(errInfo);
					System.out.println(json);
					response.getOutputStream().write(json.getBytes("UTF-8"));
				} catch (Exception e) {
					e.printStackTrace();
				}
				return ;
			} else {
				//遍历行
				for (int i = 1; i <= rowCount; i++){
					HSSFRow row = sheet.getRow(i);
					boolean isRight = true;
					//封装数据
					CusInfoModel model = new CusInfoModel();
				
					String orgCode = StringUtils4Aoto.trim(row.getCell(1).getStringCellValue());
					String custId = StringUtils4Aoto.trim(row.getCell(0).getStringCellValue());
					String custName =StringUtils4Aoto.trim(row.getCell(2).getStringCellValue());
					String custLevel = StringUtils4Aoto.trim(row.getCell(3).getStringCellValue());
					String custPdut = StringUtils4Aoto.trim(row.getCell(4).getStringCellValue());
					String custAd = StringUtils4Aoto.trim(row.getCell(5).getStringCellValue());
					String isBankEftve = StringUtils4Aoto.trim(row.getCell(6).getStringCellValue());
					
					String errMsg = "";
					
					if (StringUtils4Aoto.isBlank(orgCode)){
						errMsg += "机构编码不能为空;";
						isRight = false;
					}
					if (StringUtils4Aoto.isBlank(custId)){
						errMsg += "客户识别码不能为空;";
						isRight = false;
					}
					if (StringUtils4Aoto.isBlank(custName)){
						errMsg += "客户姓名不能为空;";
						isRight = false;
					}
					if (StringUtils4Aoto.isBlank(custLevel)){
						errMsg += "客户类型不能为空;";
						isRight = false;
					}
					if (!isRight){
						Map<String, String> errMap = new HashMap<String, String>();
						errMap.put("rownum", "第"+(i+1)+"行");
						errMap.put("errMsg", errMsg);
						errorsList.add(errMap);
						continue;
					}
					model.setOrgCode(orgCode);
					model.setCustId(custId);
					model.setCustName(custName);
					model.setCustLevel(custLevel);
					model.setCustPdut(custPdut);
					model.setCustAd(custAd);
					model.setIsBankEftve(isBankEftve);
					cusInfos.add(model);
					rownums.add((i+1)+""); //定位行号
				}
			}
			
			//保存数据
			if (cusInfos.size() > 0) {
				cusInfoService.callCreateCusInfoBatchProc(cusInfos, rownums, errorsList);
			}
			
			//判断是否全部保存成功
			if (errorsList.size() == 0){ //全部保存成功
				Map<String, String> errInfo = new HashMap<String, String>();
				errInfo.put("result", "0");
				
				try {
					String json = JsonUtils.obj2json(errInfo);
					System.out.println(json);
					response.getOutputStream().write(json.getBytes("UTF-8"));
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				
				return ;
			}
			
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		//返回保存错误的信息
		try {
			String jsonErrlist = JsonUtils.obj2json(errorsList);
			System.out.println(jsonErrlist);
			response.getOutputStream().write(jsonErrlist.getBytes("UTF-8"));
		} catch (Exception e) {
			e.printStackTrace();
		}
        return ;
    }
    
}
