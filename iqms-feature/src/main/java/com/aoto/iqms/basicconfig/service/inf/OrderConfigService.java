package com.aoto.iqms.basicconfig.service.inf;

import java.util.List;
import java.util.Map;

import com.aoto.framework.commons.pagination.PagingCriteria;
import com.aoto.iqms.basicconfig.models.OrderConfigModel;
import com.aoto.iqms.basicconfig.models.OrderConfigQuery;
import com.aoto.iqms.basicconfig.models.book.BookReqHeader;
import com.aoto.iqms.basicconfig.models.book.BookX002Req;
import com.aoto.iqms.basicconfig.models.book.BookX002Resp;
import com.aoto.iqms.basicconfig.models.book.BookX003Req;
import com.aoto.iqms.externals.models.bookvalidate.BookActiveReq;

/**
 * 预约配置
 * @author zhousj
 *
 */
public interface OrderConfigService {
	/**
	 * 调用存储过程进行分页数据查询
	 * @param pagingCriteria
	 * @param model
	 * @return
	 */
    public List<Map<String, Object>> procPageOrderConfig(PagingCriteria pagingCriteria,OrderConfigQuery model);
    
    /**
	 * 调用存储过程新增
	 * @param model
	 * @return
	 */
    public String callCreateOrderConfigProc(OrderConfigModel model);
    
    /**
     * 调用存储过程更新
     * @param model
     * @return
     */
    public String callUpdateOrderConfigProc(OrderConfigModel model);
    
    /**
     * 调用存储过程删除
     * @param list
     * @return
     */
    public String callRemoveOrderConfigProc(List<String> list);
    
    /**
     * 调用存储过程应用到下级机构
     * @param model
     * @return
     */
    public String callSaveCopyProc(OrderConfigQuery model);
    
    /**
     * 根据机构号和预约时间查询
     * @param map
     * @return
     */
    public List<Map<String, Object>> findOrderRange(String deviceNo, String orderDate);
    
    /**
     * 根据设备号查询预约所需业务
     * @param map
     * @return
     */
    public List<Map<String, Object>> findBusiness(String deviceNo);
    
    /**
     * 是否可以预约
     * @param map
     */
    public int existBook(BookX002Req reqModel);
    
    /**
     * 判断激活码是否可用
     * @param orderReqModel
     * @return  true-可用   false-不可用
     */
    public boolean existActNo(BookX002Req orderReqModel);
    
    /**
     * 增加预约记录
     * @param map
     */
    public void insertOrderInfo(BookX002Req orderRecord);
    
    /**
     * 查询激活码信息
     * @param orderReqModel
     * @return
     */
    public List<Map<String, Object>> queryActNoStatus(BookX003Req orderReqModel);
    
    /**
     * 预约取消
     * @param orderReqModel
     * @return
     */
    public String bookCancel(BookX003Req orderReqModel);
    
    /**
     * 预约激活 查询预约信息
     * @param reqModel
     * @return
     */
    public List<Map<String, Object>> queryOrderInfo(String deviceId, String mediaType, String mediaId);
    
    /**
     * 修改预约状态为已激活
     * @param orderReqModel
     * @return
     */
    public String updateOrderInfo(String orderId, String ticketNo);
}
