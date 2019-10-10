prompt PL/SQL Developer import file
prompt Created on 2018年2月23日 by zhousj
set feedback off
set define off
prompt Loading BC_PARAMETER...
insert into BC_PARAMETER (hb_interval, authentication_type, flow_port, ident_port, http_port, app_root)
values (5, '1', '8999', '8998', '7001', '/iqms');
commit;
prompt 1 records loaded
prompt Loading BC_MENU...
insert into BC_MENU (menu_id, menu_name, menu_enname, extend1)
values (1, '业务类型', 'busType', null);
commit;
prompt 1 records loaded
prompt Loading BC_NUMBERFORM...
insert into BC_NUMBERFORM (tktformat_id, tktformat, org_id, device_no)
values (2, 'tktPrefix|custPrefix|000', null, null);
commit;
prompt 1 records loaded
prompt Loading BC_QUEUECTRL...
insert into BC_QUEUECTRL (id, key, value, type, max)
values (21, 'textAdv', '文字广告', '2', null);
insert into BC_QUEUECTRL (id, key, value, type, max)
values (24, 'buzType', '业务类型', '2', null);
insert into BC_QUEUECTRL (id, key, value, type, max)
values (25, 'message', '取票提示', '1', null);
insert into BC_QUEUECTRL (id, key, value, type, max)
values (45, 'systemTime', '系统时间', '1', null);
insert into BC_QUEUECTRL (id, key, value, type, max)
values (46, 'lobbyManager', '大堂经理', '1', null);
insert into BC_QUEUECTRL (id, key, value, type, max)
values (49, 'picAdv', '图片广告', '2', null);
insert into BC_QUEUECTRL (id, key, value, type, max)
values (50, 'videoAdv', '视频广告', '2', null);
insert into BC_QUEUECTRL (id, key, value, type, max)
values (51, 'coupon', '优惠券', '2', null);
insert into BC_QUEUECTRL (id, key, value, type, max)
values (52, 'music', '音乐', '2', null);
insert into BC_QUEUECTRL (id, key, value, type, max)
values (53, 'validate', '输入验证', '1', null);
insert into BC_QUEUECTRL (id, key, value, type, max)
values (55, 'OrderRange', '预约激活', '1', null);
commit;
prompt 11 records loaded
prompt Loading SYS_DIC...
insert into SYS_DIC (dic_id, dic_name, dic_key, dic_value, dic_type, dic_symbol, created_by, created_date, last_updated_by, last_updated_date)
values (1014, '客户等级名称', '1', '级别1', 'levelName', null, -1, to_timestamp('14-07-2017 09:51:22.540', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('14-07-2017 09:51:22.540', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_DIC (dic_id, dic_name, dic_key, dic_value, dic_type, dic_symbol, created_by, created_date, last_updated_by, last_updated_date)
values (1015, '客户等级名称', '2', '级别2', 'levelName', null, -1, to_timestamp('14-07-2017 09:51:22.540', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('14-07-2017 09:51:22.540', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_DIC (dic_id, dic_name, dic_key, dic_value, dic_type, dic_symbol, created_by, created_date, last_updated_by, last_updated_date)
values (1016, '客户等级名称', '3', '级别3', 'levelName', null, -1, to_timestamp('14-07-2017 09:51:22.540', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('14-07-2017 09:51:22.540', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_DIC (dic_id, dic_name, dic_key, dic_value, dic_type, dic_symbol, created_by, created_date, last_updated_by, last_updated_date)
values (1017, '客户等级名称', '4', '级别4', 'levelName', null, -1, to_timestamp('14-07-2017 09:51:22.540', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('14-07-2017 09:51:22.540', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_DIC (dic_id, dic_name, dic_key, dic_value, dic_type, dic_symbol, created_by, created_date, last_updated_by, last_updated_date)
values (1018, '客户等级名称', '5', '级别5', 'levelName', null, -1, to_timestamp('14-07-2017 09:51:22.540', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('14-07-2017 09:51:22.540', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_DIC (dic_id, dic_name, dic_key, dic_value, dic_type, dic_symbol, created_by, created_date, last_updated_by, last_updated_date)
values (1019, '客户等级名称', '6', '级别6', 'levelName', null, -1, to_timestamp('14-07-2017 09:51:22.540', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('14-07-2017 09:51:22.540', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_DIC (dic_id, dic_name, dic_key, dic_value, dic_type, dic_symbol, created_by, created_date, last_updated_by, last_updated_date)
values (1020, '客户等级名称', '7', '级别7', 'levelName', null, -1, to_timestamp('14-07-2017 09:51:22.540', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('14-07-2017 09:51:22.540', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_DIC (dic_id, dic_name, dic_key, dic_value, dic_type, dic_symbol, created_by, created_date, last_updated_by, last_updated_date)
values (1021, '客户等级名称', '8', '级别8', 'levelName', null, -1, to_timestamp('14-07-2017 09:51:22.540', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('14-07-2017 09:51:22.540', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_DIC (dic_id, dic_name, dic_key, dic_value, dic_type, dic_symbol, created_by, created_date, last_updated_by, last_updated_date)
values (1022, '客户等级名称', '9', '级别9', 'levelName', null, -1, to_timestamp('14-07-2017 09:51:22.540', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('14-07-2017 09:51:22.540', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_DIC (dic_id, dic_name, dic_key, dic_value, dic_type, dic_symbol, created_by, created_date, last_updated_by, last_updated_date)
values (1006, '职员角色', '0', '专家', 'clerkTypes', null, -1, to_timestamp('05-06-2017 17:15:13.751', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('05-06-2017 17:15:13.751', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_DIC (dic_id, dic_name, dic_key, dic_value, dic_type, dic_symbol, created_by, created_date, last_updated_by, last_updated_date)
values (1007, '职员角色', '1', '普通职员', 'clerkTypes', null, -1, to_timestamp('05-06-2017 17:15:13.751', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('05-06-2017 17:15:13.751', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_DIC (dic_id, dic_name, dic_key, dic_value, dic_type, dic_symbol, created_by, created_date, last_updated_by, last_updated_date)
values (1, '公司名', 'AOTO', '奥拓电子', 'COM', null, -1, to_timestamp('24-02-2016 14:44:40.891', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('12-05-2016 15:16:11.132', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_DIC (dic_id, dic_name, dic_key, dic_value, dic_type, dic_symbol, created_by, created_date, last_updated_by, last_updated_date)
values (2, '公司名', 'SUNING', '苏宁', 'COM', null, -1, to_timestamp('24-02-2016 14:44:40.891', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('12-05-2016 15:16:11.132', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_DIC (dic_id, dic_name, dic_key, dic_value, dic_type, dic_symbol, created_by, created_date, last_updated_by, last_updated_date)
values (1000, '设备类型', '1', 'X86广告机', 'deviceTypes', null, -1, to_timestamp('31-05-2017 16:40:41.453', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('31-05-2017 16:40:41.453', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_DIC (dic_id, dic_name, dic_key, dic_value, dic_type, dic_symbol, created_by, created_date, last_updated_by, last_updated_date)
values (1001, '设备类型', '2', 'Android广告机', 'deviceTypes', null, -1, to_timestamp('31-05-2017 16:40:41.453', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('31-05-2017 16:40:41.453', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_DIC (dic_id, dic_name, dic_key, dic_value, dic_type, dic_symbol, created_by, created_date, last_updated_by, last_updated_date)
values (1002, '供应商', '1', '南京奥拓', 'suppliers', null, -1, to_timestamp('31-05-2017 16:58:23.974', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('17-10-2017 14:29:03.002', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_DIC (dic_id, dic_name, dic_key, dic_value, dic_type, dic_symbol, created_by, created_date, last_updated_by, last_updated_date)
values (1004, '性别', '0', '男', 'sexType', null, -1, to_timestamp('05-06-2017 16:06:37.642', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('05-06-2017 16:06:37.642', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_DIC (dic_id, dic_name, dic_key, dic_value, dic_type, dic_symbol, created_by, created_date, last_updated_by, last_updated_date)
values (1005, '性别', '1', '女', 'sexType', null, -1, to_timestamp('05-06-2017 16:06:37.642', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('05-06-2017 16:06:37.642', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_DIC (dic_id, dic_name, dic_key, dic_value, dic_type, dic_symbol, created_by, created_date, last_updated_by, last_updated_date)
values (1012, '柜员状态', '0', '无效', 'tellerStatus', null, -1, to_timestamp('20-06-2017 10:40:25.828', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('20-06-2017 10:40:25.828', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_DIC (dic_id, dic_name, dic_key, dic_value, dic_type, dic_symbol, created_by, created_date, last_updated_by, last_updated_date)
values (1013, '柜员状态', '1', '有效', 'tellerStatus', null, -1, to_timestamp('20-06-2017 10:40:25.828', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('20-06-2017 10:40:25.828', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_DIC (dic_id, dic_name, dic_key, dic_value, dic_type, dic_symbol, created_by, created_date, last_updated_by, last_updated_date)
values (1008, '识别模式', '1', '远程识别', 'recognitionType', null, -1, to_timestamp('16-06-2017 09:08:22.991', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('16-06-2017 09:08:22.991', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_DIC (dic_id, dic_name, dic_key, dic_value, dic_type, dic_symbol, created_by, created_date, last_updated_by, last_updated_date)
values (1009, '识别模式', '2', '本地识别', 'recognitionType', null, -1, to_timestamp('16-06-2017 09:08:22.991', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('16-06-2017 09:08:22.991', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_DIC (dic_id, dic_name, dic_key, dic_value, dic_type, dic_symbol, created_by, created_date, last_updated_by, last_updated_date)
values (1010, '识别模式', '3', '远程+本地按高计算', 'recognitionType', null, -1, to_timestamp('16-06-2017 09:08:22.991', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('16-06-2017 09:08:22.991', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_DIC (dic_id, dic_name, dic_key, dic_value, dic_type, dic_symbol, created_by, created_date, last_updated_by, last_updated_date)
values (1011, '识别模式', '4', '远程+本地按低计算', 'recognitionType', null, -1, to_timestamp('16-06-2017 09:08:22.991', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('16-06-2017 09:08:22.991', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_DIC (dic_id, dic_name, dic_key, dic_value, dic_type, dic_symbol, created_by, created_date, last_updated_by, last_updated_date)
values (1023, '客户等级名称', '0', '普通', 'levelName', null, -1, to_timestamp('14-07-2017 09:51:22.540', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('14-07-2017 09:51:22.540', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_DIC (dic_id, dic_name, dic_key, dic_value, dic_type, dic_symbol, created_by, created_date, last_updated_by, last_updated_date)
values (1042, '取号元素', 'textAdv', '文字广告', 'takeElement', null, -1, to_timestamp('26-09-2017 20:56:12.525', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('28-12-2017 19:06:17.522', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_DIC (dic_id, dic_name, dic_key, dic_value, dic_type, dic_symbol, created_by, created_date, last_updated_by, last_updated_date)
values (1043, '取号元素', 'buzType', '业务类型', 'takeElement', null, -1, to_timestamp('26-09-2017 20:56:12.525', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('28-12-2017 19:06:17.522', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_DIC (dic_id, dic_name, dic_key, dic_value, dic_type, dic_symbol, created_by, created_date, last_updated_by, last_updated_date)
values (1044, '取号元素', 'message', '取票提示', 'takeElement', null, -1, to_timestamp('26-09-2017 20:56:12.525', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('28-12-2017 19:06:17.522', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_DIC (dic_id, dic_name, dic_key, dic_value, dic_type, dic_symbol, created_by, created_date, last_updated_by, last_updated_date)
values (1045, '取号元素', 'systemTime', '系统时间', 'takeElement', null, -1, to_timestamp('26-09-2017 20:56:12.525', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('28-12-2017 19:06:17.522', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_DIC (dic_id, dic_name, dic_key, dic_value, dic_type, dic_symbol, created_by, created_date, last_updated_by, last_updated_date)
values (1046, '取号元素', 'lobbyManager', '大堂经理', 'takeElement', null, -1, to_timestamp('26-09-2017 20:56:12.525', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('28-12-2017 19:06:17.522', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_DIC (dic_id, dic_name, dic_key, dic_value, dic_type, dic_symbol, created_by, created_date, last_updated_by, last_updated_date)
values (1047, '取号元素', 'picAdv', '图片广告', 'takeElement', null, -1, to_timestamp('26-09-2017 20:56:12.525', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('28-12-2017 19:06:17.522', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_DIC (dic_id, dic_name, dic_key, dic_value, dic_type, dic_symbol, created_by, created_date, last_updated_by, last_updated_date)
values (1052, '取号元素', 'OrderRange', '预约激活', 'takeElement', null, -1, to_timestamp('26-09-2017 20:56:12.525', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('28-12-2017 19:06:17.522', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_DIC (dic_id, dic_name, dic_key, dic_value, dic_type, dic_symbol, created_by, created_date, last_updated_by, last_updated_date)
values (1057, '分辨率', '1024x1280', '1024x1280', 'screenResolution', null, -1, to_timestamp('26-09-2017 20:57:59.043', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('28-12-2017 15:40:59.917', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_DIC (dic_id, dic_name, dic_key, dic_value, dic_type, dic_symbol, created_by, created_date, last_updated_by, last_updated_date)
values (1058, '柜员登录匹配', 'tellerLoginMatching', '1', 'tellerLoginMatching', null, -1, to_timestamp('26-09-2017 20:59:21.516', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('26-09-2017 20:59:21.516', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_DIC (dic_id, dic_name, dic_key, dic_value, dic_type, dic_symbol, created_by, created_date, last_updated_by, last_updated_date)
values (1059, '日期类型', '1', '平日', 'dateType', null, -1, to_timestamp('26-09-2017 21:00:24.783', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('26-09-2017 21:00:24.783', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_DIC (dic_id, dic_name, dic_key, dic_value, dic_type, dic_symbol, created_by, created_date, last_updated_by, last_updated_date)
values (1060, '日期类型', '2', '假日', 'dateType', null, -1, to_timestamp('26-09-2017 21:00:24.783', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('26-09-2017 21:00:24.783', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_DIC (dic_id, dic_name, dic_key, dic_value, dic_type, dic_symbol, created_by, created_date, last_updated_by, last_updated_date)
values (1061, '设备参数', 'bankCode', 'NB20028', 'deviceElement', null, -1, to_timestamp('26-09-2017 21:10:52.947', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('26-09-2017 21:10:52.947', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_DIC (dic_id, dic_name, dic_key, dic_value, dic_type, dic_symbol, created_by, created_date, last_updated_by, last_updated_date)
values (1062, '设备参数', 'registerCode', '1BB2-1A22-059F-17CA-19BE', 'deviceElement', null, -1, to_timestamp('26-09-2017 21:10:52.947', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('26-09-2017 21:10:52.947', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_DIC (dic_id, dic_name, dic_key, dic_value, dic_type, dic_symbol, created_by, created_date, last_updated_by, last_updated_date)
values (1063, '设备参数', 'province', '江苏省', 'deviceElement', null, -1, to_timestamp('26-09-2017 21:10:52.947', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('26-09-2017 21:10:52.947', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_DIC (dic_id, dic_name, dic_key, dic_value, dic_type, dic_symbol, created_by, created_date, last_updated_by, last_updated_date)
values (1064, '设备参数', 'city', '南京', 'deviceElement', null, -1, to_timestamp('26-09-2017 21:10:52.947', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('26-09-2017 21:10:52.947', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_DIC (dic_id, dic_name, dic_key, dic_value, dic_type, dic_symbol, created_by, created_date, last_updated_by, last_updated_date)
values (1065, '设备参数', 'volume', '20', 'deviceElement', null, -1, to_timestamp('26-09-2017 21:10:52.947', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('26-09-2017 21:10:52.947', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_DIC (dic_id, dic_name, dic_key, dic_value, dic_type, dic_symbol, created_by, created_date, last_updated_by, last_updated_date)
values (1066, '设备参数', 'isMute', 'false', 'deviceElement', null, -1, to_timestamp('26-09-2017 21:10:52.947', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('26-09-2017 21:10:52.947', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_DIC (dic_id, dic_name, dic_key, dic_value, dic_type, dic_symbol, created_by, created_date, last_updated_by, last_updated_date)
values (1067, '设备参数', 'openBank', '南京奥拓', 'deviceElement', null, -1, to_timestamp('26-09-2017 21:10:52.947', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('26-09-2017 21:10:52.947', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_DIC (dic_id, dic_name, dic_key, dic_value, dic_type, dic_symbol, created_by, created_date, last_updated_by, last_updated_date)
values (1068, '设备参数', 'botMessage', '欢迎光临南京奥拓电子科技有限公司!', 'deviceElement', null, -1, to_timestamp('26-09-2017 21:10:52.947', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('26-09-2017 21:10:52.947', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_DIC (dic_id, dic_name, dic_key, dic_value, dic_type, dic_symbol, created_by, created_date, last_updated_by, last_updated_date)
values (1069, '设备参数', 'midMessage', '欢迎光临南京奥拓电子科技有限公司', 'deviceElement', null, -1, to_timestamp('26-09-2017 21:10:52.947', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('26-09-2017 21:10:52.947', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_DIC (dic_id, dic_name, dic_key, dic_value, dic_type, dic_symbol, created_by, created_date, last_updated_by, last_updated_date)
values (1070, '设备参数', 'balancedNum', '999', 'deviceElement', null, -1, to_timestamp('26-09-2017 21:10:52.947', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('26-09-2017 21:10:52.947', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_DIC (dic_id, dic_name, dic_key, dic_value, dic_type, dic_symbol, created_by, created_date, last_updated_by, last_updated_date)
values (1071, '设备参数', 'ticketInterval', '5', 'deviceElement', null, -1, to_timestamp('26-09-2017 21:10:52.947', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('26-09-2017 21:10:52.947', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_DIC (dic_id, dic_name, dic_key, dic_value, dic_type, dic_symbol, created_by, created_date, last_updated_by, last_updated_date)
values (1072, '设备参数', 'callInterval', '5', 'deviceElement', null, -1, to_timestamp('26-09-2017 21:10:52.947', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('26-09-2017 21:10:52.947', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_DIC (dic_id, dic_name, dic_key, dic_value, dic_type, dic_symbol, created_by, created_date, last_updated_by, last_updated_date)
values (1073, '设备参数', 'company', '奥拓电子', 'deviceElement', null, -1, to_timestamp('26-09-2017 21:10:52.947', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('26-09-2017 21:10:52.947', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_DIC (dic_id, dic_name, dic_key, dic_value, dic_type, dic_symbol, created_by, created_date, last_updated_by, last_updated_date)
values (1074, '设备参数', 'profession', '金融电子', 'deviceElement', null, -1, to_timestamp('26-09-2017 21:10:52.947', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('26-09-2017 21:10:52.947', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_DIC (dic_id, dic_name, dic_key, dic_value, dic_type, dic_symbol, created_by, created_date, last_updated_by, last_updated_date)
values (1075, '设备参数', 'address', '南京市', 'deviceElement', null, -1, to_timestamp('26-09-2017 21:10:52.947', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('26-09-2017 21:10:52.947', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_DIC (dic_id, dic_name, dic_key, dic_value, dic_type, dic_symbol, created_by, created_date, last_updated_by, last_updated_date)
values (1076, '设备参数', 'weekdayEndTime', '23:59', 'deviceElement', null, -1, to_timestamp('26-09-2017 21:10:52.947', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('26-09-2017 21:10:52.947', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_DIC (dic_id, dic_name, dic_key, dic_value, dic_type, dic_symbol, created_by, created_date, last_updated_by, last_updated_date)
values (1077, '设备参数', 'holidayEndTime', '23:59', 'deviceElement', null, -1, to_timestamp('26-09-2017 21:10:52.947', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('26-09-2017 21:10:52.947', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_DIC (dic_id, dic_name, dic_key, dic_value, dic_type, dic_symbol, created_by, created_date, last_updated_by, last_updated_date)
values (1078, '设备参数', 'powerOffTime', '23:59', 'deviceElement', null, -1, to_timestamp('26-09-2017 21:10:52.947', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('26-09-2017 21:10:52.947', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_DIC (dic_id, dic_name, dic_key, dic_value, dic_type, dic_symbol, created_by, created_date, last_updated_by, last_updated_date)
values (1024, '号票元素', 'logo', 'logo', 'ticketElement', null, -1, to_timestamp('26-09-2017 20:14:25.995', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('17-10-2017 14:35:57.537', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_DIC (dic_id, dic_name, dic_key, dic_value, dic_type, dic_symbol, created_by, created_date, last_updated_by, last_updated_date)
values (1025, '号票元素', 'text', '固定文本', 'ticketElement', null, -1, to_timestamp('26-09-2017 20:14:25.995', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('17-10-2017 14:35:57.537', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_DIC (dic_id, dic_name, dic_key, dic_value, dic_type, dic_symbol, created_by, created_date, last_updated_by, last_updated_date)
values (1026, '号票元素', 'orgCode', '机构代码', 'ticketElement', null, -1, to_timestamp('26-09-2017 20:14:25.995', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('17-10-2017 14:35:57.537', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_DIC (dic_id, dic_name, dic_key, dic_value, dic_type, dic_symbol, created_by, created_date, last_updated_by, last_updated_date)
values (1027, '号票元素', 'orgName', '机构名称', 'ticketElement', null, -1, to_timestamp('26-09-2017 20:14:25.995', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('17-10-2017 14:35:57.537', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_DIC (dic_id, dic_name, dic_key, dic_value, dic_type, dic_symbol, created_by, created_date, last_updated_by, last_updated_date)
values (1028, '号票元素', 'buzCnname', '业务中文名称', 'ticketElement', null, -1, to_timestamp('26-09-2017 20:14:25.995', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('17-10-2017 14:35:57.537', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_DIC (dic_id, dic_name, dic_key, dic_value, dic_type, dic_symbol, created_by, created_date, last_updated_by, last_updated_date)
values (1029, '号票元素', 'buzEnname', '业务英文名称', 'ticketElement', null, -1, to_timestamp('26-09-2017 20:14:25.995', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('17-10-2017 14:35:57.537', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_DIC (dic_id, dic_name, dic_key, dic_value, dic_type, dic_symbol, created_by, created_date, last_updated_by, last_updated_date)
values (1030, '号票元素', 'ticketNo', '号票号码', 'ticketElement', null, -1, to_timestamp('26-09-2017 20:14:25.995', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('17-10-2017 14:35:57.537', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_DIC (dic_id, dic_name, dic_key, dic_value, dic_type, dic_symbol, created_by, created_date, last_updated_by, last_updated_date)
values (1036, '号票元素', 'waitingTime', '预计等候时间', 'ticketElement', null, -1, to_timestamp('26-09-2017 20:14:25.995', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('17-10-2017 14:35:57.537', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_DIC (dic_id, dic_name, dic_key, dic_value, dic_type, dic_symbol, created_by, created_date, last_updated_by, last_updated_date)
values (1037, '号票元素', 'counterNo', '办理窗口', 'ticketElement', null, -1, to_timestamp('26-09-2017 20:14:25.995', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('17-10-2017 14:35:57.537', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_DIC (dic_id, dic_name, dic_key, dic_value, dic_type, dic_symbol, created_by, created_date, last_updated_by, last_updated_date)
values (1038, '号票元素', 'ticketAdv', '号票广告', 'ticketElement', null, -1, to_timestamp('26-09-2017 20:14:25.995', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('17-10-2017 14:35:57.537', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_DIC (dic_id, dic_name, dic_key, dic_value, dic_type, dic_symbol, created_by, created_date, last_updated_by, last_updated_date)
values (1039, '号票元素', 'fetchedDate', '取号时间', 'ticketElement', null, -1, to_timestamp('26-09-2017 20:14:25.995', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('17-10-2017 14:35:57.537', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_DIC (dic_id, dic_name, dic_key, dic_value, dic_type, dic_symbol, created_by, created_date, last_updated_by, last_updated_date)
values (1040, '号票元素', 'totalWaitingCount', '网点等候人数', 'ticketElement', null, -1, to_timestamp('26-09-2017 20:14:25.995', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('17-10-2017 14:35:57.537', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_DIC (dic_id, dic_name, dic_key, dic_value, dic_type, dic_symbol, created_by, created_date, last_updated_by, last_updated_date)
values (1041, '号票元素', 'buzWaitingCount', '业务等候人数', 'ticketElement', null, -1, to_timestamp('26-09-2017 20:14:25.995', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('17-10-2017 14:35:57.537', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_DIC (dic_id, dic_name, dic_key, dic_value, dic_type, dic_symbol, created_by, created_date, last_updated_by, last_updated_date)
values (1080, '取号元素', 'MessRemind', '短信提醒', 'takeElement', null, -1, to_timestamp('09-10-2017 16:44:01.857', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('28-12-2017 19:06:17.522', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_DIC (dic_id, dic_name, dic_key, dic_value, dic_type, dic_symbol, created_by, created_date, last_updated_by, last_updated_date)
values (1082, '供应商', '2', '浪潮', 'suppliers', null, -1, to_timestamp('17-10-2017 14:29:03.002', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('17-10-2017 14:29:03.002', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_DIC (dic_id, dic_name, dic_key, dic_value, dic_type, dic_symbol, created_by, created_date, last_updated_by, last_updated_date)
values (1084, '取号元素', 'nearbyNet', '临近网点', 'takeElement', null, -1, to_timestamp('01-11-2017 15:50:40.965', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('28-12-2017 19:06:17.522', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_DIC (dic_id, dic_name, dic_key, dic_value, dic_type, dic_symbol, created_by, created_date, last_updated_by, last_updated_date)
values (1089, '取号元素', 'videoAdv', '视频广告', 'takeElement', null, -1, to_timestamp('28-12-2017 19:06:17.522', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('28-12-2017 19:06:17.522', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_DIC (dic_id, dic_name, dic_key, dic_value, dic_type, dic_symbol, created_by, created_date, last_updated_by, last_updated_date)
values (1088, '分辨率', '1366x768', '1366x768', 'screenResolution', null, -1, to_timestamp('28-12-2017 15:40:59.917', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('28-12-2017 15:40:59.917', 'dd-mm-yyyy hh24:mi:ss.ff'));
commit;
prompt 72 records loaded
prompt Loading SYS_FUN...
insert into SYS_FUN (fun_id, fun_name, parent_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (230101, '机构分析报表查询', 2301, 2, 4, 0, -1, to_timestamp('26-06-2017 15:09:08.588', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('26-06-2017 15:09:08.588', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_FUN (fun_id, fun_name, parent_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (24, '数据监控', 1, 7, 2, 0, -1, to_timestamp('28-06-2017 13:52:55.778', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('28-06-2017 13:52:55.778', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_FUN (fun_id, fun_name, parent_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (230301, '客户来行时间报表查询', 2303, 2, 4, 0, -1, to_timestamp('05-07-2017 11:32:21.906', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('05-07-2017 11:32:21.906', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_FUN (fun_id, fun_name, parent_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (230201, '柜员效率报表查询', 2302, 2, 4, 0, -1, to_timestamp('05-07-2017 11:33:02.794', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('05-07-2017 11:33:02.794', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_FUN (fun_id, fun_name, parent_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (230401, '柜员评价报表查询', 2304, 2, 4, 0, -1, to_timestamp('06-07-2017 11:12:56.016', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('06-07-2017 11:12:56.016', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_FUN (fun_id, fun_name, parent_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (230501, '客户分析报表查询', 2305, 2, 4, 0, -1, to_timestamp('10-07-2017 16:34:35.759', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('10-07-2017 16:34:35.759', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_FUN (fun_id, fun_name, parent_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (200604, '窗口删除', 2006, 5, 4, 0, -1, to_timestamp('11-07-2017 17:23:27.257', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('11-07-2017 17:23:27.257', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_FUN (fun_id, fun_name, parent_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (230701, '业务量报表查询', 2307, 2, 4, 0, -1, to_timestamp('14-07-2017 12:09:48.504', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('14-07-2017 12:09:48.504', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_FUN (fun_id, fun_name, parent_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (2008, '号码模板', 19, 6, 3, 0, -1, to_timestamp('18-07-2017 16:01:59.281', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('18-07-2017 16:01:59.281', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_FUN (fun_id, fun_name, parent_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (200801, '号码模板查询', 2008, 2, 4, 0, -1, to_timestamp('18-07-2017 16:03:03.216', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('18-07-2017 16:03:03.216', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_FUN (fun_id, fun_name, parent_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (2010, '网点业务', 20, 6, 3, 0, -1, to_timestamp('24-07-2017 14:27:57.077', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('24-07-2017 14:27:57.077', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_FUN (fun_id, fun_name, parent_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (201002, '网点业务新增', 2010, 3, 4, 0, -1, to_timestamp('24-07-2017 14:29:08.015', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('24-07-2017 14:29:08.015', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_FUN (fun_id, fun_name, parent_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (201004, '网点业务删除', 2010, 5, 4, 0, -1, to_timestamp('24-07-2017 14:30:05.412', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('24-07-2017 14:30:05.412', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_FUN (fun_id, fun_name, parent_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (200601, '窗口配置查询', 2006, 2, 4, 0, -1, to_timestamp('11-07-2017 17:22:31.759', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('11-07-2017 17:22:31.759', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_FUN (fun_id, fun_name, parent_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (240201, '设备监控查询', 2402, 2, 4, 0, -1, to_timestamp('05-07-2017 16:54:42.768', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('05-07-2017 16:54:42.768', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_FUN (fun_id, fun_name, parent_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (2304, '柜员评价报表', 23, 3, 3, 0, -1, to_timestamp('06-07-2017 11:12:39.726', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('06-07-2017 11:12:39.726', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_FUN (fun_id, fun_name, parent_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (200701, '客户等级查询', 2007, 2, 4, 0, -1, to_timestamp('14-07-2017 09:56:01.018', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('14-07-2017 09:56:01.018', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_FUN (fun_id, fun_name, parent_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (200901, '号票模板查询', 2009, 2, 4, 0, -1, to_timestamp('18-07-2017 16:03:47.447', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('18-07-2017 16:03:47.447', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_FUN (fun_id, fun_name, parent_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (2404, '评价监控', 24, 3, 3, 0, -1, to_timestamp('11-08-2017 09:32:57.600', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('11-08-2017 09:32:57.600', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_FUN (fun_id, fun_name, parent_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (19, '基础数据', 1, 4, 2, 0, -1, to_timestamp('08-06-2017 14:21:01.106', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('08-06-2017 14:21:01.106', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_FUN (fun_id, fun_name, parent_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (190103, '客户类型编辑', 1901, 4, 4, 0, -1, to_timestamp('08-06-2017 14:22:32.185', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('08-06-2017 14:22:32.185', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_FUN (fun_id, fun_name, parent_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (190603, '菜单编辑', 1906, 4, 4, 0, -1, to_timestamp('09-06-2017 11:28:42.228', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('09-06-2017 11:28:42.228', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_FUN (fun_id, fun_name, parent_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (190605, '菜单详情', 1906, 6, 4, 0, -1, to_timestamp('09-06-2017 11:29:27.471', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('09-06-2017 11:29:27.471', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_FUN (fun_id, fun_name, parent_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (2001, '设备管理', 20, 2, 3, 0, -1, to_timestamp('15-06-2017 17:09:11.173', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('15-06-2017 17:09:11.173', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_FUN (fun_id, fun_name, parent_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (190703, '业务管理编辑', 1907, 4, 4, 0, -1, to_timestamp('12-06-2017 16:32:13.815', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('12-06-2017 16:32:13.815', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_FUN (fun_id, fun_name, parent_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (190801, '参数查询', 1908, 2, 4, 0, -1, to_timestamp('13-06-2017 11:07:21.692', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('13-06-2017 11:07:21.692', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_FUN (fun_id, fun_name, parent_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (200104, '设备管理删除', 2001, 5, 4, 0, -1, to_timestamp('15-06-2017 17:10:23.883', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('15-06-2017 17:10:23.883', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_FUN (fun_id, fun_name, parent_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (190902, '本地客户新增', 1909, 3, 4, 0, -1, to_timestamp('19-06-2017 16:31:18.044', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('19-06-2017 16:31:18.044', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_FUN (fun_id, fun_name, parent_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (190905, '本地客户详情', 1909, 6, 4, 0, -1, to_timestamp('19-06-2017 16:31:57.770', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('19-06-2017 16:31:57.770', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_FUN (fun_id, fun_name, parent_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (1911, '柜员管理', 19, 7, 3, 0, -1, to_timestamp('20-06-2017 09:24:37.898', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('20-06-2017 09:24:37.898', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_FUN (fun_id, fun_name, parent_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (191104, '柜员删除', 1911, 5, 4, 0, -1, to_timestamp('20-06-2017 09:26:16.271', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('20-06-2017 09:26:16.271', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_FUN (fun_id, fun_name, parent_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (190604, '菜单删除', 1906, 5, 4, 0, -1, to_timestamp('09-06-2017 11:28:56.205', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('09-06-2017 11:28:56.205', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_FUN (fun_id, fun_name, parent_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (1907, '业务管理', 19, 8, 3, 0, -1, to_timestamp('12-06-2017 16:24:10.542', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('12-06-2017 16:24:10.542', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_FUN (fun_id, fun_name, parent_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (190701, '业务管理查询', 1907, 2, 4, 0, -1, to_timestamp('12-06-2017 16:31:39.908', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('12-06-2017 16:31:39.908', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_FUN (fun_id, fun_name, parent_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (190702, '业务管理新增', 1907, 3, 4, 0, -1, to_timestamp('12-06-2017 16:31:58.967', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('12-06-2017 16:31:58.967', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_FUN (fun_id, fun_name, parent_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (1, '功能', 0, 0, 1, 0, null, null, null, null);
insert into SYS_FUN (fun_id, fun_name, parent_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (2, '系统', 1, 1, 2, 0, null, null, null, null);
insert into SYS_FUN (fun_id, fun_name, parent_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (301, '用户管理', 2, 1, 3, 0, null, null, -1, to_timestamp('02-03-2016 16:03:19.912', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_FUN (fun_id, fun_name, parent_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (30101, '用户查询', 301, 1, 4, 0, null, null, -1, to_timestamp('02-03-2016 15:55:32.207', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_FUN (fun_id, fun_name, parent_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (30102, '用户新增', 301, 2, 4, 0, null, null, -1, to_timestamp('02-03-2016 15:55:32.207', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_FUN (fun_id, fun_name, parent_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (30103, '用户编辑', 301, 3, 4, 0, null, null, -1, to_timestamp('02-03-2016 15:55:32.207', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_FUN (fun_id, fun_name, parent_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (30104, '用户删除', 301, 4, 4, 0, null, null, -1, to_timestamp('16-03-2016 08:50:22.964', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_FUN (fun_id, fun_name, parent_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (30105, '重置密码', 301, 5, 4, 0, null, null, -1, to_timestamp('02-03-2016 15:55:32.207', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_FUN (fun_id, fun_name, parent_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (30106, '用户详情', 301, 6, 4, 0, null, null, -1, to_timestamp('02-03-2016 15:55:32.207', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_FUN (fun_id, fun_name, parent_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (30107, '用户锁定', 301, 7, 4, 0, null, null, -1, to_timestamp('02-03-2016 15:55:32.207', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_FUN (fun_id, fun_name, parent_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (30108, '用户解锁', 301, 8, 4, 0, null, null, -1, to_timestamp('02-03-2016 15:55:32.207', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_FUN (fun_id, fun_name, parent_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (302, '功能管理', 2, 2, 3, 0, -1, to_timestamp('24-02-2016 15:51:37.941', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('02-03-2016 16:03:19.912', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_FUN (fun_id, fun_name, parent_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (30201, '功能新增', 302, 1, 4, 0, -1, to_timestamp('24-02-2016 15:51:54.952', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('24-02-2016 15:51:54.952', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_FUN (fun_id, fun_name, parent_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (30202, '功能编辑', 302, 2, 4, 0, -1, to_timestamp('24-02-2016 15:52:02.321', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('24-02-2016 15:52:02.321', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_FUN (fun_id, fun_name, parent_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (30203, '功能删除', 302, 3, 4, 0, -1, to_timestamp('24-02-2016 15:52:12.439', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('24-02-2016 15:52:12.439', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_FUN (fun_id, fun_name, parent_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (30204, '功能详情', 302, 4, 4, 0, -1, to_timestamp('24-02-2016 15:52:17.358', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('24-02-2016 15:52:17.358', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_FUN (fun_id, fun_name, parent_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (30205, '设置URL', 302, 5, 4, 0, -1, to_timestamp('24-02-2016 15:52:26.088', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('24-02-2016 15:52:26.088', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_FUN (fun_id, fun_name, parent_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (30206, '功能查询', 302, 6, 4, 0, -1, to_timestamp('02-03-2016 08:58:33.339', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('02-03-2016 08:58:33.339', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_FUN (fun_id, fun_name, parent_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (303, '菜单管理', 2, 3, 3, 0, -1, to_timestamp('24-02-2016 16:05:10.152', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('02-03-2016 16:03:19.912', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_FUN (fun_id, fun_name, parent_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (30301, '菜单新增', 303, 1, 4, 0, -1, to_timestamp('24-02-2016 16:05:21.426', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('24-02-2016 16:05:21.426', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_FUN (fun_id, fun_name, parent_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (30302, '菜单编辑', 303, 2, 4, 0, -1, to_timestamp('24-02-2016 16:05:25.609', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('24-02-2016 16:05:25.609', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_FUN (fun_id, fun_name, parent_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (30303, '菜单删除', 303, 3, 4, 0, -1, to_timestamp('24-02-2016 16:05:30.721', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('24-02-2016 16:05:30.721', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_FUN (fun_id, fun_name, parent_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (30304, '菜单详情', 303, 4, 4, 0, -1, to_timestamp('24-02-2016 16:05:37.489', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('24-02-2016 16:05:37.489', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_FUN (fun_id, fun_name, parent_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (30305, '菜单查询', 303, 5, 4, 0, -1, to_timestamp('24-02-2016 16:06:13.011', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('24-02-2016 16:06:13.011', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_FUN (fun_id, fun_name, parent_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (304, '角色管理', 2, 4, 3, 0, null, null, -1, to_timestamp('02-03-2016 16:03:19.912', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_FUN (fun_id, fun_name, parent_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (30401, '角色查询', 304, 1, 4, 0, null, null, null, null);
insert into SYS_FUN (fun_id, fun_name, parent_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (30402, '角色新增', 304, 2, 4, 0, null, null, null, null);
insert into SYS_FUN (fun_id, fun_name, parent_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (30403, '角色编辑', 304, 3, 4, 0, null, null, null, null);
insert into SYS_FUN (fun_id, fun_name, parent_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (30404, '角色删除', 304, 4, 4, 0, null, null, null, null);
insert into SYS_FUN (fun_id, fun_name, parent_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (30405, '角色授权', 304, 5, 4, 0, null, null, null, null);
insert into SYS_FUN (fun_id, fun_name, parent_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (30406, '设置成员', 304, 6, 4, 0, null, null, null, null);
insert into SYS_FUN (fun_id, fun_name, parent_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (305, '通用角色管理', 2, 5, 3, 1, null, null, -1, to_timestamp('02-03-2016 16:03:19.912', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_FUN (fun_id, fun_name, parent_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (30501, '通用角色查询', 305, 1, 4, 0, null, null, null, null);
insert into SYS_FUN (fun_id, fun_name, parent_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (30502, '设置成员', 305, 2, 4, 0, null, null, null, null);
insert into SYS_FUN (fun_id, fun_name, parent_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (306, '机构管理', 2, 6, 3, 0, null, null, -1, to_timestamp('02-03-2016 16:03:19.912', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_FUN (fun_id, fun_name, parent_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (30601, '机构查询', 306, 1, 4, 0, null, null, -1, to_timestamp('02-03-2016 15:55:43.537', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_FUN (fun_id, fun_name, parent_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (30602, '机构新增', 306, 2, 4, 0, null, null, -1, to_timestamp('02-03-2016 15:55:43.537', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_FUN (fun_id, fun_name, parent_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (30603, '机构编辑', 306, 3, 4, 0, null, null, -1, to_timestamp('02-03-2016 15:55:43.537', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_FUN (fun_id, fun_name, parent_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (30604, '机构删除', 306, 4, 4, 0, null, null, -1, to_timestamp('02-03-2016 15:55:43.537', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_FUN (fun_id, fun_name, parent_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (30605, '机构详情', 306, 5, 4, 0, null, null, -1, to_timestamp('02-03-2016 15:55:43.537', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_FUN (fun_id, fun_name, parent_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (30606, '机构导出', 306, 6, 4, 0, null, null, -1, to_timestamp('02-03-2016 15:55:43.537', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_FUN (fun_id, fun_name, parent_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (30607, '机构导入', 306, 7, 4, 0, null, null, -1, to_timestamp('02-03-2016 15:55:43.537', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_FUN (fun_id, fun_name, parent_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (307, 'URL管理', 2, 7, 3, 0, -1, to_timestamp('24-02-2016 14:01:11.753', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('02-03-2016 16:03:19.912', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_FUN (fun_id, fun_name, parent_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (30701, 'URL查询', 307, 1, 4, 0, -1, to_timestamp('24-02-2016 14:04:09.055', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('24-02-2016 14:04:09.055', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_FUN (fun_id, fun_name, parent_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (30702, 'URL新增', 307, 2, 4, 0, -1, to_timestamp('24-02-2016 14:04:17.194', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('24-02-2016 14:04:17.194', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_FUN (fun_id, fun_name, parent_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (30703, 'URL编辑', 307, 3, 4, 0, -1, to_timestamp('24-02-2016 14:04:25.241', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('24-02-2016 14:04:25.241', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_FUN (fun_id, fun_name, parent_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (30704, 'URL删除', 307, 4, 4, 0, -1, to_timestamp('24-02-2016 14:04:31.443', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('24-02-2016 14:04:31.443', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_FUN (fun_id, fun_name, parent_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (30705, 'URL详情', 307, 5, 4, 0, -1, to_timestamp('24-02-2016 14:05:01.413', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('24-02-2016 14:05:01.413', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_FUN (fun_id, fun_name, parent_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (401, '字典管理', 2, 8, 3, 0, null, null, -1, to_timestamp('02-03-2016 16:03:19.912', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_FUN (fun_id, fun_name, parent_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (40101, '字典新增', 401, 1, 4, 0, null, null, -1, to_timestamp('24-02-2016 10:30:40.406', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_FUN (fun_id, fun_name, parent_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (40102, '字典编辑', 401, 2, 4, 0, null, null, -1, to_timestamp('24-02-2016 10:30:40.406', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_FUN (fun_id, fun_name, parent_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (40103, '字典删除', 401, 3, 4, 0, null, null, -1, to_timestamp('24-02-2016 10:30:40.406', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_FUN (fun_id, fun_name, parent_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (40104, '字典详情', 401, 4, 4, 0, null, null, -1, to_timestamp('24-02-2016 10:30:40.406', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_FUN (fun_id, fun_name, parent_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (40105, '字典查询', 401, 5, 4, 0, null, null, -1, to_timestamp('24-02-2016 10:30:40.406', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_FUN (fun_id, fun_name, parent_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (501, '日志管理', 2, 9, 3, 0, null, null, -1, to_timestamp('02-03-2016 16:03:19.912', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_FUN (fun_id, fun_name, parent_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (50101, '在线用户', 501, 1, 4, 0, null, null, -1, to_timestamp('23-02-2016 16:24:32.690', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_FUN (fun_id, fun_name, parent_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (50201, '登录日志', 501, 2, 4, 0, null, null, -1, to_timestamp('23-02-2016 16:24:32.690', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_FUN (fun_id, fun_name, parent_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (50301, '用户行为', 501, 3, 4, 0, null, null, -1, to_timestamp('23-02-2016 16:24:32.690', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_FUN (fun_id, fun_name, parent_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (190704, '业务管理删除', 1907, 5, 4, 0, -1, to_timestamp('12-06-2017 16:32:25.348', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('12-06-2017 16:32:25.348', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_FUN (fun_id, fun_name, parent_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (190705, '业务管理详情', 1907, 6, 4, 0, -1, to_timestamp('12-06-2017 16:32:40.184', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('12-06-2017 16:32:40.184', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_FUN (fun_id, fun_name, parent_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (20, '网点配置', 1, 5, 2, 0, -1, to_timestamp('15-06-2017 17:08:54.140', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('15-06-2017 17:08:54.140', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_FUN (fun_id, fun_name, parent_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (200103, '设备管理编辑', 2001, 4, 4, 0, -1, to_timestamp('15-06-2017 17:10:10.439', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('15-06-2017 17:10:10.439', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_FUN (fun_id, fun_name, parent_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (191101, '柜员查询', 1911, 2, 4, 0, -1, to_timestamp('20-06-2017 09:25:28.134', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('20-06-2017 09:25:28.134', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_FUN (fun_id, fun_name, parent_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (191201, '临近网点查询', 1912, 2, 4, 0, -1, to_timestamp('21-06-2017 17:38:50.537', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('21-06-2017 17:38:50.537', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_FUN (fun_id, fun_name, parent_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (1906, '菜单管理', 19, 7, 3, 0, -1, to_timestamp('09-06-2017 11:27:14.010', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('09-06-2017 11:27:14.010', 'dd-mm-yyyy hh24:mi:ss.ff'));
commit;
prompt 100 records committed...
insert into SYS_FUN (fun_id, fun_name, parent_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (1901, '客户类型', 19, 2, 3, 0, -1, to_timestamp('08-06-2017 14:21:21.577', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('08-06-2017 14:21:21.577', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_FUN (fun_id, fun_name, parent_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (190101, '客户类型查询', 1901, 2, 4, 0, -1, to_timestamp('08-06-2017 14:21:48.329', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('08-06-2017 14:21:48.329', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_FUN (fun_id, fun_name, parent_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (190104, '客户类型删除', 1901, 5, 4, 0, -1, to_timestamp('08-06-2017 14:22:40.106', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('08-06-2017 14:22:40.106', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_FUN (fun_id, fun_name, parent_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (190105, '客户类型详情', 1901, 6, 4, 0, -1, to_timestamp('08-06-2017 14:23:07.202', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('08-06-2017 14:23:07.202', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_FUN (fun_id, fun_name, parent_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (190802, '参数保存', 1908, 3, 4, 0, -1, to_timestamp('13-06-2017 11:07:36.695', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('13-06-2017 11:07:36.695', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_FUN (fun_id, fun_name, parent_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (191001, '版本管理查询', 1910, 2, 4, 0, -1, to_timestamp('19-06-2017 19:27:53.451', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('19-06-2017 19:27:53.451', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_FUN (fun_id, fun_name, parent_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (191004, '版本管理详情', 1910, 5, 4, 0, -1, to_timestamp('19-06-2017 19:28:26.549', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('19-06-2017 19:28:26.549', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_FUN (fun_id, fun_name, parent_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (191203, '临近网点删除', 1912, 4, 4, 0, -1, to_timestamp('21-06-2017 17:48:05.139', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('21-06-2017 17:48:05.139', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_FUN (fun_id, fun_name, parent_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (2006, '窗口配置', 20, 7, 3, 0, -1, to_timestamp('11-07-2017 17:22:02.067', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('11-07-2017 17:22:02.067', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_FUN (fun_id, fun_name, parent_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (190102, '客户类型新增', 1901, 3, 4, 0, -1, to_timestamp('08-06-2017 14:22:09.489', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('08-06-2017 14:22:09.489', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_FUN (fun_id, fun_name, parent_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (190601, '菜单查询', 1906, 2, 4, 0, -1, to_timestamp('09-06-2017 11:28:05.364', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('09-06-2017 11:28:05.364', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_FUN (fun_id, fun_name, parent_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (200101, '设备管理查询', 2001, 2, 4, 0, -1, to_timestamp('15-06-2017 17:09:40.910', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('15-06-2017 17:09:40.910', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_FUN (fun_id, fun_name, parent_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (200105, '设备管理详情', 2001, 6, 4, 0, -1, to_timestamp('15-06-2017 17:10:37.727', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('15-06-2017 17:10:37.727', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_FUN (fun_id, fun_name, parent_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (190901, '本地客户查询', 1909, 2, 4, 0, -1, to_timestamp('19-06-2017 16:31:04.003', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('19-06-2017 16:31:04.003', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_FUN (fun_id, fun_name, parent_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (190904, '本地客户删除', 1909, 5, 4, 0, -1, to_timestamp('19-06-2017 16:31:47.455', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('19-06-2017 16:31:47.455', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_FUN (fun_id, fun_name, parent_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (1910, '版本管理', 19, 7, 3, 0, -1, to_timestamp('19-06-2017 19:27:11.356', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('19-06-2017 19:27:11.356', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_FUN (fun_id, fun_name, parent_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (191002, '版本管理编辑', 1910, 3, 4, 0, -1, to_timestamp('19-06-2017 19:28:04.478', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('19-06-2017 19:28:04.478', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_FUN (fun_id, fun_name, parent_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (191003, '版本管理删除', 1910, 4, 4, 0, -1, to_timestamp('19-06-2017 19:28:13.334', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('19-06-2017 19:28:13.334', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_FUN (fun_id, fun_name, parent_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (191102, '柜员新增', 1911, 3, 4, 0, -1, to_timestamp('20-06-2017 09:25:45.332', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('20-06-2017 09:25:45.332', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_FUN (fun_id, fun_name, parent_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (1912, '临近网点配置', 19, 7, 3, 1, -1, to_timestamp('21-06-2017 17:38:16.268', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('21-06-2017 17:38:16.268', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_FUN (fun_id, fun_name, parent_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (191202, '临近网点编辑', 1912, 3, 4, 0, -1, to_timestamp('21-06-2017 17:46:09.689', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('21-06-2017 17:46:09.689', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_FUN (fun_id, fun_name, parent_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (23, '数据报表', 1, 7, 2, 0, -1, to_timestamp('23-06-2017 14:11:07.590', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('23-06-2017 14:11:07.590', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_FUN (fun_id, fun_name, parent_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (200602, '窗口新增', 2006, 3, 4, 0, -1, to_timestamp('11-07-2017 17:22:52.587', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('11-07-2017 17:22:52.587', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_FUN (fun_id, fun_name, parent_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (2308, '业务统计报表', 23, 3, 3, 0, -1, to_timestamp('14-07-2017 16:12:54.620', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('14-07-2017 16:12:54.620', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_FUN (fun_id, fun_name, parent_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (2009, '号票模板', 20, 6, 3, 0, -1, to_timestamp('18-07-2017 16:03:31.843', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('18-07-2017 16:03:31.843', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_FUN (fun_id, fun_name, parent_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (2011, '叫号策略', 20, 6, 3, 0, -1, to_timestamp('31-07-2017 17:58:19.167', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('31-07-2017 17:58:19.167', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_FUN (fun_id, fun_name, parent_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (190602, '菜单新增', 1906, 3, 4, 0, -1, to_timestamp('09-06-2017 11:28:26.457', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('09-06-2017 11:28:26.457', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_FUN (fun_id, fun_name, parent_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (1908, '参数配置', 19, 7, 3, 0, -1, to_timestamp('13-06-2017 11:06:48.735', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('13-06-2017 11:06:48.735', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_FUN (fun_id, fun_name, parent_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (200102, '设备管理新增', 2001, 3, 4, 0, -1, to_timestamp('15-06-2017 17:10:00.464', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('15-06-2017 17:10:00.464', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_FUN (fun_id, fun_name, parent_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (1909, '本地客户', 19, 7, 3, 0, -1, to_timestamp('19-06-2017 16:30:38.984', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('19-06-2017 16:30:38.984', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_FUN (fun_id, fun_name, parent_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (190903, '本地客户编辑', 1909, 4, 4, 0, -1, to_timestamp('19-06-2017 16:31:38.749', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('19-06-2017 16:31:38.749', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_FUN (fun_id, fun_name, parent_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (191103, '柜员编辑', 1911, 4, 4, 0, -1, to_timestamp('20-06-2017 09:26:07.248', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('20-06-2017 09:26:07.248', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_FUN (fun_id, fun_name, parent_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (240401, '评价监控查询', 2404, 2, 4, 0, -1, to_timestamp('11-08-2017 09:33:17.408', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('11-08-2017 09:33:17.408', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_FUN (fun_id, fun_name, parent_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (2301, '机构分析报表', 23, 2, 3, 0, -1, to_timestamp('26-06-2017 15:08:55.223', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('26-06-2017 15:08:55.223', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_FUN (fun_id, fun_name, parent_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (2305, '客户分析报表', 23, 3, 3, 0, -1, to_timestamp('10-07-2017 16:34:17.785', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('10-07-2017 16:34:17.785', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_FUN (fun_id, fun_name, parent_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (240101, '业务队列查询', 2401, 2, 4, 0, -1, to_timestamp('28-06-2017 13:56:43.366', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('28-06-2017 13:56:43.366', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_FUN (fun_id, fun_name, parent_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (2302, '柜员效率报表', 23, 3, 3, 0, -1, to_timestamp('05-07-2017 11:32:50.025', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('05-07-2017 11:32:50.025', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_FUN (fun_id, fun_name, parent_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (2306, '业务流水报表', 23, 3, 3, 0, -1, to_timestamp('12-07-2017 19:10:09.572', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('12-07-2017 19:10:09.572', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_FUN (fun_id, fun_name, parent_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (230601, '业务流水报表查询', 2306, 2, 4, 0, -1, to_timestamp('12-07-2017 19:10:25.619', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('12-07-2017 19:10:25.619', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_FUN (fun_id, fun_name, parent_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (2307, '业务量报表', 23, 3, 3, 0, -1, to_timestamp('14-07-2017 12:09:34.693', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('14-07-2017 12:09:34.693', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_FUN (fun_id, fun_name, parent_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (201101, '叫号策略查询', 2011, 2, 4, 0, -1, to_timestamp('31-07-2017 17:58:38.692', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('31-07-2017 17:58:38.692', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_FUN (fun_id, fun_name, parent_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (201201, '业务显示查询', 2012, 2, 4, 0, -1, to_timestamp('01-08-2017 20:05:37.995', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('01-08-2017 20:05:37.995', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_FUN (fun_id, fun_name, parent_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (2013, '客户识别', 20, 6, 3, 0, -1, to_timestamp('08-08-2017 17:51:55.780', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('08-08-2017 17:51:55.780', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_FUN (fun_id, fun_name, parent_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (2403, '窗口监控', 24, 3, 3, 1, -1, to_timestamp('10-08-2017 15:30:09.656', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('10-08-2017 15:30:09.656', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_FUN (fun_id, fun_name, parent_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (2401, '业务队列数据监控', 24, 2, 3, 0, -1, to_timestamp('28-06-2017 13:53:54.723', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('28-06-2017 13:53:54.723', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_FUN (fun_id, fun_name, parent_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (200603, '窗口配置编辑', 2006, 4, 4, 0, -1, to_timestamp('11-07-2017 17:23:14.577', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('11-07-2017 17:23:14.577', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_FUN (fun_id, fun_name, parent_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (2303, '客户来行时间报表', 23, 4, 3, 0, -1, to_timestamp('05-07-2017 11:30:59.574', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('05-07-2017 11:30:59.574', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_FUN (fun_id, fun_name, parent_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (2402, '设备监控', 24, 3, 3, 0, -1, to_timestamp('05-07-2017 16:49:13.717', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('05-07-2017 16:49:13.717', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_FUN (fun_id, fun_name, parent_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (2007, '客户等级', 20, 6, 3, 0, -1, to_timestamp('14-07-2017 09:55:26.501', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('14-07-2017 09:55:26.501', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_FUN (fun_id, fun_name, parent_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (230801, '业务统计报表查询', 2308, 2, 4, 0, -1, to_timestamp('14-07-2017 16:13:08.760', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('14-07-2017 16:13:08.760', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_FUN (fun_id, fun_name, parent_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (201001, '网点业务查询', 2010, 2, 4, 0, -1, to_timestamp('24-07-2017 14:28:44.540', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('24-07-2017 14:28:44.540', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_FUN (fun_id, fun_name, parent_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (201003, '网点业务编辑', 2010, 4, 4, 0, -1, to_timestamp('24-07-2017 14:29:49.701', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('24-07-2017 14:29:49.701', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_FUN (fun_id, fun_name, parent_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (2012, '业务显示', 20, 6, 3, 0, -1, to_timestamp('01-08-2017 20:04:05.237', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('01-08-2017 20:04:05.237', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_FUN (fun_id, fun_name, parent_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (201301, '客户识别查询', 2013, 2, 4, 0, -1, to_timestamp('08-08-2017 17:53:01.528', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('08-08-2017 17:53:01.528', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_FUN (fun_id, fun_name, parent_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (240301, '窗口监控查询', 2403, 2, 4, 0, -1, to_timestamp('10-08-2017 15:30:40.617', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('10-08-2017 15:30:40.617', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_FUN (fun_id, fun_name, parent_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (2014, '取号配置', 20, 6, 3, 0, -1, to_timestamp('06-09-2017 21:28:14.591', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('06-09-2017 21:28:14.591', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_FUN (fun_id, fun_name, parent_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (201401, '取号配置查询', 2014, 2, 4, 0, -1, to_timestamp('06-09-2017 21:28:28.625', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('06-09-2017 21:28:28.625', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_FUN (fun_id, fun_name, parent_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (201202, '业务显示保存', 2012, 3, 4, 0, -1, to_timestamp('12-10-2017 16:56:53.630', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('12-10-2017 16:56:53.630', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_FUN (fun_id, fun_name, parent_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (200702, '客户等级保存', 2007, 3, 4, 0, -1, to_timestamp('12-10-2017 16:59:15.034', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('12-10-2017 16:59:15.034', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_FUN (fun_id, fun_name, parent_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (240202, '设备监控详情', 2402, 3, 4, 0, -1, to_timestamp('12-10-2017 18:39:21.779', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('12-10-2017 18:39:21.779', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_FUN (fun_id, fun_name, parent_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (2017, '广告发布', 20, 6, 3, 0, -1, to_timestamp('12-10-2017 11:10:50.291', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('12-10-2017 11:10:50.291', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_FUN (fun_id, fun_name, parent_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (201701, '广告发布查询', 2017, 2, 4, 0, -1, to_timestamp('12-10-2017 11:11:16.853', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('12-10-2017 11:11:16.853', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_FUN (fun_id, fun_name, parent_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (201302, '客户识别保存', 2013, 3, 4, 0, -1, to_timestamp('12-10-2017 17:07:45.322', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('12-10-2017 17:07:45.322', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_FUN (fun_id, fun_name, parent_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (191006, '版本管理下发', 1910, 7, 4, 0, -1, to_timestamp('22-10-2017 17:05:19.704', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('22-10-2017 17:05:19.704', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_FUN (fun_id, fun_name, parent_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (200802, '号码模板删除', 2008, 3, 4, 0, 1820, to_timestamp('22-10-2017 17:16:17.545', 'dd-mm-yyyy hh24:mi:ss.ff'), 1820, to_timestamp('22-10-2017 17:16:17.545', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_FUN (fun_id, fun_name, parent_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (191005, '版本新增', 1910, 6, 4, 0, -1, to_timestamp('22-10-2017 16:58:45.339', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('22-10-2017 16:58:45.339', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_FUN (fun_id, fun_name, parent_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (200902, '号票模板新增', 2009, 3, 4, 0, -1, to_timestamp('22-10-2017 19:37:41.241', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('22-10-2017 19:37:41.241', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_FUN (fun_id, fun_name, parent_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (200903, '号票模板保存配置', 2009, 4, 4, 0, -1, to_timestamp('22-10-2017 19:48:08.661', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('22-10-2017 19:48:08.661', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_FUN (fun_id, fun_name, parent_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (201102, '叫号策略保存', 2011, 3, 4, 0, -1, to_timestamp('22-10-2017 20:38:34.645', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('22-10-2017 20:38:34.645', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_FUN (fun_id, fun_name, parent_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (2015, '导航配置', 20, 6, 3, 0, -1, to_timestamp('04-12-2017 17:13:49.286', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('04-12-2017 17:13:49.286', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_FUN (fun_id, fun_name, parent_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (201501, '导航配置查询', 2015, 2, 4, 0, -1, to_timestamp('04-12-2017 17:14:22.035', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('04-12-2017 17:14:22.035', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_FUN (fun_id, fun_name, parent_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (2018, '一键检测', 20, 6, 3, 0, -1, to_timestamp('06-12-2017 10:34:42.539', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('06-12-2017 10:34:42.539', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_FUN (fun_id, fun_name, parent_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (201801, '一键检测', 2018, 2, 4, 0, -1, to_timestamp('06-12-2017 10:35:08.468', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('06-12-2017 10:35:08.468', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_FUN (fun_id, fun_name, parent_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (2405, '窗口监控', 24, 3, 3, 0, -1, to_timestamp('26-12-2017 14:46:22.384', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('26-12-2017 14:46:22.384', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_FUN (fun_id, fun_name, parent_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (1913, '预约配置', 19, 7, 3, 0, -1, to_timestamp('11-01-2018 09:14:17.517', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('11-01-2018 09:14:17.517', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_FUN (fun_id, fun_name, parent_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (191302, '预约新增', 1913, 3, 4, 0, -1, to_timestamp('11-01-2018 09:46:07.105', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('11-01-2018 09:46:07.105', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_FUN (fun_id, fun_name, parent_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (191304, '预约删除', 1913, 5, 4, 0, -1, to_timestamp('11-01-2018 09:47:02.162', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('11-01-2018 09:47:02.162', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_FUN (fun_id, fun_name, parent_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (240501, '窗口监控查询', 2405, 2, 4, 0, -1, to_timestamp('26-12-2017 14:46:46.678', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('26-12-2017 14:46:46.678', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_FUN (fun_id, fun_name, parent_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (191301, '预约查询', 1913, 2, 4, 0, -1, to_timestamp('11-01-2018 09:15:10.774', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('11-01-2018 09:15:10.774', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_FUN (fun_id, fun_name, parent_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (191303, '预约编辑', 1913, 4, 4, 0, -1, to_timestamp('11-01-2018 09:46:38.511', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('11-01-2018 09:46:38.511', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_FUN (fun_id, fun_name, parent_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (1914, '资源上传', 19, 7, 3, 0, -1, to_timestamp('30-07-2018 20:22:28.623', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('30-07-2018 20:22:28.623', 'dd-mm-yyyy hh24:mi:ss.ff'));
commit;
prompt 181 records loaded
prompt Loading SYS_FUN_URL...
insert into SYS_FUN_URL (fun_id, url_id)
values (1914, 698);
insert into SYS_FUN_URL (fun_id, url_id)
values (230101, 642);
insert into SYS_FUN_URL (fun_id, url_id)
values (200901, 661);
insert into SYS_FUN_URL (fun_id, url_id)
values (201002, 663);
insert into SYS_FUN_URL (fun_id, url_id)
values (201003, 664);
insert into SYS_FUN_URL (fun_id, url_id)
values (200801, 660);
insert into SYS_FUN_URL (fun_id, url_id)
values (200801, 666);
insert into SYS_FUN_URL (fun_id, url_id)
values (201201, 667);
insert into SYS_FUN_URL (fun_id, url_id)
values (240201, 646);
insert into SYS_FUN_URL (fun_id, url_id)
values (230501, 648);
insert into SYS_FUN_URL (fun_id, url_id)
values (200601, 649);
insert into SYS_FUN_URL (fun_id, url_id)
values (200603, 651);
insert into SYS_FUN_URL (fun_id, url_id)
values (200703, 656);
insert into SYS_FUN_URL (fun_id, url_id)
values (201101, 666);
insert into SYS_FUN_URL (fun_id, url_id)
values (240301, 670);
insert into SYS_FUN_URL (fun_id, url_id)
values (190601, 612);
insert into SYS_FUN_URL (fun_id, url_id)
values (190604, 615);
insert into SYS_FUN_URL (fun_id, url_id)
values (190703, 618);
insert into SYS_FUN_URL (fun_id, url_id)
values (190903, 632);
insert into SYS_FUN_URL (fun_id, url_id)
values (191102, 635);
insert into SYS_FUN_URL (fun_id, url_id)
values (191104, 637);
insert into SYS_FUN_URL (fun_id, url_id)
values (190701, 616);
insert into SYS_FUN_URL (fun_id, url_id)
values (190702, 617);
insert into SYS_FUN_URL (fun_id, url_id)
values (190704, 619);
insert into SYS_FUN_URL (fun_id, url_id)
values (30101, 1);
insert into SYS_FUN_URL (fun_id, url_id)
values (30102, 2);
insert into SYS_FUN_URL (fun_id, url_id)
values (30102, 3);
insert into SYS_FUN_URL (fun_id, url_id)
values (30103, 4);
insert into SYS_FUN_URL (fun_id, url_id)
values (30103, 5);
insert into SYS_FUN_URL (fun_id, url_id)
values (30104, 6);
insert into SYS_FUN_URL (fun_id, url_id)
values (30106, 7);
insert into SYS_FUN_URL (fun_id, url_id)
values (30105, 8);
insert into SYS_FUN_URL (fun_id, url_id)
values (30107, 9);
insert into SYS_FUN_URL (fun_id, url_id)
values (30108, 10);
insert into SYS_FUN_URL (fun_id, url_id)
values (30206, 31);
insert into SYS_FUN_URL (fun_id, url_id)
values (30201, 32);
insert into SYS_FUN_URL (fun_id, url_id)
values (30201, 33);
insert into SYS_FUN_URL (fun_id, url_id)
values (30202, 34);
insert into SYS_FUN_URL (fun_id, url_id)
values (30202, 35);
insert into SYS_FUN_URL (fun_id, url_id)
values (30203, 36);
insert into SYS_FUN_URL (fun_id, url_id)
values (30204, 37);
insert into SYS_FUN_URL (fun_id, url_id)
values (30205, 38);
insert into SYS_FUN_URL (fun_id, url_id)
values (30205, 39);
insert into SYS_FUN_URL (fun_id, url_id)
values (30205, 40);
insert into SYS_FUN_URL (fun_id, url_id)
values (30205, 41);
insert into SYS_FUN_URL (fun_id, url_id)
values (30305, 61);
insert into SYS_FUN_URL (fun_id, url_id)
values (30301, 62);
insert into SYS_FUN_URL (fun_id, url_id)
values (30301, 63);
insert into SYS_FUN_URL (fun_id, url_id)
values (30302, 64);
insert into SYS_FUN_URL (fun_id, url_id)
values (30302, 65);
insert into SYS_FUN_URL (fun_id, url_id)
values (30302, 66);
insert into SYS_FUN_URL (fun_id, url_id)
values (30303, 67);
insert into SYS_FUN_URL (fun_id, url_id)
values (30304, 68);
insert into SYS_FUN_URL (fun_id, url_id)
values (30401, 91);
insert into SYS_FUN_URL (fun_id, url_id)
values (30402, 92);
insert into SYS_FUN_URL (fun_id, url_id)
values (30402, 93);
insert into SYS_FUN_URL (fun_id, url_id)
values (30403, 94);
insert into SYS_FUN_URL (fun_id, url_id)
values (30403, 95);
insert into SYS_FUN_URL (fun_id, url_id)
values (30404, 96);
insert into SYS_FUN_URL (fun_id, url_id)
values (30405, 97);
insert into SYS_FUN_URL (fun_id, url_id)
values (30405, 98);
insert into SYS_FUN_URL (fun_id, url_id)
values (30405, 99);
insert into SYS_FUN_URL (fun_id, url_id)
values (30406, 100);
insert into SYS_FUN_URL (fun_id, url_id)
values (30406, 101);
insert into SYS_FUN_URL (fun_id, url_id)
values (30406, 102);
insert into SYS_FUN_URL (fun_id, url_id)
values (30406, 103);
insert into SYS_FUN_URL (fun_id, url_id)
values (30501, 121);
insert into SYS_FUN_URL (fun_id, url_id)
values (30502, 122);
insert into SYS_FUN_URL (fun_id, url_id)
values (30502, 123);
insert into SYS_FUN_URL (fun_id, url_id)
values (30101, 141);
insert into SYS_FUN_URL (fun_id, url_id)
values (30102, 141);
insert into SYS_FUN_URL (fun_id, url_id)
values (30103, 141);
insert into SYS_FUN_URL (fun_id, url_id)
values (30401, 141);
insert into SYS_FUN_URL (fun_id, url_id)
values (30402, 141);
insert into SYS_FUN_URL (fun_id, url_id)
values (30403, 141);
insert into SYS_FUN_URL (fun_id, url_id)
values (30406, 141);
insert into SYS_FUN_URL (fun_id, url_id)
values (30601, 141);
insert into SYS_FUN_URL (fun_id, url_id)
values (50201, 141);
insert into SYS_FUN_URL (fun_id, url_id)
values (50301, 141);
insert into SYS_FUN_URL (fun_id, url_id)
values (30602, 142);
insert into SYS_FUN_URL (fun_id, url_id)
values (30602, 143);
insert into SYS_FUN_URL (fun_id, url_id)
values (30603, 144);
insert into SYS_FUN_URL (fun_id, url_id)
values (30603, 145);
insert into SYS_FUN_URL (fun_id, url_id)
values (30603, 146);
insert into SYS_FUN_URL (fun_id, url_id)
values (30604, 147);
insert into SYS_FUN_URL (fun_id, url_id)
values (30605, 148);
insert into SYS_FUN_URL (fun_id, url_id)
values (30606, 149);
insert into SYS_FUN_URL (fun_id, url_id)
values (30607, 150);
insert into SYS_FUN_URL (fun_id, url_id)
values (30607, 151);
insert into SYS_FUN_URL (fun_id, url_id)
values (30701, 171);
insert into SYS_FUN_URL (fun_id, url_id)
values (30702, 172);
insert into SYS_FUN_URL (fun_id, url_id)
values (30702, 173);
insert into SYS_FUN_URL (fun_id, url_id)
values (30703, 174);
insert into SYS_FUN_URL (fun_id, url_id)
values (30703, 175);
insert into SYS_FUN_URL (fun_id, url_id)
values (30704, 176);
insert into SYS_FUN_URL (fun_id, url_id)
values (30705, 177);
insert into SYS_FUN_URL (fun_id, url_id)
values (40105, 201);
insert into SYS_FUN_URL (fun_id, url_id)
values (40101, 202);
insert into SYS_FUN_URL (fun_id, url_id)
values (40101, 203);
insert into SYS_FUN_URL (fun_id, url_id)
values (40102, 204);
commit;
prompt 100 records committed...
insert into SYS_FUN_URL (fun_id, url_id)
values (40102, 205);
insert into SYS_FUN_URL (fun_id, url_id)
values (40103, 206);
insert into SYS_FUN_URL (fun_id, url_id)
values (40104, 207);
insert into SYS_FUN_URL (fun_id, url_id)
values (40102, 208);
insert into SYS_FUN_URL (fun_id, url_id)
values (40104, 208);
insert into SYS_FUN_URL (fun_id, url_id)
values (50101, 221);
insert into SYS_FUN_URL (fun_id, url_id)
values (50201, 231);
insert into SYS_FUN_URL (fun_id, url_id)
values (50301, 241);
insert into SYS_FUN_URL (fun_id, url_id)
values (20901, 141);
insert into SYS_FUN_URL (fun_id, url_id)
values (20901, 603);
insert into SYS_FUN_URL (fun_id, url_id)
values (20903, 607);
insert into SYS_FUN_URL (fun_id, url_id)
values (20903, 606);
insert into SYS_FUN_URL (fun_id, url_id)
values (20903, 141);
insert into SYS_FUN_URL (fun_id, url_id)
values (50301, 242);
insert into SYS_FUN_URL (fun_id, url_id)
values (30502, 102);
insert into SYS_FUN_URL (fun_id, url_id)
values (30502, 103);
insert into SYS_FUN_URL (fun_id, url_id)
values (200101, 622);
insert into SYS_FUN_URL (fun_id, url_id)
values (200104, 625);
insert into SYS_FUN_URL (fun_id, url_id)
values (20902, 604);
insert into SYS_FUN_URL (fun_id, url_id)
values (20902, 141);
insert into SYS_FUN_URL (fun_id, url_id)
values (20902, 605);
insert into SYS_FUN_URL (fun_id, url_id)
values (1907, 616);
insert into SYS_FUN_URL (fun_id, url_id)
values (191201, 638);
insert into SYS_FUN_URL (fun_id, url_id)
values (190101, 608);
insert into SYS_FUN_URL (fun_id, url_id)
values (190102, 609);
insert into SYS_FUN_URL (fun_id, url_id)
values (190104, 611);
insert into SYS_FUN_URL (fun_id, url_id)
values (190602, 613);
insert into SYS_FUN_URL (fun_id, url_id)
values (190802, 621);
insert into SYS_FUN_URL (fun_id, url_id)
values (191001, 626);
insert into SYS_FUN_URL (fun_id, url_id)
values (191202, 639);
insert into SYS_FUN_URL (fun_id, url_id)
values (190103, 610);
insert into SYS_FUN_URL (fun_id, url_id)
values (200103, 624);
insert into SYS_FUN_URL (fun_id, url_id)
values (190901, 630);
insert into SYS_FUN_URL (fun_id, url_id)
values (190904, 633);
insert into SYS_FUN_URL (fun_id, url_id)
values (191002, 628);
insert into SYS_FUN_URL (fun_id, url_id)
values (191003, 629);
insert into SYS_FUN_URL (fun_id, url_id)
values (191101, 634);
insert into SYS_FUN_URL (fun_id, url_id)
values (191103, 636);
insert into SYS_FUN_URL (fun_id, url_id)
values (191203, 640);
insert into SYS_FUN_URL (fun_id, url_id)
values (190603, 614);
insert into SYS_FUN_URL (fun_id, url_id)
values (190801, 620);
insert into SYS_FUN_URL (fun_id, url_id)
values (190902, 631);
insert into SYS_FUN_URL (fun_id, url_id)
values (230601, 653);
insert into SYS_FUN_URL (fun_id, url_id)
values (230701, 658);
insert into SYS_FUN_URL (fun_id, url_id)
values (240101, 643);
insert into SYS_FUN_URL (fun_id, url_id)
values (230102, 644);
insert into SYS_FUN_URL (fun_id, url_id)
values (230301, 644);
insert into SYS_FUN_URL (fun_id, url_id)
values (230201, 645);
insert into SYS_FUN_URL (fun_id, url_id)
values (230401, 647);
insert into SYS_FUN_URL (fun_id, url_id)
values (200602, 650);
insert into SYS_FUN_URL (fun_id, url_id)
values (200604, 652);
insert into SYS_FUN_URL (fun_id, url_id)
values (200701, 654);
insert into SYS_FUN_URL (fun_id, url_id)
values (200704, 657);
insert into SYS_FUN_URL (fun_id, url_id)
values (230801, 659);
insert into SYS_FUN_URL (fun_id, url_id)
values (201001, 662);
insert into SYS_FUN_URL (fun_id, url_id)
values (201004, 665);
insert into SYS_FUN_URL (fun_id, url_id)
values (201401, 675);
insert into SYS_FUN_URL (fun_id, url_id)
values (200702, 657);
insert into SYS_FUN_URL (fun_id, url_id)
values (240202, 646);
insert into SYS_FUN_URL (fun_id, url_id)
values (201301, 681);
insert into SYS_FUN_URL (fun_id, url_id)
values (201701, 678);
insert into SYS_FUN_URL (fun_id, url_id)
values (201202, 680);
insert into SYS_FUN_URL (fun_id, url_id)
values (201302, 682);
insert into SYS_FUN_URL (fun_id, url_id)
values (191006, 684);
insert into SYS_FUN_URL (fun_id, url_id)
values (200802, 685);
insert into SYS_FUN_URL (fun_id, url_id)
values (191005, 627);
insert into SYS_FUN_URL (fun_id, url_id)
values (200102, 623);
insert into SYS_FUN_URL (fun_id, url_id)
values (200902, 686);
insert into SYS_FUN_URL (fun_id, url_id)
values (200903, 687);
insert into SYS_FUN_URL (fun_id, url_id)
values (201102, 688);
insert into SYS_FUN_URL (fun_id, url_id)
values (201501, 690);
insert into SYS_FUN_URL (fun_id, url_id)
values (191301, 694);
insert into SYS_FUN_URL (fun_id, url_id)
values (191303, 696);
insert into SYS_FUN_URL (fun_id, url_id)
values (240501, 668);
insert into SYS_FUN_URL (fun_id, url_id)
values (201801, 692);
insert into SYS_FUN_URL (fun_id, url_id)
values (191304, 697);
insert into SYS_FUN_URL (fun_id, url_id)
values (191302, 695);
commit;
prompt 177 records loaded
prompt Loading SYS_MENU...
insert into SYS_MENU (menu_id, menu_name, menu_url, icon, parent_id, fun_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (677, '资源上传', '/basicconfig/upload', 'icon-file', 624, 0, 11, 3, 0, -1, to_timestamp('30-07-2018 20:19:02.159', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('30-07-2018 20:19:02.159', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_MENU (menu_id, menu_name, menu_url, icon, parent_id, fun_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (640, '队列监控', '/monitor/trxtoday', 'icon-wrench', 639, 2401, 2, 3, 0, -1, to_timestamp('28-06-2017 13:58:32.490', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('22-10-2017 15:51:25.246', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_MENU (menu_id, menu_name, menu_url, icon, parent_id, fun_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (643, '柜员效率报表', '/report/empefficiency', 'icon-key', 636, 2302, 4, 3, 0, -1, to_timestamp('05-07-2017 11:34:27.147', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('22-10-2017 15:49:45.144', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_MENU (menu_id, menu_name, menu_url, icon, parent_id, fun_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (647, '窗口配置', '/businessconfig/bscwinconfig', 'icon-desktop', 630, 2006, 4, 3, 0, -1, to_timestamp('11-07-2017 17:31:51.661', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('22-10-2017 15:47:01.158', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_MENU (menu_id, menu_name, menu_url, icon, parent_id, fun_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (649, '客户等级', '/businessconfig/bsccustlevel', 'icon-github', 630, 2007, 7, 3, 0, -1, to_timestamp('14-07-2017 09:58:46.002', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('22-10-2017 15:47:59.601', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_MENU (menu_id, menu_name, menu_url, icon, parent_id, fun_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (653, '号码模板', '/businessconfig/numberform', 'icon-wrench', 624, 2008, 9, 3, 0, -1, to_timestamp('18-07-2017 15:51:13.629', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('22-10-2017 15:46:07.332', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_MENU (menu_id, menu_name, menu_url, icon, parent_id, fun_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (654, '号票模板', '/businessconfig/ticketform', 'icon-cogs', 630, 2009, 3, 3, 0, -1, to_timestamp('18-07-2017 16:00:17.029', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('04-12-2017 18:28:25.853', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_MENU (menu_id, menu_name, menu_url, icon, parent_id, fun_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (657, '业务显示', '/businessconfig/bscshowtime', 'icon-time', 630, 2012, 6, 3, 0, -1, to_timestamp('01-08-2017 20:08:46.245', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('22-10-2017 15:47:30.019', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_MENU (menu_id, menu_name, menu_url, icon, parent_id, fun_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (644, '设备监控', '/monitor/bscdevicestatus', 'icon-tablet', 639, 2402, 3, 3, 0, -1, to_timestamp('05-07-2017 16:52:20.018', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('22-10-2017 15:51:36.182', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_MENU (menu_id, menu_name, menu_url, icon, parent_id, fun_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (645, '柜员评价报表', '/report/empappraise', 'icon-user', 636, 2304, 5, 3, 0, -1, to_timestamp('06-07-2017 11:13:50.377', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('22-10-2017 15:49:55.562', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_MENU (menu_id, menu_name, menu_url, icon, parent_id, fun_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (650, '业务量报表', '/report/businesscount', 'icon-github', 636, 2307, 8, 3, 0, -1, to_timestamp('14-07-2017 13:45:43.227', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('22-10-2017 15:50:28.199', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_MENU (menu_id, menu_name, menu_url, icon, parent_id, fun_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (656, '叫号策略', '/businessconfig/callstrategy', 'icon-list', 630, 2011, 8, 3, 0, -1, to_timestamp('31-07-2017 17:59:45.756', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('22-10-2017 15:48:17.594', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_MENU (menu_id, menu_name, menu_url, icon, parent_id, fun_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (624, '基础数据', null, 'icon-th', 1, 0, 2, 2, 0, -1, to_timestamp('08-06-2017 14:13:43.586', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('15-06-2017 17:21:34.879', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_MENU (menu_id, menu_name, menu_url, icon, parent_id, fun_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (630, '网点配置', null, 'icon-cog', 1, 0, 3, 2, 0, -1, to_timestamp('15-06-2017 17:11:56.123', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('13-09-2017 13:59:20.757', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_MENU (menu_id, menu_name, menu_url, icon, parent_id, fun_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (626, '菜单管理', '/basicconfig/menu', 'icon-tasks', 624, 1906, 2, 3, 0, -1, to_timestamp('09-06-2017 11:31:09.602', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('22-10-2017 15:41:37.741', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_MENU (menu_id, menu_name, menu_url, icon, parent_id, fun_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (627, '业务管理', '/basicconfig/businessmanage', 'icon-tint', 624, 1907, 3, 3, 0, -1, to_timestamp('12-06-2017 16:28:36.969', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('11-10-2017 10:45:13.642', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_MENU (menu_id, menu_name, menu_url, icon, parent_id, fun_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (628, '参数配置', '/basicconfig/parameter', 'icon-wrench', 624, 1908, 1, 3, 0, -1, to_timestamp('13-06-2017 11:02:03.845', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('22-10-2017 15:40:54.695', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_MENU (menu_id, menu_name, menu_url, icon, parent_id, fun_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (1, '菜单', null, null, 0, -1, 1, 1, 0, null, null, null, null);
insert into SYS_MENU (menu_id, menu_name, menu_url, icon, parent_id, fun_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (2, '系统', null, 'icon-laptop', 1, 0, 1, 2, 0, null, null, -1, to_timestamp('15-06-2017 17:59:36.876', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_MENU (menu_id, menu_name, menu_url, icon, parent_id, fun_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (3, '权限管理', null, 'icon-key', 2, 1, 2, 3, 0, null, null, -1, to_timestamp('02-03-2016 15:29:03.697', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_MENU (menu_id, menu_name, menu_url, icon, parent_id, fun_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (301, '用户管理', '/system/users/list', 'icon-user', 3, 30101, 1, 4, 0, null, null, -1, to_timestamp('14-03-2016 16:07:44.940', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_MENU (menu_id, menu_name, menu_url, icon, parent_id, fun_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (302, '功能管理', '/system/funs/list', 'icon-cog', 3, 30206, 2, 4, 0, null, null, -1, to_timestamp('14-03-2016 16:07:44.940', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_MENU (menu_id, menu_name, menu_url, icon, parent_id, fun_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (303, '菜单管理', '/system/menus/list', 'icon-list', 3, 30305, 3, 4, 0, null, null, -1, to_timestamp('14-03-2016 16:07:44.940', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_MENU (menu_id, menu_name, menu_url, icon, parent_id, fun_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (304, '角色管理', '/system/roles/list', 'icon-tag', 3, 30401, 4, 4, 0, null, null, -1, to_timestamp('14-03-2016 16:07:44.940', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_MENU (menu_id, menu_name, menu_url, icon, parent_id, fun_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (305, '通用角色管理', '/system/commroles/list', 'icon-tags', 3, 30501, 4, 4, 1, null, null, -1, to_timestamp('11-05-2017 11:26:44.940', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_MENU (menu_id, menu_name, menu_url, icon, parent_id, fun_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (306, '机构管理', '/system/orgs/list', 'icon-sitemap', 3, 30601, 5, 4, 0, null, null, -1, to_timestamp('14-03-2016 16:07:44.940', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_MENU (menu_id, menu_name, menu_url, icon, parent_id, fun_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (307, 'URL管理', '/system/urls/list', 'icon-paper-clip', 3, 30701, 6, 4, 0, null, null, -1, to_timestamp('19-06-2017 11:10:12.384', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_MENU (menu_id, menu_name, menu_url, icon, parent_id, fun_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (4, '基础配置', null, 'icon-cogs', 2, 0, 3, 3, 0, null, null, -1, to_timestamp('02-03-2016 15:29:03.697', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_MENU (menu_id, menu_name, menu_url, icon, parent_id, fun_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (401, '字典管理', '/system/dics/list', 'icon-book', 4, 40105, 1, 4, 0, null, null, -1, to_timestamp('02-03-2016 15:29:03.697', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_MENU (menu_id, menu_name, menu_url, icon, parent_id, fun_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (5, '日志管理', null, 'icon-file-alt', 2, 0, 4, 3, 0, null, null, -1, to_timestamp('02-03-2016 15:29:03.697', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_MENU (menu_id, menu_name, menu_url, icon, parent_id, fun_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (501, '在线用户', '/system/users/online', 'icon-user-md', 5, 50101, 1, 4, 0, null, null, -1, to_timestamp('02-03-2016 15:29:03.697', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_MENU (menu_id, menu_name, menu_url, icon, parent_id, fun_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (502, '登录日志', '/system/logs/login', 'icon-desktop', 5, 50201, 2, 4, 0, null, null, -1, to_timestamp('02-03-2016 15:29:03.697', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_MENU (menu_id, menu_name, menu_url, icon, parent_id, fun_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (503, '用户行为', '/system/logs/behavior', 'icon-hand-right', 5, 50301, 3, 4, 0, null, null, -1, to_timestamp('02-03-2016 15:29:03.697', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_MENU (menu_id, menu_name, menu_url, icon, parent_id, fun_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (631, '设备管理', '/businessconfig/bscdevice', 'icon-tablet', 630, 2001, 2, 3, 0, -1, to_timestamp('15-06-2017 17:12:56.502', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('04-12-2017 18:28:19.061', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_MENU (menu_id, menu_name, menu_url, icon, parent_id, fun_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (634, '柜员管理', '/basicconfig/teller', 'icon-tasks', 624, 1911, 7, 3, 0, -1, to_timestamp('20-06-2017 09:23:37.108', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('22-10-2017 15:43:55.547', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_MENU (menu_id, menu_name, menu_url, icon, parent_id, fun_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (625, '客户类型', '/basicconfig/custtype', 'icon-github', 624, 1901, 4, 3, 0, -1, to_timestamp('08-06-2017 14:29:06.947', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('22-10-2017 15:42:00.448', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_MENU (menu_id, menu_name, menu_url, icon, parent_id, fun_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (635, '临近网点', '/basicconfig/near', 'icon-tasks', 624, 1912, 8, 3, 0, -1, to_timestamp('21-06-2017 17:49:25.788', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('22-10-2017 15:45:43.838', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_MENU (menu_id, menu_name, menu_url, icon, parent_id, fun_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (632, '本地客户', '/basicconfig/cusinfo', 'icon-list', 624, 1909, 5, 3, 0, -1, to_timestamp('19-06-2017 16:34:02.890', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('22-10-2017 15:42:13.059', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_MENU (menu_id, menu_name, menu_url, icon, parent_id, fun_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (633, '版本管理', '/basicconfig/patchversion', 'icon-cloud', 624, 1910, 6, 3, 0, -1, to_timestamp('19-06-2017 19:41:15.619', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('22-10-2017 15:43:29.584', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_MENU (menu_id, menu_name, menu_url, icon, parent_id, fun_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (636, '数据报表', null, 'icon-list', 1, 0, 4, 2, 0, -1, to_timestamp('23-06-2017 14:17:15.256', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('13-09-2017 13:59:34.576', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_MENU (menu_id, menu_name, menu_url, icon, parent_id, fun_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (646, '客户分析报表', '/report/cusanalyse', 'icon-wrench', 636, 2305, 6, 3, 0, -1, to_timestamp('10-07-2017 16:35:30.319', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('22-10-2017 15:50:05.674', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_MENU (menu_id, menu_name, menu_url, icon, parent_id, fun_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (638, '机构分析报表', '/report/organalyse', 'icon-cog', 636, 2301, 2, 3, 0, -1, to_timestamp('26-06-2017 15:08:11.773', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('22-10-2017 15:49:12.301', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_MENU (menu_id, menu_name, menu_url, icon, parent_id, fun_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (642, '客户来行时间报表', '/report/cometime', 'icon-cogs', 636, 2303, 3, 3, 0, -1, to_timestamp('03-07-2017 19:45:54.870', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('22-10-2017 15:49:31.621', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_MENU (menu_id, menu_name, menu_url, icon, parent_id, fun_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (651, '业务统计报表', '/report/businessstatistics', 'icon-tasks', 636, 2308, 9, 3, 0, -1, to_timestamp('14-07-2017 16:14:13.195', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('22-10-2017 15:51:13.360', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_MENU (menu_id, menu_name, menu_url, icon, parent_id, fun_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (639, '数据监控', null, 'icon-th', 1, 0, 5, 2, 0, -1, to_timestamp('28-06-2017 13:57:19.670', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('13-09-2017 13:59:43.313', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_MENU (menu_id, menu_name, menu_url, icon, parent_id, fun_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (648, '业务流水报表', '/report/businessflow', 'icon-tint', 636, 2306, 7, 3, 0, -1, to_timestamp('12-07-2017 19:11:18.849', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('22-10-2017 15:50:38.879', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_MENU (menu_id, menu_name, menu_url, icon, parent_id, fun_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (658, '客户识别', '/businessconfig/bsccustrecogni', 'icon-eye-open', 630, 2013, 10, 3, 0, -1, to_timestamp('08-08-2017 17:55:08.086', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('22-10-2017 15:48:44.552', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_MENU (menu_id, menu_name, menu_url, icon, parent_id, fun_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (662, '评价监控', '/monitor/appraise', 'icon-user', 639, 2404, 5, 3, 0, -1, to_timestamp('11-08-2017 09:35:29.194', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('22-10-2017 15:51:58.280', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_MENU (menu_id, menu_name, menu_url, icon, parent_id, fun_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (655, '网点业务', '/businessconfig/bscbranchbus', 'icon-sitemap', 630, 2010, 5, 3, 0, -1, to_timestamp('24-07-2017 14:26:46.790', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('22-10-2017 15:47:14.550', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_MENU (menu_id, menu_name, menu_url, icon, parent_id, fun_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (660, '窗口监控', '/monitor/winmonitor', 'icon-desktop', 639, 2403, 4, 3, 1, -1, to_timestamp('10-08-2017 15:34:05.568', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('22-10-2017 15:51:47.734', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_MENU (menu_id, menu_name, menu_url, icon, parent_id, fun_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (667, '取号配置', '/businessconfig/takeconfig', 'icon-list', 630, 2014, 9, 3, 0, -1, to_timestamp('06-09-2017 21:30:04.249', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('22-10-2017 15:48:31.754', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_MENU (menu_id, menu_name, menu_url, icon, parent_id, fun_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (668, '广告发布', '/businessconfig/adpublish', 'icon-list', 630, 2017, 11, 3, 0, -1, to_timestamp('12-10-2017 11:12:52.624', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('22-10-2017 15:49:00.829', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_MENU (menu_id, menu_name, menu_url, icon, parent_id, fun_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (670, '导航配置', '/businessconfig/navconfig', 'icon-wrench', 630, 2015, 1, 3, 0, -1, to_timestamp('04-12-2017 17:11:19.604', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('05-12-2017 11:02:03.520', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_MENU (menu_id, menu_name, menu_url, icon, parent_id, fun_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (674, '窗口监控', '/monitor/winmonitor', 'icon-desktop', 639, 2405, 6, 3, 0, -1, to_timestamp('26-12-2017 14:57:03.790', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('26-12-2017 14:57:31.650', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_MENU (menu_id, menu_name, menu_url, icon, parent_id, fun_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (676, '预约配置', '/basicconfig/orderconfig', 'icon-wrench', 624, 191301, 10, 3, 0, -1, to_timestamp('11-01-2018 09:16:48.439', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('11-01-2018 09:19:52.724', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_MENU (menu_id, menu_name, menu_url, icon, parent_id, fun_id, sort_num, level_num, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (672, '一键检测', '/businessconfig/onekeycheck', 'icon-check', 630, 201801, 12, 3, 0, -1, to_timestamp('06-12-2017 10:40:27.663', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('06-12-2017 10:40:27.663', 'dd-mm-yyyy hh24:mi:ss.ff'));
commit;
prompt 56 records loaded
prompt Loading SYS_ORG...
insert into SYS_ORG (org_id, org_code, org_name, parent_id, inherited_id, inherited_name, sort_num, level_num, tel, address, remark, deleted, created_by, created_date, last_updated_by, last_updated_date)
values (1, '1', '总部', 0, '1', '总部', 1, 1, null, null, null, 0, -1, to_timestamp('26-09-2013 00:00:00.000', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('25-10-2017 16:43:33.959', 'dd-mm-yyyy hh24:mi:ss.ff'));

commit;
prompt 2 records loaded
prompt Loading SYS_ROLE...
prompt Table is empty
prompt Loading SYS_ROLE_FUN...
prompt Table is empty
prompt Loading SYS_ROLE_USER...
prompt Table is empty
prompt Loading SYS_URL...
insert into SYS_URL (url_id, url_name, url_pattern, http_method, action_code, args_code, logged_data_changed, created_by, created_date, last_updated_by, last_updated_date)
values (695, '预约配置新增', '^/basicconfig/orderconfig.*', 'POST', null, null, 1, -1, to_timestamp('11-01-2018 09:42:41.302', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('11-01-2018 09:42:41.302', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_URL (url_id, url_name, url_pattern, http_method, action_code, args_code, logged_data_changed, created_by, created_date, last_updated_by, last_updated_date)
values (696, '预约配置编辑', '^/basicconfig/orderconfig.*', 'PUT', null, null, 1, -1, to_timestamp('11-01-2018 09:43:09.757', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('11-01-2018 09:43:09.757', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_URL (url_id, url_name, url_pattern, http_method, action_code, args_code, logged_data_changed, created_by, created_date, last_updated_by, last_updated_date)
values (697, '预约配置删除', '^/basicconfig/orderconfig.*', 'DELETE', null, null, 1, -1, to_timestamp('11-01-2018 09:43:39.603', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('11-01-2018 09:43:39.603', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_URL (url_id, url_name, url_pattern, http_method, action_code, args_code, logged_data_changed, created_by, created_date, last_updated_by, last_updated_date)
values (698, '资源上传', '^/basicconfig/upload.*', 'GET', null, null, 0, -1, to_timestamp('30-07-2018 20:20:45.938', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('30-07-2018 20:20:45.938', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_URL (url_id, url_name, url_pattern, http_method, action_code, args_code, logged_data_changed, created_by, created_date, last_updated_by, last_updated_date)
values (642, '机构分析报表查询', '^/report/organalyse.*', 'GET', null, null, 0, -1, to_timestamp('26-06-2017 15:07:13.050', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('26-06-2017 15:07:13.050', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_URL (url_id, url_name, url_pattern, http_method, action_code, args_code, logged_data_changed, created_by, created_date, last_updated_by, last_updated_date)
values (644, '客户来行时间报表查询', '^/report/cometime.*', 'GET', null, null, 0, -1, to_timestamp('03-07-2017 19:44:01.267', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('03-07-2017 19:44:01.267', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_URL (url_id, url_name, url_pattern, http_method, action_code, args_code, logged_data_changed, created_by, created_date, last_updated_by, last_updated_date)
values (647, '柜员评价报表查询', '^/report/empappraise.*', 'GET', null, null, 0, -1, to_timestamp('06-07-2017 11:11:52.837', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('06-07-2017 11:11:52.837', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_URL (url_id, url_name, url_pattern, http_method, action_code, args_code, logged_data_changed, created_by, created_date, last_updated_by, last_updated_date)
values (648, '客户分析报表查询', '^/report/cusanalyse.*', 'GET', null, null, 0, -1, to_timestamp('10-07-2017 16:33:58.172', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('10-07-2017 16:33:58.172', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_URL (url_id, url_name, url_pattern, http_method, action_code, args_code, logged_data_changed, created_by, created_date, last_updated_by, last_updated_date)
values (651, '窗口配置编辑', '^/businessconfig/bscwinconfig.*', 'PUT', null, null, 1, -1, to_timestamp('11-07-2017 17:37:27.881', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('11-07-2017 17:37:27.881', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_URL (url_id, url_name, url_pattern, http_method, action_code, args_code, logged_data_changed, created_by, created_date, last_updated_by, last_updated_date)
values (657, '客户等级保存', '^/businessconfig/bsccustlevel.*', 'DELETE', null, null, 1, -1, to_timestamp('14-07-2017 10:01:14.291', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('12-10-2017 16:55:29.035', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_URL (url_id, url_name, url_pattern, http_method, action_code, args_code, logged_data_changed, created_by, created_date, last_updated_by, last_updated_date)
values (658, '业务量报表查询', '^/report/businesscount.*', 'GET', null, null, 0, -1, to_timestamp('14-07-2017 12:09:20.883', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('14-07-2017 12:09:20.883', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_URL (url_id, url_name, url_pattern, http_method, action_code, args_code, logged_data_changed, created_by, created_date, last_updated_by, last_updated_date)
values (660, '号码模板查询', '^/businessconfig/numberform.*', 'GET', null, null, 0, -1, to_timestamp('18-07-2017 16:07:13.332', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('18-07-2017 16:07:13.332', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_URL (url_id, url_name, url_pattern, http_method, action_code, args_code, logged_data_changed, created_by, created_date, last_updated_by, last_updated_date)
values (662, '网点业务查询', '^/businessconfig/bscbranchbus.*', 'GET', null, null, 0, -1, to_timestamp('24-07-2017 14:34:10.262', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('24-07-2017 14:34:10.262', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_URL (url_id, url_name, url_pattern, http_method, action_code, args_code, logged_data_changed, created_by, created_date, last_updated_by, last_updated_date)
values (665, '网点业务删除', '^/businessconfig/branchRemove.*', 'GET', null, null, 0, -1, to_timestamp('24-07-2017 14:35:20.336', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('22-10-2017 19:59:27.592', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_URL (url_id, url_name, url_pattern, http_method, action_code, args_code, logged_data_changed, created_by, created_date, last_updated_by, last_updated_date)
values (667, '业务显示查询', '^/businessconfig/bscshowtime.*', 'GET', null, null, 0, -1, to_timestamp('01-08-2017 20:10:03.309', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('01-08-2017 20:10:03.309', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_URL (url_id, url_name, url_pattern, http_method, action_code, args_code, logged_data_changed, created_by, created_date, last_updated_by, last_updated_date)
values (646, '设备监控查询', '^/monitor/bscdevicestatus.*', 'GET', null, null, 0, -1, to_timestamp('05-07-2017 16:53:18.600', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('05-07-2017 16:53:18.600', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_URL (url_id, url_name, url_pattern, http_method, action_code, args_code, logged_data_changed, created_by, created_date, last_updated_by, last_updated_date)
values (650, '窗口配置新增', '^/businessconfig/bscwinconfig.*', 'POST', null, null, 1, -1, to_timestamp('11-07-2017 17:37:02.339', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('11-07-2017 17:37:02.339', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_URL (url_id, url_name, url_pattern, http_method, action_code, args_code, logged_data_changed, created_by, created_date, last_updated_by, last_updated_date)
values (654, '客户等级查询', '^/businessconfig/bsccustlevel.*', 'GET', null, null, 0, -1, to_timestamp('14-07-2017 10:00:13.633', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('14-07-2017 10:00:13.633', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_URL (url_id, url_name, url_pattern, http_method, action_code, args_code, logged_data_changed, created_by, created_date, last_updated_by, last_updated_date)
values (664, '网点业务编辑', '^/businessconfig/bscbranchbus.*', 'PUT', null, null, 1, -1, to_timestamp('24-07-2017 14:35:02.017', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('24-07-2017 14:35:02.017', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_URL (url_id, url_name, url_pattern, http_method, action_code, args_code, logged_data_changed, created_by, created_date, last_updated_by, last_updated_date)
values (666, '叫号策略查询', '^/businessconfig/callstrategy*', 'GET', null, null, 0, -1, to_timestamp('31-07-2017 17:57:31.399', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('22-10-2017 20:30:28.370', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_URL (url_id, url_name, url_pattern, http_method, action_code, args_code, logged_data_changed, created_by, created_date, last_updated_by, last_updated_date)
values (670, '评价监控查询', '^/monitor/appraise.*', 'GET', null, null, 0, -1, to_timestamp('11-08-2017 09:36:21.267', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('27-10-2017 22:34:44.174', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_URL (url_id, url_name, url_pattern, http_method, action_code, args_code, logged_data_changed, created_by, created_date, last_updated_by, last_updated_date)
values (610, '客户类型编辑', '^/basicconfig/custtype.*', 'PUT', null, null, 1, -1, to_timestamp('08-06-2017 14:19:03.975', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('16-06-2017 14:12:28.070', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_URL (url_id, url_name, url_pattern, http_method, action_code, args_code, logged_data_changed, created_by, created_date, last_updated_by, last_updated_date)
values (613, '菜单管理新增', '^/basicconfig/menu.*', 'POST', null, null, 1, -1, to_timestamp('09-06-2017 11:21:31.977', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('16-06-2017 14:12:06.573', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_URL (url_id, url_name, url_pattern, http_method, action_code, args_code, logged_data_changed, created_by, created_date, last_updated_by, last_updated_date)
values (620, '参数配置查询', '^/basicconfig/parameter.*', 'GET', null, null, 0, -1, to_timestamp('13-06-2017 11:04:01.099', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('16-06-2017 14:10:59.368', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_URL (url_id, url_name, url_pattern, http_method, action_code, args_code, logged_data_changed, created_by, created_date, last_updated_by, last_updated_date)
values (622, '设备管理查询', '^/businessconfig/bscdevice.*', 'GET', null, null, 0, -1, to_timestamp('15-06-2017 17:06:00.597', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('16-06-2017 14:10:41.921', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_URL (url_id, url_name, url_pattern, http_method, action_code, args_code, logged_data_changed, created_by, created_date, last_updated_by, last_updated_date)
values (630, '本地客户查询', '^/basicconfig/cusinfo.*', 'GET', null, null, 0, -1, to_timestamp('19-06-2017 16:28:51.427', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('19-06-2017 16:28:51.427', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_URL (url_id, url_name, url_pattern, http_method, action_code, args_code, logged_data_changed, created_by, created_date, last_updated_by, last_updated_date)
values (635, '柜员新增', '^/basicconfig/teller.*', 'POST', null, null, 1, -1, to_timestamp('20-06-2017 09:37:55.412', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('20-06-2017 09:37:55.412', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_URL (url_id, url_name, url_pattern, http_method, action_code, args_code, logged_data_changed, created_by, created_date, last_updated_by, last_updated_date)
values (1, '用户查询', '^/system/users/list.*', 'GET', null, null, 0, -1, to_timestamp('24-02-2016 13:23:01.000', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('24-02-2016 13:23:01.000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_URL (url_id, url_name, url_pattern, http_method, action_code, args_code, logged_data_changed, created_by, created_date, last_updated_by, last_updated_date)
values (2, '用户新增', '^/system/users$', 'POST', 'log.behavior.dialog.submit', 'user.new', 1, -1, to_timestamp('24-02-2016 13:23:01.000', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('24-02-2016 13:23:01.000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_URL (url_id, url_name, url_pattern, http_method, action_code, args_code, logged_data_changed, created_by, created_date, last_updated_by, last_updated_date)
values (3, '用户新增表单', '^/system/users/new.*', 'GET', null, null, 0, -1, to_timestamp('24-02-2016 13:23:01.000', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('24-02-2016 13:24:19.184', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_URL (url_id, url_name, url_pattern, http_method, action_code, args_code, logged_data_changed, created_by, created_date, last_updated_by, last_updated_date)
values (4, '用户编辑', '^/system/users/\d+.*', 'PUT', 'log.behavior.dialog.submit', 'user.edit', 1, -1, to_timestamp('24-02-2016 13:23:01.000', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('24-02-2016 13:23:01.000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_URL (url_id, url_name, url_pattern, http_method, action_code, args_code, logged_data_changed, created_by, created_date, last_updated_by, last_updated_date)
values (5, '用户编辑表单', '^/system/users/edit.*', 'GET', null, null, 0, -1, to_timestamp('24-02-2016 13:23:01.000', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('24-02-2016 13:24:19.184', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_URL (url_id, url_name, url_pattern, http_method, action_code, args_code, logged_data_changed, created_by, created_date, last_updated_by, last_updated_date)
values (6, '用户删除', '^/system/users.*', 'DELETE', 'log.behavior.dialog.ok', 'user.remove', 1, -1, to_timestamp('24-02-2016 13:23:01.000', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('24-02-2016 13:23:01.000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_URL (url_id, url_name, url_pattern, http_method, action_code, args_code, logged_data_changed, created_by, created_date, last_updated_by, last_updated_date)
values (7, '用户详情表单', '^/system/users/show.*', 'GET', null, null, 0, -1, to_timestamp('24-02-2016 13:23:01.000', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('24-02-2016 13:24:19.184', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_URL (url_id, url_name, url_pattern, http_method, action_code, args_code, logged_data_changed, created_by, created_date, last_updated_by, last_updated_date)
values (8, '密码重置', '^/system/users/password.*', 'PUT', 'log.behavior.dialog.ok', 'user.reset', 1, -1, to_timestamp('24-02-2016 13:23:01.000', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('24-02-2016 13:23:01.000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_URL (url_id, url_name, url_pattern, http_method, action_code, args_code, logged_data_changed, created_by, created_date, last_updated_by, last_updated_date)
values (9, '用户锁定', '^/system/users/locked.*', 'PUT', 'log.behavior.dialog.ok', 'user.lock', 1, -1, to_timestamp('24-02-2016 13:23:01.000', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('24-02-2016 13:23:01.000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_URL (url_id, url_name, url_pattern, http_method, action_code, args_code, logged_data_changed, created_by, created_date, last_updated_by, last_updated_date)
values (10, '用户解锁', '^/system/users/unlocked.*', 'PUT', 'log.behavior.dialog.ok', 'user.unlock', 1, -1, to_timestamp('24-02-2016 13:23:01.000', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('24-02-2016 13:23:01.000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_URL (url_id, url_name, url_pattern, http_method, action_code, args_code, logged_data_changed, created_by, created_date, last_updated_by, last_updated_date)
values (31, '功能查询', '^/system/funs/list.*', 'GET', null, null, 0, -1, to_timestamp('24-02-2016 15:05:16.440', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('24-02-2016 15:05:16.440', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_URL (url_id, url_name, url_pattern, http_method, action_code, args_code, logged_data_changed, created_by, created_date, last_updated_by, last_updated_date)
values (32, '功能新增', '^/system/funs$', 'POST', 'log.behavior.dialog.submit', 'fun.new', 1, -1, to_timestamp('24-02-2016 15:05:45.134', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('24-02-2016 15:05:45.134', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_URL (url_id, url_name, url_pattern, http_method, action_code, args_code, logged_data_changed, created_by, created_date, last_updated_by, last_updated_date)
values (33, '功能新增表单', '^/system/funs/new.*', 'GET', null, null, 0, -1, to_timestamp('24-02-2016 13:23:01.000', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('24-02-2016 13:24:19.184', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_URL (url_id, url_name, url_pattern, http_method, action_code, args_code, logged_data_changed, created_by, created_date, last_updated_by, last_updated_date)
values (34, '功能编辑', '^/system/funs/\d+.*', 'PUT', 'log.behavior.dialog.submit', 'fun.edit', 1, -1, to_timestamp('24-02-2016 15:06:41.291', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('24-02-2016 15:06:41.291', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_URL (url_id, url_name, url_pattern, http_method, action_code, args_code, logged_data_changed, created_by, created_date, last_updated_by, last_updated_date)
values (35, '功能编辑表单', '^/system/funs/edit.*', 'GET', null, null, 0, -1, to_timestamp('24-02-2016 13:23:01.000', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('24-02-2016 13:24:19.184', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_URL (url_id, url_name, url_pattern, http_method, action_code, args_code, logged_data_changed, created_by, created_date, last_updated_by, last_updated_date)
values (36, '功能删除', '^/system/funs/\d+.*', 'DELETE', 'log.behavior.dialog.ok', 'fun.remove', 1, -1, to_timestamp('24-02-2016 15:07:07.762', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('24-02-2016 15:07:38.184', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_URL (url_id, url_name, url_pattern, http_method, action_code, args_code, logged_data_changed, created_by, created_date, last_updated_by, last_updated_date)
values (37, '功能详情表单', '^/system/funs/show.*', 'GET', null, null, 0, -1, to_timestamp('24-02-2016 13:23:01.000', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('24-02-2016 13:24:19.184', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_URL (url_id, url_name, url_pattern, http_method, action_code, args_code, logged_data_changed, created_by, created_date, last_updated_by, last_updated_date)
values (38, '新增功能对应的URL', '^/system/funs/\d+/urls$', 'POST', 'log.behavior.dialog.submit', 'fun.edit', 1, -1, to_timestamp('24-02-2016 15:06:41.291', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('24-02-2016 15:06:41.291', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_URL (url_id, url_name, url_pattern, http_method, action_code, args_code, logged_data_changed, created_by, created_date, last_updated_by, last_updated_date)
values (39, '查询功能对应的URL', '^/system/funs/\d+/urls.*', 'GET', null, null, 0, -1, to_timestamp('24-02-2016 15:05:45.134', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('24-02-2016 15:05:45.134', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_URL (url_id, url_name, url_pattern, http_method, action_code, args_code, logged_data_changed, created_by, created_date, last_updated_by, last_updated_date)
values (40, '查询排除的URL', '^/system/urls/excepted.*', 'GET', null, null, 0, -1, to_timestamp('24-02-2016 15:05:45.134', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('24-02-2016 15:05:45.134', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_URL (url_id, url_name, url_pattern, http_method, action_code, args_code, logged_data_changed, created_by, created_date, last_updated_by, last_updated_date)
values (41, 'URL选择表单', '^/system/urls/select.*', 'GET', null, null, 0, -1, to_timestamp('24-02-2016 13:23:01.000', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('24-02-2016 13:24:19.184', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_URL (url_id, url_name, url_pattern, http_method, action_code, args_code, logged_data_changed, created_by, created_date, last_updated_by, last_updated_date)
values (61, '菜单查询', '^/system/menus/list.*', 'GET', null, null, 0, -1, to_timestamp('24-02-2016 15:05:16.440', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('24-02-2016 15:05:16.440', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_URL (url_id, url_name, url_pattern, http_method, action_code, args_code, logged_data_changed, created_by, created_date, last_updated_by, last_updated_date)
values (62, '菜单新增', '^/system/menus$', 'POST', 'log.behavior.dialog.submit', 'menu.new', 1, -1, to_timestamp('24-02-2016 15:05:45.134', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('24-02-2016 15:05:45.134', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_URL (url_id, url_name, url_pattern, http_method, action_code, args_code, logged_data_changed, created_by, created_date, last_updated_by, last_updated_date)
values (63, '菜单新增表单', '^/system/menus/new.*', 'GET', null, null, 0, -1, to_timestamp('24-02-2016 13:23:01.000', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('24-02-2016 13:24:19.184', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_URL (url_id, url_name, url_pattern, http_method, action_code, args_code, logged_data_changed, created_by, created_date, last_updated_by, last_updated_date)
values (64, '菜单编辑', '^/system/menus/\d+.*', 'PUT', 'log.behavior.dialog.submit', 'menu.edit', 1, -1, to_timestamp('24-02-2016 15:06:41.291', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('24-02-2016 15:28:45.067', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_URL (url_id, url_name, url_pattern, http_method, action_code, args_code, logged_data_changed, created_by, created_date, last_updated_by, last_updated_date)
values (65, '菜单编辑表单', '^/system/menus/edit.*', 'GET', null, null, 0, -1, to_timestamp('24-02-2016 13:23:01.000', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('24-02-2016 13:24:19.184', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_URL (url_id, url_name, url_pattern, http_method, action_code, args_code, logged_data_changed, created_by, created_date, last_updated_by, last_updated_date)
values (66, '菜单移动', '^/system/menus/\d+/parent/\d+/\d+.*', 'PUT', 'log.behavior.menu.act1', null, 1, -1, to_timestamp('24-02-2016 13:23:01.000', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('24-02-2016 13:23:01.000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_URL (url_id, url_name, url_pattern, http_method, action_code, args_code, logged_data_changed, created_by, created_date, last_updated_by, last_updated_date)
values (67, '菜单删除', '^/system/menus/\d+.*', 'DELETE', 'log.behavior.dialog.o', 'menu.remove', 1, -1, to_timestamp('24-02-2016 15:07:07.762', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('24-02-2016 16:42:28.458', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_URL (url_id, url_name, url_pattern, http_method, action_code, args_code, logged_data_changed, created_by, created_date, last_updated_by, last_updated_date)
values (68, '菜单详情表单', '^/system/menus/show.*', 'GET', null, null, 0, -1, to_timestamp('24-02-2016 13:23:01.000', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('24-02-2016 13:24:19.184', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_URL (url_id, url_name, url_pattern, http_method, action_code, args_code, logged_data_changed, created_by, created_date, last_updated_by, last_updated_date)
values (91, '角色查询', '^/system/roles/list.*', 'GET', null, null, 0, -1, to_timestamp('24-02-2016 13:23:01.000', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('24-02-2016 13:23:01.000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_URL (url_id, url_name, url_pattern, http_method, action_code, args_code, logged_data_changed, created_by, created_date, last_updated_by, last_updated_date)
values (92, '角色新增', '^/system/roles$', 'POST', 'log.behavior.dialog.submit', 'role.new', 1, -1, to_timestamp('24-02-2016 13:23:01.000', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('24-02-2016 13:23:01.000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_URL (url_id, url_name, url_pattern, http_method, action_code, args_code, logged_data_changed, created_by, created_date, last_updated_by, last_updated_date)
values (93, '角色新增表单', '^/system/roles/new.*', 'GET', null, null, 0, -1, to_timestamp('24-02-2016 13:23:01.000', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('24-02-2016 13:24:19.184', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_URL (url_id, url_name, url_pattern, http_method, action_code, args_code, logged_data_changed, created_by, created_date, last_updated_by, last_updated_date)
values (94, '角色编辑', '^/system/roles/\d+.*', 'PUT', 'log.behavior.dialog.submit', 'role.edit', 1, -1, to_timestamp('24-02-2016 13:23:01.000', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('24-02-2016 13:23:01.000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_URL (url_id, url_name, url_pattern, http_method, action_code, args_code, logged_data_changed, created_by, created_date, last_updated_by, last_updated_date)
values (95, '角色编辑表单', '^/system/roles/edit.*', 'GET', null, null, 0, -1, to_timestamp('24-02-2016 13:23:01.000', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('24-02-2016 13:24:19.184', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_URL (url_id, url_name, url_pattern, http_method, action_code, args_code, logged_data_changed, created_by, created_date, last_updated_by, last_updated_date)
values (96, '角色删除', '^/system/roles.*', 'DELETE', 'log.behavior.dialog.ok', 'role.remove', 1, -1, to_timestamp('24-02-2016 13:23:01.000', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('24-02-2016 13:23:01.000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_URL (url_id, url_name, url_pattern, http_method, action_code, args_code, logged_data_changed, created_by, created_date, last_updated_by, last_updated_date)
values (97, '角色授权展示功能列表', '^/system/roles/\d+/funs.*', 'GET', null, null, 0, -1, to_timestamp('24-02-2016 13:23:01.000', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('24-02-2016 13:23:01.000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_URL (url_id, url_name, url_pattern, http_method, action_code, args_code, logged_data_changed, created_by, created_date, last_updated_by, last_updated_date)
values (98, '角色授权', '^/system/roles/\d+/funs$', 'POST', 'log.behavior.dialog.submit', 'role.authorization', 0, -1, to_timestamp('24-02-2016 13:23:01.000', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('24-02-2016 13:23:01.000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_URL (url_id, url_name, url_pattern, http_method, action_code, args_code, logged_data_changed, created_by, created_date, last_updated_by, last_updated_date)
values (99, '功能平铺选择表单', '^/system/funs/select.*', 'GET', null, null, 0, -1, to_timestamp('24-02-2016 13:23:01.000', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('24-02-2016 13:24:19.184', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_URL (url_id, url_name, url_pattern, http_method, action_code, args_code, logged_data_changed, created_by, created_date, last_updated_by, last_updated_date)
values (100, '获取角色成员', '^/system/roles/\d+/users.*', 'GET', null, null, 0, -1, to_timestamp('24-02-2016 13:23:01.000', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('24-02-2016 13:23:01.000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_URL (url_id, url_name, url_pattern, http_method, action_code, args_code, logged_data_changed, created_by, created_date, last_updated_by, last_updated_date)
values (101, '设置角色成员', '^/system/roles/\d+/users.*', 'POST', 'log.behavior.dialog.submit', 'role.setMembership', 0, -1, to_timestamp('24-02-2016 13:23:01.000', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('24-02-2016 13:23:01.000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_URL (url_id, url_name, url_pattern, http_method, action_code, args_code, logged_data_changed, created_by, created_date, last_updated_by, last_updated_date)
values (102, '查询排除ID的用户', '^/system/users/excepted.*', 'GET', null, null, 0, -1, to_timestamp('24-02-2016 13:23:01.000', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('24-02-2016 13:23:01.000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_URL (url_id, url_name, url_pattern, http_method, action_code, args_code, logged_data_changed, created_by, created_date, last_updated_by, last_updated_date)
values (103, '用户选择表单', '^/system/users/select.*', 'GET', null, null, 0, -1, to_timestamp('24-02-2016 13:23:01.000', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('24-02-2016 13:24:19.184', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_URL (url_id, url_name, url_pattern, http_method, action_code, args_code, logged_data_changed, created_by, created_date, last_updated_by, last_updated_date)
values (121, '通用角色查询', '^/system/commroles/list.*', 'GET', null, null, 0, -1, to_timestamp('24-02-2016 13:23:01.000', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('24-02-2016 13:23:01.000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_URL (url_id, url_name, url_pattern, http_method, action_code, args_code, logged_data_changed, created_by, created_date, last_updated_by, last_updated_date)
values (122, '获取通用角色成员', '^/system/commroles/\d+/users.*', 'GET', null, null, 0, -1, to_timestamp('24-02-2016 13:23:01.000', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('24-02-2016 13:23:01.000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_URL (url_id, url_name, url_pattern, http_method, action_code, args_code, logged_data_changed, created_by, created_date, last_updated_by, last_updated_date)
values (123, '设置通用角色成员', '^/system/commroles/\d+/users.*', 'POST', 'log.behavior.dialog.submit', 'commrole.setMembership', 0, -1, to_timestamp('24-02-2016 13:23:01.000', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('24-02-2016 13:23:01.000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_URL (url_id, url_name, url_pattern, http_method, action_code, args_code, logged_data_changed, created_by, created_date, last_updated_by, last_updated_date)
values (141, '机构查询', '^/system/orgs/list.*', 'GET', null, null, 0, -1, to_timestamp('24-02-2016 13:23:01.000', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('24-02-2016 13:23:01.000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_URL (url_id, url_name, url_pattern, http_method, action_code, args_code, logged_data_changed, created_by, created_date, last_updated_by, last_updated_date)
values (142, '机构新增', '^/system/orgs$', 'POST', 'log.behavior.dialog.submit', 'org.new', 1, -1, to_timestamp('24-02-2016 13:23:01.000', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('24-02-2016 13:23:01.000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_URL (url_id, url_name, url_pattern, http_method, action_code, args_code, logged_data_changed, created_by, created_date, last_updated_by, last_updated_date)
values (143, '机构新增表单', '^/system/orgs/new.*', 'GET', null, null, 0, -1, to_timestamp('24-02-2016 13:23:01.000', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('13-05-2016 15:11:39.085', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_URL (url_id, url_name, url_pattern, http_method, action_code, args_code, logged_data_changed, created_by, created_date, last_updated_by, last_updated_date)
values (144, '机构编辑', '^/system/orgs/\d+.*', 'PUT', 'log.behavior.dialog.submit', 'org.edit', 1, -1, to_timestamp('24-02-2016 13:23:01.000', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('24-02-2016 13:23:01.000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_URL (url_id, url_name, url_pattern, http_method, action_code, args_code, logged_data_changed, created_by, created_date, last_updated_by, last_updated_date)
values (145, '机构编辑表单', '^/system/orgs/edit.*', 'GET', null, null, 0, -1, to_timestamp('24-02-2016 13:23:01.000', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('24-02-2016 13:24:19.184', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_URL (url_id, url_name, url_pattern, http_method, action_code, args_code, logged_data_changed, created_by, created_date, last_updated_by, last_updated_date)
values (146, '机构移动', '^/system/orgs/\d+/parent/\d+.*', 'PUT', 'log.behavior.org.action1', null, 1, -1, to_timestamp('24-02-2016 13:23:01.000', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('24-02-2016 13:23:01.000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_URL (url_id, url_name, url_pattern, http_method, action_code, args_code, logged_data_changed, created_by, created_date, last_updated_by, last_updated_date)
values (147, '机构删除', '^/system/orgs/extendDel/\d+.*', 'DELETE', 'log.behavior.dialog.ok', 'org.remove', 1, -1, to_timestamp('24-02-2016 13:23:01.000', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('05-01-2018 15:02:27.901', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_URL (url_id, url_name, url_pattern, http_method, action_code, args_code, logged_data_changed, created_by, created_date, last_updated_by, last_updated_date)
values (148, '机构详情表单', '^/system/orgs/show.*', 'GET', null, null, 0, -1, to_timestamp('24-02-2016 13:23:01.000', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('24-02-2016 13:24:19.184', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_URL (url_id, url_name, url_pattern, http_method, action_code, args_code, logged_data_changed, created_by, created_date, last_updated_by, last_updated_date)
values (149, '机构导出', '^/system/orgs/export$', 'GET', 'log.behavior.org.export', null, 0, -1, to_timestamp('24-02-2016 13:23:01.000', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('24-02-2016 13:23:01.000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_URL (url_id, url_name, url_pattern, http_method, action_code, args_code, logged_data_changed, created_by, created_date, last_updated_by, last_updated_date)
values (150, '机构导入', '^/system/orgs/import$', 'POST', 'log.behavior.org.import', null, 0, -1, to_timestamp('24-02-2016 13:23:01.000', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('24-02-2016 13:23:01.000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_URL (url_id, url_name, url_pattern, http_method, action_code, args_code, logged_data_changed, created_by, created_date, last_updated_by, last_updated_date)
values (151, '机构导入表单', '^/system/orgs/import.*', 'GET', null, null, 0, -1, to_timestamp('24-02-2016 13:23:01.000', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('24-02-2016 13:24:19.184', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_URL (url_id, url_name, url_pattern, http_method, action_code, args_code, logged_data_changed, created_by, created_date, last_updated_by, last_updated_date)
values (171, 'URL查询', '^/system/urls/list.*', 'GET', null, null, 0, -1, to_timestamp('24-02-2016 13:34:51.540', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('24-02-2016 13:34:51.540', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_URL (url_id, url_name, url_pattern, http_method, action_code, args_code, logged_data_changed, created_by, created_date, last_updated_by, last_updated_date)
values (172, 'URL新增', '^/system/urls$', 'POST', 'log.behavior.dialog.submit', 'url.new', 1, -1, to_timestamp('24-02-2016 13:36:14.345', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('24-02-2016 13:36:14.345', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_URL (url_id, url_name, url_pattern, http_method, action_code, args_code, logged_data_changed, created_by, created_date, last_updated_by, last_updated_date)
values (173, 'URL新增表单', '^/system/urls/new.*', 'GET', null, null, 0, -1, to_timestamp('24-02-2016 13:23:01.000', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('24-02-2016 13:24:19.184', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_URL (url_id, url_name, url_pattern, http_method, action_code, args_code, logged_data_changed, created_by, created_date, last_updated_by, last_updated_date)
values (174, 'URL编辑', '^/system/urls/\d+.*', 'PUT', 'log.behavior.dialog.submit', 'url.edit', 1, -1, to_timestamp('24-02-2016 13:36:55.509', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('24-02-2016 14:15:48.390', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_URL (url_id, url_name, url_pattern, http_method, action_code, args_code, logged_data_changed, created_by, created_date, last_updated_by, last_updated_date)
values (175, 'URL编辑表单', '^/system/urls/edit.*', 'GET', null, null, 0, -1, to_timestamp('24-02-2016 13:23:01.000', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('24-02-2016 13:24:19.184', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_URL (url_id, url_name, url_pattern, http_method, action_code, args_code, logged_data_changed, created_by, created_date, last_updated_by, last_updated_date)
values (176, 'URL删除', '^/system/urls.*', 'DELETE', 'log.behavior.dialog.ok', 'url.remove', 1, -1, to_timestamp('24-02-2016 13:37:29.857', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('24-02-2016 14:13:51.080', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_URL (url_id, url_name, url_pattern, http_method, action_code, args_code, logged_data_changed, created_by, created_date, last_updated_by, last_updated_date)
values (177, 'URL详情表单', '^/system/urls/show.*', 'GET', null, null, 0, -1, to_timestamp('24-02-2016 13:23:01.000', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('24-02-2016 13:24:19.184', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_URL (url_id, url_name, url_pattern, http_method, action_code, args_code, logged_data_changed, created_by, created_date, last_updated_by, last_updated_date)
values (201, '字典查询', '^/system/dics/list.*', 'GET', null, null, 0, -1, to_timestamp('24-02-2016 13:23:01.000', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('24-02-2016 13:24:19.184', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_URL (url_id, url_name, url_pattern, http_method, action_code, args_code, logged_data_changed, created_by, created_date, last_updated_by, last_updated_date)
values (202, '字典新增', '^/system/dics$', 'POST', 'log.behavior.dialog.submit', 'dic.new', 1, -1, to_timestamp('24-02-2016 13:23:01.000', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('24-02-2016 13:23:01.000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_URL (url_id, url_name, url_pattern, http_method, action_code, args_code, logged_data_changed, created_by, created_date, last_updated_by, last_updated_date)
values (203, '字典新增表单', '^/system/dics/new.*', 'GET', null, null, 0, -1, to_timestamp('24-02-2016 13:23:01.000', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('24-02-2016 13:24:19.184', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_URL (url_id, url_name, url_pattern, http_method, action_code, args_code, logged_data_changed, created_by, created_date, last_updated_by, last_updated_date)
values (204, '字典编辑', '^/system/dics.*', 'PUT', 'log.behavior.dialog.submit', 'dic.edit', 1, -1, to_timestamp('24-02-2016 13:23:01.000', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('24-02-2016 13:23:01.000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_URL (url_id, url_name, url_pattern, http_method, action_code, args_code, logged_data_changed, created_by, created_date, last_updated_by, last_updated_date)
values (205, '字典编辑表单', '^/system/dics/edit.*', 'GET', null, null, 0, -1, to_timestamp('24-02-2016 13:23:01.000', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('24-02-2016 13:24:19.184', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_URL (url_id, url_name, url_pattern, http_method, action_code, args_code, logged_data_changed, created_by, created_date, last_updated_by, last_updated_date)
values (206, '字典删除', '^/system/dics.*', 'DELETE', 'log.behavior.dialog.ok', 'dic.remove', 1, -1, to_timestamp('24-02-2016 13:23:01.000', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('24-02-2016 13:23:01.000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_URL (url_id, url_name, url_pattern, http_method, action_code, args_code, logged_data_changed, created_by, created_date, last_updated_by, last_updated_date)
values (207, '字典详情表单', '^/system/dics/show.*', 'GET', null, null, 0, -1, to_timestamp('24-02-2016 13:23:01.000', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('24-02-2016 13:24:19.184', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_URL (url_id, url_name, url_pattern, http_method, action_code, args_code, logged_data_changed, created_by, created_date, last_updated_by, last_updated_date)
values (208, '字典键值对查询', '^/system/dics/.+', 'GET', null, null, 0, -1, to_timestamp('24-02-2016 13:23:01.000', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('24-02-2016 13:24:19.184', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_URL (url_id, url_name, url_pattern, http_method, action_code, args_code, logged_data_changed, created_by, created_date, last_updated_by, last_updated_date)
values (221, '查询在线用户', '^/system/users/online.*', 'GET', null, null, 0, -1, to_timestamp('24-02-2016 13:23:01.000', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('24-02-2016 13:23:01.000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_URL (url_id, url_name, url_pattern, http_method, action_code, args_code, logged_data_changed, created_by, created_date, last_updated_by, last_updated_date)
values (231, '登录日志查询', '^/system/logs/login.*', 'GET', null, null, 0, -1, to_timestamp('24-02-2016 13:23:01.000', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('24-02-2016 13:23:01.000', 'dd-mm-yyyy hh24:mi:ss.ff'));
commit;
prompt 100 records committed...
insert into SYS_URL (url_id, url_name, url_pattern, http_method, action_code, args_code, logged_data_changed, created_by, created_date, last_updated_by, last_updated_date)
values (241, '行为日志查询', '^/system/logs/behavior.*', 'GET', null, null, 0, -1, to_timestamp('24-02-2016 13:23:01.000', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('24-02-2016 13:23:01.000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_URL (url_id, url_name, url_pattern, http_method, action_code, args_code, logged_data_changed, created_by, created_date, last_updated_by, last_updated_date)
values (612, '菜单管理查询', '^/basicconfig/menu.*', 'GET', null, null, 0, -1, to_timestamp('09-06-2017 11:21:00.932', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('16-06-2017 14:12:13.037', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_URL (url_id, url_name, url_pattern, http_method, action_code, args_code, logged_data_changed, created_by, created_date, last_updated_by, last_updated_date)
values (616, '业务管理查询', '^/basicconfig/businessmanage.*', 'GET', null, null, 0, -1, to_timestamp('12-06-2017 16:17:17.699', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('16-06-2017 14:11:42.767', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_URL (url_id, url_name, url_pattern, http_method, action_code, args_code, logged_data_changed, created_by, created_date, last_updated_by, last_updated_date)
values (242, '数据变更查询', '^/system/logs/data.*', 'GET', null, null, 0, -1, to_timestamp('24-02-2016 13:23:01.000', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('19-05-2017 14:02:26.609', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_URL (url_id, url_name, url_pattern, http_method, action_code, args_code, logged_data_changed, created_by, created_date, last_updated_by, last_updated_date)
values (617, '业务管理新增', '^/basicconfig/businessmanage.*', 'POST', null, null, 1, -1, to_timestamp('12-06-2017 16:18:17.000', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('16-06-2017 14:11:32.935', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_URL (url_id, url_name, url_pattern, http_method, action_code, args_code, logged_data_changed, created_by, created_date, last_updated_by, last_updated_date)
values (608, '客户类型查询', '^/basicconfig/custtype.*', 'GET', null, null, 0, -1, to_timestamp('08-06-2017 14:17:43.486', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('16-06-2017 13:53:51.421', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_URL (url_id, url_name, url_pattern, http_method, action_code, args_code, logged_data_changed, created_by, created_date, last_updated_by, last_updated_date)
values (609, '客户类型新增', '^/basicconfig/custtype.*', 'POST', null, null, 1, -1, to_timestamp('08-06-2017 14:18:43.722', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('16-06-2017 14:12:35.775', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_URL (url_id, url_name, url_pattern, http_method, action_code, args_code, logged_data_changed, created_by, created_date, last_updated_by, last_updated_date)
values (618, '业务管理编辑', '^/basicconfig/businessmanage.*', 'PUT', null, null, 1, -1, to_timestamp('12-06-2017 16:18:51.577', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('16-06-2017 14:11:23.366', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_URL (url_id, url_name, url_pattern, http_method, action_code, args_code, logged_data_changed, created_by, created_date, last_updated_by, last_updated_date)
values (619, '业务管理删除', '^/basicconfig/businessmanage.*', 'DELETE', null, null, 1, -1, to_timestamp('12-06-2017 16:19:04.745', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('16-06-2017 14:11:13.908', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_URL (url_id, url_name, url_pattern, http_method, action_code, args_code, logged_data_changed, created_by, created_date, last_updated_by, last_updated_date)
values (623, '设备管理新增', '^/businessconfig/bscdevice.*', 'POST', null, null, 1, -1, to_timestamp('15-06-2017 17:06:26.988', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('16-06-2017 14:10:34.289', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_URL (url_id, url_name, url_pattern, http_method, action_code, args_code, logged_data_changed, created_by, created_date, last_updated_by, last_updated_date)
values (626, '版本管理查询', '^/basicconfig/patchversion.*', 'GET', null, null, 0, -1, to_timestamp('19-06-2017 14:51:30.284', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('19-06-2017 14:51:30.284', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_URL (url_id, url_name, url_pattern, http_method, action_code, args_code, logged_data_changed, created_by, created_date, last_updated_by, last_updated_date)
values (627, '版本管理新增', '^/basicconfig/patchversion.*', 'POST', null, null, 1, -1, to_timestamp('19-06-2017 14:52:23.183', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('19-06-2017 14:52:23.183', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_URL (url_id, url_name, url_pattern, http_method, action_code, args_code, logged_data_changed, created_by, created_date, last_updated_by, last_updated_date)
values (629, '版本管理删除', '^/basicconfig/patchversion.*', 'DELETE', null, null, 1, -1, to_timestamp('19-06-2017 14:53:15.832', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('19-06-2017 14:53:15.832', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_URL (url_id, url_name, url_pattern, http_method, action_code, args_code, logged_data_changed, created_by, created_date, last_updated_by, last_updated_date)
values (634, '柜员查询', '^/basicconfig/teller.*', 'GET', null, null, 0, -1, to_timestamp('20-06-2017 09:28:04.774', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('20-06-2017 09:28:04.774', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_URL (url_id, url_name, url_pattern, http_method, action_code, args_code, logged_data_changed, created_by, created_date, last_updated_by, last_updated_date)
values (638, '临近网点查询', '^/basicconfig/near.*', 'GET', null, null, 0, -1, to_timestamp('21-06-2017 17:52:25.439', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('21-06-2017 17:52:25.439', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_URL (url_id, url_name, url_pattern, http_method, action_code, args_code, logged_data_changed, created_by, created_date, last_updated_by, last_updated_date)
values (639, '临近网点编辑', '^/basicconfig/near.*', 'POST', null, null, 1, -1, to_timestamp('21-06-2017 17:53:17.268', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('21-06-2017 17:53:17.268', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_URL (url_id, url_name, url_pattern, http_method, action_code, args_code, logged_data_changed, created_by, created_date, last_updated_by, last_updated_date)
values (640, '临近网点删除', '^/basicconfig/near.*', 'DELETE', null, null, 1, -1, to_timestamp('21-06-2017 17:53:31.449', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('21-06-2017 17:53:31.449', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_URL (url_id, url_name, url_pattern, http_method, action_code, args_code, logged_data_changed, created_by, created_date, last_updated_by, last_updated_date)
values (611, '客户类型删除', '^/basicconfig/custtype.*', 'DELETE', null, null, 1, -1, to_timestamp('08-06-2017 14:19:25.651', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('16-06-2017 14:12:19.934', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_URL (url_id, url_name, url_pattern, http_method, action_code, args_code, logged_data_changed, created_by, created_date, last_updated_by, last_updated_date)
values (615, '菜单管理删除', '^/basicconfig/menu.*', 'DELETE', null, null, 1, -1, to_timestamp('09-06-2017 11:22:18.329', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('16-06-2017 14:11:52.532', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_URL (url_id, url_name, url_pattern, http_method, action_code, args_code, logged_data_changed, created_by, created_date, last_updated_by, last_updated_date)
values (625, '设备管理删除', '^/businessconfig/bscdevice.*', 'DELETE', null, null, 1, -1, to_timestamp('15-06-2017 17:08:14.908', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('16-06-2017 14:10:03.492', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_URL (url_id, url_name, url_pattern, http_method, action_code, args_code, logged_data_changed, created_by, created_date, last_updated_by, last_updated_date)
values (628, '版本管理编辑', '^/basicconfig/patchversion.*', 'PUT', null, null, 1, -1, to_timestamp('19-06-2017 14:52:54.492', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('19-06-2017 14:52:54.492', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_URL (url_id, url_name, url_pattern, http_method, action_code, args_code, logged_data_changed, created_by, created_date, last_updated_by, last_updated_date)
values (631, '本地客户新增', '^/basicconfig/cusinfo.*', 'POST', null, null, 1, -1, to_timestamp('19-06-2017 16:29:27.737', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('19-06-2017 16:29:27.737', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_URL (url_id, url_name, url_pattern, http_method, action_code, args_code, logged_data_changed, created_by, created_date, last_updated_by, last_updated_date)
values (632, '本地客户编辑', '^/basicconfig/cusinfo.*', 'PUT', null, null, 1, -1, to_timestamp('19-06-2017 16:29:46.325', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('19-06-2017 16:29:46.325', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_URL (url_id, url_name, url_pattern, http_method, action_code, args_code, logged_data_changed, created_by, created_date, last_updated_by, last_updated_date)
values (633, '本地客户删除', '^/basicconfig/cusinfo.*', 'DELETE', null, null, 1, -1, to_timestamp('19-06-2017 16:30:03.248', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('19-06-2017 16:30:03.248', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_URL (url_id, url_name, url_pattern, http_method, action_code, args_code, logged_data_changed, created_by, created_date, last_updated_by, last_updated_date)
values (637, '柜员删除', '^/basicconfig/teller.*', 'DELETE', null, null, 1, -1, to_timestamp('20-06-2017 09:38:40.732', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('20-06-2017 09:38:40.732', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_URL (url_id, url_name, url_pattern, http_method, action_code, args_code, logged_data_changed, created_by, created_date, last_updated_by, last_updated_date)
values (614, '菜单管理编辑', '^/basicconfig/menu.*', 'PUT', null, null, 1, -1, to_timestamp('09-06-2017 11:21:57.844', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('16-06-2017 14:12:00.022', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_URL (url_id, url_name, url_pattern, http_method, action_code, args_code, logged_data_changed, created_by, created_date, last_updated_by, last_updated_date)
values (621, '参数配置保存', '^/basicconfig/parameter.*', 'POST', null, null, 1, -1, to_timestamp('13-06-2017 11:05:15.616', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('22-10-2017 15:58:08.956', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_URL (url_id, url_name, url_pattern, http_method, action_code, args_code, logged_data_changed, created_by, created_date, last_updated_by, last_updated_date)
values (624, '设备管理编辑', '^/businessconfig/bscdevice.*', 'PUT', null, null, 1, -1, to_timestamp('15-06-2017 17:07:19.708', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('16-06-2017 14:10:11.767', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_URL (url_id, url_name, url_pattern, http_method, action_code, args_code, logged_data_changed, created_by, created_date, last_updated_by, last_updated_date)
values (636, '柜员编辑', '^/basicconfig/teller.*', 'PUT', null, null, 1, -1, to_timestamp('20-06-2017 09:38:26.370', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('20-06-2017 09:38:26.370', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_URL (url_id, url_name, url_pattern, http_method, action_code, args_code, logged_data_changed, created_by, created_date, last_updated_by, last_updated_date)
values (643, '业务队列监控查询', '^/monitor/trxtoday.*', 'GET', null, null, 0, -1, to_timestamp('28-06-2017 14:00:25.714', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('28-06-2017 14:18:02.403', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_URL (url_id, url_name, url_pattern, http_method, action_code, args_code, logged_data_changed, created_by, created_date, last_updated_by, last_updated_date)
values (645, '柜员效率报表查询', '^/report/empefficiency.*', 'GET', null, null, 0, -1, to_timestamp('05-07-2017 11:30:02.238', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('05-07-2017 11:30:02.238', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_URL (url_id, url_name, url_pattern, http_method, action_code, args_code, logged_data_changed, created_by, created_date, last_updated_by, last_updated_date)
values (649, '窗口配置查询', '^/businessconfig/bscwinconfig.*', 'GET', null, null, 0, -1, to_timestamp('11-07-2017 17:36:06.764', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('11-07-2017 17:36:06.764', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_URL (url_id, url_name, url_pattern, http_method, action_code, args_code, logged_data_changed, created_by, created_date, last_updated_by, last_updated_date)
values (653, '业务流水报表查询', '^/report/businessflow.*', 'GET', null, null, 0, -1, to_timestamp('12-07-2017 19:09:49.394', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('12-07-2017 19:09:49.394', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_URL (url_id, url_name, url_pattern, http_method, action_code, args_code, logged_data_changed, created_by, created_date, last_updated_by, last_updated_date)
values (661, '号票模板查询', '^/businessconfig/ticketform.*', 'GET', null, null, 0, -1, to_timestamp('18-07-2017 16:08:18.683', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('18-07-2017 16:08:18.683', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_URL (url_id, url_name, url_pattern, http_method, action_code, args_code, logged_data_changed, created_by, created_date, last_updated_by, last_updated_date)
values (652, '窗口配置删除', '^/businessconfig/bscwinconfig.*', 'DELETE', null, null, 1, -1, to_timestamp('11-07-2017 17:37:42.215', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('11-07-2017 17:37:42.215', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_URL (url_id, url_name, url_pattern, http_method, action_code, args_code, logged_data_changed, created_by, created_date, last_updated_by, last_updated_date)
values (659, '业务统计报表查询', '^/report/businessstatistics.*', 'GET', null, null, 0, -1, to_timestamp('14-07-2017 16:12:32.700', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('14-07-2017 16:12:32.700', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_URL (url_id, url_name, url_pattern, http_method, action_code, args_code, logged_data_changed, created_by, created_date, last_updated_by, last_updated_date)
values (663, '网点业务新增', '^/businessconfig/bscbranchbus.*', 'POST', null, null, 1, -1, to_timestamp('24-07-2017 14:34:31.985', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('24-07-2017 14:34:31.985', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_URL (url_id, url_name, url_pattern, http_method, action_code, args_code, logged_data_changed, created_by, created_date, last_updated_by, last_updated_date)
values (668, '窗口监控查询', '^/monitor/winmonitor.*', 'GET', null, null, 0, -1, to_timestamp('10-08-2017 15:35:15.891', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('10-08-2017 15:35:15.891', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_URL (url_id, url_name, url_pattern, http_method, action_code, args_code, logged_data_changed, created_by, created_date, last_updated_by, last_updated_date)
values (672, '窗口业务查询', '^/businessconfig/bscwinbus.*', 'GET', null, null, 0, -1, to_timestamp('28-08-2017 15:06:42.738', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('28-08-2017 15:06:42.738', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_URL (url_id, url_name, url_pattern, http_method, action_code, args_code, logged_data_changed, created_by, created_date, last_updated_by, last_updated_date)
values (674, '取号模板', '^/basicconfig/takemodel.*', 'GET', null, null, 0, -1, to_timestamp('06-09-2017 20:40:26.491', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('06-09-2017 20:48:53.887', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_URL (url_id, url_name, url_pattern, http_method, action_code, args_code, logged_data_changed, created_by, created_date, last_updated_by, last_updated_date)
values (675, '取号配置', '^/businessconfig/takeconfig.*', 'GET', null, null, 0, -1, to_timestamp('06-09-2017 21:27:55.658', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('06-09-2017 21:27:55.658', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_URL (url_id, url_name, url_pattern, http_method, action_code, args_code, logged_data_changed, created_by, created_date, last_updated_by, last_updated_date)
values (681, '客户识别查询', '^/businessconfig/bsccustrecogn.*', 'GET', null, null, 0, -1, to_timestamp('12-10-2017 17:10:54.022', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('12-10-2017 17:10:54.022', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_URL (url_id, url_name, url_pattern, http_method, action_code, args_code, logged_data_changed, created_by, created_date, last_updated_by, last_updated_date)
values (682, '客户识别保存', '^/businessconfig/bsccustrecogn.*', 'DELETE', null, null, 1, -1, to_timestamp('12-10-2017 17:12:14.192', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('12-10-2017 17:12:14.192', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_URL (url_id, url_name, url_pattern, http_method, action_code, args_code, logged_data_changed, created_by, created_date, last_updated_by, last_updated_date)
values (678, '广告发布', '^/businessconfig/adpublish.*', 'GET', null, null, 0, -1, to_timestamp('12-10-2017 11:05:30.589', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('12-10-2017 11:05:30.589', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_URL (url_id, url_name, url_pattern, http_method, action_code, args_code, logged_data_changed, created_by, created_date, last_updated_by, last_updated_date)
values (680, '业务显示保存', '^/businessconfig/bscshowtime.*', 'DELETE', null, null, 1, -1, to_timestamp('12-10-2017 16:35:28.480', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('12-10-2017 16:55:48.420', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_URL (url_id, url_name, url_pattern, http_method, action_code, args_code, logged_data_changed, created_by, created_date, last_updated_by, last_updated_date)
values (684, '版本管理下发', '^/basicconfig/patchversion/\d+.*', 'POST', null, null, 1, -1, to_timestamp('22-10-2017 17:07:47.646', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('22-10-2017 17:07:47.646', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_URL (url_id, url_name, url_pattern, http_method, action_code, args_code, logged_data_changed, created_by, created_date, last_updated_by, last_updated_date)
values (685, '号码模板删除', '^/businessconfig/numberform.*', 'DELETE', null, null, 1, -1, to_timestamp('22-10-2017 17:18:18.366', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('22-10-2017 17:18:18.366', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_URL (url_id, url_name, url_pattern, http_method, action_code, args_code, logged_data_changed, created_by, created_date, last_updated_by, last_updated_date)
values (686, '号票模板新增', '^/businessconfig/numberform.*', 'GET', null, null, 0, -1, to_timestamp('22-10-2017 19:40:05.300', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('22-10-2017 19:40:05.300', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_URL (url_id, url_name, url_pattern, http_method, action_code, args_code, logged_data_changed, created_by, created_date, last_updated_by, last_updated_date)
values (687, '号票模板保存配置', '^/businessconfig/ticketform.*', 'POST', null, null, 1, -1, to_timestamp('22-10-2017 19:47:45.466', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('22-10-2017 19:47:45.466', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_URL (url_id, url_name, url_pattern, http_method, action_code, args_code, logged_data_changed, created_by, created_date, last_updated_by, last_updated_date)
values (688, '叫号策略保存', '^/businessconfig/callstrategy.*', 'POST', null, null, 1, -1, to_timestamp('22-10-2017 20:38:20.558', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('22-10-2017 20:43:42.442', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_URL (url_id, url_name, url_pattern, http_method, action_code, args_code, logged_data_changed, created_by, created_date, last_updated_by, last_updated_date)
values (690, '导航配置', '^/businessconfig/navconfig.*', 'GET', null, null, 0, -1, to_timestamp('04-12-2017 17:15:34.584', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('06-12-2017 10:43:02.766', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_URL (url_id, url_name, url_pattern, http_method, action_code, args_code, logged_data_changed, created_by, created_date, last_updated_by, last_updated_date)
values (692, '一键检测', '^/businessconfig/onekeycheck.*', 'GET', null, null, 0, -1, to_timestamp('06-12-2017 10:26:56.126', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('06-12-2017 10:26:56.126', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_URL (url_id, url_name, url_pattern, http_method, action_code, args_code, logged_data_changed, created_by, created_date, last_updated_by, last_updated_date)
values (694, '预约配置', '^/basicconfig/orderconfig.*', 'GET', null, null, 0, -1, to_timestamp('11-01-2018 09:18:13.968', 'dd-mm-yyyy hh24:mi:ss.ff'), -1, to_timestamp('11-01-2018 09:18:13.968', 'dd-mm-yyyy hh24:mi:ss.ff'));
commit;
prompt 153 records loaded
set feedback on
set define on
prompt Done.
