package com.aoto.iqms.util;

import java.io.InputStream;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.Element;
import org.dom4j.io.SAXReader;





/**
 *解析excel的配置数据
 * @author daxian
 *
 */
public class ExcelConfigManager {

    private String configName = "ExcelOperateModel.xml";

    private SAXReader saxReader;

    private Document doc;

    private Element root;

    public ExcelConfigManager() {
        String str = this.getClass().getResource("/").getPath(); // + "config/";
        // this.getClass().getResourceAsStream("/");
        System.out.println(str + configName);
        // InputStream in = ClassLoader.getSystemResourceAsStream(configName);
        InputStream in = Thread.currentThread().getContextClassLoader().getResourceAsStream(configName);
        saxReader = new SAXReader();
        try {
            doc = saxReader.read(in);
            saxReader.setValidation(true);

        } catch (DocumentException e) {
            e.printStackTrace();
        }
        root = doc.getRootElement();
    }

    
    /**
     * 找出指定的模板
     * @param modelName
     * @return
     */
    public Element getModelElement(String modelName) {
        System.out.println("modelName = " + modelName + "-----------");
        List list = root.elements();
        Element model = null;
        Element returnModel = null;
        for (Iterator it = list.iterator(); it.hasNext();) {
            model = (Element) it.next();
            //System.out.println(model.attributeValue("id"));
            if (model.attributeValue("id").equals(modelName)) {
                returnModel = model;
                break;
            }
        }
        if(returnModel==null){
            System.out.println("　＞＞＞　modelName : " + modelName + " 在配制文件中不存在！");
        }
        return returnModel;
    }

    /**
     * 获取导入导出的配置信息
     * @param modelName
     * @param flag
     * @return
     */
    public ReturnConfig getModel(String modelName, String flag) {
        Element model = this.getModelElement(modelName);
        ReturnConfig result = new ReturnConfig();
        if (model != null) {
            result.setClassName(model.attributeValue(ConfigConstant.MODEL_CLASS)); //设置封装的类
            result.setTitle(model.attributeValue(ConfigConstant.MODEL_TITLE)); //设置标题
            this.setPropertyMap(result, model);
        }
        return result;
    }
    
    /**
     * 封装配置文件的属性
     * @param result
     * @param model
     */
    private void setPropertyMap(ReturnConfig result, Element model) {
        Map<String, ReturnPropertyParam> propertyMap = new LinkedHashMap<String, ReturnPropertyParam>();
        Map<String, ReturnPropertyParam> columnMap = new LinkedHashMap<String, ReturnPropertyParam>();
        List list = model.elements();
        Element property = null;

        for (Iterator it = list.iterator(); it.hasNext();) {
            property = (Element) it.next();
            // System.out.println("Name = " + property.getName());
            if (property.getName().equals("property")) {
                ReturnPropertyParam modelProperty = new ReturnPropertyParam();
                modelProperty.setName(property.attributeValue(ConfigConstant.PROPERTY_NAME));
                modelProperty.setColumn(property.attributeValue(ConfigConstant.PROPERTY_CLOUMN));
                modelProperty.setExcelTitleName(property.attributeValue(ConfigConstant.PROPERTY_EXCEL_TITLE_NAME));
                modelProperty.setIsNull(property.attributeValue(ConfigConstant.PROPERTY_ISNULL));
                modelProperty.setColumnWidth(property.attributeValue(ConfigConstant.PROPERTY_COLUMN_WIDTH));
                modelProperty.setDataType(property.attributeValue(ConfigConstant.PROPERTY_DATA_TYPE));
                modelProperty.setMaxLength(property.attributeValue(ConfigConstant.PROPERTY_MAX_LENGTH));

                modelProperty.setFixity(property.attributeValue(ConfigConstant.PROPERTY_FIXITY));
                modelProperty.setCodeTableName(property.attributeValue(ConfigConstant.PROPERTY_CODE_TABLE_NAME));
                modelProperty.setDefaultValue(property.attributeValue(ConfigConstant.PROPERTY_DEFAULT));

                System.out.println(property.attributeValue("name"));
                
                String excelTitle = ValidateColumn.configValidate(propertyMap,modelProperty.getExcelTitleName());
                propertyMap.put(excelTitle, modelProperty);
                
                System.out.println("column = " + modelProperty.getColumn());
                columnMap.put(modelProperty.getColumn(), modelProperty);
            }
            if (property.getName().equals("flag")) {
                Map flagMap = new LinkedHashMap();
                flagMap.put(ConfigConstant.PROPERTY_NAME, property.attributeValue(ConfigConstant.PROPERTY_NAME));
                result.setFlagMap(flagMap);
            }
            if (property.getName().equals("message")) {
                Map messageMap = new LinkedHashMap();
                messageMap.put(ConfigConstant.PROPERTY_NAME, property.attributeValue(ConfigConstant.PROPERTY_NAME));
                messageMap.put(ConfigConstant.PROPERTY_EXCEL_TITLE_NAME, property.attributeValue(ConfigConstant.PROPERTY_EXCEL_TITLE_NAME));
                result.setMessageMap(messageMap);
            }
        }
        result.setPropertyMap(propertyMap);
        result.setColumnMap(columnMap);
    }

    public static void main(String[] args) {
        // TODO Auto-generated method stub
    	ExcelConfigManager test = new ExcelConfigManager();
        ReturnConfig reconfig = test.getModel("trxtodayhistorylist", "");
        System.out.println(reconfig.getClassName());

    }
	
	
}
