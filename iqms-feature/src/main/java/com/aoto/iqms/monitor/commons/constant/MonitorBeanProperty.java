package com.aoto.iqms.monitor.commons.constant;

public class MonitorBeanProperty {
	/**
	 * 分页的相关信息
	 * @author zhousj
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
	 * 当日业务数据
	 * @author zhousj
	 */
	public static final class TrxToday{
		public static final String ORG_ID="orgId";          
		public static final String DEVICE_NO="deviceNo";       
		public static final String TRX_DATE="trxDate";        
		public static final String FLOW_NO="flowNo";        
		public static final String BUS_ID="busId";          
		public static final String BUS_TYPE="busType";        
		public static final String CUST_TYPE="custType";       
		public static final String PDJ_LEVEL="pdjLevel";      
		public static final String TICKET_TYPE="ticketType";     
		public static final String TICKET_NO="ticketNo";      
		public static final String CUST_ID="custId";         
		public static final String CARD_TYPE="cardType";       
		public static final String CARD_NO="cardNo";         
		public static final String MANAGER_NO="managerNo";      
		public static final String TRX_TYPE="trxType";        
		public static final String TRX_STATUS="trxStatus";     
		public static final String PRINT_TIME="printTime";      
		public static final String CALL_TIME="callTime";      
		public static final String BEGIN_TIME="beginTime";      
		public static final String END_TIME="endTime";        
		public static final String APP_VALUE="appValue";     
		public static final String WIN_NO="winNo";          
		public static final String TELLER_NO="tellerNo";    
		public static final String RECALL_COUNT="recallCount";    
		public static final String PAUSE_BEGINTIME="pauseBeginTime"; 
		public static final String PAUSE_ENDTIME="pauseEndTime";   
		public static final String CALL_TYPE="callType";      
		public static final String TRANSFER_COUNT="transferCount";  
		public static final String BUZ_FLAG="buzFlag";        
		public static final String EXTEND1="extend1";         
		public static final String EXTEND2="extend2";         
		public static final String EXTEND3="extend3";
//		public static final String WIN_STATUS="winStatus";
		
		//add by tianjm 20181206    
		public static final String ORG_Code="orgCode";
		public static final String BUSINESS_NAME="businessName";
		public static final String CUST_NAME="custName";
	}
	
	/**
	 * 历史业务数据
	 * @author zhousj
	 */
	public static final class TrxHistory{
		public static final String ORG_ID="orgId";          
		public static final String DEVICE_NO="deviceNo";       
		public static final String TRX_DATE="trxDate";        
		public static final String FLOW_NO="flowNo";        
		public static final String BUS_ID="busId";          
		public static final String BUS_TYPE="busType";        
		public static final String CUST_TYPE="custType";       
		public static final String PDJ_LEVEL="pdjLevel";      
		public static final String TICKET_TYPE="ticketType";     
		public static final String TICKET_NO="ticketNo";      
		public static final String CUST_ID="custId";         
		public static final String CARD_TYPE="cardType";       
		public static final String CARD_NO="cardNo";         
		public static final String MANAGER_NO="managerNo";      
		public static final String TRX_TYPE="trxType";        
		public static final String TRX_STATUS="trxStatus";     
		public static final String PRINT_TIME="printTime";      
		public static final String CALL_TIME="callTime";      
		public static final String BEGIN_TIME="beginTime";      
		public static final String END_TIME="endTime";        
		public static final String APP_VALUE="appValue";     
		public static final String WIN_NO="winNo";          
		public static final String TELLER_NO="tellerNo";    
		public static final String RECALL_COUNT="recallCount";    
		public static final String PAUSE_BEGINTIME="pauseBeginTime"; 
		public static final String PAUSE_ENDTIME="pauseEndTime";   
		public static final String CALL_TYPE="callType";      
		public static final String TRANSFER_COUNT="transferCount";  
		public static final String BUZ_FLAG="buzFlag";        
		public static final String EXTEND1="extend1";         
		public static final String EXTEND2="extend2";         
		public static final String EXTEND3="extend3";
	}
	
	/**
	 * 设备状态数据
	 * @author zhousj
	 */
	public static final class BscDeviceStatus{
		public static final String ORG_ID = "orgId";
		public static final String DEVICE_NO = "deviceNo";
		public static final String CPU_RATIO = "cpuRatio";
		public static final String MEM_RATIO = "memRatio";
		public static final String DISK_RATIO = "diskRatio";
		public static final String VERSION_SEQ = "versionSeq";
		public static final String UPDATE_DATE = "updateDate";
		public static final String THERMALPRINTER_STATUS = "thermalprinterStatus";
		public static final String NEEDLEPRINTER_STATUS = "needleprinterStatus";
		public static final String IDREADER_STATUS = "idreaderStatus";
		public static final String SWREAD_STATUS = "swreadStatus";
		public static final String ICREADER_STATUS = "icreaderStatus";
		public static final String BAR_STATUS = "barStatus";
		public static final String COMP_STATUS = "compStatus";
		public static final String ORG_NAME = "orgName";
		public static final String CURRT_VERNAME = "currtVername";
		public static final String LAST_VERNAME = "lastVername";
		public static final String ONLINE_FLAG = "onLineFlag";
	}
	
	/**
	 * 数据监控查询数据
	 * @author tianjm 20190304
	 */
	public static final class SqlSelect{
		public static final String SQL_INFO = "sqlInfo";
	}
}
