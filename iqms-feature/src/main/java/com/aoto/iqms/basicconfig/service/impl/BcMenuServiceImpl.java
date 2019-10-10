package com.aoto.iqms.basicconfig.service.impl;

import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.aoto.framework.commons.lang.StringUtils4Aoto;
import com.aoto.framework.commons.pagination.PagingCriteria;
import com.aoto.iqms.basicconfig.commons.constant.BasicconfigBeanProperty.BcMenu;
import com.aoto.iqms.basicconfig.models.MenuModel;
import com.aoto.iqms.basicconfig.models.MenuQuery;
import com.aoto.iqms.basicconfig.persistence.inf.BcMenuMapper;
import com.aoto.iqms.basicconfig.service.inf.MenuService;
import com.aoto.iqms.util.ProcPageFill;

/**
 * 菜单管理service实现
 * @author zhousj
 *
 */
@Service
@Transactional
public class BcMenuServiceImpl implements MenuService{
	@Autowired
	public BcMenuMapper bcMenuMapper;
    
	/**
	 * 调用存储过程分页
	 */
	@Override
	public List<Map<String, Object>> procPageMenu(PagingCriteria pagingCriteria, MenuQuery model) {
        Map<String, Object> map = new HashMap<String, Object>();	    
		map.put(BcMenu.MENU_NAME, StringUtils4Aoto.trim(model.getMenuName()));
		
		ProcPageFill.fillProcData(model, map, BcMenu.class);
		List<Map<String, Object>> list = bcMenuMapper.callPageMenu(map);
		int total = ((BigDecimal)map.get("totalrows")).intValue();
		pagingCriteria.setTotal(total);
		list = (List<Map<String, Object>>) map.get("pageDatas");
		
        return list;
	}
	
	/**
	 * 调用存储过程新增菜单
	 */
	@Override
	public String callCreateMenuProc(MenuModel model) {
	    Map<String, Object> map = new HashMap<String, Object>();
		map.put(BcMenu.MENU_NAME, model.getMenuName());
		map.put(BcMenu.MENU_ENNAME, model.getMenuEnName());
		map.put(BcMenu.EXTEND1, model.getExtend1());
		//调用持久化方法
		try {
			bcMenuMapper.callInsertMenu(map);
			String obj = (String) map.get("ReturnCode");
			return obj;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			return "1";//失败
		}
	}
    /**
     * 调用存储过程更新
     */
	@Override
	public String callUpdateBcMenuProc(MenuModel model) {
		// TODO Auto-generated method stub
		Map<String, Object> map = new HashMap<String, Object>();
		map.put(BcMenu.MENU_ID, model.getMenuId());
		map.put(BcMenu.MENU_NAME, model.getMenuName());
		map.put(BcMenu.MENU_ENNAME, model.getMenuEnName());
		map.put(BcMenu.EXTEND1, model.getExtend1());
		
		try {
			bcMenuMapper.callUpdteBcMenu(map);
			String obj = (String)map.get("ReturnCode");
			return obj;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			return "1";//失败
		}
	}
	
	/**
	 * 调用存储过程删除
	 */
	@Override
	public String callRemoveMenuProc(List<String> list) {
		// TODO Auto-generated method stub
		Map<String, Object> map = new HashMap<String, Object>();
		for(int i=0; i<list.size(); i++){
			map.put(BcMenu.MENU_ID, list.get(i));
			bcMenuMapper.callDeleteMenu(map);
		}
		return "0";
	}

	@Override
	public List<Map<String, Object>> selectMenuByPage(PagingCriteria pagingCriteria, MenuQuery model) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public String callQueryMenuProc(List<String> list) {
		Map<String, Object> map = new HashMap<String, Object>();
		StringBuffer sb = new StringBuffer("菜单：");
		for(int i=0; i<list.size(); i++){
			map.put(BcMenu.MENU_ID, list.get(i));
			List<Map<String, Object>> menuList = bcMenuMapper.callMenuQuery(map);
			menuList = (List<Map<String, Object>>) map.get("pageDatas");
			if(menuList.size() > 0){
				sb.append(menuList.get(0).get(BcMenu.MENU_NAME)+",");
			}
		}
		if(sb.toString().equals("菜单：")){
			return "0";
		}else{
			sb.append("有网点使用，删除此菜单会级联删除此菜单的相关配置，是否确定删除。");
			return sb.toString();
		}
	}

}
