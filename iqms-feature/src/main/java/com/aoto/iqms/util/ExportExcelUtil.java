package com.aoto.iqms.util;

import java.io.*;
import java.lang.reflect.*;
import java.net.URLEncoder;
import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.text.SimpleDateFormat;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.swing.JOptionPane;

import org.apache.poi.hssf.usermodel.*;
import org.apache.poi.hssf.util.HSSFColor;

import com.aoto.framework.commons.lang.StringUtils4Aoto;

/**
 * 向页面导出excel
 * @author humz
 *
 */
public class ExportExcelUtil {
	
	/**
	 * 
	 * @param workbook
	 * @param title
	 * @param response
	 */
	private void excuteExport(HSSFWorkbook workbook,String title,HttpServletResponse response,HttpServletRequest request){
		try {
			//response.setContentType("octets/stream");
			String userAgent = request.getHeader("USER-AGENT");
			if(StringUtils4Aoto.contains(userAgent, "MSIE")){//IE浏览器
				title = URLEncoder.encode(title,"UTF-8");  //IE或者其他浏览器
			} else if (StringUtils4Aoto.contains(userAgent, "Mozilla")){
				title = new String(title.getBytes("UTF-8"),"ISO-8859-1");  //火狐浏览器
			} else {
				title = URLEncoder.encode(title,"UTF-8");  //IE或者其他浏览器
			}
			response.setCharacterEncoding("UTF-8");
			response.reset();
			response.setContentType("application/OCTET-STREAM;charset=UTF-8");
			response.setHeader("pragma", "no-cache");
			response.addHeader("Content-Disposition","attachment;filename="+title+".xls");
			OutputStream out =  response.getOutputStream();
            workbook.write(out);
        } catch (IOException e) {
            e.printStackTrace();
        }
	}
	
	
	/**
	 * 设置单元格样式
	 * @param workbook 工作本
	 * @param style 样式
	 * @param foregroundColor 单元个前景色
	 * @param fillPatten 单元格填充方式
	 * @param borderStyle 边框样式
	 * @param align 水平对齐方式
     * @param valign 垂直对齐方式
	 * @param fontColor 字体颜色
	 * @param fontSize 字体大小
	 * @param boldWeight 字体粗细
	 */
	private  void setStyle(HSSFWorkbook workbook,HSSFCellStyle style,short foregroundColor,short fillPatten,
			short borderStyle,short align,short valign,short fontColor,short fontSize,short boldWeight){
		style.setFillForegroundColor(foregroundColor); //设置前景填充方式
		style.setFillPattern(fillPatten);//填充方式
		style.setBorderBottom(borderStyle); //底部边框线
		style.setBorderLeft(borderStyle); //左边边框线
		style.setBorderRight(borderStyle); //右边边框线
		style.setBorderTop(borderStyle); //上边边框线
		style.setAlignment(align); //水平对齐方式
		style.setVerticalAlignment(valign); //垂直对齐方式
		
		// 创建字体
		HSSFFont font = workbook.createFont();
		font.setColor(fontColor); //设置字体颜色
		font.setFontHeightInPoints(fontSize); //设置字体大小
		font.setBoldweight(boldWeight); //设置字体粗度
		// 把字体应用到当前的样式
		style.setFont(font);
	}
	
	
	/**
	 * 创建单元格
	 * @param row 行对象
	 * @param columnIndex  单元个索引
	 * @param style  单元格样式
	 * @param content 单元格内容
	 * @param configParam  单元格与数据配置项
	 */
	private void createCell(HSSFWorkbook wb, HSSFRow row,int columnIndex,HSSFCellStyle style,Object content,String pattern,ReturnPropertyParam configParam){
		HSSFCell cell = row.createCell(columnIndex); //创建单元格
		cell.setCellStyle(style); //设置单元个样式
		
		//数据单元格(根据配置信息配置单元格)
		if (configParam != null){
			//暂时不设置单元格属性
			
		} else {
			//标题单元格
			
		}
		
		//格式判断
		String textValue = "";
		if (content instanceof Boolean) {
			boolean bValue = (Boolean) content;
			textValue = "是";
			if (!bValue) {
				textValue = "否";
			}
		} else if (content instanceof Date) { //日期格式的单元格
			cell.setCellValue((Date)content);
			HSSFDataFormat format = wb.createDataFormat();
			style.setDataFormat(format.getFormat("yyyy年MM月dd日  HH时:mm分ss秒"));
			cell.setCellStyle(style);
			
		} else {
			// 其它数据类型都当作字符串简单处理
			if (content != null) {
				textValue = content.toString();
			}
			cell.setCellValue(textValue);
		}
		
	}
	

	/**
	 * 导出excel(数据格式是List<JavaBean>)
	 * @param data 数据
	 * @param modelId 模板id
	 * @param response
	 * @param pattern 时间格式
	 * @throws Exception
	 */
	public void exportExcel(List data, String modelId,
			HttpServletResponse response,HttpServletRequest request ,String pattern) throws Exception {
		// 1.获取模板配置信息
		ExcelConfigManager excelConfig = new ExcelConfigManager();
		ReturnConfig reConfig = excelConfig.getModel(modelId, "");

		// 获取标题名称
		String title = reConfig.getTitle();
		// 获取类名
		String clazzStr = reConfig.getClassName();
		//获取集合中的类类型
		Class clazz = Class.forName(clazzStr);

		// 声明一个工作薄
		HSSFWorkbook workbook = new HSSFWorkbook();
		// 生成一个表格
		HSSFSheet sheet = workbook.createSheet(title);
		// 设置表格默认列宽度为15个字节
		sheet.setDefaultColumnWidth((short) 15);

		// ----------------------------------------------单元格标题样式1--------------------------------------
		HSSFCellStyle style = workbook.createCellStyle();
		setStyle(workbook,style,HSSFColor.SKY_BLUE.index,
				HSSFCellStyle.SOLID_FOREGROUND,
				HSSFCellStyle.BORDER_THIN,
				HSSFCellStyle.ALIGN_CENTER,
				HSSFCellStyle.VERTICAL_CENTER,
				HSSFColor.VIOLET.index,
				(short) 12,HSSFFont.BOLDWEIGHT_BOLD);

		// -----------------------------------------------------单元格数据样式2
		HSSFCellStyle style2 = workbook.createCellStyle();
		setStyle(workbook,style2,HSSFColor.LIGHT_YELLOW.index,
				HSSFCellStyle.SOLID_FOREGROUND,
				HSSFCellStyle.BORDER_THIN,
				HSSFCellStyle.ALIGN_CENTER,
				HSSFCellStyle.VERTICAL_CENTER,
				HSSFColor.VIOLET.index,
				(short) 11,HSSFFont.BOLDWEIGHT_NORMAL);

		// 声明一个画图的顶级管理器
		//HSSFPatriarch patriarch = sheet.createDrawingPatriarch();
		// --------------------------------------产生单元格标题行-----------------------------------
		Iterator itkey = reConfig.getPropertyMap().keySet().iterator();
		HSSFRow row = sheet.createRow(0);
		short columIndex = 0;
		while (itkey.hasNext()) {
			String cellTitle = (String) itkey.next();
			createCell(workbook,row,columIndex,style,cellTitle,pattern,null); //创建单元格
			columIndex++;
		}

		// 遍历集合数据，产生数据行

		for (short index = 0; index < data.size(); index++) {
			Object obj = data.get(index); // 获取数据
			int rowIndex = index + 1;
			row = sheet.createRow(rowIndex); // 创建这一行
			//获取每个数据列的单元格配置信息
			Iterator itValue = reConfig.getPropertyMap().values().iterator();
			int columnIn = 0;
			while (itValue.hasNext()) {
				
				//获取一个列的单元格配置信息
				ReturnPropertyParam param = (ReturnPropertyParam) itValue.next();
				// 获取属性名称(通过反射获取对应的值)
				String propertyName = param.getName();
				// 转换成get方法名
				String getMethodName = "get"+ propertyName.substring(0, 1).toUpperCase()+ propertyName.substring(1);
				// 获取这个属性的值
				Method getMethod = clazz.getMethod(getMethodName,new Class[] {});
				Object value = getMethod.invoke(obj, new Object[] {});
				createCell(workbook,row,columnIn,style2,value,pattern,param); //创建单元格
				columnIn++;
			}
		}
		excuteExport(workbook,title,response,request);
	}
	
	
	/**
	 * 导出excel(数据格式是Map)
	 * @param data
	 * @param modelId
	 * @param response
	 * @param pattern
	 * @throws Exception
	 */
	public void exportExcelOfMap(List<Map<String, Object>> data, String modelId,
			HttpServletResponse response, HttpServletRequest request,String pattern) throws Exception {
		// 1.获取模板配置信息
		ExcelConfigManager excelConfig = new ExcelConfigManager();
		ReturnConfig reConfig = excelConfig.getModel(modelId, "");
		
		// 获取标题名称
		String title = reConfig.getTitle();

		// 声明一个工作薄
		HSSFWorkbook workbook = new HSSFWorkbook();
		// 生成一个表格
		HSSFSheet sheet = workbook.createSheet(title);
		// 设置表格默认列宽度为15个字节
		sheet.setDefaultColumnWidth((short) 15);

		// ----------------------------------------------单元格标题样式1--------------------------------------
		HSSFCellStyle style = workbook.createCellStyle();
		setStyle(workbook,style,HSSFColor.SKY_BLUE.index,
				HSSFCellStyle.SOLID_FOREGROUND,
				HSSFCellStyle.BORDER_THIN,
				HSSFCellStyle.ALIGN_CENTER,
				HSSFCellStyle.VERTICAL_CENTER,
				HSSFColor.VIOLET.index,
				(short) 12,HSSFFont.BOLDWEIGHT_BOLD);

		// -----------------------------------------------------单元格数据样式2
		HSSFCellStyle style2 = workbook.createCellStyle();
		setStyle(workbook,style2,HSSFColor.LIGHT_YELLOW.index,
				HSSFCellStyle.SOLID_FOREGROUND,
				HSSFCellStyle.BORDER_THIN,
				HSSFCellStyle.ALIGN_CENTER,
				HSSFCellStyle.VERTICAL_CENTER,
				HSSFColor.VIOLET.index,
				(short) 11,HSSFFont.BOLDWEIGHT_NORMAL);

		// 声明一个画图的顶级管理器
		//HSSFPatriarch patriarch = sheet.createDrawingPatriarch();
		// --------------------------------------产生单元格标题行-----------------------------------
		Iterator itkey = reConfig.getPropertyMap().keySet().iterator();
		HSSFRow row = sheet.createRow(0);
		short columIndex = 0;
		while (itkey.hasNext()) {
			String cellTitle = (String) itkey.next();
			createCell(workbook,row,columIndex,style,cellTitle,pattern,null); //创建单元格
			columIndex++;
		}

		// 遍历集合数据，产生数据行
		for (short index = 0; index < data.size(); index++) {
			Map<String, Object> obj = data.get(index); // 获取数据
			int rowIndex = index + 1;
			row = sheet.createRow(rowIndex); // 创建这一行
			//获取每个数据列的单元格配置信息
			Iterator itValue = reConfig.getPropertyMap().values().iterator();
			int columnIn = 0;
			while (itValue.hasNext()) {
				//获取一个列的单元格配置信息
				ReturnPropertyParam param = (ReturnPropertyParam) itValue.next();
				// 获取属性名称对应map的key
				String propertyName = param.getName();
				Object value = obj.get(propertyName);
				createCell(workbook,row,columnIn,style2,value,pattern,param); //创建单元格
				columnIn++;
			}
		}
		excuteExport(workbook,title,response,request);
	}
	
	
	
	
}
