package com.aoto.iqms.monitor.service.impl;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.Reader;
import java.math.BigDecimal;
import java.sql.Clob;
import java.sql.Date;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.aoto.framework.commons.lang.StringUtils4Aoto;
import com.aoto.framework.commons.pagination.PagingCriteria;
import com.aoto.iqms.monitor.commons.constant.MonitorBeanProperty.SqlSelect;
import com.aoto.iqms.monitor.models.SqlSelectQuery;
import com.aoto.iqms.monitor.persistence.inf.SqlSelectMapper;
import com.aoto.iqms.monitor.service.inf.SqlSelectService;
import com.aoto.iqms.util.ProcPageFill;
import com.aoto.iqms.util.PropetiesLoader;

/**
 *数据监控实现
 * @author tianjm 20190304
 *
 */
@Service
@Transactional
public class SqlSelectServiceImpl implements SqlSelectService{
	@Autowired
	SqlSelectMapper sqlSelectMapper;
	private static final Logger logger = LoggerFactory.getLogger(SqlSelectServiceImpl.class);
	/**
	 * 调用存储过程分页
	 */
	@Override
	public List<Map<String, Object>> procPageSqlSelect(PagingCriteria pagingCriteria, SqlSelectQuery model) {
		List<Map<String, Object>> list = new ArrayList<Map<String,Object>>();
		Map<String, Object> map = new HashMap<String, Object>();
		String sqlInfo = model.getSelectInfo().replace(";", "").replace("；", "");
		Boolean sqlNotAllowFlag = PropetiesLoader.getSystemConfig().getBoolean("notAllowArrayFlag");
		logger.info("【数据监控开始】进行sql查询，是否仅允许输入select语句："+sqlNotAllowFlag);
	    if(sqlNotAllowFlag){
	    	List<Object> sqlNotAllow = PropetiesLoader.getSystemConfig().getList("notAllowArray");
	    	for (Object object : sqlNotAllow) {
				if(sqlInfo.contains((String)object)){
					logger.error("【数据监控开始】进行sql查询，只允许输入select语句，sql="+sqlInfo);
					map.put("error", "9999");
					list.add(map);
					return list;
				}
			}
	    }
		
	    map.put(SqlSelect.SQL_INFO, StringUtils4Aoto.trim(sqlInfo));
	    //填充分页和排序信息
	    ProcPageFill.fillProcData(model, map, SqlSelect.class);
	    //执行存储过程
	    list = sqlSelectMapper.callPageSqlSelect(map);
	    //获取存储过程的返回值
	    int total = ((BigDecimal)map.get("totalrows")).intValue();
	    pagingCriteria.setTotal(total);
	    list = (List<Map<String, Object>>) map.get("pageDatas");
		SimpleDateFormat sdf  = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		for (int i = 0; i < list.size(); i++) {
			Map<String, Object> map2 = list.get(i);
			for (Map.Entry<String, Object> entry : map2.entrySet()) { 
				if(entry.getValue() == null){
					map2.put(entry.getKey(), "");
				}else{
//					System.out.println(entry.getValue().getClass()+"=="+entry.getKey()+"=="+entry.getValue());
					if (entry.getValue() instanceof java.sql.Timestamp ) {
	//					 java.sql.Timestamp jst = (Timestamp) entry.getValue();
						map2.put(entry.getKey(), sdf.format(entry.getValue()));
					}
					if ( entry.getValue() instanceof oracle.sql.TIMESTAMP ) {
						oracle.sql.TIMESTAMP ost = (oracle.sql.TIMESTAMP) entry.getValue();
						try {
							map2.put(entry.getKey(), sdf.format(new Date( ost.dateValue().getTime())));
						} catch (SQLException e) {
							e.printStackTrace();
						}
					}
					if ( entry.getValue() instanceof oracle.sql.ROWID || entry.getValue() instanceof oracle.sql.BLOB ) {
						map2.put(entry.getKey(), entry.getValue().toString());
					}
					if(entry.getValue() instanceof oracle.sql.CLOB) {
						try {
							map2.put(entry.getKey(), ClobToString((Clob)entry.getValue()));
						} catch (SQLException | IOException e) {
							e.printStackTrace();
						}
					}
				}
//				System.out.println("Key = " + entry.getKey() + ", Value = " + entry.getValue());
			}
		}
		return list;
	}
	
	//oracle.sql.Clob类型转换成String类型
	private String ClobToString(Clob clob) throws SQLException, IOException {
	    String reString = "";
	    Reader is = clob.getCharacterStream();// 得到流
	    BufferedReader br = new BufferedReader(is);
	    String s = br.readLine();
	    StringBuffer sb = new StringBuffer();
	    while (s != null) {// 执行循环将字符串全部取出付值给StringBuffer由StringBuffer转成STRING
	        sb.append(s);
	        s = br.readLine();
	    }
	    reString = sb.toString();
	    return reString;
	}

}
