package com.aoto.iqms.basicconfig.commons.constant;

public class BasicconfigBeanProperty {
	
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
	 * 业务管理字段（字段名称和数据库对应，值和model类字段对应）
	 * @author humz
	 *
	 */
	public static final class BusinessManage{
		public static final String BUSINESS_ID = "businessId";//业务id		
		public static final String BUSINESS_NAME = "businessName";//业务名称
		public static final String AVERAGE_TIME = "averageTime";//业务平均办理时长
		public static final String ORDER_FLAG = "orderFlag";//是否可预约
		public static final String BUSINESS_ENAME = "businessEName";//业务英文名
	}
	
	/**
	 * 柜员字段（字段名称和数据库字段对应）
	 * @author daxian
	 *
	 */
	public static final class TellerInfo{
		public static final String ORG_CODE = "orgCode";
		public static final String ORG_NAME = "orgName";
		public static final String WORK_ID = "workId";
		public static final String CALLER_PWD = "callerPwd";
		public static final String NAME = "name";
		public static final String SEX = "sex";
		public static final String STATUS = "status";
		public static final String CONTAINSUB = "containSub";
	}
	
	/**
	 * 客户等级字段
	 * @author daxian
	 *
	 */
	public static final class CustType{
		public static final String CUST_LEVEL = "custLevel"; //客户等级 
		public static final String CUST_NAME = "custName";     //客户类型名称
		public static final String VIP_FLAG = "vipFlag"; //是否vip
		public static final String SMS_FLAG = "smsFlag";//是否发送短信
		public static final String WAIT_TIMEOUT = "waitTimeout";//等待超时
		public static final String PRESENT_FLAG = "presentFlag";//是否发送礼品
		public static final String IS_USE = "isUse";  //是否启用
		public static final String EXTEND1 = "expend1";  //扩展字段1
		public static final String EXTEND2 = "expend2"; //扩展字段2
		public static final String EXTEND3 = "expend3"; //扩展字段3
	}
	
	/**
	 * 本地客户
	 * @author humz
	 *
	 */
	public static final class CusInfo{
		public static final String ORG_ID = "orgId";//机构ID
		public static final String ORG_CODE = "orgCode";
		public static final String ORG_NAME = "orgName";//机构名称
		public static final String CUST_ID = "custId";//客户识别码(卡号，身份证号，手机号码等)
		public static final String CUST_NAME = "custName";//客户姓名
		public static final String CUST_LEVEL = "custLevel";//客户类型码(表BC_CUSTTYPE)
		public static final String CUS_NAME = "cusName";//客户类型名称
		public static final String CUST_PDUT = "custPdut";//客户开办产品
		public static final String CUST_AD = "custAd";//客户精准广告
		public static final String ISBANK_EFTVE = "isBankEftve";//是否全行生效。1：是 0：否 ，默认全行生效，否则只在所加网点生效
	}
	
	
	/**
	 * 系统参数配置
	 * @author daxian
	 *
	 */
	public static final class CusParam{
		public static final String WAIT_OUTTIME = "waitOutTime";
		public static final String DO_OUTTIME = "doOutTime";
		public static final String BANK_AD = "bankAd";
		public static final String SFACE_AD = "spaceAd";
		public static final String EXTEND1 = "expend1";
		public static final String EXTEND2 = "expend2";
		public static final String EXTEND3 = "expend3";
	}
	
	/**
	 * 设备管理
	 * @author daxian
	 *
	 */
	public static final class DeviceInfo{
		public static final String ORG_ID = "orgId";
		public static final String ORG_CODE = "orgCode";
		public static final String DEVICE_NO = "deviceNo";
		public static final String IS_SERVER = "isServer"; //设备是否在线
		public static final String HOST_NAME = "hostName"; //主机名
		public static final String IP_ADDR = "ipAddr";   //ip地址
		public static final String MAC_ADDR = "macAddr"; //mac地址
		public static final String SW_VER = "swVer";  //当前版本号
		public static final String PRODUCER = "producer";//厂商
		public static final String INSTALL_DATE = "installDate";//安装日期
		public static final String ADMIN_NAME = "adminName";//管理员姓名
		public static final String ADMIN_PHONE = "adminPhone";//管理员电话
		public static final String ONLINE_TIME = "onlineTime";//最后在线时间
		public static final String VERSION_NAME = "versionName";//当前版本名称
		//public static final String CV_NAME = "cvName"; //关联出的正在使用的版本名称
		//public static final String NV_NAME = "nvName"; //关联出的最新的使用的版本名称
		public static final String LAST_VER = "lastVer"; //最新版本号
		public static final String LAST_VERNAME = "lastVername";//最新版本名称
		public static final String IS_LSTVERSION = "islstversion"; //是否是最新版本
		public static final String UP_TYPE="upType"; //更新类型  1-普通更新，  2-确认更新
		
		//21051231 by hongxz 增加本地网   是否提供预约
		public static final String NET_ORGCODE = "netOrgCode";//本地网
		public static final String ORDER_FLAG = "orderFlag";//是否预约
		public static final String EXTEND1 = "extend1";//扩展字段1
		public static final String EXTEND2 = "extend2";//扩展字段2
		public static final String EXTEND3 = "extend3";//扩展字段3
		
	}
	
	/**
	 * 版本管理
	 * @author daxian
	 *
	 */
	public static final class ClientVersion{
		public static final String ORG_CODE = "orgCode";
		public static final String VENDER_NO = "venderNo";
		public static final String VERSION_NO = "versionNo";
		public static final String ATTACHMENT_PATH = "attachmentPath";
		public static final String VERSION_DATE = "versionDate";
		public static final String MD5_CODE = "md5Code";
		public static final String ORG_NAME = "orgName";
		public static final String VERSION_NAME = "versionName";
	}
	
	/**
	 * (新)版本管理
	 * @author daxian
	 *
	 */
	public static final class PatchVersion {
		public static final String ID = "id";
		public static final String PATCH_NAME = "patchName";
		public static final String PATCH_VERNO = "patchVerno";
		public static final String PATCH_MD5 = "patchMd5";
		public static final String PATCH_PATH = "patchPath";
		public static final String PATCH_REMARK = "patchRemark";
		public static final String PATCH_DATE = "patchDate";
		public static final String STATUS = "status";
		public static final String INTACT_FLAG = "intactFlag";
		public static final String DB_FLAG = "dbFlag";
		
	}
	
	/**
	 * (新)设备更新
	 * @author daxian
	 *
	 */
	public static final class UpgradeProcess {
		public static final String ID = "id";
		public static final String DEVICE_NO = "devcieNo";
		public static final String PATCH_ID = "patchId";
		public static final String OPTDATE = "optdate";
		public static final String STATUS = "status";
		public static final String DLDATE = "dldate";
	}
	
	/**
	 * 设备状态
	 * @author wwl 
	 * @since 20150909
	 *
	 */
	public static final class DeviceStatusInfo{
		public static final String ORG_ID = "orgid";
		public static final String ORG_CODE = "orgcode";
		public static final String DEVICE_ID = "devid"; 
	}
	
	
	/**
	 * 台席管理
	 * @author daxian
	 *
	 */
	public static final class WinInfo {
		public static final String ORG_ID="orgId";
		public static final String ORG_CODE="orgCode";
		public static final String ORG_NAME = "orgName";
		public static final String WIN_NO = "winNo";
		public static final String WIN_NAME = "winName";
		public static final String STATUS = "status";
	}
	
	/**
	 * 广告配置
	 * @author humz
	 *
	 */
	public static final class AdConfig {
		public static final String ID = "id";	
		public static final String ORG_CODE = "orgCode";
		public static final String ORG_NAME = "orgName";
		public static final String ORG_AD ="orgAd";
		public static final String TICKET_AD ="ticketAd";
		public static final String CREATE_TIME="createTime";
		public static final String IS_USE="isUse";
		public static final String ORG_ID = "orgId";
	}	

	/**
	 * 二维码管理
	 * @author humz
	 *
	 */
	public static final class QrCode {
		public static final String ID = "id";	
		public static final String ORG_CODE = "orgCode";
		public static final String ORG_NAME = "orgName";
		public static final String QRCODE_NAME ="qrcodeName";
		public static final String QRCODE_PATH ="qrcodePath";
		public static final String CREATE_TIME="createTime";
		public static final String ORG_ID = "orgId";
		public static final String QRCODE_INFO = "qrcodeInfo";//增加二维码说明20170413
	
	}
	
	/**
	 * (新)二维码更新
	 * @author humz
	 *
	 */
	public static final class QrcodeUpdate {
		public static final String ID = "id";
		public static final String ORGCODE = "orgCode";
		public static final String QRCODE_ID = "qrcodeId";
		public static final String OPTDATE = "optdate";
		public static final String STATUS = "status";
		public static final String DLDATE = "dldate";
	}
	
	/**
	 * 等待配置
	 * @author zhangxp02
	 *
	 */
	public static final class WaitConfig {
		public static final String ID = "id";
		public static final String ORG_CODE = "orgCode";
		public static final String ORG_NAME = "orgName";
		public static final String WAIT_NUM = "waitNum";
		public static final String CREATE_TIME = "createTime";
		public static final String IS_USE = "isUse";
		public static final String ORG_ID = "orgId";
	}
	
	/**
	 * 预约配置
	 * @author daxian
	 *
	 */
	public static final class OrderRange {
		public static final String ID = "id";
		public static final String ORG_CODE = "orgCode";
		public static final String ORG_NAME = "orgName";
		public static final String BEGIN_TIME = "beginTime";
		public static final String END_TIME = "endTime";
		public static final String ORDERCOUNT = "orderCount";
		public static final String ORG_ID = "orgid";
	}
	
	/**
	 * 菜单管理
	 * @author zhousj
	 *
	 */
	public static final class BcMenu {
		public static final String MENU_ID = "menuId";
		public static final String MENU_NAME = "menuName";
		public static final String MENU_ENNAME = "menuEnName";
		public static final String EXTEND1 = "extend1";
	}
	
	/**
	 * 参数配置
	 * @author zhousj
	 */
	public static final class Parameter {
		public static final String HB_INTERVAL = "hbInterval";
		public static final String AUTHENTICATION_TYPE = "authenticationType";
		public static final String FLOW_PORT = "flowPort";
		public static final String HTTP_PORT = "httpPort";
		public static final String IDENT_PORT = "identPort";
		public static final String APP_ROOT = "appRoot";
	}
	
	/**
	 * 柜员管理
	 * @author zhousj
	 */
	public static final class Teller {
		public static final String ORG_CODE = "orgCode";
		public static final String ORG_NAME = "orgName";
		public static final String ORG_ID = "orgId";
		public static final String WORK_ID = "workId";
		public static final String CALLER_PWD = "callerPwd";
		public static final String NAME_ = "name_";
		public static final String SEX = "sex";
		public static final String STATUS = "status";
	}
	
	/**
	 * 临近网点管理
	 * @author zhousj
	 */
	public static final class Near {
		public static final String ORG_ID = "orgId";
		public static final String ORG_ID1 = "orgId1";
		public static final String ORG_ID2 = "orgId2";
		public static final String ORG_ID3 = "orgId3";
		public static final String ORG_ID4 = "orgId4";
		public static final String ORG_ID5 = "orgId5";
		public static final String ORG_ID6 = "orgId6";
	}
	
	/**
	 * 预约配置
	 * @author zhousj
	 */
	public static final class OrderConfig {
		public static final String ID = "id";
		public static final String ORDER_ID = "orderId";
		public static final String ORG_CODE = "orgCode";
		public static final String DEVICE_NO = "deviceNo";
		public static final String BEGIN_TIME = "beginTime";
		public static final String END_TIME = "endTime";
		public static final String ORDER_COUNT = "orderCount";
		public static final String ORG_ID = "orgId";
	}
	
	/**
	 * 上传文件类
	 * @author zhousj
	 *
	 */
	public static final class ResourceUpload {
		public static final String ID = "id";
		public static final String FILE_NAME = "fileName";
		public static final String FILE_PATH = "filePath";
		public static final String FILE_TYPE = "fileType";
		public static final String UPLOAD_DATE = "uploadDate";
		public static final String FILE_REMARK = "fileRemark";
		
	}
}
