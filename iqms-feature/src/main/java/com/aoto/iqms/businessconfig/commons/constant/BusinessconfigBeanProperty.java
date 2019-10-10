package com.aoto.iqms.businessconfig.commons.constant;

public class BusinessconfigBeanProperty {
	
	/**
	 * 分页的相关信息
	 * @author daxian
	 *
	 */
	public static final class PageInfo{
		public static final String PAGEINDEX = "pageIndex";
		public static final String PAGESIZE = "pageSize";
		public static final String TOTAL = "total";
		public static final String SORTFIELD = "sortField";
		public static final String SORTDERECTION = "sortDirection";
	}
	
	/**
	 * 设备管理
	 * @author daxian
	 *
	 */
	public static final class BscDevice{
		public static final String ORG_ID = "orgId";
		public static final String ORG_CODE = "orgCode";
		public static final String DEVICE_NO = "deviceNo";
		public static final String HOST_NAME = "hostName"; //主机名
		public static final String IP_ADDR = "ipAddr";   //ip地址
		public static final String MAC_ADDR = "macAddr"; //mac地址
		public static final String PRODUCER = "producer";//厂商
		public static final String INSTALL_DATE = "installDate";//安装日期
		public static final String ADMIN_NAME = "adminName";//管理员姓名
		public static final String ADMIN_PHONE = "adminPhone";//管理员电话
		public static final String ONLINE_TIME = "onlineTime";//最后在线时间
		public static final String CURRT_VER = "currtVer";//当前版本号
		public static final String CURRT_VERNAME = "currtVerName";//当前版本名称
		public static final String LAST_VER = "lastVer"; //最新版本号
		public static final String LAST_VERNAME = "lastVername";//最新版本名称
		public static final String IS_LSTVERSION = "islstversion"; //是否是最新版本
		
		//21051231 by hongxz 增加本地网   是否提供预约
		public static final String NET_ORGCODE = "netOrgCode";//本地网
		public static final String ORDER_FLAG = "orderFlag";//是否预约
		public static final String EXTEND1 = "extend1";//扩展字段1
		public static final String EXTEND2 = "extend2";//扩展字段2
		public static final String EXTEND3 = "extend3";//扩展字段3
		
		public static final String SCREEN_RESOLUTION = "screenResolution"; //分辨率
		public static final String ONLINE_MODEL = "onlineModel"; //上线模式
		public static final String TPSCROLL_FLAG = "tpscrollFlag"; //条屏显示
	}
	
	/**
	 * 窗口配置
	 * @author zhousj
	 *
	 */
	public static final class BscWinConfig{
		public static final String ORG_ID = "orgId";
		public static final String DEVICE_NO = "deviceNo";
		public static final String WIN_NO = "winNo"; 
		public static final String IS_CALL = "isCall";   
		public static final String IS_JUDGE = "isJudge"; 
		public static final String IS_START = "isStart"; 
		public static final String WIN_SCREEN = "winScreen";
		public static final String MULTIPLE_SCREEN = "multipleScreen";
		public static final String ROW_ID = "rowId";
		public static final String EXTEND1 = "extend1";//扩展字段1
		public static final String EXTEND2 = "extend2";//扩展字段2
		public static final String EXTEND3 = "extend3";//扩展字段3
		public static final String TARGET_ID = "targetId";//要应用的下级机构id
		public static final String TARGET_NO = "targetNo";//要应用的下级设备号
	}
	
	/**
	 *客户等级配置
	 * @author zhousj
	 *
	 */
	public static final class BscCustLevel{
		public static final String ORG_ID = "orgId";
		public static final String DEVICE_NO = "deviceNo";
		public static final String CUST_LEVEL = "custLevel"; 
		public static final String LEVEL_NAME = "levelName";   
		public static final String BUSINESS_ID = "businessId"; 
		public static final String PRIOR_TIME = "priorTime"; 
		public static final String CALL_HEAD = "callHead";
		public static final String MAX_WAIT_TIME = "maxWaitTime";
		public static final String TICKET_TEMPLATE = "ticketTemplate";
		public static final String IS_START = "isStart";
		public static final String EXTEND1 = "extend1";//扩展字段1
		public static final String EXTEND2 = "extend2";//扩展字段2
		public static final String EXTEND3 = "extend3";//扩展字段3
		public static final String ROW_ID = "rowId";//页面序号 同时代表 固定客户级别
		
	}
	
	/**
	 *网点业务
	 * @author zhousj
	 *
	 */
	public static final class BscBranchBusiness{
		public static final String ORG_ID = "orgId";
		public static final String DEVICE_NO = "deviceNo";
		public static final String TREE_PID = "treePid"; 
		public static final String TREE_ID = "treeId"; 
		public static final String BUSINESS_TYPE = "businessType"; 
		public static final String BUSINESS_EN_NAME = "businessEnName"; 
		public static final String BUSINESS_CODE = "businessCode";
		public static final String CALL_HEAD = "callHead";
		public static final String PRIOR_TIME = "priorTime";
		public static final String IS_SWIPE = "isSwipe";
		public static final String IS_SHOW_EN = "isShowEn";
		public static final String PICK_UP_ADVICE = "pickUpAdvice";
		public static final String MAX_PICK_UP = "maxPickUp";
		public static final String SORT_NUM = "sortNum";
		public static final String EXTEND1 = "extend1";
		public static final String EXTEND2 = "extend2";
		public static final String EXTEND3 = "extend3";
		public static final String BUSINESS_NAME = "businessName";
		public static final String MENU_NAME ="menuName";
		public static final String BUS_ID ="busId";
		public static final String LEVELNUM ="levelNum";
	}
	
	/**
	 *业务时间
	 * @author zhousj
	 *
	 */
	public static final class BscShowTime{
		public static final String ORG_ID = "orgId";
		public static final String DEVICE_NO = "deviceNo";
		public static final String BUSINESS_ID = "businessId"; 
		public static final String ROW_ID = "rowId"; 
		public static final String DATE_TYPE = "dateType"; 
		public static final String BEGIN_TIME = "beginTime"; 
		public static final String END_TIME = "endTime";
		public static final String MAX_NUM = "maxNum";
		public static final String EXTEND1 = "extend1";
		public static final String EXTEND2 = "extend2";
		public static final String EXTEND3 = "extend3";
	}
	/**
	 * 客户识别
	 * @author zhousj
	 */
	public static final class BscCustRegconition{
		public static final String ORG_ID = "orgId";
		public static final String DEVICE_NO = "deviceNo";
		public static final String ROW_ID = "rowId"; 
		public static final String DATE_TYPE = "dateType"; 
		public static final String START_POSITION = "startPosition"; 
		public static final String MATE_LENGTH = "mateLength"; 
		public static final String START_MATE_CODE = "startMateCode";
		public static final String END_MATE_CODE = "endMateCode";
		public static final String CUST_LEVEL = "custLevel";
		public static final String RECOGNITION_TYPE = "recognitionType";
		public static final String EXTEND1 = "extend1";
		public static final String EXTEND2 = "extend2";
		public static final String EXTEND3 = "extend3";
		public static final String WIN_NO = "winNo";
	}
	/**
	 * 叫号策略
	 * @author humz
	 */
	public static final class CallStrategy{
		public static final String COUNTERID = "counterId";
		public static final String DATETYPEID = "dateTypeId";
		public static final String BUZTYPEID = "buzTypeId"; 
		public static final String LEVELID = "levelId"; 
		public static final String BUZPRIORITYTIME = "buzPriorityTime"; 
		public static final String CUSTPRIORITYTIME = "custPriorityTime";
		public static final String MAXWAITING = "maxWaiting";
	}
	/**
	 * 特殊日期
	 * @author zhousj
	 */
	public static final class BscSpecialDate{
		public static final String DEVICE_NO = "deviceNo";
		public static final String SPECIAL_DATE = "specialDate"; 
		public static final String DATE_TYPE = "dateType"; 
	}
}
