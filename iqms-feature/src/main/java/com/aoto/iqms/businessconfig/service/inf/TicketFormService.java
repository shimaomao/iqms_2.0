package com.aoto.iqms.businessconfig.service.inf;

import java.util.List;
import java.util.Map;

import com.aoto.iqms.businessconfig.models.BscBranchBusinessQuery;
import com.aoto.iqms.businessconfig.models.BscCustRecognitionModel;
import com.aoto.iqms.businessconfig.models.NumberFormModel;
import com.aoto.iqms.businessconfig.models.SettingsModel;
import com.aoto.iqms.businessconfig.models.TicketFormModel;

/**
 * 号票模板-业务层接口
 * @author humz
 *
 */
public interface TicketFormService {

	/**
	 * 新增号票
	 * @param model
	 * @return
	 */
	public String addTicketForm(TicketFormModel model);
	
	/**
	 * 新增号票模板（导航中使用）
	 * @param model
	 * @return
	 */
	public String addTicketFormFormNav(Map<String, Object> map);
	
	/**
	 * 查询号票
	 */
	public List<Map<String, Object>> selectTicketForm(TicketFormModel model);
	
	/**
	 * 编辑号票
	 */
	public String updateTicketForm(TicketFormModel model);
	
	/**
	 * 删除号票
	 */
	public String deleteTicketForm(TicketFormModel model);
	
	/**
	 * 号票预览
	 */
	public String previewTicketform(TicketFormModel model);
	
	/**
	 * 根据ID查询单条号票数据
	 */
	public Map<String, Object> selectOneTicketForm(TicketFormModel model);
	
	/**
	 * 根据类型查询元素列表配置
	 */
	public Map<String, Object> selectSettings(SettingsModel model);
	
	/**
	 * 保存号票样式
	 */
	public String saveTicketform(Map<String, Object> map);
	
	/**
     * 调用存储过程应用到下级机构
     * @param model
     * @return
     */
    public String callCopyTicketProc(TicketFormModel model);
    
    /**
	 * 创建tktFormats.json文件
	 * @param model
	 */
	public void createTktFormats(BscBranchBusinessQuery model,String path);
	
	/**
     * 执行存储过程生成TktFormats.json
     * @param model
     * @return
     */
    public List<Map<String, Object>> procTktFormatsQuery(BscBranchBusinessQuery model);
    
    /**
     * 一键检测：检测号票模板配制
     * @param model
     * @return
     */
    public List<Map<String, Object>> checkedTicketModel(TicketFormModel model);
    
    /**
     * 调用存储过程应用到下级机构
     * @param model
     * @return
     */
    public String procTicketFormCopy(TicketFormModel model);
    
    /**
     * 导航配置：查询设备默认的号票模板
     * @param model
     * @return
     */
    public List<Map<String, Object>> navDefDevTicketfrom(TicketFormModel model);
	
}
