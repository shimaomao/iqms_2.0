package com.aoto.iqms.report.commons.constant;

import com.aoto.iqms.report.commons.constant.ReportBeanProperty.OperationInfo;

public class ReportBeanProperty {
	
	/**
	 * 机构分析报表
	 * @author humz
	 *
	 */
	public static final class OrgAnalyseReport{
			public static final String ORG_ID = "orgId";//机构ID
			public static final String ORG_CODE = "orgCode";//机构编码
			public static final String ORG_NAME ="orgName";//机构名称
			public static final String DEAL_COUNT ="dealCount";//总受理量
			public static final String AVG_WAIT ="avgWait";//平均等待时长
			public static final String MAX_WAIT ="maxWait";//最大等待时间
			public static final String MIN_WAIT ="minWait";//最小等待时间
			public static final String AVG_DEAL="avgDeal";//平均处理时间
			public static final String MAX_DEAL ="maxDeal";//最大处理时间
			public static final String MIN_DEAL ="minDeal";//最小处理时间
			//关联的一些字段
			public static final String START_DATE = "startDate";//开始日期
			public static final String END_DATE = "endDate";//结束日期
	}
	
	/**
	 * 客户来行时间报表
	 * @author humz
	 *
	 */
	public static final class ComeTimeReport{
			
		public static final String ORG_ID = "orgId";//机构ID
		public static final String ORG_CODE = "orgCode";//机构编码
		public static final String CUST_NO = "custNo";//客户号
		public static final String CUST_NAME ="custName";//客户姓名		
		public static final String CUST_SEX ="custSex";//客户性别
		public static final String CERT_TYPE ="certType";//证件类型
		public static final String CERT_CONTENT = "certContent";//证件内容
		public static final String CUST_PHONE = "custPhone";//客户手机
		public static final String CUST_ASSETS = "custAssets";//客户资产
		public static final String CUST_DEPOSIT = "custDeposit";//客户存款型
		public static final String CUST_FINANCIAL = "custFinancial";//客户理财
		public static final String CUST_FOUNDATION = "custFoundation";//客户基金
		public static final String CUST_NATIONALDEBT = "custNationaldebt";//客户国债
		public static final String CUST_INSURANCE = "custInsurance";//客户保险
		public static final String CUST_LEVEL = "custLevel";//综合评级
		public static final String COME_DT = "comeDt";//来店日期
		//关联的一些字段
		public static final String START_DATE = "startDate";//开始日期
		public static final String END_DATE = "endDate";//结束日期
	}
	
	/**
	 * 柜员效率报表
	 * @author humz
	 *
	 */
	public static final class EmpEfficiencyReport{
			public static final String ORG_ID = "orgId";//机构ID
			public static final String ORG_CODE = "orgCode";//机构编码
			public static final String ORG_NAME ="orgName";//机构名称
			public static final String WORK_ID = "workId";//柜员工号
			public static final String WORK_NAME ="workName";//柜员姓名
			public static final String DEAL_COUNT ="dealCount";//总受理量
			public static final String AVG_DEAL="avgDeal";//平均处理时间
			public static final String MAX_DEAL ="maxDeal";//最大处理时间
			public static final String MIN_DEAL ="minDeal";//最小处理时间
			//关联的一些字段
			public static final String START_DATE = "startDate";//开始日期
			public static final String END_DATE = "endDate";//结束日期
	}
	
	/**
	 * 柜员评价报表
	 * @author humz
	 *
	 */
	public static final class EmpAppraiseReport{
			public static final String ORG_ID = "orgId";//机构ID
			public static final String ORG_CODE = "orgCode";//机构编码
			public static final String ORG_NAME ="orgName";//机构名称
			public static final String WORK_ID = "workId";//员工工号
			public static final String WORK_NAME ="workName";//员工姓名
			public static final String APP_CONTENT ="appContent";//满意
			public static final String APP_SOSO ="appSoso";//一般满意
			public static final String APP_DISCONTENT ="appDiscontent";//不满意
			public static final String APP_NONAPP="appNonapp";//未评价
			public static final String RATE_CONTENT ="rateContent";//满意率
			public static final String RATE_SOSO ="rateSoso";//一般满意率
			public static final String RATE_DISCONTENT ="rateDiscontent";//不满意率
			public static final String RATE_NONAPP="rateNonapp";//未评价率
			//关联的一些字段
			public static final String START_DATE = "startDate";//开始日期
			public static final String END_DATE = "endDate";//结束日期
	}
	
	/**
	 * 客户分析报表
	 * @author humz
	 *
	 */
	public static final class CusAnalyseReport{
			
			public static final String ORG_ID = "orgId";//机构ID
			public static final String ORG_CODE = "orgCode";//机构编码
			public static final String ORG_NAME ="orgName";//机构名称
			public static final String CUST_LEVEL = "custLevel";//客户类型
			public static final String CUST_NAME ="custName";//客户类型名称
			public static final String DEAL_COUNT ="dealCount";//总受理量
			public static final String AVG_WAIT ="avgWait";//平均等待时长
			public static final String MAX_WAIT ="maxWait";//最大等待时间
			public static final String MIN_WAIT ="minWait";//最小等待时间
			public static final String AVG_DEAL="avgDeal";//平均处理时间
			public static final String MAX_DEAL ="maxDeal";//最大处理时间
			public static final String MIN_DEAL ="minDeal";//最小处理时间
			//关联的一些字段
			public static final String START_DATE = "startDate";//开始日期
			public static final String END_DATE = "endDate";//结束日期
		}
	/**
	 * 弃票率报表
	 * @author tianjm  20181128
	 */
	public static final class AbandonRateReport{
		
		public static final String ORG_ID = "orgId";//机构ID
		public static final String ORG_CODE = "orgCode";//机构编码
		public static final String ORG_NAME ="orgName";//机构名称
		public static final String BUS_TYPE = "busType";//业务类型
		public static final String TOTAL_COUNT ="totalCount";//总取票量
		public static final String TOTAL_WAIT ="totalWait";//未受理量
		public static final String TOTAL_DEAL ="totalDeal";//受理量
		public static final String TOTAL_ABANDON ="totalAbandon";//弃票量
		public static final String ABANDON_RATE ="abandonRate";//弃票率
		//关联的一些字段
		public static final String START_DATE = "startDate";//开始日期
		public static final String END_DATE = "endDate";//结束日期
	}
	
	/**
	 * 业务流水报表
	 * @author humz
	 *
	 */
	public static final class BusinessFlowReport{
			public static final String ORG_ID = "orgId";//机构ID
			public static final String ORG_CODE = "orgCode";//机构编码
			public static final String ORG_NAME="orgName";//机构名称
			public static final String DEVICE_NO = "deviceNo";//设备编号
			public static final String TRX_DATE = "trxDate";//交易日期
			public static final String FLOW_NO = "flowNo";//排队流水号
			public static final String BUS_TYPE = "busType";//业务类型
			public static final String BUSINESS_NAME = "businessName";//业务名称
			public static final String CUST_LEVEL = "custLevel";//客户类型
			public static final String CUST_NAME="custName";//客户类型名称
			public static final String PDJ_LEVEL = "pdjLevel";//排队机等级
			public static final String TICKET_TYPE = "ticketType";//取票类型
			public static final String TICKET_NO = "ticketNo";//排队号
			public static final String CUST_ID = "custId";//客户号
			public static final String CARD_TYPE = "cardType";//刷卡类型
			public static final String CARD_NO = "cardNo";//卡的内容
			public static final String MANAGER_NO = "managerNo";//大堂经理号
			public static final String TRX_STATUS = "trxStatus";//号票状态
			public static final String PRINT_TIME = "printTime";//取号日期
			public static final String CALL_TIME = "callTime";//叫号日期
			public static final String BEGIN_TIME = "beginTime";//业务开始办理时间
			public static final String END_TIME = "endTime";//业务办理完成时间
			public static final String APP_VALUE = "appValue";//评价值
			public static final String WIN_NO = "winNo";//办理窗口
			public static final String TELLER_NO = "tellerNo";//柜员号
			public static final String EXTEND1 = "extend1";//
			public static final String EXTEND2 = "extend2";//
			public static final String EXTEND3 = "extend3";//
			//关联的一些字段
			public static final String START_DATE = "startDate";//开始时间
			public static final String END_DATE = "endDate";//结束时间
		}
	
	
	/**
	 * 业务量报表
	 * @author humz
	 *
	 */
	public static final class BusinessCountReport{
			
			public static final String ORG_ID = "orgId";//机构编码
			public static final String ORG_CODE = "orgCode";//机构编码
			public static final String ORG_NAME ="orgName";//机构名称
			public static final String BUS_TYPE = "busType";//业务类型
			public static final String BUSINESS_NAME ="businessName";//业务名称
			public static final String DEAL_COUNT ="dealCount";//总受理量
			public static final String AVG_WAIT ="avgWait";//平均等待时长
			public static final String MAX_WAIT ="maxWait";//最大等待时间
			public static final String MIN_WAIT ="minWait";//最小等待时间
			public static final String AVG_DEAL="avgDeal";//平均处理时间
			public static final String MAX_DEAL ="maxDeal";//最大处理时间
			public static final String MIN_DEAL ="minDeal";//最小处理时间
			
			//关联的一些字段
			public static final String START_DATE = "startDate";//开始日期
			public static final String END_DATE = "endDate";//结束日期
	}
	
	
	/**
	 * 业务统计报表
	 * @author humz
	 *
	 */
	public static final class BusinessStatisticsReport{
		public static final String ORG_ID = "orgId";
		public static final String ORG_CODE = "orgCode";//机构编码
		public static final String ORG_NAME ="orgName";//机构名称
		public static final String BUS_TYPE = "busType";//业务类型
		public static final String BUSINESS_NAME ="businessName";//业务名称
		public static final String CUST_LEVEL = "custLevel";//客户类型
		public static final String CUST_NAME="custName";//客户类型名称
		public static final String DEAL_COUNT ="dealCount";//总受理量
		public static final String WAIT_COUNT ="waitCount";//等待超时
		public static final String NOTWAIT_COUNT ="notwaitCount";//等待未超时
		public static final String DEALWAIT_COUNT ="dealwaitCount";//办理超时
		public static final String NOTDEALWAIT_COUNT="notdealwaitCount";//办理未超时
		//关联的一些字段
		public static final String START_DATE = "startDate";//开始日期
		public static final String END_DATE = "endDate";//结束日期
		
	}
	
	
	
	/**
	 * 分页的相关信息
	 * @author humz
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
	 * 排队号记录类字段属性
	 * @author daxian
	 *
	 */
	public static final class Trxtoday{
		public static final String ORG_ID = "orgId";
		public static final String ORG_CODE = "orgCode";//机构编码
		public static final String DEVICE_NO = "deviceNo";
		public static final String TRX_DATE = "trxDate";
		public static final String FLOW_NO = "flowNo";
		public static final String BUS_ID = "busId";
		public static final String BUS_TYPE = "busType";
		public static final String CUST_TYPE = "custType";
		public static final String PDJ_LEVEL = "pdjLevel";
		public static final String TICKET_TYPE = "ticketType";
		public static final String TICKET_NO = "ticketNo";
		public static final String CUST_ID = "custId";
		public static final String CARD_TYPE = "cardType";
		public static final String CARD_NO = "cardNo";
		public static final String MANAGER_NO = "managerNo";
		public static final String TRX_TYPE = "trxType";
		public static final String TRX_STATUS = "trxStatus";
		public static final String PRINT_TIME = "printTime";
		public static final String CALL_TIME = "callTime";
		public static final String BEGIN_TIME = "beginTime";
		public static final String END_TIME = "endTime";
		public static final String APP_VALUE = "appValue";
		public static final String WIN_NO = "winNo";
		public static final String TELLER_NO = "tellerNo";
		public static final String RECALL_COUNT = "recallCount";
		public static final String PAUSE_BEGINTIME = "pauseBeginTime";
		public static final String PAUSE_ENDTIME = "pauseEndTime";
		public static final String CALL_TYPE = "callType";
		public static final String TRANSFER_COUNT = "transferCount";
		public static final String BUZ_FLAG = "buzFlag";
		public static final String UpFlag = "upFlag";
		public static final String EXTEND1 = "extend1";
		public static final String EXTEND2 = "extend2";
		public static final String EXTEND3 = "extend3";
	}
	
	/**
	 * 系统交互日志记录相关字段
	 * @author pzw
	 *
	 */
	public static final class OperationInfo{
		public static final String data = "data";
		public static final String type = "type";
		public static final String date = "date";
	}
	
	
}
