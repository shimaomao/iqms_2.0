package com.aoto.iqms.businessconfig.persistence.inf;

import java.util.List;
import java.util.Map;

import com.aoto.iqms.businessconfig.models.TicketFormModel;

/**
 * 号票模板-持久化层
 * @author humz
 *
 */
public interface TicketFormMapper {

	/**
	 * 新增号票模板
	 */
	public void addTicketForm(Map<String, Object> map);
	
	/**
	 * 查询号票模板
	 */
	public List<Map<String, Object>> selectTicketForm(TicketFormModel model);
	
	/**
	 * 编辑号票模板
	 */
	public void updateTicketForm(Map<String, Object> map);
	
	/**
	 * 删除号票模板
	 */
	public void deleteTicketForm(Map<String, Object> map);
	
	/**
	 * 号票预览
	 */
	public String previewTicketform(TicketFormModel model);
	
	/**
	 * 根据ID查询单条号票数据
	 */
	public Map<String, Object> selectOneTicketForm(Map<String, Object> map);
	
	/**
	 * 根据类型查询元素列表配置
	 */
	public  List<Map<String, Object>> selectSettings(Map<String, Object> map);
	
	/**
	 * 保存号票样式
	 */
	public void saveTicketform(Map<String, Object> map);
	
	/**
	 * 新增号票（导航使用）
	 */
	public void saveNavTicketform(Map<String, Object> map);
	
	/**
     * 执行存储过程应用到下级机构
     * @param map
     */
    public void callCopyTicket(Map<String, Object> map);
    
    /**
     * 执行存储过程更新tktformat_id
     * @param map
     */
//    public void callUpdateTicket(Map<String, Object> map);
    /**
     * 执行存储过程生成tktFormats.json
     * @param model
     * @return
     */
    public List<Map<String, Object>> callTktFormats(Map<String, Object> map);
    
    
    /**
     * 执行存储过程生成tktFormats.json
     * @param model
     * @return
     */
    public List<Map<String, Object>> checkedTicketModel(Map<String, Object> map);
    
    /**
     * 导航配置：查询设备的默认模板
     * @param map
     * @return
     */
    public List<Map<String, Object>> navDefDevTicketfrom(Map<String, Object> map);
    
	
}
