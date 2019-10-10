package com.aoto.iqms.util;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.aoto.iqms.externals.models.RespHeader;
import com.aoto.iqms.externals.models.deviceregist.DeviceRegistData;
import com.aoto.iqms.externals.models.deviceregist.DeviceRegistResp;
import com.aoto.iqms.externals.thirdcommunication.SocketRequest;
import com.aoto.iqms.util.testdata.HttpJsonData;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

public class JsonUtils
{
    private static ObjectMapper objectMapper = new ObjectMapper();
    
    private static final Logger logger = LoggerFactory
			.getLogger(JsonUtils.class);

    /**
     * javaBean,list,array convert to json string
     */
    public static String obj2json(Object obj) throws Exception
    {
        return objectMapper.writeValueAsString(obj);
    }

    /**
     * json string convert to javaBean
     */
    public static <T> T json2pojo(String jsonStr, Class<T> clazz) throws Exception
    {
        return objectMapper.readValue(jsonStr, clazz);
    }

    /**
     * json string convert to map
     */
    @SuppressWarnings("unchecked")
    public static <T> Map<String, Object> json2map(String jsonStr) throws Exception
    {
        return objectMapper.readValue(jsonStr, Map.class);
    }

    /**
     * json string convert to map with javaBean
     */
    public static <T> Map<String, T> json2map(String jsonStr, Class<T> clazz) throws Exception
    {
        Map<String, Map<String, Object>> map = objectMapper.readValue(jsonStr, new TypeReference<Map<String, T>>()
        {
        });
        Map<String, T> result = new HashMap<String, T>();
        for (Entry<String, Map<String, Object>> entry : map.entrySet())
        {
            result.put(entry.getKey(), map2pojo(entry.getValue(), clazz));
        }
        return result;
    }

    /**
     * json array string convert to list with javaBean
     */
    public static <T> List<T> json2list(String jsonArrayStr, Class<T> clazz) throws Exception
    {
        List<Map<String, Object>> list = objectMapper.readValue(jsonArrayStr, new TypeReference<List<T>>()
        {
        });
        List<T> result = new ArrayList<T>();
        for (Map<String, Object> map : list)
        {
            result.add(map2pojo(map, clazz));
        }
        return result;
    }

    /**
     * map convert to javaBean
     */
    public static <T> T map2pojo(Map<?, ?> map, Class<T> clazz)
    {
        return objectMapper.convertValue(map, clazz);
    }
    
    /**
     * 根据节点路径获取节点
     * @param jsonXml
     * @param path
     * @return
     */
    public static JsonNode getJsonNode(String jsonXml,String path){
	    //解析出机构信息
		JsonNode rootNode = null;
		try {
			rootNode = objectMapper.readTree(jsonXml);
		} catch (JsonProcessingException e) {
			logger.info("json转换成节点异常：",e);
		} catch (IOException e) {
			logger.info("json转换成节点异常：",e);
		}
		//orgId
    	JsonNode jsonNode = rootNode.path(path);
    	return jsonNode;
	 }
    
    /**
     * 获取json对象
     * @param json
     * @return
     */
    public static JsonNode getRoot(String json){
	    //解析出机构信息
		JsonNode rootNode = null;
		try {
			rootNode = objectMapper.readTree(json);
		} catch (JsonProcessingException e) {
			logger.info("json转换成节点异常：",e);
		} catch (IOException e) {
			logger.info("json转换成节点异常：",e);
		}
    	return rootNode;
	 }
    
//    public static void main(String[] args) {
//		DeviceRegistResp resp = new DeviceRegistResp();
//		RespHeader respHeader = new RespHeader();
//		DeviceRegistData deviceRegistData =new DeviceRegistData();
//		respHeader.setTransCode("A1001");
//		respHeader.setTransDateTime("2017-06-20 11:22:30");
//		respHeader.setTransDescription("成功");
//		respHeader.setTransStatus("0000");
//		
//		deviceRegistData.setDeviceId("09101101");
//		deviceRegistData.setOrgCode("09100101");
//		deviceRegistData.setOrgId("22");
//		
//		resp.setData(deviceRegistData);
//		resp.setHeader(respHeader);
//		
//		try {
//			String json = JsonUtils.obj2json(resp);
//			System.out.println(json);
//		} catch (Exception e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}
//		
//		
//	}
    
    //测试
    public static void main(String[] args) {
    	JsonNode rootNode = null;
    	String adWords = "";
		try {
			rootNode = objectMapper.readTree(HttpJsonData.REQ_JSON);
			JsonNode returnCode = rootNode.findValue("transCode"); //
			System.out.println("编码值："+returnCode.textValue());
			if (returnCode.asInt() == 0){ //请求成功,获取一句话广告
				System.out.println("获取广告成功");
//				JsonNode adInfos = rootNode.get("ROOT").get("BODY").get("OUT_DATA")
//				.get("AD_INFOS");
				List<JsonNode> params = rootNode.findValues("PARAM");
				//只取第一个（第一个就是序号1的）
				JsonNode adParamNode = params.get(0);
				//转换成listMap
		        List<Map<String, String>> list = objectMapper.readValue(adParamNode.toString(), new TypeReference<List<Map<String, String>>>()
		                {
		                });
				
				//获取第一个广告
				for (Map<String, String> map : list) {
					if (map.get("CONTENT_KEY").equals("marketWord")){
						//获取一句话广告
						adWords = map.get("CONTENT_VALUE");
					}
					System.out.println("CONTENT_KEY:"+map.get("CONTENT_KEY"));
					System.out.println("CONTENT_VALUE:"+map.get("CONTENT_VALUE"));
					System.out.println();
				}
				
			}
		} catch (JsonProcessingException e) {
			System.out.println(e.getMessage());
		} catch (IOException e) {
			System.out.println(e.getMessage());
		}
		
	}
    
}
