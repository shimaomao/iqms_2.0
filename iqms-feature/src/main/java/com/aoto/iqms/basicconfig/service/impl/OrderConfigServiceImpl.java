package com.aoto.iqms.basicconfig.service.impl;

import java.math.BigDecimal;
import java.text.ParseException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.aoto.framework.commons.lang.StringUtils4Aoto;
import com.aoto.framework.commons.pagination.PagingCriteria;
import com.aoto.iqms.basicconfig.commons.constant.BasicconfigBeanProperty.OrderConfig;
import com.aoto.iqms.basicconfig.models.OrderConfigModel;
import com.aoto.iqms.basicconfig.models.OrderConfigQuery;
import com.aoto.iqms.basicconfig.models.book.BookReqHeader;
import com.aoto.iqms.basicconfig.models.book.BookX002Req;
import com.aoto.iqms.basicconfig.models.book.BookX002Resp;
import com.aoto.iqms.basicconfig.models.book.BookX003Req;
import com.aoto.iqms.basicconfig.persistence.inf.OrderConfigMapper;
import com.aoto.iqms.basicconfig.service.inf.OrderConfigService;
import com.aoto.iqms.businessconfig.commons.constant.BusinessconfigBeanProperty.BscDevice;
import com.aoto.iqms.businessconfig.service.inf.BscWinConfigService;
import com.aoto.iqms.util.DateUtil;
import com.aoto.iqms.util.ProcPageFill;

@Service
@Transactional
public class OrderConfigServiceImpl implements OrderConfigService{
	@Autowired
	public OrderConfigMapper orderMapper;
	@Autowired
	private BscWinConfigService bscWinConfigService;
	@Override
	public List<Map<String, Object>> procPageOrderConfig(PagingCriteria pagingCriteria, OrderConfigQuery model) {
		Map<String, Object> map = new HashMap<String, Object>();	    
		map.put("orgId", StringUtils4Aoto.trim(model.getOrgId()));
		ProcPageFill.fillProcData(model, map, OrderConfig.class);
		List<Map<String, Object>> list = orderMapper.callPageOrderConfig(map);
		int total = ((BigDecimal)map.get("totalrows")).intValue();
		pagingCriteria.setTotal(total);
		list = (List<Map<String, Object>>) map.get("pageDatas");
		
        return list;
	}

	@Override
	public String callCreateOrderConfigProc(OrderConfigModel model) {
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			if(!DateUtil.compareDate(model.getBeginTime(), model.getEndTime())){
				return "5";
			}
		} catch (ParseException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		map.put(OrderConfig.ORG_ID, model.getOrgId());
		map.put(OrderConfig.DEVICE_NO, model.getDeviceNo());
		map.put(OrderConfig.BEGIN_TIME, model.getBeginTime());
		map.put(OrderConfig.END_TIME, model.getEndTime());
		map.put(OrderConfig.ORDER_COUNT, model.getOrderCount());
		
		
		//调用持久化方法
		try {
			orderMapper.callInsertOrderConfig(map);
			String obj = (String) map.get("ReturnCode");
			return obj;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			return "4";//失败
		}
	}

	@Override
	public String callUpdateOrderConfigProc(OrderConfigModel model) {
		try {
			if(!DateUtil.compareDate(model.getBeginTime(), model.getEndTime())){
				return "5";
			}
		} catch (ParseException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		Map<String, Object> map = new HashMap<String, Object>();
		map.put(OrderConfig.ORDER_ID, model.getOrderId());
		map.put(OrderConfig.BEGIN_TIME, model.getBeginTime());
		map.put(OrderConfig.END_TIME, model.getEndTime());
		map.put(OrderConfig.ORDER_COUNT, model.getOrderCount());
		map.put(OrderConfig.DEVICE_NO, model.getDeviceNo());
		try {
			orderMapper.callUpdteOrderConfig(map);
			String obj = (String)map.get("ReturnCode");
			return obj;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			return "1";//失败
		}
	}

	@Override
	public String callRemoveOrderConfigProc(List<String> list) {
		Map<String, Object> map = new HashMap<String, Object>();
		for(int i=0; i<list.size(); i++){
			map.put(OrderConfig.ORDER_ID, list.get(i));
			orderMapper.callDeleteOrderConfig(map);
		}
		return "0";
	}

	@Override
	public String callSaveCopyProc(OrderConfigQuery model) {
		List<Map<String, Object>> list = bscWinConfigService.createOrgIdDeviceNo(model.getOrgDevicelist());
		for(int i=0; i<list.size(); i++){
			Map<String, Object> map = list.get(i);
			map.put(OrderConfig.DEVICE_NO, model.getDeviceNo());
			orderMapper.callCopyOrderConfig(map);
		}
		return "0";
	}

	@Override
	public List<Map<String, Object>> findOrderRange(String deviceNo, String orderDate) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("deviceNo", deviceNo);
		map.put("orderDate", orderDate);
		List<Map<String, Object>> list = orderMapper.findOrderRange(map);
		return list;
	}

	@Override
	public List<Map<String, Object>> findBusiness(String deviceNo) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("deviceNo", deviceNo);
		List<Map<String, Object>> list = orderMapper.findBusiness(map);
		list = (List<Map<String, Object>>) map.get("pageDatas");
		return list;
	}

	@Override
	public int existBook(BookX002Req reqModel) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("orgCode", reqModel.getHead().getOrgCode());
		map.put("devNo", reqModel.getData().getDevNo());
		map.put("certType", reqModel.getData().getCertType());
		map.put("certContent", reqModel.getData().getCertContent());
		map.put("orderTime", reqModel.getData().getOrderTime());
		map.put("rangeBegin", reqModel.getData().getRangeBegin());
		map.put("rangeEnd", reqModel.getData().getRangeEnd());
		map.put("orderDt", reqModel.getHead().getOrderDt());
		orderMapper.callExistBook(map);
		int result = Integer.parseInt(((String)map.get("ReturnCode")));
		return result;
	}

	@Override
	public boolean existActNo(BookX002Req orderReqModel) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("orgCode", orderReqModel.getHead().getOrgCode());
		map.put("actNo", orderReqModel.getData().getDevNo());
		map.put("orderDt", orderReqModel.getHead().getOrderDt());
		orderMapper.callExistActNo(map);
		String res = (String)map.get("ReturnCode");
		return res.equals("1")?true:false;
	}

	@Override
	public void insertOrderInfo(BookX002Req orderRecord) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("orgCode", orderRecord.getHead().getOrgCode());
		map.put("devNo", orderRecord.getData().getDevNo());
		map.put("actNo", orderRecord.getData().getActNo());
		map.put("orderBusId", orderRecord.getData().getOrderServiceId());
		map.put("orderBusCode", orderRecord.getData().getOrderServiceCode());
		map.put("certType", orderRecord.getData().getCertType());
		map.put("certContent", orderRecord.getData().getCertContent());
		map.put("orderDt", orderRecord.getHead().getOrderDt());
		map.put("orderTime", orderRecord.getData().getOrderTime());
		map.put("rangeBegin", orderRecord.getData().getRangeBegin());
		map.put("rangeEnd", orderRecord.getData().getRangeEnd());
		orderMapper.callInsertOrderInfo(map);
	}

	@Override
	public List<Map<String, Object>> queryActNoStatus(BookX003Req orderReqModel) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("orgCode", orderReqModel.getHead().getOrgCode());
		map.put("actNo", orderReqModel.getData().getActNo());
		map.put("orderDt", orderReqModel.getHead()
				.getOrderDt());
		map.put("certType", orderReqModel.getData().getCertType());
		map.put("certContent", orderReqModel.getData().getCertContent());
		List<Map<String, Object>> list = orderMapper.callQueryActNoStatus(map);
//		list = (List<Map<String, Object>>) map.get("pageDatas");
		return list;
	}

	@Override
	public String bookCancel(BookX003Req orderReqModel) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("orgCode", orderReqModel.getHead().getOrgCode());
		map.put("actNo", orderReqModel.getData().getActNo());
		map.put("orderDt", orderReqModel.getHead().getOrderDt());
		map.put("certType", orderReqModel.getData().getCertType());
		map.put("certContent", orderReqModel.getData().getCertContent());
		//调用持久化方法
		try {
			orderMapper.callBookCancel(map);
			//获取存储过程的输出参数
			String obj = (String)map.get("ReturnCode");
			return obj;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			return "1"; //执行失败
		}
	}

	@Override
	public List<Map<String, Object>> queryOrderInfo(String deviceId, String mediaType, String mediaId) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("deviceNo", deviceId);
		map.put("certType", mediaType);
		map.put("certContent", mediaId);
		List<Map<String, Object>> list = orderMapper.callQueryOrderInfo(map);
		list = (List<Map<String, Object>>) map.get("pageDatas");
		return list;
	}

	@Override
	public String updateOrderInfo(String orderId, String ticketNo) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("orderId", orderId);
		map.put("ticketNo", ticketNo);
		try {
			orderMapper.callUpdateOrderInfo(map);
			//获取存储过程的输出参数
			String obj = (String)map.get("ReturnCode");
			return obj;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			return "1"; //执行失败
		}
	}

}
