----------------------------------------------
-- Export file for user IQMS_NEW            --
-- Created by zhousj on 2018/4/16, 15:14:42 --
----------------------------------------------

spool table111.log

prompt
prompt Creating table BC_BUSINESSMANAGE
prompt ================================
prompt
create table iqms_new.BC_BUSINESSMANAGE
(
  business_id    NUMBER(10) not null,
  business_name  VARCHAR2(50) not null,
  average_time   VARCHAR2(10),
  order_flag     VARCHAR2(5),
  business_ename VARCHAR2(50)
)
tablespace IQMS_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 8K
    minextents 1
    maxextents unlimited
  );
comment on column iqms_new.BC_BUSINESSMANAGE.business_id
  is '业务ID';
comment on column iqms_new.BC_BUSINESSMANAGE.business_name
  is '业务名称';
comment on column iqms_new.BC_BUSINESSMANAGE.average_time
  is '业务平均办理时长（分钟）';
comment on column iqms_new.BC_BUSINESSMANAGE.order_flag
  is '是否可预约  1-可预约 0-不可预约';
comment on column iqms_new.BC_BUSINESSMANAGE.business_ename
  is '业务英文名称';
alter table iqms_new.BC_BUSINESSMANAGE
  add constraint PK_BC_BUSINESSMANAGE primary key (BUSINESS_ID)
  using index 
  tablespace IQMS_DATA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table BC_CUSINFO
prompt =========================
prompt
create table iqms_new.BC_CUSINFO
(
  org_id       VARCHAR2(20) not null,
  cust_id      VARCHAR2(50) not null,
  cust_name    VARCHAR2(50),
  cust_level   VARCHAR2(20) not null,
  cust_pdut    VARCHAR2(50),
  cust_ad      VARCHAR2(500),
  isbank_eftve VARCHAR2(1) default 1
)
tablespace IQMS_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column iqms_new.BC_CUSINFO.org_id
  is '机构ID';
comment on column iqms_new.BC_CUSINFO.cust_id
  is '客户识别码(卡号，身份证号，手机号码等)';
comment on column iqms_new.BC_CUSINFO.cust_name
  is '客户姓名';
comment on column iqms_new.BC_CUSINFO.cust_level
  is '客户类型码(表BC_CUSTTYPE)';
comment on column iqms_new.BC_CUSINFO.cust_pdut
  is '客户开办产品';
comment on column iqms_new.BC_CUSINFO.cust_ad
  is '客户精准广告';
comment on column iqms_new.BC_CUSINFO.isbank_eftve
  is '是否全行生效。1：是 0：否 ，默认全行生效，否则只在所加网点生效';
alter table iqms_new.BC_CUSINFO
  add constraint PK_BC_CUSINFO primary key (CUST_ID)
  using index 
  tablespace IQMS_DATA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table BC_CUSTTYPE
prompt ==========================
prompt
create table iqms_new.BC_CUSTTYPE
(
  cust_level   VARCHAR2(20) not null,
  cust_name    VARCHAR2(50) not null,
  vip_flag     VARCHAR2(10),
  sms_flag     VARCHAR2(5),
  wait_timeout VARCHAR2(10),
  present_flag VARCHAR2(5),
  is_use       VARCHAR2(5),
  extend1      VARCHAR2(100),
  extend2      VARCHAR2(100),
  extend3      VARCHAR2(100)
)
tablespace IQMS_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 8K
    minextents 1
    maxextents unlimited
  );
comment on column iqms_new.BC_CUSTTYPE.cust_level
  is '客户类型代码';
comment on column iqms_new.BC_CUSTTYPE.cust_name
  is '客户类型名称';
comment on column iqms_new.BC_CUSTTYPE.vip_flag
  is '是否VIP 1-是 2-否';
comment on column iqms_new.BC_CUSTTYPE.sms_flag
  is '是否发送短信   1-发送    0-不发送';
comment on column iqms_new.BC_CUSTTYPE.wait_timeout
  is '等待超时时间：分钟';
comment on column iqms_new.BC_CUSTTYPE.present_flag
  is '是否送礼物：  1-送  0-不送';
comment on column iqms_new.BC_CUSTTYPE.is_use
  is '是否启用      1-启用   0-不启用';
comment on column iqms_new.BC_CUSTTYPE.extend1
  is '扩展字段1';
comment on column iqms_new.BC_CUSTTYPE.extend2
  is '扩展字段2';
comment on column iqms_new.BC_CUSTTYPE.extend3
  is '扩展字段3';
alter table iqms_new.BC_CUSTTYPE
  add constraint PK_BC_CUSTTYPE primary key (CUST_LEVEL)
  using index 
  tablespace IQMS_DATA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table BC_MENU
prompt ======================
prompt
create table iqms_new.BC_MENU
(
  menu_id     NUMBER not null,
  menu_name   VARCHAR2(50) not null,
  menu_enname VARCHAR2(50),
  extend1     VARCHAR2(50)
)
tablespace IQMS_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column iqms_new.BC_MENU.menu_id
  is '菜单表id';
comment on column iqms_new.BC_MENU.menu_name
  is '菜单名称';
comment on column iqms_new.BC_MENU.menu_enname
  is '菜单英文名';
comment on column iqms_new.BC_MENU.extend1
  is '扩展字段1';
alter table iqms_new.BC_MENU
  add constraint PK_BC_MENU primary key (MENU_ID)
  using index 
  tablespace IQMS_DATA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table BC_MODELSTYLE
prompt ============================
prompt
create table iqms_new.BC_MODELSTYLE
(
  id                NUMBER not null,
  org_id            NUMBER not null,
  device_no         VARCHAR2(32) not null,
  style_id          NUMBER,
  datetype_id       NUMBER,
  copy_status       VARCHAR2(10),
  screen_resolution VARCHAR2(50),
  dpi               VARCHAR2(10),
  dpi_x             NUMBER,
  dpi_y             NUMBER
)
tablespace IQMS_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 16K
    next 8K
    minextents 1
    maxextents unlimited
  );
comment on column iqms_new.BC_MODELSTYLE.id
  is '自动生成递增，唯一';
comment on column iqms_new.BC_MODELSTYLE.org_id
  is '机构id';
comment on column iqms_new.BC_MODELSTYLE.device_no
  is '设备id';
comment on column iqms_new.BC_MODELSTYLE.style_id
  is '所属模板id';
comment on column iqms_new.BC_MODELSTYLE.datetype_id
  is '日期类型  1-平日， 2-假日';
comment on column iqms_new.BC_MODELSTYLE.copy_status
  is '是否平日，假日相同   1-相同   0-不相同';
comment on column iqms_new.BC_MODELSTYLE.screen_resolution
  is '屏幕分辨率';
comment on column iqms_new.BC_MODELSTYLE.dpi
  is '偏移步数（无效）';
comment on column iqms_new.BC_MODELSTYLE.dpi_x
  is '偏移x';
comment on column iqms_new.BC_MODELSTYLE.dpi_y
  is '偏移y';

prompt
prompt Creating table BC_MODELSTYLE_ELEMENT
prompt ====================================
prompt
create table iqms_new.BC_MODELSTYLE_ELEMENT
(
  model_style_id            NUMBER not null,
  org_id                    NUMBER not null,
  device_no                 VARCHAR2(32) not null,
  buztype_id                NUMBER,
  element_type              VARCHAR2(20),
  org_type                  VARCHAR2(10),
  element_x                 NUMBER(10),
  element_y                 NUMBER(10),
  element_width             NUMBER(10),
  element_height            NUMBER(10),
  element_family            VARCHAR2(50),
  element_style             VARCHAR2(50),
  element_backgroundcolor   VARCHAR2(100),
  element_fontcolor         VARCHAR2(20),
  element_size              VARCHAR2(10),
  element_icon              VARCHAR2(20),
  icon_position             VARCHAR2(20),
  element_borderradius      VARCHAR2(20),
  borderradiust_topleft1    NUMBER(10),
  borderradius_topright1    NUMBER(10),
  borderradius_bottomright1 NUMBER(10),
  borderradius_bottomleft1  NUMBER(10),
  borderradius_bottomleft2  NUMBER(10),
  borderradius_bottomright2 NUMBER(10),
  borderradius_topright2    NUMBER(10),
  borderradius_topleft2     NUMBER(10),
  element_shape             VARCHAR2(20),
  element_shadow            VARCHAR2(20),
  shadow_h                  NUMBER(10),
  shadow_v                  NUMBER(10),
  shadow_blur               NUMBER(10),
  element_skew              VARCHAR2(20),
  skew_h                    NUMBER(10),
  skew_v                    NUMBER(10),
  element_rotate            VARCHAR2(20),
  rotate_x                  NUMBER(10),
  rotate_y                  NUMBER(10),
  rotate_z                  NUMBER(10),
  element_effect            VARCHAR2(20),
  effect_scrollamount       NUMBER(10),
  effect_direction          VARCHAR2(10),
  childrenpageimg           VARCHAR2(200),
  childrenpagecolor         VARCHAR2(50),
  backgroundimage           VARCHAR2(200),
  element_text              VARCHAR2(200)
)
tablespace IQMS_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 16K
    next 8K
    minextents 1
    maxextents unlimited
  );
comment on column iqms_new.BC_MODELSTYLE_ELEMENT.model_style_id
  is '模板样式id，外键，bc_modelstyle表中的id';
comment on column iqms_new.BC_MODELSTYLE_ELEMENT.org_id
  is '机构id';
comment on column iqms_new.BC_MODELSTYLE_ELEMENT.device_no
  is '设备id';
comment on column iqms_new.BC_MODELSTYLE_ELEMENT.buztype_id
  is '业务id';
comment on column iqms_new.BC_MODELSTYLE_ELEMENT.element_type
  is '元素类型，字典表中数据';
comment on column iqms_new.BC_MODELSTYLE_ELEMENT.org_type
  is '元素层级类型：控制元素在页面上z-index的值';
comment on column iqms_new.BC_MODELSTYLE_ELEMENT.element_x
  is '元素x坐标';
comment on column iqms_new.BC_MODELSTYLE_ELEMENT.element_y
  is '元素y坐标';
comment on column iqms_new.BC_MODELSTYLE_ELEMENT.element_width
  is '元素长度';
comment on column iqms_new.BC_MODELSTYLE_ELEMENT.element_height
  is '元素高度';
comment on column iqms_new.BC_MODELSTYLE_ELEMENT.element_family
  is '元素字体';
comment on column iqms_new.BC_MODELSTYLE_ELEMENT.element_style
  is '元素字形';
comment on column iqms_new.BC_MODELSTYLE_ELEMENT.element_backgroundcolor
  is '元素背景色';
comment on column iqms_new.BC_MODELSTYLE_ELEMENT.element_fontcolor
  is '字体颜色';
comment on column iqms_new.BC_MODELSTYLE_ELEMENT.element_size
  is '字体大小';
comment on column iqms_new.BC_MODELSTYLE_ELEMENT.element_icon
  is '元素图标';
comment on column iqms_new.BC_MODELSTYLE_ELEMENT.icon_position
  is '图标位置';
comment on column iqms_new.BC_MODELSTYLE_ELEMENT.element_borderradius
  is '圆角  borderRadius-圆角   normal-常规';
comment on column iqms_new.BC_MODELSTYLE_ELEMENT.borderradiust_topleft1
  is '圆角参数';
comment on column iqms_new.BC_MODELSTYLE_ELEMENT.borderradius_topright1
  is '圆角参数';
comment on column iqms_new.BC_MODELSTYLE_ELEMENT.borderradius_bottomright1
  is '圆角参数';
comment on column iqms_new.BC_MODELSTYLE_ELEMENT.borderradius_bottomleft1
  is '圆角参数';
comment on column iqms_new.BC_MODELSTYLE_ELEMENT.borderradius_bottomleft2
  is '圆角参数';
comment on column iqms_new.BC_MODELSTYLE_ELEMENT.borderradius_bottomright2
  is '圆角参数';
comment on column iqms_new.BC_MODELSTYLE_ELEMENT.borderradius_topright2
  is '圆角参数';
comment on column iqms_new.BC_MODELSTYLE_ELEMENT.borderradius_topleft2
  is '圆角参数';
comment on column iqms_new.BC_MODELSTYLE_ELEMENT.element_shape
  is '元素形状：hexagon-多边形   normal-常规';
comment on column iqms_new.BC_MODELSTYLE_ELEMENT.element_shadow
  is '元素阴影：shadow-阴影  normal-无阴影';
comment on column iqms_new.BC_MODELSTYLE_ELEMENT.shadow_h
  is '水平阴影';
comment on column iqms_new.BC_MODELSTYLE_ELEMENT.shadow_v
  is '垂直阴影';
comment on column iqms_new.BC_MODELSTYLE_ELEMENT.shadow_blur
  is '阴影距离';
comment on column iqms_new.BC_MODELSTYLE_ELEMENT.element_skew
  is '元素倾斜：skew-倾斜    normal-常规';
comment on column iqms_new.BC_MODELSTYLE_ELEMENT.skew_h
  is '水平倾斜';
comment on column iqms_new.BC_MODELSTYLE_ELEMENT.skew_v
  is '垂直倾斜';
comment on column iqms_new.BC_MODELSTYLE_ELEMENT.element_rotate
  is '元素旋转：rotate-旋转  normal-常规';
comment on column iqms_new.BC_MODELSTYLE_ELEMENT.rotate_x
  is 'x轴旋转';
comment on column iqms_new.BC_MODELSTYLE_ELEMENT.rotate_y
  is 'y轴旋转';
comment on column iqms_new.BC_MODELSTYLE_ELEMENT.rotate_z
  is 'z轴旋转';
comment on column iqms_new.BC_MODELSTYLE_ELEMENT.element_effect
  is '元素效果：marquee-跑马灯效果   normal-常规';
comment on column iqms_new.BC_MODELSTYLE_ELEMENT.effect_scrollamount
  is '效果速度：15-常规，5-超慢  10-慢  25-快  30-超快';
comment on column iqms_new.BC_MODELSTYLE_ELEMENT.effect_direction
  is '效果方向：left-左，right-右，down-下，up-想';
comment on column iqms_new.BC_MODELSTYLE_ELEMENT.childrenpageimg
  is '下级页面背景图';
comment on column iqms_new.BC_MODELSTYLE_ELEMENT.childrenpagecolor
  is '下级页面背景色';
comment on column iqms_new.BC_MODELSTYLE_ELEMENT.backgroundimage
  is '元素背景图片';
comment on column iqms_new.BC_MODELSTYLE_ELEMENT.element_text
  is '元素内容';

prompt
prompt Creating table BC_NEAR
prompt ======================
prompt
create table iqms_new.BC_NEAR
(
  org_id  VARCHAR2(50) not null,
  org_id1 VARCHAR2(50),
  org_id2 VARCHAR2(50),
  org_id3 VARCHAR2(50),
  org_id4 VARCHAR2(50),
  org_id5 VARCHAR2(50),
  org_id6 VARCHAR2(50)
)
tablespace IQMS_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 8K
    minextents 1
    maxextents unlimited
  );
comment on column iqms_new.BC_NEAR.org_id
  is '网点ID';
comment on column iqms_new.BC_NEAR.org_id1
  is '临近网点ID1';
comment on column iqms_new.BC_NEAR.org_id2
  is '临近网点ID2';
comment on column iqms_new.BC_NEAR.org_id3
  is '临近网点ID3';
comment on column iqms_new.BC_NEAR.org_id4
  is '临近网点ID4';
comment on column iqms_new.BC_NEAR.org_id5
  is '临近网点ID5';
comment on column iqms_new.BC_NEAR.org_id6
  is '临近网点ID6';

prompt
prompt Creating table BC_NUMBERFORM
prompt ============================
prompt
create table iqms_new.BC_NUMBERFORM
(
  tktformat_id NUMBER,
  tktformat    VARCHAR2(50),
  org_id       NUMBER,
  device_no    VARCHAR2(20)
)
tablespace IQMS_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 8K
    minextents 1
    maxextents unlimited
  );
comment on column iqms_new.BC_NUMBERFORM.tktformat_id
  is '号码模板的序号ID(唯一)';
comment on column iqms_new.BC_NUMBERFORM.tktformat
  is '号码模板的字符串。格式：业务类型|客户等级|流量位数';
comment on column iqms_new.BC_NUMBERFORM.org_id
  is '机构id （废弃）';
comment on column iqms_new.BC_NUMBERFORM.device_no
  is '设备号  （废弃）';

prompt
prompt Creating table BC_PARAMETER
prompt ===========================
prompt
create table iqms_new.BC_PARAMETER
(
  hb_interval         NUMBER not null,
  authentication_type VARCHAR2(50) not null,
  flow_port           VARCHAR2(10),
  ident_port          VARCHAR2(10),
  http_port           VARCHAR2(10),
  app_root            VARCHAR2(50)
)
tablespace IQMS_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 8K
    minextents 1
    maxextents unlimited
  );
comment on column iqms_new.BC_PARAMETER.hb_interval
  is '心跳间隔（分钟）';
comment on column iqms_new.BC_PARAMETER.authentication_type
  is '鉴权模式 1：远程识别 2：本地识别3：远程+本地按高计算4：远程+本地按低计算';
comment on column iqms_new.BC_PARAMETER.flow_port
  is '流水数据上报端口';
comment on column iqms_new.BC_PARAMETER.ident_port
  is '客户识别端口';
comment on column iqms_new.BC_PARAMETER.http_port
  is '服务端http端口';
comment on column iqms_new.BC_PARAMETER.app_root
  is '工程名称';

prompt
prompt Creating table BC_PATCHVERSION
prompt ==============================
prompt
create table iqms_new.BC_PATCHVERSION
(
  id           NUMBER not null,
  patch_name   VARCHAR2(100) not null,
  patch_md5    VARCHAR2(100),
  patch_path   VARCHAR2(200),
  patch_remark VARCHAR2(1000),
  patch_date   DATE,
  status       VARCHAR2(2),
  patch_verno  VARCHAR2(50),
  intact_flag  VARCHAR2(2),
  db_flag      VARCHAR2(2)
)
tablespace IQMS_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 8K
    minextents 1
    maxextents unlimited
  );
comment on table iqms_new.BC_PATCHVERSION
  is '客户端版本管理表';
comment on column iqms_new.BC_PATCHVERSION.id
  is '更新包id';
comment on column iqms_new.BC_PATCHVERSION.patch_name
  is '更新包名称';
comment on column iqms_new.BC_PATCHVERSION.patch_md5
  is '更新包md5';
comment on column iqms_new.BC_PATCHVERSION.patch_path
  is '更新包位置';
comment on column iqms_new.BC_PATCHVERSION.patch_remark
  is '更新包说明';
comment on column iqms_new.BC_PATCHVERSION.patch_date
  is '更新包日期';
comment on column iqms_new.BC_PATCHVERSION.status
  is '记录状态 0-正常  1-删除';
comment on column iqms_new.BC_PATCHVERSION.patch_verno
  is '手工输入的版本号';
comment on column iqms_new.BC_PATCHVERSION.intact_flag
  is '是否全量包   1-全量   2-增量';
comment on column iqms_new.BC_PATCHVERSION.db_flag
  is '是否包含数据库   1-包含   2-不包含';
alter table iqms_new.BC_PATCHVERSION
  add primary key (ID)
  using index 
  tablespace IQMS_DATA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table BC_QUEUECTRL
prompt ===========================
prompt
create table iqms_new.BC_QUEUECTRL
(
  id    NUMBER not null,
  key   VARCHAR2(20) not null,
  value VARCHAR2(50),
  type  VARCHAR2(10),
  max   VARCHAR2(10)
)
tablespace IQMS_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column iqms_new.BC_QUEUECTRL.id
  is 'ID';
comment on column iqms_new.BC_QUEUECTRL.key
  is '键';
comment on column iqms_new.BC_QUEUECTRL.value
  is '值';
comment on column iqms_new.BC_QUEUECTRL.type
  is '类型';
alter table iqms_new.BC_QUEUECTRL
  add constraint PK_BC_QUEUECTRL primary key (ID)
  using index 
  tablespace IQMS_DATA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table BC_TAKEMODEL
prompt ===========================
prompt
create table iqms_new.BC_TAKEMODEL
(
  styleid   NUMBER not null,
  stylename VARCHAR2(50) not null,
  def       NUMBER not null,
  styletype NUMBER,
  org_id    NUMBER not null,
  device_no VARCHAR2(32) not null
)
tablespace IQMS_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 8K
    minextents 1
    maxextents unlimited
  );
comment on column iqms_new.BC_TAKEMODEL.styleid
  is '取号模板ID';
comment on column iqms_new.BC_TAKEMODEL.stylename
  is '取号模板名称';
comment on column iqms_new.BC_TAKEMODEL.def
  is '是否为默认取号模板。0-否，1-是';
comment on column iqms_new.BC_TAKEMODEL.styletype
  is '模板类型(目前固定为3，win8风格)';
comment on column iqms_new.BC_TAKEMODEL.org_id
  is '机构号';
comment on column iqms_new.BC_TAKEMODEL.device_no
  is '设备号';
alter table iqms_new.BC_TAKEMODEL
  add constraint PK_BC_TAKEMODEL primary key (STYLEID)
  using index 
  tablespace IQMS_DATA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table BC_TELLER
prompt ========================
prompt
create table iqms_new.BC_TELLER
(
  work_id    VARCHAR2(50) not null,
  org_id     NUMBER not null,
  caller_pwd VARCHAR2(50),
  name_      VARCHAR2(50) not null,
  sex        VARCHAR2(5),
  status     VARCHAR2(5) not null
)
tablespace IQMS_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 8K
    minextents 1
    maxextents unlimited
  );
comment on column iqms_new.BC_TELLER.work_id
  is '柜员工号';
comment on column iqms_new.BC_TELLER.org_id
  is '机构ID';
comment on column iqms_new.BC_TELLER.caller_pwd
  is '柜员密码';
comment on column iqms_new.BC_TELLER.name_
  is '柜员名称';
comment on column iqms_new.BC_TELLER.sex
  is '性别（0-女，1-男）';
comment on column iqms_new.BC_TELLER.status
  is '状态（0-无效，1-有效）';
alter table iqms_new.BC_TELLER
  add constraint TELLER_WORKID primary key (WORK_ID)
  using index 
  tablespace IQMS_DATA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table BC_TICKETFORM
prompt ============================
prompt
create table iqms_new.BC_TICKETFORM
(
  tkttmp_id    NUMBER not null,
  tkttmp_name  VARCHAR2(50) not null,
  def          NUMBER not null,
  tktformat_id VARCHAR2(50) not null,
  tktformat    VARCHAR2(50) not null,
  tkttmp_style VARCHAR2(4000),
  org_id       NUMBER,
  device_no    VARCHAR2(20)
)
tablespace IQMS_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 8K
    minextents 1
    maxextents unlimited
  );
comment on column iqms_new.BC_TICKETFORM.tkttmp_id
  is '号票模板的序号ID  唯一';
comment on column iqms_new.BC_TICKETFORM.tkttmp_name
  is '号票名称';
comment on column iqms_new.BC_TICKETFORM.def
  is '是否为默认模板,1-默认，0-不默认';
comment on column iqms_new.BC_TICKETFORM.tktformat_id
  is '号码模板的序号ID';
comment on column iqms_new.BC_TICKETFORM.tktformat
  is '号码模板序号的字符串值（此字段无任何地方引用）';
comment on column iqms_new.BC_TICKETFORM.tkttmp_style
  is '号票样式:json格式，{"print":{.....}}';
comment on column iqms_new.BC_TICKETFORM.org_id
  is '机构ID';
comment on column iqms_new.BC_TICKETFORM.device_no
  is '设备编号';

prompt
prompt Creating table BSC_ADTYPE
prompt =========================
prompt
create table iqms_new.BSC_ADTYPE
(
  org_id      VARCHAR2(20) not null,
  device_no   VARCHAR2(20) not null,
  adv_type    VARCHAR2(20) not null,
  adv_content VARCHAR2(200) not null,
  create_time DATE not null
)
tablespace IQMS_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 8K
    minextents 1
    maxextents unlimited
  );
comment on column iqms_new.BSC_ADTYPE.org_id
  is '机构代码';
comment on column iqms_new.BSC_ADTYPE.device_no
  is '设备号';
comment on column iqms_new.BSC_ADTYPE.adv_type
  is '广告类型：1.条屏 2.综合屏';
comment on column iqms_new.BSC_ADTYPE.adv_content
  is '广告内容';
comment on column iqms_new.BSC_ADTYPE.create_time
  is '创建时间';

prompt
prompt Creating table BSC_BRANCH_BUSINESS
prompt ==================================
prompt
create table iqms_new.BSC_BRANCH_BUSINESS
(
  org_id           NUMBER not null,
  device_no        VARCHAR2(32) not null,
  tree_pid         VARCHAR2(32) not null,
  tree_id          VARCHAR2(32) not null,
  business_code    VARCHAR2(32),
  call_head        VARCHAR2(32),
  prior_time       VARCHAR2(32),
  is_swipe         VARCHAR2(2),
  is_show_en       VARCHAR2(2),
  pick_up_advice   VARCHAR2(100),
  max_pick_up      NUMBER,
  sort_num         VARCHAR2(32),
  extend1          VARCHAR2(32),
  extend2          VARCHAR2(32),
  extend3          VARCHAR2(32),
  business_type    VARCHAR2(10) not null,
  bus_id           NUMBER,
  levelnum         NUMBER,
  business_en_name VARCHAR2(32)
)
tablespace IQMS_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 8K
    minextents 1
    maxextents unlimited
  );
comment on column iqms_new.BSC_BRANCH_BUSINESS.org_id
  is '机构号';
comment on column iqms_new.BSC_BRANCH_BUSINESS.device_no
  is '设备号';
comment on column iqms_new.BSC_BRANCH_BUSINESS.tree_pid
  is '父节点';
comment on column iqms_new.BSC_BRANCH_BUSINESS.tree_id
  is '子节点';
comment on column iqms_new.BSC_BRANCH_BUSINESS.business_code
  is '业务代码';
comment on column iqms_new.BSC_BRANCH_BUSINESS.call_head
  is '呼叫字头';
comment on column iqms_new.BSC_BRANCH_BUSINESS.prior_time
  is '优先时间';
comment on column iqms_new.BSC_BRANCH_BUSINESS.is_swipe
  is '是否刷卡 0：是 1：否';
comment on column iqms_new.BSC_BRANCH_BUSINESS.is_show_en
  is '是否显示英文名 0：是 1：否';
comment on column iqms_new.BSC_BRANCH_BUSINESS.pick_up_advice
  is '取票提示';
comment on column iqms_new.BSC_BRANCH_BUSINESS.max_pick_up
  is '取票上限';
comment on column iqms_new.BSC_BRANCH_BUSINESS.sort_num
  is '排序号';
comment on column iqms_new.BSC_BRANCH_BUSINESS.extend1
  is '扩展字段1';
comment on column iqms_new.BSC_BRANCH_BUSINESS.extend2
  is '扩展字段2';
comment on column iqms_new.BSC_BRANCH_BUSINESS.extend3
  is '扩展字段3';
comment on column iqms_new.BSC_BRANCH_BUSINESS.business_type
  is '菜单-0   业务-1';
comment on column iqms_new.BSC_BRANCH_BUSINESS.bus_id
  is '业务id';
comment on column iqms_new.BSC_BRANCH_BUSINESS.levelnum
  is '菜单等级';
comment on column iqms_new.BSC_BRANCH_BUSINESS.business_en_name
  is '英文名';

prompt
prompt Creating table BSC_COUNTERBUZ
prompt =============================
prompt
create table iqms_new.BSC_COUNTERBUZ
(
  counterid        VARCHAR2(10),
  datetypeid       VARCHAR2(10),
  buztypeid        VARCHAR2(10),
  levelid          VARCHAR2(10),
  buzprioritytime  VARCHAR2(10),
  custprioritytime VARCHAR2(10),
  maxwaiting       VARCHAR2(10),
  org_id           NUMBER,
  device_no        VARCHAR2(32)
)
tablespace IQMS_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 8K
    minextents 1
    maxextents unlimited
  );
comment on column iqms_new.BSC_COUNTERBUZ.counterid
  is '窗口ID';
comment on column iqms_new.BSC_COUNTERBUZ.datetypeid
  is '日期类型。1-工作日，2-假日';
comment on column iqms_new.BSC_COUNTERBUZ.buztypeid
  is '业务类型ID';
comment on column iqms_new.BSC_COUNTERBUZ.levelid
  is '客户等级ID';
comment on column iqms_new.BSC_COUNTERBUZ.buzprioritytime
  is '业务优先时间';
comment on column iqms_new.BSC_COUNTERBUZ.custprioritytime
  is '客户优先时间';
comment on column iqms_new.BSC_COUNTERBUZ.maxwaiting
  is '最大等待时间';
comment on column iqms_new.BSC_COUNTERBUZ.org_id
  is '机构id';
comment on column iqms_new.BSC_COUNTERBUZ.device_no
  is '设备号';

prompt
prompt Creating table BSC_CUST_LEVEL
prompt =============================
prompt
create table iqms_new.BSC_CUST_LEVEL
(
  org_id          NUMBER not null,
  device_no       VARCHAR2(32) not null,
  cust_level      VARCHAR2(10) not null,
  business_id     NUMBER,
  prior_time      VARCHAR2(32),
  call_head       VARCHAR2(32),
  max_wait_time   VARCHAR2(32),
  ticket_template VARCHAR2(32),
  is_start        VARCHAR2(2),
  extend1         VARCHAR2(2),
  extend2         VARCHAR2(2),
  extend3         VARCHAR2(2),
  level_name      VARCHAR2(32)
)
tablespace IQMS_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 8K
    minextents 1
    maxextents unlimited
  );
comment on column iqms_new.BSC_CUST_LEVEL.org_id
  is '机构ID';
comment on column iqms_new.BSC_CUST_LEVEL.device_no
  is '设备号';
comment on column iqms_new.BSC_CUST_LEVEL.cust_level
  is '客户等级';
comment on column iqms_new.BSC_CUST_LEVEL.business_id
  is '绑定的业务ID';
comment on column iqms_new.BSC_CUST_LEVEL.prior_time
  is '优先时间';
comment on column iqms_new.BSC_CUST_LEVEL.call_head
  is '呼叫字头';
comment on column iqms_new.BSC_CUST_LEVEL.max_wait_time
  is '最大等待时间';
comment on column iqms_new.BSC_CUST_LEVEL.ticket_template
  is '号票模板';
comment on column iqms_new.BSC_CUST_LEVEL.is_start
  is '是否启用,1-启用，0-不启用';
comment on column iqms_new.BSC_CUST_LEVEL.level_name
  is '客户等级名称';

prompt
prompt Creating table BSC_CUST_LEVEL_TMP
prompt =================================
prompt
create table iqms_new.BSC_CUST_LEVEL_TMP
(
  org_id          NUMBER not null,
  device_no       VARCHAR2(32) not null,
  cust_level      VARCHAR2(10) not null,
  business_id     NUMBER,
  prior_time      VARCHAR2(32),
  call_head       VARCHAR2(32),
  max_wait_time   VARCHAR2(32),
  ticket_template VARCHAR2(32),
  is_start        VARCHAR2(2),
  extend1         VARCHAR2(2),
  extend2         VARCHAR2(2),
  extend3         VARCHAR2(2),
  level_name      VARCHAR2(32)
)
tablespace IQMS_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 16K
    next 8K
    minextents 1
    maxextents unlimited
  );
comment on column iqms_new.BSC_CUST_LEVEL_TMP.org_id
  is '机构ID';
comment on column iqms_new.BSC_CUST_LEVEL_TMP.device_no
  is '设备号';
comment on column iqms_new.BSC_CUST_LEVEL_TMP.cust_level
  is '客户等级';
comment on column iqms_new.BSC_CUST_LEVEL_TMP.business_id
  is '绑定的业务ID';
comment on column iqms_new.BSC_CUST_LEVEL_TMP.prior_time
  is '优先时间';
comment on column iqms_new.BSC_CUST_LEVEL_TMP.call_head
  is '呼叫字头';
comment on column iqms_new.BSC_CUST_LEVEL_TMP.max_wait_time
  is '最大等待时间';
comment on column iqms_new.BSC_CUST_LEVEL_TMP.ticket_template
  is '号票模板';
comment on column iqms_new.BSC_CUST_LEVEL_TMP.is_start
  is '是否启用,1-启用，0-不启用';
comment on column iqms_new.BSC_CUST_LEVEL_TMP.level_name
  is '客户等级名称';

prompt
prompt Creating table BSC_CUST_RECOGNITION
prompt ===================================
prompt
create table iqms_new.BSC_CUST_RECOGNITION
(
  org_id           NUMBER not null,
  device_no        VARCHAR2(32) not null,
  row_id           NUMBER not null,
  date_type        VARCHAR2(2) not null,
  start_position   VARCHAR2(32) not null,
  mate_length      VARCHAR2(10) not null,
  start_mate_code  VARCHAR2(32) not null,
  end_mate_code    VARCHAR2(32) not null,
  cust_level       VARCHAR2(32) not null,
  extend1          VARCHAR2(32),
  extend2          VARCHAR2(32),
  extend3          VARCHAR2(32),
  recognition_type VARCHAR2(10) not null
)
tablespace IQMS_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 8K
    minextents 1
    maxextents unlimited
  );
comment on column iqms_new.BSC_CUST_RECOGNITION.org_id
  is '机构id';
comment on column iqms_new.BSC_CUST_RECOGNITION.device_no
  is '设备号';
comment on column iqms_new.BSC_CUST_RECOGNITION.row_id
  is '序号';
comment on column iqms_new.BSC_CUST_RECOGNITION.date_type
  is '日期类型 H：假日 N：平日   A:两者都有';
comment on column iqms_new.BSC_CUST_RECOGNITION.start_position
  is '开始位';
comment on column iqms_new.BSC_CUST_RECOGNITION.mate_length
  is '匹配长度';
comment on column iqms_new.BSC_CUST_RECOGNITION.start_mate_code
  is '起始匹配码';
comment on column iqms_new.BSC_CUST_RECOGNITION.end_mate_code
  is '结束匹配码';
comment on column iqms_new.BSC_CUST_RECOGNITION.cust_level
  is '客户等级';
comment on column iqms_new.BSC_CUST_RECOGNITION.recognition_type
  is '识别模式';

prompt
prompt Creating table BSC_DEVICE
prompt =========================
prompt
create table iqms_new.BSC_DEVICE
(
  org_id            NUMBER not null,
  device_no         VARCHAR2(32) not null,
  host_name         VARCHAR2(200),
  ip_addr           VARCHAR2(15) not null,
  mac_addr          VARCHAR2(17),
  producer          VARCHAR2(200),
  install_date      DATE,
  admin_name        VARCHAR2(200),
  admin_phone       VARCHAR2(15),
  online_time       DATE,
  currt_ver         NUMBER,
  currt_vername     VARCHAR2(100),
  last_ver          NUMBER,
  last_vername      VARCHAR2(100),
  net_orgcode       VARCHAR2(10),
  order_flag        VARCHAR2(1),
  extend1           VARCHAR2(100),
  extend2           VARCHAR2(100),
  extend3           VARCHAR2(100),
  screen_resolution VARCHAR2(50),
  online_model      VARCHAR2(10) default 1,
  tpscroll_flag     VARCHAR2(10) default 1
)
tablespace IQMS_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 8K
    minextents 1
    maxextents unlimited
  );
comment on table iqms_new.BSC_DEVICE
  is '排队机设备表：存储排队机的相关信息';
comment on column iqms_new.BSC_DEVICE.org_id
  is '机构代码：机构id';
comment on column iqms_new.BSC_DEVICE.device_no
  is '设备编号：唯一标识一台设备';
comment on column iqms_new.BSC_DEVICE.host_name
  is '主机名：排队机实际的主机名称';
comment on column iqms_new.BSC_DEVICE.ip_addr
  is 'IP地址：排队机的实际IP地址';
comment on column iqms_new.BSC_DEVICE.mac_addr
  is 'MAC 地址：排队机的实际MAC地址';
comment on column iqms_new.BSC_DEVICE.producer
  is '厂商品牌：排队机生产厂商品牌';
comment on column iqms_new.BSC_DEVICE.install_date
  is '安装日期 yyyymmdd：排队机安装的日期';
comment on column iqms_new.BSC_DEVICE.admin_name
  is '管理员姓名：排队机的管理员姓名';
comment on column iqms_new.BSC_DEVICE.admin_phone
  is '管理员电话';
comment on column iqms_new.BSC_DEVICE.online_time
  is '上线时间';
comment on column iqms_new.BSC_DEVICE.currt_ver
  is '当前软件版本号';
comment on column iqms_new.BSC_DEVICE.currt_vername
  is '当前版本名称';
comment on column iqms_new.BSC_DEVICE.last_ver
  is '最新版本号';
comment on column iqms_new.BSC_DEVICE.last_vername
  is '最新版本名称';
comment on column iqms_new.BSC_DEVICE.net_orgcode
  is '本地网编码（安徽使用）';
comment on column iqms_new.BSC_DEVICE.order_flag
  is '是否可以预约  1-可以预约   0-不可以预约';
comment on column iqms_new.BSC_DEVICE.extend1
  is '配置是否有更新   1-有更新    0-无更新';
comment on column iqms_new.BSC_DEVICE.extend2
  is '扩展字段2';
comment on column iqms_new.BSC_DEVICE.extend3
  is '扩展字段3';
comment on column iqms_new.BSC_DEVICE.screen_resolution
  is '分辨率';
comment on column iqms_new.BSC_DEVICE.online_model
  is '1-联网    0-单机';
comment on column iqms_new.BSC_DEVICE.tpscroll_flag
  is '1-条屏滚动   0-直接显示';
alter table iqms_new.BSC_DEVICE
  add primary key (DEVICE_NO)
  disable;

prompt
prompt Creating table BSC_DEVICE_STATUS
prompt ================================
prompt
create table iqms_new.BSC_DEVICE_STATUS
(
  org_id                NUMBER not null,
  device_no             VARCHAR2(32) not null,
  cpu_ratio             VARCHAR2(50),
  mem_ratio             VARCHAR2(50),
  disk_ratio            VARCHAR2(50),
  version_seq           VARCHAR2(50),
  update_date           DATE,
  thermalprinter_status VARCHAR2(50),
  needleprinter_status  VARCHAR2(50),
  idreader_status       VARCHAR2(50),
  swread_status         VARCHAR2(50),
  icreader_status       VARCHAR2(50),
  bar_status            VARCHAR2(50),
  comp_status           VARCHAR2(50)
)
tablespace IQMS_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column iqms_new.BSC_DEVICE_STATUS.org_id
  is '机构号';
comment on column iqms_new.BSC_DEVICE_STATUS.device_no
  is '设备号';
comment on column iqms_new.BSC_DEVICE_STATUS.cpu_ratio
  is 'cpu使用率';
comment on column iqms_new.BSC_DEVICE_STATUS.mem_ratio
  is '内存使用率';
comment on column iqms_new.BSC_DEVICE_STATUS.disk_ratio
  is '磁盘使用率';
comment on column iqms_new.BSC_DEVICE_STATUS.version_seq
  is '版本号';
comment on column iqms_new.BSC_DEVICE_STATUS.update_date
  is '数据更新时间';
comment on column iqms_new.BSC_DEVICE_STATUS.thermalprinter_status
  is '号票打印机 1：正常 3：离线 5：缺纸';
comment on column iqms_new.BSC_DEVICE_STATUS.needleprinter_status
  is '针式打印机1：正常 3：离线';
comment on column iqms_new.BSC_DEVICE_STATUS.idreader_status
  is '身份证1：正常 3：离线';
comment on column iqms_new.BSC_DEVICE_STATUS.swread_status
  is '磁条卡1：正常 3：离线';
comment on column iqms_new.BSC_DEVICE_STATUS.icreader_status
  is 'IC卡1：正常 3：离线';
comment on column iqms_new.BSC_DEVICE_STATUS.bar_status
  is '条屏1：正常 3：离线';
comment on column iqms_new.BSC_DEVICE_STATUS.comp_status
  is '综合屏1：正常 3：离线';

prompt
prompt Creating table BSC_DEVUPGRADE_PROCESS
prompt =====================================
prompt
create table iqms_new.BSC_DEVUPGRADE_PROCESS
(
  id        NUMBER not null,
  device_no VARCHAR2(100) not null,
  patch_id  NUMBER,
  optdate   DATE,
  status    VARCHAR2(2),
  dldate    DATE
)
tablespace IQMS_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on table iqms_new.BSC_DEVUPGRADE_PROCESS
  is '客户端更新过程记录表';
comment on column iqms_new.BSC_DEVUPGRADE_PROCESS.id
  is '记录id，时间的毫秒数';
comment on column iqms_new.BSC_DEVUPGRADE_PROCESS.device_no
  is '设备编号';
comment on column iqms_new.BSC_DEVUPGRADE_PROCESS.patch_id
  is '更新包ID';
comment on column iqms_new.BSC_DEVUPGRADE_PROCESS.optdate
  is '更新包配置到记录的日期';
comment on column iqms_new.BSC_DEVUPGRADE_PROCESS.status
  is '是否已经更新  1-已经更新   0-还未更新';
comment on column iqms_new.BSC_DEVUPGRADE_PROCESS.dldate
  is '客户端更新成功日期';
alter table iqms_new.BSC_DEVUPGRADE_PROCESS
  add primary key (ID)
  using index 
  tablespace IQMS_DATA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table BSC_SETTING
prompt ==========================
prompt
create table iqms_new.BSC_SETTING
(
  id    VARCHAR2(10) not null,
  key   VARCHAR2(50) not null,
  value VARCHAR2(500),
  type  VARCHAR2(10)
)
tablespace IQMS_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 8K
    minextents 1
    maxextents unlimited
  );
comment on column iqms_new.BSC_SETTING.id
  is '元素ID';
comment on column iqms_new.BSC_SETTING.key
  is '元素键名';
comment on column iqms_new.BSC_SETTING.value
  is '元素值';
comment on column iqms_new.BSC_SETTING.type
  is '元素类型';
alter table iqms_new.BSC_SETTING
  add constraint PK_BSC_SETTING primary key (ID)
  using index 
  tablespace IQMS_DATA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table BSC_SHOW_TIME
prompt ============================
prompt
create table iqms_new.BSC_SHOW_TIME
(
  org_id      NUMBER not null,
  device_no   VARCHAR2(32) not null,
  business_id NUMBER not null,
  row_id      VARCHAR2(32) not null,
  date_type   VARCHAR2(10) not null,
  begin_time  VARCHAR2(32) not null,
  end_time    VARCHAR2(32) not null,
  extend1     VARCHAR2(32),
  extend2     VARCHAR2(32),
  extend3     VARCHAR2(32),
  max_num     NUMBER not null
)
tablespace IQMS_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 8K
    minextents 1
    maxextents unlimited
  );
comment on column iqms_new.BSC_SHOW_TIME.org_id
  is '机构id';
comment on column iqms_new.BSC_SHOW_TIME.device_no
  is '设备号';
comment on column iqms_new.BSC_SHOW_TIME.business_id
  is '业务id';
comment on column iqms_new.BSC_SHOW_TIME.row_id
  is '序号';
comment on column iqms_new.BSC_SHOW_TIME.date_type
  is '时间类型 H:holiday 假日，N：normal 平时';
comment on column iqms_new.BSC_SHOW_TIME.begin_time
  is '开始时间';
comment on column iqms_new.BSC_SHOW_TIME.end_time
  is '结束时间';
comment on column iqms_new.BSC_SHOW_TIME.max_num
  is '时间段内取号数量限制';

prompt
prompt Creating table BSC_WIN_BUS
prompt ==========================
prompt
create table iqms_new.BSC_WIN_BUS
(
  org_id             NUMBER not null,
  device_no          VARCHAR2(32) not null,
  win_no             VARCHAR2(32) not null,
  buz_priority_time  NUMBER,
  cust_priority_time NUMBER,
  max_waiting        NUMBER,
  level_id           NUMBER,
  buz_type_id        NUMBER,
  data_type_id       NUMBER,
  extend1            VARCHAR2(32),
  extend2            VARCHAR2(32),
  extend3            VARCHAR2(32)
)
tablespace IQMS_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 8K
    minextents 1
    maxextents unlimited
  );
comment on column iqms_new.BSC_WIN_BUS.org_id
  is '机构id';
comment on column iqms_new.BSC_WIN_BUS.device_no
  is '设备号';
comment on column iqms_new.BSC_WIN_BUS.win_no
  is '窗口号';
comment on column iqms_new.BSC_WIN_BUS.buz_priority_time
  is '业务优先时间';
comment on column iqms_new.BSC_WIN_BUS.cust_priority_time
  is '等级优先时间';
comment on column iqms_new.BSC_WIN_BUS.max_waiting
  is '最大等待时间';
comment on column iqms_new.BSC_WIN_BUS.level_id
  is '等级ID';
comment on column iqms_new.BSC_WIN_BUS.buz_type_id
  is '业务ID';
comment on column iqms_new.BSC_WIN_BUS.data_type_id
  is '日期类型：1 ：平日 、2：假日';

prompt
prompt Creating table BSC_WIN_CONFIG
prompt =============================
prompt
create table iqms_new.BSC_WIN_CONFIG
(
  org_id          NUMBER not null,
  device_no       VARCHAR2(32) not null,
  win_no          VARCHAR2(32) not null,
  is_call         VARCHAR2(2),
  is_judge        VARCHAR2(2),
  win_screen      VARCHAR2(32),
  multiple_screen VARCHAR2(32),
  is_start        VARCHAR2(2),
  extend1         VARCHAR2(32),
  extend2         VARCHAR2(32),
  extend3         VARCHAR2(32),
  row_id          NUMBER not null,
  win_id          VARCHAR2(10) not null
)
tablespace IQMS_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 8K
    minextents 1
    maxextents unlimited
  );
comment on column iqms_new.BSC_WIN_CONFIG.org_id
  is '机构代码：机构id';
comment on column iqms_new.BSC_WIN_CONFIG.device_no
  is '设备编号：唯一标识一台设备';
comment on column iqms_new.BSC_WIN_CONFIG.win_no
  is '窗口编号';
comment on column iqms_new.BSC_WIN_CONFIG.is_call
  is '是否有呼叫器：0、否 1、是 ';
comment on column iqms_new.BSC_WIN_CONFIG.is_judge
  is '是否有评价器：0、否 1、是';
comment on column iqms_new.BSC_WIN_CONFIG.win_screen
  is '窗口屏';
comment on column iqms_new.BSC_WIN_CONFIG.multiple_screen
  is '综合屏幕';
comment on column iqms_new.BSC_WIN_CONFIG.is_start
  is '是否启用：0、否 1、是';
comment on column iqms_new.BSC_WIN_CONFIG.row_id
  is '序号';
comment on column iqms_new.BSC_WIN_CONFIG.win_id
  is '窗口编号ID，与窗口编号一致';

prompt
prompt Creating table CUSTCOME_RECORD
prompt ==============================
prompt
create table iqms_new.CUSTCOME_RECORD
(
  org_id            NUMBER not null,
  cust_no           VARCHAR2(50) not null,
  cust_name         VARCHAR2(50),
  cust_sex          VARCHAR2(50),
  cert_type         VARCHAR2(2),
  cert_content      VARCHAR2(50),
  cust_phone        VARCHAR2(50),
  cust_assets       VARCHAR2(22),
  cust_deposit      VARCHAR2(22),
  cust_financial    VARCHAR2(22),
  cust_foundation   VARCHAR2(22),
  cust_nationaldebt VARCHAR2(22),
  cust_insurance    VARCHAR2(22),
  cust_level        VARCHAR2(22),
  come_dt           DATE
)
tablespace IQMS_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 8K
    minextents 1
    maxextents unlimited
  );
comment on column iqms_new.CUSTCOME_RECORD.org_id
  is '机构ID';
comment on column iqms_new.CUSTCOME_RECORD.cust_no
  is '客户号';
comment on column iqms_new.CUSTCOME_RECORD.cust_name
  is '客户姓名';
comment on column iqms_new.CUSTCOME_RECORD.cust_sex
  is '客户性别  F-女   M-男';
comment on column iqms_new.CUSTCOME_RECORD.cert_type
  is '证件类型  01-卡   02-身份证';
comment on column iqms_new.CUSTCOME_RECORD.cert_content
  is '证件内容';
comment on column iqms_new.CUSTCOME_RECORD.cust_phone
  is '客户手机号';
comment on column iqms_new.CUSTCOME_RECORD.cust_assets
  is '客户资产';
comment on column iqms_new.CUSTCOME_RECORD.cust_deposit
  is '客户存款';
comment on column iqms_new.CUSTCOME_RECORD.cust_financial
  is '客户理财';
comment on column iqms_new.CUSTCOME_RECORD.cust_foundation
  is '客户基金';
comment on column iqms_new.CUSTCOME_RECORD.cust_nationaldebt
  is '客户国债';
comment on column iqms_new.CUSTCOME_RECORD.cust_insurance
  is '客户保险';
comment on column iqms_new.CUSTCOME_RECORD.cust_level
  is '客户级别';
comment on column iqms_new.CUSTCOME_RECORD.come_dt
  is '来访日期';

prompt
prompt Creating table ORDER_INFO
prompt =========================
prompt
create table iqms_new.ORDER_INFO
(
  org_code      VARCHAR2(50) not null,
  dev_no        VARCHAR2(50) not null,
  act_no        VARCHAR2(10),
  order_busid   VARCHAR2(10),
  order_buscode VARCHAR2(10),
  cert_type     VARCHAR2(20),
  cert_content  VARCHAR2(50),
  order_date    VARCHAR2(10) not null,
  order_time    VARCHAR2(20),
  range_begin   VARCHAR2(30) not null,
  range_end     VARCHAR2(20) not null,
  order_status  VARCHAR2(2) not null,
  opertate_date VARCHAR2(20) not null,
  modify_date   VARCHAR2(20),
  order_id      NUMBER not null,
  ticket_no     VARCHAR2(20)
)
tablespace IQMS_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 8K
    minextents 1
    maxextents unlimited
  );
comment on table iqms_new.ORDER_INFO
  is '预约记录表';
comment on column iqms_new.ORDER_INFO.org_code
  is '机构号';
comment on column iqms_new.ORDER_INFO.dev_no
  is '设备号';
comment on column iqms_new.ORDER_INFO.act_no
  is '激活码：4位激活码';
comment on column iqms_new.ORDER_INFO.order_busid
  is '预约业务ID';
comment on column iqms_new.ORDER_INFO.order_buscode
  is '预约业务编码：A,B,C,D';
comment on column iqms_new.ORDER_INFO.cert_type
  is '1-手机号   2-身份证号';
comment on column iqms_new.ORDER_INFO.cert_content
  is '证件内容';
comment on column iqms_new.ORDER_INFO.order_date
  is '客户预约日期:2016-10-11';
comment on column iqms_new.ORDER_INFO.order_time
  is '客户预约时间点:9:11（预留）';
comment on column iqms_new.ORDER_INFO.range_begin
  is '客户预约时间段：开始时间-10:00';
comment on column iqms_new.ORDER_INFO.range_end
  is '客户预约时间段：结束时间-11:30';
comment on column iqms_new.ORDER_INFO.order_status
  is '预约状态： 0-未激活   1-已激活    2-取消 3-失效 4-未知';
comment on column iqms_new.ORDER_INFO.opertate_date
  is '操作日期';
comment on column iqms_new.ORDER_INFO.modify_date
  is '修改日期';
comment on column iqms_new.ORDER_INFO.order_id
  is '预约ID';
comment on column iqms_new.ORDER_INFO.ticket_no
  is '打印票号';

prompt
prompt Creating table ORDER_RANGE
prompt ==========================
prompt
create table iqms_new.ORDER_RANGE
(
  id         NUMBER not null,
  org_code   VARCHAR2(50) not null,
  device_no  VARCHAR2(50) not null,
  begin_time VARCHAR2(50) not null,
  end_time   VARCHAR2(100) not null,
  ordercount NUMBER not null
)
tablespace IQMS_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 8K
    minextents 1
    maxextents unlimited
  );
comment on table iqms_new.ORDER_RANGE
  is '预约时间段表';
comment on column iqms_new.ORDER_RANGE.id
  is '主键';
comment on column iqms_new.ORDER_RANGE.org_code
  is '机构编码';
comment on column iqms_new.ORDER_RANGE.device_no
  is '设备号';
comment on column iqms_new.ORDER_RANGE.begin_time
  is '开始时间';
comment on column iqms_new.ORDER_RANGE.end_time
  is '结束时间';
comment on column iqms_new.ORDER_RANGE.ordercount
  is '预约数量';

prompt
prompt Creating table ORG_MAP
prompt ======================
prompt
create table iqms_new.ORG_MAP
(
  org_code_old VARCHAR2(100),
  org_code_new VARCHAR2(100),
  org_name_old VARCHAR2(200),
  org_name_new VARCHAR2(200)
)
tablespace IQMS_DATA
  pctfree 10
  initrans 1
  maxtrans 255;

prompt
prompt Creating table SYS_BEHAVIOR_LOG
prompt ===============================
prompt
create table iqms_new.SYS_BEHAVIOR_LOG
(
  behavior_id  NUMBER(8) not null,
  session_id   VARCHAR2(100) not null,
  logged_date  TIMESTAMP(3) not null,
  action       VARCHAR2(128),
  data_changed NUMBER(1) not null
)
partition by range(LOGGED_DATE) interval(numtoyminterval (1,'month'))
(partition part1 values less than (to_date('2018-01-01','YYYY-MM-DD'))
);
alter table iqms_new.SYS_BEHAVIOR_LOG
  add constraint PK_SYS_BEHAVIOR_LOG primary key (BEHAVIOR_ID)
  using index 
  tablespace IQMS_DATA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table SYS_DATA_LOG
prompt ===========================
prompt
create table iqms_new.SYS_DATA_LOG
(
  behavior_id NUMBER(8) not null,
  logged_date TIMESTAMP(3) not null,
  table_name  VARCHAR2(32) not null,
  column_name VARCHAR2(32) not null,
  key_value   NUMBER(8) not null,
  old_value   VARCHAR2(512),
  new_value   VARCHAR2(512)
)
tablespace IQMS_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table SYS_DIC
prompt ======================
prompt
create table iqms_new.SYS_DIC
(
  dic_id            NUMBER(8) not null,
  dic_name          VARCHAR2(64) not null,
  dic_key           VARCHAR2(32) not null,
  dic_value         VARCHAR2(128) not null,
  dic_type          VARCHAR2(32) not null,
  dic_symbol        VARCHAR2(128),
  created_by        NUMBER(8) not null,
  created_date      TIMESTAMP(3) not null,
  last_updated_by   NUMBER(8) not null,
  last_updated_date TIMESTAMP(3) not null
)
tablespace IQMS_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table iqms_new.SYS_DIC
  add constraint PK_SYS_DIC primary key (DIC_ID)
  using index 
  tablespace IQMS_DATA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table SYS_FUN
prompt ======================
prompt
create table iqms_new.SYS_FUN
(
  fun_id            NUMBER(8) not null,
  fun_name          VARCHAR2(64) not null,
  parent_id         NUMBER(8) not null,
  sort_num          NUMBER(3) not null,
  level_num         NUMBER(1) not null,
  deleted           NUMBER(1) not null,
  created_by        NUMBER(8),
  created_date      TIMESTAMP(3),
  last_updated_by   NUMBER(8),
  last_updated_date TIMESTAMP(3)
)
tablespace IQMS_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table iqms_new.SYS_FUN
  add constraint PK_SYS_FUN primary key (FUN_ID)
  using index 
  tablespace IQMS_DATA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table SYS_FUN_URL
prompt ==========================
prompt
create table iqms_new.SYS_FUN_URL
(
  fun_id NUMBER(8) not null,
  url_id NUMBER(8) not null
)
tablespace IQMS_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table SYS_LOGIN_LOG
prompt ============================
prompt
create table iqms_new.SYS_LOGIN_LOG
(
  session_id     VARCHAR2(100) not null,
  user_id        NUMBER(8) not null,
  username       VARCHAR2(32) not null,
  real_name      VARCHAR2(32) not null,
  ip             VARCHAR2(16) not null,
  org_id         NUMBER(8) not null,
  org_name       VARCHAR2(64) not null,
  inherited_name VARCHAR2(512) not null,
  login_date     TIMESTAMP(3) not null,
  logout_date    TIMESTAMP(3),
  os             VARCHAR2(32),
  browser        VARCHAR2(32),
  user_agent     VARCHAR2(256)
)
tablespace IQMS_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 8K
    minextents 1
    maxextents unlimited
  );
alter table iqms_new.SYS_LOGIN_LOG
  add constraint SYS_LOGIN_LOG primary key (SESSION_ID)
  using index 
  tablespace IQMS_DATA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table SYS_MENU
prompt =======================
prompt
create table iqms_new.SYS_MENU
(
  menu_id           NUMBER(8) not null,
  menu_name         VARCHAR2(64) not null,
  menu_url          VARCHAR2(64),
  icon              VARCHAR2(16),
  parent_id         NUMBER(8) not null,
  fun_id            NUMBER(8) not null,
  sort_num          NUMBER(3) not null,
  level_num         NUMBER(1) not null,
  deleted           NUMBER(1) not null,
  created_by        NUMBER(8),
  created_date      TIMESTAMP(3),
  last_updated_by   NUMBER(8),
  last_updated_date TIMESTAMP(3)
)
tablespace IQMS_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table iqms_new.SYS_MENU
  add constraint PK_SYS_MENU primary key (MENU_ID)
  using index 
  tablespace IQMS_DATA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table SYS_ORG
prompt ======================
prompt
create table iqms_new.SYS_ORG
(
  org_id            NUMBER(8) not null,
  org_code          VARCHAR2(16) not null,
  org_name          VARCHAR2(64) not null,
  parent_id         NUMBER(8) not null,
  inherited_id      VARCHAR2(128) not null,
  inherited_name    VARCHAR2(512) not null,
  sort_num          NUMBER(4) not null,
  level_num         NUMBER(2) not null,
  tel               VARCHAR2(16),
  address           VARCHAR2(128),
  remark            VARCHAR2(128),
  deleted           NUMBER(1) not null,
  created_by        NUMBER(8) not null,
  created_date      TIMESTAMP(3) not null,
  last_updated_by   NUMBER(8) not null,
  last_updated_date TIMESTAMP(3) not null
)
tablespace IQMS_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 8K
    minextents 1
    maxextents unlimited
  );
alter table iqms_new.SYS_ORG
  add constraint PK_SYS_ORG primary key (ORG_ID)
  using index 
  tablespace IQMS_DATA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table SYS_ROLE
prompt =======================
prompt
create table iqms_new.SYS_ROLE
(
  role_id           NUMBER(8) not null,
  role_name         VARCHAR2(64) not null,
  role_type         NUMBER(1) not null,
  org_id            NUMBER(8),
  remark            VARCHAR2(128),
  deleted           NUMBER(1) not null,
  created_by        NUMBER(8) not null,
  created_date      TIMESTAMP(3) not null,
  last_updated_by   NUMBER(8) not null,
  last_updated_date TIMESTAMP(3) not null
)
tablespace IQMS_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table iqms_new.SYS_ROLE
  add constraint PK_SYS_ROLE primary key (ROLE_ID)
  using index 
  tablespace IQMS_DATA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table iqms_new.SYS_ROLE
  add constraint UK_SYS_ROLE unique (ROLE_NAME, ORG_ID)
  using index 
  tablespace IQMS_DATA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table SYS_ROLE_FUN
prompt ===========================
prompt
create table iqms_new.SYS_ROLE_FUN
(
  role_id NUMBER(8) not null,
  fun_id  NUMBER(8) not null
)
tablespace IQMS_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table SYS_ROLE_USER
prompt ============================
prompt
create table iqms_new.SYS_ROLE_USER
(
  role_id NUMBER(8) not null,
  user_id NUMBER(8) not null
)
tablespace IQMS_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table SYS_URL
prompt ======================
prompt
create table iqms_new.SYS_URL
(
  url_id              NUMBER(8) not null,
  url_name            VARCHAR2(64),
  url_pattern         VARCHAR2(64) not null,
  http_method         VARCHAR2(8) not null,
  action_code         VARCHAR2(32),
  args_code           VARCHAR2(64),
  logged_data_changed NUMBER(1) not null,
  created_by          NUMBER(8),
  created_date        TIMESTAMP(3),
  last_updated_by     NUMBER(8),
  last_updated_date   TIMESTAMP(3)
)
tablespace IQMS_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table iqms_new.SYS_URL
  add constraint PK_SYS_URL primary key (URL_ID)
  using index 
  tablespace IQMS_DATA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table SYS_USER
prompt =======================
prompt
create table iqms_new.SYS_USER
(
  user_id           NUMBER(8) not null,
  username          VARCHAR2(32) not null,
  real_name         VARCHAR2(64) not null,
  pwd               CHAR(32) not null,
  org_id            NUMBER(8) not null,
  locked            NUMBER(1) not null,
  error_time        NUMBER(2),
  age               NUMBER(3),
  birthday          TIMESTAMP(3),
  phone             VARCHAR2(16),
  mobile            VARCHAR2(16),
  email             VARCHAR2(64),
  address           VARCHAR2(128),
  remark            VARCHAR2(128),
  user_pic_data     BLOB,
  user_pic_suffix   VARCHAR2(16),
  about             CLOB,
  last_login_date   TIMESTAMP(3),
  last_login_ip     VARCHAR2(16),
  deleted           NUMBER(1) not null,
  created_by        NUMBER(8) not null,
  created_date      TIMESTAMP(3) not null,
  last_updated_by   NUMBER(8) not null,
  last_updated_date TIMESTAMP(3) not null
)
tablespace IQMS_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table iqms_new.SYS_USER
  add constraint PK_SYS_USER primary key (USER_ID)
  using index 
  tablespace IQMS_DATA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table iqms_new.SYS_USER
  add constraint UK_SYS_USER unique (USERNAME)
  using index 
  tablespace IQMS_DATA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table SYS_USER_BAK
prompt ===========================
prompt
create table iqms_new.SYS_USER_BAK
(
  user_id           NUMBER(8) not null,
  username          VARCHAR2(32) not null,
  real_name         VARCHAR2(64) not null,
  pwd               CHAR(32) not null,
  org_id            NUMBER(8) not null,
  locked            NUMBER(1) not null,
  error_time        NUMBER(2),
  age               NUMBER(3),
  birthday          TIMESTAMP(3),
  phone             VARCHAR2(16),
  mobile            VARCHAR2(16),
  email             VARCHAR2(64),
  address           VARCHAR2(128),
  remark            VARCHAR2(128),
  user_pic_data     BLOB,
  user_pic_suffix   VARCHAR2(16),
  about             CLOB,
  last_login_date   TIMESTAMP(3),
  last_login_ip     VARCHAR2(16),
  deleted           NUMBER(1) not null,
  created_by        NUMBER(8) not null,
  created_date      TIMESTAMP(3) not null,
  last_updated_by   NUMBER(8) not null,
  last_updated_date TIMESTAMP(3) not null
)
tablespace IQMS_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table TRX_HISTORY
prompt ==========================
prompt
create table iqms_new.TRX_HISTORY
(
  org_id          INTEGER not null,
  device_no       VARCHAR2(32) not null,
  trx_date        DATE not null,
  flow_no         VARCHAR2(100) not null,
  bus_id          VARCHAR2(20) not null,
  bus_type        VARCHAR2(3) not null,
  cust_type       VARCHAR2(10),
  pdj_level       INTEGER,
  ticket_type     VARCHAR2(2),
  ticket_no       VARCHAR2(10) not null,
  cust_id         VARCHAR2(30),
  card_type       VARCHAR2(5),
  card_no         VARCHAR2(200),
  manager_no      VARCHAR2(30),
  trx_type        INTEGER,
  trx_status      INTEGER,
  print_time      DATE,
  call_time       DATE,
  begin_time      DATE,
  end_time        DATE,
  app_value       INTEGER default 0 not null,
  win_no          INTEGER,
  teller_no       VARCHAR2(20),
  recall_count    INTEGER,
  pause_begintime VARCHAR2(20),
  pause_endtime   VARCHAR2(20),
  call_type       VARCHAR2(2),
  transfer_count  INTEGER,
  buz_flag        VARCHAR2(10),
  extend1         VARCHAR2(30),
  extend2         VARCHAR2(30),
  extend3         VARCHAR2(30)
)
partition by range(trx_date) interval(numtoyminterval (1,'month'))
(partition part1 values less than (to_date('2018-01-01','YYYY-MM-DD'))
);
comment on column iqms_new.TRX_HISTORY.org_id
  is '机构ID';
comment on column iqms_new.TRX_HISTORY.device_no
  is '设备编号';
comment on column iqms_new.TRX_HISTORY.trx_date
  is '交易日期';
comment on column iqms_new.TRX_HISTORY.flow_no
  is '主键（唯一字段，机构号+设备号+取号时间+排队号）';
comment on column iqms_new.TRX_HISTORY.bus_id
  is '业务ID';
comment on column iqms_new.TRX_HISTORY.bus_type
  is '业务编码';
comment on column iqms_new.TRX_HISTORY.cust_type
  is '客户类型';
comment on column iqms_new.TRX_HISTORY.pdj_level
  is '系统等级1-9';
comment on column iqms_new.TRX_HISTORY.ticket_type
  is '取票类型：手工取票0，刷二代证取票1，刷卡取票2，刷存折3，预约取号4，远程取号5，输入号码取票6，固话取票7，宽带拨号账号取票8。';
comment on column iqms_new.TRX_HISTORY.ticket_no
  is '排队号';
comment on column iqms_new.TRX_HISTORY.cust_id
  is '客户号';
comment on column iqms_new.TRX_HISTORY.card_type
  is ' 刷卡类型  0 无；1 身份证；2 卡；3存折';
comment on column iqms_new.TRX_HISTORY.card_no
  is '-- 卡的内容 ：客户识别号码：（和客户刷卡类型一起标识客户）银行卡号，身份证号等  ';
comment on column iqms_new.TRX_HISTORY.manager_no
  is '-- 大堂经理号';
comment on column iqms_new.TRX_HISTORY.trx_type
  is '状态：1-取号；2-叫号；3-办理结束';
comment on column iqms_new.TRX_HISTORY.trx_status
  is '号票状态：1：正常等候 ，2：正在办理 ，3：完成，4：弃号，5：转移；6：锁号；7：延后，8：插前。';
comment on column iqms_new.TRX_HISTORY.print_time
  is '取号日期';
comment on column iqms_new.TRX_HISTORY.call_time
  is '叫号日期';
comment on column iqms_new.TRX_HISTORY.begin_time
  is '业务开始办理时间';
comment on column iqms_new.TRX_HISTORY.end_time
  is '业务办理完成时间';
comment on column iqms_new.TRX_HISTORY.app_value
  is '评价值：0:未评价，默认值，1:不满意，2:一般，3:满意，仅当【交易状态】为“2”时有意义。';
comment on column iqms_new.TRX_HISTORY.win_no
  is '办理窗口';
comment on column iqms_new.TRX_HISTORY.teller_no
  is '柜员号';
comment on column iqms_new.TRX_HISTORY.recall_count
  is '重呼次数';
comment on column iqms_new.TRX_HISTORY.pause_begintime
  is '暂停开始时间';
comment on column iqms_new.TRX_HISTORY.pause_endtime
  is '暂停结束时间';
comment on column iqms_new.TRX_HISTORY.call_type
  is '呼叫类型：1:顺呼; 2:重呼; 3:指呼; 4:特呼';
comment on column iqms_new.TRX_HISTORY.transfer_count
  is '转移次数';
comment on column iqms_new.TRX_HISTORY.buz_flag
  is '业务扩展标记';
alter table iqms_new.TRX_HISTORY
  add primary key (ORG_ID, DEVICE_NO, TRX_DATE, FLOW_NO)
  using index 
  tablespace IQMS_DATA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table TRX_TODAY
prompt ========================
prompt
create table iqms_new.TRX_TODAY
(
  org_id          INTEGER not null,
  device_no       VARCHAR2(32) not null,
  trx_date        DATE not null,
  flow_no         VARCHAR2(100) not null,
  bus_id          VARCHAR2(20) not null,
  bus_type        VARCHAR2(3) not null,
  cust_type       VARCHAR2(10),
  pdj_level       INTEGER,
  ticket_type     VARCHAR2(2),
  ticket_no       VARCHAR2(10) not null,
  cust_id         VARCHAR2(30),
  card_type       VARCHAR2(5),
  card_no         VARCHAR2(200),
  manager_no      VARCHAR2(30),
  trx_type        INTEGER,
  trx_status      INTEGER,
  print_time      DATE,
  call_time       DATE,
  begin_time      DATE,
  end_time        DATE,
  app_value       INTEGER default 0 not null,
  win_no          INTEGER,
  teller_no       VARCHAR2(20),
  recall_count    INTEGER,
  pause_begintime VARCHAR2(20),
  pause_endtime   VARCHAR2(20),
  call_type       VARCHAR2(2),
  transfer_count  INTEGER,
  buz_flag        VARCHAR2(10),
  extend1         VARCHAR2(30),
  extend2         VARCHAR2(30),
  extend3         VARCHAR2(30)
)
partition by range(trx_date) interval(numtoyminterval (1,'month'))
(partition part1 values less than (to_date('2018-01-01','YYYY-MM-DD'))
);
comment on column iqms_new.TRX_TODAY.org_id
  is '机构ID';
comment on column iqms_new.TRX_TODAY.device_no
  is '设备编号';
comment on column iqms_new.TRX_TODAY.trx_date
  is '交易日期';
comment on column iqms_new.TRX_TODAY.flow_no
  is '主键（唯一字段，机构号+设备号+取号时间+排队号）';
comment on column iqms_new.TRX_TODAY.bus_id
  is '业务ID';
comment on column iqms_new.TRX_TODAY.bus_type
  is '业务编码';
comment on column iqms_new.TRX_TODAY.cust_type
  is '客户类型-银行的系统分级';
comment on column iqms_new.TRX_TODAY.pdj_level
  is '系统等级1-9';
comment on column iqms_new.TRX_TODAY.ticket_type
  is '取票类型：手工取票0，刷二代证取票1，刷卡取票2，刷存折3，预约取号4，远程取号5，输入号码取票6，固话取票7，宽带拨号账号取票8。';
comment on column iqms_new.TRX_TODAY.ticket_no
  is '排队号';
comment on column iqms_new.TRX_TODAY.cust_id
  is '客户号';
comment on column iqms_new.TRX_TODAY.card_type
  is ' 刷卡类型  0 无；1 身份证；2 卡；3存折';
comment on column iqms_new.TRX_TODAY.card_no
  is '-- 卡的内容 ：客户识别号码：（和客户刷卡类型一起标识客户）银行卡号，身份证号等  ';
comment on column iqms_new.TRX_TODAY.manager_no
  is '-- 大堂经理号';
comment on column iqms_new.TRX_TODAY.trx_type
  is '状态：1-取号；2-叫号；3-办理结束';
comment on column iqms_new.TRX_TODAY.trx_status
  is '号票状态：1-正常等候，2-正在办理 ，3-完成，4-弃号，5-转移；6-锁号；7-延后，8-插前。';
comment on column iqms_new.TRX_TODAY.print_time
  is '取号日期';
comment on column iqms_new.TRX_TODAY.call_time
  is '叫号日期';
comment on column iqms_new.TRX_TODAY.begin_time
  is '业务开始办理时间';
comment on column iqms_new.TRX_TODAY.end_time
  is '业务办理完成时间';
comment on column iqms_new.TRX_TODAY.app_value
  is '评价值：0:未评价，默认值1:不满意2:一般3:满意';
comment on column iqms_new.TRX_TODAY.win_no
  is '办理窗口';
comment on column iqms_new.TRX_TODAY.teller_no
  is '柜员号';
comment on column iqms_new.TRX_TODAY.recall_count
  is '重呼次数';
comment on column iqms_new.TRX_TODAY.pause_begintime
  is '暂停开始时间';
comment on column iqms_new.TRX_TODAY.pause_endtime
  is '暂停结束时间';
comment on column iqms_new.TRX_TODAY.call_type
  is '呼叫类型：1:顺呼; 2:重呼; 3:指呼; 4:特呼';
comment on column iqms_new.TRX_TODAY.transfer_count
  is '转移次数';
comment on column iqms_new.TRX_TODAY.buz_flag
  is '业务扩展标记';
alter table iqms_new.TRX_TODAY
  add primary key (ORG_ID, DEVICE_NO, TRX_DATE, FLOW_NO)
  using index 
  tablespace IQMS_DATA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating sequence SEQ_BCBUSINESSMANAGE
prompt ======================================
prompt
create sequence iqms_new.SEQ_BCBUSINESSMANAGE
minvalue 1
maxvalue 99999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_BCMENU
prompt ============================
prompt
create sequence iqms_new.SEQ_BCMENU
minvalue 1
maxvalue 99999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_BCNUMBERFORM
prompt ==================================
prompt
create sequence iqms_new.SEQ_BCNUMBERFORM
minvalue 1
maxvalue 99999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_BCPATCHVERSION
prompt ====================================
prompt
create sequence iqms_new.SEQ_BCPATCHVERSION
minvalue 1
maxvalue 99999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_BCTAKEMODEL
prompt =================================
prompt
create sequence iqms_new.SEQ_BCTAKEMODEL
minvalue 1
maxvalue 9999999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_BCTICKETFORM
prompt ==================================
prompt
create sequence iqms_new.SEQ_BCTICKETFORM
minvalue 1
maxvalue 999999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_DEVICE
prompt ============================
prompt
create sequence iqms_new.SEQ_DEVICE
minvalue 1
maxvalue 99999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_MODELSTYLEID
prompt ==================================
prompt
create sequence iqms_new.SEQ_MODELSTYLEID
minvalue 1
maxvalue 99999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_ORDERINFO
prompt ===============================
prompt
create sequence iqms_new.SEQ_ORDERINFO
minvalue 1
maxvalue 999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_ORDERRANGE
prompt ================================
prompt
create sequence iqms_new.SEQ_ORDERRANGE
minvalue 1
maxvalue 99999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_SYS_BEHAVIOR_LOG
prompt ======================================
prompt
create sequence iqms_new.SEQ_SYS_BEHAVIOR_LOG
minvalue 1
maxvalue 9999999999999999999999999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_SYS_DIC
prompt =============================
prompt
create sequence iqms_new.SEQ_SYS_DIC
minvalue 1
maxvalue 99999999
start with 1
increment by 1
cache 2;

prompt
prompt Creating sequence SEQ_SYS_MENU
prompt ==============================
prompt
create sequence iqms_new.SEQ_SYS_MENU
minvalue 1
maxvalue 99999999
start with 1
increment by 1
cache 2;

prompt
prompt Creating sequence SEQ_SYS_ORG
prompt =============================
prompt
create sequence iqms_new.SEQ_SYS_ORG
minvalue 1
maxvalue 99999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_SYS_ROLE
prompt ==============================
prompt
create sequence iqms_new.SEQ_SYS_ROLE
minvalue 1
maxvalue 99999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_SYS_URL
prompt =============================
prompt
create sequence iqms_new.SEQ_SYS_URL
minvalue 1
maxvalue 99999999
start with 1
increment by 1
cache 2;

prompt
prompt Creating sequence SEQ_SYS_USER
prompt ==============================
prompt
create sequence iqms_new.SEQ_SYS_USER
minvalue 1
maxvalue 99999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_UPGRADEPROCESS
prompt ====================================
prompt
create sequence iqms_new.SEQ_UPGRADEPROCESS
minvalue 1
maxvalue 99999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating view VIEW_BUSMENU
prompt ==========================
prompt
create or replace view iqms_new.view_busmenu as
select "BUSINESS_ID","BUSINESS_NAME","BUS_TYPE",business_en_name from (
select m.menu_id business_id, m.menu_name business_name, '0' bus_type,m.menu_enname business_en_name from bc_menu m
union all
select bm.business_id,bm.business_name,'1' bus_type, bm.business_ename business_en_name from bc_businessmanage bm);

prompt
prompt Creating view VIEW_DEVTREE
prompt ==========================
prompt
create or replace view iqms_new.view_devtree as
select "ID","DEVICENO","PID","DEVNAME","ISDEV","CURRTVER","LASTVER","CURRTNAME","LASTNAME","SCREEN" from (select to_char(o.org_id) id,'' deviceNo,to_char(o.parent_id) pid,o.org_name devName, '' isDev, -1 currtVer, -1 lastVer, ''currtName, '' lastName,'' screen from sys_org o
  union all
  select 'D'||d.device_no id,
         d.device_no deviceNo,
         to_char(d.org_id) pid,
         case when d.producer is not null then '【'||d.producer || '】' || d.host_name else '【null】'||d.host_name end devName,
         '1' isDev,
         d.currt_ver currtVer,
         d.last_ver lastVer,
         d.currt_vername currtName,
         d.last_vername lastName,
         d.screen_resolution screen
    from bsc_device d ) tmp;

prompt
prompt Creating view VIEW_TICKETTREE
prompt =============================
prompt
create or replace view iqms_new.view_tickettree as
select "ID","DEVICENO","PID","DEVNAME","ISDEV","CURRTVER","LASTVER","CURRTNAME","LASTNAME","TKTTMPID" from (
select to_char(o.org_id) id,'' deviceNo,to_char(o.parent_id) pid,o.org_name devName, '' isDev, -1 currtVer, -1 lastVer, ''currtName, '' lastName,-1 tktTmpId from sys_org o
  union all
  select 'D'||d.device_no id,
         d.device_no deviceNo,
         to_char(d.org_id) pid,
         case when d.producer is not null then '【'||d.producer || '】' || d.host_name else '【null】'||d.host_name end devName,
         '1' isDev,
         d.currt_ver currtVer,
         d.last_ver lastVer,
         d.currt_vername currtName,
         d.last_vername lastName,
         t.tkttmp_id tktTmpId
    from bsc_device d , bc_ticketform t
                 where d.device_no = t.device_no
                   and t.def = '1') tmp;

prompt
prompt Creating view VIEW_WINMONITOR
prompt =============================
prompt
create or replace view iqms_new.view_winmonitor as
select t.rowid rid,
       row_number() over(PARTITION BY t.win_no order by t.call_time desc) rnum,
       t.flow_no flowNoDone,--上一个已完成的
       t.app_value app,
       tmp."ORG_ID",
       tmp."DEVICE_NO",
       tmp."TRX_DATE",
       tmp."FLOW_NO" flowNo,--正在办理的
       tmp."BUS_ID",
       tmp."BUS_TYPE",
       tmp."CUST_TYPE",
       tmp."PDJ_LEVEL",
       tmp."TICKET_TYPE",
       tmp."TICKET_NO",
       tmp."CUST_ID",
       tmp."CARD_TYPE",
       tmp."CARD_NO",
       tmp."MANAGER_NO",
       tmp."TRX_TYPE",
       tmp."TRX_STATUS",
       tmp."PRINT_TIME",
       tmp."CALL_TIME",
       tmp."BEGIN_TIME",
       tmp."END_TIME",
       tmp."APP_VALUE",
       tmp."WIN_NO",
       tmp."TELLER_NO",
       tmp."RECALL_COUNT",
       tmp."PAUSE_BEGINTIME",
       tmp."PAUSE_ENDTIME",
       tmp."CALL_TYPE",
       tmp."TRANSFER_COUNT",
       tmp."BUZ_FLAG",
       tmp."EXTEND1",
       tmp."EXTEND2",
       tmp."EXTEND3",
       tmp.WIN_STATUS
  from trx_today t
 inner join (select h.*,
                    case
                      when w.is_start = '0' then
                       '关闭'
                      else
                       '开启'
                    end WIN_STATUS
               from trx_today h
               left join bsc_win_config w
                 on (h.device_no = w.device_no and h.win_no = w.win_no)
              where h.trx_status = '2'
                and trunc(h.trx_date) = trunc(sysdate) and h.call_time in (
                select max(tt.call_time) from trx_today tt where tt.trx_status = '2'
                group by tt.device_no,tt.win_no
                )
                ) tmp
    on (t.win_no = tmp.win_no and t.device_no = tmp.device_no and
       t.trx_date = tmp.trx_date and t.call_time < tmp.call_time)
 where t.trx_status = '3';

prompt
prompt Creating function GET_DIC_VALUE
prompt ===============================
prompt
create or replace function iqms_new.GET_DIC_VALUE(P_DIC_TYPE IN VARCHAR2,P_DIC_KEY IN VARCHAR2)
return varchar2
is
   V_DIC_VALUE VARCHAR2(64);
begin
  SELECT DIC_VALUE INTO V_DIC_VALUE FROM SYS_DIC WHERE P_DIC_TYPE = DIC_TYPE AND P_DIC_KEY = DIC_KEY;
  return(V_DIC_VALUE);
end GET_DIC_VALUE;
/

prompt
prompt Creating function GET_FUN_NAME
prompt ==============================
prompt
CREATE OR REPLACE FUNCTION iqms_new.GET_FUN_NAME(P_FUN_ID IN NUMBER) RETURN VARCHAR2 IS
  V_FUN_NAME VARCHAR2(64);
BEGIN
  SELECT FUN_NAME INTO V_FUN_NAME FROM SYS_FUN WHERE FUN_ID = P_FUN_ID;
  RETURN(V_FUN_NAME);
END GET_FUN_NAME;
/

prompt
prompt Creating function GET_ORG_INHERITEDNAME
prompt =======================================
prompt
CREATE OR REPLACE FUNCTION iqms_new.GET_ORG_INHERITEDNAME(P_ORG_ID IN NUMBER) RETURN VARCHAR2 IS
  V_ORG_INHERITEDNAME VARCHAR2(512);
BEGIN

  SELECT INHERITED_NAME INTO V_ORG_INHERITEDNAME FROM SYS_ORG WHERE ORG_ID = P_ORG_ID;

  RETURN(V_ORG_INHERITEDNAME);

END GET_ORG_INHERITEDNAME;
/

prompt
prompt Creating function GET_ORG_NAME
prompt ==============================
prompt
CREATE OR REPLACE FUNCTION iqms_new.GET_ORG_NAME(P_ORG_ID IN NUMBER) RETURN VARCHAR2 IS
  V_ORG_NAME VARCHAR2(64);
BEGIN

  SELECT ORG_NAME INTO V_ORG_NAME FROM SYS_ORG WHERE ORG_ID = P_ORG_ID;

  RETURN(V_ORG_NAME);

END GET_ORG_NAME;
/

prompt
prompt Creating function GET_ORG_PARENTNAME
prompt ====================================
prompt
CREATE OR REPLACE FUNCTION iqms_new.GET_ORG_PARENTNAME(P_PARENT_ID IN NUMBER) RETURN VARCHAR2 IS
  V_PARENT_NAME VARCHAR2(64);
BEGIN

  SELECT ORG_NAME INTO V_PARENT_NAME FROM SYS_ORG WHERE ORG_ID = P_PARENT_ID;

  RETURN(V_PARENT_NAME);

END GET_ORG_PARENTNAME;
/

prompt
prompt Creating function GET_REAL_NAME
prompt ===============================
prompt
CREATE OR REPLACE FUNCTION iqms_new.GET_REAL_NAME(P_USER_ID IN NUMBER) RETURN VARCHAR2 IS
  V_REAL_NAME VARCHAR2(64);
BEGIN

  SELECT REAL_NAME INTO V_REAL_NAME FROM SYS_USER WHERE USER_ID = P_USER_ID;

  RETURN(V_REAL_NAME);

END GET_REAL_NAME;
/

prompt
prompt Creating function GET_USERNAME
prompt ==============================
prompt
CREATE OR REPLACE FUNCTION iqms_new.GET_USERNAME(P_USER_ID IN NUMBER) RETURN VARCHAR2 IS
  V_USERNAME VARCHAR2(64);
BEGIN

  SELECT USERNAME INTO V_USERNAME FROM SYS_USER WHERE USER_ID = P_USER_ID;

  RETURN(V_USERNAME);

END GET_USERNAME;
/

prompt
prompt Creating procedure PROC_ADS_SAVE
prompt ================================
prompt
create or replace procedure iqms_new.proc_ads_save
(
orgId in  number,
deviceNo in  varchar2,
advType in  varchar2,
advContent in  varchar2,
ReturnCode out varchar2

)
is

begin
           insert into bsc_adtype b (
              b.ORG_ID,
              b.DEVICE_NO,
              b.adv_type,
              b.adv_content,
              b.CREATE_TIME
           )values(
              orgId,
              deviceNo,
              advType,
              advContent,
              sysdate
           );

            ReturnCode:='0';
end proc_ads_save;
/

prompt
prompt Creating procedure PROC_ADS_SELECT
prompt ==================================
prompt
create or replace procedure iqms_new.proc_ads_select
(
orgId in  number,
deviceNo in  varchar2,
p_cursor out sys_refcursor
)
is
  v_sql varchar2(4000);
  v_orgid varchar2(50) := orgId;
  v_deviceNo varchar2(50) := deviceNo;
begin
   v_sql := 'select t.*,d.ip_addr
  from (select row_number() over(partition by b.adv_type order by b.create_time desc) rnum,
       b.*
  from bsc_adtype b
 where b.org_id =:v_orgid
   and b.device_no =:v_deviceNo) t
               inner join
               bsc_device d on (d.device_no = t.device_no)
 where t.rnum = 1';

   OPEN p_cursor FOR v_sql using v_orgid,v_deviceNo;

end proc_ads_select;
/

prompt
prompt Creating procedure PROC_DEVICEUPDATEFLAG
prompt ========================================
prompt
create or replace procedure iqms_new.proc_deviceupdateflag
(
 deviceNo in  varchar2,
 upFlage in varchar2 -- 1全部设备更新    0-只更新deviceNo的设备
)
is



begin

  if   upFlage = 1 then

       update bsc_device d set d.extend1 = 1;

  else

       update bsc_device d set d.extend1 = 1 where d.device_no = deviceNo;

  end if;




   --异常处理
   -- exception
    --   when others then
     --  ReturnCode:='1'; --数据库异常
end proc_deviceupdateflag;
/

prompt
prompt Creating procedure PROC_BCBUSMANAGE_ADD
prompt =======================================
prompt
CREATE OR REPLACE PROCEDURE iqms_new.proc_bcbusmanage_add
(
 businessName varchar2,
 businessEName varchar2,

 averageTime varchar2 ,
 orderFlag varchar2 ,
 ReturnCode OUT varchar2
)
AS
iRecCount INTEGER;
eCount INTEGER;
BEGIN

 --查询要增加的记录是否存在
 select count(1) into iRecCount from bc_businessmanage t where t.business_name = businessName;
 select count(1) into eCount from bc_businessmanage t where t.business_ename = businessEName;
 if iRecCount > 0 then
   ReturnCode:='2'; --该中文名已经存在
 elsif eCount>0 then
  ReturnCode:='3'; --该英文名已经存在
 else
   --插入
   insert into bc_businessmanage t (
      BUSINESS_ID,
      BUSINESS_NAME,
      BUSINESS_ENAME,
      AVERAGE_TIME,
      ORDER_FLAG
   ) values (
     SEQ_BCMENU.NEXTVAL,
     businessName,
     businessEName,
     averageTime,
     orderFlag
   );
   ReturnCode:='0';
   proc_deviceupdateflag('','1');
 end if;
 --异常处理
 -- exception
   --   when others then
     --  ReturnCode:='1'; --数据库异常
END proc_bcbusmanage_add;
/

prompt
prompt Creating procedure PROC_BCBUSMANAGE_ALL
prompt =======================================
prompt
create or replace procedure iqms_new.proc_bcbusmanage_all (
businessId varchar2,
p_cursor out sys_refcursor
)
as
   v_sql_condition varchar2(4000);

begin
---------------------------------------------------------1.按条件查询数据 start------------------------------------------------------------------

  v_sql_condition := ' select BUSINESS_ID,BUSINESS_NAME,AVERAGE_TIME,ORDER_FLAG from bc_businessmanage h where 1=1  ';

  OPEN p_cursor FOR v_sql_condition;


end proc_bcbusmanage_all;
/

prompt
prompt Creating procedure PROC_BCBUSMANAGE_EDIT
prompt ========================================
prompt
CREATE OR REPLACE PROCEDURE iqms_new.proc_bcbusmanage_edit
(
 businessId varchar2,
 businessName varchar2,
 businessEName varchar2,
 averageTime varchar2 ,
 orderFlag varchar2 ,
 ReturnCode OUT varchar2
)
AS
iRecCount INTEGER;
eCount INTEGER;
BEGIN
   select count(1) into iRecCount from bc_businessmanage t where t.business_name = businessName and t.business_id <> businessId;

 if iRecCount > 0 then
   ReturnCode:='2'; --该中文名已经存在
 else
   update bc_businessmanage t set
      t.BUSINESS_ID = businessId,
      t.BUSINESS_NAME =businessName,
      t.business_ename = businessEName,
      t.AVERAGE_TIME = averageTime,
      t.ORDER_FLAG = orderFlag
   where t.BUSINESS_ID = businessId;
proc_deviceupdateflag('','1');
   ReturnCode:='0';
   end if;
 --异常处理
 -- exception
   --   when others then
     --  ReturnCode:='1'; --数据库异常
END proc_bcbusmanage_edit;
/

prompt
prompt Creating procedure PROC_BCBUSMANAGE_PAGE
prompt ========================================
prompt
create or replace procedure iqms_new.proc_bcbusmanage_page (
businessName varchar2, --业务名称
orderfield in varchar2,--排序字段
ordertype in varchar2,--排序类型（方向：顺序、倒序）
pagesize in number,--每页大小
pageno in number,--当前页码
totalrows out number,--总记录数
p_cursor out sys_refcursor
)
as
   v_sql varchar2(4000);
   v_sql_page varchar2(4000);
   v_sql_condition varchar2(4000);
   v_sql_count varchar2(4000);
   v_begin number := (pageno-1)*pagesize+1;
   v_end number := pageno*pagesize;
   v_sort varchar2(50);
   v_businessName varchar2(50) := businessName;

begin
---------------------------------------------------------1.按条件查询数据 start------------------------------------------------------------------

  v_sql_condition := ' select BUSINESS_ID,BUSINESS_NAME,BUSINESS_ENAME,AVERAGE_TIME,ORDER_FLAG,h.rowId rid from bc_businessmanage h where 1=1  ';


  if v_businessName is not null then
     v_sql_condition := v_sql_condition || ' and h.BUSINESS_NAME like ''%''||:businessName||''%''';
   else

     v_businessName := '@#$&^%$#@!';
     v_sql_condition := v_sql_condition || ' and ( h.BUSINESS_NAME  is null or h.BUSINESS_NAME <>:businessName)';

  end if;


  -------------------------------------------------2.包裹按条件查询的语句，进行分页 开始------------------------------------------------------------
  if (orderfield is null) then
      v_sort := 'BUSINESS_ID ';
  else
      v_sort := orderfield||' '||ordertype;
  end if;

 --select result
 v_sql := 'select row_number() over ( order by '||v_sort||',rid) rnum,tt.BUSINESS_ID,
  tt.BUSINESS_NAME,
  tt.BUSINESS_ENAME,
  tt.AVERAGE_TIME,
  tt.ORDER_FLAG
   from ('||v_sql_condition||') tt ';

   --select count
  v_sql_count := 'select count(1) from ('||v_sql||')';


------------------------------------------------------------3.判断是分页还是查询列表

   if pageno > 0  then
    v_sql_page := 'select * from ('||v_sql||') temp where temp.rnum >= :v_begin and temp.rnum <= :v_end';
     execute immediate v_sql_count into totalrows using v_businessName;
     OPEN p_cursor FOR v_sql_page using  v_businessName,v_begin,v_end;
  else
    totalrows:=0; --set default value
    v_sql_page := 'select * from ('||v_sql||') temp ';
    OPEN p_cursor FOR v_sql_page using  v_businessName;
  end if;

end proc_bcbusmanage_page;
/

prompt
prompt Creating procedure PROC_BCBUSMANAGE_REMOVE
prompt ==========================================
prompt
CREATE OR REPLACE PROCEDURE iqms_new.proc_bcbusmanage_remove
(
 businessId varchar2,
 ReturnCode OUT varchar2
)
AS
iRecCount INTEGER;
BEGIN

   delete from  bc_businessmanage t where t.BUSINESS_ID = businessId;
   --级联删除网点业务
   delete from bsc_branch_business b where b.bus_id = businessId
   and b.business_type = '1';
   --级联删除【叫号策略】
   delete from bsc_counterbuz s where s.buztypeid = businessId ;
   --级联删除【业务显示】
   delete from bsc_show_time b where b.business_id =  businessId;
   --级联删除【取号界面】
   delete from bc_modelstyle_element m where m.element_type = 'buzType'
   and m.buztype_id = businessId;
   --级联更新【客户级别】 绑定业务为不绑定
   update bsc_cust_level c set c.business_id = null
   where c.business_id = businessId;
    proc_deviceupdateflag('','1');
   ReturnCode:='0';
 --异常处理
 -- exception
   --   when others then
     --  ReturnCode:='1'; --数据库异常
END proc_bcbusmanage_remove;
/

prompt
prompt Creating procedure PROC_BCCUSINFO_ADD
prompt =====================================
prompt
CREATE OR REPLACE PROCEDURE iqms_new.proc_bccusinfo_add
(
 orgId varchar2,
 custId varchar2,
 custName varchar2 ,
 custLevel varchar2 ,
 custPdut varchar2 ,
 custAd varchar2 ,
 isBankEftve varchar2 ,
 ReturnCode OUT varchar2
)
AS
iRecCount INTEGER;
BEGIN

 --查询要增加的记录是否存在
 select count(1) into iRecCount from bc_cusinfo t where t.CUST_ID = custId;

 if iRecCount > 0 then
   ReturnCode:='2'; --该客户类型已经存在
 else
   --插入
   insert into bc_cusinfo t (
      ORG_ID,
      CUST_ID,
      CUST_NAME,
      CUST_LEVEL,
      CUST_PDUT,
      CUST_AD,
      ISBANK_EFTVE
   ) values (
     orgId,
     custId,
     custName,
     custLevel,
     custPdut,
     custAd,
     isBankEftve
   );
   ReturnCode:='0';
 end if;
 --异常处理
 -- exception
   --   when others then
     --  ReturnCode:='1'; --数据库异常
END proc_bccusinfo_add;
/

prompt
prompt Creating procedure PROC_BCCUSINFO_ADD_FILE
prompt ==========================================
prompt
CREATE OR REPLACE PROCEDURE iqms_new.proc_bccusinfo_add_file
(
 orgCode varchar2,
 custId varchar2,
 custName varchar2 ,
 custLevel varchar2 ,
 custPdut varchar2 ,
 custAd varchar2 ,
 isBankEftve varchar2 ,
 ReturnCode OUT varchar2
)
AS
iRecCount INTEGER;
orgId INTEGER;
BEGIN

 --查询要增加的记录是否存在
 select count(1) into iRecCount from bc_cusinfo t where t.CUST_ID = custId;
 select o.org_id into orgId from sys_org o where o.org_code = orgCode;

 if iRecCount > 0 then
   ReturnCode:='2'; --该客户类型已经存在
 else
   --插入
   insert into bc_cusinfo t (
      ORG_ID,
      CUST_ID,
      CUST_NAME,
      CUST_LEVEL,
      CUST_PDUT,
      CUST_AD,
      ISBANK_EFTVE
   ) values (
     orgId,
     custId,
     custName,
     custLevel,
     custPdut,
     custAd,
     isBankEftve
   );
   ReturnCode:='0';
 end if;
 --异常处理
 -- exception
   --   when others then
     --  ReturnCode:='1'; --数据库异常
END proc_bccusinfo_add_file;
/

prompt
prompt Creating procedure PROC_BCCUSINFO_EDIT
prompt ======================================
prompt
CREATE OR REPLACE PROCEDURE iqms_new.proc_bccusinfo_edit
(
 orgId varchar2,
 custId varchar2,
 custName varchar2 ,
 custLevel varchar2 ,
 custPdut varchar2 ,
 custAd varchar2 ,
 isBankEftve varchar2 ,
 ReturnCode OUT varchar2
)
AS
iRecCount INTEGER;
BEGIN

   update bc_cusinfo t set
      t.ORG_ID = orgId,
      t.CUST_ID = custId,
      t.CUST_NAME = custName,
      t.CUST_LEVEL = custLevel,
      t.CUST_PDUT = custPdut,
      t.CUST_AD = custAd,
      t.ISBANK_EFTVE = isBankEftve
   where t.CUST_ID = custId;

   ReturnCode:='0';
 --异常处理
 -- exception
   --   when others then
     --  ReturnCode:='1'; --数据库异常
END proc_bccusinfo_edit;
/

prompt
prompt Creating procedure PROC_BCCUSINFO_PAGE
prompt ======================================
prompt
create or replace procedure iqms_new.proc_bccusinfo_page (
orgId in varchar2,
custId in varchar2,
custName in varchar2,
custLevel in varchar2,
orderfield in varchar2,
ordertype in varchar2,
pagesize in number, pageno in number,totalrows out number,p_cursor out sys_refcursor)
as
   v_sql varchar2(4000);
   v_sql_page varchar2(4000);
   v_sql_condition varchar2(2000);
   v_sql_count varchar2(4000);
   v_begin number := (pageno-1)*pagesize+1;
   v_end number := pageno*pagesize;
   v_sort varchar2(50);

   v_orgid varchar2(50) := orgId;
   v_custid varchar2(50) := custId;
   v_custname varchar2(50) := custName;
   v_custlevel varchar2(50) := custLevel;

begin

  ---------------------------------------------------------1.按条件查询数据 start------------------------------------------------------------------

  v_sql_condition := 'select
                      h.ORG_ID,
                      og.ORG_CODE,
                      og.ORG_NAME,
                      h.CUST_ID,
                      h.CUST_NAME,
                      h.CUST_LEVEL,
                      b.CUST_NAME CUS_NAME,
                      h.CUST_PDUT,
                      h.CUST_AD,
                      h.ISBANK_EFTVE,
                      h.rowId rid
                      from BC_CUSINFO h
  inner join (select * from sys_org o where o.deleted=0  start with o.org_id =:v_orgid
  connect by prior o.org_id = o.parent_id) og on (h.ORG_ID=og.ORG_ID)
  inner join BC_CUSTTYPE b on (h.CUST_LEVEL = b.CUST_LEVEL) where 1=1';

  --其他查询条件
  if v_custid is not null then
     v_sql_condition := v_sql_condition || ' and h.CUST_ID like ''%''||:custId ||''%''';
   else
     v_custid := '@#$&^%$#@!';
     v_sql_condition := v_sql_condition || ' and ( h.CUST_ID  is null or h.CUST_ID <>:custId)';

  end if;

   if v_custname is not null then
     v_sql_condition := v_sql_condition || ' and h.CUST_NAME like ''%''||:custName ||''%''';
   else
     v_custname := '@#$&^%$#@!';
     v_sql_condition := v_sql_condition || ' and ( h.CUST_NAME  is null or h.CUST_NAME <>:custName)';

  end if;

   if v_custlevel is not null then
     v_sql_condition := v_sql_condition || ' and h.CUST_LEVEL = :custLevel ';
   else
     v_custlevel := '@#$&^%$#@!';
     v_sql_condition := v_sql_condition || ' and ( h.CUST_LEVEL  is null or h.CUST_LEVEL <>:custLevel)';

  end if;


-------------------------------------------------2.包裹按条件查询的语句，进行分页 开始------------------------------------------------------------
  if (orderfield is null) then
      v_sort := 'ORG_ID ';
  else
      v_sort := orderfield||' '||ordertype;
  end if;

 --select result
 v_sql := 'select row_number() over ( order by '||v_sort||',rid) rnum,
     tt.ORG_ID,
    tt.ORG_CODE,
    tt.ORG_NAME,
    tt.CUST_ID,
    tt.CUST_NAME,
    tt.CUST_LEVEL,
    tt.CUS_NAME,
    tt.CUST_PDUT,
    tt.CUST_AD,
    tt.ISBANK_EFTVE
   from ('||v_sql_condition||') tt ';

   --select count
  v_sql_count := 'select count(1) from ('||v_sql||')';

------------------------------------------------------------3.判断是分页还是查询列表

   if pageno > 0  then
    v_sql_page := 'select * from ('||v_sql||') temp where temp.rnum >= :v_begin and temp.rnum <= :v_end';
     execute immediate v_sql_count into totalrows using v_orgid,v_custid,v_custname,v_custlevel;
     OPEN p_cursor FOR v_sql_page using  v_orgid,v_custid,v_custname,v_custlevel,v_begin,v_end;
  else
    totalrows:=0; --set default value
    v_sql_page := 'select * from ('||v_sql||') temp ';
    OPEN p_cursor FOR v_sql_page using  v_orgid,v_custid,v_custname,v_custlevel;
  end if;

end proc_bccusinfo_page;
/

prompt
prompt Creating procedure PROC_BCCUSINFO_REMOVE
prompt ========================================
prompt
CREATE OR REPLACE PROCEDURE iqms_new.proc_bccusinfo_remove
(
 custId varchar2,
 ReturnCode OUT varchar2
)
AS
iRecCount INTEGER;
BEGIN

   delete from  bc_cusinfo t where t.CUST_ID = custId;

   ReturnCode:='0';
 --异常处理
 -- exception
   --   when others then
     --  ReturnCode:='1'; --数据库异常
END proc_bccusinfo_remove;
/

prompt
prompt Creating procedure PROC_BCCUSTTYPE_ADD
prompt ======================================
prompt
CREATE OR REPLACE PROCEDURE iqms_new.proc_bccusttype_add
(
 custLevel varchar2,
 custName varchar2,
 vipFlag varchar2 ,
 smsFlag varchar2 ,
 waitTimeout varchar2,
 presentFlag varchar2,
 isUse varchar2,
 v_expend1 varchar2,
 v_expend2 varchar2,
 v_expend3 varchar2,
 ReturnCode OUT varchar2
)
AS
iRecCount INTEGER;
eCount INTEGER;
BEGIN

 --查询要增加的记录是否存在
 select count(1) into iRecCount from bc_custtype t where t.cust_level = custLevel;
 select count(1) into eCount  from bc_custtype t where t.cust_name = custName;
 if iRecCount > 0 then
   ReturnCode:='2';--该客户类型已经存在
 elsif eCount> 0 then
   ReturnCode:='3'; --该客户类型已经存在
 else
   --插入
   insert into bc_custtype t (
      CUST_LEVEL,
      CUST_NAME,
      VIP_FLAG,
      SMS_FLAG,
      WAIT_TIMEOUT,
      PRESENT_FLAG,
      IS_USE,
      EXTEND1,
      EXTEND2,
      EXTEND3
   ) values (
     custLevel,
     custName,
     vipFlag,
     smsFlag,
      waitTimeout,
      presentFlag,
      isUse,
      v_expend1,
      v_expend2,
      v_expend3
   );
   ReturnCode:='0';
 end if;
 --异常处理
 -- exception
   --   when others then
     --  ReturnCode:='1'; --数据库异常
END proc_bccusttype_add;
/

prompt
prompt Creating procedure PROC_BCCUSTTYPE_EDIT
prompt =======================================
prompt
CREATE OR REPLACE PROCEDURE iqms_new.proc_bccusttype_edit
(
 custLevel varchar2,
 cusName varchar2,
 vipFlag varchar2 ,
 smsFlag varchar2 ,
 waitTimeout varchar2,
 presentFlag varchar2,
 isUse varchar2,
 v_expend1 varchar2,
 v_expend2 varchar2,
 v_expend3 varchar2,
 ReturnCode OUT varchar2
)
AS
iRecCount INTEGER;
BEGIN

   update bc_custtype t set
      t.CUST_LEVEL = custLevel,
      t.CUST_NAME =cusName,
      t.VIP_FLAG = vipFlag,
      t.SMS_FLAG = smsFlag,
      t.WAIT_TIMEOUT = waitTimeout,
      t.PRESENT_FLAG = presentFlag,
      t.IS_USE = isUse,
      t.EXTEND1 = v_expend1,
      t.EXTEND2 = v_expend2,
      t.EXTEND3 = v_expend3
   where t.cust_level = custLevel;

   ReturnCode:='0';
 --异常处理
 -- exception
   --   when others then
     --  ReturnCode:='1'; --数据库异常
END proc_bccusttype_edit;
/

prompt
prompt Creating procedure PROC_BCCUSTTYPE_PAGE
prompt =======================================
prompt
create or replace procedure iqms_new.proc_bccusttype_page (
custName varchar2, --类型名称

orderfield in varchar2,
ordertype in varchar2,
pagesize in number, pageno in number,totalrows out number,p_cursor out sys_refcursor)
as
   v_sql varchar2(4000);
   v_sql_page varchar2(4000);
   v_sql_condition varchar2(4000);
   v_sql_count varchar2(4000);
   v_begin number := (pageno-1)*pagesize+1;
   v_end number := pageno*pagesize;
   v_sort varchar2(50);
   v_custName varchar2(50) := custName;

begin
---------------------------------------------------------1.按条件查询数据 start------------------------------------------------------------------

  v_sql_condition := ' select CUST_LEVEL,h.rowId rid,CUST_NAME,VIP_FLAG,SMS_FLAG,WAIT_TIMEOUT,
                     PRESENT_FLAG,IS_USE,EXTEND1,EXTEND2,EXTEND3 from bc_custtype h where 1=1  ';


  if v_custName is not null then
     v_sql_condition := v_sql_condition || ' and h.cust_name like ''%''||:custName||''%''';
   else
     v_custName := '@#$&^%$#@!';
     v_sql_condition := v_sql_condition || ' and ( h.cust_name  is null or h.cust_name <>:custName)';

  end if;


  -------------------------------------------------2.包裹按条件查询的语句，进行分页 开始------------------------------------------------------------
  if (orderfield is null) then
      v_sort := 'cust_level ';
  else
      v_sort := orderfield||' '||ordertype;
  end if;

 --select result
 v_sql := 'select row_number() over ( order by '||v_sort||',rid) rnum,tt.CUST_LEVEL,
  tt.CUST_NAME,
  tt.VIP_FLAG,
  tt.SMS_FLAG,
  tt.WAIT_TIMEOUT,
  tt.PRESENT_FLAG,
  tt.IS_USE,
  tt.EXTEND1,
  tt.EXTEND2,
  tt.EXTEND3
   from ('||v_sql_condition||') tt ';

   --select count
  v_sql_count := 'select count(1) from ('||v_sql||')';


------------------------------------------------------------3.判断是分页还是查询列表

   if pageno > 0  then
    v_sql_page := 'select * from ('||v_sql||') temp where temp.rnum >= :v_begin and temp.rnum <= :v_end';
     execute immediate v_sql_count into totalrows using v_custName;
     OPEN p_cursor FOR v_sql_page using  v_custName,v_begin,v_end;
  else
    totalrows:=0; --set default value
    v_sql_page := 'select * from ('||v_sql||') temp ';
    OPEN p_cursor FOR v_sql_page using  v_custName;
  end if;

end proc_bccusttype_page;
/

prompt
prompt Creating procedure PROC_BCCUSTTYPE_REMOVE
prompt =========================================
prompt
CREATE OR REPLACE PROCEDURE iqms_new.proc_bccusttype_remove
(
 custLevel varchar2,
 ReturnCode OUT varchar2
)
AS
iRecCount INTEGER;
BEGIN

   delete from  bc_custtype t where t.cust_level = custLevel;

   ReturnCode:='0';
 --异常处理
 -- exception
   --   when others then
     --  ReturnCode:='1'; --数据库异常
END proc_bccusttype_remove;
/

prompt
prompt Creating procedure PROC_BCMENU_ADD
prompt ==================================
prompt
CREATE OR REPLACE PROCEDURE iqms_new.proc_bcmenu_add
(
 menuName varchar2,
 menuEnName varchar2 ,
 v_expend1 varchar2,
 ReturnCode OUT varchar2
)
AS
iRecCount INTEGER;
eCount INTEGER;
BEGIN

 --查询要增加的记录是否存在
 select count(1) into iRecCount from bc_menu t where t.menu_name = menuName;
 select count(1) into eCount from bc_menu t where t.menu_enname = menuEnName;

 if iRecCount > 0 then
   ReturnCode:='2'; --该客户类型已经存在
 elsif eCount>0 then
 ReturnCode:='3';
 else
   --插入
   insert into bc_menu t (
      MENU_ID,
      MENU_NAME,
      MENU_ENNAME,
      EXTEND1
   ) values (
     SEQ_BCMENU.NEXTVAL,
     menuName,
     menuEnName,
      v_expend1
   );
   --update bsc_device b set b.extend1 = '1';
   proc_deviceupdateflag('','1');
   ReturnCode:='0';
 end if;
 --异常处理
 -- exception
   --   when others then
     --  ReturnCode:='1'; --数据库异常
END proc_bcmenu_add;
/

prompt
prompt Creating procedure PROC_BCMENU_EDIT
prompt ===================================
prompt
CREATE OR REPLACE PROCEDURE iqms_new.proc_bcmenu_edit
(
 menuId varchar2,
 menuName varchar2,
 menuEnName varchar2 ,
 v_expend1 varchar2,
 ReturnCode OUT varchar2
)
AS
iRecCount1 INTEGER;
iRecCount2 INTEGER;
BEGIN
--查询要增加的记录是否存在
 select count(1) into iRecCount1 from bc_menu t where t.menu_name = menuName
  and t.menu_id != menuId;

  select count(1) into iRecCount2 from bc_menu t where t.menu_enname = menuEnName
  and t.menu_id != menuId;
   if iRecCount1 > 0 then
   ReturnCode:='2'; --该客户名称已经存在

   elsif iRecCount2 > 0 then
   ReturnCode:='3'; --该客户英文名已经存在
 else
   update bc_menu t set
      t.MENU_ID = menuId,
      t.MENU_NAME =menuName,
      t.MENU_ENNAME = menuEnName,
      t.EXTEND1 = v_expend1
   where t.MENU_ID = menuId;
    --update bsc_device b set b.extend1 = '1';
    proc_deviceupdateflag('','1');
   ReturnCode:='0';
   end if;

 --异常处理
 -- exception
   --   when others then
     --  ReturnCode:='1'; --数据库异常
END proc_bcmenu_edit;
/

prompt
prompt Creating procedure PROC_BCMENU_PAGE
prompt ===================================
prompt
create or replace procedure iqms_new.proc_bcmenu_page (
menuName varchar2, --类型名称

orderfield in varchar2,
ordertype in varchar2,
pagesize in number, pageno in number,totalrows out number,p_cursor out sys_refcursor)
as
   v_sql varchar2(4000);
   v_sql_page varchar2(4000);
   v_sql_condition varchar2(4000);
   v_sql_count varchar2(4000);
   v_begin number := (pageno-1)*pagesize+1;
   v_end number := pageno*pagesize;
   v_sort varchar2(50);
   v_menuName varchar2(50) := menuName;

begin
---------------------------------------------------------1.按条件查询数据 start------------------------------------------------------------------

  v_sql_condition := ' select MENU_ID,h.rowId rid,MENU_NAME,MENU_ENNAME,EXTEND1 from bc_menu h where 1=1  ';


  if v_menuName is not null then
     v_sql_condition := v_sql_condition || ' and h.menu_name like ''%''||:menuName||''%''';
   else
     v_menuName := '@#$&^%$#@!';
     v_sql_condition := v_sql_condition || ' and ( h.menu_name  is null or h.menu_name <>:menuName)';

  end if;


  -------------------------------------------------2.包裹按条件查询的语句，进行分页 开始------------------------------------------------------------
  if (orderfield is null) then
      v_sort := 'menu_name ';
  else
      v_sort := orderfield||' '||ordertype;
  end if;

 --select result
 v_sql := 'select row_number() over ( order by '||v_sort||',rid) rnum,tt.MENU_ID,
  tt.MENU_NAME,
  tt.MENU_ENNAME,
  tt.EXTEND1
  from ('||v_sql_condition||') tt ';

   --select count
  v_sql_count := 'select count(1) from ('||v_sql||')';


------------------------------------------------------------3.判断是分页还是查询列表

   if pageno > 0  then
    v_sql_page := 'select * from ('||v_sql||') temp where temp.rnum >= :v_begin and temp.rnum <= :v_end';
     execute immediate v_sql_count into totalrows using v_menuName;
     OPEN p_cursor FOR v_sql_page using  v_menuName,v_begin,v_end;
  else
    totalrows:=0; --set default value
    v_sql_page := 'select * from ('||v_sql||') temp ';
    OPEN p_cursor FOR v_sql_page using  v_menuName;
  end if;

end proc_bcmenu_page;
/

prompt
prompt Creating procedure PROC_BCMENU_QUERY
prompt ====================================
prompt
create or replace procedure iqms_new.proc_bcmenu_query (
menuId varchar2,
p_cursor out sys_refcursor)
as
   v_sql varchar2(4000);


begin


 --select result
 v_sql := 'select b.menu_name from BC_MENU b,BSC_BRANCH_BUSINESS bsc where  b.menu_id =:menuId
 and b.menu_id = bsc.bus_id and bsc.business_type = ''MENU''';
 OPEN p_cursor FOR v_sql using menuId;


end proc_bcmenu_query;
/

prompt
prompt Creating procedure PROC_BCMENU_REMOVE
prompt =====================================
prompt
CREATE OR REPLACE PROCEDURE iqms_new.proc_bcmenu_remove
(
 menuId varchar2,
 ReturnCode OUT varchar2
)
IS

cursor v_deviceNo is
select bus.device_no from bsc_branch_business bus
where bus.business_type = '0' and bus.bus_id = menuId;
v_no v_deviceNo%rowtype;
iRecCount INTEGER;
BEGIN

   delete from bc_menu t where t.menu_id = menuId;
   --更新设备状态
  --update bsc_device b set b.extend1 = '1' where b.device_no in (select bus.device_no from bsc_branch_business bus
  --where bus.business_type = '0' and bus.bus_id = menuId);
  for v_no in v_deviceNo loop
    proc_deviceupdateflag(v_no.device_no,'0');

  end loop;


  --级联删除【业务显示】中有此菜单下挂的业务
  delete from bsc_show_time s where s.device_no in (
  select b.device_no from bsc_branch_business b where b.business_type = '1' and
         b.tree_pid in (select t.tree_id
                          from bsc_branch_business t
                         where t.business_type = '0'
                           and t.bus_id = menuId))
  and s.business_id in (
               select b.bus_id from bsc_branch_business b where b.business_type = '1' and
         b.tree_pid in (select t.tree_id
                          from bsc_branch_business t
                         where t.business_type = '0'
                           and t.bus_id = menuId));
  --级联删除【叫号策略】中配置的菜单下挂的业务
  delete from bsc_counterbuz s where s.device_no in (
  select b.device_no from bsc_branch_business b where b.business_type = '1' and
         b.tree_pid in (select t.tree_id
                          from bsc_branch_business t
                         where t.business_type = '0'
                           and t.bus_id = menuId))
  and s.buztypeid in (
               select b.bus_id from bsc_branch_business b where b.business_type = '1' and
         b.tree_pid in (select t.tree_id
                          from bsc_branch_business t
                         where t.business_type = '0'
                           and t.bus_id = menuId));

  --级联更新【客户级别】中绑定业务为不绑定业务
  update bsc_cust_level c set c.business_id= null where c.device_no in(
  select b.device_no from bsc_branch_business b where b.business_type = '1' and
         b.tree_pid in (select t.tree_id
                          from bsc_branch_business t
                         where t.business_type = '0'
                           and t.bus_id = menuId))
  and c.business_id in (
               select b.bus_id from bsc_branch_business b where b.business_type = '1' and
         b.tree_pid in (select t.tree_id
                          from bsc_branch_business t
                         where t.business_type = '0'
                           and t.bus_id = menuId));
  --级联删除【网点业务】功能中此菜单及此菜单下挂的业务
  delete from bsc_branch_business b where b.business_type = '1' and
         b.tree_pid in (select t.tree_id
                          from bsc_branch_business t
                         where t.business_type = '0'
                           and t.bus_id = menuId);
  delete from bsc_branch_business b where b.business_type = '0' and b.bus_id = menuId;



   ReturnCode:='0';
 --异常处理
 -- exception
   --   when others then
     --  ReturnCode:='1'; --数据库异常
END proc_bcmenu_remove;
/

prompt
prompt Creating procedure PROC_BCNEAR_EDIT
prompt ===================================
prompt
CREATE OR REPLACE PROCEDURE iqms_new.proc_bcnear_edit
(
 orgId  varchar2,
 orgId1 varchar2,
 orgId2 varchar2,
 orgId3 varchar2,
 orgId4 varchar2,
 orgId5 varchar2,
 orgId6 varchar2,
 ReturnCode OUT varchar2
)
AS
iRecCount INTEGER;
BEGIN
--查询表中是否存在数据
select count(1) into iRecCount from bc_near t where t.org_id = orgId;
if iRecCount > 0 then
   update bc_near t set
      t.org_id = orgId,
      t.org_id1 =orgId1,
      t.org_id2 =orgId2,
      t.org_id3 =orgId3,
      t.org_id4 =orgId4,
      t.org_id5 =orgId5,
      t.org_id6 =orgId6
      where t.org_id = orgId;

   ReturnCode:='0';
else
  INSERT INTO bc_near t (
      ORG_ID,
      ORG_ID1,
      ORG_ID2,
      ORG_ID3,
      ORG_ID4,
      ORG_ID5,
      ORG_ID6
  ) VALUES (
      orgId,
      orgId1,
      orgId2,
      orgId3,
      orgId4,
      orgId5,
      orgId6
  );
  ReturnCode:='0';
  end if;
 --异常处理
 --exception
    -- when others then
     --  ReturnCode:='1'; --数据库异常
END proc_bcnear_edit;
/

prompt
prompt Creating procedure PROC_BCNEAR_QUERY
prompt ====================================
prompt
create or replace procedure iqms_new.proc_bcnear_query (
orgId varchar2,
p_cursor out sys_refcursor)
as
   v_sql varchar2(4000);


begin


 --select result
 v_sql := 'select * from BC_NEAR b where  b.org_id =:orgId ';
 OPEN p_cursor FOR v_sql using orgId;


end proc_bcnear_query;
/

prompt
prompt Creating procedure PROC_BCNEAR_REMOVE
prompt =====================================
prompt
CREATE OR REPLACE PROCEDURE iqms_new.proc_bcnear_remove
(
 orgId varchar2,
 ReturnCode OUT varchar2
)
AS
iRecCount INTEGER;
BEGIN

   delete from  bc_near t where to_char(t.org_id) = orgId;
   commit;
   ReturnCode:='0';
 --异常处理
 exception
     when others then
     ReturnCode:='1'; --数据库异常
END proc_bcnear_remove;
/

prompt
prompt Creating procedure PROC_BCPARAMETER_EDIT
prompt ========================================
prompt
CREATE OR REPLACE PROCEDURE iqms_new.proc_bcparameter_edit
(
 hbInterval varchar2,
 authenticationType varchar2,
 flowPort varchar2,
 httpPort varchar2,
 identPort varchar2,
 appRoot varchar2,
 ReturnCode OUT varchar2
)
AS
iRecCount INTEGER;
BEGIN
--查询表中是否存在数据
select count(1) into iRecCount from bc_parameter t;
if iRecCount > 0 then
   update bc_parameter t set
      t.HB_INTERVAL = hbInterval,
      t.AUTHENTICATION_TYPE =authenticationType,
      t.flow_port = flowPort,
      t.http_port = httpPort,
      t.ident_port = identPort,
      t.app_root = appRoot;

   ReturnCode:='0';
else
  INSERT INTO bc_parameter t (
      HB_INTERVAL,
      AUTHENTICATION_TYPE,
      flow_port,
      http_port,
      ident_port,
      app_root
  ) VALUES (
      hbInterval,
      authenticationType,
      flowPort,
      httpPort,
      identPort,
      appRoot
  );
  ReturnCode:='0';
  end if;
  --修改客户识别中的识别模式
update bsc_cust_recognition c
set c.recognition_type = authenticationType;
  --update bsc_device t set
      --t.extend1 = '1';
 proc_deviceupdateflag('','1');
 --异常处理
 --exception
    -- when others then
     --  ReturnCode:='1'; --数据库异常
END proc_bcparameter_edit;
/

prompt
prompt Creating procedure PROC_BCPARAMETER_QUERY
prompt =========================================
prompt
create or replace procedure iqms_new.proc_bcparameter_query (
p_cursor out sys_refcursor)
as
   v_sql varchar2(4000);


begin


 --select result
 v_sql := 'select * from BC_PARAMETER ';
 OPEN p_cursor FOR v_sql ;


end proc_bcparameter_query;
/

prompt
prompt Creating procedure PROC_BCPATCHVERSION_ADD
prompt ==========================================
prompt
create or replace procedure proc_bcpatchversion_add (
 patchName varchar2,
 patchVerno varchar2,
 md5code varchar2,
 patchPath varchar2,
 patchRemark varchar2,
 p_status varchar2,
 intactFlag varchar2,
 dbFlag varchar2,
 patchId OUT varchar2,
 ReturnCode OUT varchar2
)
AS
iRecCount INTEGER;
--v_count INTEGER;
v_verno varchar2(20);
BEGIN
  select count(1) into iRecCount from bc_patchversion p where p.patch_verno = patchVerno;
   
   if iRecCount > 0 then 
     ReturnCode:='1';
     else
       
   --插入
   if (patchVerno = '') then
      select to_number(tmp.patch_verno)+1 into v_verno from (select a.patch_verno from bc_patchversion a order by to_number(a.patch_verno) desc)tmp where rownum <= 1;
    else
      v_verno := patchVerno;
      end if;
     if  (v_verno = '' or v_verno is null)then
       v_verno := '1';
       end if;
      patchId := SEQ_BCPATCHVERSION.NEXTVAL;
   insert into bc_patchversion (
      id,
      patch_Name,
      patch_Md5,
      patch_PATH,
      patch_remark,
      patch_date,
      status,
      PATCH_VERNO,
      INTACT_FLAG,
      DB_FLAG
   ) values (
     patchId,
     patchName,
     md5code,
     patchPath,
     patchRemark,
     sysdate,
     '1',
     v_verno,
     intactFlag,
     dbFlag
   );
   ReturnCode:='0';
   end if;
 --异常处理
  --exception
   --   when others then
     --  ReturnCode:='1'; --数据库异常
END proc_bcpatchversion_add;
/

prompt
prompt Creating procedure PROC_BCPATCHVERSION_PAGE
prompt ===========================================
prompt
create or replace procedure iqms_new.proc_bcpatchversion_page (
orderfield in varchar2,
ordertype in varchar2,
pagesize in number, pageno in number,totalrows out number,p_cursor out sys_refcursor)
as
   v_sql varchar2(4000);
   v_sql_page varchar2(4000);
   v_sql_condition varchar2(4000);
   v_sql_count varchar2(4000);
   v_begin number := (pageno-1)*pagesize+1;
   v_end number := pageno*pagesize;
   v_sort varchar2(50);

begin
---------------------------------------------------------1.按条件查询数据 start------------------------------------------------------------------

  v_sql_condition := ' select ID,h.rowId rid,
  PATCH_NAME,
  PATCH_MD5,
  PATCH_PATH,
  PATCH_REMARK,
  PATCH_DATE,
  STATUS,
  PATCH_VERNO,
  INTACT_FLAG,
  DB_FLAG
  from bc_patchversion h where 1=1  ';


  -------------------------------------------------2.包裹按条件查询的语句，进行分页 开始------------------------------------------------------------


 --select result
 v_sql := 'select row_number() over ( order by PATCH_DATE desc,rid ) rnum,tt.ID,
  tt.PATCH_NAME,
  tt.PATCH_MD5,
  tt.PATCH_PATH,
  tt.PATCH_REMARK,
  tt.PATCH_DATE,
  tt.STATUS,
  tt.PATCH_VERNO,
  tt.INTACT_FLAG,
  tt.DB_FLAG
   from ('||v_sql_condition||') tt ';

   --select count
  v_sql_count := 'select count(1) from ('||v_sql||')';


------------------------------------------------------------3.判断是分页还是查询列表

   if pageno > 0  then
    v_sql_page := 'select * from ('||v_sql||') temp where temp.rnum >= :v_begin and temp.rnum <= :v_end';
     execute immediate v_sql_count into totalrows;
     OPEN p_cursor FOR v_sql_page using  v_begin,v_end;
  else
    totalrows:=0; --set default value
    v_sql_page := 'select * from ('||v_sql||') temp ';
    OPEN p_cursor FOR v_sql_page;
  end if;

end proc_bcpatchversion_page;
/

prompt
prompt Creating procedure PROC_BCPATCHVERSION_REMOVE
prompt =============================================
prompt
CREATE OR REPLACE PROCEDURE iqms_new.proc_bcpatchversion_remove
(
 idno varchar2,
 ReturnCode OUT varchar2
)
AS
iRecCount INTEGER;
BEGIN
 --获取记录的版本号
 update  bc_patchversion t set t.status='1' where t.id = idno;
 commit;

 ReturnCode := '0';
END proc_bcpatchversion_remove;
/

prompt
prompt Creating procedure PROC_BCTELLER_ADD
prompt ====================================
prompt
CREATE OR REPLACE PROCEDURE iqms_new.proc_bcteller_add
(
 workId varchar2,
 orgId number,
 callerPwd varchar2,
 name_ varchar2,
 sex varchar2,
 status varchar2,
 ReturnCode OUT varchar2
)
AS
iRecCount INTEGER;
BEGIN

 --查询要增加的记录是否存在
 select count(1) into iRecCount from bc_teller t where t.work_id = workId;

 if iRecCount > 0 then
   ReturnCode:='2'; --该柜员工号已经存在
 else

   --插入
   insert into bc_teller t (
      WORK_ID,
      ORG_ID,
      caller_pwd,
      name_,
      sex,
      status
   ) values (
     workId,
     orgId,
     callerPwd,
     name_,
     sex,
     status
   );
   --更新设备状态
  update bsc_device b set b.extend1 = '1' where b.org_id = orgId;
   ReturnCode:='0';
 end if;
 --异常处理
 -- exception
   --   when others then
     --  ReturnCode:='1'; --数据库异常
END proc_bcteller_add;
/

prompt
prompt Creating procedure PROC_BCTELLER_EDIT
prompt =====================================
prompt
CREATE OR REPLACE PROCEDURE iqms_new.proc_bcteller_edit
(
 workId varchar2,
 orgId number,
 callerPwd varchar2 ,
 v_name_ varchar2 ,
 v_sex varchar2 ,
 v_status varchar2 ,
 ReturnCode OUT varchar2
)
AS
iRecCount INTEGER;
BEGIN

   update bc_teller t set
      t.org_id =orgId,
      t.caller_pwd = callerPwd,
      t.name_ = v_name_,
      t.sex = v_sex,
      t.status = v_status
   where t.work_id = workId;
update bsc_device b set b.extend1 = '1' where b.org_id = orgId;

   ReturnCode:='0';
 --异常处理
 -- exception
   --   when others then
     --  ReturnCode:='1'; --数据库异常
END proc_bcteller_edit;
/

prompt
prompt Creating procedure PROC_BCTELLER_PAGE
prompt =====================================
prompt
create or replace procedure iqms_new.proc_bcteller_page (
orgId varchar2,--机构id
name_ varchar2, --柜员名称

orderfield in varchar2,
ordertype in varchar2,
pagesize in number, pageno in number,totalrows out number,p_cursor out sys_refcursor)
as
   v_sql varchar2(4000);
   v_sql_page varchar2(4000);
   v_sql_condition varchar2(4000);
   v_sql_count varchar2(4000);
   v_begin number := (pageno-1)*pagesize+1;
   v_end number := pageno*pagesize;
   v_sort varchar2(50);
   v_name varchar2(50) := name_;
   v_org_id number := orgId;
begin
---------------------------------------------------------1.按条件查询数据 start------------------------------------------------------------------
if v_org_id = '0' then
  v_org_id := '1';
  end if;
  v_sql_condition := ' select h.org_id,h.rowId rid,h.work_id,h.caller_pwd,h.name_,h.sex,
                     h.status,s.org_code,s.org_name from bc_teller h inner join (select *
                 from sys_org o
                where o.deleted = 0
                start with o.org_id = :orgId
               connect by prior o.org_id = o.parent_id) s
      on (h.ORG_ID = s.ORG_ID)';

  --if v_org_id !=0 then
    -- v_sql_condition := v_sql_condition || ' and s.org_id =:orgId';
  -- else
    -- v_org_id := 0;
    -- v_sql_condition := v_sql_condition || ' and ( s.org_id  is null or s.org_id <>:orgId)';

  --end if;
  if v_name is not null then
     v_sql_condition := v_sql_condition || ' and h.name_ like ''%''||:name_||''%''';
   else
     v_name := '@#$&^%$#@!';
     v_sql_condition := v_sql_condition || ' and ( h.name_  is null or h.name_ <>:name_)';

  end if;


  -------------------------------------------------2.包裹按条件查询的语句，进行分页 开始------------------------------------------------------------
  if (orderfield is null) then
      v_sort := 'org_code';
  else
      v_sort := orderfield||' '||ordertype;
  end if;

 --select result
 v_sql := 'select row_number() over ( order by '||v_sort||',rid) rnum,tt.org_id,
  tt.work_id,
  tt.caller_pwd,
  tt.name_,
  tt.sex,
  tt.status,
  tt.org_code,
  tt.org_name
   from ('||v_sql_condition||') tt ';

   --select count
  v_sql_count := 'select count(1) from ('||v_sql||')';


------------------------------------------------------------3.判断是分页还是查询列表

   if pageno > 0  then
    v_sql_page := 'select * from ('||v_sql||') temp where temp.rnum >= :v_begin and temp.rnum <= :v_end';
     execute immediate v_sql_count into totalrows using v_org_id, v_name;
     OPEN p_cursor FOR v_sql_page using v_org_id, v_name,v_begin,v_end;
  else
    totalrows:=0; --set default value
    v_sql_page := 'select * from ('||v_sql||') temp ';
    OPEN p_cursor FOR v_sql_page using v_org_id, v_name;
  end if;

end proc_bcteller_page;
/

prompt
prompt Creating procedure PROC_BCTELLER_REMOVE
prompt =======================================
prompt
CREATE OR REPLACE PROCEDURE iqms_new.proc_bcteller_remove
(
 workId varchar2,
 ReturnCode OUT varchar2
)
AS
iRecCount INTEGER;
BEGIN
   update bsc_device b set b.extend1 = '1'
   where b.org_id =
   (select t.org_id from bc_teller t where t.work_id = workId);
   delete from  bc_teller t where t.work_id = workId;


   ReturnCode:='0';
 --异常处理
 -- exception
   --   when others then
     --  ReturnCode:='1'; --数据库异常
END proc_bcteller_remove;
/

prompt
prompt Creating procedure PROC_BOOKCANCEL
prompt ==================================
prompt
CREATE OR REPLACE PROCEDURE iqms_new.proc_bookCancel
(
 orgCode IN varchar2,  -- 机构编码
 actNo in varchar2, --激活码
 orderDt in varchar2,
 certType in varchar2, -- 证件类型
 certContent in varchar2, -- 证件号
 ReturnCode out varchar2  -- 返回结果  0-成功   1-失败

)
AS
  recordExists INTEGER DEFAULT 0;
BEGIN
 ReturnCode := 0; -- 成功
  -- 查询激活码是否可用，此机构预约日期激活码不重复
  SELECT COUNT(1)  INTO recordExists FROM order_info i  WHERE i.org_code = orgCode
                                                               --and r.dev_no = devNo
                                                               and i.act_no = actNo
                                                               and order_date = orderDt;

  if recordExists = 0 then
     ReturnCode := 1; -- 失败
     return;
  end if;




     update ORDER_INFO oi set oi.order_status = '2' where oi.org_code = orgCode and
      oi.order_date = orderDt and
      (oi.act_no = actNo or (oi.cert_type = certType and oi.cert_content=certContent));

ReturnCode := 0;
END proc_bookCancel;
/

prompt
prompt Creating procedure PROC_BSCBRANCHBUSINESS_NEW
prompt =============================================
prompt
create or replace procedure iqms_new.proc_bscbranchbusiness_new (
orgId varchar2,
menuId varchar2,
businessId varchar2,
p_cursor out sys_refcursor)
as
   v_sql varchar2(4000);


begin
if menuId =0 then

 --select result
 v_sql := 'select s.org_name orgName,'''' menuName, bm.business_name businessName
 from  SYS_ORG s, BC_BUSINESSMANAGE bm
 where  s.org_id =:orgId
   and bm.business_id =:business_id';
 OPEN p_cursor FOR v_sql using orgId,businessId;
else
v_sql := 'select s.org_name orgName, m.menu_name menuName, bm.business_name businessName
 from  SYS_ORG s,bc_menu m, BC_BUSINESSMANAGE bm
 where  s.org_id =:orgId and m.menu_id =:menuId
   and bm.business_id =:business_id';
 OPEN p_cursor FOR v_sql using orgId,menuId,businessId;
end if;



end proc_bscbranchbusiness_new;
/

prompt
prompt Creating procedure PROC_BSCBRANCHBUSINESS_QUERY
prompt ===============================================
prompt
create or replace procedure iqms_new.proc_bscbranchbusiness_query (
orgId varchar2,
deviceNo varchar2,
treeId varchar2,
p_cursor out sys_refcursor)
as
   v_sql varchar2(4000);
   iRecCount INTEGER;

begin
if treeId ='-1' then

 --select result
 v_sql := 'select b.*,s.org_code,s.org_name,
 decode(b.business_type,''1'',(select bm.business_name from BC_BUSINESSMANAGE bm where b.bus_id= bm.business_id),
 ''0'',(select m.menu_name from bc_menu m where b.bus_id=m.menu_id) ) branchName,
 decode(b.business_type,''1'',(select bm.business_ename from BC_BUSINESSMANAGE bm where b.bus_id= bm.business_id),
 ''0'',(select m.menu_enname from bc_menu m where b.bus_id=m.menu_id) ) businessEnName
 from bsc_branch_business b, SYS_ORG s
 where  b.org_id =:orgId and b.device_no =:deviceNo and  b.org_id = s.org_id';
 OPEN p_cursor FOR v_sql using orgId,deviceNo;
else
 select count(1) into iRecCount from bsc_branch_business b where b.tree_id
 =treeId;
 if iRecCount > 0 then
 v_sql := 'select b.*,s.org_code,s.org_name,
 (select bm.business_name from BC_BUSINESSMANAGE bm where b.bus_id= bm.business_id) branchName,
 (select bm.business_ename from BC_BUSINESSMANAGE bm where b.bus_id= bm.business_id) businessEnName
 from bsc_branch_business b, SYS_ORG s
 where  b.org_id =:orgId and b.device_no =:deviceNo and  b.org_id = s.org_id and b.tree_id=:treeId ';

  OPEN p_cursor FOR v_sql using orgId,deviceNo,treeId;
  else
    v_sql := 'select b.business_name branchName,
    b.business_ename businessEnName
from bc_businessmanage b
 where  b.business_id=:treeId ';

  OPEN p_cursor FOR v_sql using treeId;
    end if;
end if;



end proc_bscbranchbusiness_query;
/

prompt
prompt Creating procedure PROC_BSCBRANCHBUS_ADD
prompt ========================================
prompt
CREATE OR REPLACE PROCEDURE iqms_new.proc_bscbranchbus_add
(
 orgId varchar2,
 deviceNo varchar2,
 treeId varchar2,
 treePid varchar2,
 businessEnName varchar2,
 businessType varchar2,
 businessCode varchar2,
 callHead varchar2,
 priorTime varchar2,
 isSwipe varchar2,
 isShowEn varchar2,
 pickUpAdvice varchar2,
 maxPickUp varchar2,
 sortNum varchar2,
 extend1 varchar2,
 extend2 varchar2,
 extend3 varchar2,
 busId   varchar2,
 levelNum varchar2,
 ReturnCode OUT varchar2
)
AS
iRecCount INTEGER;
codeCount1 INTEGER;

timesCount integer;
BEGIN

 --查询要增加的记录是否存在
 --select count(1) into iRecCount from DEVICE_INFO t where t.org_code = orgCode and t.device_no = deviceNo;
 select count(1) into iRecCount from BSC_BRANCH_BUSINESS t where t.org_id=orgId and t.device_no = deviceNo and t.tree_id = treeId;
 select count(1) into timesCount from bsc_show_time t
 where t.device_no = deviceNo and t.business_id = busId;

 select count(1) into codeCount1 from BSC_BRANCH_BUSINESS t where t.device_no = deviceNo
 and t.tree_id <> treeId and t.business_type = businessType
 and t.business_code = businessCode;
 if codeCount1>0 then
   ReturnCode:='2';--业务代码重复
   return;
  end if;
 if iRecCount > 0 then
   update BSC_BRANCH_BUSINESS t set
      t.ORG_ID = orgId,
      t.DEVICE_NO =deviceNo,
      t.tree_id =treeId,
      t.tree_pid =treePid,
      t.BUSINESS_EN_NAME = businessEnName,
      t.business_type = businessType,
      t.BUSINESS_CODE = businessCode,
      t.PRIOR_TIME =priorTime,
      t.CALL_HEAD =callHead,
      t.IS_SWIPE =isSwipe,
      t.IS_SHOW_EN =isShowEn,
      t.PICK_UP_ADVICE =pickUpAdvice,
      t.MAX_PICK_UP = maxPickUp,
      t.SORT_NUM = sortNum,
      t.EXTEND1 =extend1,
      t.EXTEND2 =extend2,
      t.EXTEND3 =extend3,
      t.levelnum = levelNum,
      t.bus_id = busId
      where t.org_id = orgId
      and t.device_no = deviceNo
      and t.tree_id = treeId;
 else
   --插入
   insert into BSC_BRANCH_BUSINESS (
      ORG_ID,
      DEVICE_NO,
      tree_id,
      tree_pid,
      BUSINESS_EN_NAME,
      BUSINESS_TYPE,
      BUSINESS_CODE,
      PRIOR_TIME,
      CALL_HEAD,
      IS_SWIPE,
      IS_SHOW_EN,
      PICK_UP_ADVICE,
      MAX_PICK_UP,
      SORT_NUM,
      EXTEND1,
      EXTEND2,
      EXTEND3,
      bus_id,
      levelnum
   ) values (
     orgId,
     deviceNo,
     treeId,
     treePid,
     businessEnName,
     businessType,
     businessCode,
     priorTime,
     callHead,
     isSwipe,
     isShowEn,
     pickUpAdvice,
     maxPickUp,
     sortNum,
     extend1,
     extend2,
     extend3,
     busId,
     levelNum
   );

   --更新设备状态
--update bsc_device b set b.extend1 = '1' where b.org_id = orgId
--and b.device_no = deviceNo;
 end if;
 if timesCount = 0  then
   insert into BSC_SHOW_TIME (
      ORG_ID,
      DEVICE_NO,
      business_id,
      row_id,
      date_type,
      begin_time,
      end_time,
      max_num
   ) values (
     orgId,
     deviceNo,
     treeId,
     1,
     'N',
     '08:00',
     '23:00',
     999
   );
   insert into BSC_SHOW_TIME (
      ORG_ID,
      DEVICE_NO,
      business_id,
      row_id,
      date_type,
      begin_time,
      end_time,
      max_num
   ) values (
     orgId,
     deviceNo,
     treeId,
     1,
     'H',
     '08:00',
     '23:00',
     999
   );
   end if;

   proc_deviceupdateflag(deviceNo,'0');
   ReturnCode:='0';

 --异常处理
 -- exception
   --   when others then
     --  ReturnCode:='1'; --数据库异常
END proc_bscbranchbus_add;
/

prompt
prompt Creating procedure PROC_BSCBRANCHBUS_BUZ
prompt ========================================
prompt
create or replace procedure iqms_new.proc_bscbranchbus_buz (
orgId varchar2,
deviceNo varchar2,
p_cursor out sys_refcursor)
as
   v_sql varchar2(4000);


begin



 v_sql := 'select b.org_id,b.device_no,b.business_type,
b.bus_id,
tree_pid,
 b.business_code,
b.prior_time,b.max_pick_up,b.call_head,
(select bm.business_name from BC_BUSINESSMANAGE bm where b.bus_id= bm.business_id)
 branchName,
b.business_en_name,
b.is_show_en,b.is_swipe,b.pick_up_advice,b.sort_num

 from bsc_branch_business b
 where  b.org_id =:orgId and b.device_no =:deviceNo
 and b.business_type=''1'' ';
 OPEN p_cursor FOR v_sql using orgId,deviceNo;




end proc_bscbranchbus_buz;
/

prompt
prompt Creating procedure PROC_BSCBRANCHBUS_COPY
prompt =========================================
prompt
CREATE OR REPLACE PROCEDURE proc_bscbranchbus_copy--应用到下级机构
(
 orgId varchar2,
 deviceNo varchar2,
 targetId varchar2,--目标orgId
 targetNo varchar2, --目标deviceNo
 ReturnCode OUT varchar2
)
AS
BEGIN
if orgId != targetId or deviceNo != targetNo then

 --删除目标数据再插入
 delete from BSC_BRANCH_BUSINESS b where b.org_id = targetId and b.device_no = targetNo;

   --插入
   insert into BSC_BRANCH_BUSINESS (
      ORG_ID,
      DEVICE_NO,
      tree_id，
      tree_pid，
      BUSINESS_EN_NAME,
      BUSINESS_TYPE,
      BUSINESS_CODE,
      PRIOR_TIME,
      CALL_HEAD,
      IS_SWIPE,
      IS_SHOW_EN,
      PICK_UP_ADVICE,
      MAX_PICK_UP,
      SORT_NUM,
      EXTEND1,
      EXTEND2,
      EXTEND3,
      bus_id,
      LEVELNUM
   ) select
     targetId,
     targetNo,
      tree_id,
      tree_pid,
      BUSINESS_EN_NAME,
      BUSINESS_TYPE,
      BUSINESS_CODE,
      PRIOR_TIME,
      CALL_HEAD,
      IS_SWIPE,
      IS_SHOW_EN,
      PICK_UP_ADVICE,
      MAX_PICK_UP,
      SORT_NUM,
      EXTEND1,
      EXTEND2,
      EXTEND3,
      bus_id,
      LEVELNUM
    from BSC_BRANCH_BUSINESS w where w.org_id = orgId and w.device_no=deviceNo;
 --插入业务显示时间
 delete from BSC_SHOW_TIME s where s.device_no = targetNo;
 insert into BSC_SHOW_TIME (
      ORG_ID,
      DEVICE_NO,
      business_id,
      row_id,
      date_type,
      begin_time,
      end_time,
      max_num
   )select
     targetId,
     targetNo, 
     BUSINESS_ID,
     ROW_ID,
     DATE_TYPE,
     BEGIN_TIME,
     END_TIME,
     MAX_NUM  
     from BSC_SHOW_TIME w where w.org_id = orgId and w.device_no=deviceNo;
 
 proc_deviceupdateflag(deviceNo,'0');
   ReturnCode:='0';
end if;
 --异常处理
 -- exception
   --   when others then
     --  ReturnCode:='1'; --数据库异常
END proc_bscbranchbus_copy;
/

prompt
prompt Creating procedure PROC_BSCBRANCHBUS_EDIT
prompt =========================================
prompt
CREATE OR REPLACE PROCEDURE iqms_new.proc_bscbranchbus_edit
(
 orgId varchar2,
 deviceNo varchar2,
 treeId varchar2,
 treePid varchar2,
 businessEnName varchar2,
 businessType varchar2,
 businessCode varchar2,
 callHead varchar2,
 priorTime varchar2,
 isSwipe varchar2,
 isShowEN varchar2,
 pickUpAdvice varchar2,
 maxPickUp varchar2,
 sortNum varchar2,
 extend1 varchar2,
 extend2 varchar2,
 extend3 varchar2,
 ReturnCode OUT varchar2
)
AS
prefixCount INTEGER;
BEGIN
   select count(1) into prefixCount from BSC_BRANCH_BUSINESS t
 where t.org_id=orgId and t.device_no = deviceNo and t.call_head = callHead
 and t.tree_id != treeId;
 if prefixCount>0 then
   ReturnCode:='2';--呼叫字头不能重复
   else
   update BSC_BRANCH_BUSINESS t set
      t.ORG_ID = orgId,
      t.DEVICE_NO =deviceNo,
      t.TREE_ID =treeId,
      t.business_type = businessType,
      t.TREE_PID =treePid,
      t.BUSINESS_EN_NAME = businessEnName,
      t.BUSINESS_CODE = businessCode,
      t.PRIOR_TIME =priorTime,
      t.CALL_HEAD =callHead,
      t.IS_SWIPE =isSwipe,
      t.IS_SHOW_EN =isShowEn,
      t.PICK_UP_ADVICE =pickUpAdvice,
      t.MAX_PICK_UP = maxPickUp,
      t.SORT_NUM = sortNum,
      t.EXTEND1 =extend1,
      t.EXTEND2 =extend2,
      t.EXTEND3 =extend3
      where t.org_id = orgId
      and t.device_no = deviceNo
      and t.tree_id = treeId;
--更新设备状态
--update bsc_device b set b.extend1 = '1' where b.org_id = orgId
--and b.device_no = deviceNo;
proc_deviceupdateflag(deviceNo,'0');
   ReturnCode:='0';
   end if;
 --异常处理
 -- exception
   --   when others then
     --  ReturnCode:='1'; --数据库异常
END proc_bscbranchbus_edit;
/

prompt
prompt Creating procedure PROC_BSCBRANCHBUS_LEVEL
prompt ==========================================
prompt
create or replace procedure iqms_new.proc_bscbranchbus_level (
orgId varchar2,
deviceNo varchar2,
treePid varchar2,
p_cursor out sys_refcursor)
as
   v_sql varchar2(4000);


begin
--,b.org_id,b.device_no,b.tree_id,b.tree_pid
 v_sql := 'select max(levelnum) as lev
 from bsc_branch_business b
 where  b.org_id =:orgId and b.device_no =:deviceNo
  start with b.tree_pid =:treePid
  connect by prior b.tree_pid = tree_id';
 OPEN p_cursor FOR v_sql using orgId,deviceNo,treePid;



end proc_bscbranchbus_level;
/

prompt
prompt Creating procedure PROC_BSCBRANCHBUS_QUERY
prompt ==========================================
prompt
create or replace procedure iqms_new.proc_bscbranchbus_query (--查询所有的业务不包括菜单
orgId varchar2,
deviceNo varchar2,

p_cursor out sys_refcursor)
as
   v_sql varchar2(4000);


begin


 --select result
 v_sql := 'select b.*,
 bm.business_name branchName
 from bsc_branch_business b, BC_BUSINESSMANAGE bm
 where  b.org_id =:orgId and b.device_no =:deviceNo
  and b.bus_id = bm.business_id and b.business_type=''BUS''';
 OPEN p_cursor FOR v_sql using orgId,deviceNo;




end proc_bscbranchbus_query;
/

prompt
prompt Creating procedure PROC_BSCBRANCHBUS_REMOVE
prompt ===========================================
prompt
CREATE OR REPLACE PROCEDURE iqms_new.proc_bscbranchbus_remove
(
 orgId varchar2,
 deviceNo varchar2,
 treeId varchar2,
 ReturnCode OUT varchar2
)
AS

busType varchar2(10);
busId varchar2(20);
BEGIN

 select t.business_type into busType from BSC_BRANCH_BUSINESS t
 where t.org_id = orgId and t.device_no = deviceNo and t.tree_id = treeId;
 select t.bus_id into busId from BSC_BRANCH_BUSINESS t
 where t.org_id = orgId and t.device_no = deviceNo and t.tree_id = treeId;

--删除网点业务同时 删除业务显示数据
 delete from Bsc_Show_Time s
 where s.device_no = deviceNo and s.org_id = orgId
 and s.business_id = busId;
--级联删除 叫号策略中关联业务
 delete from  bsc_counterbuz t
 where t.org_id = orgId and t.device_no = deviceNo and t.buztypeid = busId;
--设置 客户等级 中绑定业务 为不绑定
update bsc_cust_level c set c.business_id=0
where c.device_no = deviceNo and c.business_id = busId;
--级联删除 【取号界面】
delete from bc_modelstyle_element m
where m.buztype_id =  busId and m.element_type = 'buzType'
 and m.device_no = deviceNo;
--更新设备状态
--update bsc_device b set b.extend1 = '1' where b.org_id = orgId
--and b.device_no = deviceNo;

 delete from  BSC_BRANCH_BUSINESS t
 where t.org_id = orgId and t.device_no = deviceNo and t.tree_id = treeId;

 proc_deviceupdateflag(deviceNo,'0');
 ReturnCode:='0';

END proc_bscbranchbus_remove;
/

prompt
prompt Creating procedure PROC_BSCCUSTLEVEL_ADD
prompt ========================================
prompt
CREATE OR REPLACE PROCEDURE iqms_new.proc_bsccustlevel_add
(
 orgId varchar2,
 deviceNo varchar2,
 custLevel varchar2,
 levelName varchar2,
 businessId varchar2,
 priorTime varchar2,
 callHead varchar2,
 maxWaitTime varchar2,
 ticketTemplate varchar2,
 isStart varchar2,
 extend1 varchar2,
 extend2 varchar2,
 extend3 varchar2,
 ReturnCode OUT varchar2
)
AS
iRecCount INTEGER;
BEGIN

 --查询要增加的记录是否存在
 --select count(1) into iRecCount from DEVICE_INFO t where t.org_code = orgCode and t.device_no = deviceNo;
 select count(1) into iRecCount from BSC_CUST_LEVEL t where t.cust_level=custLevel and t.device_no = deviceNo and t.org_id = orgId;

 if iRecCount > 0 then
   update BSC_CUST_LEVEL t set
      t.ORG_ID = orgId,
      t.DEVICE_NO =deviceNo,
      t.CUST_LEVEL =custLevel,
      t.LEVEL_NAME =levelName,
      t.BUSINESS_ID =businessId,
      t.PRIOR_TIME =priorTime,
      t.CALL_HEAD =callHead,
      t.MAX_WAIT_TIME =maxWaitTime,
      t.TICKET_TEMPLATE =ticketTemplate,
      t.IS_START =isStart,
      t.EXTEND1 =extend1,
      t.EXTEND2 =extend2,
      t.EXTEND3 =extend3
      where t.org_id = orgId
      and t.device_no = deviceNo
      and t.CUST_LEVEL = custLevel;
      --更新设备状态
proc_deviceupdateflag(deviceNo,'0');
   ReturnCode:='0'; --已经存在
 else
   --插入
   insert into BSC_CUST_LEVEL (
      ORG_ID,
      DEVICE_NO,
      CUST_LEVEL，
      LEVEL_NAME，
      BUSINESS_ID,
      PRIOR_TIME,
      CALL_HEAD,
      MAX_WAIT_TIME,
      TICKET_TEMPLATE,
      IS_START,
      EXTEND1,
      EXTEND2,
      EXTEND3
   ) values (
     orgId,
     deviceNo,
     custLevel,
     levelName,
     businessId,
     priorTime,
     callHead,
     maxWaitTime,
     ticketTemplate,
     isStart,
     extend1,
     extend2,
     extend3
   );
   --更新设备状态
--update bsc_device b set b.extend1 = '1' where b.org_id = orgId
--and b.device_no = deviceNo;
proc_deviceupdateflag(deviceNo,'0');
   ReturnCode:='0';
 end if;
 --异常处理
 -- exception
   --   when others then
     --  ReturnCode:='1'; --数据库异常
END proc_bsccustlevel_add;
/

prompt
prompt Creating procedure PROC_BSCCUSTLEVEL_COPY
prompt =========================================
prompt
CREATE OR REPLACE PROCEDURE iqms_new.proc_bsccustlevel_copy--应用到下级机构
(
 orgId varchar2,
 deviceNo varchar2,
 targetId varchar2,--目标orgId
 targetNo varchar2, --目标deviceNo
 ReturnCode OUT varchar2
)
AS


    -- 定义游标查询源客户等级信息
    cursor custleveldata_cur is select
      org_id,
      device_no,
      CUST_LEVEL，
      LEVEL_NAME，
      BUSINESS_ID,
      PRIOR_TIME,
      CALL_HEAD,
      MAX_WAIT_TIME,
      TICKET_TEMPLATE,
      IS_START,
      EXTEND1,
      EXTEND2,
      EXTEND3
    from Bsc_Cust_Level w where w.org_id = orgId and w.device_no=deviceNo;


    v_tkttmpId varchar2(30); -- 号票模板id
    v_sorceTkName varchar2(30); -- 源设备的号票模板名称
    v_targetTkId varchar2(30); -- 目标设备的对应的设备Id


BEGIN
if orgId != targetId or targetNo != deviceNo then

 --删除目标数据再插入
 delete from Bsc_Cust_Level b where b.org_id = targetId and b.device_no = targetNo;


 -- 遍历客户等级源的值
  for c_custlevel  in custleveldata_cur loop


      -- 查询出源机构等级绑定的号票模板名称
      if c_custlevel.TICKET_TEMPLATE is not null then

         begin
           select tf.tkttmp_name into v_sorceTkName from bc_ticketform tf where to_char(tf.tkttmp_id) =  c_custlevel.TICKET_TEMPLATE and tf.device_no = deviceNo;
         exception
            when others then
            --异常就设置原模板名称为
            v_sorceTkName:='';
         end;


         -- 通过模板名称查询目标机构此模板的id
         begin
           select tf.tkttmp_id into v_targetTkId from bc_ticketform tf where tf.tkttmp_name = v_sorceTkName and tf.device_no = targetNo;
         exception
            when others then
            --异常就设置原模板名称为
            v_targetTkId:='';
         end;

      else
        v_targetTkId:='';
      end if;
       -- 将数据插入到临时表中
       insert into BSC_CUST_LEVEL_TMP values (targetId,targetNo,
                           c_custlevel.cust_level,
                           c_custlevel.business_id,
                           c_custlevel.prior_time,
                           c_custlevel.call_head,
                           c_custlevel.max_wait_time,
                           v_targetTkId,
                           c_custlevel.is_start,
                           c_custlevel.extend1,
                           c_custlevel.extend2,
                           c_custlevel.extend3,
                           c_custlevel.level_name);
  end loop;


  -- 将临时表数据插入到Bsc_Cust_Level中
   insert into Bsc_Cust_Level (
      ORG_ID,
      DEVICE_NO,
      CUST_LEVEL，
      LEVEL_NAME，
      BUSINESS_ID,
      PRIOR_TIME,
      CALL_HEAD,
      MAX_WAIT_TIME,
      TICKET_TEMPLATE,
      IS_START,
      EXTEND1,
      EXTEND2,
      EXTEND3
   ) select
     tmp.org_id,
     tmp.device_no,
      CUST_LEVEL，
      LEVEL_NAME，
      BUSINESS_ID,
      PRIOR_TIME,
      CALL_HEAD,
      MAX_WAIT_TIME,
      TICKET_TEMPLATE,
      IS_START,
      EXTEND1,
      EXTEND2,
      EXTEND3
    from BSC_CUST_LEVEL_TMP tmp where tmp.org_id = targetId and tmp.device_no=targetNo;

   -- 清理临时表
   delete  from BSC_CUST_LEVEL_TMP tmp where tmp.org_id = targetId and tmp.device_no=targetNo;

   ReturnCode:='0';
end if;
proc_deviceupdateflag(deviceNo,'0');
 --异常处理
 -- exception
   --   when others then
     --  ReturnCode:='1'; --数据库异常
END proc_bsccustlevel_copy;
/

prompt
prompt Creating procedure PROC_BSCCUSTLEVEL_EDIT
prompt =========================================
prompt
CREATE OR REPLACE PROCEDURE iqms_new.proc_bsccustlevel_edit
(
 orgId varchar2,
 deviceNo varchar2,
 custLevel varchar2,
 --levelName varchar2,
 businessId varchar2,
 priorTime varchar2,
 callHead varchar2,
 maxWaitTime varchar2,
 ticketTemplate varchar2,
 isStart varchar2,
 extend1 varchar2,
 extend2 varchar2,
 extend3 varchar2,
 ReturnCode OUT varchar2
)
AS

BEGIN

   update BSC_CUST_LEVEL t set
      t.ORG_ID = orgId,
      t.DEVICE_NO =deviceNo,
      t.CUST_LEVEL =custLevel,
     -- t.LEVEL_NAME =levelName,
      t.BUSINESS_ID =businessId,
      t.PRIOR_TIME =priorTime,
      t.CALL_HEAD =callHead,
      t.MAX_WAIT_TIME =maxWaitTime,
      t.TICKET_TEMPLATE =ticketTemplate,
      t.IS_START =isStart,
      t.EXTEND1 =extend1,
      t.EXTEND2 =extend2,
      t.EXTEND3 =extend3
      where t.org_id = orgId
      and t.device_no = deviceNo
      and t.CUST_LEVEL = custLevel;
      proc_deviceupdateflag(deviceNo,'0');
   ReturnCode:='0';
 --异常处理
 -- exception
   --   when others then
     --  ReturnCode:='1'; --数据库异常
END proc_bsccustlevel_edit;
/

prompt
prompt Creating procedure PROC_BSCCUSTLEVEL_PAGE
prompt =========================================
prompt
create or replace procedure iqms_new.proc_bsccustlevel_page (
orgId varchar2, --机构id
deviceNo varchar2,
orderfield in varchar2,
ordertype in varchar2,
pagesize in number, pageno in number,totalrows out number,p_cursor out sys_refcursor)
as
   v_sql varchar2(4000);
   v_sql_page varchar2(4000);
   v_sql_condition varchar2(4000);
   v_sql_count varchar2(4000);
   v_begin number := (pageno-1)*pagesize+1;
   v_end number := pageno*pagesize;
   v_sort varchar2(50);
   v_orgId varchar2(50) := orgId;
   v_deviceNo varchar2(50) := deviceNo;
begin
---------------------------------------------------------1.按条件查询数据 start------------------------------------------------------------------

  v_sql_condition := ' select h.*,h.rowId rid,s.org_code,s.org_name,b.business_name,dic.dic_value level_name
   from bsc_cust_level h,sys_org s,bc_businessmanage b,sys_dic dic where h.org_id=s.org_id
    and h.business_id = b.business_id and h.cust_level = dic.dic_key and dic.dic_type=''levelName''';


  if v_orgId !=0 then
     v_sql_condition := v_sql_condition || ' and h.org_id =:orgId and h.device_no =:deviceNo';
   else
     v_orgId := 0;
     v_sql_condition := v_sql_condition || ' and ( h.org_id  is null or h.org_id <>:orgId)';

  end if;


  -------------------------------------------------2.包裹按条件查询的语句，进行分页 开始------------------------------------------------------------
  if (orderfield is null) then
      v_sort := 'org_id ';
  else
      v_sort := orderfield||' '||ordertype;
  end if;

 --select result
 v_sql := 'select row_number() over ( order by '||v_sort||',rid) rnum, tt.org_id,tt.device_no,
tt.cust_level,tt.business_id,
tt.prior_time,tt.call_head,
tt.max_wait_time,tt.ticket_template,tt.is_start,
tt.extend1,tt.extend2,tt.extend3,tt.level_name,
tt..org_code,tt.org_name,tt.business_name,tt.level_name
  from ('||v_sql_condition||') tt ';

   --select count
  v_sql_count := 'select count(1) from ('||v_sql||')';


------------------------------------------------------------3.判断是分页还是查询列表

   if pageno > 0  then
    v_sql_page := 'select * from ('||v_sql||') temp where temp.rnum >= :v_begin and temp.rnum <= :v_end';
     execute immediate v_sql_count into totalrows using v_orgId,v_deviceNo;
     OPEN p_cursor FOR v_sql_page using  v_orgId,v_deviceNo,v_begin,v_end;
  else
    totalrows:=0; --set default value
    v_sql_page := 'select * from ('||v_sql||') temp ';
    OPEN p_cursor FOR v_sql_page using  v_orgId,v_deviceNo;
  end if;

end proc_bsccustlevel_page;
/

prompt
prompt Creating procedure PROC_BSCCUSTLEVEL_QUERY
prompt ==========================================
prompt
create or replace procedure iqms_new.PROC_BSCCUSTLEVEL_QUERY (
orgId varchar2,
deviceNo varchar2,
--flag varchar2,
p_cursor out sys_refcursor)
as
   v_sql varchar2(4000);


begin


 --select result
 --if flag ='1' then
 v_sql := 'select h.*
   from bsc_cust_level h where

      h.org_id =:orgId and h.device_no =:deviceNo  order by h.cust_level';
 OPEN p_cursor FOR v_sql using orgId,deviceNo;
 --else
  -- v_sql := 'select h.*,dic.dic_value
   --from bsc_cust_level h,sys_dic dic where
    --  h.cust_level = dic.dic_key and dic.dic_type=''levelName''
    -- and h.org_id =:orgId and h.device_no =:deviceNo';
 --OPEN p_cursor FOR v_sql using orgId,deviceNo;
--end if;


end PROC_BSCCUSTLEVEL_QUERY;
/

prompt
prompt Creating procedure PROC_BSCCUSTLEVEL_REMOVE
prompt ===========================================
prompt
CREATE OR REPLACE PROCEDURE iqms_new.proc_bsccustlevel_remove
(
 orgId varchar2,
 deviceNo varchar2,
 custLevel varchar2,
 ReturnCode OUT varchar2
)
AS

BEGIN
 delete from  BSC_CUST_LEVEL t  where t.org_id = orgId and t.device_no = deviceNo and t.cust_level = custLevel;
 proc_deviceupdateflag(deviceNo,'0');
 ReturnCode:='0';
END proc_bsccustlevel_remove;
/

prompt
prompt Creating procedure PROC_BSCCUSTRECOGNITION_ADD
prompt ==============================================
prompt
CREATE OR REPLACE PROCEDURE iqms_new.proc_bsccustrecognition_add
(
 orgId varchar2,
 deviceNo varchar2,
 rowId_ varchar2,
 dateType varchar2,
 startPosition varchar2,
 mateLength varchar2,
 startMateCode varchar2,
 endMateCode varchar2,
 custLevel varchar2,
 --recognitionType varchar2,
 extend1 varchar2,
 extend2 varchar2,
 extend3 varchar2,
 ReturnCode OUT varchar2
)
AS
iRecCount INTEGER;
BEGIN

 --查询要增加的记录是否存在
 --select count(1) into iRecCount from DEVICE_INFO t where t.org_code = orgCode and t.device_no = deviceNo;
 select count(1) into iRecCount from BSC_CUST_RECOGNITION t where t.org_id=orgId and t.device_no = deviceNo
  and t.row_id = rowId_;


 if iRecCount > 0 then
   update BSC_CUST_RECOGNITION t set
      t.ORG_ID = orgId,
      t.DEVICE_NO =deviceNo,
      --t.recognition_type = recognitionType,
      t.row_id =rowId_,
      t.date_type = dateType,
      t.start_position = startPosition,
      t.mate_length = mateLength,
      t.start_mate_code = startMateCode,
      t.end_mate_code = endMateCode,
      t.cust_level = custLevel,
      t.EXTEND1 =extend1,
      t.EXTEND2 =extend2,
      t.EXTEND3 =extend3
      where t.org_id=orgId
      and t.device_no = deviceNo

      and t.row_id = rowId_
      and t.date_type = dateType;
      --更新设备状态
proc_deviceupdateflag(deviceNo,'0');
   ReturnCode:='0'; --已经存在
 else
   --插入
   insert into BSC_CUST_RECOGNITION (
      ORG_ID,
      DEVICE_NO,
      recognition_type,
      row_id,
      date_type,
      start_position,
      mate_length,
      start_mate_code,
      end_mate_code,
      cust_level,
      EXTEND1,
      EXTEND2,
      EXTEND3
   ) values (
     orgId,
     deviceNo,
     (select distinct(p.authentication_type) from bc_parameter p),
     rowId_,
     dateType,
     startPosition,
     mateLength,
     startMateCode,
     endMateCode,
     custLevel,
     extend1,
     extend2,
     extend3
   );
   --更新设备状态
--update bsc_device b set b.extend1 = '1' where b.org_id = orgId
--and b.device_no = deviceNo;
proc_deviceupdateflag(deviceNo,'0');
   ReturnCode:='0';
 end if;
 --异常处理
 -- exception
   --   when others then
     --  ReturnCode:='1'; --数据库异常
END proc_bsccustrecognition_add;
/

prompt
prompt Creating procedure PROC_BSCCUSTRECOGNITION_COPY
prompt ===============================================
prompt
CREATE OR REPLACE PROCEDURE iqms_new.proc_bsccustrecognition_copy--应用到下级机构
(
 orgId varchar2,
 deviceNo varchar2,
 targetId varchar2,--目标orgId
 targetNo varchar2, --目标deviceNo
 ReturnCode OUT varchar2
)
AS
BEGIN
if orgId != targetId or deviceNo != targetNo then

 --删除目标数据再插入
 delete from BSC_CUST_RECOGNITION b where b.org_id = targetId and b.device_no = targetNo;

   --插入
   insert into BSC_CUST_RECOGNITION (
      ORG_ID,
      DEVICE_NO,
      recognition_type,
      row_id,
      date_type,
      start_position,
      mate_length,
      start_mate_code,
      end_mate_code,
      cust_level,
      EXTEND1,
      EXTEND2,
      EXTEND3
   ) select
     targetId,
     targetNo,
      recognition_type,
      row_id,
      date_type,
      start_position,
      mate_length,
      start_mate_code,
      end_mate_code,
      cust_level,
      EXTEND1,
      EXTEND2,
      EXTEND3
    from BSC_CUST_RECOGNITION w where w.org_id = orgId and w.device_no=deviceNo;
    proc_deviceupdateflag(deviceNo,'0');
   ReturnCode:='0';
end if;
 --异常处理
 -- exception
   --   when others then
     --  ReturnCode:='1'; --数据库异常
END proc_bsccustrecognition_copy;
/

prompt
prompt Creating procedure PROC_BSCCUSTRECOGNITION_QUERY
prompt ================================================
prompt
create or replace procedure iqms_new.proc_bsccustrecognition_query (
orgId varchar2,
deviceNo varchar2,
p_cursor out sys_refcursor)
as
   v_sql varchar2(4000);


begin


 --select result
 v_sql := 'select b.*,d.dic_value levelName

 from bsc_cust_recognition b, sys_dic d
 where  b.org_id =:orgId and b.device_no =:deviceNo and  b.cust_level = d.dic_key
 and d.dic_type=''levelName'' order by b.row_id' ;
 OPEN p_cursor FOR v_sql using orgId,deviceNo;



end proc_bsccustrecognition_query;
/

prompt
prompt Creating procedure PROC_BSCCUSTRECOGNITION_REMOVE
prompt =================================================
prompt
CREATE OR REPLACE PROCEDURE iqms_new.proc_bsccustrecognition_remove
(
 orgId varchar2,
 deviceNo varchar2,

 ReturnCode OUT varchar2
)
AS

BEGIN
 delete from  BSC_CUST_RECOGNITION t  where t.org_id = orgId and t.device_no = deviceNo ;
--更新设备状态
--update bsc_device b set b.extend1 = '1' where b.org_id = orgId
--and b.device_no = deviceNo;
proc_deviceupdateflag(deviceNo,'0');
 ReturnCode:='0';
END proc_bsccustrecognition_remove;
/

prompt
prompt Creating procedure PROC_BSCDEVICE_ADD
prompt =====================================
prompt
CREATE OR REPLACE PROCEDURE iqms_new.proc_bscdevice_add
(
 orgId varchar2,
 deviceNo varchar2,
 hostName varchar2,
 ipAddr varchar2,
 macAddr varchar2,
 currtVer varchar2,
 v_producer varchar2,
 installDate varchar2,
 adminName varchar2,
 adminPhone varchar2,
 netorgcode varchar2,--本地网
 orderflag varchar2,--是否可预约
 pextend1  varchar2,
 pextend2  varchar2,
 pextend3  varchar2,
 screenResolution varchar2,
 onlineModel varchar2,
 tpscrollFlag varchar2,
 ReturnCode OUT varchar2
)
AS
iRecCount INTEGER;
custLevel number;
BEGIN

 --查询要增加的记录是否存在
 --select count(1) into iRecCount from DEVICE_INFO t where t.org_code = orgCode and t.device_no = deviceNo;
 select count(1) into iRecCount from BSC_DEVICE t where t.ip_addr=ipAddr or t.device_no = deviceNo;


 if iRecCount > 0 then
   ReturnCode:='3'; --该设备已经存在
 else
   --插入
   insert into BSC_DEVICE (
      ORG_ID,
      DEVICE_NO,
      HOST_NAME，
      IP_ADDR，
      MAC_ADDR,
      CURRT_VER,
      PRODUCER,
      INSTALL_DATE,
      ADMIN_NAME,
      ADMIN_PHONE,
      ONLINE_TIME,
      NET_ORGCODE,
      ORDER_FLAG,

      EXTEND1,
      EXTEND2,
      EXTEND3,
      SCREEN_RESOLUTION,
      Online_Model,
      Tpscroll_Flag
   ) values (
     orgId,
     deviceNo,
     hostName,
     ipAddr,
     macAddr,
     currtVer,
     v_producer,
     to_date(installDate,'yyyy-MM-dd'),
     adminName,
     adminPhone,
     null,
     netorgcode,
     orderflag,

     '1',
     pextend2,
     pextend3,
     screenResolution,
     onlineModel,
     tpscrollFlag
   );

   --在bsc_branch_business里插入菜单'业务类型'
   insert into bsc_branch_business(
   org_id,
   device_no,
   tree_pid,
   tree_id,
   business_type,
   bus_id,
   levelnum,
   max_pick_up)
   values(
   orgId,
   deviceNo,
   '0',
   '1',
   '0',
   1,
   0,
   999
   );
   --插入对应的buztimes
   insert into BSC_SHOW_TIME (
      ORG_ID,
      DEVICE_NO,
      business_id，
      row_id，
      date_type,
      begin_time,
      end_time,
      max_num
   ) values (
     orgId,
     deviceNo,
     1,
     1,
     'H',
     '08:00',
     '23:00',
     999
   );
   insert into BSC_SHOW_TIME (
      ORG_ID,
      DEVICE_NO,
      business_id，
      row_id，
      date_type,
      begin_time,
      end_time,
      max_num
   ) values (
     orgId,
     deviceNo,
     1,
     1,
     'N',
     '08:00',
     '23:00',
     999
   );
   --将设备信息插入bsc_cust_level 表 级别0-9
   custLevel := 0;
   <<repeat_loop>>
   if custLevel < 9 then
     insert into bsc_cust_level (org_id,device_no,cust_level,
     level_name,business_id,prior_time,call_head,
     max_wait_time,ticket_template,is_start)
     values (orgId,
     deviceNo,custLevel,'级别'||custLevel,0,'0',
     '0','0','','1');
   custLevel := custLevel +1;

     GOTO repeat_loop;
   end if;
   ReturnCode:='0';
 end if;
 --异常处理
 -- exception
   --   when others then
     --  ReturnCode:='1'; --数据库异常
END proc_bscdevice_add;
/

prompt
prompt Creating procedure PROC_BSCDEVICE_EDIT
prompt ======================================
prompt
CREATE OR REPLACE PROCEDURE iqms_new.proc_bscdevice_edit
(
 orgId varchar2,
 deviceNo varchar2,
 hostName varchar2,
 ipAddr varchar2,
 macAddr varchar2,
 currtVer varchar2,
 v_producer varchar2,
 installDate varchar2,
 adminName varchar2,
 adminPhone varchar2,
 netorgcode varchar2,--本地网
 orderflag varchar2,--是否可预约
 pextend1  varchar2,
 pextend2  varchar2,
 pextend3  varchar2,
 screenResolution varchar2,
 onlineModel varchar2,
 tpscrollFlag varchar2,
 ReturnCode OUT varchar2
)
AS
iRecCount INTEGER;
BEGIN


 select count(1) into iRecCount from BSC_DEVICE t where t.ip_addr=ipAddr and t.org_id <> orgId;

 if iRecCount > 0 then
   ReturnCode:='2'; --改设备已经存在
   return;
 end if;

 update BSC_DEVICE t set

      t.HOST_NAME = hostName，
      t.IP_ADDR = ipAddr，
      t.MAC_ADDR = macAddr,
      t.PRODUCER = v_producer,
      t.INSTALL_DATE = to_date(installDate,'yyyy-MM-dd'),
      t.ADMIN_NAME = adminName,
      t.ADMIN_PHONE = adminPhone,
      t.NET_ORGCODE = netorgcode,
      t.ORDER_FLAG = orderflag,
      t.EXTEND1 = pextend1,
      t.EXTEND2 = pextend2,
      t.EXTEND3 = pextend3,
      t.screen_resolution = screenResolution,
      t.online_model = onlineModel,
      t.tpscroll_flag = tpscrollFlag
 where t.org_Id = orgId and t.device_no = deviceNo;
 --更新设备状态
--update bsc_device b set b.extend1 = '1' where b.org_id = orgId
--and b.device_no = deviceNo;
proc_deviceupdateflag(deviceNo,'0');
 ReturnCode:='0';
 --异常处理
 -- exception
   --   when others then
     --  ReturnCode:='1'; --数据库异常
END proc_bscdevice_edit;
/

prompt
prompt Creating procedure PROC_BSCDEVICE_NAVADD
prompt ========================================
prompt
CREATE OR REPLACE PROCEDURE iqms_new.proc_bscdevice_navadd
(
 orgId varchar2,
 deviceNo varchar2,
 hostName varchar2,
 ipAddr varchar2,
 macAddr varchar2,
 currtVer varchar2,
 v_producer varchar2,
 installDate varchar2,
 adminName varchar2,
 adminPhone varchar2,
 netorgcode varchar2,--本地网
 orderflag varchar2,--是否可预约
 pextend1  varchar2,
 pextend2  varchar2,
 pextend3  varchar2,
 screenResolution varchar2,
 onlineModel varchar2,
 tpscrollFlag varchar2,
 ReturnCode OUT varchar2
)
AS
iRecCount INTEGER;
addrCount INTEGER;
custLevel number;
BEGIN

 --查询要增加的记录是否存在
 --select count(1) into iRecCount from DEVICE_INFO t where t.org_code = orgCode and t.device_no = deviceNo;
 select count(1) into iRecCount from BSC_DEVICE t where  t.device_no = deviceNo;
 select count(1) into addrCount from BSC_DEVICE t where t.ip_addr = ipAddr and t.device_no != deviceNo;

 if iRecCount > 0 then
   update BSC_DEVICE d set d.host_name=hostName,d.ip_addr=ipAddr,d.mac_addr=macAddr,
   d.currt_ver=currtVer,
   d.producer=v_producer, d.install_date=to_date(substr(installDate,1,10),'yyyy-MM-dd'),
   d.admin_name=adminName,d.admin_phone=adminPhone,d.online_time=null,
   d.net_orgcode=netorgcode,d.order_flag=orderflag,d.screen_resolution=screenResolution,
   d.online_model=onlineModel,d.tpscroll_flag=tpscrollFlag where
   d.device_no = deviceNo;
   commit;
   ReturnCode:='2'; --该设备已经存在 更新设备
 elsif addrCount>0 then
  ReturnCode:='3';--ip地址已存在
 else
   --插入
   insert into BSC_DEVICE (
      ORG_ID,
      DEVICE_NO,
      HOST_NAME，
      IP_ADDR，
      MAC_ADDR,
      CURRT_VER,
      PRODUCER,
      INSTALL_DATE,
      ADMIN_NAME,
      ADMIN_PHONE,
      ONLINE_TIME,
      NET_ORGCODE,
      ORDER_FLAG,

      EXTEND1,
      EXTEND2,
      EXTEND3,
      SCREEN_RESOLUTION,
      Online_Model,
      Tpscroll_Flag
   ) values (
     orgId,
     deviceNo,
     hostName,
     ipAddr,
     macAddr,
     currtVer,
     v_producer,
     to_date(installDate,'yyyy-MM-dd'),
     adminName,
     adminPhone,
     null,
     netorgcode,
     orderflag,

     '1',
     pextend2,
     pextend3,
     screenResolution,
     onlineModel,
     tpscrollFlag
   );

   --在bsc_branch_business里插入菜单'业务类型'
   insert into bsc_branch_business(
   org_id,
   device_no,
   tree_pid,
   tree_id,
   business_type,
   bus_id,
   levelnum,
   max_pick_up)
   values(
   orgId,
   deviceNo,
   '0',
   '1',
   '0',
   1,
   0,
   999
   );
   --插入对应的buztimes
   insert into BSC_SHOW_TIME (
      ORG_ID,
      DEVICE_NO,
      business_id，
      row_id，
      date_type,
      begin_time,
      end_time,
      max_num
   ) values (
     orgId,
     deviceNo,
     1,
     1,
     'H',
     '08:00',
     '23:00',
     999
   );
   insert into BSC_SHOW_TIME (
      ORG_ID,
      DEVICE_NO,
      business_id，
      row_id，
      date_type,
      begin_time,
      end_time,
      max_num
   ) values (
     orgId,
     deviceNo,
     1,
     1,
     'N',
     '08:00',
     '23:00',
     999
   );
   --将设备信息插入bsc_cust_level 表 级别0-9
   custLevel := 0;
   <<repeat_loop>>
   if custLevel < 9 then
     insert into bsc_cust_level (org_id,device_no,cust_level,
     level_name,business_id,prior_time,call_head,
     max_wait_time,ticket_template,is_start)
     values (orgId,
     deviceNo,custLevel,'级别'||custLevel,0,'0',
     '0','0','','1');
   custLevel := custLevel +1;

     GOTO repeat_loop;
   end if;
   ReturnCode:='0';
 end if;
 --异常处理
 -- exception
   --   when others then
     --  ReturnCode:='1'; --数据库异常
END proc_bscdevice_navadd;
/

prompt
prompt Creating procedure PROC_BSCDEVICE_PAGE
prompt ======================================
prompt
create or replace procedure iqms_new.proc_bscdevice_page (orgId in varchar2,
islsflag in varchar2,
orderfield in varchar2,
ordertype in varchar2,
pagesize in number, pageno in number,totalrows out number,p_cursor out sys_refcursor)
as
   v_sql varchar2(4000);
   v_sql_page varchar2(4000);
   v_sql_condition varchar2(2000);
   v_sql_count varchar2(4000);
   v_begin number := (pageno-1)*pagesize+1;
   v_end number := pageno*pagesize;
   v_orgid varchar2(20);
   v_islsflag varchar2(20);
   v_sort varchar2(50);

begin

  ---------------------------------------------------------1.按条件查询数据 start------------------------------------------------------------------

  v_sql_condition := 'select
                      h.rowId rid,
                      h.ORG_ID,
                      og.ORG_CODE,
                      og.ORG_NAME,
                      h.DEVICE_NO,
                      h.HOST_NAME,
                      h.IP_ADDR,
                      h.MAC_ADDR,
                      h.CURRT_VER,
                      h.CURRT_VERNAME,
                      h.LAST_VERNAME,
                      h.LAST_VER,
                      (case when (h.LAST_VER is null or h.CURRT_VER = h.LAST_VER) then ''1'' else ''0'' end) is_lstversion,
                      h.PRODUCER,
                      to_char(h.INSTALL_DATE,''yyyy-MM-dd'') INSTALL_DATE,
                      h.ADMIN_NAME,
                      h.ADMIN_PHONE,
                      h.NET_ORGCODE,
                      h.ORDER_FLAG,
                      h.EXTEND1,
                      h.EXTEND2,
                      h.EXTEND3,
                      h.screen_resolution,
                      h.online_model,
                      h.tpscroll_flag,
                      to_char(h.ONLINE_TIME,''yyyy-MM-dd hh24:mi:ss'') ONLINE_TIME from BSC_DEVICE h
  inner join (select * from sys_org o where o.deleted=0  start with o.org_id =:v_orgid
  connect by prior o.org_id = o.parent_id) og on (h.ORG_ID=og.ORG_ID) ';

-------------------------------------------------2.包裹按条件查询的语句，进行分页 开始------------------------------------------------------------
  if (orderfield is null) then
      v_sort := 'ORG_ID ';
  else
      v_sort := orderfield||' '||ordertype;
  end if;

 --select result
 v_sql := 'select row_number() over ( order by '||v_sort||',rid) rnum,
     tt.ORG_ID,
    tt.ORG_CODE,
    tt.ORG_NAME,
    tt.DEVICE_NO,
    tt.HOST_NAME,
    tt.IP_ADDR,
    tt.MAC_ADDR,
    tt.CURRT_VER,
    tt.CURRT_VERNAME,
    tt.LAST_VERNAME,
    tt.LAST_VER,
    tt.is_lstversion,
    tt.PRODUCER,
    tt.INSTALL_DATE,
    tt.ADMIN_NAME,
    tt.ADMIN_PHONE,
    tt.NET_ORGCODE,
    tt.ORDER_FLAG,
    tt.EXTEND1,
    tt.EXTEND2,
    tt.EXTEND3,
    tt.screen_resolution,
    tt.online_model,
    tt.tpscroll_flag,
    tt.ONLINE_TIME
   from ('||v_sql_condition||') tt ';

   --select count
  v_sql_count := 'select count(1) from ('||v_sql||')';

------------------------------------------------------------3.判断是分页还是查询列表

   if pageno > 0  then
    v_sql_page := 'select * from ('||v_sql||') temp where temp.rnum >= :v_begin and temp.rnum <= :v_end';
     execute immediate v_sql_count into totalrows using orgId;
     OPEN p_cursor FOR v_sql_page using  orgId,v_begin,v_end;
  else
    totalrows:=0; --set default value
    v_sql_page := 'select * from ('||v_sql||') temp ';
    OPEN p_cursor FOR v_sql_page using  orgId;
  end if;




end proc_bscdevice_page;
/

prompt
prompt Creating procedure PROC_BSCDEVICE_REMOVE
prompt ========================================
prompt
CREATE OR REPLACE PROCEDURE iqms_new.proc_bscdevice_remove
(
 orgId varchar2,
 deviceNo varchar2,
 ReturnCode OUT varchar2
)
AS
iRecCount INTEGER;
BEGIN
 --删除所有设备相关的网点配置
 delete from bsc_branch_business t where t.device_no = deviceNo;
 delete from bsc_show_time t where t.device_no = deviceNo;
 delete from bc_ticketform t where t.device_no = deviceNo;
 delete from bsc_win_config t where t.device_no = deviceNo;

 delete from bsc_cust_level t where t.device_no = deviceNo;
 delete from bsc_counterbuz t where t.device_no = deviceNo;
 delete from bsc_cust_recognition t where t.device_no = deviceNo;
 delete from bc_modelstyle t where t.device_no =  deviceNo;
 delete from bc_modelstyle_element t where t.device_no = deviceNo;
 delete from bc_takemodel t where t.device_no = deviceNo;

 delete from  BSC_DEVICE t  where t.org_id = orgId and t.device_no = deviceNo;
 ReturnCode:='0';
END proc_bscdevice_remove;
/

prompt
prompt Creating procedure PROC_BSCDEVUPGRADEPROCESS_ADD
prompt ================================================
prompt
CREATE OR REPLACE PROCEDURE iqms_new.proc_BSCDEVUPGRADEPROCESS_add
(
 deviceNo varchar2,
 patchId varchar2,
 ReturnCode OUT varchar2
)
AS
iRecCount INTEGER;
patchName varchar2(100);
dbFlag varchar2(2);
BEGIN


 --查询要增加的记录是否存在
 select count(1) into iRecCount from BSC_DEVUPGRADE_PROCESS t where t.device_no = deviceNo and t.patch_id = patchId and t.status = 0;

 if iRecCount > 0 then
   ReturnCode:='2'; -- 该设备已经使用过了该升级包
 else

 -- 查询版本的名称和是否包含数据(dbFlag  1-有数据库   0-没有数据)
 select v.patch_name,v.db_flag into patchName,dbFlag from bc_patchversion v where v.id = patchId;

   --插入
   insert into BSC_DEVUPGRADE_PROCESS (
      id,
      device_no,
      patch_id,
      optDate,
      status
   ) values (
     SEQ_UPGRADEPROCESS.NEXTVAL,
     deviceNo,
     patchId,
     sysdate,
      '0' --是否已经下发成功
   );

   -- 将信息更新到设备表中
   update bsc_device d set d.last_ver=patchId,d.last_vername=patchName,d.extend1 = dbFlag where d.device_no = deviceNo;

   ReturnCode:='0';
 end if;
 --异常处理
 -- exception
   --   when others then
     --  ReturnCode:='1'; --数据库异常
END proc_BSCDEVUPGRADEPROCESS_add;
/

prompt
prompt Creating procedure PROC_BSCSHOWTIME_ADD
prompt =======================================
prompt
CREATE OR REPLACE PROCEDURE iqms_new.proc_bscshowtime_add
(
 orgId varchar2,
 deviceNo varchar2,
 businessId varchar2,
 rowId_ varchar2,
 dateType varchar2,
 beginTime varchar2,
 endTime varchar2,
 maxNum varchar2,
 extend1 varchar2,
 extend2 varchar2,
 extend3 varchar2,
 ReturnCode OUT varchar2
)
AS
iRecCount INTEGER;
BEGIN

 --查询要增加的记录是否存在
 --select count(1) into iRecCount from DEVICE_INFO t where t.org_code = orgCode and t.device_no = deviceNo;
 select count(1) into iRecCount from BSC_SHOW_TIME t where t.org_id=orgId and t.device_no = deviceNo
  and t.business_id = businessId and t.row_id = rowId_ and t.date_type = dateType;


 if iRecCount > 0 then
   update BSC_SHOW_TIME t set
      t.ORG_ID = orgId,
      t.DEVICE_NO =deviceNo,
      t.business_id =businessId,
      t.row_id =rowId_,
      t.date_type = dateType,
      t.begin_time = beginTime,
      t.end_time = endTime,
      t.max_num = maxNum,
      t.EXTEND1 =extend1,
      t.EXTEND2 =extend2,
      t.EXTEND3 =extend3
      where t.org_id=orgId
      and t.device_no = deviceNo
      and t.business_id = businessId
      and t.row_id = rowId_
      and t.date_type = dateType;
      --更新设备状态
--update bsc_device b set b.extend1 = '1' where b.org_id = orgId
--and b.device_no = deviceNo;
proc_deviceupdateflag(deviceNo,'0');
   ReturnCode:='0'; --已经存在
 else
   --插入
   insert into BSC_SHOW_TIME (
      ORG_ID,
      DEVICE_NO,
      business_id，
      row_id，
      date_type,
      begin_time,
      end_time,
      max_num,
      EXTEND1,
      EXTEND2,
      EXTEND3
   ) values (
     orgId,
     deviceNo,
     businessId,
     rowId_,
     dateType,
     beginTime,
     endTime,
     maxNum,
     extend1,
     extend2,
     extend3
   );
   --更新设备状态
update bsc_device b set b.extend1 = '1' where b.org_id = orgId
and b.device_no = deviceNo;
   ReturnCode:='0';
 end if;
 --异常处理
 -- exception
   --   when others then
     --  ReturnCode:='1'; --数据库异常
END proc_bscshowtime_add;
/

prompt
prompt Creating procedure PROC_BSCSHOWTIME_COPY
prompt ========================================
prompt
CREATE OR REPLACE PROCEDURE iqms_new.proc_bscshowtime_copy--应用到下级机构
(
 orgId varchar2,
 deviceNo varchar2,
 targetId varchar2,--目标orgId
 targetNo varchar2, --目标deviceNo
 ReturnCode OUT varchar2
)
AS
BEGIN

if orgId != targetId or deviceNo != targetNo then
 --删除目标数据再插入
 delete from BSC_SHOW_TIME b where b.org_id = targetId and b.device_no = targetNo;

   --插入
   insert into BSC_SHOW_TIME (
      ORG_ID,
      DEVICE_NO,
      business_id，
      row_id，
      date_type,
      begin_time,
      end_time,
      max_num,
      EXTEND1,
      EXTEND2,
      EXTEND3
   ) select
     targetId,
     targetNo,
      business_id，
      row_id，
      date_type,
      begin_time,
      end_time,
      max_num,
      EXTEND1,
      EXTEND2,
      EXTEND3
    from BSC_SHOW_TIME w where w.org_id = orgId and w.device_no=deviceNo;
 proc_deviceupdateflag(deviceNo,'0');
  ReturnCode:='0';
end if;
 --异常处理
 -- exception
   --   when others then
     --  ReturnCode:='1'; --数据库异常
END proc_bscshowtime_copy;
/

prompt
prompt Creating procedure PROC_BSCSHOWTIME_EXIST
prompt =========================================
prompt
CREATE OR REPLACE PROCEDURE iqms_new.proc_bscshowtime_exist
(
 orgId varchar2,
 deviceNo varchar2,

 ReturnCode OUT varchar2
)
AS
iRecCount INTEGER;
BEGIN

 --查询要增加的记录是否存在
 --select count(1) into iRecCount from DEVICE_INFO t where t.org_code = orgCode and t.device_no = deviceNo;
 select count(1) into iRecCount from BSC_SHOW_TIME t where t.org_id=orgId and t.device_no = deviceNo;



 if iRecCount > 0 then

  ReturnCode:='0'; --已经存在
 else

   ReturnCode:='1';
 end if;
 --异常处理
 -- exception
   --   when others then
     --  ReturnCode:='1'; --数据库异常
END proc_bscshowtime_exist;
/

prompt
prompt Creating procedure PROC_BSCSHOWTIME_QUERY
prompt =========================================
prompt
create or replace procedure iqms_new.proc_bscshowtime_query (
orgId varchar2,
deviceNo varchar2,
businessId varchar2,
p_cursor out sys_refcursor)
as
   v_sql varchar2(4000);


begin

 v_sql := 'select b.* from bsc_show_time b
 where  b.org_id =:orgId and b.device_no =:deviceNo and b.business_id=:businessId ';

  OPEN p_cursor FOR v_sql using orgId,deviceNo,businessId;




end proc_bscshowtime_query;
/

prompt
prompt Creating procedure PROC_BSCSHOWTIME_REMOVE
prompt ==========================================
prompt
CREATE OR REPLACE PROCEDURE iqms_new.proc_bscshowtime_remove
(
 orgId varchar2,
 deviceNo varchar2,
 businessId varchar2,
 ReturnCode OUT varchar2
)
AS

BEGIN
 delete from  BSC_SHOW_TIME t  where t.org_id = orgId and t.device_no = deviceNo and t.business_id = businessId;
 --更新设备状态
--update bsc_device b set b.extend1 = '1' where b.org_id = orgId
--and b.device_no = deviceNo;
proc_deviceupdateflag(deviceNo,'0');
 ReturnCode:='0';
END proc_bscshowtime_remove;
/

prompt
prompt Creating procedure PROC_BSCWINBUS_QUERY
prompt =======================================
prompt
create or replace procedure iqms_new.PROC_BSCWINBUS_QUERY (
orgId varchar2,
deviceNo varchar2,
winNo varchar2,
buzTypeId varchar2,
p_cursor out sys_refcursor)
as
   v_sql varchar2(4000);


begin
if buzTypeId = '-1' then

 --select result
 v_sql := 'select h.*,dic.dic_value,bsc.business_code,bc.business_name
   from bsc_win_bus h,sys_dic dic,bc_businessmanage bc,
   bsc_branch_business bsc
    where
      h.level_id = dic.dic_key and dic.dic_type=''levelName''
      and h.buz_type_id = bc.business_id and h.buz_type_id = bsc.bus_id
      and bsc.business_type = ''BUS''
     and h.org_id =:orgId and h.device_no =:deviceNo and h.win_no =:winNo';
 OPEN p_cursor FOR v_sql using orgId,deviceNo,winNo;
else
 v_sql := 'select h.*,dic.dic_value,bsc.business_code,bc.business_name
   from bsc_win_bus h,sys_dic dic,bc_businessmanage bc,
   bsc_branch_business bsc
    where
      h.level_id = dic.dic_key and dic.dic_type=''levelName''
      and h.buz_type_id = bc.business_id and h.buz_type_id = bsc.bus_id
      and bsc.business_type = ''BUS''
     and h.org_id =:orgId and h.device_no =:deviceNo and h.win_no =:winNo
     and h.buz_type_id =:buzTypeId';
OPEN p_cursor FOR v_sql using orgId,deviceNo,winNo,buzTypeId;
end if;
end PROC_BSCWINBUS_QUERY;
/

prompt
prompt Creating procedure PROC_BSCWINCONFIG_ADD
prompt ========================================
prompt
CREATE OR REPLACE PROCEDURE iqms_new.proc_bscwinconfig_add
(
 orgId varchar2,
 deviceNo varchar2,
 winNo varchar2,
 isCall varchar2,
 isJudge varchar2,
 winScreen varchar2,
 multipleScreen varchar2,
 isStart varchar2,
 rowId_ varchar2,
 extend1 varchar2,
 extend2 varchar2,
 extend3 varchar2,
 ReturnCode OUT varchar2
)
AS
iRecCount INTEGER;
BEGIN

 --查询要增加的记录是否存在
 --select count(1) into iRecCount from DEVICE_INFO t where t.org_code = orgCode and t.device_no = deviceNo;
 select count(1) into iRecCount from BSC_WIN_CONFIG t where t.win_no=winNo and t.device_no = deviceNo and t.org_id = orgId;

 if iRecCount > 0 then
   update BSC_WIN_CONFIG t set
      t.ORG_ID = orgId,
      t.DEVICE_NO =deviceNo,
      t.WIN_NO =winNo,
      t.IS_CALL =isCall,
      t.IS_JUDGE =isJudge,
      t.WIN_SCREEN =winScreen,
      t.MULTIPLE_SCREEN =multipleScreen,
      t.IS_START =isStart,
      t.ROW_ID = rowId_,
      t.win_id = winNo,
      t.EXTEND1 =extend1,
      t.EXTEND2 =extend2,
      t.EXTEND3 =extend3
      where t.org_id = orgId
      and t.device_no = deviceNo
      and t.row_id = rowId_;
      --更新设备状态
  proc_deviceupdateflag(deviceNo,'0');
   ReturnCode:='0'; --该窗口已经存在
 else
   --插入
   insert into BSC_WIN_CONFIG (
      ORG_ID,
      DEVICE_NO,
      WIN_NO，
      IS_CALL，
      IS_JUDGE,
      WIN_SCREEN,
      MULTIPLE_SCREEN,
      IS_START,
      row_id,
      win_id,
      EXTEND1,
      EXTEND2,
      EXTEND3
   ) values (
     orgId,
     deviceNo,
     winNo,
     isCall,
     isJudge,
     winScreen,
     multipleScreen,
     isStart,
     rowId_,
     winNo,
     extend1,
     extend2,
     extend3
   );
   --更新设备状态
  --update bsc_device b set b.extend1 = '1'
  --where b.org_id = orgId and b.device_no = deviceNo;
  proc_deviceupdateflag(deviceNo,'0');
   ReturnCode:='0';
 end if;
 --异常处理
 -- exception
   --   when others then
     --  ReturnCode:='1'; --数据库异常
END proc_bscwinconfig_add;
/

prompt
prompt Creating procedure PROC_BSCWINCONFIG_COPY
prompt =========================================
prompt
CREATE OR REPLACE PROCEDURE iqms_new.proc_bscwinconfig_copy--应用到下级机构
(
 orgId varchar2,
 deviceNo varchar2,
 targetId varchar2,--目标orgId
 targetNo varchar2, --目标deviceNo
 ReturnCode OUT varchar2
)
AS
BEGIN
 if orgId != targetId or deviceNo != targetNo then
 --删除目标数据再插入
 delete from BSC_WIN_CONFIG b where b.org_id = targetId and b.device_no = targetNo;

   --插入
   insert into BSC_WIN_CONFIG (
      ORG_ID,
      DEVICE_NO,
      WIN_NO,
      win_id,
      IS_CALL,
      IS_JUDGE,
      WIN_SCREEN,
      MULTIPLE_SCREEN,
      IS_START,
      row_id,
      EXTEND1,
      EXTEND2,
      EXTEND3
   ) select
     targetId,
     targetNo,
      WIN_NO,
      WIN_ID,
      IS_CALL,
      IS_JUDGE,
      WIN_SCREEN,
      MULTIPLE_SCREEN,
      IS_START,
      row_id,
      EXTEND1,
      EXTEND2,
      EXTEND3
    from BSC_WIN_CONFIG w where w.org_id = orgId and w.device_no=deviceNo;
    proc_deviceupdateflag(deviceNo,'0');
   ReturnCode:='0';
end if;
 --异常处理
 -- exception
   --   when others then
     --  ReturnCode:='1'; --数据库异常
END proc_bscwinconfig_copy;
/

prompt
prompt Creating procedure PROC_BSCWINCONFIG_EDIT
prompt =========================================
prompt
CREATE OR REPLACE PROCEDURE iqms_new.proc_bscwinconfig_edit
(
 orgId varchar2,
 deviceNo varchar2,
 winNo varchar2,
 isCall varchar2,
 isJudge varchar2,
 winScreen varchar2,
 multipleScreen varchar2,
 isStart varchar2,
 extend1 varchar2,
 extend2 varchar2,
 extend3 varchar2,
 ReturnCode OUT varchar2
)
AS

BEGIN

   update BSC_WIN_CONFIG t set
      t.ORG_ID = orgId,
      t.DEVICE_NO =deviceNo,
      t.WIN_NO =winNo,
      t.IS_CALL =isCall,
      t.IS_JUDGE =isJudge,
      t.WIN_SCREEN =winScreen,
      t.MULTIPLE_SCREEN =multipleScreen,
      t.IS_START =isStart,
      t.EXTEND1 =extend1,
      t.EXTEND2 =extend2,
      t.EXTEND3 =extend3
      where t.org_id = orgId
      and t.device_no = deviceNo
      and t.win_no = winNo;
       proc_deviceupdateflag(deviceNo,'0');

   ReturnCode:='0';
 --异常处理
 -- exception
   --   when others then
     --  ReturnCode:='1'; --数据库异常
END proc_bscwinconfig_edit;
/

prompt
prompt Creating procedure PROC_BSCWINCONFIG_PAGE
prompt =========================================
prompt
create or replace procedure iqms_new.proc_bscwinconfig_page(orgId      varchar2, --机构id
                                                   deviceNo   varchar2,
                                                   orderfield in varchar2,
                                                   ordertype  in varchar2,
                                                   pagesize   in number,
                                                   pageno     in number,
                                                   totalrows  out number,
                                                   p_cursor   out sys_refcursor) as
  v_sql           varchar2(4000);
  v_sql_page      varchar2(4000);
  v_sql_condition varchar2(4000);
  v_sql_count     varchar2(4000);
  v_begin         number := (pageno - 1) * pagesize + 1;
  v_end           number := pageno * pagesize;
  v_sort          varchar2(50);
  v_orgId         varchar2(50) := orgId;
  v_deviceNo      varchar2(50) := deviceNo;

begin
  ---------------------------------------------------------1.按条件查询数据 start------------------------------------------------------------------

  v_sql_condition := ' select h.ORG_ID,h.rowId rid,h.DEVICE_NO,h.WIN_NO,h.IS_CALL,h.IS_JUDGE,h.WIN_SCREEN,
  h.MULTIPLE_SCREEN,h.IS_START,h.EXTEND1,h.EXTEND2,h.EXTEND3,s.org_code,s.org_name from bsc_win_config h,sys_org s
   where h.org_id=s.org_id ';

  if v_orgId != 0 then
    v_sql_condition := v_sql_condition ||
                       ' and h.org_id =:orgId and h.device_no =:deviceNo';
  else
    v_orgId         := 0;
    v_sql_condition := v_sql_condition ||
                       ' and ( h.org_id  is null or h.org_id <>:orgId)';

  end if;

  -------------------------------------------------2.包裹按条件查询的语句，进行分页 开始------------------------------------------------------------
  if (orderfield is null) then
    v_sort := 'org_id ';
  else
    v_sort := orderfield || ' ' || ordertype;
  end if;

  --select result
  v_sql := 'select row_number() over ( order by ' || v_sort || ',rid) rnum,tt.ORG_ID,tt.DEVICE_NO,tt.WIN_NO,tt.IS_CALL,tt.IS_JUDGE,tt.WIN_SCREEN,
  tt.MULTIPLE_SCREEN,tt.IS_START,tt.EXTEND1,tt.EXTEND2,tt.EXTEND3,tt.org_code,tt.org_name
  from (' || v_sql_condition || ') tt ';

  --select count
  v_sql_count := 'select count(1) from (' || v_sql || ')';

  ------------------------------------------------------------3.判断是分页还是查询列表

  if pageno > 0 then
    v_sql_page := 'select * from (' || v_sql ||
                  ') temp where temp.rnum >= :v_begin and temp.rnum <= :v_end';
    execute immediate v_sql_count
      into totalrows
      using v_orgId, v_deviceNo;
    OPEN p_cursor FOR v_sql_page
      using v_orgId, v_deviceNo, v_begin, v_end;
  else
    totalrows  := 0; --set default value
    v_sql_page := 'select * from (' || v_sql || ') temp ';
    OPEN p_cursor FOR v_sql_page
      using v_orgId, v_deviceNo;
  end if;

end proc_bscwinconfig_page;
/

prompt
prompt Creating procedure PROC_BSCWINCONFIG_QUERY
prompt ==========================================
prompt
create or replace procedure iqms_new.proc_bscwinconfig_query (
orgId varchar2, --机构id
deviceNo varchar2,
p_cursor out sys_refcursor)
as
   v_sql varchar2(4000);

begin
---------------------------------------------------------1.按条件查询数据 start------------------------------------------------------------------

  v_sql:= ' select h.*,s.org_name from bsc_win_config h,sys_org s
   where h.org_id =:org_id and h.device_no =:deviceNo and h.org_id = s.org_id';

OPEN p_cursor FOR v_sql using orgId,deviceNo;


end proc_bscwinconfig_query;
/

prompt
prompt Creating procedure PROC_BSCWINCONFIG_REMOVE
prompt ===========================================
prompt
CREATE OR REPLACE PROCEDURE iqms_new.proc_bscwinconfig_remove
(
 orgId varchar2,
 deviceNo varchar2,
 winNo varchar2,
 ReturnCode OUT varchar2
)
AS

BEGIN
 delete from  BSC_WIN_CONFIG t  where t.org_id = orgId and t.device_no = deviceNo;
 --级联删除 bsc_counterbuz
 delete from  bsc_counterbuz t where t.device_no = deviceNo and t.counterid = winNo;
  --更新设备状态
  --update bsc_device b set b.extend1 = '1' where b.org_id = orgId and b.device_no = deviceNo;
 proc_deviceupdateflag(deviceNo,'0');
 ReturnCode:='0';
END proc_bscwinconfig_remove;
/

prompt
prompt Creating procedure PROC_BUZTIMES_QUERY
prompt ======================================
prompt
create or replace procedure iqms_new.proc_buztimes_query (
orgId varchar2,
deviceNo varchar2,
p_cursor out sys_refcursor)
as
   v_sql varchar2(4000);


begin


 --查询bsc_branch_business 生成buzType.json
 v_sql := 'select b.org_id,b.device_no,b.business_id,
 (case when b.date_type = ''N'' then 1 else 2 end) date_type,
b.begin_time,b.end_time,b.max_num
 from bsc_show_time b
 where  b.org_id =:orgId and b.device_no =:deviceNo';
 OPEN p_cursor FOR v_sql using orgId,deviceNo;




end proc_buztimes_query;
/

prompt
prompt Creating procedure PROC_BUZTYPE_QUERY
prompt =====================================
prompt
create or replace procedure iqms_new.proc_buztype_query (
orgId varchar2,
deviceNo varchar2,
p_cursor out sys_refcursor)
as
   v_sql varchar2(4000);


begin


 --查询bsc_branch_business 生成buzType.json
 v_sql := 'select b.org_id,b.device_no,b.business_type,
b.bus_id,
tree_pid,
 b.business_code,
b.prior_time,b.max_pick_up,b.call_head,
decode(b.business_type,''1'',(select bm.business_name from BC_BUSINESSMANAGE bm where b.bus_id= bm.business_id),
 ''0'',(select m.menu_name from bc_menu m where b.bus_id=m.menu_id) ) branchName,
decode(b.business_type,''1'',(select bm.business_ename from BC_BUSINESSMANAGE bm where b.bus_id= bm.business_id),
 ''0'',(select m.menu_enname from bc_menu m where b.bus_id=m.menu_id) ) en_name,
b.is_show_en,b.is_swipe,b.pick_up_advice,b.sort_num,b.levelnum

 from bsc_branch_business b
 where  b.org_id =:orgId and b.device_no =:deviceNo';
 OPEN p_cursor FOR v_sql using orgId,deviceNo;




end proc_buztype_query;
/

prompt
prompt Creating procedure PROC_BUZTYPE_SELECT
prompt ======================================
prompt
create or replace procedure iqms_new.proc_buztype_select
(
orgId varchar2,
deviceNo varchar2,
p_cursor out sys_refcursor
)
as
   v_sql varchar2(4000);
   v_orgid varchar2(50) := orgId;
   v_deviceNo varchar2(50) := deviceNo;
begin

   if orgId is null or deviceNo is null then
       v_sql := 'select b.business_name,a.bus_id from BSC_BRANCH_BUSINESS a
	           inner join bc_businessmanage b on(a.bus_id=b.business_id) where a.business_type=''1''';
       OPEN p_cursor FOR v_sql;
   else
       v_sql := 'select b.business_name,a.bus_id from BSC_BRANCH_BUSINESS a
	           inner join bc_businessmanage b on(a.bus_id=b.business_id) where a.business_type=''1''
             and a.org_id =:orgId and a.device_no =:deviceNo ';
       OPEN p_cursor FOR v_sql using v_orgid,v_deviceNo;
   end if;

end proc_buztype_select;
/

prompt
prompt Creating procedure PROC_CALLSTRATEGY_COPY
prompt =========================================
prompt
CREATE OR REPLACE PROCEDURE iqms_new.proc_callstrategy_copy--应用到下级机构
(
 orgId varchar2,
 deviceNo varchar2,
 targetId varchar2,--目标orgId
 targetNo varchar2, --目标deviceNo
 ReturnCode OUT varchar2
)
AS
BEGIN

if orgId != targetId or deviceNo != targetNo then
 --删除目标数据再插入
 delete from bsc_counterbuz b where b.org_id = targetId and b.device_no = targetNo;

   --插入
   insert into bsc_counterbuz (
      ORG_ID,
      DEVICE_NO,
      counterid,
      datetypeid，
      buztypeid,
      levelid,
      buzprioritytime,
      custprioritytime,
      maxwaiting

   ) select
     targetId,
     targetNo,
     counterid,
      datetypeid，
      buztypeid,
      levelid,
      buzprioritytime,
      custprioritytime,
      maxwaiting
    from bsc_counterbuz w where w.org_id = orgId and w.device_no=deviceNo;
    proc_deviceupdateflag(deviceNo,'0');
   ReturnCode:='0';
end if;
 --异常处理
 -- exception
   --   when others then
     --  ReturnCode:='1'; --数据库异常
END proc_callstrategy_copy;
/

prompt
prompt Creating procedure PROC_CLEARTRXTODAY
prompt =====================================
prompt
create or replace procedure iqms_new.proc_cleartrxtoday
 as
    --(删除掉当天除了弃号和完成的数据,或者删除掉当天办理完成但是开始办理时间和结束办理时间相同的记录)
    cursor delerrdata_cur is select * from trx_today t where (t.trx_status <> '2'  and  t.trx_status <> '3')
    or (t.trx_status = '2' and t.begin_time = t.end_time);
 begin
      --遍历游标删除异常数据
      for cur_type in delerrdata_cur
        loop
          delete from trx_history h where h.org_id=cur_type.org_id and h.device_no=cur_type.device_no
          and h.trx_date=cur_type.trx_date and h.flow_no = cur_type.flow_no;
          commit;
        end loop;
      DBMS_Utility.Exec_DDL_Statement('truncate table trx_today');
 end proc_cleartrxtoday;
/

prompt
prompt Creating procedure PROC_CONFIGCONFIRM
prompt =====================================
prompt
CREATE OR REPLACE PROCEDURE iqms_new.proc_configConfirm
(
 deviceId varchar2,
 ReturnCode OUT varchar2  -- 1-失败，记录不存在     0-成功
)
AS
iRecCount INTEGER;
BEGIN

 --查询柜员是否存在versionSeq
 select count(1) into iRecCount from bsc_device t where t.device_no = deviceId;

 if iRecCount > 0 then -- 更新下载日期
    update bsc_device t set t.extend1 = '0' where t.device_no = deviceId;
     ReturnCode:='0';
 else
   ReturnCode:='1';
 end if;
 --异常处理
 -- exception
   --   when others then
     --  ReturnCode:='1'; --数据库异常
END proc_configConfirm;
/

prompt
prompt Creating procedure PROC_COUNTERBUZBYWINID_SELECT
prompt ================================================
prompt
create or replace procedure iqms_new.proc_counterbuzbywinid_select
(
orgId varchar2,
deviceNo varchar2,
winId varchar2,
p_cursor out sys_refcursor
)
as
   v_sql varchar2(4000);
   v_orgid varchar2(50) := orgId;
   v_deviceNo varchar2(50) := deviceNo;
   v_winId varchar2(50) := winId;
begin

   if orgId is null or deviceNo is null then
       v_sql := 'select * from BSC_CounterBuz b where b.counterid =:v_winId ';
       OPEN p_cursor FOR v_sql using v_winId;
   else
       v_sql := 'select * from BSC_CounterBuz b where b.counterid =:v_winId
       and b.org_id =:v_orgid and b.device_no =:v_deviceNo';
       OPEN p_cursor FOR v_sql using v_winId,v_orgid,v_deviceNo;
   end if;

end proc_counterbuzbywinid_select;
/

prompt
prompt Creating procedure PROC_COUNTERBUZS_ADD
prompt =======================================
prompt
create or replace procedure iqms_new.proc_counterbuzs_add
(
v_orgId varchar2,
v_deviceNo varchar2,
v_counterId varchar2,
v_dateTypeId varchar2,
v_busId varchar2,
v_custLevel varchar2,
v_buzPriorityTime varchar2,
v_custPriorityTime varchar2,
v_maxWaitTime varchar2,
ReturnCode out varchar2
)
is
iRecCount INTEGER;
v_count INTEGER;
begin

   if v_orgId is null or v_deviceNo is null then
      --查询要增加的记录是否存在
     select count(1) into iRecCount from BSC_CounterBuz t where t.counterid = v_counterId ;
     if iRecCount >0 then
        select count(1) into v_count from BSC_CounterBuz t where t.counterid = v_counterId and t.datetypeid = v_dateTypeId
        and t.buztypeid = v_busId and t.levelid = v_custLevel;

        if v_count>0 then
          delete from BSC_CounterBuz b where b.counterid = v_counterId and b.datetypeid=v_dateTypeId and b.buztypeid=v_busId
          and b.levelid=v_custLevel;

          insert into BSC_CounterBuz b
          (b.counterId,
           b.dateTypeId,
           b.buzTypeId,
           b.levelId,
           b.buzPriorityTime,
           b.custPriorityTime,
           b.maxWaiting，
           b.org_id,
           b.device_no
          )values
          (v_counterId,
           v_dateTypeId,
           v_busId,
           v_custLevel,
           v_buzPriorityTime,
           v_custPriorityTime,
           v_maxWaitTime,
           v_orgId,
           v_deviceNo
          );
          ReturnCode:='0';
          proc_deviceupdateflag(v_deviceNo,'0');
        else
          insert into BSC_CounterBuz b
          (b.counterId,
           b.dateTypeId,
           b.buzTypeId,
           b.levelId,
           b.buzPriorityTime,
           b.custPriorityTime,
           b.maxWaiting,
           b.org_id,
           b.device_no
          )values
          (v_counterId,
           v_dateTypeId,
           v_busId,
           v_custLevel,
           v_buzPriorityTime,
           v_custPriorityTime,
           v_maxWaitTime,
           v_orgId,
           v_deviceNo
          );
          ReturnCode:='0';
          proc_deviceupdateflag(v_deviceNo,'0');
       end if;
     else
        insert into BSC_CounterBuz b
          (b.counterId,
           b.dateTypeId,
           b.buzTypeId,
           b.levelId,
           b.buzPriorityTime,
           b.custPriorityTime,
           b.maxWaiting,
           b.org_id,
           b.device_no
          )values
          (v_counterId,
           v_dateTypeId,
           v_busId,
           v_custLevel,
           v_buzPriorityTime,
           v_custPriorityTime,
           v_maxWaitTime,
           v_orgId,
           v_deviceNo
          );
        ReturnCode:='0';
        proc_deviceupdateflag(v_deviceNo,'0');
    end if;
   else
      --查询要增加的记录是否存在
     select count(1) into iRecCount from BSC_CounterBuz t where t.counterid = v_counterId
     and t.org_id = v_orgId and t.device_no = v_deviceNo;

     if iRecCount >0 then
        select count(1) into v_count from BSC_CounterBuz t where t.counterid = v_counterId and t.datetypeid = v_dateTypeId
        and t.buztypeid = v_busId and t.levelid = v_custLevel and t.org_id = v_orgId and t.device_no = v_deviceNo;

        if v_count>0 then
          delete from BSC_CounterBuz b where b.counterid = v_counterId and b.datetypeid=v_dateTypeId and b.buztypeid=v_busId
          and b.levelid=v_custLevel  and b.org_id = v_orgId and b.device_no = v_deviceNo;

          insert into BSC_CounterBuz b
          (b.counterId,
           b.dateTypeId,
           b.buzTypeId,
           b.levelId,
           b.buzPriorityTime,
           b.custPriorityTime,
           b.maxWaiting，
           b.org_id,
           b.device_no
          )values
          (v_counterId,
           v_dateTypeId,
           v_busId,
           v_custLevel,
           v_buzPriorityTime,
           v_custPriorityTime,
           v_maxWaitTime,
           v_orgId,
           v_deviceNo
          );
          ReturnCode:='0';
          proc_deviceupdateflag(v_deviceNo,'0');
        else
          insert into BSC_CounterBuz b
          (b.counterId,
           b.dateTypeId,
           b.buzTypeId,
           b.levelId,
           b.buzPriorityTime,
           b.custPriorityTime,
           b.maxWaiting,
           b.org_id,
           b.device_no
          )values
          (v_counterId,
           v_dateTypeId,
           v_busId,
           v_custLevel,
           v_buzPriorityTime,
           v_custPriorityTime,
           v_maxWaitTime,
           v_orgId,
           v_deviceNo
          );
          ReturnCode:='0';
          proc_deviceupdateflag(v_deviceNo,'0');
       end if;
     else
        insert into BSC_CounterBuz b
          (b.counterId,
           b.dateTypeId,
           b.buzTypeId,
           b.levelId,
           b.buzPriorityTime,
           b.custPriorityTime,
           b.maxWaiting,
           b.org_id,
           b.device_no
          )values
          (v_counterId,
           v_dateTypeId,
           v_busId,
           v_custLevel,
           v_buzPriorityTime,
           v_custPriorityTime,
           v_maxWaitTime,
           v_orgId,
           v_deviceNo
          );
        ReturnCode:='0';
        proc_deviceupdateflag(v_deviceNo,'0');
    end if;

   end if;


        --异常处理
        -- exception
         --   when others then
          --  ReturnCode:='1'; --数据库异常

end proc_counterbuzs_add;
/

prompt
prompt Creating procedure PROC_COUNTERBUZS_QUERY
prompt =========================================
prompt
create or replace procedure iqms_new.proc_counterBuzs_query (
orgId varchar2,
deviceNo varchar2,
counterId varchar2,
p_cursor out sys_refcursor)
as
   v_sql varchar2(4000);


begin


 --查询bsc_win_config 生成counters.json
 v_sql := 'select b.buzprioritytime,b.custprioritytime,b.maxwaiting,
b.levelid,bus.business_name cnName,c.cust_name levelName,
bsc.business_code buzCode,b.buztypeid,''T'' saveDjStatus,b.counterid,
b.datetypeid
from bsc_counterbuz b,bsc_branch_business bsc,bc_custtype c,
bc_businessmanage bus
 where b.buztypeid = bsc.bus_id and bsc.business_type=''BUS''
 and c.cust_level = b.levelid and bus.business_id = b.buztypeid
 and  b.org_id =:orgId and b.device_no =:deviceNo and b.counterid =:counterId ';
 OPEN p_cursor FOR v_sql using orgId,deviceNo,counterId;




end proc_counterBuzs_query;
/

prompt
prompt Creating procedure PROC_COUNTERBUZ_DELETE
prompt =========================================
prompt
create or replace procedure iqms_new.proc_counterbuz_delete
(
orgId varchar2,
deviceNo varchar2,
winId varchar2,
ReturnCode out varchar2
)
as
   v_sql varchar2(4000);

begin

   if orgId is null or deviceNo is null then
       delete from BSC_CounterBuz b where b.counterId = winId;
       ReturnCode:='0';
   else
       delete from BSC_CounterBuz b where b.counterId = winId
       and b.org_id = orgId and b.device_no = deviceNo;
       ReturnCode:='0';
   end if;
   proc_deviceupdateflag(deviceNo,'0');

end proc_counterbuz_delete;
/

prompt
prompt Creating procedure PROC_COUNTERBUZ_SELECT
prompt =========================================
prompt
create or replace procedure iqms_new.proc_counterbuz_select
(
orgId varchar2,
deviceNo varchar2,
p_cursor out sys_refcursor
)
as
   v_sql varchar2(4000);
   v_orgid varchar2(50) := orgId;
   v_deviceNo varchar2(50) := deviceNo;
   v_orgid2 varchar2(50) := orgId;
   v_deviceNo2 varchar2(50) := deviceNo;
begin

   if orgId is null or deviceNo is null then
       v_sql := 'select m.bus_id,m.business_code,m.business_name,m.prior_time buzPriorityTime,n.cust_level,n.level_name,n.prior_time custPriorityTime,n.max_wait_time from
          (select a.business_code,b.business_name,a.prior_time,a.bus_id from BSC_BRANCH_BUSINESS a inner join bc_businessmanage b on(a.bus_id=b.business_id) where a.business_type=''1''
          ) m,
          (select a.cust_level,a.prior_time,a.max_wait_time,a.level_name from BSC_CUST_LEVEL a
          where a.is_start=1) n
          order by m.business_name,n.cust_level';
       OPEN p_cursor FOR v_sql;
   else
       v_sql := 'select m.bus_id,m.business_code,m.business_name,m.prior_time buzPriorityTime,n.cust_level,n.level_name,n.prior_time custPriorityTime,n.max_wait_time from
          (select a.business_code,b.business_name,a.prior_time,a.bus_id from BSC_BRANCH_BUSINESS a inner join bc_businessmanage b on(a.bus_id=b.business_id) where a.business_type=''1''
          and  a.org_id =:v_orgid and a.device_no =:v_deviceNo) m,
          (select a.cust_level,a.prior_time,a.max_wait_time,a.level_name from BSC_CUST_LEVEL a
          where a.is_start=1 and a.org_id =:v_orgid2 and a.device_no =:v_deviceNo2) n
          order by m.business_name,n.cust_level';
       OPEN p_cursor FOR v_sql using v_orgid,v_deviceNo,v_orgid2,v_deviceNo2;
   end if;

end proc_counterbuz_select;
/

prompt
prompt Creating procedure PROC_COUNTERID_QUERY
prompt =======================================
prompt
create or replace procedure iqms_new.proc_counterId_query (
orgId varchar2,
deviceNo varchar2,
p_cursor out sys_refcursor)
as
   v_sql varchar2(4000);


begin


 --查询bsc_win_config 生成counters.json
 v_sql := 'select distinct(b.counterid) from bsc_counterbuz b
 where  b.org_id =:orgId and b.device_no =:deviceNo';
 OPEN p_cursor FOR v_sql using orgId,deviceNo;




end proc_counterId_query;
/

prompt
prompt Creating procedure PROC_COUNTERID_SELECT
prompt ========================================
prompt
create or replace procedure iqms_new.proc_counterid_select
(
orgId varchar2,
deviceNo varchar2,
p_cursor out sys_refcursor
)
as
 v_sql varchar2(4000);
 v_orgid varchar2(50) := orgId;
 v_deviceNo varchar2(50) := deviceNo;

begin

 v_sql := 'select distinct(b.counterid) from bsc_counterbuz b
           where  b.org_id =:v_orgid and b.device_no =:v_deviceNo';

 OPEN p_cursor FOR v_sql using v_orgid,v_deviceNo;


end proc_counterid_select;
/

prompt
prompt Creating procedure PROC_COUNTERS_QUERY
prompt ======================================
prompt
create or replace procedure iqms_new.proc_counters_query (
orgId varchar2,
deviceNo varchar2,
p_cursor out sys_refcursor)
as
   v_sql varchar2(4000);


begin


 --查询bsc_win_config 生成counters.json
 v_sql := 'select b.win_no counterId,
''inserted''  saveStatus,
b.win_no counterNo,
b.is_start enabled,
b.win_screen caller,
b.win_screen evaluator,
b.win_screen barscn,
b.multiple_screen cmpscn
from bsc_win_config b
 where  b.org_id =:orgId and b.device_no =:deviceNo';
 OPEN p_cursor FOR v_sql using orgId,deviceNo;




end proc_counters_query;
/

prompt
prompt Creating procedure PROC_CUSTLEVELS_QUERY
prompt ========================================
prompt
create or replace procedure iqms_new.proc_custlevels_query (
orgId varchar2,
deviceNo varchar2,
p_cursor out sys_refcursor)
as
   v_sql varchar2(4000);


begin


 --bsc_cust_level 生成custLevels.json
 v_sql := 'select bsc.cust_level, bsc.level_name, bsc.business_id,
bsc.prior_time, bsc.call_head, bsc.max_wait_time, bsc.ticket_template,
bsc.is_start
from bsc_cust_level bsc
where bsc.org_id =:orgId and bsc.device_no =:deviceNo ';
 OPEN p_cursor FOR v_sql using orgId,deviceNo;




end proc_custlevels_query;
/

prompt
prompt Creating procedure PROC_CUSTRECS_QUERY
prompt ======================================
prompt
create or replace procedure iqms_new.proc_custrecs_query (
orgId varchar2,
deviceNo varchar2,
p_cursor out sys_refcursor)
as
   v_sql varchar2(4000);


begin


 --bsc_cust_level 生成custLevels.json
 v_sql := 'select bsc.date_type, bsc.start_position,
bsc.MATE_LENGTH, bsc.start_mate_code,
bsc.end_mate_code, bsc.cust_level, ''inserted'' saveStatus
from bsc_cust_recognition bsc
where bsc.org_id =:orgId and bsc.device_no =:deviceNo ';
 OPEN p_cursor FOR v_sql using orgId,deviceNo;




end proc_custrecs_query;
/

prompt
prompt Creating procedure PROC_DEVICE_SELECT
prompt =====================================
prompt
create or replace procedure iqms_new.proc_device_select
(
orgId varchar2,
deviceNo varchar2,
p_cursor out sys_refcursor
)
is
 v_sql varchar2(4000);
 v_orgid varchar2(50) := orgId;
 v_deviceNo varchar2(50) := deviceNo;

begin

            v_sql := ' select b.buzprioritytime,b.custprioritytime,b.maxwaiting,b.levelid,bus.business_name cnName,
                     cus.level_name levelName,bsc.business_code buzCode,b.buztypeid,''true'' saveDjStatus,b.counterid,b.datetypeid
                     from BSC_CounterBuz b
                     inner join bc_businessmanage bus on(b.buztypeid=bus.business_id)
                     inner join bsc_cust_level cus on(b.levelid=cus.cust_level and cus.device_no =:v_deviceNo)
                     inner join BSC_BRANCH_BUSINESS bsc on(b.buztypeid=bsc.bus_id and bsc.device_no =:v_deviceNo)
                     where b.org_id =:v_orgid and b.device_no =:v_deviceNo';

          open p_cursor FOR v_sql using v_deviceNo,v_deviceNo,v_orgid,v_deviceNo;

end proc_device_select;
/

prompt
prompt Creating procedure PROC_DIC_QUERY
prompt =================================
prompt
create or replace procedure iqms_new.proc_dic_query (
dicType varchar2, --类型名称
p_cursor out sys_refcursor)
as
   v_sql varchar2(4000);
   v_dicType varchar2(50) := dicType;

begin
---------------------------------------------------------1.按条件查询数据 start------------------------------------------------------------------
 v_sql := 'select dic_key,dic_value from SYS_DIC dic where 1=1 ';
 v_sql := v_sql || ' and dic.dic_type =:dicType';
 OPEN p_cursor FOR v_sql using  v_dicType;

end proc_dic_query;
/

prompt
prompt Creating procedure PROC_EXISTACTNO
prompt ==================================
prompt
CREATE OR REPLACE PROCEDURE iqms_new.proc_existActNo
(
 orgCode IN varchar2,  -- 机构编码
 actNo IN varchar2,    -- 激活码
 orderDt in varchar2, -- 预预约日期  2017-10-21
 ReturnCode out varchar2  -- 返回结果  1-可用   0-不可用

)
AS
  recordExists INTEGER DEFAULT 0;

BEGIN
  ReturnCode := 1; -- 可以预约
  -- 查询激活码是否可用，此机构预约日期激活码不重复
 SELECT COUNT(1)  INTO recordExists FROM order_info i  WHERE i.org_code = orgCode
                                                               --and r.dev_no = devNo
                                                               and i.act_no = actNo
                                                               and order_date = orderDt;

  if recordExists > 0 then
     ReturnCode := 0; -- 不可用
     return;
  end if;

END proc_existActNo;
/

prompt
prompt Creating procedure PROC_EXISTBOOKRECORD
prompt =======================================
prompt
CREATE OR REPLACE PROCEDURE iqms_new.PROC_EXISTBOOKRECORD
(
 orgCode IN varchar2,  -- 机构编码
 devNo IN varchar2,    -- 设备号
 certType in varchar2, -- 证件类型
 certContent in varchar2, -- 证件号
 orderTime  in varchar2, -- 预约时间点（废弃不使用）
 orderDt in varchar2, -- 预预约日期  2017-10-21
 beginTime in varchar2, --开始时间段
 endTime in varchar2,-- 结束时间段
 ReturnCode out varchar2  -- 返回结果  0-可以预约   1-预约已经存在

)
AS
  recordExists INTEGER DEFAULT 0;
  orderCount INTEGER DEFAULT 0;
  canOrderCount varchar2(50);
  rangeExists INTEGER DEFAULT 0;  -- 预约时间点所在时间段是否存在
  rangeTotalCount  INTEGER DEFAULT 0; -- 时间段可预约的总数量
BEGIN
  ReturnCode := 0; -- 可以预约
  -- 查询此人是否已经预约过了(当天这个营业厅，这个验证类型，且不是取消的)
  SELECT COUNT(1)  INTO recordExists FROM order_info i  WHERE i.org_code = orgCode
                                                               --and r.dev_no = devNo
                                                               and i.cert_type = certType
                                                               and i.cert_content = certContent
                                                               and i.order_status <> '2'  --
                                                               and order_date = orderDt;



  if recordExists > 0 then
     ReturnCode := 1; -- 该客户今天已经预约过了
     return;
  end if;


  -- 查询预约时间段是否存在
  select count(1) into rangeExists from order_range r where r.device_no = devNo  --预约网点
                                           and  r.begin_time =  beginTime
                                           and  r.end_time =  endTime;

   if rangeExists = 1 then  -- 查询预约时间段的放号数量

      select r.ordercount into rangeTotalCount from order_range r where r.device_no = devNo  --预约网点
                                           and  r.begin_time =  beginTime
                                           and  r.end_time =  endTime;
   else
     ReturnCode := 2; -- 预约的时间段，没有对应的时间段
     return;
   end if;


  -- 查询该网点的此时间段预约情况(一个网点，同一日期，同一时间段，有效的预约数量)
select count(1) into orderCount from order_info i  WHERE i.dev_no = devNo
                                                           and i.range_begin = beginTime
                                                           and i.range_end = endTime
                                                           and i.order_status <> '2'  --
                                                           and i.order_date = orderDt;

  -- 判断是否有多余的预约数量
  if rangeTotalCount <= orderCount then
     ReturnCode := 3; -- 预约时间段，已经被预约完了
     return;
  end if ;
   ReturnCode := 0;

END PROC_EXISTBOOKRECORD;
/

prompt
prompt Creating procedure PROC_EXTFLOWDATAPAD
prompt ======================================
prompt
create or replace procedure proc_extflowdatapad (
orgCode varchar2, --机构编码
deviceNo varchar2,
showCount in varchar2,
p_cursor out sys_refcursor)
as
   v_sql varchar2(4000);
   v_sql_condition varchar2(2000);
begin
---------------------------------------------------------1.按条件查询数据 start------------------------------------------------------------------

  v_sql_condition := 'select
    h.org_id,
    h.device_no,
    to_char(h.trx_date,''yyyy-MM-dd'') trx_date,
    h.flow_no,
    h.bus_id,
    h.bus_type,
    h.cust_type,
    h.pdj_level,
    h.ticket_type,
    h.ticket_no,
    h.cust_id,
    h.card_type,
    h.card_no,
    h.manager_no,
    h.trx_type,
    h.trx_status,
    h.cust_name,
    (select count(1) from trx_today t where t.bus_id=h.bus_id and t.org_id=s.org_id and t.pdj_level = h.pdj_level and t.trx_date = h.trx_date and t.trx_status=1 and t.print_time <=h.print_time) wait_num,
    to_char(h.print_time,''yyyy-MM-dd hh24:mi:ss'') print_time,
    to_char(h.call_time,''yyyy-MM-dd hh24:mi:ss'') call_time,
    to_char(h.begin_time,''yyyy-MM-dd hh24:mi:ss'') begin_time,
    to_char(h.end_time,''yyyy-MM-dd hh24:mi:ss'') end_time,
    h.app_value,
    h.win_no,
    h.teller_no,
    h.recall_count,
    h.pause_begintime,
    h.pause_endtime,
    h.call_type,
    h.transfer_count,
    h.buz_flag,
    h.extend1,
    h.extend2,
    h.extend3,
    s.org_code,
    s.org_name,
    b.business_name
    from trx_today h left join sys_org s on (h.org_id=s.org_id)
                                 left join BC_BUSINESSMANAGE b on (h.bus_id=b.BUSINESS_ID)

 where s.org_code=:org_code and h.device_no =:deviceNo  and to_char(h.trx_date,''yyyy-MM-dd'')=to_char(sysdate,''yyyy-MM-dd'') order  by h.print_time desc';
 -- 获取行号
 v_sql := 'select rownum rnum, temp.* from ('||v_sql_condition||') temp ';

  v_sql := 'select * from ('||v_sql||') f where f.rnum <= :showCount ';

 OPEN p_cursor FOR v_sql using orgCode,deviceNo,showCount;

end proc_extflowdatapad;
/

prompt
prompt Creating procedure PROC_EXTFLOWDATA_SAVE
prompt ========================================
prompt
CREATE OR REPLACE PROCEDURE proc_extflowdata_save
(
 orgId varchar2,     -- 1001
 deviceNo varchar2 ,  --A0:1D:48:B1:C0:8F
 trxDate varchar2,    -- yyyy-MM-dd需要转换
 flowNo varchar2 ,
 busId varchar2,
  busType varchar2,
 custType varchar2 ,
  pdjLevel number,
 ticketType varchar2 ,
  ticketNo varchar2,
 custId varchar2 ,
  cardType varchar2,
 cardNo varchar2 ,
 managerNo varchar2 ,
 trxType varchar2,
 trxStatus varchar2,
 printTime varchar2 , --要转时间
  callTime varchar2, --要转时间
 beginTime varchar2 ,--要转时间
  endTime varchar2, --要转时间
 appValue varchar2 ,
  winNo varchar2,
 tellerNo varchar2 ,
 recallCount varchar2,
 pauseBeginTime varchar2,
 pauseEndTime varchar2,
 callType varchar2,
 transferCount varchar2,
 buzFlag varchar2,
 extend_1 varchar2 ,
 extend_2 varchar2 ,
 extend_3 varchar2 ,
 custName varchar2,
 birthDay varchar2,
 headPhoto varchar2,
 ReturnCode OUT varchar2
)
AS
iRecCount INTEGER;
v_custType varchar2(20);
BEGIN

 --查询要更新的记录是否存储
 select count(1) into iRecCount from TRX_TODAY t where t.org_id=orgId and t.DEVICE_NO=deviceNo and to_char(t.TRX_DATE,'yyyyMMdd')=trxDate and t.FLOW_NO=flowNo;
--修改该窗口下其他为 正在办理状态的 流水 为已完成
if trxStatus ='2' then
  update TRX_TODAY t set t.trx_status = '3' where t.win_no = winNo and 
  t.device_no = deviceNo and t.org_id=orgId and t.FLOW_NO != flowNo;
  commit;
end if;
if custType = '0' then
   v_custType :='00';
   end if;
 if iRecCount > 0 then
   --更新
   update TRX_TODAY t set t.bus_type=busType,t.bus_id = busId,t.cust_type=v_custType,t.pdj_level=pdjLevel,t.ticket_type=ticketType,
                          t.ticket_no=ticketNo,t.cust_id=custId,t.card_type=cardType,t.card_no=cardNo,t.manager_no=managerNo,t.trx_type = trxType,
                          t.trx_status=trxStatus,
                          t.print_time=case when printTime='' then null else to_date(printTime,'yyyy-MM-dd HH24:mi:ss') end,
                          t.call_time=case when callTime='' then null else to_date(callTime,'yyyy-MM-dd HH24:mi:ss') end,
                          t.begin_time=case when beginTime='' then null else to_date(beginTime,'yyyy-MM-dd HH24:mi:ss') end,
                          t.end_time=case when endTime='' then null else to_date(endTime,'yyyy-MM-dd HH24:mi:ss') end,
                          t.app_value=appValue,t.win_no=winNo,t.teller_no=tellerNo,t.recall_count=recallCount,t.pause_begintime=pauseBeginTime,t.pause_endtime=pauseEndTime,
                          t.call_type=callType,t.transfer_count=transferCount,t.buz_flag=buzFlag,
                          t.cust_name=custName,t.birth_day=birthDay,t.head_photo=headPhoto,
                          t.extend1=extend_1,t.extend2=extend_2,t.extend3=extend_3
   where t.ORG_ID=orgId and t.DEVICE_NO=deviceNo and to_char(t.TRX_DATE,'yyyyMMdd')=trxDate and t.FLOW_NO=flowNo;
   commit;
   ReturnCode:='0';
 else
   --插入
   insert into TRX_TODAY t (ORG_ID,DEVICE_NO,TRX_DATE,FLOW_NO,bus_id,BUS_TYPE,
      cust_type,PDJ_LEVEL,TICKET_TYPE,TICKET_NO,CUST_ID,CARD_TYPE,
      CARD_NO,MANAGER_NO,trx_type,TRX_STATUS,PRINT_TIME, CALL_TIME, BEGIN_TIME,END_TIME,APP_VALUE, WIN_NO, TELLER_NO,recall_count,pause_begintime,
      pause_endtime,call_type,transfer_count,buz_flag,EXTEND1,EXTEND2,EXTEND3,cust_name,
      birth_day,head_photo
   ) values (
     orgId,deviceNo,to_date(trxDate,'yyyyMMdd'), flowNo,busId,busType,
     v_custType,pdjLevel,ticketType,ticketNo,custId,cardType,
     cardNo,managerNo,trxType,trxStatus,
    case when printTime='' then null else to_date(printTime,'yyyy-MM-dd HH24:mi:ss') end,
    case when callTime='' then null else to_date(callTime,'yyyy-MM-dd HH24:mi:ss') end,
    case when beginTime='' then null else to_date(beginTime,'yyyy-MM-dd HH24:mi:ss') end,
    case when endTime='' then null else to_date(endTime,'yyyy-MM-dd HH24:mi:ss') end,
     appValue,winNo,tellerNo,recallCount,pauseBeginTime,pauseEndTime,callType,transferCount,buzFlag,
     extend_1,extend_2,extend_3,custName,birthDay,headPhoto
   );
   commit;
   ReturnCode:='0';
 end if;
 --异常处理
 -- exception
  --    when others then
  --     ReturnCode:='1';
END proc_extflowdata_save;
/

prompt
prompt Creating procedure PROC_EXTFLOWNEARNET
prompt ======================================
prompt
create or replace procedure iqms_new.proc_extflownearnet (
orgCode varchar2, --机构编码
p_cursor out sys_refcursor)
as
   v_sql varchar2(4000);
   v_sql_condition varchar2(2000);
   v_near1 number;
   v_near2 number;
   v_near3 number;
   v_near4 number;
   v_near5 number;
   v_near6 number;
   v_orgId number;
   v_sql_error varchar2(1000);
   v_hasFlag number;
begin
---------------------------------------------------------1.按条件查询数据 start------------------------------------------------------------------

 -- 没有数据的sql
 v_sql_error := 'select * from sys_org where  1=2';

 -- 1.查询机构是否存在
 select count(1) into v_hasFlag from sys_org o where o.org_code = orgCode;
 if v_hasFlag = 0 then   -- 执行错误的返回
   OPEN p_cursor FOR v_sql_error;
   return;
 end if;

 -- 将机构号查询出来
 select o.org_id into v_orgId from sys_org o where o.org_code = orgCode;

 -- 2.查询机构的临近网点配置
 select count(1) into v_hasFlag from bc_near n where n.org_id = v_orgId;

 if v_hasFlag = 0 then   -- 执行错误的返回
   OPEN p_cursor FOR v_sql_error;
   return;
 end if;


 -- 3.查询出所有的临近网点
 select n.org_id1,n.org_id2,n.org_id3,n.org_id4,n.org_id5,n.org_id6 into v_near1,v_near2,v_near3,v_near4,v_near5,v_near6  from bc_near n where n.org_id = v_orgId;


 --4.查询所有临近网点信息
 open p_cursor for select * from sys_org o where o.org_id in (v_near1,v_near2,v_near3,v_near4,v_near5,v_near6);

end proc_extflownearnet;
/

prompt
prompt Creating procedure PROC_EXTHEARTBEAT
prompt ====================================
prompt
CREATE OR REPLACE PROCEDURE iqms_new.proc_extheartbeat
(
 orgId varchar2,
 deviceNo varchar2 ,
 cpuRatio varchar2,
 memRatio varchar2 ,
 diskRatio varchar2,
 versionSeq varchar2,
 thermalPrinterStatus varchar2 ,
 needlePrinterStatus number,
 idReaderStatus varchar2 ,
 swReadStatus varchar2,
 icReaderStatus varchar2 ,
 barStatus varchar2,
 compStatus varchar2 ,
 configUpdaeFlag OUT varchar2,
 clientUpdateFlag OUT varchar2,
 clentiVerSeq OUT varchar2,
 clientVerName OUT varchar2,
 clientPatchMd5 OUT varchar2,
 hearBeatInterval OUT varchar2,
 authenticationType OUT varchar2,
 ReturnCode OUT varchar2
)
AS
iRecCount INTEGER;
devVerNo number; -- 设备当前版本号
devLastNo number; --设备最新版本号
patchId number; -- 返回需要升级的版本号
patchName number; --返回需要升级的版本的名称
patchMd5 varchar2(50); -- 版本的md5码
configFlag varchar2(1);  --配置更新flag
patchFlag varchar2(1); -- 版本更新flag

BEGIN

 --查询状态记录是否存在
 select count(1) into iRecCount from BSC_DEVICE_STATUS t where t.org_id  = orgId and t.DEVICE_NO=deviceNo;

 if iRecCount > 0 then

   update BSC_DEVICE_STATUS ds set ds.cpu_ratio = cpuRatio,ds.mem_ratio=memRatio,ds.disk_ratio=diskRatio,ds.version_seq=versionSeq,
                                   ds.update_date= sysdate,ds.thermalprinter_status = thermalPrinterStatus,
                                   ds.needleprinter_status = needlePrinterStatus, ds.idreader_status = idReaderStatus,
                                   ds.swread_status = swReadStatus, ds.icreader_status = icReaderStatus,
                                   ds.bar_status = barStatus,ds.comp_status = compStatus
   where ds.org_id = orgId and ds.device_no = deviceNo;
 else
   --插入
   insert into BSC_DEVICE_STATUS ds (ORG_ID,
          DEVICE_NO,
          CPU_RATIO,
          MEM_RATIO,
          DISK_RATIO,
          VERSION_SEQ,
          UPDATE_DATE,
          THERMALPRINTER_STATUS,
          NEEDLEPRINTER_STATUS,
          IDREADER_STATUS,
          SWREAD_STATUS,
          ICREADER_STATUS,
          BAR_STATUS,
          COMP_STATUS
   ) values (
       orgId,
       deviceNo,
       cpuRatio,
       memRatio,
       diskRatio,
       versionSeq,
       sysdate,
       thermalPrinterStatus,
       needlePrinterStatus,
       idReaderStatus,
       swReadStatus,
       icReaderStatus,
       barStatus,
       compStatus
   );
 end if;

 -- 更新设备的最后在线时间，及设备当前版本号
 update bsc_device d set d.online_time = sysdate,d.currt_ver=versionSeq where d.org_id= orgId and d.device_no=deviceNo;


 -- 查询设备信息
 begin
   select case when d.extend1 is null then '0' else d.extend1 end cFlag,  -- 配置是否有更新  1-有   0-无
          case when d.currt_ver is null then -1 else d.currt_ver end currVer,  -- 当前版本号
          case when d.last_ver is null then -1 else d.last_ver end lastVer --  最新版本号
    into configFlag,devVerNo,devLastNo  from bsc_device d where d.device_no = deviceNo;
 exception
      when others then
     -- 设备不存在
     configFlag:=0;
     devVerNo:=-1;
     devLastNo:=-1;
 end;

 -- 返回相关信息
 configUpdaeFlag := configFlag; --是否有配置更新
 --configUpdaeFlag := '0'; --是否有配置更新
 clientUpdateFlag := '0'; -- 是否有客户端更新
 clentiVerSeq := '';  --客户端版本号
 clientVerName := ''; -- 客户端版本名称
 clientPatchMd5 := ''; -- 版本的MD5码

 if devLastNo > devVerNo then
     clientUpdateFlag := '1'; -- 是否有客户端更新
     -- 查询和当前版本最接近需要升级的版本
     select tmp.patch_id,tmp.patch_name,tmp.patch_md5 into  clentiVerSeq,clientVerName,clientPatchMd5  from
     (
            select dup.patch_id,p.patch_name,p.patch_md5 from bsc_devupgrade_process dup inner join bc_patchversion p on (p.id = dup.patch_id)
                          where dup.patch_id >  to_number(versionSeq)
                          and dup.status = 0
                          and dup.device_no = deviceNo
                          order by dup.patch_id
      ) tmp where rownum <= 1;
 end if;

 -- 查询心跳间隔
 begin
    select to_char(case when p.hb_interval is null then 5 else p.hb_interval end),

           (case when p.authentication_type is null then '1' else p.authentication_type end)    into hearBeatInterval,authenticationType  from bc_parameter p;
 exception
      when others then
     hearBeatInterval:=5;
     authenticationType:='1';
 end;


 ReturnCode:='0';


 --异常处理
 -- exception
  --    when others then
  --     ReturnCode:='1';
END proc_extheartbeat;
/

prompt
prompt Creating procedure PROC_FINDBUSYS
prompt =================================
prompt
create or replace procedure iqms_new.proc_findBusys (
orgCode varchar2,
deviceNo varchar2,


p_cursor out sys_refcursor)
as
   v_sql varchar2(4000);
   v_orgId varchar2(50);

begin

select s.org_id into v_orgId from sys_org s where s.org_code = orgCode;

 v_sql := 'select b.org_id,b.device_no,
 b.bus_id,
 b.business_code,
 bm.business_name,
 bm.order_flag 
 from bsc_branch_business b
 inner join BC_BUSINESSMANAGE bm
 on (b.bus_id = bm.business_id)  
 where  b.device_no =:deviceNo
 and b.business_type=''1''
 and b.org_id =:v_orgId ';
 OPEN p_cursor FOR v_sql using deviceNo,v_orgId;




end proc_findBusys;
/

prompt
prompt Creating procedure PROC_FINDSHOWTIME_QUERY
prompt ==========================================
prompt
create or replace procedure iqms_new.proc_findShowTime_query (
--orgId varchar2,
deviceNo varchar2,
businessId varchar2,
dateType varchar2,
p_cursor out sys_refcursor)
as
   v_sql varchar2(4000);


begin

 v_sql := 'select b.* from bsc_show_time b 
 where b.device_no =:deviceNo and b.business_id=:businessId
 and b.date_type=:dateType order by b.begin_time ' ;

  OPEN p_cursor FOR v_sql using deviceNo,businessId,dateType;




end proc_findShowTime_query;
/

prompt
prompt Creating procedure PROC_INSERT_ORDERINFO
prompt ========================================
prompt
CREATE OR REPLACE PROCEDURE iqms_new.proc_insert_orderinfo
(
 orgCode IN varchar2,  -- 机构编码
 devNo IN varchar2,    -- 设备号
 actNo in varchar2, --激活码
 orderBusId in varchar2,--业务id
 orderBusCode in varchar2,--业务code
 certType in varchar2, -- 证件类型
 certContent in varchar2, -- 证件号
 orderDt in varchar2,
 orderTime in varchar2,
 rangeBegin in varchar2,
 rangeEnd in varchar2,
 ReturnCode out varchar2  -- 返回结果  0-成功   1-失败

)
AS
  recordExists INTEGER DEFAULT 0;
BEGIN
  insert into order_info (
         order_id,
         org_code,
         dev_no,
         act_no,
         ORDER_BUSID,
         ORDER_BUSCODE,
         cert_type,
         cert_content,
         ORDER_DATE,
         order_time,
         RANGE_BEGIN,
         RANGE_END,
         order_status,
         OPERTATE_DATE) values
         (
         SEQ_ORDERINFO.NEXTVAL,
         orgCode,
         devNo,
         actNo,
         orderBusId,
         orderBusCode,
         certType,
         certContent,
         orderDt,
         orderTime,
         rangeBegin,
         rangeEnd,
         0,
         to_char(sysdate,'yyyy-mm-dd')
         );
ReturnCode := 0;
END proc_insert_orderinfo;
/

prompt
prompt Creating procedure PROC_MOBSCDEVICESTATUS_PAGE
prompt ==============================================
prompt
create or replace procedure iqms_new.proc_mobscdevicestatus_page (
orgId varchar2, --机构id
onLineFlag  varchar2,--是否在线
orderfield in varchar2,
ordertype in varchar2,
pagesize in number, pageno in number,totalrows out number,p_cursor out sys_refcursor)
as
   v_sql varchar2(4000);
   v_sql_page varchar2(4000);
   v_sql_condition varchar2(4000);
   v_sql_count varchar2(4000);
   v_begin number := (pageno-1)*pagesize+1;
   v_end number := pageno*pagesize;
   v_sort varchar2(50);
   v_orgId varchar2(50) := orgId;
   v_onLineFlag varchar2(50) := onLineFlag;
   v_inervalOnline number;
   v_onLine varchar2(50);

begin
---------------------------------------------------------1.按条件查询数据 start------------------------------------------------------------------
if v_orgId = '0' then 
  v_orgId := '1';
  end if;
 select p.hb_interval into v_inervalOnline from bc_parameter p;  
 
-- select (case when 
 --(h.online_time is null or 
 --(TO_NUMBER(sysdate - h.online_time) * 24 * 60)> '||v_inervalOnline||') then '3' else '1' end)  
 --into v_onLine from bsc_device h;

  v_sql_condition := 'select h.rowid rid,og.org_id,og.org_name,h.device_no,
     (case when (h.online_time is null or (TO_NUMBER(sysdate - h.online_time) * 24 * 60)> '||v_inervalOnline||') then ''3'' else ''1'' end) ONLINE_FLAG,
     ds.CPU_RATIO,
     ds.MEM_RATIO,
     ds.DISK_RATIO,
     ds.THERMALPRINTER_STATUS THERMALPRINTER_STATUS,
     ds.NEEDLEPRINTER_STATUS NEEDLEPRINTER_STATUS,
     ds.IDREADER_STATUS IDREADER_STATUS,
     ds.SWREAD_STATUS SWREAD_STATUS,
     ds.ICREADER_STATUS ICREADER_STATUS,
     ds.BAR_STATUS BAR_STATUS,
     ds.COMP_STATUS COMP_STATUS,
     ds.VERSION_SEQ,
     h.currt_vername,
     h.last_vername
    from bsc_device h
   inner join (select *
                 from sys_org o
                where o.deleted = 0
                start with o.org_id = :orgId
               connect by prior o.org_id = o.parent_id) og
      on (h.ORG_ID = og.ORG_ID)
    left join bsc_device_status ds
      on (ds.device_no = h.device_no) ';

  -------------------------------------------------2.包裹按条件查询的语句，进行分页 开始------------------------------------------------------------
  if (orderfield is null) then
      v_sort := 'device_no';
  else
      v_sort := orderfield||' '||ordertype;
  end if;

 --select result
 v_sql := 'select row_number() over ( order by '||v_sort||',rid) rnum,
  tt.ORG_ID,tt.DEVICE_NO,tt.CPU_RATIO,tt.MEM_RATIO,tt.DISK_RATIO,tt.VERSION_SEQ,
  tt.ONLINE_FLAG,
  tt.THERMALPRINTER_STATUS,tt.NEEDLEPRINTER_STATUS,tt.IDREADER_STATUS,tt.SWREAD_STATUS,tt.ICREADER_STATUS,tt.BAR_STATUS,
  tt.COMP_STATUS,
  tt.currt_vername,tt.last_vername,tt.org_name
  from ('||v_sql_condition||') tt where  ';
  
  -- 查询是否在线
  if (onLineFlag is null or onLineFlag = '2') then
      v_onLineFlag := '2';
      v_sql := v_sql || 'tt.ONLINE_FLAG != :v_onLineFlag ';
  else 
      v_sql := v_sql || 'tt.ONLINE_FLAG = :v_onLineFlag ';
  end if;
  

   --select count
  v_sql_count := 'select count(1) from ('||v_sql||')';


------------------------------------------------------------3.判断是分页还是查询列表

   if pageno > 0  then
    v_sql_page := 'select ORG_ID,
       DEVICE_NO,
       CPU_RATIO,
       MEM_RATIO,
       DISK_RATIO,
       VERSION_SEQ,
       ONLINE_FLAG,
       THERMALPRINTER_STATUS,
       NEEDLEPRINTER_STATUS,
       IDREADER_STATUS,
       SWREAD_STATUS,
       ICREADER_STATUS,
       BAR_STATUS,
       COMP_STATUS,
       currt_vername,
       last_vername,
       org_name  from ('||v_sql||') temp where temp.rnum >= :v_begin and temp.rnum <= :v_end';
     execute immediate v_sql_count into totalrows using v_orgId,v_onLineFlag;
     OPEN p_cursor FOR v_sql_page using  v_orgId,v_onLineFlag,v_begin,v_end;
  else
    totalrows:=0; --set default value
    v_sql_page := 'select ORG_ID,
       DEVICE_NO,
       CPU_RATIO,
       MEM_RATIO,
       DISK_RATIO,
       VERSION_SEQ,
       ONLINE_FLAG,
       THERMALPRINTER_STATUS,
       NEEDLEPRINTER_STATUS,
       IDREADER_STATUS,
       SWREAD_STATUS,
       ICREADER_STATUS,
       BAR_STATUS,
       COMP_STATUS,
       currt_vername,
       last_vername,
       org_name from ('||v_sql||') temp ';
    OPEN p_cursor FOR v_sql_page using  v_orgId,v_onLineFlag;
  end if;

end proc_mobscdevicestatus_page;
/

prompt
prompt Creating procedure PROC_MOBSCDEVICESTATUS_SHOW
prompt ==============================================
prompt
create or replace procedure iqms_new.proc_mobscdevicestatus_show (
orgId varchar2, --机构id
deviceNo  varchar2,--是否在线
p_cursor out sys_refcursor)
as
   v_sql varchar2(4000);
   v_orgId varchar2(50) := orgId;
   v_deviceNo varchar2(50) := deviceNo;

begin
---------------------------------------------------------1.按条件查询数据 start------------------------------------------------------------------

  v_sql := ' select h.ORG_ID,h.DEVICE_NO,h.CPU_RATIO,h.MEM_RATIO,h.DISK_RATIO,
  d.currt_vername,d.last_vername,s.org_name from bsc_device_status h,bc_parameter b,sys_org s,bsc_device d where d.device_no=h.device_no
  and s.org_id = h.org_id and h.org_id =:orgId and h.device_no =:deviceNo';





OPEN p_cursor FOR v_sql using  v_orgId,v_deviceNo;

end proc_mobscdevicestatus_show;
/

prompt
prompt Creating procedure PROC_MYTEST
prompt ==============================
prompt
create or replace procedure iqms_new.proc_mytest
as

begin


 --select result

 update sys_user u set u.real_name = '张二狗' where u.username='hongxz';

 commit;

end proc_mytest;
/

prompt
prompt Creating procedure PROC_NEARS_QUERY
prompt ===================================
prompt
create or replace procedure iqms_new.proc_nears_query (--查询临近网点信息到客户端
orgId varchar2, --机构id

p_cursor out sys_refcursor)
as
   v_sql varchar2(4000);
   v_orgId varchar2(50) := orgId;


begin
---------------------------------------------------------1.按条件查询数据 start------------------------------------------------------------------
v_sql := 'select count(1) totalGetNums,
sum(case when t.trx_status = ''1'' then 1 else 0 end) totalWait,
sum(case when t.trx_status = ''3'' then 1 else 0 end) totalFinished,
sum(case when t.trx_status = ''2'' then 1 else 0 end) totalDeal,
s.org_name
from  trx_today t inner join sys_org s on t.org_id = s.org_id

where
to_char(t.trx_date, ''yyyy/mm/dd'') =
to_char(sysdate,''yyyy/mm/dd'')
and t.org_id = :orgId
group by s.org_name';--总取号数，总等候数，已办理数

 OPEN p_cursor FOR v_sql using v_orgId;

end proc_nears_query;
/

prompt
prompt Creating procedure PROC_NUMBERFORM_ADD
prompt ======================================
prompt
CREATE OR REPLACE PROCEDURE iqms_new.proc_numberform_add
(
 tktFormatId varchar2,
 v_tktFormat varchar2,
 ReturnCode OUT varchar2
)
AS
iRecCount INTEGER;
BEGIN

   --查询要增加的记录是否存在
   select count(1) into iRecCount from bc_numberform b where b.tktformat = v_tktFormat;

   if iRecCount > 0 then
     ReturnCode:='2'; --该号码模板已经存在
   else
     --插入
     insert into bc_numberform t (
         TKTFORMAT_ID,
         TKTFORMAT
     ) values (
         SEQ_BCNUMBERFORM.NEXTVAL,
         v_tktFormat
     );
     ReturnCode:='0';
   end if;
   --异常处理
   -- exception
     --   when others then
       --  ReturnCode:='1'; --数据库异常

END proc_numberform_add;
/

prompt
prompt Creating procedure PROC_NUMBERFORM_DELETE
prompt =========================================
prompt
create or replace procedure iqms_new.proc_numberform_delete(
tktFormatId in varchar2,
ReturnCode out varchar2
)
IS
cursor v_deviceNo is
select t.device_no from bc_ticketform t left join bc_numberform n on
t.tktformat_id = n.tktformat_id;
v_no v_deviceNo%rowtype;
begin
  delete from bc_numberform b where b.tktformat_id = tktFormatId ;
  for v_no in v_deviceNo loop
     proc_deviceupdateflag(v_no.device_no,'0');

     end loop;
  ReturnCode:='0';

  --异常处理
 -- exception
   --   when others then
     --  ReturnCode:='1'; --数据库异常

end proc_numberform_delete;
/

prompt
prompt Creating procedure PROC_NUMBERFORM_UPDATE
prompt =========================================
prompt
CREATE OR REPLACE PROCEDURE iqms_new.proc_numberform_update
(
 tktFormatId varchar2,
 v_tktFormat varchar2,
 ReturnCode OUT varchar2
)
IS
cursor v_deviceNo is
select t.device_no from bc_ticketform t left join bc_numberform n on
t.tktformat_id = n.tktformat_id;
v_no v_deviceNo%rowtype;
iRecCount INTEGER;
BEGIN
   --查询要修改的记录是否存在
   select count(1) into iRecCount from bc_numberform b where b.tktformat = v_tktFormat and b.tktformat_id <> tktFormatId;

   if iRecCount > 0 then
       ReturnCode:='2';
   else
     update bc_numberform t set
        t.TKTFORMAT = v_tktFormat
     where  t.TKTFORMAT_ID = tktFormatId;

     for v_no in v_deviceNo loop
     proc_deviceupdateflag(v_no.device_no,'0');

     end loop;
     ReturnCode:='0';
   end if ;

 --异常处理
 -- exception
   --   when others then
     --  ReturnCode:='1'; --数据库异常
END proc_numberform_update;
/

prompt
prompt Creating procedure PROC_NUMBER_COPY
prompt ===================================
prompt
CREATE OR REPLACE PROCEDURE iqms_new.proc_number_copy--应用到下级机构
(
 orgId varchar2,
 deviceNo varchar2,
 targetId varchar2,--目标orgId
 targetNo varchar2, --目标deviceNo
 ReturnCode OUT varchar2
)
AS
BEGIN
 if orgId != targetId or deviceNo != targetNo then
 --删除目标数据再插入
 delete from bc_numberform b where b.org_id = targetId and b.device_no = targetNo;

   --插入
   insert into bc_numberform (
      ORG_ID,
      DEVICE_NO,
      TKTFORMAT_ID,
      TKTFORMAT
   ) select
     targetId,
     targetNo,
     SEQ_BCNUMBERFORM.NEXTVAL,
     TKTFORMAT
    from bc_numberform w where w.org_id = orgId and w.device_no=deviceNo;
   ReturnCode:='0';
end if;
 --异常处理
 -- exception
   --   when others then
     --  ReturnCode:='1'; --数据库异常
END proc_number_copy;
/

prompt
prompt Creating procedure PROC_ORDERACTIVE_INFO
prompt ========================================
prompt
create or replace procedure iqms_new.proc_orderactive_info (
deviceNo varchar2,
certType varchar2,
certContent varchar2,
p_cursor out sys_refcursor)
as
   v_sql varchar2(4000);


begin


 if certType = '4' then --激活码
 v_sql :='select oi.order_id,oi.cert_type,oi.cert_content, oi.ORDER_BUSID,oi.ORDER_DATE,oi.RANGE_END from order_info oi
 where oi.act_no =:certContent and oi.dev_no =:deviceNo';
 OPEN p_cursor FOR v_sql using certContent,deviceNo;
 else
  v_sql :='select oi.order_id,oi.cert_type,oi.cert_content, oi.ORDER_BUSID,oi.ORDER_DATE,oi.RANGE_END from order_info oi
 where oi.cert_type =:certType and oi.cert_content =:certContent and oi.dev_no =:deviceNo';
 OPEN p_cursor FOR v_sql using certType,certContent,deviceNo;
 end if;
 





end proc_orderactive_info;
/

prompt
prompt Creating procedure PROC_ORDERCONFIG_ADD
prompt =======================================
prompt
CREATE OR REPLACE PROCEDURE iqms_new.proc_orderconfig_add
(
 orgId varchar2,
 deviceNo varchar2,
 beginTime varchar2 ,
 endTime varchar2,
 orderCount varchar2,
 ReturnCode OUT varchar2
)
AS
beginCount INTEGER;
endCount INTEGER;
betweenCount INTEGER;
orgCode varchar2(20);
BEGIN

 --查询要增加的时间段是否存在
 select count(1) into beginCount from order_range t where (t.begin_time = beginTime or 
 t.end_time = beginTime) 
 and t.device_no = deviceNo;
 select count(1) into endCount from order_range t where (t.end_time = endTime or 
 t.begin_time = endTime) and t.device_no = deviceNo;

 select count(1) into betweenCount from order_range t where (t.begin_time < beginTime
 and  t.end_time > beginTime) or  (t.begin_time < endTime
 and  t.end_time > endTime)
 and t.device_no = deviceNo;

 if beginCount > 0 then
   ReturnCode:='1'; --开始时间已经存在
 elsif endCount>0 then
 ReturnCode:='2';--结束时间已存在
 elsif betweenCount>0 then
 ReturnCode:='3';--时间段重叠
 else
   select s.org_code into orgCode from sys_org s where s.org_id = orgId;
   --插入
   insert into order_range t (
      id,
      ORG_CODE,
      device_no,
      begin_time,
      end_time,
      ordercount
   ) values (
     seq_orderrange.nextval,
     orgCode,
     deviceNo,
     beginTime,
     endTime,
     orderCount
   );
   ReturnCode:='0';
 end if;
 --异常处理
 -- exception
   --   when others then
     --  ReturnCode:='1'; --数据库异常
END proc_orderconfig_add;
/

prompt
prompt Creating procedure PROC_ORDERCONFIG_COPY
prompt ========================================
prompt
CREATE OR REPLACE PROCEDURE iqms_new.proc_orderconfig_copy--应用到下级机构
(
 deviceNo varchar2,
 targetId varchar2,--目标orgId
 targetNo varchar2, --目标deviceNo
 ReturnCode OUT varchar2
)
AS
BEGIN
 if  deviceNo != targetNo then
 --删除目标数据再插入
 delete from order_range b where b.device_no = targetNo;

   --插入
   insert into order_range (
      id,
      ORG_CODE,
      device_no,
      begin_time,
      end_time,
      ordercount
   ) select
     SEQ_ORDERRANGE.NEXTVAL,
     s.org_code,
     targetNo,
     begin_time,
     end_time,
     ordercount

    from order_range w,sys_org s where  w.device_no=deviceNo 
     and s.org_id = targetId;


   ReturnCode:='0';
end if;
 --异常处理
 -- exception
   --   when others then
     --  ReturnCode:='1'; --数据库异常
END proc_orderconfig_copy;
/

prompt
prompt Creating procedure PROC_ORDERCONFIG_EDIT
prompt ========================================
prompt
CREATE OR REPLACE PROCEDURE iqms_new.proc_orderconfig_edit
(
 orderId varchar2,
 beginTime varchar2,
 endTime varchar2 ,
 orderCount varchar2,
 deviceNo varchar2,
 ReturnCode OUT varchar2
)
AS
v_orderCount varchar2(20);
beginCount INTEGER;
endCount INTEGER;
betweenCount INTEGER;
BEGIN
  v_orderCount:= orderCount;
 --查询要增加的时间段是否存在
 select count(1) into beginCount from order_range t where (t.begin_time = beginTime or 
 t.end_time = beginTime)
 and t.id <> orderId and t.device_no = deviceNo;
 select count(1) into endCount from order_range t where (t.end_time = endTime or 
 t.begin_time = endTime) 
 and t.id <> orderId and t.device_no = deviceNo;

 select count(1) into betweenCount from order_range t where (t.begin_time < beginTime
 and  t.end_time > beginTime) or  (t.begin_time < endTime
 and  t.end_time > endTime)
 and t.id <> orderId and t.device_no = deviceNo;

   if beginCount > 0 then
   ReturnCode:='1'; --开始时间已经存在
   elsif endCount>0 then
   ReturnCode:='2';--结束时间已存在
   elsif betweenCount>0 then
   ReturnCode:='3';--时间段重叠
 else
   update order_range t set
      t.begin_time = beginTime,
      t.end_time =endTime,
      t.ordercount = v_orderCount 
   where t.id = orderId;
   commit;
   ReturnCode:='0';
   end if;

 --异常处理
 -- exception
   --   when others then
     --  ReturnCode:='1'; --数据库异常
END proc_orderconfig_edit;
/

prompt
prompt Creating procedure PROC_ORDERCONFIG_PAGE
prompt ========================================
prompt
create or replace procedure iqms_new.proc_orderconfig_page (
orgId varchar2, --机构ID

orderfield in varchar2,
ordertype in varchar2,
pagesize in number, pageno in number,totalrows out number,p_cursor out sys_refcursor)
as
   v_sql varchar2(4000);
   v_sql_page varchar2(4000);
   v_sql_condition varchar2(4000);
   v_sql_count varchar2(4000);
   v_begin number := (pageno-1)*pagesize+1;
   v_end number := pageno*pagesize;
   v_sort varchar2(50);
   v_orgCode varchar2(50);

begin
---------------------------------------------------------1.按条件查询数据 start------------------------------------------------------------------
  select s.org_code into v_orgCode from sys_org s where s.org_id = orgId;
  v_sql_condition := ' select o.id,o.rowId rid,o.org_code,o.device_no,o.begin_time,o.end_time,
  o.ordercount,s.org_name,d.host_name from order_range o,sys_org s,bsc_device d where 
  o.org_code=s.org_code and o.device_no = d.device_no  ';


  if v_orgCode is not null then
     v_sql_condition := v_sql_condition || ' and o.org_code like ''%''||:v_orgCode||''%''';
   else
     v_orgCode := '@#$&^%$#@!';
     v_sql_condition := v_sql_condition || ' and ( o.org_code  is null or o.org_code <>:v_orgCode)';

  end if;


  -------------------------------------------------2.包裹按条件查询的语句，进行分页 开始------------------------------------------------------------
  if (orderfield is null) then
      v_sort := 'org_code';
  else
      v_sort := orderfield||' '||ordertype;
  end if;

 --select result
 v_sql := 'select row_number() over ( order by '||v_sort||',rid) rnum,tt.id,
  tt.org_code,
  tt.device_no,
  tt.begin_time,
  tt.end_time,
  tt.ordercount,
  tt.org_name,
  tt.host_name 
  from ('||v_sql_condition||') tt ';

   --select count
  v_sql_count := 'select count(1) from ('||v_sql||')';


------------------------------------------------------------3.判断是分页还是查询列表

   if pageno > 0  then
    v_sql_page := 'select * from ('||v_sql||') temp where temp.rnum >= :v_begin and temp.rnum <= :v_end';
     execute immediate v_sql_count into totalrows using v_orgCode;
     OPEN p_cursor FOR v_sql_page using  v_orgCode,v_begin,v_end;
  else
    totalrows:=0; --set default value
    v_sql_page := 'select * from ('||v_sql||') temp ';
    OPEN p_cursor FOR v_sql_page using  v_orgCode;
  end if;

end proc_orderconfig_page;
/

prompt
prompt Creating procedure PROC_ORDERCONFIG_REMOVE
prompt ==========================================
prompt
CREATE OR REPLACE PROCEDURE iqms_new.proc_orderconfig_remove
(
 orderId varchar2,
 ReturnCode OUT varchar2
)
AS
BEGIN

   delete from order_range t where t.id = orderId;




   ReturnCode:='0';
 --异常处理
 -- exception
   --   when others then
     --  ReturnCode:='1'; --数据库异常
END proc_orderconfig_remove;
/

prompt
prompt Creating procedure PROC_ORDERINFO_EDIT
prompt ======================================
prompt
CREATE OR REPLACE PROCEDURE iqms_new.proc_orderinfo_edit
(
 orderId varchar2,
 ticketNo varchar2,
 ReturnCode OUT varchar2
)
AS
v_count integer;

BEGIN

   select count(1) into v_count from order_info where order_id = orderId;
   if v_count != 1 then
     ReturnCode:='1';--未找到预约记录
   else
   update order_info t set
      t.order_status = '1',
      t.modify_date =to_char(sysdate,'yyyy-mm-dd hh24:mi:ss'),
      t.ticket_no = ticketNo 
   where t.order_id = orderId;

   ReturnCode:='0';
   end if;
   

 --异常处理
 -- exception
   --   when others then
     --  ReturnCode:='1'; --数据库异常
END proc_orderinfo_edit;
/

prompt
prompt Creating procedure PROC_ORDER_BUSINESS
prompt ======================================
prompt
create or replace procedure iqms_new.proc_order_business (
deviceNo varchar2,
--dateType varchar2,--是否假日
p_cursor out sys_refcursor)
as
   v_sql varchar2(4000);


begin



 v_sql := 'select b.org_id,b.device_no,
 b.bus_id,
 b.business_code,
 bm.business_name,
 bm.order_flag 
 from bsc_branch_business b
 inner join BC_BUSINESSMANAGE bm
 on (b.bus_id = bm.business_id)
 
 where  b.device_no =:deviceNo
 and b.business_type=''1''
 and bm.order_flag =''1'' ';
 OPEN p_cursor FOR v_sql using deviceNo ;




end proc_order_business;
/

prompt
prompt Creating procedure PROC_PATCHDLCONFIRM
prompt ======================================
prompt
CREATE OR REPLACE PROCEDURE iqms_new.proc_patchDlConfirm
(
 deviceId varchar2,
 versionSeq varchar2,
 ReturnCode OUT varchar2  -- 1-失败，记录不存在     0-成功
)
AS
iRecCount INTEGER;
BEGIN

 --查询柜员是否存在versionSeq
 select count(1) into iRecCount from bsc_devupgrade_process t where t.device_no = deviceId and t.patch_id = versionSeq;

 if iRecCount > 0 then -- 更新下载日期
    update bsc_devupgrade_process t set t.dldate = sysdate where t.device_no = deviceId and t.patch_id = versionSeq;
     ReturnCode:='0';
 else
   ReturnCode:='1';
 end if;
 --异常处理
 -- exception
   --   when others then
     --  ReturnCode:='1'; --数据库异常
END proc_patchDlConfirm;
/

prompt
prompt Creating procedure PROC_REPORT_BUSGRAPHIC
prompt =========================================
prompt
create or replace procedure iqms_new.proc_report_busGraphic (
orgId in varchar2,
busType in varchar2,
startDate in varchar2,--不能对输入参数重新赋值
endDate in varchar2,
orderfield in varchar2,
ordertype in varchar2,
pagesize in number, pageno in number,totalrows out number,p_cursor out sys_refcursor)
as
   v_sql varchar2(4000);
   v_sql_page varchar2(4000);
   v_sql_condition varchar2(20000);
   v_sql_count varchar2(4000);
   v_begin number := (pageno-1)*pagesize+1;
   v_end number := pageno*pagesize;
   v_sort varchar2(50);

   v_orgid varchar2(50) := orgId;
   v_busType varchar2(50) := busType;
   v_startDate varchar2(50) := startDate;
   v_endDate varchar2(50) := endDate;

begin

  ---------------------------------------------------------1.按条件查询数据 start------------------------------------------------------------------

  v_sql_condition := ' select temps.bus_id,temps.business_name,
                             count(1) deal_count,
                             sum(case when temps.is_WaitOut=1 then 1 else 0 end) wait_count,
                             sum(case when temps.is_WaitOut=0 then 1 else 0 end) notwait_count,
                             sum(case when temps.deal_TimeOut=1 then 1 else 0 end) dealwait_count,
                             sum(case when temps.deal_TimeOut=0 then 1 else 0 end) notdealwait_count
                       from
                          (select temp.bus_id,temp.business_name,
                             (case when temp.cus_wait >temp.c_wait then ''1'' else ''0'' end) is_WaitOut,
                             (case when temp.bus_wait >temp.b_wait then ''1'' else ''0'' end) deal_TimeOut
                          from
                               (select h.bus_id,b.business_name,
                                  b.average_time b_wait,
                                  c.wait_timeout c_wait,
                                  trunc(((case when h.call_time is null then sysdate else h.call_time end)-h.print_time)*24*60,0) cus_wait,
                                  trunc(((case when h.end_time is null then sysdate else h.end_time end)-h.begin_time)*24*60,0) bus_wait
                               from trx_history h
                               inner join (select * from sys_org o where o.deleted=0  start with o.org_id =:v_orgid
                               connect by prior o.org_id = o.parent_id) og on (h.org_id=og.org_id)
                               left join bc_businessmanage b on (h.bus_id=b.business_id)
                               left join bc_custtype c on (h.cust_type = c.cust_level)
                               where h.trx_status=''3'' ';

  --其他查询条件
  if busType is not null then
     v_sql_condition := v_sql_condition || ' and h.bus_id = :v_busType';
   else
     v_busType := '@#$&^%$#@!';
     v_sql_condition := v_sql_condition || ' and ( h.bus_id  is null or h.bus_id <> :v_busType)';

  end if;

  if startDate is not null then
     v_sql_condition := v_sql_condition || ' and to_date(to_char(h.TRX_DATE,''yyyy-MM-dd''),''yyyy-MM-dd'') >= to_date(:startDate,''yyyy-MM-dd'') ';
   else
     v_startDate := '@#$&^%$#@!';
     v_sql_condition := v_sql_condition || ' and ( h.TRX_DATE  is null or to_char(h.TRX_DATE,''yyyy-MM-dd'') <> :startDate )';

  end if;

  if endDate is not null then
     v_sql_condition := v_sql_condition || ' and to_date(to_char(h.TRX_DATE,''yyyy-MM-dd''),''yyyy-MM-dd'') <= to_date(:endDate,''yyyy-MM-dd'') ';
   else
     v_endDate := '@#$&^%$#@!';
     v_sql_condition := v_sql_condition || ' and ( h.TRX_DATE  is null or to_char(h.TRX_DATE,''yyyy-MM-dd'') <>:endDate)';

  end if;

  v_sql_condition := v_sql_condition ||' ) temp ) temps group by temps.bus_id,temps.business_name order by temps.bus_id';


    OPEN p_cursor FOR v_sql_condition using  v_orgid,v_busType,v_startDate,v_endDate;

end proc_report_busGraphic;
/

prompt
prompt Creating procedure PROC_REPORT_BUSINESSCOUNT
prompt ============================================
prompt
prompt Creating procedure PROC_ADS_SAVE
prompt ================================
prompt
create or replace procedure iqms_new.proc_ads_save
(
orgId in  number,
--deviceNo in  varchar2,
advType in  varchar2,
advContent in  varchar2,
ReturnCode out varchar2

)
is
cursor v_device is select t.org_id,d.device_no from (select s.org_id
  from sys_org s
connect by prior s.org_id = s.parent_id
 start with s.org_id = orgId)t left join bsc_device d on (t.org_id = d.org_id);
   v_d v_device%rowtype;
begin
           for v_d in v_device loop
      insert into bsc_adtype b (
              b.ORG_ID,
              b.DEVICE_NO,
              b.adv_type,
              b.adv_content,
              b.CREATE_TIME
           )values(
              v_d.org_id,
              v_d.device_no,
              advType,
              advContent,
              sysdate
           );
       end loop;
 ReturnCode:='0';
end proc_ads_save;
/

prompt
prompt Creating procedure PROC_ADS_SELECT
prompt ==================================
prompt
create or replace procedure iqms_new.proc_ads_select
(
orgId in  number,
deviceNo in  varchar2,
p_cursor out sys_refcursor
)
is
  v_sql varchar2(4000);
  v_orgid varchar2(50) := orgId;
  v_deviceNo varchar2(50) := deviceNo;
begin
   v_sql := 'select t.*,d.ip_addr
  from (select row_number() over(partition by b.adv_type order by b.create_time desc) rnum,
       b.*
  from bsc_adtype b
 where b.org_id =:v_orgid
   and b.device_no =:v_deviceNo) t
               inner join
               bsc_device d on (d.device_no = t.device_no)
 where t.rnum = 1';

   OPEN p_cursor FOR v_sql using v_orgid,v_deviceNo;

end proc_ads_select;
/

prompt
prompt Creating procedure PROC_DEVICEUPDATEFLAG
prompt ========================================
prompt
create or replace procedure iqms_new.proc_deviceupdateflag
(
 deviceNo in  varchar2,
 upFlage in varchar2 -- 1全部设备更新    0-只更新deviceNo的设备
)
is



begin

  if   upFlage = 1 then

       update bsc_device d set d.extend1 = 1;

  else

       update bsc_device d set d.extend1 = 1 where d.device_no = deviceNo;

  end if;




   --异常处理
   -- exception
    --   when others then
     --  ReturnCode:='1'; --数据库异常
end proc_deviceupdateflag;
/

prompt
prompt Creating procedure PROC_BCBUSMANAGE_ADD
prompt =======================================
prompt
CREATE OR REPLACE PROCEDURE iqms_new.proc_bcbusmanage_add
(
 businessName varchar2,
 businessEName varchar2,

 averageTime varchar2 ,
 orderFlag varchar2 ,
 ReturnCode OUT varchar2
)
AS
iRecCount INTEGER;
eCount INTEGER;
BEGIN

 --查询要增加的记录是否存在
 select count(1) into iRecCount from bc_businessmanage t where t.business_name = businessName;
 select count(1) into eCount from bc_businessmanage t where t.business_ename = businessEName;
 if iRecCount > 0 then
   ReturnCode:='2'; --该中文名已经存在
 elsif eCount>0 then
  ReturnCode:='3'; --该英文名已经存在
 else
   --插入
   insert into bc_businessmanage t (
      BUSINESS_ID,
      BUSINESS_NAME,
      BUSINESS_ENAME,
      AVERAGE_TIME,
      ORDER_FLAG
   ) values (
     SEQ_BCMENU.NEXTVAL,
     businessName,
     businessEName,
     averageTime,
     orderFlag
   );
   ReturnCode:='0';
   proc_deviceupdateflag('','1');
 end if;
 --异常处理
 -- exception
   --   when others then
     --  ReturnCode:='1'; --数据库异常
END proc_bcbusmanage_add;
/

prompt
prompt Creating procedure PROC_BCBUSMANAGE_ALL
prompt =======================================
prompt
create or replace procedure iqms_new.proc_bcbusmanage_all (
businessId varchar2,
p_cursor out sys_refcursor
)
as
   v_sql_condition varchar2(4000);

begin
---------------------------------------------------------1.按条件查询数据 start------------------------------------------------------------------

  v_sql_condition := ' select BUSINESS_ID,BUSINESS_NAME,AVERAGE_TIME,ORDER_FLAG from bc_businessmanage h where 1=1  ';

  OPEN p_cursor FOR v_sql_condition;


end proc_bcbusmanage_all;
/

prompt
prompt Creating procedure PROC_BCBUSMANAGE_EDIT
prompt ========================================
prompt
CREATE OR REPLACE PROCEDURE iqms_new.proc_bcbusmanage_edit
(
 businessId varchar2,
 businessName varchar2,
 businessEName varchar2,
 averageTime varchar2 ,
 orderFlag varchar2 ,
 ReturnCode OUT varchar2
)
AS
iRecCount INTEGER;
eCount INTEGER;
BEGIN
   select count(1) into iRecCount from bc_businessmanage t where t.business_name = businessName and t.business_id <> businessId;

 if iRecCount > 0 then
   ReturnCode:='2'; --该中文名已经存在
 else
   update bc_businessmanage t set
      t.BUSINESS_ID = businessId,
      t.BUSINESS_NAME =businessName,
      t.business_ename = businessEName,
      t.AVERAGE_TIME = averageTime,
      t.ORDER_FLAG = orderFlag
   where t.BUSINESS_ID = businessId;
proc_deviceupdateflag('','1');
   ReturnCode:='0';
   end if;
 --异常处理
 -- exception
   --   when others then
     --  ReturnCode:='1'; --数据库异常
END proc_bcbusmanage_edit;
/

prompt
prompt Creating procedure PROC_BCBUSMANAGE_PAGE
prompt ========================================
prompt
create or replace procedure iqms_new.proc_bcbusmanage_page (
businessName varchar2, --业务名称
orderfield in varchar2,--排序字段
ordertype in varchar2,--排序类型（方向：顺序、倒序）
pagesize in number,--每页大小
pageno in number,--当前页码
totalrows out number,--总记录数
p_cursor out sys_refcursor
)
as
   v_sql varchar2(4000);
   v_sql_page varchar2(4000);
   v_sql_condition varchar2(4000);
   v_sql_count varchar2(4000);
   v_begin number := (pageno-1)*pagesize+1;
   v_end number := pageno*pagesize;
   v_sort varchar2(50);
   v_businessName varchar2(50) := businessName;

begin
---------------------------------------------------------1.按条件查询数据 start------------------------------------------------------------------

  v_sql_condition := ' select BUSINESS_ID,BUSINESS_NAME,BUSINESS_ENAME,AVERAGE_TIME,ORDER_FLAG,h.rowId rid from bc_businessmanage h where 1=1  ';


  if v_businessName is not null then
     v_sql_condition := v_sql_condition || ' and h.BUSINESS_NAME like ''%''||:businessName||''%''';
   else

     v_businessName := '@#$&^%$#@!';
     v_sql_condition := v_sql_condition || ' and ( h.BUSINESS_NAME  is null or h.BUSINESS_NAME <>:businessName)';

  end if;


  -------------------------------------------------2.包裹按条件查询的语句，进行分页 开始------------------------------------------------------------
  if (orderfield is null) then
      v_sort := 'BUSINESS_ID ';
  else
      v_sort := orderfield||' '||ordertype;
  end if;

 --select result
 v_sql := 'select row_number() over ( order by '||v_sort||',rid) rnum,tt.BUSINESS_ID,
  tt.BUSINESS_NAME,
  tt.BUSINESS_ENAME,
  tt.AVERAGE_TIME,
  tt.ORDER_FLAG
   from ('||v_sql_condition||') tt ';

   --select count
  v_sql_count := 'select count(1) from ('||v_sql||')';


------------------------------------------------------------3.判断是分页还是查询列表

   if pageno > 0  then
    v_sql_page := 'select * from ('||v_sql||') temp where temp.rnum >= :v_begin and temp.rnum <= :v_end';
     execute immediate v_sql_count into totalrows using v_businessName;
     OPEN p_cursor FOR v_sql_page using  v_businessName,v_begin,v_end;
  else
    totalrows:=0; --set default value
    v_sql_page := 'select * from ('||v_sql||') temp ';
    OPEN p_cursor FOR v_sql_page using  v_businessName;
  end if;

end proc_bcbusmanage_page;
/

prompt
prompt Creating procedure PROC_BCBUSMANAGE_REMOVE
prompt ==========================================
prompt
CREATE OR REPLACE PROCEDURE iqms_new.proc_bcbusmanage_remove
(
 businessId varchar2,
 ReturnCode OUT varchar2
)
AS
iRecCount INTEGER;
BEGIN

   delete from  bc_businessmanage t where t.BUSINESS_ID = businessId;
   --级联删除网点业务
   delete from bsc_branch_business b where b.bus_id = businessId
   and b.business_type = '1';
   --级联删除【叫号策略】
   delete from bsc_counterbuz s where s.buztypeid = businessId ;
   --级联删除【业务显示】
   delete from bsc_show_time b where b.business_id =  businessId;
   --级联删除【取号界面】
   delete from bc_modelstyle_element m where m.element_type = 'buzType'
   and m.buztype_id = businessId;
   --级联更新【客户级别】 绑定业务为不绑定
   update bsc_cust_level c set c.business_id = null
   where c.business_id = businessId;
    proc_deviceupdateflag('','1');
   ReturnCode:='0';
 --异常处理
 -- exception
   --   when others then
     --  ReturnCode:='1'; --数据库异常
END proc_bcbusmanage_remove;
/

prompt
prompt Creating procedure PROC_BCCUSINFO_ADD
prompt =====================================
prompt
CREATE OR REPLACE PROCEDURE iqms_new.proc_bccusinfo_add
(
 orgId varchar2,
 custId varchar2,
 custName varchar2 ,
 custLevel varchar2 ,
 custPdut varchar2 ,
 custAd varchar2 ,
 isBankEftve varchar2 ,
 ReturnCode OUT varchar2
)
AS
iRecCount INTEGER;
BEGIN

 --查询要增加的记录是否存在
 select count(1) into iRecCount from bc_cusinfo t where t.CUST_ID = custId;

 if iRecCount > 0 then
   ReturnCode:='2'; --该客户类型已经存在
 else
   --插入
   insert into bc_cusinfo t (
      ORG_ID,
      CUST_ID,
      CUST_NAME,
      CUST_LEVEL,
      CUST_PDUT,
      CUST_AD,
      ISBANK_EFTVE
   ) values (
     orgId,
     custId,
     custName,
     custLevel,
     custPdut,
     custAd,
     isBankEftve
   );
   ReturnCode:='0';
 end if;
 --异常处理
 -- exception
   --   when others then
     --  ReturnCode:='1'; --数据库异常
END proc_bccusinfo_add;
/

prompt
prompt Creating procedure PROC_BCCUSINFO_ADD_FILE
prompt ==========================================
prompt
CREATE OR REPLACE PROCEDURE iqms_new.proc_bccusinfo_add_file
(
 orgCode varchar2,
 custId varchar2,
 custName varchar2 ,
 custLevel varchar2 ,
 custPdut varchar2 ,
 custAd varchar2 ,
 isBankEftve varchar2 ,
 ReturnCode OUT varchar2
)
AS
iRecCount INTEGER;
orgId INTEGER;
BEGIN

 --查询要增加的记录是否存在
 select count(1) into iRecCount from bc_cusinfo t where t.CUST_ID = custId;
 select o.org_id into orgId from sys_org o where o.org_code = orgCode;

 if iRecCount > 0 then
   ReturnCode:='2'; --该客户类型已经存在
 else
   --插入
   insert into bc_cusinfo t (
      ORG_ID,
      CUST_ID,
      CUST_NAME,
      CUST_LEVEL,
      CUST_PDUT,
      CUST_AD,
      ISBANK_EFTVE
   ) values (
     orgId,
     custId,
     custName,
     custLevel,
     custPdut,
     custAd,
     isBankEftve
   );
   ReturnCode:='0';
 end if;
 --异常处理
 -- exception
   --   when others then
     --  ReturnCode:='1'; --数据库异常
END proc_bccusinfo_add_file;
/

prompt
prompt Creating procedure PROC_BCCUSINFO_EDIT
prompt ======================================
prompt
CREATE OR REPLACE PROCEDURE iqms_new.proc_bccusinfo_edit
(
 orgId varchar2,
 custId varchar2,
 custName varchar2 ,
 custLevel varchar2 ,
 custPdut varchar2 ,
 custAd varchar2 ,
 isBankEftve varchar2 ,
 ReturnCode OUT varchar2
)
AS
iRecCount INTEGER;
BEGIN

   update bc_cusinfo t set
      t.ORG_ID = orgId,
      t.CUST_ID = custId,
      t.CUST_NAME = custName,
      t.CUST_LEVEL = custLevel,
      t.CUST_PDUT = custPdut,
      t.CUST_AD = custAd,
      t.ISBANK_EFTVE = isBankEftve
   where t.CUST_ID = custId;

   ReturnCode:='0';
 --异常处理
 -- exception
   --   when others then
     --  ReturnCode:='1'; --数据库异常
END proc_bccusinfo_edit;
/

prompt
prompt Creating procedure PROC_BCCUSINFO_PAGE
prompt ======================================
prompt
create or replace procedure iqms_new.proc_bccusinfo_page (
orgId in varchar2,
custId in varchar2,
custName in varchar2,
custLevel in varchar2,
orderfield in varchar2,
ordertype in varchar2,
pagesize in number, pageno in number,totalrows out number,p_cursor out sys_refcursor)
as
   v_sql varchar2(4000);
   v_sql_page varchar2(4000);
   v_sql_condition varchar2(2000);
   v_sql_count varchar2(4000);
   v_begin number := (pageno-1)*pagesize+1;
   v_end number := pageno*pagesize;
   v_sort varchar2(50);

   v_orgid varchar2(50) := orgId;
   v_custid varchar2(50) := custId;
   v_custname varchar2(50) := custName;
   v_custlevel varchar2(50) := custLevel;

begin

  ---------------------------------------------------------1.按条件查询数据 start------------------------------------------------------------------

  v_sql_condition := 'select
                      h.ORG_ID,
                      og.ORG_CODE,
                      og.ORG_NAME,
                      h.CUST_ID,
                      h.CUST_NAME,
                      h.CUST_LEVEL,
                      b.CUST_NAME CUS_NAME,
                      h.CUST_PDUT,
                      h.CUST_AD,
                      h.ISBANK_EFTVE,
                      h.rowId rid
                      from BC_CUSINFO h
  inner join (select * from sys_org o where o.deleted=0  start with o.org_id =:v_orgid
  connect by prior o.org_id = o.parent_id) og on (h.ORG_ID=og.ORG_ID)
  inner join BC_CUSTTYPE b on (h.CUST_LEVEL = b.CUST_LEVEL) where 1=1';

  --其他查询条件
  if v_custid is not null then
     v_sql_condition := v_sql_condition || ' and h.CUST_ID like ''%''||:custId ||''%''';
   else
     v_custid := '@#$&^%$#@!';
     v_sql_condition := v_sql_condition || ' and ( h.CUST_ID  is null or h.CUST_ID <>:custId)';

  end if;

   if v_custname is not null then
     v_sql_condition := v_sql_condition || ' and h.CUST_NAME like ''%''||:custName ||''%''';
   else
     v_custname := '@#$&^%$#@!';
     v_sql_condition := v_sql_condition || ' and ( h.CUST_NAME  is null or h.CUST_NAME <>:custName)';

  end if;

   if v_custlevel is not null then
     v_sql_condition := v_sql_condition || ' and h.CUST_LEVEL = :custLevel ';
   else
     v_custlevel := '@#$&^%$#@!';
     v_sql_condition := v_sql_condition || ' and ( h.CUST_LEVEL  is null or h.CUST_LEVEL <>:custLevel)';

  end if;


-------------------------------------------------2.包裹按条件查询的语句，进行分页 开始------------------------------------------------------------
  if (orderfield is null) then
      v_sort := 'ORG_ID ';
  else
      v_sort := orderfield||' '||ordertype;
  end if;

 --select result
 v_sql := 'select row_number() over ( order by '||v_sort||',rid) rnum,
     tt.ORG_ID,
    tt.ORG_CODE,
    tt.ORG_NAME,
    tt.CUST_ID,
    tt.CUST_NAME,
    tt.CUST_LEVEL,
    tt.CUS_NAME,
    tt.CUST_PDUT,
    tt.CUST_AD,
    tt.ISBANK_EFTVE
   from ('||v_sql_condition||') tt ';

   --select count
  v_sql_count := 'select count(1) from ('||v_sql||')';

------------------------------------------------------------3.判断是分页还是查询列表

   if pageno > 0  then
    v_sql_page := 'select * from ('||v_sql||') temp where temp.rnum >= :v_begin and temp.rnum <= :v_end';
     execute immediate v_sql_count into totalrows using v_orgid,v_custid,v_custname,v_custlevel;
     OPEN p_cursor FOR v_sql_page using  v_orgid,v_custid,v_custname,v_custlevel,v_begin,v_end;
  else
    totalrows:=0; --set default value
    v_sql_page := 'select * from ('||v_sql||') temp ';
    OPEN p_cursor FOR v_sql_page using  v_orgid,v_custid,v_custname,v_custlevel;
  end if;

end proc_bccusinfo_page;
/

prompt
prompt Creating procedure PROC_BCCUSINFO_REMOVE
prompt ========================================
prompt
CREATE OR REPLACE PROCEDURE iqms_new.proc_bccusinfo_remove
(
 custId varchar2,
 ReturnCode OUT varchar2
)
AS
iRecCount INTEGER;
BEGIN

   delete from  bc_cusinfo t where t.CUST_ID = custId;

   ReturnCode:='0';
 --异常处理
 -- exception
   --   when others then
     --  ReturnCode:='1'; --数据库异常
END proc_bccusinfo_remove;
/

prompt
prompt Creating procedure PROC_BCCUSTTYPE_ADD
prompt ======================================
prompt
CREATE OR REPLACE PROCEDURE iqms_new.proc_bccusttype_add
(
 custLevel varchar2,
 custName varchar2,
 vipFlag varchar2 ,
 smsFlag varchar2 ,
 waitTimeout varchar2,
 presentFlag varchar2,
 isUse varchar2,
 v_expend1 varchar2,
 v_expend2 varchar2,
 v_expend3 varchar2,
 ReturnCode OUT varchar2
)
AS
iRecCount INTEGER;
eCount INTEGER;
BEGIN
 --查询要增加的记录是否存在
 select count(1) into iRecCount from bc_custtype t where t.cust_level = custLevel;
 select count(1) into eCount from bc_custtype t where t.cust_name = custName;

 if iRecCount > 0 then
   ReturnCode:='2'; --该客户类型已经存在
 elsif eCount > 0 then
   ReturnCode:='3';
 else
   --插入
   insert into bc_custtype t (
      CUST_LEVEL,
      CUST_NAME,
      VIP_FLAG,
      SMS_FLAG,
      WAIT_TIMEOUT,
      PRESENT_FLAG,
      IS_USE,
      EXTEND1,
      EXTEND2,
      EXTEND3
   ) values (
     custLevel,
     custName,
     vipFlag,
     smsFlag,
      waitTimeout,
      presentFlag,
      isUse,
      v_expend1,
      v_expend2,
      v_expend3
   );
   ReturnCode:='0';
 end if;
 --异常处理
 -- exception
   --   when others then
     --  ReturnCode:='1'; --数据库异常
END proc_bccusttype_add;
/

prompt
prompt Creating procedure PROC_BCCUSTTYPE_EDIT
prompt =======================================
prompt
CREATE OR REPLACE PROCEDURE iqms_new.proc_bccusttype_edit
(
 custLevel varchar2,
 cusName varchar2,
 vipFlag varchar2 ,
 smsFlag varchar2 ,
 waitTimeout varchar2,
 presentFlag varchar2,
 isUse varchar2,
 v_expend1 varchar2,
 v_expend2 varchar2,
 v_expend3 varchar2,
 ReturnCode OUT varchar2
)
AS
iRecCount INTEGER;
BEGIN

   update bc_custtype t set
      t.CUST_LEVEL = custLevel,
      t.CUST_NAME =cusName,
      t.VIP_FLAG = vipFlag,
      t.SMS_FLAG = smsFlag,
      t.WAIT_TIMEOUT = waitTimeout,
      t.PRESENT_FLAG = presentFlag,
      t.IS_USE = isUse,
      t.EXTEND1 = v_expend1,
      t.EXTEND2 = v_expend2,
      t.EXTEND3 = v_expend3
   where t.cust_level = custLevel;

   ReturnCode:='0';
 --异常处理
 -- exception
   --   when others then
     --  ReturnCode:='1'; --数据库异常
END proc_bccusttype_edit;
/

prompt
prompt Creating procedure PROC_BCCUSTTYPE_PAGE
prompt =======================================
prompt
create or replace procedure iqms_new.proc_bccusttype_page (
custName varchar2, --类型名称

orderfield in varchar2,
ordertype in varchar2,
pagesize in number, pageno in number,totalrows out number,p_cursor out sys_refcursor)
as
   v_sql varchar2(4000);
   v_sql_page varchar2(4000);
   v_sql_condition varchar2(4000);
   v_sql_count varchar2(4000);
   v_begin number := (pageno-1)*pagesize+1;
   v_end number := pageno*pagesize;
   v_sort varchar2(50);
   v_custName varchar2(50) := custName;

begin
---------------------------------------------------------1.按条件查询数据 start------------------------------------------------------------------

  v_sql_condition := ' select CUST_LEVEL,h.rowId rid,CUST_NAME,VIP_FLAG,SMS_FLAG,WAIT_TIMEOUT,
                     PRESENT_FLAG,IS_USE,EXTEND1,EXTEND2,EXTEND3 from bc_custtype h where 1=1  ';


  if v_custName is not null then
     v_sql_condition := v_sql_condition || ' and h.cust_name like ''%''||:custName||''%''';
   else
     v_custName := '@#$&^%$#@!';
     v_sql_condition := v_sql_condition || ' and ( h.cust_name  is null or h.cust_name <>:custName)';

  end if;


  -------------------------------------------------2.包裹按条件查询的语句，进行分页 开始------------------------------------------------------------
  if (orderfield is null) then
      v_sort := 'cust_level ';
  else
      v_sort := orderfield||' '||ordertype;
  end if;

 --select result
 v_sql := 'select row_number() over ( order by '||v_sort||',rid) rnum,tt.CUST_LEVEL,
  tt.CUST_NAME,
  tt.VIP_FLAG,
  tt.SMS_FLAG,
  tt.WAIT_TIMEOUT,
  tt.PRESENT_FLAG,
  tt.IS_USE,
  tt.EXTEND1,
  tt.EXTEND2,
  tt.EXTEND3
   from ('||v_sql_condition||') tt ';

   --select count
  v_sql_count := 'select count(1) from ('||v_sql||')';


------------------------------------------------------------3.判断是分页还是查询列表

   if pageno > 0  then
    v_sql_page := 'select * from ('||v_sql||') temp where temp.rnum >= :v_begin and temp.rnum <= :v_end';
     execute immediate v_sql_count into totalrows using v_custName;
     OPEN p_cursor FOR v_sql_page using  v_custName,v_begin,v_end;
  else
    totalrows:=0; --set default value
    v_sql_page := 'select * from ('||v_sql||') temp ';
    OPEN p_cursor FOR v_sql_page using  v_custName;
  end if;

end proc_bccusttype_page;
/

prompt
prompt Creating procedure PROC_BCCUSTTYPE_REMOVE
prompt =========================================
prompt
CREATE OR REPLACE PROCEDURE iqms_new.proc_bccusttype_remove
(
 custLevel varchar2,
 ReturnCode OUT varchar2
)
AS
iRecCount INTEGER;
BEGIN

   delete from  bc_custtype t where t.cust_level = custLevel;

   ReturnCode:='0';
 --异常处理
 -- exception
   --   when others then
     --  ReturnCode:='1'; --数据库异常
END proc_bccusttype_remove;
/

prompt
prompt Creating procedure PROC_BCMENU_ADD
prompt ==================================
prompt
CREATE OR REPLACE PROCEDURE iqms_new.proc_bcmenu_add
(
 menuName varchar2,
 menuEnName varchar2 ,
 expend1 varchar2,
 ReturnCode OUT varchar2
)
AS
iRecCount INTEGER;
eCount INTEGER;
BEGIN

 --查询要增加的记录是否存在
 select count(1) into iRecCount from bc_menu t where t.menu_name = menuName;
 select count(1) into eCount from bc_menu t where t.menu_enname = menuEnName;

 if iRecCount > 0 then
   ReturnCode:='2'; --该客户类型已经存在
 elsif eCount>0 then
 ReturnCode:='3';
 else
   --插入
   insert into bc_menu t (
      MENU_ID,
      MENU_NAME,
      MENU_ENNAME,
      EXTEND1
   ) values (
     SEQ_BCMENU.NEXTVAL,
     menuName,
     menuEnName,
     expend1
   );
   --update bsc_device b set b.extend1 = '1';
   proc_deviceupdateflag('','1');
   ReturnCode:='0';
 end if;
 --异常处理
 -- exception
   --   when others then
     --  ReturnCode:='1'; --数据库异常
END proc_bcmenu_add;
/

prompt
prompt Creating procedure PROC_BCMENU_EDIT
prompt ===================================
prompt
CREATE OR REPLACE PROCEDURE iqms_new.proc_bcmenu_edit
(
 menuId varchar2,
 menuName varchar2,
 menuEnName varchar2 ,
 expend1 varchar2,
 ReturnCode OUT varchar2
)
AS
iRecCount1 INTEGER;
iRecCount2 INTEGER;
BEGIN
--查询要增加的记录是否存在
 select count(1) into iRecCount1 from bc_menu t where t.menu_name = menuName
  and t.menu_id != menuId;

  select count(1) into iRecCount2 from bc_menu t where t.menu_enname = menuEnName
  and t.menu_id != menuId;
   if iRecCount1 > 0 then
   ReturnCode:='2'; --该客户名称已经存在

   elsif iRecCount2 > 0 then
   ReturnCode:='3'; --该客户英文名已经存在
 else
   update bc_menu t set
      t.MENU_ID = menuId,
      t.MENU_NAME =menuName,
      t.MENU_ENNAME = menuEnName,
      t.EXTEND1 = expend1
   where t.MENU_ID = menuId;
    --update bsc_device b set b.extend1 = '1';
    proc_deviceupdateflag('','1');
   ReturnCode:='0';
   end if;

 --异常处理
 -- exception
   --   when others then
     --  ReturnCode:='1'; --数据库异常
END proc_bcmenu_edit;
/

prompt
prompt Creating procedure PROC_BCMENU_PAGE
prompt ===================================
prompt
create or replace procedure iqms_new.proc_bcmenu_page (
menuName varchar2, --类型名称

orderfield in varchar2,
ordertype in varchar2,
pagesize in number, pageno in number,totalrows out number,p_cursor out sys_refcursor)
as
   v_sql varchar2(4000);
   v_sql_page varchar2(4000);
   v_sql_condition varchar2(4000);
   v_sql_count varchar2(4000);
   v_begin number := (pageno-1)*pagesize+1;
   v_end number := pageno*pagesize;
   v_sort varchar2(50);
   v_menuName varchar2(50) := menuName;

begin
---------------------------------------------------------1.按条件查询数据 start------------------------------------------------------------------

  v_sql_condition := ' select MENU_ID,h.rowId rid,MENU_NAME,MENU_ENNAME,EXTEND1 from bc_menu h where 1=1  ';


  if v_menuName is not null then
     v_sql_condition := v_sql_condition || ' and h.menu_name like ''%''||:menuName||''%''';
   else
     v_menuName := '@#$&^%$#@!';
     v_sql_condition := v_sql_condition || ' and ( h.menu_name  is null or h.menu_name <>:menuName)';

  end if;


  -------------------------------------------------2.包裹按条件查询的语句，进行分页 开始------------------------------------------------------------
  if (orderfield is null) then
      v_sort := 'menu_name ';
  else
      v_sort := orderfield||' '||ordertype;
  end if;

 --select result
 v_sql := 'select row_number() over ( order by '||v_sort||',rid) rnum,tt.MENU_ID,
  tt.MENU_NAME,
  tt.MENU_ENNAME,
  tt.EXTEND1
  from ('||v_sql_condition||') tt ';

   --select count
  v_sql_count := 'select count(1) from ('||v_sql||')';


------------------------------------------------------------3.判断是分页还是查询列表

   if pageno > 0  then
    v_sql_page := 'select * from ('||v_sql||') temp where temp.rnum >= :v_begin and temp.rnum <= :v_end';
     execute immediate v_sql_count into totalrows using v_menuName;
     OPEN p_cursor FOR v_sql_page using  v_menuName,v_begin,v_end;
  else
    totalrows:=0; --set default value
    v_sql_page := 'select * from ('||v_sql||') temp ';
    OPEN p_cursor FOR v_sql_page using  v_menuName;
  end if;

end proc_bcmenu_page;
/

prompt
prompt Creating procedure PROC_BCMENU_QUERY
prompt ====================================
prompt
create or replace procedure iqms_new.proc_bcmenu_query (
menuId varchar2,
p_cursor out sys_refcursor)
as
   v_sql varchar2(4000);


begin


 --select result
 v_sql := 'select b.menu_name from BC_MENU b,BSC_BRANCH_BUSINESS bsc where  b.menu_id =:menuId
 and b.menu_id = bsc.bus_id and bsc.business_type = ''MENU''';
 OPEN p_cursor FOR v_sql using menuId;


end proc_bcmenu_query;
/

prompt
prompt Creating procedure PROC_BCMENU_REMOVE
prompt =====================================
prompt
CREATE OR REPLACE PROCEDURE iqms_new.proc_bcmenu_remove
(
 menuId varchar2,
 ReturnCode OUT varchar2
)
IS

cursor v_deviceNo is
select bus.device_no from bsc_branch_business bus
where bus.business_type = '0' and bus.bus_id = menuId;
v_no v_deviceNo%rowtype;
iRecCount INTEGER;
BEGIN

   delete from bc_menu t where t.menu_id = menuId;
   --更新设备状态
  --update bsc_device b set b.extend1 = '1' where b.device_no in (select bus.device_no from bsc_branch_business bus
  --where bus.business_type = '0' and bus.bus_id = menuId);
  for v_no in v_deviceNo loop
    proc_deviceupdateflag(v_no.device_no,'0');

  end loop;


  --级联删除【业务显示】中有此菜单下挂的业务
  delete from bsc_show_time s where s.device_no in (
  select b.device_no from bsc_branch_business b where b.business_type = '1' and
         b.tree_pid in (select t.tree_id
                          from bsc_branch_business t
                         where t.business_type = '0'
                           and t.bus_id = menuId))
  and s.business_id in (
               select b.bus_id from bsc_branch_business b where b.business_type = '1' and
         b.tree_pid in (select t.tree_id
                          from bsc_branch_business t
                         where t.business_type = '0'
                           and t.bus_id = menuId));
  --级联删除【叫号策略】中配置的菜单下挂的业务
  delete from bsc_counterbuz s where s.device_no in (
  select b.device_no from bsc_branch_business b where b.business_type = '1' and
         b.tree_pid in (select t.tree_id
                          from bsc_branch_business t
                         where t.business_type = '0'
                           and t.bus_id = menuId))
  and s.buztypeid in (
               select b.bus_id from bsc_branch_business b where b.business_type = '1' and
         b.tree_pid in (select t.tree_id
                          from bsc_branch_business t
                         where t.business_type = '0'
                           and t.bus_id = menuId));

  --级联更新【客户级别】中绑定业务为不绑定业务
  update bsc_cust_level c set c.business_id= null where c.device_no in(
  select b.device_no from bsc_branch_business b where b.business_type = '1' and
         b.tree_pid in (select t.tree_id
                          from bsc_branch_business t
                         where t.business_type = '0'
                           and t.bus_id = menuId))
  and c.business_id in (
               select b.bus_id from bsc_branch_business b where b.business_type = '1' and
         b.tree_pid in (select t.tree_id
                          from bsc_branch_business t
                         where t.business_type = '0'
                           and t.bus_id = menuId));
  --级联删除【网点业务】功能中此菜单及此菜单下挂的业务
  delete from bsc_branch_business b where b.business_type = '1' and
         b.tree_pid in (select t.tree_id
                          from bsc_branch_business t
                         where t.business_type = '0'
                           and t.bus_id = menuId);
  delete from bsc_branch_business b where b.business_type = '0' and b.bus_id = menuId;



   ReturnCode:='0';
 --异常处理
 -- exception
   --   when others then
     --  ReturnCode:='1'; --数据库异常
END proc_bcmenu_remove;
/

prompt
prompt Creating procedure PROC_BCNEAR_EDIT
prompt ===================================
prompt
CREATE OR REPLACE PROCEDURE iqms_new.proc_bcnear_edit
(
 orgId  varchar2,
 orgId1 varchar2,
 orgId2 varchar2,
 orgId3 varchar2,
 orgId4 varchar2,
 orgId5 varchar2,
 orgId6 varchar2,
 ReturnCode OUT varchar2
)
AS
iRecCount INTEGER;
BEGIN
--查询表中是否存在数据
select count(1) into iRecCount from bc_near t where t.org_id = orgId;
if iRecCount > 0 then
   update bc_near t set
      t.org_id = orgId,
      t.org_id1 =orgId1,
      t.org_id2 =orgId2,
      t.org_id3 =orgId3,
      t.org_id4 =orgId4,
      t.org_id5 =orgId5,
      t.org_id6 =orgId6
      where t.org_id = orgId;

   ReturnCode:='0';
else
  INSERT INTO bc_near t (
      ORG_ID,
      ORG_ID1,
      ORG_ID2,
      ORG_ID3,
      ORG_ID4,
      ORG_ID5,
      ORG_ID6
  ) VALUES (
      orgId,
      orgId1,
      orgId2,
      orgId3,
      orgId4,
      orgId5,
      orgId6
  );
  ReturnCode:='0';
  end if;
 --异常处理
 --exception
    -- when others then
     --  ReturnCode:='1'; --数据库异常
END proc_bcnear_edit;
/

prompt
prompt Creating procedure PROC_BCNEAR_QUERY
prompt ====================================
prompt
create or replace procedure iqms_new.proc_bcnear_query (
orgId varchar2,
p_cursor out sys_refcursor)
as
   v_sql varchar2(4000);


begin


 --select result
 v_sql := 'select * from BC_NEAR b where  b.org_id =:orgId ';
 OPEN p_cursor FOR v_sql using orgId;


end proc_bcnear_query;
/

prompt
prompt Creating procedure PROC_BCNEAR_REMOVE
prompt =====================================
prompt
CREATE OR REPLACE PROCEDURE iqms_new.proc_bcnear_remove
(
 orgId varchar2,
 ReturnCode OUT varchar2
)
AS
iRecCount INTEGER;
BEGIN

   delete from  bc_near t where to_char(t.org_id) = orgId;
   commit;
   ReturnCode:='0';
 --异常处理
 exception
     when others then
     ReturnCode:='1'; --数据库异常
END proc_bcnear_remove;
/

prompt
prompt Creating procedure PROC_BCPARAMETER_EDIT
prompt ========================================
prompt
CREATE OR REPLACE PROCEDURE iqms_new.proc_bcparameter_edit
(
 hbInterval varchar2,
 authenticationType varchar2,
 flowPort varchar2,
 httpPort varchar2,
 identPort varchar2,
 appRoot varchar2,
 ReturnCode OUT varchar2
)
AS
iRecCount INTEGER;
BEGIN
--查询表中是否存在数据
select count(1) into iRecCount from bc_parameter t;
if iRecCount > 0 then
   update bc_parameter t set
      t.HB_INTERVAL = hbInterval,
      t.AUTHENTICATION_TYPE =authenticationType,
      t.flow_port = flowPort,
      t.http_port = httpPort,
      t.ident_port = identPort,
      t.app_root = appRoot;

   ReturnCode:='0';
else
  INSERT INTO bc_parameter t (
      HB_INTERVAL,
      AUTHENTICATION_TYPE,
      flow_port,
      http_port,
      ident_port,
      app_root
  ) VALUES (
      hbInterval,
      authenticationType,
      flowPort,
      httpPort,
      identPort,
      appRoot
  );
  ReturnCode:='0';
  end if;
  --修改客户识别中的识别模式
update bsc_cust_recognition c
set c.recognition_type = authenticationType;
  --update bsc_device t set
      --t.extend1 = '1';
 proc_deviceupdateflag('','1');
 --异常处理
 --exception
    -- when others then
     --  ReturnCode:='1'; --数据库异常
END proc_bcparameter_edit;
/

prompt
prompt Creating procedure PROC_BCPARAMETER_QUERY
prompt =========================================
prompt
create or replace procedure iqms_new.proc_bcparameter_query (
p_cursor out sys_refcursor)
as
   v_sql varchar2(4000);


begin


 --select result
 v_sql := 'select * from BC_PARAMETER ';
 OPEN p_cursor FOR v_sql ;


end proc_bcparameter_query;
/

prompt
prompt Creating procedure PROC_BCPATCHVERSION_ADD
prompt ==========================================
prompt
create or replace procedure iqms_new.proc_bcpatchversion_add (
 patchName varchar2,
 patchVerno varchar2,
 md5code varchar2,
 patchPath varchar2,
 patchRemark varchar2,
 p_status varchar2,
 intactFlag varchar2,
 dbFlag varchar2,
 ReturnCode OUT varchar2
)
AS
iRecCount INTEGER;
BEGIN
  select count(1) into iRecCount from bc_patchversion p where p.patch_verno = patchVerno;
   if iRecCount > 0 then 
     ReturnCode:='1';
     else
   --插入
   insert into bc_patchversion (
      id,
      patch_Name,
      patch_Md5,
      patch_PATH,
      patch_remark,
      patch_date,
      status,
      PATCH_VERNO,
      INTACT_FLAG,
      DB_FLAG
   ) values (
     SEQ_BCPATCHVERSION.NEXTVAL,
     patchName,
     md5code,
     patchPath,
     patchRemark,
     sysdate,
     '1',
     patchVerno,
     intactFlag,
     dbFlag
   );
   ReturnCode:='0';
   end if;
 --异常处理
  --exception
   --   when others then
     --  ReturnCode:='1'; --数据库异常
END proc_bcpatchversion_add;
/

prompt
prompt Creating procedure PROC_BCPATCHVERSION_PAGE
prompt ===========================================
prompt
create or replace procedure iqms_new.proc_bcpatchversion_page (
orderfield in varchar2,
ordertype in varchar2,
pagesize in number, pageno in number,totalrows out number,p_cursor out sys_refcursor)
as
   v_sql varchar2(4000);
   v_sql_page varchar2(4000);
   v_sql_condition varchar2(4000);
   v_sql_count varchar2(4000);
   v_begin number := (pageno-1)*pagesize+1;
   v_end number := pageno*pagesize;
   v_sort varchar2(50);

begin
---------------------------------------------------------1.按条件查询数据 start------------------------------------------------------------------

  v_sql_condition := ' select ID,h.rowId rid,
  PATCH_NAME,
  PATCH_MD5,
  PATCH_PATH,
  PATCH_REMARK,
  PATCH_DATE,
  STATUS,
  PATCH_VERNO,
  INTACT_FLAG,
  DB_FLAG
  from bc_patchversion h where 1=1  ';


  -------------------------------------------------2.包裹按条件查询的语句，进行分页 开始------------------------------------------------------------


 --select result
 v_sql := 'select row_number() over ( order by PATCH_DATE desc,rid ) rnum,tt.ID,
  tt.PATCH_NAME,
  tt.PATCH_MD5,
  tt.PATCH_PATH,
  tt.PATCH_REMARK,
  tt.PATCH_DATE,
  tt.STATUS,
  tt.PATCH_VERNO,
  tt.INTACT_FLAG,
  tt.DB_FLAG
   from ('||v_sql_condition||') tt ';

   --select count
  v_sql_count := 'select count(1) from ('||v_sql||')';


------------------------------------------------------------3.判断是分页还是查询列表

   if pageno > 0  then
    v_sql_page := 'select * from ('||v_sql||') temp where temp.rnum >= :v_begin and temp.rnum <= :v_end';
     execute immediate v_sql_count into totalrows;
     OPEN p_cursor FOR v_sql_page using  v_begin,v_end;
  else
    totalrows:=0; --set default value
    v_sql_page := 'select * from ('||v_sql||') temp ';
    OPEN p_cursor FOR v_sql_page;
  end if;

end proc_bcpatchversion_page;
/

prompt
prompt Creating procedure PROC_BCPATCHVERSION_REMOVE
prompt =============================================
prompt
CREATE OR REPLACE PROCEDURE iqms_new.proc_bcpatchversion_remove
(
 idno varchar2,
 ReturnCode OUT varchar2
)
AS
iRecCount INTEGER;
BEGIN
 --获取记录的版本号
 update  bc_patchversion t set t.status='1' where t.id = idno;
 commit;

 ReturnCode := '0';
END proc_bcpatchversion_remove;
/

prompt
prompt Creating procedure PROC_BCTELLER_ADD
prompt ====================================
prompt
CREATE OR REPLACE PROCEDURE iqms_new.proc_bcteller_add
(
 workId varchar2,
 orgId number,
 callerPwd varchar2,
 name_ varchar2,
 sex varchar2,
 status varchar2,
 ReturnCode OUT varchar2
)
AS
iRecCount INTEGER;
BEGIN

 --查询要增加的记录是否存在
 select count(1) into iRecCount from bc_teller t where t.work_id = workId;

 if iRecCount > 0 then
   ReturnCode:='2'; --该柜员工号已经存在
 else

   --插入
   insert into bc_teller t (
      WORK_ID,
      ORG_ID,
      caller_pwd,
      name_,
      sex,
      status
   ) values (
     workId,
     orgId,
     callerPwd,
     name_,
     sex,
     status
   );
   --更新设备状态
  update bsc_device b set b.extend1 = '1' where b.org_id = orgId;
   ReturnCode:='0';
 end if;
 --异常处理
 -- exception
   --   when others then
     --  ReturnCode:='1'; --数据库异常
END proc_bcteller_add;
/

prompt
prompt Creating procedure PROC_BCTELLER_EDIT
prompt =====================================
prompt
CREATE OR REPLACE PROCEDURE iqms_new.proc_bcteller_edit
(
 workId varchar2,
 orgId number,
 callerPwd varchar2 ,
 v_name_ varchar2 ,
 v_sex varchar2 ,
 v_status varchar2 ,
 ReturnCode OUT varchar2
)
AS
iRecCount INTEGER;
BEGIN

   update bc_teller t set
      t.org_id =orgId,
      t.caller_pwd = callerPwd,
      t.name_ = v_name_,
      t.sex = v_sex,
      t.status = v_status
   where t.work_id = workId;
update bsc_device b set b.extend1 = '1' where b.org_id = orgId;

   ReturnCode:='0';
 --异常处理
 -- exception
   --   when others then
     --  ReturnCode:='1'; --数据库异常
END proc_bcteller_edit;
/

prompt
prompt Creating procedure PROC_BCTELLER_PAGE
prompt =====================================
prompt
create or replace procedure iqms_new.proc_bcteller_page (
orgId varchar2,--机构id
name_ varchar2, --柜员名称

orderfield in varchar2,
ordertype in varchar2,
pagesize in number, pageno in number,totalrows out number,p_cursor out sys_refcursor)
as
   v_sql varchar2(4000);
   v_sql_page varchar2(4000);
   v_sql_condition varchar2(4000);
   v_sql_count varchar2(4000);
   v_begin number := (pageno-1)*pagesize+1;
   v_end number := pageno*pagesize;
   v_sort varchar2(50);
   v_name varchar2(50) := name_;
   v_org_id number := orgId;
begin
---------------------------------------------------------1.按条件查询数据 start------------------------------------------------------------------
if v_org_id = '0' then
  v_org_id := '1';
  end if;
  v_sql_condition := ' select h.org_id,h.rowId rid,h.work_id,h.caller_pwd,h.name_,h.sex,
                     h.status,s.org_code,s.org_name from bc_teller h inner join (select *
                 from sys_org o
                where o.deleted = 0
                start with o.org_id = :orgId
               connect by prior o.org_id = o.parent_id) s
      on (h.ORG_ID = s.ORG_ID)';

  --if v_org_id !=0 then
    -- v_sql_condition := v_sql_condition || ' and s.org_id =:orgId';
  -- else
    -- v_org_id := 0;
    -- v_sql_condition := v_sql_condition || ' and ( s.org_id  is null or s.org_id <>:orgId)';

  --end if;
  if v_name is not null then
     v_sql_condition := v_sql_condition || ' and h.name_ like ''%''||:name_||''%''';
   else
     v_name := '@#$&^%$#@!';
     v_sql_condition := v_sql_condition || ' and ( h.name_  is null or h.name_ <>:name_)';

  end if;


  -------------------------------------------------2.包裹按条件查询的语句，进行分页 开始------------------------------------------------------------
  if (orderfield is null) then
      v_sort := 'org_code';
  else
      v_sort := orderfield||' '||ordertype;
  end if;

 --select result
 v_sql := 'select row_number() over ( order by '||v_sort||',rid) rnum,tt.org_id,
  tt.work_id,
  tt.caller_pwd,
  tt.name_,
  tt.sex,
  tt.status,
  tt.org_code,
  tt.org_name
   from ('||v_sql_condition||') tt ';

   --select count
  v_sql_count := 'select count(1) from ('||v_sql||')';


------------------------------------------------------------3.判断是分页还是查询列表

   if pageno > 0  then
    v_sql_page := 'select * from ('||v_sql||') temp where temp.rnum >= :v_begin and temp.rnum <= :v_end';
     execute immediate v_sql_count into totalrows using v_org_id, v_name;
     OPEN p_cursor FOR v_sql_page using v_org_id, v_name,v_begin,v_end;
  else
    totalrows:=0; --set default value
    v_sql_page := 'select * from ('||v_sql||') temp ';
    OPEN p_cursor FOR v_sql_page using v_org_id, v_name;
  end if;

end proc_bcteller_page;
/

prompt
prompt Creating procedure PROC_BCTELLER_REMOVE
prompt =======================================
prompt
CREATE OR REPLACE PROCEDURE iqms_new.proc_bcteller_remove
(
 workId varchar2,
 ReturnCode OUT varchar2
)
AS
iRecCount INTEGER;
BEGIN
   update bsc_device b set b.extend1 = '1'
   where b.org_id =
   (select t.org_id from bc_teller t where t.work_id = workId);
   delete from  bc_teller t where t.work_id = workId;


   ReturnCode:='0';
 --异常处理
 -- exception
   --   when others then
     --  ReturnCode:='1'; --数据库异常
END proc_bcteller_remove;
/

prompt
prompt Creating procedure PROC_BOOKCANCEL
prompt ==================================
prompt
CREATE OR REPLACE PROCEDURE iqms_new.proc_bookCancel
(
 orgCode IN varchar2,  -- 机构编码
 actNo in varchar2, --激活码
 orderDt in varchar2,
 certType in varchar2, -- 证件类型
 certContent in varchar2, -- 证件号
 ReturnCode out varchar2  -- 返回结果  0-成功   1-失败

)
AS
  recordExists INTEGER DEFAULT 0;
BEGIN
 ReturnCode := 0; -- 成功
  -- 查询激活码是否可用，此机构预约日期激活码不重复
  SELECT COUNT(1)  INTO recordExists FROM order_info i  WHERE i.org_code = orgCode
                                                               --and r.dev_no = devNo
                                                               and i.act_no = actNo
                                                               and order_date = orderDt;

  if recordExists = 0 then
     ReturnCode := 1; -- 失败
     return;
  end if;




     update ORDER_INFO oi set oi.order_status = '2' where oi.org_code = orgCode and
      oi.order_date = orderDt and
      (oi.act_no = actNo or (oi.cert_type = certType and oi.cert_content=certContent));

ReturnCode := 0;
END proc_bookCancel;
/

prompt
prompt Creating procedure PROC_BSCBRANCHBUSINESS_NEW
prompt =============================================
prompt
create or replace procedure iqms_new.proc_bscbranchbusiness_new (
orgId varchar2,
menuId varchar2,
businessId varchar2,
p_cursor out sys_refcursor)
as
   v_sql varchar2(4000);


begin
if menuId =0 then

 --select result
 v_sql := 'select s.org_name orgName,'''' menuName, bm.business_name businessName
 from  SYS_ORG s, BC_BUSINESSMANAGE bm
 where  s.org_id =:orgId
   and bm.business_id =:business_id';
 OPEN p_cursor FOR v_sql using orgId,businessId;
else
v_sql := 'select s.org_name orgName, m.menu_name menuName, bm.business_name businessName
 from  SYS_ORG s,bc_menu m, BC_BUSINESSMANAGE bm
 where  s.org_id =:orgId and m.menu_id =:menuId
   and bm.business_id =:business_id';
 OPEN p_cursor FOR v_sql using orgId,menuId,businessId;
end if;



end proc_bscbranchbusiness_new;
/

prompt
prompt Creating procedure PROC_BSCBRANCHBUSINESS_QUERY
prompt ===============================================
prompt
create or replace procedure iqms_new.proc_bscbranchbusiness_query (
orgId varchar2,
deviceNo varchar2,
treeId varchar2,
p_cursor out sys_refcursor)
as
   v_sql varchar2(4000);
   iRecCount INTEGER;

begin
if treeId ='-1' then

 --select result
 v_sql := 'select b.*,s.org_code,s.org_name,
 decode(b.business_type,''1'',(select bm.business_name from BC_BUSINESSMANAGE bm where b.bus_id= bm.business_id),
 ''0'',(select m.menu_name from bc_menu m where b.bus_id=m.menu_id) ) branchName,
 decode(b.business_type,''1'',(select bm.business_ename from BC_BUSINESSMANAGE bm where b.bus_id= bm.business_id),
 ''0'',(select m.menu_enname from bc_menu m where b.bus_id=m.menu_id) ) businessEnName
 from bsc_branch_business b, SYS_ORG s
 where  b.org_id =:orgId and b.device_no =:deviceNo and  b.org_id = s.org_id';
 OPEN p_cursor FOR v_sql using orgId,deviceNo;
else
 select count(1) into iRecCount from bsc_branch_business b where b.tree_id
 =treeId;
 if iRecCount > 0 then
 v_sql := 'select b.*,s.org_code,s.org_name,
 (select bm.business_name from BC_BUSINESSMANAGE bm where b.bus_id= bm.business_id) branchName,
 (select bm.business_ename from BC_BUSINESSMANAGE bm where b.bus_id= bm.business_id) businessEnName
 from bsc_branch_business b, SYS_ORG s
 where  b.org_id =:orgId and b.device_no =:deviceNo and  b.org_id = s.org_id and b.tree_id=:treeId ';

  OPEN p_cursor FOR v_sql using orgId,deviceNo,treeId;
  else
    v_sql := 'select b.business_name branchName,
    b.business_ename businessEnName
from bc_businessmanage b
 where  b.business_id=:treeId ';

  OPEN p_cursor FOR v_sql using treeId;
    end if;
end if;



end proc_bscbranchbusiness_query;
/

prompt
prompt Creating procedure PROC_BSCBRANCHBUS_ADD
prompt ========================================
prompt
CREATE OR REPLACE PROCEDURE iqms_new.proc_bscbranchbus_add
(
 orgId varchar2,
 deviceNo varchar2,
 treeId varchar2,
 treePid varchar2,
 businessEnName varchar2,
 businessType varchar2,
 businessCode varchar2,
 callHead varchar2,
 priorTime varchar2,
 isSwipe varchar2,
 isShowEn varchar2,
 pickUpAdvice varchar2,
 maxPickUp varchar2,
 sortNum varchar2,
 extend1 varchar2,
 extend2 varchar2,
 extend3 varchar2,
 busId   varchar2,
 levelNum varchar2,
 ReturnCode OUT varchar2
)
AS
iRecCount INTEGER;
codeCount1 INTEGER;

timesCount integer;
BEGIN

 --查询要增加的记录是否存在
 --select count(1) into iRecCount from DEVICE_INFO t where t.org_code = orgCode and t.device_no = deviceNo;
 select count(1) into iRecCount from BSC_BRANCH_BUSINESS t where t.org_id=orgId and t.device_no = deviceNo and t.tree_id = treeId;
 select count(1) into timesCount from bsc_show_time t
 where t.device_no = deviceNo and t.business_id = busId;

 select count(1) into codeCount1 from BSC_BRANCH_BUSINESS t where t.device_no = deviceNo
 and t.tree_id <> treeId and t.business_type = businessType
 and t.business_code = businessCode;
 if codeCount1>0 then
   ReturnCode:='2';--业务代码重复
   return;
  end if;
 if iRecCount > 0 then
   update BSC_BRANCH_BUSINESS t set
      t.ORG_ID = orgId,
      t.DEVICE_NO =deviceNo,
      t.tree_id =treeId,
      t.tree_pid =treePid,
      t.BUSINESS_EN_NAME = businessEnName,
      t.business_type = businessType,
      t.BUSINESS_CODE = businessCode,
      t.PRIOR_TIME =priorTime,
      t.CALL_HEAD =callHead,
      t.IS_SWIPE =isSwipe,
      t.IS_SHOW_EN =isShowEn,
      t.PICK_UP_ADVICE =pickUpAdvice,
      t.MAX_PICK_UP = maxPickUp,
      t.SORT_NUM = sortNum,
      t.EXTEND1 =extend1,
      t.EXTEND2 =extend2,
      t.EXTEND3 =extend3,
      t.levelnum = levelNum,
      t.bus_id = busId
      where t.org_id = orgId
      and t.device_no = deviceNo
      and t.tree_id = treeId;
 else
   --插入
   insert into BSC_BRANCH_BUSINESS (
      ORG_ID,
      DEVICE_NO,
      tree_id,
      tree_pid,
      BUSINESS_EN_NAME,
      BUSINESS_TYPE,
      BUSINESS_CODE,
      PRIOR_TIME,
      CALL_HEAD,
      IS_SWIPE,
      IS_SHOW_EN,
      PICK_UP_ADVICE,
      MAX_PICK_UP,
      SORT_NUM,
      EXTEND1,
      EXTEND2,
      EXTEND3,
      bus_id,
      levelnum
   ) values (
     orgId,
     deviceNo,
     treeId,
     treePid,
     businessEnName,
     businessType,
     businessCode,
     priorTime,
     callHead,
     isSwipe,
     isShowEn,
     pickUpAdvice,
     maxPickUp,
     sortNum,
     extend1,
     extend2,
     extend3,
     busId,
     levelNum
   );

   --更新设备状态
--update bsc_device b set b.extend1 = '1' where b.org_id = orgId
--and b.device_no = deviceNo;
 end if;
 if timesCount = 0  then
   insert into BSC_SHOW_TIME (
      ORG_ID,
      DEVICE_NO,
      business_id,
      row_id,
      date_type,
      begin_time,
      end_time,
      max_num
   ) values (
     orgId,
     deviceNo,
     treeId,
     1,
     'N',
     '08:00',
     '23:00',
     999
   );
   insert into BSC_SHOW_TIME (
      ORG_ID,
      DEVICE_NO,
      business_id,
      row_id,
      date_type,
      begin_time,
      end_time,
      max_num
   ) values (
     orgId,
     deviceNo,
     treeId,
     1,
     'H',
     '08:00',
     '23:00',
     999
   );
   end if;

   proc_deviceupdateflag(deviceNo,'0');
   ReturnCode:='0';

 --异常处理
 -- exception
   --   when others then
     --  ReturnCode:='1'; --数据库异常
END proc_bscbranchbus_add;
/

prompt
prompt Creating procedure PROC_BSCBRANCHBUS_BUZ
prompt ========================================
prompt
create or replace procedure iqms_new.proc_bscbranchbus_buz (
orgId varchar2,
deviceNo varchar2,
p_cursor out sys_refcursor)
as
   v_sql varchar2(4000);


begin



 v_sql := 'select b.org_id,b.device_no,b.business_type,
b.bus_id,
tree_pid,
 b.business_code,
b.prior_time,b.max_pick_up,b.call_head,
(select bm.business_name from BC_BUSINESSMANAGE bm where b.bus_id= bm.business_id)
 branchName,
b.business_en_name,
b.is_show_en,b.is_swipe,b.pick_up_advice,b.sort_num

 from bsc_branch_business b
 where  b.org_id =:orgId and b.device_no =:deviceNo
 and b.business_type=''1'' ';
 OPEN p_cursor FOR v_sql using orgId,deviceNo;




end proc_bscbranchbus_buz;
/

prompt
prompt Creating procedure PROC_BSCBRANCHBUS_COPY
prompt =========================================
prompt
CREATE OR REPLACE PROCEDURE iqms_new.proc_bscbranchbus_copy--应用到下级机构
(
 orgId varchar2,
 deviceNo varchar2,
 targetId varchar2,--目标orgId
 targetNo varchar2, --目标deviceNo
 ReturnCode OUT varchar2
)
AS
BEGIN
if orgId != targetId or deviceNo != targetNo then

 --删除目标数据再插入
 delete from BSC_BRANCH_BUSINESS b where b.org_id = targetId and b.device_no = targetNo;

   --插入
   insert into BSC_BRANCH_BUSINESS (
      ORG_ID,
      DEVICE_NO,
      tree_id，
      tree_pid，
      BUSINESS_EN_NAME,
      BUSINESS_TYPE,
      BUSINESS_CODE,
      PRIOR_TIME,
      CALL_HEAD,
      IS_SWIPE,
      IS_SHOW_EN,
      PICK_UP_ADVICE,
      MAX_PICK_UP,
      SORT_NUM,
      EXTEND1,
      EXTEND2,
      EXTEND3,
      bus_id,
      LEVELNUM
   ) select
     targetId,
     targetNo,
      tree_id，
      tree_pid，
      BUSINESS_EN_NAME,
      BUSINESS_TYPE,
      BUSINESS_CODE,
      PRIOR_TIME,
      CALL_HEAD,
      IS_SWIPE,
      IS_SHOW_EN,
      PICK_UP_ADVICE,
      MAX_PICK_UP,
      SORT_NUM,
      EXTEND1,
      EXTEND2,
      EXTEND3,
      bus_id,
      LEVELNUM
    from BSC_BRANCH_BUSINESS w where w.org_id = orgId and w.device_no=deviceNo;
 proc_deviceupdateflag(deviceNo,'0');
   ReturnCode:='0';
end if;
 --异常处理
 -- exception
   --   when others then
     --  ReturnCode:='1'; --数据库异常
END proc_bscbranchbus_copy;
/

prompt
prompt Creating procedure PROC_BSCBRANCHBUS_EDIT
prompt =========================================
prompt
CREATE OR REPLACE PROCEDURE iqms_new.proc_bscbranchbus_edit
(
 orgId varchar2,
 deviceNo varchar2,
 treeId varchar2,
 treePid varchar2,
 businessEnName varchar2,
 businessType varchar2,
 businessCode varchar2,
 callHead varchar2,
 priorTime varchar2,
 isSwipe varchar2,
 isShowEN varchar2,
 pickUpAdvice varchar2,
 maxPickUp varchar2,
 sortNum varchar2,
 extend1 varchar2,
 extend2 varchar2,
 extend3 varchar2,
 ReturnCode OUT varchar2
)
AS
prefixCount INTEGER;
BEGIN
   select count(1) into prefixCount from BSC_BRANCH_BUSINESS t
 where t.org_id=orgId and t.device_no = deviceNo and t.call_head = callHead
 and t.tree_id != treeId;
 if prefixCount>0 then
   ReturnCode:='2';--呼叫字头不能重复
   else
   update BSC_BRANCH_BUSINESS t set
      t.ORG_ID = orgId,
      t.DEVICE_NO =deviceNo,
      t.TREE_ID =treeId,
      t.business_type = businessType,
      t.TREE_PID =treePid,
      t.BUSINESS_EN_NAME = businessEnName,
      t.BUSINESS_CODE = businessCode,
      t.PRIOR_TIME =priorTime,
      t.CALL_HEAD =callHead,
      t.IS_SWIPE =isSwipe,
      t.IS_SHOW_EN =isShowEn,
      t.PICK_UP_ADVICE =pickUpAdvice,
      t.MAX_PICK_UP = maxPickUp,
      t.SORT_NUM = sortNum,
      t.EXTEND1 =extend1,
      t.EXTEND2 =extend2,
      t.EXTEND3 =extend3
      where t.org_id = orgId
      and t.device_no = deviceNo
      and t.tree_id = treeId;
--更新设备状态
--update bsc_device b set b.extend1 = '1' where b.org_id = orgId
--and b.device_no = deviceNo;
proc_deviceupdateflag(deviceNo,'0');
   ReturnCode:='0';
   end if;
 --异常处理
 -- exception
   --   when others then
     --  ReturnCode:='1'; --数据库异常
END proc_bscbranchbus_edit;
/

prompt
prompt Creating procedure PROC_BSCBRANCHBUS_LEVEL
prompt ==========================================
prompt
create or replace procedure iqms_new.proc_bscbranchbus_level (
orgId varchar2,
deviceNo varchar2,
treePid varchar2,
p_cursor out sys_refcursor)
as
   v_sql varchar2(4000);


begin
--,b.org_id,b.device_no,b.tree_id,b.tree_pid
 v_sql := 'select max(levelnum) as lev
 from bsc_branch_business b
 where  b.org_id =:orgId and b.device_no =:deviceNo
  start with b.tree_pid =:treePid
  connect by prior b.tree_pid = tree_id';
 OPEN p_cursor FOR v_sql using orgId,deviceNo,treePid;



end proc_bscbranchbus_level;
/

prompt
prompt Creating procedure PROC_BSCBRANCHBUS_QUERY
prompt ==========================================
prompt
create or replace procedure iqms_new.proc_bscbranchbus_query (--查询所有的业务不包括菜单
orgId varchar2,
deviceNo varchar2,

p_cursor out sys_refcursor)
as
   v_sql varchar2(4000);


begin


 --select result
 v_sql := 'select b.*,
 bm.business_name branchName
 from bsc_branch_business b, BC_BUSINESSMANAGE bm
 where  b.org_id =:orgId and b.device_no =:deviceNo
  and b.bus_id = bm.business_id and b.business_type=''BUS''';
 OPEN p_cursor FOR v_sql using orgId,deviceNo;




end proc_bscbranchbus_query;
/

prompt
prompt Creating procedure PROC_BSCBRANCHBUS_REMOVE
prompt ===========================================
prompt
CREATE OR REPLACE PROCEDURE iqms_new.proc_bscbranchbus_remove
(
 orgId varchar2,
 deviceNo varchar2,
 treeId varchar2,
 ReturnCode OUT varchar2
)
AS

busType varchar2(10);
busId varchar2(20);
BEGIN

 select t.business_type into busType from BSC_BRANCH_BUSINESS t
 where t.org_id = orgId and t.device_no = deviceNo and t.tree_id = treeId;
 select t.bus_id into busId from BSC_BRANCH_BUSINESS t
 where t.org_id = orgId and t.device_no = deviceNo and t.tree_id = treeId;

--删除网点业务同时 删除业务显示数据
 delete from Bsc_Show_Time s
 where s.device_no = deviceNo and s.org_id = orgId
 and s.business_id = busId;
--级联删除 叫号策略中关联业务
 delete from  bsc_counterbuz t
 where t.org_id = orgId and t.device_no = deviceNo and t.buztypeid = busId;
--设置 客户等级 中绑定业务 为不绑定
update bsc_cust_level c set c.business_id=0
where c.device_no = deviceNo and c.business_id = busId;
--级联删除 【取号界面】
delete from bc_modelstyle_element m
where m.buztype_id =  busId and m.element_type = 'buzType'
 and m.device_no = deviceNo;
--更新设备状态
--update bsc_device b set b.extend1 = '1' where b.org_id = orgId
--and b.device_no = deviceNo;

 delete from  BSC_BRANCH_BUSINESS t
 where t.org_id = orgId and t.device_no = deviceNo and t.tree_id = treeId;

 proc_deviceupdateflag(deviceNo,'0');
 ReturnCode:='0';

END proc_bscbranchbus_remove;
/

prompt
prompt Creating procedure PROC_BSCCUSTLEVEL_ADD
prompt ========================================
prompt
CREATE OR REPLACE PROCEDURE iqms_new.proc_bsccustlevel_add
(
 orgId varchar2,
 deviceNo varchar2,
 custLevel varchar2,
 levelName varchar2,
 businessId varchar2,
 priorTime varchar2,
 callHead varchar2,
 maxWaitTime varchar2,
 ticketTemplate varchar2,
 isStart varchar2,
 extend1 varchar2,
 extend2 varchar2,
 extend3 varchar2,
 ReturnCode OUT varchar2
)
AS
iRecCount INTEGER;
v_count INTEGER;
BEGIN

 --查询要增加的记录是否存在
 --select count(1) into iRecCount from DEVICE_INFO t where t.org_code = orgCode and t.device_no = deviceNo;
 select count(1) into iRecCount from BSC_CUST_LEVEL t where t.cust_level=custLevel and t.device_no = deviceNo and t.org_id = orgId;
 select count(1) into v_count from bsc_counterbuz c where c.levelid = custLevel and c.device_no = deviceNo and c.org_id = orgId;
 if iRecCount > 0 then
   update BSC_CUST_LEVEL t set
      t.ORG_ID = orgId,
      t.DEVICE_NO =deviceNo,
      t.CUST_LEVEL =custLevel,
      t.LEVEL_NAME =levelName,
      t.BUSINESS_ID =businessId,
      t.PRIOR_TIME =priorTime,
      t.CALL_HEAD =callHead,
      t.MAX_WAIT_TIME =maxWaitTime,
      t.TICKET_TEMPLATE =ticketTemplate,
      t.IS_START =isStart,
      t.EXTEND1 =extend1,
      t.EXTEND2 =extend2,
      t.EXTEND3 =extend3
      where t.org_id = orgId
      and t.device_no = deviceNo
      and t.CUST_LEVEL = custLevel;
      --更新设备状态
proc_deviceupdateflag(deviceNo,'0');
   ReturnCode:='0'; --已经存在
 else
   --插入
   insert into BSC_CUST_LEVEL (
      ORG_ID,
      DEVICE_NO,
      CUST_LEVEL，
      LEVEL_NAME，
      BUSINESS_ID,
      PRIOR_TIME,
      CALL_HEAD,
      MAX_WAIT_TIME,
      TICKET_TEMPLATE,
      IS_START,
      EXTEND1,
      EXTEND2,
      EXTEND3
   ) values (
     orgId,
     deviceNo,
     custLevel,
     levelName,
     businessId,
     priorTime,
     callHead,
     maxWaitTime,
     ticketTemplate,
     isStart,
     extend1,
     extend2,
     extend3
   );
   --更新设备状态
--update bsc_device b set b.extend1 = '1' where b.org_id = orgId
--and b.device_no = deviceNo;
proc_deviceupdateflag(deviceNo,'0');
   ReturnCode:='0';
 end if;
 if v_count > 0 then
   update bsc_counterbuz c set
   c.custprioritytime = priorTime,
   c.maxwaiting = maxWaitTime
   where c.device_no = deviceNo
   and c.org_id = orgId
   and c.levelid = custLevel;
   end if;
 --异常处理
 -- exception
   --   when others then
     --  ReturnCode:='1'; --数据库异常
END proc_bsccustlevel_add;
/

prompt
prompt Creating procedure PROC_BSCCUSTLEVEL_COPY
prompt =========================================
prompt
CREATE OR REPLACE PROCEDURE iqms_new.proc_bsccustlevel_copy--应用到下级机构
(
 orgId varchar2,
 deviceNo varchar2,
 targetId varchar2,--目标orgId
 targetNo varchar2, --目标deviceNo
 ReturnCode OUT varchar2
)
AS


    -- 定义游标查询源客户等级信息
    cursor custleveldata_cur is select
      org_id,
      device_no,
      CUST_LEVEL，
      LEVEL_NAME，
      BUSINESS_ID,
      PRIOR_TIME,
      CALL_HEAD,
      MAX_WAIT_TIME,
      TICKET_TEMPLATE,
      IS_START,
      EXTEND1,
      EXTEND2,
      EXTEND3
    from Bsc_Cust_Level w where w.org_id = orgId and w.device_no=deviceNo;


    v_tkttmpId varchar2(30); -- 号票模板id
    v_sorceTkName varchar2(30); -- 源设备的号票模板名称
    v_targetTkId varchar2(30); -- 目标设备的对应的设备Id


BEGIN
if orgId != targetId or targetNo != deviceNo then

 --删除目标数据再插入
 delete from Bsc_Cust_Level b where b.org_id = targetId and b.device_no = targetNo;


 -- 遍历客户等级源的值
  for c_custlevel  in custleveldata_cur loop


      -- 查询出源机构等级绑定的号票模板名称
      if c_custlevel.TICKET_TEMPLATE is not null then

         begin
           select tf.tkttmp_name into v_sorceTkName from bc_ticketform tf where to_char(tf.tkttmp_id) =  c_custlevel.TICKET_TEMPLATE and tf.device_no = deviceNo;
         exception
            when others then
            --异常就设置原模板名称为
            v_sorceTkName:='';
         end;


         -- 通过模板名称查询目标机构此模板的id
         begin
           select tf.tkttmp_id into v_targetTkId from bc_ticketform tf where tf.tkttmp_name = v_sorceTkName and tf.device_no = targetNo;
         exception
            when others then
            --异常就设置原模板名称为
            v_targetTkId:='';
         end;

      else
        v_targetTkId:='';
      end if;
       -- 将数据插入到临时表中
       insert into BSC_CUST_LEVEL_TMP values (targetId,targetNo,
                           c_custlevel.cust_level,
                           c_custlevel.business_id,
                           c_custlevel.prior_time,
                           c_custlevel.call_head,
                           c_custlevel.max_wait_time,
                           v_targetTkId,
                           c_custlevel.is_start,
                           c_custlevel.extend1,
                           c_custlevel.extend2,
                           c_custlevel.extend3,
                           c_custlevel.level_name);
  end loop;


  -- 将临时表数据插入到Bsc_Cust_Level中
   insert into Bsc_Cust_Level (
      ORG_ID,
      DEVICE_NO,
      CUST_LEVEL，
      LEVEL_NAME，
      BUSINESS_ID,
      PRIOR_TIME,
      CALL_HEAD,
      MAX_WAIT_TIME,
      TICKET_TEMPLATE,
      IS_START,
      EXTEND1,
      EXTEND2,
      EXTEND3
   ) select
     tmp.org_id,
     tmp.device_no,
      CUST_LEVEL，
      LEVEL_NAME，
      BUSINESS_ID,
      PRIOR_TIME,
      CALL_HEAD,
      MAX_WAIT_TIME,
      TICKET_TEMPLATE,
      IS_START,
      EXTEND1,
      EXTEND2,
      EXTEND3
    from BSC_CUST_LEVEL_TMP tmp where tmp.org_id = targetId and tmp.device_no=targetNo;

   -- 清理临时表
   delete  from BSC_CUST_LEVEL_TMP tmp where tmp.org_id = targetId and tmp.device_no=targetNo;

   ReturnCode:='0';
end if;
proc_deviceupdateflag(deviceNo,'0');
 --异常处理
 -- exception
   --   when others then
     --  ReturnCode:='1'; --数据库异常
END proc_bsccustlevel_copy;
/

prompt
prompt Creating procedure PROC_BSCCUSTLEVEL_EDIT
prompt =========================================
prompt
CREATE OR REPLACE PROCEDURE iqms_new.proc_bsccustlevel_edit
(
 orgId varchar2,
 deviceNo varchar2,
 custLevel varchar2,
 --levelName varchar2,
 businessId varchar2,
 priorTime varchar2,
 callHead varchar2,
 maxWaitTime varchar2,
 ticketTemplate varchar2,
 isStart varchar2,
 extend1 varchar2,
 extend2 varchar2,
 extend3 varchar2,
 ReturnCode OUT varchar2
)
AS

BEGIN

   update BSC_CUST_LEVEL t set
      t.ORG_ID = orgId,
      t.DEVICE_NO =deviceNo,
      t.CUST_LEVEL =custLevel,
     -- t.LEVEL_NAME =levelName,
      t.BUSINESS_ID =businessId,
      t.PRIOR_TIME =priorTime,
      t.CALL_HEAD =callHead,
      t.MAX_WAIT_TIME =maxWaitTime,
      t.TICKET_TEMPLATE =ticketTemplate,
      t.IS_START =isStart,
      t.EXTEND1 =extend1,
      t.EXTEND2 =extend2,
      t.EXTEND3 =extend3
      where t.org_id = orgId
      and t.device_no = deviceNo
      and t.CUST_LEVEL = custLevel;
      proc_deviceupdateflag(deviceNo,'0');
   ReturnCode:='0';
 --异常处理
 -- exception
   --   when others then
     --  ReturnCode:='1'; --数据库异常
END proc_bsccustlevel_edit;
/

prompt
prompt Creating procedure PROC_BSCCUSTLEVEL_PAGE
prompt =========================================
prompt
create or replace procedure iqms_new.proc_bsccustlevel_page (
orgId varchar2, --机构id
deviceNo varchar2,
orderfield in varchar2,
ordertype in varchar2,
pagesize in number, pageno in number,totalrows out number,p_cursor out sys_refcursor)
as
   v_sql varchar2(4000);
   v_sql_page varchar2(4000);
   v_sql_condition varchar2(4000);
   v_sql_count varchar2(4000);
   v_begin number := (pageno-1)*pagesize+1;
   v_end number := pageno*pagesize;
   v_sort varchar2(50);
   v_orgId varchar2(50) := orgId;
   v_deviceNo varchar2(50) := deviceNo;
begin
---------------------------------------------------------1.按条件查询数据 start------------------------------------------------------------------

  v_sql_condition := ' select h.*,h.rowId rid,s.org_code,s.org_name,b.business_name,dic.dic_value level_name
   from bsc_cust_level h,sys_org s,bc_businessmanage b,sys_dic dic where h.org_id=s.org_id
    and h.business_id = b.business_id and h.cust_level = dic.dic_key and dic.dic_type=''levelName''';


  if v_orgId !=0 then
     v_sql_condition := v_sql_condition || ' and h.org_id =:orgId and h.device_no =:deviceNo';
   else
     v_orgId := 0;
     v_sql_condition := v_sql_condition || ' and ( h.org_id  is null or h.org_id <>:orgId)';

  end if;


  -------------------------------------------------2.包裹按条件查询的语句，进行分页 开始------------------------------------------------------------
  if (orderfield is null) then
      v_sort := 'org_id ';
  else
      v_sort := orderfield||' '||ordertype;
  end if;

 --select result
 v_sql := 'select row_number() over ( order by '||v_sort||',rid) rnum, tt.org_id,tt.device_no,
tt.cust_level,tt.business_id,
tt.prior_time,tt.call_head,
tt.max_wait_time,tt.ticket_template,tt.is_start,
tt.extend1,tt.extend2,tt.extend3,tt.level_name,
tt..org_code,tt.org_name,tt.business_name,tt.level_name
  from ('||v_sql_condition||') tt ';

   --select count
  v_sql_count := 'select count(1) from ('||v_sql||')';


------------------------------------------------------------3.判断是分页还是查询列表

   if pageno > 0  then
    v_sql_page := 'select * from ('||v_sql||') temp where temp.rnum >= :v_begin and temp.rnum <= :v_end';
     execute immediate v_sql_count into totalrows using v_orgId,v_deviceNo;
     OPEN p_cursor FOR v_sql_page using  v_orgId,v_deviceNo,v_begin,v_end;
  else
    totalrows:=0; --set default value
    v_sql_page := 'select * from ('||v_sql||') temp ';
    OPEN p_cursor FOR v_sql_page using  v_orgId,v_deviceNo;
  end if;

end proc_bsccustlevel_page;
/

prompt
prompt Creating procedure PROC_BSCCUSTLEVEL_QUERY
prompt ==========================================
prompt
create or replace procedure iqms_new.PROC_BSCCUSTLEVEL_QUERY (
orgId varchar2,
deviceNo varchar2,
--flag varchar2,
p_cursor out sys_refcursor)
as
   v_sql varchar2(4000);


begin


 --select result
 --if flag ='1' then
 v_sql := 'select h.*
   from bsc_cust_level h where

      h.org_id =:orgId and h.device_no =:deviceNo  order by h.cust_level';
 OPEN p_cursor FOR v_sql using orgId,deviceNo;
 --else
  -- v_sql := 'select h.*,dic.dic_value
   --from bsc_cust_level h,sys_dic dic where
    --  h.cust_level = dic.dic_key and dic.dic_type=''levelName''
    -- and h.org_id =:orgId and h.device_no =:deviceNo';
 --OPEN p_cursor FOR v_sql using orgId,deviceNo;
--end if;


end PROC_BSCCUSTLEVEL_QUERY;
/

prompt
prompt Creating procedure PROC_BSCCUSTLEVEL_REMOVE
prompt ===========================================
prompt
CREATE OR REPLACE PROCEDURE iqms_new.proc_bsccustlevel_remove
(
 orgId varchar2,
 deviceNo varchar2,
 custLevel varchar2,
 ReturnCode OUT varchar2
)
AS

BEGIN
 delete from  BSC_CUST_LEVEL t  where t.org_id = orgId and t.device_no = deviceNo and t.cust_level = custLevel;
 proc_deviceupdateflag(deviceNo,'0');
 ReturnCode:='0';
END proc_bsccustlevel_remove;
/

prompt
prompt Creating procedure PROC_BSCCUSTRECOGNITION_ADD
prompt ==============================================
prompt
CREATE OR REPLACE PROCEDURE iqms_new.proc_bsccustrecognition_add
(
 orgId varchar2,
 deviceNo varchar2,
 rowId_ varchar2,
 dateType varchar2,
 startPosition varchar2,
 mateLength varchar2,
 startMateCode varchar2,
 endMateCode varchar2,
 custLevel varchar2,
 --recognitionType varchar2,
 extend1 varchar2,
 extend2 varchar2,
 extend3 varchar2,
 ReturnCode OUT varchar2
)
AS
iRecCount INTEGER;
BEGIN

 --查询要增加的记录是否存在
 --select count(1) into iRecCount from DEVICE_INFO t where t.org_code = orgCode and t.device_no = deviceNo;
 select count(1) into iRecCount from BSC_CUST_RECOGNITION t where t.org_id=orgId and t.device_no = deviceNo
  and t.row_id = rowId_;


 if iRecCount > 0 then
   update BSC_CUST_RECOGNITION t set
      t.ORG_ID = orgId,
      t.DEVICE_NO =deviceNo,
      --t.recognition_type = recognitionType,
      t.row_id =rowId_,
      t.date_type = dateType,
      t.start_position = startPosition,
      t.mate_length = mateLength,
      t.start_mate_code = startMateCode,
      t.end_mate_code = endMateCode,
      t.cust_level = custLevel,
      t.EXTEND1 =extend1,
      t.EXTEND2 =extend2,
      t.EXTEND3 =extend3
      where t.org_id=orgId
      and t.device_no = deviceNo

      and t.row_id = rowId_
      and t.date_type = dateType;
      --更新设备状态
proc_deviceupdateflag(deviceNo,'0');
   ReturnCode:='0'; --已经存在
 else
   --插入
   insert into BSC_CUST_RECOGNITION (
      ORG_ID,
      DEVICE_NO,
      recognition_type,
      row_id,
      date_type,
      start_position,
      mate_length,
      start_mate_code,
      end_mate_code,
      cust_level,
      EXTEND1,
      EXTEND2,
      EXTEND3
   ) values (
     orgId,
     deviceNo,
     (select distinct(p.authentication_type) from bc_parameter p),
     rowId_,
     dateType,
     startPosition,
     mateLength,
     startMateCode,
     endMateCode,
     custLevel,
     extend1,
     extend2,
     extend3
   );
   --更新设备状态
--update bsc_device b set b.extend1 = '1' where b.org_id = orgId
--and b.device_no = deviceNo;
proc_deviceupdateflag(deviceNo,'0');
   ReturnCode:='0';
 end if;
 --异常处理
 -- exception
   --   when others then
     --  ReturnCode:='1'; --数据库异常
END proc_bsccustrecognition_add;
/

prompt
prompt Creating procedure PROC_BSCCUSTRECOGNITION_COPY
prompt ===============================================
prompt
CREATE OR REPLACE PROCEDURE iqms_new.proc_bsccustrecognition_copy--应用到下级机构
(
 orgId varchar2,
 deviceNo varchar2,
 targetId varchar2,--目标orgId
 targetNo varchar2, --目标deviceNo
 ReturnCode OUT varchar2
)
AS
BEGIN
if orgId != targetId or deviceNo != targetNo then

 --删除目标数据再插入
 delete from BSC_CUST_RECOGNITION b where b.org_id = targetId and b.device_no = targetNo;

   --插入
   insert into BSC_CUST_RECOGNITION (
      ORG_ID,
      DEVICE_NO,
      recognition_type,
      row_id,
      date_type,
      start_position,
      mate_length,
      start_mate_code,
      end_mate_code,
      cust_level,
      EXTEND1,
      EXTEND2,
      EXTEND3
   ) select
     targetId,
     targetNo,
      recognition_type,
      row_id,
      date_type,
      start_position,
      mate_length,
      start_mate_code,
      end_mate_code,
      cust_level,
      EXTEND1,
      EXTEND2,
      EXTEND3
    from BSC_CUST_RECOGNITION w where w.org_id = orgId and w.device_no=deviceNo;
    proc_deviceupdateflag(deviceNo,'0');
   ReturnCode:='0';
end if;
 --异常处理
 -- exception
   --   when others then
     --  ReturnCode:='1'; --数据库异常
END proc_bsccustrecognition_copy;
/

prompt
prompt Creating procedure PROC_BSCCUSTRECOGNITION_QUERY
prompt ================================================
prompt
create or replace procedure iqms_new.proc_bsccustrecognition_query (
orgId varchar2,
deviceNo varchar2,
p_cursor out sys_refcursor)
as
   v_sql varchar2(4000);


begin


 --select result
 v_sql := 'select b.*,d.dic_value levelName

 from bsc_cust_recognition b, sys_dic d
 where  b.org_id =:orgId and b.device_no =:deviceNo and  b.cust_level = d.dic_key
 and d.dic_type=''levelName'' order by b.row_id' ;
 OPEN p_cursor FOR v_sql using orgId,deviceNo;



end proc_bsccustrecognition_query;
/

prompt
prompt Creating procedure PROC_BSCCUSTRECOGNITION_REMOVE
prompt =================================================
prompt
CREATE OR REPLACE PROCEDURE iqms_new.proc_bsccustrecognition_remove
(
 orgId varchar2,
 deviceNo varchar2,

 ReturnCode OUT varchar2
)
AS

BEGIN
 delete from  BSC_CUST_RECOGNITION t  where t.org_id = orgId and t.device_no = deviceNo ;
--更新设备状态
--update bsc_device b set b.extend1 = '1' where b.org_id = orgId
--and b.device_no = deviceNo;
proc_deviceupdateflag(deviceNo,'0');
 ReturnCode:='0';
END proc_bsccustrecognition_remove;
/

prompt
prompt Creating procedure PROC_BSCDEVICE_ADD
prompt =====================================
prompt
CREATE OR REPLACE PROCEDURE iqms_new.proc_bscdevice_add
(
 orgId varchar2,
 deviceNo varchar2,
 hostName varchar2,
 ipAddr varchar2,
 macAddr varchar2,
 currtVer varchar2,
 v_producer varchar2,
 installDate varchar2,
 adminName varchar2,
 adminPhone varchar2,
 netorgcode varchar2,--本地网
 orderflag varchar2,--是否可预约
 pextend1  varchar2,
 pextend2  varchar2,
 pextend3  varchar2,
 screenResolution varchar2,
 onlineModel varchar2,
 tpscrollFlag varchar2,
 ReturnCode OUT varchar2
)
AS
iRecCount INTEGER;
custLevel number;
BEGIN

 --查询要增加的记录是否存在
 --select count(1) into iRecCount from DEVICE_INFO t where t.org_code = orgCode and t.device_no = deviceNo;
 select count(1) into iRecCount from BSC_DEVICE t where t.ip_addr=ipAddr or t.device_no = deviceNo;


 if iRecCount > 0 then
   ReturnCode:='3'; --该设备已经存在
 else
   --插入
   insert into BSC_DEVICE (
      ORG_ID,
      DEVICE_NO,
      HOST_NAME，
      IP_ADDR，
      MAC_ADDR,
      CURRT_VER,
      PRODUCER,
      INSTALL_DATE,
      ADMIN_NAME,
      ADMIN_PHONE,
      ONLINE_TIME,
      NET_ORGCODE,
      ORDER_FLAG,

      EXTEND1,
      EXTEND2,
      EXTEND3,
      SCREEN_RESOLUTION,
      Online_Model,
      Tpscroll_Flag
   ) values (
     orgId,
     deviceNo,
     hostName,
     ipAddr,
     macAddr,
     currtVer,
     v_producer,
     to_date(installDate,'yyyy-MM-dd'),
     adminName,
     adminPhone,
     null,
     netorgcode,
     orderflag,

     '1',
     pextend2,
     pextend3,
     screenResolution,
     onlineModel,
     tpscrollFlag
   );

   --在bsc_branch_business里插入菜单'业务类型'
   insert into bsc_branch_business(
   org_id,
   device_no,
   tree_pid,
   tree_id,
   business_type,
   bus_id,
   levelnum,
   max_pick_up)
   values(
   orgId,
   deviceNo,
   '0',
   '1',
   '0',
   1,
   0,
   999
   );
   --插入对应的buztimes
   insert into BSC_SHOW_TIME (
      ORG_ID,
      DEVICE_NO,
      business_id，
      row_id，
      date_type,
      begin_time,
      end_time,
      max_num
   ) values (
     orgId,
     deviceNo,
     1,
     1,
     'H',
     '08:00',
     '23:00',
     999
   );
   insert into BSC_SHOW_TIME (
      ORG_ID,
      DEVICE_NO,
      business_id，
      row_id，
      date_type,
      begin_time,
      end_time,
      max_num
   ) values (
     orgId,
     deviceNo,
     1,
     1,
     'N',
     '08:00',
     '23:00',
     999
   );
   --将设备信息插入bsc_cust_level 表 级别0-9
   custLevel := 0;
   <<repeat_loop>>
   if custLevel < 9 then
     insert into bsc_cust_level (org_id,device_no,cust_level,
     level_name,business_id,prior_time,call_head,
     max_wait_time,ticket_template,is_start)
     values (orgId,
     deviceNo,custLevel,'级别'||custLevel,0,'0',
     '0','0','','1');
   custLevel := custLevel +1;

     GOTO repeat_loop;
   end if;
   ReturnCode:='0';
 end if;
 --异常处理
 -- exception
   --   when others then
     --  ReturnCode:='1'; --数据库异常
END proc_bscdevice_add;
/

prompt
prompt Creating procedure PROC_BSCDEVICE_EDIT
prompt ======================================
prompt
CREATE OR REPLACE PROCEDURE iqms_new.proc_bscdevice_edit
(
 orgId varchar2,
 deviceNo varchar2,
 hostName varchar2,
 ipAddr varchar2,
 macAddr varchar2,
 currtVer varchar2,
 v_producer varchar2,
 installDate varchar2,
 adminName varchar2,
 adminPhone varchar2,
 netorgcode varchar2,--本地网
 orderflag varchar2,--是否可预约
 pextend1  varchar2,
 pextend2  varchar2,
 pextend3  varchar2,
 screenResolution varchar2,
 onlineModel varchar2,
 tpscrollFlag varchar2,
 ReturnCode OUT varchar2
)
AS
iRecCount INTEGER;
BEGIN


 select count(1) into iRecCount from BSC_DEVICE t where t.ip_addr=ipAddr and t.org_id <> orgId;

 if iRecCount > 0 then
   ReturnCode:='2'; --改设备已经存在
   return;
 end if;

 update BSC_DEVICE t set

      t.HOST_NAME = hostName，
      t.IP_ADDR = ipAddr，
      t.MAC_ADDR = macAddr,
      t.PRODUCER = v_producer,
      t.INSTALL_DATE = to_date(installDate,'yyyy-MM-dd'),
      t.ADMIN_NAME = adminName,
      t.ADMIN_PHONE = adminPhone,
      t.NET_ORGCODE = netorgcode,
      t.ORDER_FLAG = orderflag,
      t.EXTEND1 = pextend1,
      t.EXTEND2 = pextend2,
      t.EXTEND3 = pextend3,
      t.screen_resolution = screenResolution,
      t.online_model = onlineModel,
      t.tpscroll_flag = tpscrollFlag
 where t.org_Id = orgId and t.device_no = deviceNo;
 --更新设备状态
--update bsc_device b set b.extend1 = '1' where b.org_id = orgId
--and b.device_no = deviceNo;
proc_deviceupdateflag(deviceNo,'0');
 ReturnCode:='0';
 --异常处理
 -- exception
   --   when others then
     --  ReturnCode:='1'; --数据库异常
END proc_bscdevice_edit;
/

prompt
prompt Creating procedure PROC_BSCDEVICE_NAVADD
prompt ========================================
prompt
CREATE OR REPLACE PROCEDURE iqms_new.proc_bscdevice_navadd
(
 orgId varchar2,
 deviceNo varchar2,
 hostName varchar2,
 ipAddr varchar2,
 macAddr varchar2,
 currtVer varchar2,
 v_producer varchar2,
 installDate varchar2,
 adminName varchar2,
 adminPhone varchar2,
 netorgcode varchar2,--本地网
 orderflag varchar2,--是否可预约
 pextend1  varchar2,
 pextend2  varchar2,
 pextend3  varchar2,
 screenResolution varchar2,
 onlineModel varchar2,
 tpscrollFlag varchar2,
 ReturnCode OUT varchar2
)
AS
iRecCount INTEGER;
addrCount INTEGER;
custLevel number;
BEGIN

 --查询要增加的记录是否存在
 --select count(1) into iRecCount from DEVICE_INFO t where t.org_code = orgCode and t.device_no = deviceNo;
 select count(1) into iRecCount from BSC_DEVICE t where  t.device_no = deviceNo;
 select count(1) into addrCount from BSC_DEVICE t where t.ip_addr = ipAddr and t.device_no != deviceNo;

 if iRecCount > 0 then
   update BSC_DEVICE d set d.host_name=hostName,d.ip_addr=ipAddr,d.mac_addr=macAddr,
   d.currt_ver=currtVer,
   d.producer=v_producer, d.install_date=to_date(substr(installDate,1,10),'yyyy-MM-dd'),
   d.admin_name=adminName,d.admin_phone=adminPhone,d.online_time=null,
   d.net_orgcode=netorgcode,d.order_flag=orderflag,d.screen_resolution=screenResolution,
   d.online_model=onlineModel,d.tpscroll_flag=tpscrollFlag where
   d.device_no = deviceNo;
   commit;
   ReturnCode:='2'; --该设备已经存在 更新设备
 elsif addrCount>0 then
  ReturnCode:='3';--ip地址已存在
 else
   --插入
   insert into BSC_DEVICE (
      ORG_ID,
      DEVICE_NO,
      HOST_NAME，
      IP_ADDR，
      MAC_ADDR,
      CURRT_VER,
      PRODUCER,
      INSTALL_DATE,
      ADMIN_NAME,
      ADMIN_PHONE,
      ONLINE_TIME,
      NET_ORGCODE,
      ORDER_FLAG,

      EXTEND1,
      EXTEND2,
      EXTEND3,
      SCREEN_RESOLUTION,
      Online_Model,
      Tpscroll_Flag
   ) values (
     orgId,
     deviceNo,
     hostName,
     ipAddr,
     macAddr,
     currtVer,
     v_producer,
     to_date(installDate,'yyyy-MM-dd'),
     adminName,
     adminPhone,
     null,
     netorgcode,
     orderflag,

     '1',
     pextend2,
     pextend3,
     screenResolution,
     onlineModel,
     tpscrollFlag
   );

   --在bsc_branch_business里插入菜单'业务类型'
   insert into bsc_branch_business(
   org_id,
   device_no,
   tree_pid,
   tree_id,
   business_type,
   bus_id,
   levelnum,
   max_pick_up)
   values(
   orgId,
   deviceNo,
   '0',
   '1',
   '0',
   1,
   0,
   999
   );
   --插入对应的buztimes
   insert into BSC_SHOW_TIME (
      ORG_ID,
      DEVICE_NO,
      business_id，
      row_id，
      date_type,
      begin_time,
      end_time,
      max_num
   ) values (
     orgId,
     deviceNo,
     1,
     1,
     'H',
     '08:00',
     '23:00',
     999
   );
   insert into BSC_SHOW_TIME (
      ORG_ID,
      DEVICE_NO,
      business_id，
      row_id，
      date_type,
      begin_time,
      end_time,
      max_num
   ) values (
     orgId,
     deviceNo,
     1,
     1,
     'N',
     '08:00',
     '23:00',
     999
   );
   --将设备信息插入bsc_cust_level 表 级别0-9
   custLevel := 0;
   <<repeat_loop>>
   if custLevel < 9 then
     insert into bsc_cust_level (org_id,device_no,cust_level,
     level_name,business_id,prior_time,call_head,
     max_wait_time,ticket_template,is_start)
     values (orgId,
     deviceNo,custLevel,'级别'||custLevel,0,'0',
     '0','0','','1');
   custLevel := custLevel +1;

     GOTO repeat_loop;
   end if;
   ReturnCode:='0';
 end if;
 --异常处理
 -- exception
   --   when others then
     --  ReturnCode:='1'; --数据库异常
END proc_bscdevice_navadd;
/

prompt
prompt Creating procedure PROC_BSCDEVICE_PAGE
prompt ======================================
prompt
create or replace procedure iqms_new.proc_bscdevice_page (orgId in varchar2,
islsflag in varchar2,
orderfield in varchar2,
ordertype in varchar2,
pagesize in number, pageno in number,totalrows out number,p_cursor out sys_refcursor)
as
   v_sql varchar2(4000);
   v_sql_page varchar2(4000);
   v_sql_condition varchar2(2000);
   v_sql_count varchar2(4000);
   v_begin number := (pageno-1)*pagesize+1;
   v_end number := pageno*pagesize;
   v_orgid varchar2(20);
   v_islsflag varchar2(20);
   v_sort varchar2(50);

begin

  ---------------------------------------------------------1.按条件查询数据 start------------------------------------------------------------------

  v_sql_condition := 'select
                      h.rowId rid,
                      h.ORG_ID,
                      og.ORG_CODE,
                      og.ORG_NAME,
                      h.DEVICE_NO,
                      h.HOST_NAME,
                      h.IP_ADDR,
                      h.MAC_ADDR,
                      h.CURRT_VER,
                      h.CURRT_VERNAME,
                      h.LAST_VERNAME,
                      h.LAST_VER,
                      (case when (h.LAST_VER is null or h.CURRT_VER = h.LAST_VER) then ''1'' else ''0'' end) is_lstversion,
                      h.PRODUCER,
                      to_char(h.INSTALL_DATE,''yyyy-MM-dd'') INSTALL_DATE,
                      h.ADMIN_NAME,
                      h.ADMIN_PHONE,
                      h.NET_ORGCODE,
                      h.ORDER_FLAG,
                      h.EXTEND1,
                      h.EXTEND2,
                      h.EXTEND3,
                      h.screen_resolution,
                      h.online_model,
                      h.tpscroll_flag,
                      to_char(h.ONLINE_TIME,''yyyy-MM-dd hh24:mi:ss'') ONLINE_TIME from BSC_DEVICE h
  inner join (select * from sys_org o where o.deleted=0  start with o.org_id =:v_orgid
  connect by prior o.org_id = o.parent_id) og on (h.ORG_ID=og.ORG_ID) ';

-------------------------------------------------2.包裹按条件查询的语句，进行分页 开始------------------------------------------------------------
  if (orderfield is null) then
      v_sort := 'ORG_ID ';
  else
      v_sort := orderfield||' '||ordertype;
  end if;

 --select result
 v_sql := 'select row_number() over ( order by '||v_sort||',rid) rnum,
     tt.ORG_ID,
    tt.ORG_CODE,
    tt.ORG_NAME,
    tt.DEVICE_NO,
    tt.HOST_NAME,
    tt.IP_ADDR,
    tt.MAC_ADDR,
    tt.CURRT_VER,
    tt.CURRT_VERNAME,
    tt.LAST_VERNAME,
    tt.LAST_VER,
    tt.is_lstversion,
    tt.PRODUCER,
    tt.INSTALL_DATE,
    tt.ADMIN_NAME,
    tt.ADMIN_PHONE,
    tt.NET_ORGCODE,
    tt.ORDER_FLAG,
    tt.EXTEND1,
    tt.EXTEND2,
    tt.EXTEND3,
    tt.screen_resolution,
    tt.online_model,
    tt.tpscroll_flag,
    tt.ONLINE_TIME
   from ('||v_sql_condition||') tt ';

   --select count
  v_sql_count := 'select count(1) from ('||v_sql||')';

------------------------------------------------------------3.判断是分页还是查询列表

   if pageno > 0  then
    v_sql_page := 'select * from ('||v_sql||') temp where temp.rnum >= :v_begin and temp.rnum <= :v_end';
     execute immediate v_sql_count into totalrows using orgId;
     OPEN p_cursor FOR v_sql_page using  orgId,v_begin,v_end;
  else
    totalrows:=0; --set default value
    v_sql_page := 'select * from ('||v_sql||') temp ';
    OPEN p_cursor FOR v_sql_page using  orgId;
  end if;




end proc_bscdevice_page;
/

prompt
prompt Creating procedure PROC_BSCDEVICE_REMOVE
prompt ========================================
prompt
CREATE OR REPLACE PROCEDURE iqms_new.proc_bscdevice_remove
(
 orgId varchar2,
 deviceNo varchar2,
 ReturnCode OUT varchar2
)
AS
iRecCount INTEGER;
BEGIN
 --删除所有设备相关的网点配置
 delete from bsc_branch_business t where t.device_no = deviceNo;
 delete from bsc_show_time t where t.device_no = deviceNo;
 delete from bc_ticketform t where t.device_no = deviceNo;
 delete from bsc_win_config t where t.device_no = deviceNo;

 delete from bsc_cust_level t where t.device_no = deviceNo;
 delete from bsc_counterbuz t where t.device_no = deviceNo;
 delete from bsc_cust_recognition t where t.device_no = deviceNo;
 delete from bc_modelstyle t where t.device_no =  deviceNo;
 delete from bc_modelstyle_element t where t.device_no = deviceNo;
 delete from bc_takemodel t where t.device_no = deviceNo;

 delete from  BSC_DEVICE t  where t.org_id = orgId and t.device_no = deviceNo;
 ReturnCode:='0';
END proc_bscdevice_remove;
/

prompt
prompt Creating procedure PROC_BSCDEVUPGRADEPROCESS_ADD
prompt ================================================
prompt
CREATE OR REPLACE PROCEDURE iqms_new.proc_BSCDEVUPGRADEPROCESS_add
(
 deviceNo varchar2,
 patchId varchar2,
 ReturnCode OUT varchar2
)
AS
iRecCount INTEGER;
patchName varchar2(100);
dbFlag varchar2(2);
BEGIN


 --查询要增加的记录是否存在
 select count(1) into iRecCount from BSC_DEVUPGRADE_PROCESS t where t.device_no = deviceNo and t.patch_id = patchId and t.status = 0;

 if iRecCount > 0 then
   ReturnCode:='2'; -- 该设备已经使用过了该升级包
 else

 -- 查询版本的名称和是否包含数据(dbFlag  1-有数据库   0-没有数据)
 select v.patch_name,v.db_flag into patchName,dbFlag from bc_patchversion v where v.id = patchId;

   --插入
   insert into BSC_DEVUPGRADE_PROCESS (
      id,
      device_no,
      patch_id,
      optDate,
      status
   ) values (
     SEQ_UPGRADEPROCESS.NEXTVAL,
     deviceNo,
     patchId,
     sysdate,
      '0' --是否已经下发成功
   );

   -- 将信息更新到设备表中
   update bsc_device d set d.last_ver=patchId,d.last_vername=patchName,d.extend1 = dbFlag where d.device_no = deviceNo;

   ReturnCode:='0';
 end if;
 --异常处理
 -- exception
   --   when others then
     --  ReturnCode:='1'; --数据库异常
END proc_BSCDEVUPGRADEPROCESS_add;
/

prompt
prompt Creating procedure PROC_BSCSHOWTIME_ADD
prompt =======================================
prompt
CREATE OR REPLACE PROCEDURE iqms_new.proc_bscshowtime_add
(
 orgId varchar2,
 deviceNo varchar2,
 businessId varchar2,
 rowId_ varchar2,
 dateType varchar2,
 beginTime varchar2,
 endTime varchar2,
 maxNum varchar2,
 extend1 varchar2,
 extend2 varchar2,
 extend3 varchar2,
 ReturnCode OUT varchar2
)
AS
iRecCount INTEGER;
BEGIN

 --查询要增加的记录是否存在
 --select count(1) into iRecCount from DEVICE_INFO t where t.org_code = orgCode and t.device_no = deviceNo;
 select count(1) into iRecCount from BSC_SHOW_TIME t where t.org_id=orgId and t.device_no = deviceNo
  and t.business_id = businessId and t.row_id = rowId_ and t.date_type = dateType;


 if iRecCount > 0 then
   update BSC_SHOW_TIME t set
      t.ORG_ID = orgId,
      t.DEVICE_NO =deviceNo,
      t.business_id =businessId,
      t.row_id =rowId_,
      t.date_type = dateType,
      t.begin_time = beginTime,
      t.end_time = endTime,
      t.max_num = maxNum,
      t.EXTEND1 =extend1,
      t.EXTEND2 =extend2,
      t.EXTEND3 =extend3
      where t.org_id=orgId
      and t.device_no = deviceNo
      and t.business_id = businessId
      and t.row_id = rowId_
      and t.date_type = dateType;
      --更新设备状态
--update bsc_device b set b.extend1 = '1' where b.org_id = orgId
--and b.device_no = deviceNo;
proc_deviceupdateflag(deviceNo,'0');
   ReturnCode:='0'; --已经存在
 else
   --插入
   insert into BSC_SHOW_TIME (
      ORG_ID,
      DEVICE_NO,
      business_id，
      row_id，
      date_type,
      begin_time,
      end_time,
      max_num,
      EXTEND1,
      EXTEND2,
      EXTEND3
   ) values (
     orgId,
     deviceNo,
     businessId,
     rowId_,
     dateType,
     beginTime,
     endTime,
     maxNum,
     extend1,
     extend2,
     extend3
   );
   --更新设备状态
update bsc_device b set b.extend1 = '1' where b.org_id = orgId
and b.device_no = deviceNo;
   ReturnCode:='0';
 end if;
 --异常处理
 -- exception
   --   when others then
     --  ReturnCode:='1'; --数据库异常
END proc_bscshowtime_add;
/

prompt
prompt Creating procedure PROC_BSCSHOWTIME_COPY
prompt ========================================
prompt
CREATE OR REPLACE PROCEDURE iqms_new.proc_bscshowtime_copy--应用到下级机构
(
 orgId varchar2,
 deviceNo varchar2,
 targetId varchar2,--目标orgId
 targetNo varchar2, --目标deviceNo
 ReturnCode OUT varchar2
)
AS
BEGIN

if orgId != targetId or deviceNo != targetNo then
 --删除目标数据再插入
 delete from BSC_SHOW_TIME b where b.org_id = targetId and b.device_no = targetNo;

   --插入
   insert into BSC_SHOW_TIME (
      ORG_ID,
      DEVICE_NO,
      business_id，
      row_id，
      date_type,
      begin_time,
      end_time,
      max_num,
      EXTEND1,
      EXTEND2,
      EXTEND3
   ) select
     targetId,
     targetNo,
      business_id，
      row_id，
      date_type,
      begin_time,
      end_time,
      max_num,
      EXTEND1,
      EXTEND2,
      EXTEND3
    from BSC_SHOW_TIME w where w.org_id = orgId and w.device_no=deviceNo;
 proc_deviceupdateflag(deviceNo,'0');
  ReturnCode:='0';
end if;
 --异常处理
 -- exception
   --   when others then
     --  ReturnCode:='1'; --数据库异常
END proc_bscshowtime_copy;
/

prompt
prompt Creating procedure PROC_BSCSHOWTIME_EXIST
prompt =========================================
prompt
CREATE OR REPLACE PROCEDURE iqms_new.proc_bscshowtime_exist
(
 orgId varchar2,
 deviceNo varchar2,

 ReturnCode OUT varchar2
)
AS
iRecCount INTEGER;
BEGIN

 --查询要增加的记录是否存在
 --select count(1) into iRecCount from DEVICE_INFO t where t.org_code = orgCode and t.device_no = deviceNo;
 select count(1) into iRecCount from BSC_SHOW_TIME t where t.org_id=orgId and t.device_no = deviceNo;



 if iRecCount > 0 then

  ReturnCode:='0'; --已经存在
 else

   ReturnCode:='1';
 end if;
 --异常处理
 -- exception
   --   when others then
     --  ReturnCode:='1'; --数据库异常
END proc_bscshowtime_exist;
/

prompt
prompt Creating procedure PROC_BSCSHOWTIME_QUERY
prompt =========================================
prompt
create or replace procedure iqms_new.proc_bscshowtime_query (
orgId varchar2,
deviceNo varchar2,
businessId varchar2,
p_cursor out sys_refcursor)
as
   v_sql varchar2(4000);


begin

 v_sql := 'select b.* from bsc_show_time b
 where  b.org_id =:orgId and b.device_no =:deviceNo and b.business_id=:businessId ';

  OPEN p_cursor FOR v_sql using orgId,deviceNo,businessId;




end proc_bscshowtime_query;
/

prompt
prompt Creating procedure PROC_BSCSHOWTIME_REMOVE
prompt ==========================================
prompt
CREATE OR REPLACE PROCEDURE iqms_new.proc_bscshowtime_remove
(
 orgId varchar2,
 deviceNo varchar2,
 businessId varchar2,
 ReturnCode OUT varchar2
)
AS

BEGIN
 delete from  BSC_SHOW_TIME t  where t.org_id = orgId and t.device_no = deviceNo and t.business_id = businessId;
 --更新设备状态
--update bsc_device b set b.extend1 = '1' where b.org_id = orgId
--and b.device_no = deviceNo;
proc_deviceupdateflag(deviceNo,'0');
 ReturnCode:='0';
END proc_bscshowtime_remove;
/

prompt
prompt Creating procedure PROC_BSCWINBUS_QUERY
prompt =======================================
prompt
create or replace procedure iqms_new.PROC_BSCWINBUS_QUERY (
orgId varchar2,
deviceNo varchar2,
winNo varchar2,
buzTypeId varchar2,
p_cursor out sys_refcursor)
as
   v_sql varchar2(4000);


begin
if buzTypeId = '-1' then

 --select result
 v_sql := 'select h.*,dic.dic_value,bsc.business_code,bc.business_name
   from bsc_win_bus h,sys_dic dic,bc_businessmanage bc,
   bsc_branch_business bsc
    where
      h.level_id = dic.dic_key and dic.dic_type=''levelName''
      and h.buz_type_id = bc.business_id and h.buz_type_id = bsc.bus_id
      and bsc.business_type = ''BUS''
     and h.org_id =:orgId and h.device_no =:deviceNo and h.win_no =:winNo';
 OPEN p_cursor FOR v_sql using orgId,deviceNo,winNo;
else
 v_sql := 'select h.*,dic.dic_value,bsc.business_code,bc.business_name
   from bsc_win_bus h,sys_dic dic,bc_businessmanage bc,
   bsc_branch_business bsc
    where
      h.level_id = dic.dic_key and dic.dic_type=''levelName''
      and h.buz_type_id = bc.business_id and h.buz_type_id = bsc.bus_id
      and bsc.business_type = ''BUS''
     and h.org_id =:orgId and h.device_no =:deviceNo and h.win_no =:winNo
     and h.buz_type_id =:buzTypeId';
OPEN p_cursor FOR v_sql using orgId,deviceNo,winNo,buzTypeId;
end if;
end PROC_BSCWINBUS_QUERY;
/

prompt
prompt Creating procedure PROC_BSCWINCONFIG_ADD
prompt ========================================
prompt
CREATE OR REPLACE PROCEDURE iqms_new.proc_bscwinconfig_add
(
 orgId varchar2,
 deviceNo varchar2,
 winNo varchar2,
 isCall varchar2,
 isJudge varchar2,
 winScreen varchar2,
 multipleScreen varchar2,
 isStart varchar2,
 rowId_ varchar2,
 extend1 varchar2,
 extend2 varchar2,
 extend3 varchar2,
 ReturnCode OUT varchar2
)
AS
iRecCount INTEGER;
BEGIN

 --查询要增加的记录是否存在
 --select count(1) into iRecCount from DEVICE_INFO t where t.org_code = orgCode and t.device_no = deviceNo;
 select count(1) into iRecCount from BSC_WIN_CONFIG t where t.win_no=winNo and t.device_no = deviceNo and t.org_id = orgId;

 if iRecCount > 0 then
   update BSC_WIN_CONFIG t set
      t.ORG_ID = orgId,
      t.DEVICE_NO =deviceNo,
      t.WIN_NO =winNo,
      t.IS_CALL =isCall,
      t.IS_JUDGE =isJudge,
      t.WIN_SCREEN =winScreen,
      t.MULTIPLE_SCREEN =multipleScreen,
      t.IS_START =isStart,
      t.ROW_ID = rowId_,
      t.win_id = winNo,
      t.EXTEND1 =extend1,
      t.EXTEND2 =extend2,
      t.EXTEND3 =extend3
      where t.org_id = orgId
      and t.device_no = deviceNo
      and t.row_id = rowId_;
      --更新设备状态
  proc_deviceupdateflag(deviceNo,'0');
   ReturnCode:='0'; --该窗口已经存在
 else
   --插入
   insert into BSC_WIN_CONFIG (
      ORG_ID,
      DEVICE_NO,
      WIN_NO，
      IS_CALL，
      IS_JUDGE,
      WIN_SCREEN,
      MULTIPLE_SCREEN,
      IS_START,
      row_id,
      win_id,
      EXTEND1,
      EXTEND2,
      EXTEND3
   ) values (
     orgId,
     deviceNo,
     winNo,
     isCall,
     isJudge,
     winScreen,
     multipleScreen,
     isStart,
     rowId_,
     winNo,
     extend1,
     extend2,
     extend3
   );
   --更新设备状态
  --update bsc_device b set b.extend1 = '1'
  --where b.org_id = orgId and b.device_no = deviceNo;
  proc_deviceupdateflag(deviceNo,'0');
   ReturnCode:='0';
 end if;
 --异常处理
 -- exception
   --   when others then
     --  ReturnCode:='1'; --数据库异常
END proc_bscwinconfig_add;
/

prompt
prompt Creating procedure PROC_BSCWINCONFIG_COPY
prompt =========================================
prompt
CREATE OR REPLACE PROCEDURE iqms_new.proc_bscwinconfig_copy--应用到下级机构
(
 orgId varchar2,
 deviceNo varchar2,
 targetId varchar2,--目标orgId
 targetNo varchar2, --目标deviceNo
 ReturnCode OUT varchar2
)
AS
BEGIN
 if orgId != targetId or deviceNo != targetNo then
 --删除目标数据再插入
 delete from BSC_WIN_CONFIG b where b.org_id = targetId and b.device_no = targetNo;

   --插入
   insert into BSC_WIN_CONFIG (
      ORG_ID,
      DEVICE_NO,
      WIN_NO,
      win_id,
      IS_CALL,
      IS_JUDGE,
      WIN_SCREEN,
      MULTIPLE_SCREEN,
      IS_START,
      row_id,
      EXTEND1,
      EXTEND2,
      EXTEND3
   ) select
     targetId,
     targetNo,
      WIN_NO,
      WIN_ID,
      IS_CALL,
      IS_JUDGE,
      WIN_SCREEN,
      MULTIPLE_SCREEN,
      IS_START,
      row_id,
      EXTEND1,
      EXTEND2,
      EXTEND3
    from BSC_WIN_CONFIG w where w.org_id = orgId and w.device_no=deviceNo;
    proc_deviceupdateflag(deviceNo,'0');
   ReturnCode:='0';
end if;
 --异常处理
 -- exception
   --   when others then
     --  ReturnCode:='1'; --数据库异常
END proc_bscwinconfig_copy;
/

prompt
prompt Creating procedure PROC_BSCWINCONFIG_EDIT
prompt =========================================
prompt
CREATE OR REPLACE PROCEDURE iqms_new.proc_bscwinconfig_edit
(
 orgId varchar2,
 deviceNo varchar2,
 winNo varchar2,
 isCall varchar2,
 isJudge varchar2,
 winScreen varchar2,
 multipleScreen varchar2,
 isStart varchar2,
 extend1 varchar2,
 extend2 varchar2,
 extend3 varchar2,
 ReturnCode OUT varchar2
)
AS

BEGIN

   update BSC_WIN_CONFIG t set
      t.ORG_ID = orgId,
      t.DEVICE_NO =deviceNo,
      t.WIN_NO =winNo,
      t.IS_CALL =isCall,
      t.IS_JUDGE =isJudge,
      t.WIN_SCREEN =winScreen,
      t.MULTIPLE_SCREEN =multipleScreen,
      t.IS_START =isStart,
      t.EXTEND1 =extend1,
      t.EXTEND2 =extend2,
      t.EXTEND3 =extend3
      where t.org_id = orgId
      and t.device_no = deviceNo
      and t.win_no = winNo;
       proc_deviceupdateflag(deviceNo,'0');

   ReturnCode:='0';
 --异常处理
 -- exception
   --   when others then
     --  ReturnCode:='1'; --数据库异常
END proc_bscwinconfig_edit;
/

prompt
prompt Creating procedure PROC_BSCWINCONFIG_PAGE
prompt =========================================
prompt
create or replace procedure iqms_new.proc_bscwinconfig_page(orgId      varchar2, --机构id
                                                   deviceNo   varchar2,
                                                   orderfield in varchar2,
                                                   ordertype  in varchar2,
                                                   pagesize   in number,
                                                   pageno     in number,
                                                   totalrows  out number,
                                                   p_cursor   out sys_refcursor) as
  v_sql           varchar2(4000);
  v_sql_page      varchar2(4000);
  v_sql_condition varchar2(4000);
  v_sql_count     varchar2(4000);
  v_begin         number := (pageno - 1) * pagesize + 1;
  v_end           number := pageno * pagesize;
  v_sort          varchar2(50);
  v_orgId         varchar2(50) := orgId;
  v_deviceNo      varchar2(50) := deviceNo;

begin
  ---------------------------------------------------------1.按条件查询数据 start------------------------------------------------------------------

  v_sql_condition := ' select h.ORG_ID,h.rowId rid,h.DEVICE_NO,h.WIN_NO,h.IS_CALL,h.IS_JUDGE,h.WIN_SCREEN,
  h.MULTIPLE_SCREEN,h.IS_START,h.EXTEND1,h.EXTEND2,h.EXTEND3,s.org_code,s.org_name from bsc_win_config h,sys_org s
   where h.org_id=s.org_id ';

  if v_orgId != 0 then
    v_sql_condition := v_sql_condition ||
                       ' and h.org_id =:orgId and h.device_no =:deviceNo';
  else
    v_orgId         := 0;
    v_sql_condition := v_sql_condition ||
                       ' and ( h.org_id  is null or h.org_id <>:orgId)';

  end if;

  -------------------------------------------------2.包裹按条件查询的语句，进行分页 开始------------------------------------------------------------
  if (orderfield is null) then
    v_sort := 'org_id ';
  else
    v_sort := orderfield || ' ' || ordertype;
  end if;

  --select result
  v_sql := 'select row_number() over ( order by ' || v_sort || ',rid) rnum,tt.ORG_ID,tt.DEVICE_NO,tt.WIN_NO,tt.IS_CALL,tt.IS_JUDGE,tt.WIN_SCREEN,
  tt.MULTIPLE_SCREEN,tt.IS_START,tt.EXTEND1,tt.EXTEND2,tt.EXTEND3,tt.org_code,tt.org_name
  from (' || v_sql_condition || ') tt ';

  --select count
  v_sql_count := 'select count(1) from (' || v_sql || ')';

  ------------------------------------------------------------3.判断是分页还是查询列表

  if pageno > 0 then
    v_sql_page := 'select * from (' || v_sql ||
                  ') temp where temp.rnum >= :v_begin and temp.rnum <= :v_end';
    execute immediate v_sql_count
      into totalrows
      using v_orgId, v_deviceNo;
    OPEN p_cursor FOR v_sql_page
      using v_orgId, v_deviceNo, v_begin, v_end;
  else
    totalrows  := 0; --set default value
    v_sql_page := 'select * from (' || v_sql || ') temp ';
    OPEN p_cursor FOR v_sql_page
      using v_orgId, v_deviceNo;
  end if;

end proc_bscwinconfig_page;
/

prompt
prompt Creating procedure PROC_BSCWINCONFIG_QUERY
prompt ==========================================
prompt
create or replace procedure iqms_new.proc_bscwinconfig_query (
orgId varchar2, --机构id
deviceNo varchar2,
p_cursor out sys_refcursor)
as
   v_sql varchar2(4000);

begin
---------------------------------------------------------1.按条件查询数据 start------------------------------------------------------------------

  v_sql:= ' select h.*,s.org_name from bsc_win_config h,sys_org s
   where h.org_id =:org_id and h.device_no =:deviceNo and h.org_id = s.org_id order by h.win_no asc';

OPEN p_cursor FOR v_sql using orgId,deviceNo;


end proc_bscwinconfig_query;
/

prompt
prompt Creating procedure PROC_BSCWINCONFIG_REMOVE
prompt ===========================================
prompt
CREATE OR REPLACE PROCEDURE iqms_new.proc_bscwinconfig_remove
(
 orgId varchar2,
 deviceNo varchar2,
 winNo varchar2,
 ReturnCode OUT varchar2
)
AS

BEGIN
 delete from  BSC_WIN_CONFIG t  where t.org_id = orgId and t.device_no = deviceNo;
 --级联删除 bsc_counterbuz
 delete from  bsc_counterbuz t where t.device_no = deviceNo and t.counterid = winNo;
  --更新设备状态
  --update bsc_device b set b.extend1 = '1' where b.org_id = orgId and b.device_no = deviceNo;
 proc_deviceupdateflag(deviceNo,'0');
 ReturnCode:='0';
END proc_bscwinconfig_remove;
/

prompt
prompt Creating procedure PROC_BUZTIMES_QUERY
prompt ======================================
prompt
create or replace procedure iqms_new.proc_buztimes_query (
orgId varchar2,
deviceNo varchar2,
p_cursor out sys_refcursor)
as
   v_sql varchar2(4000);


begin


 --查询bsc_branch_business 生成buzType.json
 v_sql := 'select b.org_id,b.device_no,b.business_id,
 (case when b.date_type = ''N'' then 1 else 2 end) date_type,
b.begin_time,b.end_time,b.max_num
 from bsc_show_time b
 where  b.org_id =:orgId and b.device_no =:deviceNo';
 OPEN p_cursor FOR v_sql using orgId,deviceNo;




end proc_buztimes_query;
/

prompt
prompt Creating procedure PROC_BUZTYPE_QUERY
prompt =====================================
prompt
create or replace procedure iqms_new.proc_buztype_query (
orgId varchar2,
deviceNo varchar2,
p_cursor out sys_refcursor)
as
   v_sql varchar2(4000);


begin


 --查询bsc_branch_business 生成buzType.json
 v_sql := 'select b.org_id,b.device_no,b.business_type,
b.bus_id,
tree_pid,
 b.business_code,
b.prior_time,b.max_pick_up,b.call_head,
decode(b.business_type,''1'',(select bm.business_name from BC_BUSINESSMANAGE bm where b.bus_id= bm.business_id),
 ''0'',(select m.menu_name from bc_menu m where b.bus_id=m.menu_id) ) branchName,
decode(b.business_type,''1'',(select bm.business_ename from BC_BUSINESSMANAGE bm where b.bus_id= bm.business_id),
 ''0'',(select m.menu_enname from bc_menu m where b.bus_id=m.menu_id) ) en_name,
 decode(b.business_type,''1'',''1'',
 ''0'',(select m.extend1 from bc_menu m where b.bus_id=m.menu_id) ) isShowed,
b.is_show_en,b.is_swipe,b.pick_up_advice,b.sort_num,b.levelnum

 from bsc_branch_business b
 where  b.org_id =:orgId and b.device_no =:deviceNo';
 OPEN p_cursor FOR v_sql using orgId,deviceNo;




end proc_buztype_query;
/

prompt
prompt Creating procedure PROC_BUZTYPE_SELECT
prompt ======================================
prompt
create or replace procedure iqms_new.proc_buztype_select
(
orgId varchar2,
deviceNo varchar2,
p_cursor out sys_refcursor
)
as
   v_sql varchar2(4000);
   v_orgid varchar2(50) := orgId;
   v_deviceNo varchar2(50) := deviceNo;
begin

   if orgId is null or deviceNo is null then
       v_sql := 'select b.business_name,a.bus_id from BSC_BRANCH_BUSINESS a
	           inner join bc_businessmanage b on(a.bus_id=b.business_id) where a.business_type=''1''';
       OPEN p_cursor FOR v_sql;
   else
       v_sql := 'select b.business_name,a.bus_id from BSC_BRANCH_BUSINESS a
	           inner join bc_businessmanage b on(a.bus_id=b.business_id) where a.business_type=''1''
             and a.org_id =:orgId and a.device_no =:deviceNo ';
       OPEN p_cursor FOR v_sql using v_orgid,v_deviceNo;
   end if;

end proc_buztype_select;
/

prompt
prompt Creating procedure PROC_CALLSTRATEGY_COPY
prompt =========================================
prompt
CREATE OR REPLACE PROCEDURE iqms_new.proc_callstrategy_copy--应用到下级机构
(
 orgId varchar2,
 deviceNo varchar2,
 targetId varchar2,--目标orgId
 targetNo varchar2, --目标deviceNo
 ReturnCode OUT varchar2
)
AS
BEGIN

if orgId != targetId or deviceNo != targetNo then
 --删除目标数据再插入
 delete from bsc_counterbuz b where b.org_id = targetId and b.device_no = targetNo;

   --插入
   insert into bsc_counterbuz (
      ORG_ID,
      DEVICE_NO,
      counterid,
      datetypeid，
      buztypeid,
      levelid,
      buzprioritytime,
      custprioritytime,
      maxwaiting

   ) select
     targetId,
     targetNo,
     counterid,
      datetypeid，
      buztypeid,
      levelid,
      buzprioritytime,
      custprioritytime,
      maxwaiting
    from bsc_counterbuz w where w.org_id = orgId and w.device_no=deviceNo;
    proc_deviceupdateflag(deviceNo,'0');
   ReturnCode:='0';
end if;
 --异常处理
 -- exception
   --   when others then
     --  ReturnCode:='1'; --数据库异常
END proc_callstrategy_copy;
/

prompt
prompt Creating procedure PROC_CLEARTRXTODAY
prompt =====================================
prompt
create or replace procedure iqms_new.proc_cleartrxtoday
 as
    --(删除掉当天除了弃号和完成的数据,或者删除掉当天办理完成但是开始办理时间和结束办理时间相同的记录)
    cursor delerrdata_cur is select * from trx_today t where (t.trx_status <> '2'  and  t.trx_status <> '3')
    or (t.trx_status = '2' and t.begin_time = t.end_time);
 begin
      --遍历游标删除异常数据
      for cur_type in delerrdata_cur
        loop
          delete from trx_history h where h.org_id=cur_type.org_id and h.device_no=cur_type.device_no
          and h.trx_date=cur_type.trx_date and h.flow_no = cur_type.flow_no;
          commit;
        end loop;
      DBMS_Utility.Exec_DDL_Statement('truncate table trx_today');
 end proc_cleartrxtoday;
/

prompt
prompt Creating procedure PROC_CONFIGCONFIRM
prompt =====================================
prompt
CREATE OR REPLACE PROCEDURE iqms_new.proc_configConfirm
(
 deviceId varchar2,
 ReturnCode OUT varchar2  -- 1-失败，记录不存在     0-成功
)
AS
iRecCount INTEGER;
BEGIN

 --查询柜员是否存在versionSeq
 select count(1) into iRecCount from bsc_device t where t.device_no = deviceId;

 if iRecCount > 0 then -- 更新下载日期
    update bsc_device t set t.extend1 = '0' where t.device_no = deviceId;
     ReturnCode:='0';
 else
   ReturnCode:='1';
 end if;
 --异常处理
 -- exception
   --   when others then
     --  ReturnCode:='1'; --数据库异常
END proc_configConfirm;
/

prompt
prompt Creating procedure PROC_COUNTERBUZBYWINID_SELECT
prompt ================================================
prompt
create or replace procedure iqms_new.proc_counterbuzbywinid_select
(
orgId varchar2,
deviceNo varchar2,
winId varchar2,
p_cursor out sys_refcursor
)
as
   v_sql varchar2(4000);
   v_orgid varchar2(50) := orgId;
   v_deviceNo varchar2(50) := deviceNo;
   v_winId varchar2(50) := winId;
begin

   if orgId is null or deviceNo is null then
       v_sql := 'select * from BSC_CounterBuz b where b.counterid =:v_winId ';
       OPEN p_cursor FOR v_sql using v_winId;
   else
       v_sql := 'select * from BSC_CounterBuz b where b.counterid =:v_winId
       and b.org_id =:v_orgid and b.device_no =:v_deviceNo';
       OPEN p_cursor FOR v_sql using v_winId,v_orgid,v_deviceNo;
   end if;

end proc_counterbuzbywinid_select;
/

prompt
prompt Creating procedure PROC_COUNTERBUZS_ADD
prompt =======================================
prompt
create or replace procedure iqms_new.proc_counterbuzs_add
(
v_orgId varchar2,
v_deviceNo varchar2,
v_counterId varchar2,
v_dateTypeId varchar2,
v_busId varchar2,
v_custLevel varchar2,
v_buzPriorityTime varchar2,
v_custPriorityTime varchar2,
v_maxWaitTime varchar2,
ReturnCode out varchar2
)
is
iRecCount INTEGER;
v_count INTEGER;
begin

   if v_orgId is null or v_deviceNo is null then
      --查询要增加的记录是否存在
     select count(1) into iRecCount from BSC_CounterBuz t where t.counterid = v_counterId ;
     if iRecCount >0 then
        select count(1) into v_count from BSC_CounterBuz t where t.counterid = v_counterId and t.datetypeid = v_dateTypeId
        and t.buztypeid = v_busId and t.levelid = v_custLevel;

        if v_count>0 then
          delete from BSC_CounterBuz b where b.counterid = v_counterId and b.datetypeid=v_dateTypeId and b.buztypeid=v_busId
          and b.levelid=v_custLevel;

          insert into BSC_CounterBuz b
          (b.counterId,
           b.dateTypeId,
           b.buzTypeId,
           b.levelId,
           b.buzPriorityTime,
           b.custPriorityTime,
           b.maxWaiting，
           b.org_id,
           b.device_no
          )values
          (v_counterId,
           v_dateTypeId,
           v_busId,
           v_custLevel,
           v_buzPriorityTime,
           v_custPriorityTime,
           v_maxWaitTime,
           v_orgId,
           v_deviceNo
          );
          ReturnCode:='0';
          proc_deviceupdateflag(v_deviceNo,'0');
        else
          insert into BSC_CounterBuz b
          (b.counterId,
           b.dateTypeId,
           b.buzTypeId,
           b.levelId,
           b.buzPriorityTime,
           b.custPriorityTime,
           b.maxWaiting,
           b.org_id,
           b.device_no
          )values
          (v_counterId,
           v_dateTypeId,
           v_busId,
           v_custLevel,
           v_buzPriorityTime,
           v_custPriorityTime,
           v_maxWaitTime,
           v_orgId,
           v_deviceNo
          );
          ReturnCode:='0';
          proc_deviceupdateflag(v_deviceNo,'0');
       end if;
     else
        insert into BSC_CounterBuz b
          (b.counterId,
           b.dateTypeId,
           b.buzTypeId,
           b.levelId,
           b.buzPriorityTime,
           b.custPriorityTime,
           b.maxWaiting,
           b.org_id,
           b.device_no
          )values
          (v_counterId,
           v_dateTypeId,
           v_busId,
           v_custLevel,
           v_buzPriorityTime,
           v_custPriorityTime,
           v_maxWaitTime,
           v_orgId,
           v_deviceNo
          );
        ReturnCode:='0';
        proc_deviceupdateflag(v_deviceNo,'0');
    end if;
   else
      --查询要增加的记录是否存在
     select count(1) into iRecCount from BSC_CounterBuz t where t.counterid = v_counterId
     and t.org_id = v_orgId and t.device_no = v_deviceNo;

     if iRecCount >0 then
        select count(1) into v_count from BSC_CounterBuz t where t.counterid = v_counterId and t.datetypeid = v_dateTypeId
        and t.buztypeid = v_busId and t.levelid = v_custLevel and t.org_id = v_orgId and t.device_no = v_deviceNo;

        if v_count>0 then
          delete from BSC_CounterBuz b where b.counterid = v_counterId and b.datetypeid=v_dateTypeId and b.buztypeid=v_busId
          and b.levelid=v_custLevel  and b.org_id = v_orgId and b.device_no = v_deviceNo;

          insert into BSC_CounterBuz b
          (b.counterId,
           b.dateTypeId,
           b.buzTypeId,
           b.levelId,
           b.buzPriorityTime,
           b.custPriorityTime,
           b.maxWaiting，
           b.org_id,
           b.device_no
          )values
          (v_counterId,
           v_dateTypeId,
           v_busId,
           v_custLevel,
           v_buzPriorityTime,
           v_custPriorityTime,
           v_maxWaitTime,
           v_orgId,
           v_deviceNo
          );
          ReturnCode:='0';
          proc_deviceupdateflag(v_deviceNo,'0');
        else
          insert into BSC_CounterBuz b
          (b.counterId,
           b.dateTypeId,
           b.buzTypeId,
           b.levelId,
           b.buzPriorityTime,
           b.custPriorityTime,
           b.maxWaiting,
           b.org_id,
           b.device_no
          )values
          (v_counterId,
           v_dateTypeId,
           v_busId,
           v_custLevel,
           v_buzPriorityTime,
           v_custPriorityTime,
           v_maxWaitTime,
           v_orgId,
           v_deviceNo
          );
          ReturnCode:='0';
          proc_deviceupdateflag(v_deviceNo,'0');
       end if;
     else
        insert into BSC_CounterBuz b
          (b.counterId,
           b.dateTypeId,
           b.buzTypeId,
           b.levelId,
           b.buzPriorityTime,
           b.custPriorityTime,
           b.maxWaiting,
           b.org_id,
           b.device_no
          )values
          (v_counterId,
           v_dateTypeId,
           v_busId,
           v_custLevel,
           v_buzPriorityTime,
           v_custPriorityTime,
           v_maxWaitTime,
           v_orgId,
           v_deviceNo
          );
        ReturnCode:='0';
        proc_deviceupdateflag(v_deviceNo,'0');
    end if;

   end if;


        --异常处理
        -- exception
         --   when others then
          --  ReturnCode:='1'; --数据库异常

end proc_counterbuzs_add;
/

prompt
prompt Creating procedure PROC_COUNTERBUZS_QUERY
prompt =========================================
prompt
create or replace procedure iqms_new.proc_counterBuzs_query (
orgId varchar2,
deviceNo varchar2,
counterId varchar2,
p_cursor out sys_refcursor)
as
   v_sql varchar2(4000);


begin


 --查询bsc_win_config 生成counters.json
 v_sql := 'select b.buzprioritytime,b.custprioritytime,b.maxwaiting,
b.levelid,bus.business_name cnName,c.cust_name levelName,
bsc.business_code buzCode,b.buztypeid,''T'' saveDjStatus,b.counterid,
b.datetypeid
from bsc_counterbuz b,bsc_branch_business bsc,bc_custtype c,
bc_businessmanage bus
 where b.buztypeid = bsc.bus_id and bsc.business_type=''BUS''
 and c.cust_level = b.levelid and bus.business_id = b.buztypeid
 and  b.org_id =:orgId and b.device_no =:deviceNo and b.counterid =:counterId ';
 OPEN p_cursor FOR v_sql using orgId,deviceNo,counterId;




end proc_counterBuzs_query;
/

prompt
prompt Creating procedure PROC_COUNTERBUZ_DELETE
prompt =========================================
prompt
create or replace procedure iqms_new.proc_counterbuz_delete
(
orgId varchar2,
deviceNo varchar2,
winId varchar2,
ReturnCode out varchar2
)
as
   v_sql varchar2(4000);

begin

   if orgId is null or deviceNo is null then
       delete from BSC_CounterBuz b where b.counterId = winId;
       ReturnCode:='0';
   else
       delete from BSC_CounterBuz b where b.counterId = winId
       and b.org_id = orgId and b.device_no = deviceNo;
       ReturnCode:='0';
   end if;
   proc_deviceupdateflag(deviceNo,'0');

end proc_counterbuz_delete;
/

prompt
prompt Creating procedure PROC_COUNTERBUZ_SELECT
prompt =========================================
prompt
create or replace procedure iqms_new.proc_counterbuz_select
(
orgId varchar2,
deviceNo varchar2,
p_cursor out sys_refcursor
)
as
   v_sql varchar2(4000);
   v_orgid varchar2(50) := orgId;
   v_deviceNo varchar2(50) := deviceNo;
   v_orgid2 varchar2(50) := orgId;
   v_deviceNo2 varchar2(50) := deviceNo;
begin

   if orgId is null or deviceNo is null then
       v_sql := 'select m.bus_id,m.business_code,m.business_name,m.prior_time buzPriorityTime,n.cust_level,n.level_name,n.prior_time custPriorityTime,n.max_wait_time from
          (select a.business_code,b.business_name,a.prior_time,a.bus_id from BSC_BRANCH_BUSINESS a inner join bc_businessmanage b on(a.bus_id=b.business_id) where a.business_type=''1''
          ) m,
          (select a.cust_level,a.prior_time,a.max_wait_time,a.level_name from BSC_CUST_LEVEL a
          where a.is_start=1) n
          order by m.business_name,n.cust_level';
       OPEN p_cursor FOR v_sql;
   else
       v_sql := 'select m.bus_id,m.business_code,m.business_name,m.prior_time buzPriorityTime,n.cust_level,n.level_name,n.prior_time custPriorityTime,n.max_wait_time from
          (select a.business_code,b.business_name,a.prior_time,a.bus_id from BSC_BRANCH_BUSINESS a inner join bc_businessmanage b on(a.bus_id=b.business_id) where a.business_type=''1''
          and  a.org_id =:v_orgid and a.device_no =:v_deviceNo) m,
          (select a.cust_level,a.prior_time,a.max_wait_time,a.level_name from BSC_CUST_LEVEL a
          where a.is_start=1 and a.org_id =:v_orgid2 and a.device_no =:v_deviceNo2) n
          order by m.business_name,n.cust_level';
       OPEN p_cursor FOR v_sql using v_orgid,v_deviceNo,v_orgid2,v_deviceNo2;
   end if;

end proc_counterbuz_select;
/

prompt
prompt Creating procedure PROC_COUNTERID_QUERY
prompt =======================================
prompt
create or replace procedure iqms_new.proc_counterId_query (
orgId varchar2,
deviceNo varchar2,
p_cursor out sys_refcursor)
as
   v_sql varchar2(4000);


begin


 --查询bsc_win_config 生成counters.json
 v_sql := 'select distinct(b.counterid) from bsc_counterbuz b
 where  b.org_id =:orgId and b.device_no =:deviceNo';
 OPEN p_cursor FOR v_sql using orgId,deviceNo;




end proc_counterId_query;
/

prompt
prompt Creating procedure PROC_COUNTERID_SELECT
prompt ========================================
prompt
create or replace procedure iqms_new.proc_counterid_select
(
orgId varchar2,
deviceNo varchar2,
p_cursor out sys_refcursor
)
as
 v_sql varchar2(4000);
 v_orgid varchar2(50) := orgId;
 v_deviceNo varchar2(50) := deviceNo;

begin

 v_sql := 'select distinct(b.counterid) from bsc_counterbuz b
           where  b.org_id =:v_orgid and b.device_no =:v_deviceNo';

 OPEN p_cursor FOR v_sql using v_orgid,v_deviceNo;


end proc_counterid_select;
/

prompt
prompt Creating procedure PROC_COUNTERS_QUERY
prompt ======================================
prompt
create or replace procedure iqms_new.proc_counters_query (
orgId varchar2,
deviceNo varchar2,
p_cursor out sys_refcursor)
as
   v_sql varchar2(4000);


begin


 --查询bsc_win_config 生成counters.json
 v_sql := 'select b.win_no counterId,
''inserted''  saveStatus,
b.win_no counterNo,
b.is_start enabled,
b.win_screen caller,
b.win_screen evaluator,
b.win_screen barscn,
b.multiple_screen cmpscn
from bsc_win_config b
 where  b.org_id =:orgId and b.device_no =:deviceNo';
 OPEN p_cursor FOR v_sql using orgId,deviceNo;




end proc_counters_query;
/

prompt
prompt Creating procedure PROC_CUSTLEVELS_QUERY
prompt ========================================
prompt
create or replace procedure iqms_new.proc_custlevels_query (
orgId varchar2,
deviceNo varchar2,
p_cursor out sys_refcursor)
as
   v_sql varchar2(4000);


begin


 --bsc_cust_level 生成custLevels.json
 v_sql := 'select bsc.cust_level, bsc.level_name, bsc.business_id,
bsc.prior_time, bsc.call_head, bsc.max_wait_time, bsc.ticket_template,
bsc.is_start
from bsc_cust_level bsc
where bsc.org_id =:orgId and bsc.device_no =:deviceNo ';
 OPEN p_cursor FOR v_sql using orgId,deviceNo;




end proc_custlevels_query;
/

prompt
prompt Creating procedure PROC_CUSTRECS_QUERY
prompt ======================================
prompt
create or replace procedure iqms_new.proc_custrecs_query (
orgId varchar2,
deviceNo varchar2,
p_cursor out sys_refcursor)
as
   v_sql varchar2(4000);


begin


 --bsc_cust_level 生成custLevels.json
 v_sql := 'select bsc.date_type, bsc.start_position,
bsc.MATE_LENGTH, bsc.start_mate_code,
bsc.end_mate_code, bsc.cust_level, ''inserted'' saveStatus
from bsc_cust_recognition bsc
where bsc.org_id =:orgId and bsc.device_no =:deviceNo ';
 OPEN p_cursor FOR v_sql using orgId,deviceNo;




end proc_custrecs_query;
/

prompt
prompt Creating procedure PROC_DEVICE_SELECT
prompt =====================================
prompt
create or replace procedure iqms_new.proc_device_select
(
orgId varchar2,
deviceNo varchar2,
p_cursor out sys_refcursor
)
is
 v_sql varchar2(4000);
 v_orgid varchar2(50) := orgId;
 v_deviceNo varchar2(50) := deviceNo;

begin

            v_sql := ' select b.buzprioritytime,b.custprioritytime,b.maxwaiting,b.levelid,bus.business_name cnName,
                     cus.level_name levelName,bsc.business_code buzCode,b.buztypeid,''true'' saveDjStatus,b.counterid,b.datetypeid
                     from BSC_CounterBuz b
                     inner join bc_businessmanage bus on(b.buztypeid=bus.business_id)
                     inner join bsc_cust_level cus on(b.levelid=cus.cust_level and cus.device_no =:v_deviceNo)
                     inner join BSC_BRANCH_BUSINESS bsc on(b.buztypeid=bsc.bus_id and bsc.device_no =:v_deviceNo)
                     where b.org_id =:v_orgid and b.device_no =:v_deviceNo';

          open p_cursor FOR v_sql using v_deviceNo,v_deviceNo,v_orgid,v_deviceNo;

end proc_device_select;
/

prompt
prompt Creating procedure PROC_DIC_QUERY
prompt =================================
prompt
create or replace procedure iqms_new.proc_dic_query (
dicType varchar2, --类型名称
p_cursor out sys_refcursor)
as
   v_sql varchar2(4000);
   v_dicType varchar2(50) := dicType;

begin
---------------------------------------------------------1.按条件查询数据 start------------------------------------------------------------------
 v_sql := 'select dic_key,dic_value from SYS_DIC dic where 1=1 ';
 v_sql := v_sql || ' and dic.dic_type =:dicType';
 OPEN p_cursor FOR v_sql using  v_dicType;

end proc_dic_query;
/

prompt
prompt Creating procedure PROC_EXISTACTNO
prompt ==================================
prompt
CREATE OR REPLACE PROCEDURE iqms_new.proc_existActNo
(
 orgCode IN varchar2,  -- 机构编码
 actNo IN varchar2,    -- 激活码
 orderDt in varchar2, -- 预预约日期  2017-10-21
 ReturnCode out varchar2  -- 返回结果  1-可用   0-不可用

)
AS
  recordExists INTEGER DEFAULT 0;

BEGIN
  ReturnCode := 1; -- 可以预约
  -- 查询激活码是否可用，此机构预约日期激活码不重复
 SELECT COUNT(1)  INTO recordExists FROM order_info i  WHERE i.org_code = orgCode
                                                               --and r.dev_no = devNo
                                                               and i.act_no = actNo
                                                               and order_date = orderDt;

  if recordExists > 0 then
     ReturnCode := 0; -- 不可用
     return;
  end if;

END proc_existActNo;
/

prompt
prompt Creating procedure PROC_EXISTBOOKRECORD
prompt =======================================
prompt
CREATE OR REPLACE PROCEDURE iqms_new.PROC_EXISTBOOKRECORD
(
 orgCode IN varchar2,  -- 机构编码
 devNo IN varchar2,    -- 设备号
 certType in varchar2, -- 证件类型
 certContent in varchar2, -- 证件号
 orderTime  in varchar2, -- 预约时间点（废弃不使用）
 orderDt in varchar2, -- 预预约日期  2017-10-21
 beginTime in varchar2, --开始时间段
 endTime in varchar2,-- 结束时间段
 ReturnCode out varchar2  -- 返回结果  0-可以预约   1-预约已经存在

)
AS
  recordExists INTEGER DEFAULT 0;
  orderCount INTEGER DEFAULT 0;
  canOrderCount varchar2(50);
  rangeExists INTEGER DEFAULT 0;  -- 预约时间点所在时间段是否存在
  rangeTotalCount  INTEGER DEFAULT 0; -- 时间段可预约的总数量
BEGIN
  ReturnCode := 0; -- 可以预约
  -- 查询此人是否已经预约过了(当天这个营业厅，这个验证类型，且不是取消的)
  SELECT COUNT(1)  INTO recordExists FROM order_info i  WHERE i.org_code = orgCode
                                                               --and r.dev_no = devNo
                                                               and i.cert_type = certType
                                                               and i.cert_content = certContent
                                                               and i.order_status <> '2'  --
                                                               and order_date = orderDt;



  if recordExists > 0 then
     ReturnCode := 1; -- 该客户今天已经预约过了
     return;
  end if;


  -- 查询预约时间段是否存在
  select count(1) into rangeExists from order_range r where r.device_no = devNo  --预约网点
                                           and  r.begin_time =  beginTime
                                           and  r.end_time =  endTime;

   if rangeExists = 1 then  -- 查询预约时间段的放号数量

      select r.ordercount into rangeTotalCount from order_range r where r.device_no = devNo  --预约网点
                                           and  r.begin_time =  beginTime
                                           and  r.end_time =  endTime;
   else
     ReturnCode := 2; -- 预约的时间段，没有对应的时间段
     return;
   end if;


  -- 查询该网点的此时间段预约情况(一个网点，同一日期，同一时间段，有效的预约数量)
select count(1) into orderCount from order_info i  WHERE i.dev_no = devNo
                                                           and i.range_begin = beginTime
                                                           and i.range_end = endTime
                                                           and i.order_status <> '2'  --
                                                           and i.order_date = orderDt;

  -- 判断是否有多余的预约数量
  if rangeTotalCount <= orderCount then
     ReturnCode := 3; -- 预约时间段，已经被预约完了
     return;
  end if ;
   ReturnCode := 0;

END PROC_EXISTBOOKRECORD;
/

prompt
prompt Creating procedure PROC_EXTFLOWDATAPAD
prompt ======================================
prompt
create or replace procedure iqms_new.proc_extflowdatapad (
orgCode varchar2, --机构编码
showCount in varchar2,
p_cursor out sys_refcursor)
as
   v_sql varchar2(4000);
   v_sql_condition varchar2(2000);
begin
---------------------------------------------------------1.按条件查询数据 start------------------------------------------------------------------

  v_sql_condition := 'select
    h.org_id,
    h.device_no,
    to_char(h.trx_date,''yyyy-MM-dd'') trx_date,
    h.flow_no,
    h.bus_id,
    h.bus_type,
    h.cust_type,
    h.pdj_level,
    h.ticket_type,
    h.ticket_no,
    h.cust_id,
    h.card_type,
    h.card_no,
    h.manager_no,
    h.trx_type,
    h.trx_status,
    (select count(1) from trx_today t where t.bus_id=h.bus_id and t.org_id=s.org_id and t.pdj_level = h.pdj_level and t.trx_date = h.trx_date and t.trx_status=1 and t.print_time < h.print_time) wait_num,
    to_char(h.print_time,''yyyy-MM-dd hh24:mi:ss'') print_time,
    to_char(h.call_time,''yyyy-MM-dd hh24:mi:ss'') call_time,
    to_char(h.begin_time,''yyyy-MM-dd hh24:mi:ss'') begin_time,
    to_char(h.end_time,''yyyy-MM-dd hh24:mi:ss'') end_time,
    h.app_value,
    h.win_no,
    h.teller_no,
    h.recall_count,
    h.pause_begintime,
    h.pause_endtime,
    h.call_type,
    h.transfer_count,
    h.buz_flag,
    h.extend1,
    h.extend2,
    h.extend3,
    s.org_code,
    s.org_name,
    b.business_name,
    c.cust_name from trx_today h left join sys_org s on (h.org_id=s.org_id)
                                 left join BC_BUSINESSMANAGE b on (h.bus_id=b.BUSINESS_ID)
                                 left join bc_custtype c  on  (h.CUST_TYPE = c.CUST_LEVEL)
 where s.org_code=:org_code and h.TRX_STATUS = 1 and to_char(h.trx_date,''yyyy-MM-dd'')=to_char(sysdate,''yyyy-MM-dd'') order  by h.print_time desc';
 -- 获取行号
 v_sql := 'select rownum rnum, temp.* from ('||v_sql_condition||') temp ';

  v_sql := 'select * from ('||v_sql||') f where f.rnum <= :showCount ';

 OPEN p_cursor FOR v_sql using orgCode,showCount;

end proc_extflowdatapad;
/

prompt
prompt Creating procedure PROC_EXTFLOWDATA_SAVE
prompt ========================================
prompt
CREATE OR REPLACE PROCEDURE iqms_new.proc_extflowdata_save
(
 orgId varchar2,     -- 1001
 deviceNo varchar2 ,  --A0:1D:48:B1:C0:8F
 trxDate varchar2,    -- yyyy-MM-dd需要转换
 flowNo varchar2 ,
 busId varchar2,
  busType varchar2,
 custType varchar2 ,
  pdjLevel number,
 ticketType varchar2 ,
  ticketNo varchar2,
 custId varchar2 ,
  cardType varchar2,
 cardNo varchar2 ,
 managerNo varchar2 ,
 trxType varchar2,
 trxStatus varchar2,
 printTime varchar2 , --要转时间
  callTime varchar2, --要转时间
 beginTime varchar2 ,--要转时间
  endTime varchar2, --要转时间
 appValue varchar2 ,
  winNo varchar2,
 tellerNo varchar2 ,
 recallCount varchar2,
 pauseBeginTime varchar2,
 pauseEndTime varchar2,
 callType varchar2,
 transferCount varchar2,
 buzFlag varchar2,
 extend_1 varchar2 ,
 extend_2 varchar2 ,
 extend_3 varchar2 ,
 ReturnCode OUT varchar2
)
AS
iRecCount INTEGER;
BEGIN

 --查询要更新的记录是否存储
 select count(1) into iRecCount from TRX_TODAY t where t.org_id=orgId and t.DEVICE_NO=deviceNo and to_char(t.TRX_DATE,'yyyyMMdd')=trxDate and t.FLOW_NO=flowNo;
--修改该窗口下其他为 正在办理状态的 流水 为已完成
if trxStatus ='2' then
  update TRX_TODAY t set t.trx_status = '3' where t.win_no = winNo and 
  t.device_no = deviceNo and t.org_id=orgId and t.FLOW_NO != flowNo;
  commit;
end if;
 if iRecCount > 0 then
   --更新
   update TRX_TODAY t set t.bus_type=busType,t.bus_id = busId,t.cust_type=custType,t.pdj_level=pdjLevel,t.ticket_type=ticketType,
                          t.ticket_no=ticketNo,t.cust_id=custId,t.card_type=cardType,t.card_no=cardNo,t.manager_no=managerNo,t.trx_type = trxType,
                          t.trx_status=trxStatus,
                          t.print_time=case when printTime='' then null else to_date(printTime,'yyyy-MM-dd HH24:mi:ss') end,
                          t.call_time=case when callTime='' then null else to_date(callTime,'yyyy-MM-dd HH24:mi:ss') end,
                          t.begin_time=case when beginTime='' then null else to_date(beginTime,'yyyy-MM-dd HH24:mi:ss') end,
                          t.end_time=case when endTime='' then null else to_date(endTime,'yyyy-MM-dd HH24:mi:ss') end,
                          t.app_value=appValue,t.win_no=winNo,t.teller_no=tellerNo,t.recall_count=recallCount,t.pause_begintime=pauseBeginTime,t.pause_endtime=pauseEndTime,
                          t.call_type=callType,t.transfer_count=transferCount,t.buz_flag=buzFlag,t.extend1=extend_1,t.extend2=extend_2,t.extend3=extend_3
   where t.ORG_ID=orgId and t.DEVICE_NO=deviceNo and to_char(t.TRX_DATE,'yyyyMMdd')=trxDate and t.FLOW_NO=flowNo;
   commit;
   ReturnCode:='0';
 else
   --插入
   insert into TRX_TODAY t (ORG_ID,DEVICE_NO,TRX_DATE,FLOW_NO,bus_id,BUS_TYPE,
      cust_type,PDJ_LEVEL,TICKET_TYPE,TICKET_NO,CUST_ID,CARD_TYPE,
      CARD_NO,MANAGER_NO,trx_type,TRX_STATUS,PRINT_TIME, CALL_TIME, BEGIN_TIME,END_TIME,APP_VALUE, WIN_NO, TELLER_NO,recall_count,pause_begintime,
      pause_endtime,call_type,transfer_count,buz_flag,EXTEND1,EXTEND2,EXTEND3
   ) values (
     orgId,deviceNo,to_date(trxDate,'yyyyMMdd'), flowNo,busId,busType,
     custType,pdjLevel,ticketType,ticketNo,custId,cardType,
     cardNo,managerNo,trxType,trxStatus,
    case when printTime='' then null else to_date(printTime,'yyyy-MM-dd HH24:mi:ss') end,
    case when callTime='' then null else to_date(callTime,'yyyy-MM-dd HH24:mi:ss') end,
    case when beginTime='' then null else to_date(beginTime,'yyyy-MM-dd HH24:mi:ss') end,
    case when endTime='' then null else to_date(endTime,'yyyy-MM-dd HH24:mi:ss') end,
     appValue,winNo,tellerNo,recallCount,pauseBeginTime,pauseEndTime,callType,transferCount,buzFlag,
     extend_1,extend_2,extend_3
   );
   commit;
   ReturnCode:='0';
 end if;
 --异常处理
 -- exception
  --    when others then
  --     ReturnCode:='1';
END proc_extflowdata_save;
/

prompt
prompt Creating procedure PROC_EXTFLOWNEARNET
prompt ======================================
prompt
create or replace procedure iqms_new.proc_extflownearnet (
orgCode varchar2, --机构编码
p_cursor out sys_refcursor)
as
   v_sql varchar2(4000);
   v_sql_condition varchar2(2000);
   v_near1 number;
   v_near2 number;
   v_near3 number;
   v_near4 number;
   v_near5 number;
   v_near6 number;
   v_orgId number;
   v_sql_error varchar2(1000);
   v_hasFlag number;
begin
---------------------------------------------------------1.按条件查询数据 start------------------------------------------------------------------

 -- 没有数据的sql
 v_sql_error := 'select * from sys_org where  1=2';

 -- 1.查询机构是否存在
 select count(1) into v_hasFlag from sys_org o where o.org_code = orgCode;
 if v_hasFlag = 0 then   -- 执行错误的返回
   OPEN p_cursor FOR v_sql_error;
   return;
 end if;

 -- 将机构号查询出来
 select o.org_id into v_orgId from sys_org o where o.org_code = orgCode;

 -- 2.查询机构的临近网点配置
 select count(1) into v_hasFlag from bc_near n where n.org_id = v_orgId;

 if v_hasFlag = 0 then   -- 执行错误的返回
   OPEN p_cursor FOR v_sql_error;
   return;
 end if;


 -- 3.查询出所有的临近网点
 select n.org_id1,n.org_id2,n.org_id3,n.org_id4,n.org_id5,n.org_id6 into v_near1,v_near2,v_near3,v_near4,v_near5,v_near6  from bc_near n where n.org_id = v_orgId;


 --4.查询所有临近网点信息
 open p_cursor for select * from sys_org o where o.org_id in (v_near1,v_near2,v_near3,v_near4,v_near5,v_near6);

end proc_extflownearnet;
/

prompt
prompt Creating procedure PROC_EXTHEARTBEAT
prompt ====================================
prompt
CREATE OR REPLACE PROCEDURE iqms_new.proc_extheartbeat
(
 orgId varchar2,
 deviceNo varchar2 ,
 cpuRatio varchar2,
 memRatio varchar2 ,
 diskRatio varchar2,
 versionSeq varchar2,
 thermalPrinterStatus varchar2 ,
 needlePrinterStatus number,
 idReaderStatus varchar2 ,
 swReadStatus varchar2,
 icReaderStatus varchar2 ,
 barStatus varchar2,
 compStatus varchar2 ,
 configUpdaeFlag OUT varchar2,
 clientUpdateFlag OUT varchar2,
 clentiVerSeq OUT varchar2,
 clientVerName OUT varchar2,
 clientPatchMd5 OUT varchar2,
 hearBeatInterval OUT varchar2,
 authenticationType OUT varchar2,
 ReturnCode OUT varchar2
)
AS
iRecCount INTEGER;
devVerNo number; -- 设备当前版本号
devLastNo number; --设备最新版本号
patchId number; -- 返回需要升级的版本号
patchName number; --返回需要升级的版本的名称
patchMd5 varchar2(50); -- 版本的md5码
configFlag varchar2(1);  --配置更新flag
patchFlag varchar2(1); -- 版本更新flag

BEGIN

 --查询状态记录是否存在
 select count(1) into iRecCount from BSC_DEVICE_STATUS t where t.org_id  = orgId and t.DEVICE_NO=deviceNo;

 if iRecCount > 0 then

   update BSC_DEVICE_STATUS ds set ds.cpu_ratio = cpuRatio,ds.mem_ratio=memRatio,ds.disk_ratio=diskRatio,ds.version_seq=versionSeq,
                                   ds.update_date= sysdate,ds.thermalprinter_status = thermalPrinterStatus,
                                   ds.needleprinter_status = needlePrinterStatus, ds.idreader_status = idReaderStatus,
                                   ds.swread_status = swReadStatus, ds.icreader_status = icReaderStatus,
                                   ds.bar_status = barStatus,ds.comp_status = compStatus
   where ds.org_id = orgId and ds.device_no = deviceNo;
 else
   --插入
   insert into BSC_DEVICE_STATUS ds (ORG_ID,
          DEVICE_NO,
          CPU_RATIO,
          MEM_RATIO,
          DISK_RATIO,
          VERSION_SEQ,
          UPDATE_DATE,
          THERMALPRINTER_STATUS,
          NEEDLEPRINTER_STATUS,
          IDREADER_STATUS,
          SWREAD_STATUS,
          ICREADER_STATUS,
          BAR_STATUS,
          COMP_STATUS
   ) values (
       orgId,
       deviceNo,
       cpuRatio,
       memRatio,
       diskRatio,
       versionSeq,
       sysdate,
       thermalPrinterStatus,
       needlePrinterStatus,
       idReaderStatus,
       swReadStatus,
       icReaderStatus,
       barStatus,
       compStatus
   );
 end if;

 -- 更新设备的最后在线时间，及设备当前版本号
 update bsc_device d set d.online_time = sysdate,d.currt_ver=versionSeq where d.org_id= orgId and d.device_no=deviceNo;


 -- 查询设备信息
 begin
   select case when d.extend1 is null then '0' else d.extend1 end cFlag,  -- 配置是否有更新  1-有   0-无
          case when d.currt_ver is null then -1 else d.currt_ver end currVer,  -- 当前版本号
          case when d.last_ver is null then -1 else d.last_ver end lastVer --  最新版本号
    into configFlag,devVerNo,devLastNo  from bsc_device d where d.device_no = deviceNo;
 exception
      when others then
     -- 设备不存在
     configFlag:=0;
     devVerNo:=-1;
     devLastNo:=-1;
 end;

 -- 返回相关信息
 configUpdaeFlag := configFlag; --是否有配置更新
 --configUpdaeFlag := '0'; --是否有配置更新
 clientUpdateFlag := '0'; -- 是否有客户端更新
 clentiVerSeq := '';  --客户端版本号
 clientVerName := ''; -- 客户端版本名称
 clientPatchMd5 := ''; -- 版本的MD5码

 if devLastNo > devVerNo then
     clientUpdateFlag := '1'; -- 是否有客户端更新
     -- 查询和当前版本最接近需要升级的版本
     select tmp.patch_id,tmp.patch_name,tmp.patch_md5 into  clentiVerSeq,clientVerName,clientPatchMd5  from
     (
            select dup.patch_id,p.patch_name,p.patch_md5 from bsc_devupgrade_process dup inner join bc_patchversion p on (p.id = dup.patch_id)
                          where dup.patch_id >  to_number(versionSeq)
                          and dup.status = 0
                          and dup.device_no = deviceNo
                          order by dup.patch_id
      ) tmp where rownum <= 1;
 end if;

 -- 查询心跳间隔
 begin
    select to_char(case when p.hb_interval is null then 5 else p.hb_interval end),

           (case when p.authentication_type is null then '1' else p.authentication_type end)    into hearBeatInterval,authenticationType  from bc_parameter p;
 exception
      when others then
     hearBeatInterval:=5;
     authenticationType:='1';
 end;


 ReturnCode:='0';


 --异常处理
 -- exception
  --    when others then
  --     ReturnCode:='1';
END proc_extheartbeat;
/

prompt
prompt Creating procedure PROC_FINDBUSYS
prompt =================================
prompt
create or replace procedure iqms_new.proc_findBusys (
orgCode varchar2,
deviceNo varchar2,


p_cursor out sys_refcursor)
as
   v_sql varchar2(4000);
   v_orgId varchar2(50);

begin

select s.org_id into v_orgId from sys_org s where s.org_code = orgCode;

 v_sql := 'select b.org_id,b.device_no,
 b.bus_id,
 b.business_code,
 bm.business_name,
 bm.order_flag
 from bsc_branch_business b
 inner join BC_BUSINESSMANAGE bm
 on (b.bus_id = bm.business_id)
 where  b.device_no =:deviceNo
 and b.business_type=''1''
 and b.org_id =:v_orgId ';
 OPEN p_cursor FOR v_sql using deviceNo,v_orgId;




end proc_findBusys;
/

prompt
prompt Creating procedure PROC_FINDSHOWTIME_QUERY
prompt ==========================================
prompt
create or replace procedure iqms_new.proc_findShowTime_query (
--orgId varchar2,
deviceNo varchar2,
businessId varchar2,
dateType varchar2,
p_cursor out sys_refcursor)
as
   v_sql varchar2(4000);


begin

 v_sql := 'select b.* from bsc_show_time b
 where b.device_no =:deviceNo and b.business_id=:businessId
 and b.date_type=:dateType order by b.begin_time ' ;

  OPEN p_cursor FOR v_sql using deviceNo,businessId,dateType;




end proc_findShowTime_query;
/

prompt
prompt Creating procedure PROC_INSERT_ORDERINFO
prompt ========================================
prompt
CREATE OR REPLACE PROCEDURE iqms_new.proc_insert_orderinfo
(
 orgCode IN varchar2,  -- 机构编码
 devNo IN varchar2,    -- 设备号
 actNo in varchar2, --激活码
 orderBusId in varchar2,--业务id
 orderBusCode in varchar2,--业务code
 certType in varchar2, -- 证件类型
 certContent in varchar2, -- 证件号
 orderDt in varchar2,
 orderTime in varchar2,
 rangeBegin in varchar2,
 rangeEnd in varchar2,
 ReturnCode out varchar2  -- 返回结果  0-成功   1-失败

)
AS
  recordExists INTEGER DEFAULT 0;
BEGIN
  insert into order_info (
         order_id,
         org_code,
         dev_no,
         act_no,
         ORDER_BUSID,
         ORDER_BUSCODE,
         cert_type,
         cert_content,
         ORDER_DATE,
         order_time,
         RANGE_BEGIN,
         RANGE_END,
         order_status,
         OPERTATE_DATE) values
         (
         SEQ_ORDERINFO.NEXTVAL,
         orgCode,
         devNo,
         actNo,
         orderBusId,
         orderBusCode,
         certType,
         certContent,
         orderDt,
         orderTime,
         rangeBegin,
         rangeEnd,
         0,
         to_char(sysdate,'yyyy-mm-dd')
         );
ReturnCode := 0;
END proc_insert_orderinfo;
/

prompt
prompt Creating procedure PROC_MOBSCDEVICESTATUS_PAGE
prompt ==============================================
prompt
create or replace procedure iqms_new.proc_mobscdevicestatus_page (
orgId varchar2, --机构id
onLineFlag  varchar2,--是否在线
orderfield in varchar2,
ordertype in varchar2,
pagesize in number, pageno in number,totalrows out number,p_cursor out sys_refcursor)
as
   v_sql varchar2(4000);
   v_sql_page varchar2(4000);
   v_sql_condition varchar2(4000);
   v_sql_count varchar2(4000);
   v_begin number := (pageno-1)*pagesize+1;
   v_end number := pageno*pagesize;
   v_sort varchar2(50);
   v_orgId varchar2(50) := orgId;
   v_onLineFlag varchar2(50) := onLineFlag;
   v_inervalOnline number;
   v_onLine varchar2(50);

begin
---------------------------------------------------------1.按条件查询数据 start------------------------------------------------------------------
if v_orgId = '0' then
  v_orgId := '1';
  end if;
 select p.hb_interval into v_inervalOnline from bc_parameter p;

-- select (case when
 --(h.online_time is null or
 --(TO_NUMBER(sysdate - h.online_time) * 24 * 60)> '||v_inervalOnline||') then '3' else '1' end)
 --into v_onLine from bsc_device h;

  v_sql_condition := 'select h.rowid rid,og.org_id,og.org_name,h.device_no,
     (case when (h.online_time is null or (TO_NUMBER(sysdate - h.online_time) * 24 * 60)> '||v_inervalOnline||') then ''3'' else ''1'' end) ONLINE_FLAG,
     ds.CPU_RATIO,
     ds.MEM_RATIO,
     ds.DISK_RATIO,
     ds.THERMALPRINTER_STATUS THERMALPRINTER_STATUS,
     ds.NEEDLEPRINTER_STATUS NEEDLEPRINTER_STATUS,
     ds.IDREADER_STATUS IDREADER_STATUS,
     ds.SWREAD_STATUS SWREAD_STATUS,
     ds.ICREADER_STATUS ICREADER_STATUS,
     ds.BAR_STATUS BAR_STATUS,
     ds.COMP_STATUS COMP_STATUS,
     ds.VERSION_SEQ,
     h.currt_vername,
     h.last_vername
    from bsc_device h
   inner join (select *
                 from sys_org o
                where o.deleted = 0
                start with o.org_id = :orgId
               connect by prior o.org_id = o.parent_id) og
      on (h.ORG_ID = og.ORG_ID)
    left join bsc_device_status ds
      on (ds.device_no = h.device_no) ';

  -------------------------------------------------2.包裹按条件查询的语句，进行分页 开始------------------------------------------------------------
  if (orderfield is null) then
      v_sort := 'device_no';
  else
      v_sort := orderfield||' '||ordertype;
  end if;

 --select result
 v_sql := 'select row_number() over ( order by '||v_sort||',rid) rnum,
  tt.ORG_ID,tt.DEVICE_NO,tt.CPU_RATIO,tt.MEM_RATIO,tt.DISK_RATIO,tt.VERSION_SEQ,
  tt.ONLINE_FLAG,
  tt.THERMALPRINTER_STATUS,tt.NEEDLEPRINTER_STATUS,tt.IDREADER_STATUS,tt.SWREAD_STATUS,tt.ICREADER_STATUS,tt.BAR_STATUS,
  tt.COMP_STATUS,
  tt.currt_vername,tt.last_vername,tt.org_name
  from ('||v_sql_condition||') tt where  ';

  -- 查询是否在线
  if (onLineFlag is null or onLineFlag = '2') then
      v_onLineFlag := '2';
      v_sql := v_sql || 'tt.ONLINE_FLAG != :v_onLineFlag ';
  else
      v_sql := v_sql || 'tt.ONLINE_FLAG = :v_onLineFlag ';
  end if;


   --select count
  v_sql_count := 'select count(1) from ('||v_sql||')';


------------------------------------------------------------3.判断是分页还是查询列表

   if pageno > 0  then
    v_sql_page := 'select ORG_ID,
       DEVICE_NO,
       CPU_RATIO,
       MEM_RATIO,
       DISK_RATIO,
       VERSION_SEQ,
       ONLINE_FLAG,
       THERMALPRINTER_STATUS,
       NEEDLEPRINTER_STATUS,
       IDREADER_STATUS,
       SWREAD_STATUS,
       ICREADER_STATUS,
       BAR_STATUS,
       COMP_STATUS,
       currt_vername,
       last_vername,
       org_name  from ('||v_sql||') temp where temp.rnum >= :v_begin and temp.rnum <= :v_end';
     execute immediate v_sql_count into totalrows using v_orgId,v_onLineFlag;
     OPEN p_cursor FOR v_sql_page using  v_orgId,v_onLineFlag,v_begin,v_end;
  else
    totalrows:=0; --set default value
    v_sql_page := 'select ORG_ID,
       DEVICE_NO,
       CPU_RATIO,
       MEM_RATIO,
       DISK_RATIO,
       VERSION_SEQ,
       ONLINE_FLAG,
       THERMALPRINTER_STATUS,
       NEEDLEPRINTER_STATUS,
       IDREADER_STATUS,
       SWREAD_STATUS,
       ICREADER_STATUS,
       BAR_STATUS,
       COMP_STATUS,
       currt_vername,
       last_vername,
       org_name from ('||v_sql||') temp ';
    OPEN p_cursor FOR v_sql_page using  v_orgId,v_onLineFlag;
  end if;

end proc_mobscdevicestatus_page;
/

prompt
prompt Creating procedure PROC_MOBSCDEVICESTATUS_SHOW
prompt ==============================================
prompt
create or replace procedure iqms_new.proc_mobscdevicestatus_show (
orgId varchar2, --机构id
deviceNo  varchar2,--是否在线
p_cursor out sys_refcursor)
as
   v_sql varchar2(4000);
   v_orgId varchar2(50) := orgId;
   v_deviceNo varchar2(50) := deviceNo;

begin
---------------------------------------------------------1.按条件查询数据 start------------------------------------------------------------------

  v_sql := ' select h.ORG_ID,h.DEVICE_NO,h.CPU_RATIO,h.MEM_RATIO,h.DISK_RATIO,
  d.currt_vername,d.last_vername,s.org_name from bsc_device_status h,bc_parameter b,sys_org s,bsc_device d where d.device_no=h.device_no
  and s.org_id = h.org_id and h.org_id =:orgId and h.device_no =:deviceNo';





OPEN p_cursor FOR v_sql using  v_orgId,v_deviceNo;

end proc_mobscdevicestatus_show;
/

prompt
prompt Creating procedure PROC_MYTEST
prompt ==============================
prompt
create or replace procedure iqms_new.proc_mytest
as

begin


 --select result

 update sys_user u set u.real_name = '张二狗' where u.username='hongxz';

 commit;

end proc_mytest;
/

prompt
prompt Creating procedure PROC_NEARS_QUERY
prompt ===================================
prompt
create or replace procedure iqms_new.proc_nears_query (--查询临近网点信息到客户端
orgId varchar2, --机构id

p_cursor out sys_refcursor)
as
   v_sql varchar2(4000);
   v_orgId varchar2(50) := orgId;


begin
---------------------------------------------------------1.按条件查询数据 start------------------------------------------------------------------
v_sql := 'select count(1) totalGetNums,
sum(case when t.trx_status = ''1'' then 1 else 0 end) totalWait,
sum(case when t.trx_status = ''3'' then 1 else 0 end) totalFinished,
sum(case when t.trx_status = ''2'' then 1 else 0 end) totalDeal,
s.org_name
from  trx_today t inner join sys_org s on t.org_id = s.org_id

where
to_char(t.trx_date, ''yyyy/mm/dd'') =
to_char(sysdate,''yyyy/mm/dd'')
and t.org_id = :orgId
group by s.org_name';--总取号数，总等候数，已办理数

 OPEN p_cursor FOR v_sql using v_orgId;

end proc_nears_query;
/

prompt
prompt Creating procedure PROC_NUMBERFORM_ADD
prompt ======================================
prompt
CREATE OR REPLACE PROCEDURE iqms_new.proc_numberform_add
(
 tktFormatId varchar2,
 v_tktFormat varchar2,
 ReturnCode OUT varchar2
)
AS
iRecCount INTEGER;
BEGIN

   --查询要增加的记录是否存在
   select count(1) into iRecCount from bc_numberform b where b.tktformat = v_tktFormat;

   if iRecCount > 0 then
     ReturnCode:='2'; --该号码模板已经存在
   else
     --插入
     insert into bc_numberform t (
         TKTFORMAT_ID,
         TKTFORMAT
     ) values (
         SEQ_BCNUMBERFORM.NEXTVAL,
         v_tktFormat
     );
     ReturnCode:='0';
   end if;
   --异常处理
   -- exception
     --   when others then
       --  ReturnCode:='1'; --数据库异常

END proc_numberform_add;
/

prompt
prompt Creating procedure PROC_NUMBERFORM_DELETE
prompt =========================================
prompt
create or replace procedure iqms_new.proc_numberform_delete(
tktFormatId in varchar2,
ReturnCode out varchar2
)
IS
cursor v_deviceNo is
select t.device_no from bc_ticketform t left join bc_numberform n on
t.tktformat_id = n.tktformat_id;
v_no v_deviceNo%rowtype;
begin
  delete from bc_numberform b where b.tktformat_id = tktFormatId ;
  for v_no in v_deviceNo loop
     proc_deviceupdateflag(v_no.device_no,'0');

     end loop;
  ReturnCode:='0';

  --异常处理
 -- exception
   --   when others then
     --  ReturnCode:='1'; --数据库异常

end proc_numberform_delete;
/

prompt
prompt Creating procedure PROC_NUMBERFORM_UPDATE
prompt =========================================
prompt
CREATE OR REPLACE PROCEDURE iqms_new.proc_numberform_update
(
 tktFormatId varchar2,
 v_tktFormat varchar2,
 ReturnCode OUT varchar2
)
IS
cursor v_deviceNo is
select t.device_no from bc_ticketform t left join bc_numberform n on
t.tktformat_id = n.tktformat_id;
v_no v_deviceNo%rowtype;
iRecCount INTEGER;
BEGIN
   --查询要修改的记录是否存在
   select count(1) into iRecCount from bc_numberform b where b.tktformat = v_tktFormat and b.tktformat_id <> tktFormatId;

   if iRecCount > 0 then
       ReturnCode:='2';
   else
     update bc_numberform t set
        t.TKTFORMAT = v_tktFormat
     where  t.TKTFORMAT_ID = tktFormatId;

     for v_no in v_deviceNo loop
     proc_deviceupdateflag(v_no.device_no,'0');

     end loop;
     ReturnCode:='0';
   end if ;

 --异常处理
 -- exception
   --   when others then
     --  ReturnCode:='1'; --数据库异常
END proc_numberform_update;
/

prompt
prompt Creating procedure PROC_NUMBER_COPY
prompt ===================================
prompt
CREATE OR REPLACE PROCEDURE iqms_new.proc_number_copy--应用到下级机构
(
 orgId varchar2,
 deviceNo varchar2,
 targetId varchar2,--目标orgId
 targetNo varchar2, --目标deviceNo
 ReturnCode OUT varchar2
)
AS
BEGIN
 if orgId != targetId or deviceNo != targetNo then
 --删除目标数据再插入
 delete from bc_numberform b where b.org_id = targetId and b.device_no = targetNo;

   --插入
   insert into bc_numberform (
      ORG_ID,
      DEVICE_NO,
      TKTFORMAT_ID,
      TKTFORMAT
   ) select
     targetId,
     targetNo,
     SEQ_BCNUMBERFORM.NEXTVAL,
     TKTFORMAT
    from bc_numberform w where w.org_id = orgId and w.device_no=deviceNo;
   ReturnCode:='0';
end if;
 --异常处理
 -- exception
   --   when others then
     --  ReturnCode:='1'; --数据库异常
END proc_number_copy;
/

prompt
prompt Creating procedure PROC_ORDERACTIVE_INFO
prompt ========================================
prompt
create or replace procedure iqms_new.proc_orderactive_info (
deviceNo varchar2,
certType varchar2,
certContent varchar2,
p_cursor out sys_refcursor)
as
   v_sql varchar2(4000);


begin


 if certType = '4' then --激活码
 v_sql :='select oi.order_id,oi.cert_type,oi.cert_content, oi.ORDER_BUSID,oi.ORDER_DATE,oi.RANGE_END from order_info oi
 where oi.act_no =:certContent and oi.dev_no =:deviceNo';
 OPEN p_cursor FOR v_sql using certContent,deviceNo;
 else
  v_sql :='select oi.order_id,oi.cert_type,oi.cert_content, oi.ORDER_BUSID,oi.ORDER_DATE,oi.RANGE_END from order_info oi
 where oi.cert_type =:certType and oi.cert_content =:certContent and oi.dev_no =:deviceNo';
 OPEN p_cursor FOR v_sql using certType,certContent,deviceNo;
 end if;






end proc_orderactive_info;
/

prompt
prompt Creating procedure PROC_ORDERCONFIG_ADD
prompt =======================================
prompt
CREATE OR REPLACE PROCEDURE iqms_new.proc_orderconfig_add
(
 orgId varchar2,
 deviceNo varchar2,
 beginTime varchar2 ,
 endTime varchar2,
 orderCount varchar2,
 ReturnCode OUT varchar2
)
AS
beginCount INTEGER;
endCount INTEGER;
betweenCount INTEGER;
orgCode varchar2(20);
BEGIN

 --查询要增加的时间段是否存在
 select count(1) into beginCount from order_range t where (t.begin_time = beginTime or
 t.end_time = beginTime)
 and t.device_no = deviceNo;
 select count(1) into endCount from order_range t where (t.end_time = endTime or
 t.begin_time = endTime) and t.device_no = deviceNo;

 select count(1) into betweenCount from order_range t where (t.begin_time < beginTime
 and  t.end_time > beginTime) or  (t.begin_time < endTime
 and  t.end_time > endTime)
 and t.device_no = deviceNo;

 if beginCount > 0 then
   ReturnCode:='1'; --开始时间已经存在
 elsif endCount>0 then
 ReturnCode:='2';--结束时间已存在
 elsif betweenCount>0 then
 ReturnCode:='3';--时间段重叠
 else
   select s.org_code into orgCode from sys_org s where s.org_id = orgId;
   --插入
   insert into order_range t (
      id,
      ORG_CODE,
      device_no,
      begin_time,
      end_time,
      ordercount
   ) values (
     seq_orderrange.nextval,
     orgCode,
     deviceNo,
     beginTime,
     endTime,
     orderCount
   );
   ReturnCode:='0';
 end if;
 --异常处理
 -- exception
   --   when others then
     --  ReturnCode:='1'; --数据库异常
END proc_orderconfig_add;
/

prompt
prompt Creating procedure PROC_ORDERCONFIG_COPY
prompt ========================================
prompt
CREATE OR REPLACE PROCEDURE iqms_new.proc_orderconfig_copy--应用到下级机构
(
 deviceNo varchar2,
 targetId varchar2,--目标orgId
 targetNo varchar2, --目标deviceNo
 ReturnCode OUT varchar2
)
AS
BEGIN
 if  deviceNo != targetNo then
 --删除目标数据再插入
 delete from order_range b where b.device_no = targetNo;

   --插入
   insert into order_range (
      id,
      ORG_CODE,
      device_no,
      begin_time,
      end_time,
      ordercount
   ) select
     SEQ_ORDERRANGE.NEXTVAL,
     s.org_code,
     targetNo,
     begin_time,
     end_time,
     ordercount

    from order_range w,sys_org s where  w.device_no=deviceNo
     and s.org_id = targetId;


   ReturnCode:='0';
end if;
 --异常处理
 -- exception
   --   when others then
     --  ReturnCode:='1'; --数据库异常
END proc_orderconfig_copy;
/

prompt
prompt Creating procedure PROC_ORDERCONFIG_EDIT
prompt ========================================
prompt
CREATE OR REPLACE PROCEDURE iqms_new.proc_orderconfig_edit
(
 orderId varchar2,
 beginTime varchar2,
 endTime varchar2 ,
 orderCount varchar2,
 deviceNo varchar2,
 ReturnCode OUT varchar2
)
AS
v_orderCount varchar2(20);
beginCount INTEGER;
endCount INTEGER;
betweenCount INTEGER;
BEGIN
  v_orderCount:= orderCount;
 --查询要增加的时间段是否存在
 select count(1) into beginCount from order_range t where (t.begin_time = beginTime or
 t.end_time = beginTime)
 and t.id <> orderId and t.device_no = deviceNo;
 select count(1) into endCount from order_range t where (t.end_time = endTime or
 t.begin_time = endTime)
 and t.id <> orderId and t.device_no = deviceNo;

 select count(1) into betweenCount from order_range t where (t.begin_time < beginTime
 and  t.end_time > beginTime) or  (t.begin_time < endTime
 and  t.end_time > endTime)
 and t.id <> orderId and t.device_no = deviceNo;

   if beginCount > 0 then
   ReturnCode:='1'; --开始时间已经存在
   elsif endCount>0 then
   ReturnCode:='2';--结束时间已存在
   elsif betweenCount>0 then
   ReturnCode:='3';--时间段重叠
 else
   update order_range t set
      t.begin_time = beginTime,
      t.end_time =endTime,
      t.ordercount = v_orderCount
   where t.id = orderId;
   commit;
   ReturnCode:='0';
   end if;

 --异常处理
 -- exception
   --   when others then
     --  ReturnCode:='1'; --数据库异常
END proc_orderconfig_edit;
/

prompt
prompt Creating procedure PROC_ORDERCONFIG_PAGE
prompt ========================================
prompt
create or replace procedure iqms_new.proc_orderconfig_page (
orgId varchar2, --机构ID

orderfield in varchar2,
ordertype in varchar2,
pagesize in number, pageno in number,totalrows out number,p_cursor out sys_refcursor)
as
   v_sql varchar2(4000);
   v_sql_page varchar2(4000);
   v_sql_condition varchar2(4000);
   v_sql_count varchar2(4000);
   v_begin number := (pageno-1)*pagesize+1;
   v_end number := pageno*pagesize;
   v_sort varchar2(50);
   v_orgCode varchar2(50);

begin
---------------------------------------------------------1.按条件查询数据 start------------------------------------------------------------------
  select s.org_code into v_orgCode from sys_org s where s.org_id = orgId;
  v_sql_condition := ' select o.id,o.rowId rid,o.org_code,o.device_no,o.begin_time,o.end_time,
  o.ordercount,s.org_name,d.host_name from order_range o,sys_org s,bsc_device d where
  o.org_code=s.org_code and o.device_no = d.device_no  ';


  if v_orgCode is not null then
     v_sql_condition := v_sql_condition || ' and o.org_code like ''%''||:v_orgCode||''%''';
   else
     v_orgCode := '@#$&^%$#@!';
     v_sql_condition := v_sql_condition || ' and ( o.org_code  is null or o.org_code <>:v_orgCode)';

  end if;


  -------------------------------------------------2.包裹按条件查询的语句，进行分页 开始------------------------------------------------------------
  if (orderfield is null) then
      v_sort := 'org_code';
  else
      v_sort := orderfield||' '||ordertype;
  end if;

 --select result
 v_sql := 'select row_number() over ( order by '||v_sort||',rid) rnum,tt.id,
  tt.org_code,
  tt.device_no,
  tt.begin_time,
  tt.end_time,
  tt.ordercount,
  tt.org_name,
  tt.host_name
  from ('||v_sql_condition||') tt ';

   --select count
  v_sql_count := 'select count(1) from ('||v_sql||')';


------------------------------------------------------------3.判断是分页还是查询列表

   if pageno > 0  then
    v_sql_page := 'select * from ('||v_sql||') temp where temp.rnum >= :v_begin and temp.rnum <= :v_end';
     execute immediate v_sql_count into totalrows using v_orgCode;
     OPEN p_cursor FOR v_sql_page using  v_orgCode,v_begin,v_end;
  else
    totalrows:=0; --set default value
    v_sql_page := 'select * from ('||v_sql||') temp ';
    OPEN p_cursor FOR v_sql_page using  v_orgCode;
  end if;

end proc_orderconfig_page;
/

prompt
prompt Creating procedure PROC_ORDERCONFIG_REMOVE
prompt ==========================================
prompt
CREATE OR REPLACE PROCEDURE iqms_new.proc_orderconfig_remove
(
 orderId varchar2,
 ReturnCode OUT varchar2
)
AS
BEGIN

   delete from order_range t where t.id = orderId;




   ReturnCode:='0';
 --异常处理
 -- exception
   --   when others then
     --  ReturnCode:='1'; --数据库异常
END proc_orderconfig_remove;
/

prompt
prompt Creating procedure PROC_ORDERINFO_EDIT
prompt ======================================
prompt
CREATE OR REPLACE PROCEDURE iqms_new.proc_orderinfo_edit
(
 orderId varchar2,
 ticketNo varchar2,
 ReturnCode OUT varchar2
)
AS
v_count integer;

BEGIN

   select count(1) into v_count from order_info where order_id = orderId;
   if v_count != 1 then
     ReturnCode:='1';--未找到预约记录
   else
   update order_info t set
      t.order_status = '1',
      t.modify_date =to_char(sysdate,'yyyy-mm-dd hh24:mi:ss'),
      t.ticket_no = ticketNo
   where t.order_id = orderId;

   ReturnCode:='0';
   end if;


 --异常处理
 -- exception
   --   when others then
     --  ReturnCode:='1'; --数据库异常
END proc_orderinfo_edit;
/

prompt
prompt Creating procedure PROC_ORDER_BUSINESS
prompt ======================================
prompt
create or replace procedure iqms_new.proc_order_business (
deviceNo varchar2,
--dateType varchar2,--是否假日
p_cursor out sys_refcursor)
as
   v_sql varchar2(4000);


begin



 v_sql := 'select b.org_id,b.device_no,
 b.bus_id,
 b.business_code,
 bm.business_name,
 bm.order_flag
 from bsc_branch_business b
 inner join BC_BUSINESSMANAGE bm
 on (b.bus_id = bm.business_id)

 where  b.device_no =:deviceNo
 and b.business_type=''1''
 and bm.order_flag =''1'' ';
 OPEN p_cursor FOR v_sql using deviceNo ;




end proc_order_business;
/

prompt
prompt Creating procedure PROC_PATCHDLCONFIRM
prompt ======================================
prompt
CREATE OR REPLACE PROCEDURE iqms_new.proc_patchDlConfirm
(
 deviceId varchar2,
 versionSeq varchar2,
 ReturnCode OUT varchar2  -- 1-失败，记录不存在     0-成功
)
AS
iRecCount INTEGER;
BEGIN

 --查询柜员是否存在versionSeq
 select count(1) into iRecCount from bsc_devupgrade_process t where t.device_no = deviceId and t.patch_id = versionSeq;

 if iRecCount > 0 then -- 更新下载日期
    update bsc_devupgrade_process t set t.dldate = sysdate where t.device_no = deviceId and t.patch_id = versionSeq;
     ReturnCode:='0';
 else
   ReturnCode:='1';
 end if;
 --异常处理
 -- exception
   --   when others then
     --  ReturnCode:='1'; --数据库异常
END proc_patchDlConfirm;
/

prompt
prompt Creating procedure PROC_REPORT_BUSGRAPHIC
prompt =========================================
prompt
create or replace procedure iqms_new.proc_report_busGraphic (
orgId in varchar2,
busType in varchar2,
startDate in varchar2,--不能对输入参数重新赋值
endDate in varchar2,
orderfield in varchar2,
ordertype in varchar2,
pagesize in number, pageno in number,totalrows out number,p_cursor out sys_refcursor)
as
   v_sql varchar2(4000);
   v_sql_page varchar2(4000);
   v_sql_condition varchar2(20000);
   v_sql_count varchar2(4000);
   v_begin number := (pageno-1)*pagesize+1;
   v_end number := pageno*pagesize;
   v_sort varchar2(50);

   v_orgid varchar2(50) := orgId;
   v_busType varchar2(50) := busType;
   v_startDate varchar2(50) := startDate;
   v_endDate varchar2(50) := endDate;

begin

  ---------------------------------------------------------1.按条件查询数据 start------------------------------------------------------------------

  v_sql_condition := ' select temps.bus_id,temps.business_name,
                             count(1) deal_count,
                             sum(case when temps.is_WaitOut=1 then 1 else 0 end) wait_count,
                             sum(case when temps.is_WaitOut=0 then 1 else 0 end) notwait_count,
                             sum(case when temps.deal_TimeOut=1 then 1 else 0 end) dealwait_count,
                             sum(case when temps.deal_TimeOut=0 then 1 else 0 end) notdealwait_count
                       from
                          (select temp.bus_id,temp.business_name,
                             (case when temp.cus_wait >temp.c_wait then ''1'' else ''0'' end) is_WaitOut,
                             (case when temp.bus_wait >temp.b_wait then ''1'' else ''0'' end) deal_TimeOut
                          from
                               (select h.bus_id,b.business_name,
                                  b.average_time b_wait,
                                  c.wait_timeout c_wait,
                                  trunc(((case when h.call_time is null then sysdate else h.call_time end)-h.print_time)*24*60,0) cus_wait,
                                  trunc(((case when h.end_time is null then sysdate else h.end_time end)-h.begin_time)*24*60,0) bus_wait
                               from trx_history h
                               inner join (select * from sys_org o where o.deleted=0  start with o.org_id =:v_orgid
                               connect by prior o.org_id = o.parent_id) og on (h.org_id=og.org_id)
                               left join bc_businessmanage b on (h.bus_id=b.business_id)
                               left join bc_custtype c on (h.cust_type = c.cust_level)
                               where h.trx_status=''3'' ';

  --其他查询条件
  if busType is not null then
     v_sql_condition := v_sql_condition || ' and h.bus_id = :v_busType';
   else
     v_busType := '@#$&^%$#@!';
     v_sql_condition := v_sql_condition || ' and ( h.bus_id  is null or h.bus_id <> :v_busType)';

  end if;

  if startDate is not null then
     v_sql_condition := v_sql_condition || ' and to_date(to_char(h.TRX_DATE,''yyyy-MM-dd''),''yyyy-MM-dd'') >= to_date(:startDate,''yyyy-MM-dd'') ';
   else
     v_startDate := '@#$&^%$#@!';
     v_sql_condition := v_sql_condition || ' and ( h.TRX_DATE  is null or to_char(h.TRX_DATE,''yyyy-MM-dd'') <> :startDate )';

  end if;

  if endDate is not null then
     v_sql_condition := v_sql_condition || ' and to_date(to_char(h.TRX_DATE,''yyyy-MM-dd''),''yyyy-MM-dd'') <= to_date(:endDate,''yyyy-MM-dd'') ';
   else
     v_endDate := '@#$&^%$#@!';
     v_sql_condition := v_sql_condition || ' and ( h.TRX_DATE  is null or to_char(h.TRX_DATE,''yyyy-MM-dd'') <>:endDate)';

  end if;

  v_sql_condition := v_sql_condition ||' ) temp ) temps group by temps.bus_id,temps.business_name order by temps.bus_id';


    OPEN p_cursor FOR v_sql_condition using  v_orgid,v_busType,v_startDate,v_endDate;

end proc_report_busGraphic;
/

prompt
prompt Creating procedure PROC_REPORT_BUSINESSCOUNT
prompt ============================================
prompt
create or replace procedure iqms_new.proc_report_businesscount (
orgId in varchar2,
busType in varchar2,
startDate in varchar2,--不能对输入参数重新赋值
endDate in varchar2,
orderfield in varchar2,
ordertype in varchar2,
pagesize in number, pageno in number,totalrows out number,p_cursor out sys_refcursor)
as
   v_sql varchar2(4000);
   v_sql_page varchar2(4000);
   v_sql_condition varchar2(20000);
   v_sql_count varchar2(4000);
   v_begin number := (pageno-1)*pagesize+1;
   v_end number := pageno*pagesize;
   v_sort varchar2(50);

   v_orgid varchar2(50) := orgId;
   v_busType varchar2(50) := busType;
   v_startDate varchar2(50) := startDate;
   v_endDate varchar2(50) := endDate;

begin

  ---------------------------------------------------------1.按条件查询数据 start------------------------------------------------------------------

  v_sql_condition := 'select h.org_id,og.org_code,og.org_name,h.bus_id,c.business_name,
                             count(1) deal_count,
                             to_char(trunc(avg(h.call_time-h.print_time)*24*60,1),''fm9999990.0999'') avg_wait,
                             to_char(trunc(max(h.call_time-h.print_time)*24*60,1),''fm9999990.0999'') max_wait,
                             to_char(trunc(min(h.call_time-h.print_time)*24*60,1),''fm9999990.0999'') min_wait,
                             to_char(trunc(avg(h.end_time-h.begin_time)*24*60,1),''fm9999990.0999'') avg_deal,
                             to_char(trunc(max(h.end_time-h.begin_time)*24*60,1),''fm9999990.0999'') max_deal,
                             to_char(trunc(min(h.end_time-h.begin_time)*24*60,1),''fm9999990.0999'') min_deal
                       from TRX_HISTORY h
                       inner join (select * from sys_org o where o.deleted=0  start with o.org_id = :v_orgid
                       connect by prior o.org_id = o.parent_id) og on (h.org_id=og.org_id)
                       inner join bc_businessmanage c on (h.bus_id=c.business_id)
                       where h.trx_status=''3'' and h.begin_time is not null and h.end_time is not null ';


  --其他查询条件
  if busType is not null then
     v_sql_condition := v_sql_condition || ' and h.bus_id = :v_busType';
   else
     v_busType := '@#$&^%$#@!';
     v_sql_condition := v_sql_condition || ' and ( h.bus_id  is null or h.bus_id <> :v_busType)';

  end if;

  if startDate is not null then
     v_sql_condition := v_sql_condition || ' and to_date(to_char(h.TRX_DATE,''yyyy-MM-dd''),''yyyy-MM-dd'') >= to_date(:startDate,''yyyy-MM-dd'') ';
   else
     v_startDate := '@#$&^%$#@!';
     v_sql_condition := v_sql_condition || ' and ( h.TRX_DATE  is null or to_char(h.TRX_DATE,''yyyy-MM-dd'') <> :startDate )';

  end if;

  if endDate is not null then
     v_sql_condition := v_sql_condition || ' and to_date(to_char(h.TRX_DATE,''yyyy-MM-dd''),''yyyy-MM-dd'') <= to_date(:endDate,''yyyy-MM-dd'') ';
   else
     v_endDate := '@#$&^%$#@!';
     v_sql_condition := v_sql_condition || ' and ( h.TRX_DATE  is null or to_char(h.TRX_DATE,''yyyy-MM-dd'') <>:endDate)';

  end if;

  v_sql_condition := v_sql_condition ||' group by h.org_id,og.org_code,og.org_name,h.bus_id,c.business_name';


-------------------------------------------------2.包裹按条件查询的语句，进行分页 开始------------------------------------------------------------
  if (orderfield is null) then
      v_sort := 'ORG_ID ';
  else
      v_sort := orderfield||' '||ordertype;
  end if;

 --select result
 v_sql := 'select row_number() over ( order by '||v_sort||') rnum,
    tt.ORG_ID,
    tt.ORG_CODE,
    tt.ORG_NAME,
    tt.bus_id,
    tt.business_name,
    tt.deal_count,
    tt.avg_wait,
    tt.max_wait,
    tt.min_wait,
    tt.avg_deal,
    tt.max_deal,
    tt.min_deal
   from ('||v_sql_condition||') tt ';

   --select count
  v_sql_count := 'select count(1) from ('||v_sql||')';

------------------------------------------------------------3.判断是分页还是查询列表

   if pageno > 0  then
    v_sql_page := 'select * from ('||v_sql||') temp where temp.rnum >= :v_begin and temp.rnum <= :v_end';
     execute immediate v_sql_count into totalrows using v_orgid,v_busType,v_startDate,v_endDate;
     OPEN p_cursor FOR v_sql_page using  v_orgid,v_busType,v_startDate,v_endDate,v_begin,v_end;
  else
    totalrows:=0; --set default value
    v_sql_page := 'select * from ('||v_sql||') temp ';
    OPEN p_cursor FOR v_sql_page using  v_orgid,v_busType,v_startDate,v_endDate;
  end if;

end proc_report_businesscount;
/

prompt
prompt Creating procedure PROC_REPORT_BUSINESSCOUNTGRPH
prompt ================================================
prompt
create or replace procedure iqms_new.proc_report_businesscountgrph (
orgId in varchar2,
busType in varchar2,
startDate in varchar2,--不能对输入参数重新赋值
endDate in varchar2,
orderfield in varchar2,
ordertype in varchar2,
pagesize in number, pageno in number,totalrows out number,p_cursor out sys_refcursor)
as
   v_sql varchar2(4000);
   v_sql_page varchar2(4000);
   v_sql_condition varchar2(20000);
   v_sql_count varchar2(4000);
   v_begin number := (pageno-1)*pagesize+1;
   v_end number := pageno*pagesize;
   v_sort varchar2(50);

   v_orgid varchar2(50) := orgId;
   v_busType varchar2(50) := busType;
   v_startDate varchar2(50) := startDate;
   v_endDate varchar2(50) := endDate;

begin

  ---------------------------------------------------------1.按条件查询数据 start------------------------------------------------------------------

  v_sql_condition := 'select h.bus_id,c.business_name,
                             count(1) deal_count,
                             to_char(trunc(avg(h.call_time-h.print_time)*24*60,1),''fm9999990.0999'') avg_wait,
                             to_char(trunc(max(h.call_time-h.print_time)*24*60,1),''fm9999990.0999'') max_wait,
                             to_char(trunc(min(h.call_time-h.print_time)*24*60,1),''fm9999990.0999'') min_wait,
                             to_char(trunc(avg(h.end_time-h.begin_time)*24*60,1),''fm9999990.0999'') avg_deal,
                             to_char(trunc(max(h.end_time-h.begin_time)*24*60,1),''fm9999990.0999'') max_deal,
                             to_char(trunc(min(h.end_time-h.begin_time)*24*60,1),''fm9999990.0999'') min_deal
                       from TRX_HISTORY h
                       inner join (select * from sys_org o where o.deleted=0  start with o.org_id = :v_orgid
                       connect by prior o.org_id = o.parent_id) og on (h.org_id=og.org_id)
                       inner join bc_businessmanage c on (h.bus_id=c.business_id)
                       where h.trx_status=''3'' and h.end_time is not null and h.begin_time is not null ';


  --其他查询条件
  if busType is not null then
     v_sql_condition := v_sql_condition || ' and h.bus_id = :v_busType';
   else
     v_busType := '@#$&^%$#@!';
     v_sql_condition := v_sql_condition || ' and ( h.bus_id  is null or h.bus_id <> :v_busType)';

  end if;

  if startDate is not null then
     v_sql_condition := v_sql_condition || ' and to_date(to_char(h.TRX_DATE,''yyyy-MM-dd''),''yyyy-MM-dd'') >= to_date(:startDate,''yyyy-MM-dd'') ';
   else
     v_startDate := '@#$&^%$#@!';
     v_sql_condition := v_sql_condition || ' and ( h.TRX_DATE  is null or to_char(h.TRX_DATE,''yyyy-MM-dd'') <> :startDate )';

  end if;

  if endDate is not null then
     v_sql_condition := v_sql_condition || ' and to_date(to_char(h.TRX_DATE,''yyyy-MM-dd''),''yyyy-MM-dd'') <= to_date(:endDate,''yyyy-MM-dd'') ';
   else
     v_endDate := '@#$&^%$#@!';
     v_sql_condition := v_sql_condition || ' and ( h.TRX_DATE  is null or to_char(h.TRX_DATE,''yyyy-MM-dd'') <>:endDate)';

  end if;

  v_sql_condition := v_sql_condition ||' group by h.bus_id,c.business_name order by h.bus_id';


    OPEN p_cursor FOR v_sql_condition using  v_orgid,v_busType,v_startDate,v_endDate;

end proc_report_businesscountgrph;
/

prompt
prompt Creating procedure PROC_REPORT_BUSINESSFLOW
prompt ===========================================
prompt
create or replace procedure iqms_new.proc_report_businessflow (
orgId in varchar2,
--busType in varchar2,
custLevel in varchar2,
appValue in varchar2,
startDate in varchar2,--不能对输入参数重新赋值
endDate in varchar2,
orderfield in varchar2,
ordertype in varchar2,
pagesize in number, pageno in number,totalrows out number,p_cursor out sys_refcursor)
as
   v_sql varchar2(4000);
   v_sql_page varchar2(4000);
   v_sql_condition varchar2(20000);
   v_sql_count varchar2(4000);
   v_begin number := (pageno-1)*pagesize+1;
   v_end number := pageno*pagesize;
   v_sort varchar2(50);

   v_orgid varchar2(50) := orgId;
   --v_busType varchar2(50) := busType;
   v_custLevel varchar2(50) := custLevel;
   v_appValue varchar2(50) := appValue;
   v_startDate varchar2(50) := startDate;
   v_endDate varchar2(50) := endDate;

begin

  ---------------------------------------------------------1.按条件查询数据 start------------------------------------------------------------------

  v_sql_condition := 'select h.org_id,og.org_code,og.org_name,h.device_no,h.trx_date,h.flow_no,h.bus_id,
                             b.BUSINESS_NAME,h.ticket_no,h.cust_type,c.cust_name,h.teller_no,h.win_no,h.print_time,
                             h.call_time,h.begin_time,h.end_time,h.app_value,h.trx_status,h.pdj_level,h.ticket_type,h.cust_id,
                             h.card_type,h.card_no,h.manager_no,h.extend1,h.extend2,h.extend3
                       from TRX_HISTORY h
                       inner join (select * from sys_org o where o.deleted=0  start with o.org_id =:v_orgid
                       connect by prior o.org_id = o.parent_id) og on (h.org_id=og.org_id)
                       inner join bc_businessmanage b on (h.bus_id=b.BUSINESS_ID)
                       left join bc_custtype c on (h.cust_type = c.cust_level) where 1=1  ';

  --其他查询条件
  /*if busType is not null then
     v_sql_condition := v_sql_condition || ' and h.bus_id = :v_busType';
   else
     v_busType := '@#$&^%$#@!';
     v_sql_condition := v_sql_condition || ' and ( h.bus_id  is null or h.bus_id <> :v_busType)';

  end if;*/

  if custLevel is not null then
     v_sql_condition := v_sql_condition || ' and h.cust_type = :v_custLevel';
   else
     v_custLevel := '@#$&^%$#@!';
     v_sql_condition := v_sql_condition || ' and ( h.cust_type  is null or h.cust_type <> :v_custLevel)';

  end if;

  if appValue is not null then
     v_sql_condition := v_sql_condition || ' and h.app_value = :v_appValue';
   else
     v_appValue := 5201314;
     v_sql_condition := v_sql_condition || ' and ( h.app_value  is null or h.app_value <> :v_appValue)';

  end if;

  if startDate is not null then
     v_sql_condition := v_sql_condition || ' and to_date(to_char(h.TRX_DATE,''yyyy-MM-dd''),''yyyy-MM-dd'') >= to_date(:startDate,''yyyy-MM-dd'') ';
   else
     v_startDate := '@#$&^%$#@!';
     v_sql_condition := v_sql_condition || ' and ( h.TRX_DATE  is null or to_char(h.TRX_DATE,''yyyy-MM-dd'') <> :startDate )';

  end if;

  if endDate is not null then
     v_sql_condition := v_sql_condition || ' and to_date(to_char(h.TRX_DATE,''yyyy-MM-dd''),''yyyy-MM-dd'') <= to_date(:endDate,''yyyy-MM-dd'') ';
   else
     v_endDate := '@#$&^%$#@!';
     v_sql_condition := v_sql_condition || ' and ( h.TRX_DATE  is null or to_char(h.TRX_DATE,''yyyy-MM-dd'') <>:endDate)';

  end if;



-------------------------------------------------2.包裹按条件查询的语句，进行分页 开始------------------------------------------------------------
  if (orderfield is null) then
      v_sort := 'ORG_ID ';
  else
      v_sort := orderfield||' '||ordertype;
  end if;

 --select result
 v_sql := 'select row_number() over ( order by '||v_sort||') rnum,
    tt.ORG_ID,
    tt.ORG_CODE,
    tt.ORG_NAME,
    tt.device_no,
    tt.trx_date,
    tt.flow_no,
    tt.bus_id,
    tt.BUSINESS_NAME,
    tt.ticket_no,
    tt.cust_type,
    tt.cust_name,
    tt.teller_no,
    tt.win_no,
    tt.print_time,
    tt.call_time,
    tt.begin_time,
    tt.end_time,
    tt.app_value,
    tt.trx_status,
    tt.pdj_level,
    tt.ticket_type,
    tt.cust_id,
    tt.card_type,
    tt.card_no,
    tt.manager_no,
    tt.extend1,
    tt.extend2,
    tt.extend3
   from ('||v_sql_condition||') tt ';

   --select count
  v_sql_count := 'select count(1) from ('||v_sql||')';

------------------------------------------------------------3.判断是分页还是查询列表

   if pageno > 0  then
    v_sql_page := 'select * from ('||v_sql||') temp where temp.rnum >= :v_begin and temp.rnum <= :v_end';
     execute immediate v_sql_count into totalrows using v_orgid,v_custLevel,v_appValue,v_startDate,v_endDate;
     OPEN p_cursor FOR v_sql_page using  v_orgid,v_custLevel,v_appValue,v_startDate,v_endDate,v_begin,v_end;
  else
    totalrows:=0; --set default value
    v_sql_page := 'select * from ('||v_sql||') temp ';
    OPEN p_cursor FOR v_sql_page using  v_orgid,v_custLevel,v_appValue,v_startDate,v_endDate;
  end if;

end proc_report_businessflow;
/

prompt
prompt Creating procedure PROC_REPORT_BUSINESSSTATISTICS
prompt =================================================
prompt
create or replace procedure iqms_new.proc_report_businessstatistics (
orgId in varchar2,
busType in varchar2,
startDate in varchar2,--不能对输入参数重新赋值
endDate in varchar2,
orderfield in varchar2,
ordertype in varchar2,
pagesize in number, pageno in number,totalrows out number,p_cursor out sys_refcursor)
as
   v_sql varchar2(4000);
   v_sql_page varchar2(4000);
   v_sql_condition varchar2(20000);
   v_sql_count varchar2(4000);
   v_begin number := (pageno-1)*pagesize+1;
   v_end number := pageno*pagesize;
   v_sort varchar2(50);

   v_orgid varchar2(50) := orgId;
   v_busType varchar2(50) := busType;
   v_startDate varchar2(50) := startDate;
   v_endDate varchar2(50) := endDate;

begin

  ---------------------------------------------------------1.按条件查询数据 start------------------------------------------------------------------

  v_sql_condition := ' select temps.org_id,temps.org_code,temps.org_name,temps.bus_id,temps.business_name,temps.cust_level,temps.cust_name,
                             count(1) deal_count,
                             sum(case when temps.is_WaitOut=1 then 1 else 0 end) wait_count,
                             sum(case when temps.is_WaitOut=0 then 1 else 0 end) notwait_count,
                             sum(case when temps.deal_TimeOut=1 then 1 else 0 end) dealwait_count,
                             sum(case when temps.deal_TimeOut=0 then 1 else 0 end) notdealwait_count
                       from
                          (select temp.org_id,temp.org_code, temp.org_name,temp.bus_id,temp.business_name,temp.cust_level,temp.cust_name,
                             (case when temp.cus_wait >temp.c_wait then ''1'' else ''0'' end) is_WaitOut,
                             (case when temp.bus_wait >temp.b_wait then ''1'' else ''0'' end) deal_TimeOut
                          from
                               (select h.org_id, og.org_code,og.org_name,h.bus_id,b.business_name,c.cust_level,c.cust_name,
                                  b.average_time b_wait,
                                  c.wait_timeout c_wait,
                                  trunc(((case when h.call_time is null then sysdate else h.call_time end)-h.print_time)*24*60,0) cus_wait,
                                  trunc(((case when h.end_time is null then sysdate else h.end_time end)-h.begin_time)*24*60,0) bus_wait
                               from trx_history h
                               inner join (select * from sys_org o where o.deleted=0  start with o.org_id =:v_orgid
                               connect by prior o.org_id = o.parent_id) og on (h.org_id=og.org_id)
                               left join bc_businessmanage b on (h.bus_id=b.business_id)
                               left join bc_custtype c on (h.cust_type = c.cust_level)
                               where h.trx_status=''3'' ';

  --其他查询条件
  if busType is not null then
     v_sql_condition := v_sql_condition || ' and h.bus_id = :v_busType';
   else
     v_busType := '@#$&^%$#@!';
     v_sql_condition := v_sql_condition || ' and ( h.bus_id  is null or h.bus_id <> :v_busType)';

  end if;

  if startDate is not null then
     v_sql_condition := v_sql_condition || ' and to_date(to_char(h.TRX_DATE,''yyyy-MM-dd''),''yyyy-MM-dd'') >= to_date(:startDate,''yyyy-MM-dd'') ';
   else
     v_startDate := '@#$&^%$#@!';
     v_sql_condition := v_sql_condition || ' and ( h.TRX_DATE  is null or to_char(h.TRX_DATE,''yyyy-MM-dd'') <> :startDate )';

  end if;

  if endDate is not null then
     v_sql_condition := v_sql_condition || ' and to_date(to_char(h.TRX_DATE,''yyyy-MM-dd''),''yyyy-MM-dd'') <= to_date(:endDate,''yyyy-MM-dd'') ';
   else
     v_endDate := '@#$&^%$#@!';
     v_sql_condition := v_sql_condition || ' and ( h.TRX_DATE  is null or to_char(h.TRX_DATE,''yyyy-MM-dd'') <>:endDate)';

  end if;

  v_sql_condition := v_sql_condition ||' ) temp ) temps group by temps.org_id,temps.org_code,temps.org_name,temps.bus_id,temps.business_name,temps.cust_level,temps.cust_name';


-------------------------------------------------2.包裹按条件查询的语句，进行分页 开始------------------------------------------------------------
  if (orderfield is null) then
      v_sort := 'ORG_ID ';
  else
      v_sort := orderfield||' '||ordertype;
  end if;

 --select result
 v_sql := 'select row_number() over ( order by '||v_sort||') rnum,
    tt.ORG_ID,
    tt.ORG_CODE,
    tt.ORG_NAME,
    tt.bus_id,
    tt.business_name,
    tt.cust_level,
    tt.cust_name,
    tt.deal_count,
    tt.wait_count,
    tt.notwait_count,
    tt.dealwait_count,
    tt.notdealwait_count
   from ('||v_sql_condition||') tt ';

   --select count
  v_sql_count := 'select count(1) from ('||v_sql||')';

------------------------------------------------------------3.判断是分页还是查询列表

   if pageno > 0  then
    v_sql_page := 'select * from ('||v_sql||') temp where temp.rnum >= :v_begin and temp.rnum <= :v_end';
     execute immediate v_sql_count into totalrows using v_orgid,v_busType,v_startDate,v_endDate;
     OPEN p_cursor FOR v_sql_page using  v_orgid,v_busType,v_startDate,v_endDate,v_begin,v_end;
  else
    totalrows:=0; --set default value
    v_sql_page := 'select * from ('||v_sql||') temp ';
    OPEN p_cursor FOR v_sql_page using  v_orgid,v_busType,v_startDate,v_endDate;
  end if;

end proc_report_businessstatistics;
/

prompt
prompt Creating procedure PROC_REPORT_COMETIME
prompt =======================================
prompt
create or replace procedure iqms_new.proc_report_cometime (
orgId in varchar2,
startDate in varchar2,--不能对输入参数重新赋值
endDate in varchar2,
orderfield in varchar2,
ordertype in varchar2,
pagesize in number, pageno in number,totalrows out number,p_cursor out sys_refcursor)
as
   v_sql varchar2(4000);
   v_sql_page varchar2(4000);
   v_sql_condition varchar2(20000);
   v_sql_count varchar2(4000);
   v_begin number := (pageno-1)*pagesize+1;
   v_end number := pageno*pagesize;
   v_sort varchar2(50);

   v_orgid varchar2(50) := orgId;
   v_startDate varchar2(50) := startDate;
   v_endDate varchar2(50) := endDate;

begin

  ---------------------------------------------------------1.按条件查询数据 start------------------------------------------------------------------

  v_sql_condition := 'select tempss.org_id,tempss.org_code,tempss.org_name,
               sum(case when tempss.seven_eight=1 then 1 else 0 end) seven_count,
               sum(case when tempss.eight_nine=1 then 1 else 0 end) eight_count,
               sum(case when tempss.nine_ten=1 then 1 else 0 end) nine_count,
               sum(case when tempss.ten_eleven=1 then 1 else 0 end) ten_count,
               sum(case when tempss.eleven_twelve=1 then 1 else 0 end) eleven_count,
               sum(case when tempss.twelve_thirteen=1 then 1 else 0 end) twelve_count,
               sum(case when tempss.thirteen_fourteen=1 then 1 else 0 end) thirteen_count,
               sum(case when tempss.fourteen_fifteen=1 then 1 else 0 end) fourteen_count,
               sum(case when tempss.fifteen_sixteen=1 then 1 else 0 end) fifteen_count,
               sum(case when tempss.sixteen_seveteen=1 then 1 else 0 end) sixteen_count,
               sum(case when tempss.seveteen_eightee=1 then 1 else 0 end) seveteen_count,
               sum(case when tempss.eightee_nineteen=1 then 1 else 0 end) eightee_count
        from
         (select temps.org_id,temps.org_code,temps.org_name,
               (case when temps.time_scale=07 then ''1'' else ''0'' end) seven_eight,
               (case when temps.time_scale=08 then ''1'' else ''0'' end) eight_nine ,
               (case when temps.time_scale=09 then ''1'' else ''0'' end) nine_ten,
               (case when temps.time_scale=10 then ''1'' else ''0'' end) ten_eleven ,
               (case when temps.time_scale=11 then ''1'' else ''0'' end) eleven_twelve,
               (case when temps.time_scale=12 then ''1'' else ''0'' end) twelve_thirteen,
               (case when temps.time_scale=13 then ''1'' else ''0'' end) thirteen_fourteen,
               (case when temps.time_scale=14 then ''1'' else ''0'' end) fourteen_fifteen,
               (case when temps.time_scale=15 then ''1'' else ''0'' end) fifteen_sixteen,
               (case when temps.time_scale=16 then ''1'' else ''0'' end) sixteen_seveteen,
               (case when temps.time_scale=17 then ''1'' else ''0'' end) seveteen_eightee,
               (case when temps.time_scale=18 then ''1'' else ''0'' end) eightee_nineteen
        from
          (select temp.org_id,temp.org_code,temp.org_name,to_number(to_char(temp.print_time,''hh24'')) time_scale
         from
            (select c.org_id,og.org_code,og.org_name,c.trx_date,c.print_time from trx_history c
            inner join (select * from sys_org o where o.deleted=0  start with o.org_id = :v_orgid
            connect by prior o.org_id = o.parent_id) og on (c.org_id=og.org_id)
            where 1=1 ';

  --其他查询条件
  if startDate is not null then
     v_sql_condition := v_sql_condition || 'and to_date(to_char(c.trx_date,''yyyy-MM-dd''),''yyyy-MM-dd'') >= to_date(:startDate,''yyyy-MM-dd'') ';
   else
     v_startDate := '@#$&^%$#@!';
     v_sql_condition := v_sql_condition || ' and ( c.trx_date  is null or to_char(c.trx_date,''yyyy-MM-dd'') <> :startDate )';

  end if;

  if endDate is not null then
     v_sql_condition := v_sql_condition || 'and to_date(to_char(c.trx_date,''yyyy-MM-dd''),''yyyy-MM-dd'') <= to_date(:endDate,''yyyy-MM-dd'') ';
   else
     v_endDate := '@#$&^%$#@!';
     v_sql_condition := v_sql_condition || ' and ( c.trx_date  is null or to_char(c.trx_date,''yyyy-MM-dd'') <>:endDate)';

  end if;

  v_sql_condition := v_sql_condition ||' ) temp) temps) tempss group by tempss.org_id,tempss.org_code,tempss.org_name';


-------------------------------------------------2.包裹按条件查询的语句，进行分页 开始------------------------------------------------------------
  if (orderfield is null) then
      v_sort := 'ORG_ID ';
  else
      v_sort := orderfield||' '||ordertype;
  end if;

 --select result
 v_sql := 'select row_number() over ( order by '||v_sort||') rnum,
    tt.ORG_ID,
    tt.ORG_CODE,
    tt.ORG_NAME,
    tt.seven_count,
    tt.eight_count,
    tt.nine_count,
    tt.ten_count,
    tt.eleven_count,
    tt.twelve_count,
    tt.thirteen_count,
    tt.fourteen_count,
    tt.fifteen_count,
    tt.sixteen_count,
    tt.seveteen_count,
    tt.eightee_count
   from ('||v_sql_condition||') tt ';

   --select count
  v_sql_count := 'select count(1) from ('||v_sql||')';

------------------------------------------------------------3.判断是分页还是查询列表

   if pageno > 0  then
    v_sql_page := 'select * from ('||v_sql||') temp where temp.rnum >= :v_begin and temp.rnum <= :v_end';
     execute immediate v_sql_count into totalrows using v_orgid,v_startDate,v_endDate;
     OPEN p_cursor FOR v_sql_page using  v_orgid,v_startDate,v_endDate,v_begin,v_end;
  else
    totalrows:=0; --set default value
    v_sql_page := 'select * from ('||v_sql||') temp ';
    OPEN p_cursor FOR v_sql_page using  v_orgid,v_startDate,v_endDate;
  end if;

end proc_report_cometime;
/

prompt
prompt Creating procedure PROC_REPORT_CUSANALYSE
prompt =========================================
prompt
create or replace procedure iqms_new.proc_report_cusanalyse (
orgId in varchar2,
custLevel in varchar2,
startDate in varchar2,--不能对输入参数重新赋值
endDate in varchar2,
orderfield in varchar2,
ordertype in varchar2,
pagesize in number, pageno in number,totalrows out number,p_cursor out sys_refcursor)
as
   v_sql varchar2(4000);
   v_sql_page varchar2(4000);
   v_sql_condition varchar2(20000);
   v_sql_count varchar2(4000);
   v_begin number := (pageno-1)*pagesize+1;
   v_end number := pageno*pagesize;
   v_sort varchar2(50);

   v_orgid varchar2(50) := orgId;
   v_custLevel varchar2(50) := custLevel;
   v_startDate varchar2(50) := startDate;
   v_endDate varchar2(50) := endDate;

begin

  ---------------------------------------------------------1.按条件查询数据 start------------------------------------------------------------------

  v_sql_condition := 'select h.org_id,og.org_code,og.org_name,c.cust_level,c.cust_name,
                             count(1) deal_count,
                             to_char(trunc(avg(h.call_time-h.print_time)*24*60,1),''fm9999990.0999'') avg_wait,
                             to_char(trunc(max(h.call_time-h.print_time)*24*60,1),''fm9999990.0999'') max_wait,
                             to_char(trunc(min(h.call_time-h.print_time)*24*60,1),''fm9999990.0999'') min_wait,
                             to_char(trunc(avg(h.end_time-h.begin_time)*24*60,1),''fm9999990.0999'') avg_deal,
                             to_char(trunc(max(h.end_time-h.begin_time)*24*60,1),''fm9999990.0999'') max_deal,
                             to_char(trunc(min(h.end_time-h.begin_time)*24*60,1),''fm9999990.0999'') min_deal
                       from TRX_HISTORY h
                       left join (select * from sys_org o where o.deleted=0  start with o.org_id = :v_orgid
                       connect by prior o.org_id = o.parent_id) og on (h.org_id=og.org_id)
                       inner join bc_custtype c on (h.cust_type=c.cust_level)
                       where h.trx_status=''3'' and h.begin_time is not null and h.end_time is not null ';

  --其他查询条件
  if custLevel is not null then
     v_sql_condition := v_sql_condition || ' and h.cust_type = :v_custLevel';
   else
     v_custLevel := '@#$&^%$#@!';
     v_sql_condition := v_sql_condition || ' and ( h.cust_type  is null or h.cust_type <> :v_custLevel)';

  end if;

  if startDate is not null then
     v_sql_condition := v_sql_condition || ' and to_date(to_char(h.TRX_DATE,''yyyy-MM-dd''),''yyyy-MM-dd'') >= to_date(:startDate,''yyyy-MM-dd'') ';
   else
     v_startDate := '@#$&^%$#@!';
     v_sql_condition := v_sql_condition || ' and ( h.TRX_DATE  is null or to_char(h.TRX_DATE,''yyyy-MM-dd'') <> :startDate )';

  end if;

  if endDate is not null then
     v_sql_condition := v_sql_condition || ' and to_date(to_char(h.TRX_DATE,''yyyy-MM-dd''),''yyyy-MM-dd'') <= to_date(:endDate,''yyyy-MM-dd'') ';
   else
     v_endDate := '@#$&^%$#@!';
     v_sql_condition := v_sql_condition || ' and ( h.TRX_DATE  is null or to_char(h.TRX_DATE,''yyyy-MM-dd'') <>:endDate)';

  end if;

  v_sql_condition := v_sql_condition ||' group by h.org_id,og.org_code,og.org_name,c.cust_level,c.cust_name';


-------------------------------------------------2.包裹按条件查询的语句，进行分页 开始------------------------------------------------------------
  if (orderfield is null) then
      v_sort := 'ORG_ID ';
  else
      v_sort := orderfield||' '||ordertype;
  end if;

 --select result
 v_sql := 'select row_number() over ( order by '||v_sort||') rnum,
    tt.ORG_ID,
    tt.ORG_CODE,
    tt.ORG_NAME,
    tt.cust_level,
    tt.cust_name,
    tt.deal_count,
    tt.avg_wait,
    tt.max_wait,
    tt.min_wait,
    tt.avg_deal,
    tt.max_deal,
    tt.min_deal
   from ('||v_sql_condition||') tt ';

   --select count
  v_sql_count := 'select count(1) from ('||v_sql||')';

------------------------------------------------------------3.判断是分页还是查询列表

   if pageno > 0  then
    v_sql_page := 'select * from ('||v_sql||') temp where temp.rnum >= :v_begin and temp.rnum <= :v_end';
     execute immediate v_sql_count into totalrows using v_orgid,v_custLevel,v_startDate,v_endDate;
     OPEN p_cursor FOR v_sql_page using  v_orgid,v_custLevel,v_startDate,v_endDate,v_begin,v_end;
  else
    totalrows:=0; --set default value
    v_sql_page := 'select * from ('||v_sql||') temp ';
    OPEN p_cursor FOR v_sql_page using  v_orgid,v_custLevel,v_startDate,v_endDate;
  end if;

end proc_report_cusanalyse;
/

prompt
prompt Creating procedure PROC_REPORT_CUSANALYSEGRPH
prompt =============================================
prompt
create or replace procedure iqms_new.proc_report_cusanalysegrph (
orgId in varchar2,
custLevel in varchar2,
startDate in varchar2,--不能对输入参数重新赋值
endDate in varchar2,
orderfield in varchar2,
ordertype in varchar2,
pagesize in number, pageno in number,totalrows out number,p_cursor out sys_refcursor)
as
   v_sql varchar2(4000);
   v_sql_page varchar2(4000);
   v_sql_condition varchar2(20000);
   v_sql_count varchar2(4000);
   v_begin number := (pageno-1)*pagesize+1;
   v_end number := pageno*pagesize;
   v_sort varchar2(50);

   v_orgid varchar2(50) := orgId;
   v_custLevel varchar2(50) := custLevel;
   v_startDate varchar2(50) := startDate;
   v_endDate varchar2(50) := endDate;

begin

  ---------------------------------------------------------1.按条件查询数据 start------------------------------------------------------------------

  v_sql_condition := 'select c.cust_level,c.cust_name,
                             count(1) deal_count,
                             to_char(trunc(avg(h.call_time-h.print_time)*24*60,1),''fm9999990.0999'') avg_wait,
                             to_char(trunc(max(h.call_time-h.print_time)*24*60,1),''fm9999990.0999'') max_wait,
                             to_char(trunc(min(h.call_time-h.print_time)*24*60,1),''fm9999990.0999'') min_wait,
                             to_char(trunc(avg(h.end_time-h.begin_time)*24*60,1),''fm9999990.0999'') avg_deal,
                             to_char(trunc(max(h.end_time-h.begin_time)*24*60,1),''fm9999990.0999'') max_deal,
                             to_char(trunc(min(h.end_time-h.begin_time)*24*60,1),''fm9999990.0999'') min_deal
                       from TRX_HISTORY h
                       inner join (select * from sys_org o where o.deleted=0  start with o.org_id = :v_orgid
                       connect by prior o.org_id = o.parent_id) og on (h.org_id=og.org_id)
                       inner join bc_custtype c on (h.cust_type=c.cust_level)
                       where h.trx_status=''3'' and h.end_time is not null and h.begin_time is not null ';

  --其他查询条件
  if custLevel is not null then
     v_sql_condition := v_sql_condition || ' and h.cust_type = :v_custLevel';
   else
     v_custLevel := '@#$&^%$#@!';
     v_sql_condition := v_sql_condition || ' and ( h.cust_type  is null or h.cust_type <> :v_custLevel)';

  end if;

  if startDate is not null then
     v_sql_condition := v_sql_condition || ' and to_date(to_char(h.TRX_DATE,''yyyy-MM-dd''),''yyyy-MM-dd'') >= to_date(:startDate,''yyyy-MM-dd'') ';
   else
     v_startDate := '@#$&^%$#@!';
     v_sql_condition := v_sql_condition || ' and ( h.TRX_DATE  is null or to_char(h.TRX_DATE,''yyyy-MM-dd'') <> :startDate )';

  end if;

  if endDate is not null then
     v_sql_condition := v_sql_condition || ' and to_date(to_char(h.TRX_DATE,''yyyy-MM-dd''),''yyyy-MM-dd'') <= to_date(:endDate,''yyyy-MM-dd'') ';
   else
     v_endDate := '@#$&^%$#@!';
     v_sql_condition := v_sql_condition || ' and ( h.TRX_DATE  is null or to_char(h.TRX_DATE,''yyyy-MM-dd'') <>:endDate)';

  end if;

  v_sql_condition := v_sql_condition ||' group by c.cust_level,c.cust_name order by c.cust_level ';


    OPEN p_cursor FOR v_sql_condition using  v_orgid,v_custLevel,v_startDate,v_endDate;

end proc_report_cusanalysegrph;
/

prompt
prompt Creating procedure PROC_REPORT_EMPAPPRAISE
prompt ==========================================
prompt
create or replace procedure iqms_new.proc_report_empappraise (
orgId in varchar2,
workName in varchar2,
startDate in varchar2,--不能对输入参数重新赋值
endDate in varchar2,
orderfield in varchar2,
ordertype in varchar2,
pagesize in number, pageno in number,totalrows out number,p_cursor out sys_refcursor)
as
   v_sql varchar2(4000);
   v_sql_page varchar2(4000);
   v_sql_condition varchar2(20000);
   v_sql_count varchar2(4000);
   v_begin number := (pageno-1)*pagesize+1;
   v_end number := pageno*pagesize;
   v_sort varchar2(50);

   v_orgid varchar2(50) := orgId;
   v_workName varchar2(50) := workName;
   v_startDate varchar2(50) := startDate;
   v_endDate varchar2(50) := endDate;

begin

  ---------------------------------------------------------1.按条件查询数据 start------------------------------------------------------------------

  v_sql_condition := 'select  tmp.org_id,tmp.org_code,tmp.org_name,tmp.work_id,tmp.work_name ,
                            (tmp.app_content+tmp.app_soso+tmp.app_discontent+tmp.app_nonapp) total_count,
                             tmp.app_content,
                             tmp.app_soso,
                             tmp.app_discontent,
                             tmp.app_nonapp,
                             to_char(trunc(tmp.app_content/(tmp.app_content+tmp.app_soso+tmp.app_discontent+tmp.app_nonapp),3)*100,''FM999'') rate_content,
                             to_char(trunc(tmp.app_soso/(tmp.app_content+tmp.app_soso+tmp.app_discontent+tmp.app_nonapp),3)*100,''FM999'') rate_soso,
                             to_char(trunc(tmp.app_discontent/(tmp.app_content+tmp.app_soso+tmp.app_discontent+tmp.app_nonapp),3)*100,''FM999'') rate_discontent,
                             to_char(trunc(tmp.app_nonapp/(tmp.app_content+tmp.app_soso+tmp.app_discontent+tmp.app_nonapp),3)*100,''FM999'') rate_nonapp
                      from
                       (select h.org_id,og.org_code,og.org_name,t.work_id,t.name_ work_name,
                            sum(case when h.app_value=3 then 1 else 0 end) app_content,
                            sum(case when h.app_value=2 then 1 else 0 end) app_soso,
                            sum(case when h.app_value=1 then 1 else 0 end) app_discontent,
                            sum(case when h.app_value=0 then 1 else 0 end) app_nonapp
                       from TRX_HISTORY h
                       inner join (select * from sys_org o where o.deleted=0  start with o.org_id = :v_orgid
                       connect by prior o.org_id = o.parent_id) og on (h.org_id=og.org_id)
                       inner join bc_teller t on (t.org_id = h.org_id and t.work_id = h.teller_no)
                       where h.trx_status=''3'' ';

  --其他查询条件
  if workName is not null then
     v_sql_condition := v_sql_condition || ' and t.name_ = :v_workName';
   else
     v_workName := '@#$&^%$#@!';
     v_sql_condition := v_sql_condition || ' and ( t.name_  is null or t.name_ <> :v_workName)';

  end if;

  if startDate is not null then
     v_sql_condition := v_sql_condition || ' and to_date(to_char(h.TRX_DATE,''yyyy-MM-dd''),''yyyy-MM-dd'') >= to_date(:startDate,''yyyy-MM-dd'') ';
   else
     v_startDate := '@#$&^%$#@!';
     v_sql_condition := v_sql_condition || ' and ( h.TRX_DATE  is null or to_char(h.TRX_DATE,''yyyy-MM-dd'') <> :startDate )';

  end if;

  if endDate is not null then
     v_sql_condition := v_sql_condition || ' and to_date(to_char(h.TRX_DATE,''yyyy-MM-dd''),''yyyy-MM-dd'') <= to_date(:endDate,''yyyy-MM-dd'') ';
   else
     v_endDate := '@#$&^%$#@!';
     v_sql_condition := v_sql_condition || ' and ( h.TRX_DATE  is null or to_char(h.TRX_DATE,''yyyy-MM-dd'') <>:endDate)';

  end if;

  v_sql_condition := v_sql_condition ||'  group by h.org_id,og.org_code,og.org_name,t.work_id,t.name_ ) tmp';


-------------------------------------------------2.包裹按条件查询的语句，进行分页 开始------------------------------------------------------------
  if (orderfield is null) then
      v_sort := 'ORG_ID ';
  else
      v_sort := orderfield||' '||ordertype;
  end if;

 --select result
 v_sql := 'select row_number() over ( order by '||v_sort||') rnum,
    tt.ORG_ID,
    tt.ORG_CODE,
    tt.ORG_NAME,
    tt.work_id,
    tt.work_name,
    tt.total_count,
    tt.app_content,
    tt.app_soso,
    tt.app_discontent,
    tt.app_nonapp,
    tt.rate_content ,
    tt.rate_soso ,
    tt.rate_discontent ,
    tt.rate_nonapp
   from ('||v_sql_condition||') tt ';

   --select count
  v_sql_count := 'select count(1) from ('||v_sql||')';

------------------------------------------------------------3.判断是分页还是查询列表

   if pageno > 0  then
    v_sql_page := 'select * from ('||v_sql||') temp where temp.rnum >= :v_begin and temp.rnum <= :v_end';
     execute immediate v_sql_count into totalrows using v_orgid,v_workName,v_startDate,v_endDate;
     OPEN p_cursor FOR v_sql_page using  v_orgid,v_workName,v_startDate,v_endDate,v_begin,v_end;
  else
    totalrows:=0; --set default value
    v_sql_page := 'select * from ('||v_sql||') temp ';
    OPEN p_cursor FOR v_sql_page using  v_orgid,v_workName,v_startDate,v_endDate;
  end if;

end proc_report_empappraise;
/

prompt
prompt Creating procedure PROC_REPORT_EMPEFFICIENCY
prompt ============================================
prompt
create or replace procedure iqms_new.proc_report_empefficiency (
orgId in varchar2,
workName in varchar2,
startDate in varchar2,--不能对输入参数重新赋值
endDate in varchar2,
orderfield in varchar2,
ordertype in varchar2,
pagesize in number, pageno in number,totalrows out number,p_cursor out sys_refcursor)
as
   v_sql varchar2(4000);
   v_sql_page varchar2(4000);
   v_sql_condition varchar2(20000);
   v_sql_count varchar2(4000);
   v_begin number := (pageno-1)*pagesize+1;
   v_end number := pageno*pagesize;
   v_sort varchar2(50);

   v_orgid varchar2(50) := orgId;
   v_workName varchar2(50) := workName;
   v_startDate varchar2(50) := startDate;
   v_endDate varchar2(50) := endDate;

begin

  ---------------------------------------------------------1.按条件查询数据 start------------------------------------------------------------------

  v_sql_condition := 'select h.org_id,og.org_code,og.org_name,t.work_id,t.name_  work_name,
                             count(1) deal_count,
                             to_char(trunc(avg(h.end_time-h.begin_time)*24*60,1),''fm9999990.0999'') avg_deal,
                             to_char(trunc(max(h.end_time-h.begin_time)*24*60,1),''fm9999990.0999'') max_deal,
                             to_char(trunc(min(h.end_time-h.begin_time)*24*60,1),''fm9999990.0999'') min_deal
                       from TRX_HISTORY h
                       inner join (select * from sys_org o where o.deleted=0  start with o.org_id = :v_orgid
                       connect by prior o.org_id = o.parent_id) og on (h.org_id=og.org_id)
                       inner join bc_teller t on (t.org_id = h.org_id and t.work_id = h.teller_no)
                       where h.trx_status=''3''
                       and h.begin_time is not null and h.end_time is not null ';

  --其他查询条件
  if workName is not null then
     v_sql_condition := v_sql_condition || ' and t.name_ = :v_workName';
   else
     v_workName := '@#$&^%$#@!';
     v_sql_condition := v_sql_condition || ' and ( t.name_  is null or t.name_ <> :v_workName)';

  end if;

  if startDate is not null then
     v_sql_condition := v_sql_condition || ' and to_date(to_char(h.TRX_DATE,''yyyy-MM-dd''),''yyyy-MM-dd'') >= to_date(:startDate,''yyyy-MM-dd'') ';
   else
     v_startDate := '@#$&^%$#@!';
     v_sql_condition := v_sql_condition || ' and ( h.TRX_DATE  is null or to_char(h.TRX_DATE,''yyyy-MM-dd'') <> :startDate )';

  end if;

  if endDate is not null then
     v_sql_condition := v_sql_condition || ' and to_date(to_char(h.TRX_DATE,''yyyy-MM-dd''),''yyyy-MM-dd'') <= to_date(:endDate,''yyyy-MM-dd'') ';
   else
     v_endDate := '@#$&^%$#@!';
     v_sql_condition := v_sql_condition || ' and ( h.TRX_DATE  is null or to_char(h.TRX_DATE,''yyyy-MM-dd'') <>:endDate)';

  end if;

  v_sql_condition := v_sql_condition ||' group by h.org_id,og.org_code,og.org_name,t.work_id,t.name_';


-------------------------------------------------2.包裹按条件查询的语句，进行分页 开始------------------------------------------------------------
  if (orderfield is null) then
      v_sort := 'ORG_ID ';
  else
      v_sort := orderfield||' '||ordertype;
  end if;

 --select result
 v_sql := 'select row_number() over ( order by '||v_sort||') rnum,
    tt.ORG_ID,
    tt.ORG_CODE,
    tt.ORG_NAME,
    tt.work_id,
    tt.work_name,
    tt.deal_count,
    tt.avg_deal,
    tt.max_deal,
    tt.min_deal
   from ('||v_sql_condition||') tt ';

   --select count
  v_sql_count := 'select count(1) from ('||v_sql||')';

------------------------------------------------------------3.判断是分页还是查询列表

   if pageno > 0  then
    v_sql_page := 'select * from ('||v_sql||') temp where temp.rnum >= :v_begin and temp.rnum <= :v_end';
     execute immediate v_sql_count into totalrows using v_orgid,v_workName,v_startDate,v_endDate;
     OPEN p_cursor FOR v_sql_page using  v_orgid,v_workName,v_startDate,v_endDate,v_begin,v_end;
  else
    totalrows:=0; --set default value
    v_sql_page := 'select * from ('||v_sql||') temp ';
    OPEN p_cursor FOR v_sql_page using  v_orgid,v_workName,v_startDate,v_endDate;
  end if;

end proc_report_empefficiency;
/

prompt
prompt Creating procedure PROC_REPORT_ORGANALYSE
prompt =========================================
prompt
create or replace procedure iqms_new.proc_report_organalyse (
orgId in varchar2,
startDate in varchar2,--不能对输入参数重新赋值
endDate in varchar2,
orderfield in varchar2,
ordertype in varchar2,
pagesize in number, pageno in number,totalrows out number,p_cursor out sys_refcursor)
as
   v_sql varchar2(4000);
   v_sql_page varchar2(4000);
   v_sql_condition varchar2(2000);
   v_sql_count varchar2(4000);
   v_begin number := (pageno-1)*pagesize+1;
   v_end number := pageno*pagesize;
   v_sort varchar2(50);

   v_orgid varchar2(50) := orgId;
   v_startDate varchar2(50) := startDate;
   v_endDate varchar2(50) := endDate;

begin

  ---------------------------------------------------------1.按条件查询数据 start------------------------------------------------------------------

  v_sql_condition := 'select
                     h.org_id,og.org_code,og.org_name,
                     count(1) deal_count,
                     to_char(trunc(avg(h.call_time-h.print_time)*24*60,1),''fm9999990.0999'') avg_wait,
                     to_char(trunc(max(h.call_time-h.print_time)*24*60,1),''fm9999990.0999'') max_wait,
                     to_char(trunc(min(h.call_time-h.print_time)*24*60,1),''fm9999990.0999'') min_wait,
                     to_char(trunc(avg(h.end_time-h.begin_time)*24*60,1),''fm9999990.0999'') avg_deal,
                     to_char(trunc(max(h.end_time-h.begin_time)*24*60,1),''fm9999990.0999'') max_deal,
                     to_char(trunc(min(h.end_time-h.begin_time)*24*60,1),''fm9999990.0999'') min_deal
                     from TRX_HISTORY h
  inner join (select * from sys_org o where o.deleted=0  start with o.org_id =:v_orgid
  connect by prior o.org_id = o.parent_id) og on (h.ORG_ID=og.ORG_ID)
  where h.trx_status=''3'' and h.begin_time is not null and h.end_time is not null ';

  --其他查询条件
  if startDate is not null then
     v_sql_condition := v_sql_condition || ' and to_date(to_char(h.TRX_DATE,''yyyy-MM-dd''),''yyyy-MM-dd'') >= to_date(:startDate,''yyyy-MM-dd'') ';
   else
     v_startDate := '@#$&^%$#@!';
     v_sql_condition := v_sql_condition || ' and ( h.TRX_DATE  is null or to_char(h.TRX_DATE,''yyyy-MM-dd'') <> :startDate )';

  end if;

  if endDate is not null then
     v_sql_condition := v_sql_condition || 'and to_date(to_char(h.TRX_DATE,''yyyy-MM-dd''),''yyyy-MM-dd'') <= to_date(:endDate,''yyyy-MM-dd'') ';
   else
     v_endDate := '@#$&^%$#@!';
     v_sql_condition := v_sql_condition || ' and ( h.TRX_DATE  is null or to_char(h.TRX_DATE,''yyyy-MM-dd'') <>:endDate)';

  end if;

  v_sql_condition := v_sql_condition ||'  group by h.org_id,og.org_code,og.org_name';


-------------------------------------------------2.包裹按条件查询的语句，进行分页 开始------------------------------------------------------------
  if (orderfield is null) then
      v_sort := 'ORG_ID ';
  else
      v_sort := orderfield||' '||ordertype;
  end if;

 --select result
 v_sql := 'select row_number() over ( order by '||v_sort||') rnum,
    tt.ORG_ID,
    tt.ORG_CODE,
    tt.ORG_NAME,
    tt.deal_count,
    tt.avg_wait,
    tt.max_wait,
    tt.min_wait,
    tt.avg_deal,
    tt.max_deal,
    tt.min_deal
   from ('||v_sql_condition||') tt ';

   --select count
  v_sql_count := 'select count(1) from ('||v_sql||')';

------------------------------------------------------------3.判断是分页还是查询列表

   if pageno > 0  then
    v_sql_page := 'select * from ('||v_sql||') temp where temp.rnum >= :v_begin and temp.rnum <= :v_end';
     execute immediate v_sql_count into totalrows using v_orgid,v_startDate,v_endDate;
     OPEN p_cursor FOR v_sql_page using  v_orgid,v_startDate,v_endDate,v_begin,v_end;
  else
    totalrows:=0; --set default value
    v_sql_page := 'select * from ('||v_sql||') temp ';
    OPEN p_cursor FOR v_sql_page using  v_orgid,v_startDate,v_endDate;
  end if;

end proc_report_organalyse;
/

prompt
prompt Creating procedure PROC_SYSORGEXTEND_DELETE
prompt ===========================================
prompt
create or replace procedure iqms_new.proc_sysorgextend_delete (
orgId varchar2,

ReturnCode OUT varchar2)


is
  cursor v_device is select d.org_id v_orgId,d.device_no v_deviceNo from bsc_device d
  where  d.org_id = orgId;
  v_d v_device%rowtype;
  v_code varchar2(20);
begin

 delete from sys_org t where t.org_id = orgId;

 for v_d in v_device loop
        proc_bscdevice_remove(to_char(v_d.v_orgid),v_d.v_deviceno, v_code);

 end loop;
ReturnCode:='0';


end proc_sysorgextend_delete;
/

prompt
prompt Creating procedure PROC_SYSORG_QUERY
prompt ====================================
prompt
create or replace procedure iqms_new.proc_sysorg_query (
p_cursor out sys_refcursor)
as
   v_sql varchar2(4000);


begin


 --select result
 v_sql := 'select org_name,org_id from SYS_ORG ';
 OPEN p_cursor FOR v_sql ;


end proc_sysorg_query;
/

prompt
prompt Creating procedure PROC_TAKECONFIG_ADD
prompt ======================================
prompt
create or replace procedure iqms_new.proc_takeconfig_add
(
 v_styleId in number,
 v_StyleName in varchar2 ,
 v_def in number,
 v_styleType in varchar2,
 orgId in number,
 deviceNo in varchar2,
 ReturnCode out varchar2
)
is
 iRecCount INTEGER;
 defFlag INTEGER;
begin
  --查询是否有同名模板
  select count(1) into iRecCount from bc_takemodel b where b.stylename = v_StyleName and b.org_id= orgId and b.device_no=deviceNo;

  if iRecCount > 0 then
    ReturnCode :='2';
  else
     if v_def = 1 then  --当为默认模板时，其他将被修改为否
         update bc_takemodel b set b.def = 0 where b.org_id =orgId and b.device_no =deviceNo ;

         insert into bc_takemodel t (
                 STYLEID,
                 STYLENAME,
                 DEF,
                 STYLETYPE，
                 ORG_ID，
                 DEVICE_NO
             ) values (
                 SEQ_BCTAKEMODEL.NEXTVAL,
                 v_StyleName,
                 v_def,
                 v_styleType ，
                 orgId，
                 deviceNo
             );
             proc_deviceupdateflag(deviceNo,'0');
         ReturnCode:='0';
     else
         insert into bc_takemodel t (
                 STYLEID,
                 STYLENAME,
                 DEF,
                 STYLETYPE，
                 ORG_ID，
                 DEVICE_NO
             ) values (
                 SEQ_BCTAKEMODEL.NEXTVAL,
                 v_StyleName,
                 v_def,
                 v_styleType，
                 orgId，
                 deviceNo
             );
             proc_deviceupdateflag(deviceNo,'0');
         ReturnCode:='0';
     end if;
  end if;
   --异常处理
   -- exception
     --   when others then
       --  ReturnCode:='1'; --数据库异常

end proc_takeconfig_add;
/

prompt
prompt Creating procedure PROC_TAKECONFIG_BYDEVICE
prompt ===========================================
prompt
create or replace procedure iqms_new.proc_takeconfig_bydevice
(
 --v_styleId in  number,
 --v_screenResolution in  varchar2,
 --v_dateTypeId number,
 orgId number,
 deviceNo varchar2,
 p_cursor out sys_refcursor
)
is
   iRecCount INTEGER;
   i_sql varchar2(4000);
   --i_styleId varchar2(50) := v_styleId;
   --i_screenResolution varchar2(50) := v_screenResolution;
   --i_dateTypeId varchar2(50) := v_dateTypeId;
   i_orgid varchar2(50) := orgId;
   i_deviceNo varchar2(50) := deviceNo;
begin
--b.styleid =: v_styleId  and c.screenresolution= :v_screenResolution
 --     and c.datetypeid=: v_dateTypeId and
      i_sql := 'select c.stylevalue,c.styleid,c.datetypeid,
      c.screenresolution
      from bc_takemodel b
      inner join bc_modelStyle c on(b.styleid=c.styleid)
      where b.org_id=:orgId and b.device_no=: deviceNo';

      OPEN p_cursor FOR i_sql using i_orgid,i_deviceNo;

end proc_takeconfig_bydevice;
/

prompt
prompt Creating procedure PROC_TAKECONFIG_BYDEVICENO
prompt =============================================
prompt
create or replace procedure iqms_new.proc_takeconfig_bydeviceno
(
orgId varchar2,
deviceNo varchar2,
p_cursor out sys_refcursor
)
as
   v_sql varchar2(4000);
   v_orgid varchar2(50) := orgId;
   v_deviceNo varchar2(50) := deviceNo;
begin

       v_sql := 'select b.*,d.screen_resolution from bc_takemodel b
                 left join bsc_device d on (b.org_id = d.org_id and b.device_no = d.device_no)
                 where b.org_id =: v_orgid and b.device_no =: v_deviceNo order by b.STYLEID';
       OPEN p_cursor FOR v_sql using v_orgid,v_deviceNo;

end proc_takeconfig_bydeviceno;
/

prompt
prompt Creating procedure PROC_TAKECONFIG_COPY
prompt =======================================
prompt
CREATE OR REPLACE PROCEDURE iqms_new.proc_takeconfig_copy --应用到下级机构
(orgId      varchar2,
 deviceNo   varchar2,
 targetId   varchar2, --目标orgId
 targetNo   varchar2, --目标deviceNo
 ReturnCode OUT varchar2) AS
BEGIN
  if orgId != targetId or deviceNo != targetNo then
    --删除目标数据再插入
    delete from bc_takemodel b
     where b.org_id = targetId
       and b.device_no = targetNo;
    delete from bc_modelstyle b
     where b.org_id = targetId
       and b.device_no = targetNo;
    delete from bc_modelstyle_element b
     where b.org_id = targetId
       and b.device_no = targetNo;
    --插入
    insert into bc_takemodel
      (STYLEID, STYLENAME, DEF, STYLETYPE, ORG_ID, DEVICE_NO)
      select SEQ_BCTAKEMODEL.NEXTVAL,
             STYLENAME,
             DEF,
             STYLETYPE,
             targetId,
             targetNo

        from bc_takemodel w
       where w.org_id = orgId
         and w.device_no = deviceNo;

    insert into bc_modelStyle b
      (id,
       ORG_ID,
       DEVICE_NO,
       STYLE_ID,
       DATETYPE_ID,
       copy_status,
       SCREEN_RESOLUTION,
       dpi,
       dpi_x,
       dpi_y)

      select SEQ_MODELSTYLEID.NEXTVAL,
             targetId,
             targetNo,
             (select n.styleid
                from bc_takemodel n
                left join bc_takemodel n1
                  on (n.stylename = n1.stylename and n.def = n1.def and
                     n.styletype = n1.styletype)
               where n.device_no = targetNo
                 and n1.device_no = deviceNo
                 and n1.styleid = w.style_id),
             DATETYPE_ID,
             copy_status,
             SCREEN_RESOLUTION,
             dpi,
             dpi_x,
             dpi_y
        from bc_modelstyle w
       where w.org_id = orgId
         and w.device_no = deviceNo;

    insert into bc_modelstyle_element
      (model_style_id,
       org_id,
       device_no,
       buztype_id,
       element_type,
       org_type,
       element_x,
       element_y,
       element_width,
       element_height,
       element_family,
       element_style,
       element_backgroundcolor,
       element_fontcolor,
       element_size,
       element_icon,
       icon_position,
       element_borderradius,
       borderradiust_topleft1,
       borderradius_topright1,
       borderradius_bottomright1,
       borderradius_bottomleft1,
       borderradius_bottomleft2,
       borderradius_bottomright2,
       borderradius_topright2,
       borderradius_topleft2,
       element_shape,
       element_shadow,
       shadow_h,
       shadow_v,
       shadow_blur,
       element_skew,
       skew_h,
       skew_v,
       element_rotate,
       rotate_x,
       rotate_y,
       rotate_z,
       element_effect,
       effect_scrollamount,
       effect_direction,
       childrenpageimg,
       childrenpagecolor,
       backgroundimage,
       ELEMENT_TEXT)
      select (select n.id
                from bc_modelStyle n
                left join bc_modelStyle n1
                  on (n.datetype_id = n1.datetype_id and
                     n.copy_status = n1.copy_status and
                     n.screen_resolution = n1.screen_resolution and
                     n.dpi = n1.dpi and n.dpi_x = n1.dpi_x and
                     n.dpi_y = n1.dpi_y)
               where n.device_no = targetNo
                 and n1.device_no = deviceNo
                 and n1.id = w.model_style_id),
             targetId,
             targetNo,
             buztype_id,
             element_type,
             org_type,
             element_x,
             element_y,
             element_width,
             element_height,
             element_family,
             element_style,
             element_backgroundcolor,
             element_fontcolor,
             element_size,
             element_icon,
             icon_position,
             element_borderradius,
             borderradiust_topleft1,
             borderradius_topright1,
             borderradius_bottomright1,
             borderradius_bottomleft1,
             borderradius_bottomleft2,
             borderradius_bottomright2,
             borderradius_topright2,
             borderradius_topleft2,
             element_shape,
             element_shadow,
             shadow_h,
             shadow_v,
             shadow_blur,
             element_skew,
             skew_h,
             skew_v,
             element_rotate,
             rotate_x,
             rotate_y,
             rotate_z,
             element_effect,
             effect_scrollamount,
             effect_direction,
             childrenpageimg,
             childrenpagecolor,
             backgroundimage,
             ELEMENT_TEXT
        from bc_modelstyle_element w
       where w.org_id = orgId
         and w.device_no = deviceNo;
         commit;
         proc_deviceupdateflag(deviceNo,'0');
    ReturnCode := '0';
  end if;
  --异常处理
  -- exception
  --   when others then
  --  ReturnCode:='1'; --数据库异常
END proc_takeconfig_copy;
/

prompt
prompt Creating procedure PROC_TAKECONFIG_DELETE
prompt =========================================
prompt
create or replace procedure iqms_new.proc_takeconfig_delete
(
 v_styleId in  varchar2,
 ReturnCode  out varchar2
)
is

  ideviceNo varchar2(100);

begin

    --
  select t.device_no into ideviceNo from bc_takemodel t where t.styleid = v_styleId;

  -- 1、删除这些样式模板的界面元素
  delete from bc_modelstyle_element me where me.model_style_id in (select ms.id from bc_modelStyle ms where ms.style_id = v_styleId);


  -- 2. 删除样式表
  delete from bc_modelstyle ms where ms.style_id = v_styleId;


  --3、删除模板
  delete from bc_takemodel t where t.styleid = v_styleId;




   -- 更新设备更新标记
   proc_deviceupdateflag(ideviceNo,0);

  ReturnCode:='0';

   --异常处理
   -- exception
    --   when others then
     --  ReturnCode:='1'; --数据库异常
end proc_takeconfig_delete;
/

prompt
prompt Creating procedure PROC_TAKECONFIG_GETSTYLE
prompt ===========================================
prompt
create or replace procedure iqms_new.proc_takeconfig_getstyle
(
 v_styleId in  number,  -- 模板id
 v_screenResolution in  varchar2,  -- 分辨率
 v_dateTypeId number,  -- 日期类型
 orgId number,  -- 机构id
 deviceNo varchar2,  -- 设备编号
 p_cursor out sys_refcursor,  -- 界面元素列表
 modelstyleInfo_cursor out sys_refcursor  -- 取号界面基本信息
)
is
   iRecCount INTEGER;
   i_modelStyleid number;
begin

      -- 1、查询出bc_modelStyle表中记录id，通过记录id，找到界面配置的元素信息

      select count(1) into iRecCount from bc_modelStyle m
          where m.org_id = orgId
                and m.device_no = deviceNo
                and (m.datetype_id = v_dateTypeId or m.copy_status = 1)
                and m.style_id =  v_styleId
                and m.screen_resolution = v_screenResolution;

      -- 2.如果配置存在，获取取号界面的样式di
      if iRecCount > 0 then
         select m.id into i_modelStyleid  from bc_modelStyle m
         where m.org_id = orgId
         and m.device_no = deviceNo
         and (m.datetype_id = v_dateTypeId or m.copy_status = 1)
         and m.style_id =  v_styleId
         and m.screen_resolution = v_screenResolution;
         -- 3.通过id，查询界面元素配置
          OPEN p_cursor FOR select * from BC_MODELSTYLE_ELEMENT me where me.model_style_id =  i_modelStyleid;


      else
         -- 4.如果没有配置，那么久返回空
         OPEN p_cursor FOR select * from BC_MODELSTYLE_ELEMENT me where 1=2;
      end if;

      open modelstyleInfo_cursor for select t.styleid,t.stylename,t.styletype,ms.screen_resolution,ms.datetype_id,ms.copy_status, '1' stylePath from  bc_takemodel  t left join   bc_modelStyle ms on
                 (t.styleid = ms.style_id and ms.org_id = orgId and ms.device_no = deviceNo and (ms.datetype_id =v_dateTypeId or ms.copy_status = 1))
                 where t.styleid = v_styleId and ms.screen_resolution = v_screenResolution;

end proc_takeconfig_getstyle;
/

prompt
prompt Creating procedure PROC_TAKECONFIG_QUEUEELEMENT
prompt ===============================================
prompt
create or replace procedure iqms_new.proc_takeconfig_queueelement
(
v_modelStyleId in number,  -- 样式id
v_orgId in number,  -- 机构id
v_deviceNo in varchar2,  -- 设备编号
v_buzTypeId in varchar2,  -- 业务id
v_type in varchar2,    -- 元素雷星星
v_orgType in varchar2,   -- 控制元素z-index
v_x in number,      --x位置
v_y in number,      -- y位置
v_width in number,   -- 元素长度
v_height in number,  -- 元素高度
v_family in varchar2,  -- 字体
v_style in varchar2,  -- 字形
v_backgroundColor in varchar2,  --元素背景色
v_fontColor in varchar2,  -- 字体颜色
v_size in varchar2,  -- 字体大小
v_icon in varchar2,  -- 元素小图标
v_iconPosition in varchar2,  -- 元素小图标位置
v_borderRadius in varchar2,  -- 是否圆角
v_topLeft1 in number,  -- 圆角参数
v_topRight1 in number,  -- 圆角参数
v_bottomRight1 in number,  -- 圆角参数
v_bottomLeft1 in number,  -- 圆角参数
v_bottomLeft2 in number,  -- 圆角参数
v_bottomRight2 in number,  -- 圆角参数
v_topRight2 in number,  -- 圆角参数
v_topLeft2 in number,  -- 圆角参数
v_shape in varchar2,  -- 形状
v_shadow in varchar2,  -- 阴影
v_shadowH in number,  -- 水平阴影
v_shadowV in number,  -- 垂直阴影
v_shadowBlur in varchar2,  -- 阴影距离
v_skew in varchar2,  -- 倾斜
v_skewH in number,  -- 水平倾斜
v_skewV in number,  -- 垂直倾斜
v_rotate in varchar2,  -- 旋转
v_angleOfRotationX in number,  -- x轴旋转
v_angleOfRotationY in number,  -- y轴旋转
v_angleOfRotationZ in number,  -- z轴旋转
v_effect in varchar2,  -- 效果
v_scrollAmount in number,  -- 跑马灯速度
v_direction in varchar2,  -- 跑马灯方向
v_childrenPageImg in varchar2,  -- 子界面背景图
v_childrenPageColor in varchar2,  -- 子界面背景色
v_backgroundImage in varchar2,  -- 元素背景图片
v_text in varchar2,--文本内容
ReturnCode out varchar2
 )
is
 iRecCount INTEGER;
 iStyleModeId number default 0; --临时记录样式表的id，用于返回
begin



  insert into BC_MODELSTYLE_ELEMENT values (

          v_modelStyleId,
          v_orgId,
          v_deviceNo,
          v_buzTypeId,
          v_type,
          v_orgType,
          v_x,
          v_y,
          v_width,
          v_height,
          v_family,
          v_style,
          v_backgroundColor,
          v_fontColor,
          v_size,
          v_icon,
          v_iconPosition,
          v_borderRadius,
          v_topLeft1,
          v_topRight1,
          v_bottomRight1,
          v_bottomLeft1,
          v_bottomLeft2,
          v_bottomRight2,
          v_topRight2,
          v_topLeft2,
          v_shape,
          v_shadow,
          v_shadowH,
          v_shadowV,
          v_shadowBlur,
          v_skew,
          v_skewH,
          v_skewV,
          v_rotate,
          v_angleOfRotationX,
          v_angleOfRotationY,
          v_angleOfRotationZ,
          v_effect  ,
          v_scrollAmount,
          v_direction,
          v_childrenPageImg ,
          v_childrenPageColor,
          v_backgroundImage,
          v_text
  );



  ReturnCode:='0';

   --异常处理
   -- exception
     --   when others then
       --  ReturnCode:='1'; --数据库异常
end proc_takeconfig_queueelement;
/

prompt
prompt Creating procedure PROC_TAKECONFIG_SAVECONFIG
prompt =============================================
prompt
create or replace procedure iqms_new.proc_takeconfig_saveconfig
(
v_styleId in number,  -- 模板id
v_styleName in varchar2,  -- 模板名称
v_styleType in varchar2,  -- 模板类型
v_screenResolution in varchar2,  -- 样式分辨率
v_dateTypeId in varchar2,    -- 样式日期类型
v_copyStatus in varchar2,   -- 是否平日假日相同  1-相同   0- 不同
v_def in varchar2,      --是否默认模板
orgId in varchar2,      -- 机构编号
deviceNo in varchar2,   -- 设备编号
modeStyelId out varchar2,  -- 返回的bc_modelStyle的id
ReturnCode out varchar2
 )
is
 iRecCount INTEGER;
 iStyleModeId number default 0; --临时记录样式表的id，用于返回
begin

  -- 1、更新模板信息  这里面相当于编辑
  select count(1) into iRecCount from bc_takemodel b where b.stylename = v_StyleName and b.org_id= orgId and b.device_no=deviceNo and b.styleid <> v_styleId;

  if iRecCount > 0 then  -- 模板id存在名字相同
    ReturnCode :='2';
    return;
  else
     if v_def = 1 then  --当为默认模板时，其他将被修改为否
         update bc_takemodel b set b.def = 0 where b.org_id =orgId and b.device_no =deviceNo ;
     end if;
     update bc_takemodel b set b.def = v_def,b.stylename=v_styleName where b.org_id =orgId and b.device_no =deviceNo and b.styleid = v_styleId;
  end if;


  -- 保证bc_modelStyle一个分辨率只有，平日，假日两条记录 或者只有平日假日相同，这样的一条记录
  -- 如果保存的数据记录已经存在，就更新记录的是否相同状态，然后根据是否相同状态，如果是平日假日相同状态，就删除另一个日期的配置，
  -- 如果不是平日假日相同状态，就将另外一个平日假日相同状态改为另外一个日期类型

  select count(1) into iRecCount from bc_modelStyle c where c.org_id=orgId and c.device_no= deviceNo
           and c.STYLE_ID = v_styleId and c.DATETYPE_ID= v_dateTypeId and c.SCREEN_RESOLUTION=v_screenResolution;

  if iRecCount > 0 then    --日期类型存在

     select c.id into iStyleModeId  from bc_modelStyle c where c.org_id=orgId and c.device_no= deviceNo
           and c.STYLE_ID = v_styleId and c.DATETYPE_ID= v_dateTypeId and c.SCREEN_RESOLUTION=v_screenResolution;

      -- 更新
      update bc_modelStyle c set c.copy_status=v_copyStatus where c.id = iStyleModeId;

  else

      iStyleModeId:=SEQ_MODELSTYLEID.NEXTVAL;  --计算样式主键
      -- 新增样式记录
       insert into bc_modelStyle c (
            c.ID,
            c.ORG_ID,
            c.DEVICE_NO,
            c.STYLE_ID,
            c.DATETYPE_ID,
            c.COPY_STATUS,
            c.SCREEN_RESOLUTION,
            c.DPI,
            c.DPI_X,
            c.DPI_Y
         )values(
            iStyleModeId,
            orgId,
            deviceNo,
            v_styleId，
            v_dateTypeId，
            v_copyStatus，
            v_screenResolution,
            '100',
            0,
            0
         );
  end if;

  -- 返回样式的主键
  modeStyelId:=to_char(iStyleModeId);

  --删除当前日期类型的配置，代码中会进行重新保存
  delete from BC_MODELSTYLE_ELEMENT me where me.model_style_id = iStyleModeId;

  -- 判断是否是节日，假日相同(如果相同，则删除另一个日期的配置)
  if v_copyStatus = 1 then

       -- 查看另一个日期的配置是否存在
       select count(1) into iRecCount from bc_modelStyle c where c.org_id=orgId and c.device_no= deviceNo
           and c.STYLE_ID = v_styleId and c.DATETYPE_ID <> v_dateTypeId and c.SCREEN_RESOLUTION=v_screenResolution;


       if iRecCount > 0 then

          select c.id into iStyleModeId  from bc_modelStyle c where c.org_id=orgId and c.device_no= deviceNo
             and c.STYLE_ID = v_styleId and c.DATETYPE_ID <> v_dateTypeId and c.SCREEN_RESOLUTION=v_screenResolution;

          -- 删除另一个界面配置元素数据
          delete from BC_MODELSTYLE_ELEMENT me where me.model_style_id = iStyleModeId;

          --删除另一日期样式记录
          delete from bc_modelStyle c where c.id = iStyleModeId;
       end if;
  else

      -- 如果平日，假日不相同，那么找到 那个平日假日相同的记录，修改为平日假日不同，同时设置日期类型和当前保存类型相反
      update bc_modelStyle c set c.copy_status = 0 , c.datetype_id = (case when v_dateTypeId = 1 then 2 else 1  end)
      where c.org_id=orgId and c.device_no= deviceNo
             and c.STYLE_ID = v_styleId and c.copy_status = 1  and c.SCREEN_RESOLUTION=v_screenResolution;
  end if;

  ReturnCode:='0';
  proc_deviceupdateflag(deviceNo,'0');

   --异常处理
   -- exception
     --   when others then
       --  ReturnCode:='1'; --数据库异常
end proc_takeconfig_saveconfig;
/

prompt
prompt Creating procedure PROC_TAKEMODELNAV_ADD
prompt ========================================
prompt
create or replace procedure iqms_new.proc_takemodelnav_add
(
 v_StyleName in varchar2 ,
 v_def in number,
 orgId in number,
 deviceNo in varchar2,
 v_styleId out number,
 ReturnCode out varchar2
)
is
 iRecCount INTEGER;
 defFlag INTEGER;
 seqStyleId number;
begin
  --查询是否有同名模板
  select count(1) into iRecCount from bc_takemodel b where b.stylename = v_StyleName and b.org_id= orgId and b.device_no=deviceNo;

  if iRecCount > 0 then
    ReturnCode :='2';
  else
     if v_def = 1 then  --当为默认模板时，其他将被修改为否
         update bc_takemodel b set b.def = 0 where b.org_id =orgId and b.device_no =deviceNo ;
         proc_deviceupdateflag(deviceNo,'0');
     end if;


     seqStyleId := SEQ_BCTAKEMODEL.NEXTVAL;
     insert into bc_takemodel t (
             STYLEID,
             STYLENAME,
             DEF,
             STYLETYPE，
             ORG_ID，
             DEVICE_NO
         ) values (
             seqStyleId,
             v_StyleName,
             v_def,
             '3'，
             orgId，
             deviceNo
         );
     proc_deviceupdateflag(deviceNo,'0');
     v_styleId := seqStyleId;
     ReturnCode:='0';
  end if;
   --异常处理
   -- exception
     --   when others then
       --  ReturnCode:='1'; --数据库异常

end proc_takemodelnav_add;
/

prompt
prompt Creating procedure PROC_TAKEMODEL_ADD
prompt =====================================
prompt
create or replace procedure iqms_new.proc_takemodel_add
(
 v_styleId in number,
 v_StyleName in varchar2 ,
 v_def in number,
 v_styleType in varchar2,
 orgId in number,
 deviceNo in varchar2,
 ReturnCode out varchar2
)
is
 iRecCount INTEGER;
 defFlag INTEGER;
begin
  --查询是否有同名模板
  select count(1) into iRecCount from bc_takemodel b where b.stylename = v_StyleName and b.org_id= orgId and b.device_no=deviceNo;

  if iRecCount > 0 then
    ReturnCode :='2';
  else
     if v_def = 1 then  --当为默认模板时，其他将被修改为否
         update bc_takemodel b set b.def = 0 where b.org_id =orgId and b.device_no =deviceNo ;

         insert into bc_takemodel t (
                 STYLEID,
                 STYLENAME,
                 DEF,
                 STYLETYPE，
                 ORG_ID，
                 DEVICE_NO
             ) values (
                 SEQ_BCTAKEMODEL.NEXTVAL,
                 v_StyleName,
                 v_def,
                 v_styleType ，
                 orgId，
                 deviceNo
             );

         insert into bc_modelStyle b (
                 ORG_ID，
                 DEVICE_NO,
                 style_id
             ) values (
                 orgId，
                 deviceNo,
                 SEQ_BCTAKEMODEL.NEXTVAL -1
             );
             proc_deviceupdateflag(deviceNo,'0');
         ReturnCode:='0';
     else
         insert into bc_takemodel t (
                 STYLEID,
                 STYLENAME,
                 DEF,
                 STYLETYPE，
                 ORG_ID，
                 DEVICE_NO
             ) values (
                 SEQ_BCTAKEMODEL.NEXTVAL,
                 v_StyleName,
                 v_def,
                 v_styleType，
                 orgId，
                 deviceNo
             );

         insert into bc_modelStyle b (
                 ORG_ID，
                 DEVICE_NO,
                 STYLE_ID
             ) values (
                 orgId，
                 deviceNo,
                 SEQ_BCTAKEMODEL.NEXTVAL -1
             );
             proc_deviceupdateflag(deviceNo,'0');
         ReturnCode:='0';
     end if;
  end if;
   --异常处理
   -- exception
     --   when others then
       --  ReturnCode:='1'; --数据库异常

end proc_takemodel_add;
/

prompt
prompt Creating procedure PROC_TAKEMODEL_BYDEVICENO
prompt ============================================
prompt
create or replace procedure iqms_new.proc_takemodel_bydeviceno
(
orgId varchar2,
deviceNo varchar2,
p_cursor out sys_refcursor
)
as
   v_sql varchar2(4000);
   v_orgid varchar2(50) := orgId;
   v_deviceNo varchar2(50) := deviceNo;
begin

       v_sql := 'select * from bc_takemodel b where b.org_id =: v_orgid and b.device_no =: v_deviceNo order by b.STYLEID';
       OPEN p_cursor FOR v_sql using v_orgid,v_deviceNo;

end proc_takemodel_bydeviceno;
/

prompt
prompt Creating procedure PROC_TAKEMODEL_DELETE
prompt ========================================
prompt
create or replace procedure iqms_new.proc_takemodel_delete
(
 v_styleId in  varchar2,
 ReturnCode  out varchar2
)
is
v_deviceNo  varchar2(50);
begin

  delete from bc_takemodel b where b.styleid = v_styleId ;
  delete from bc_modelStyle b where b.style_id = v_styleId ;

  select b.device_no into v_deviceNo from bc_takemodel b;
  proc_deviceupdateflag(v_deviceNo,'0');
  ReturnCode:='0';

   --异常处理
   -- exception
    --   when others then
     --  ReturnCode:='1'; --数据库异常
end proc_takemodel_delete;
/

prompt
prompt Creating procedure PROC_TAKEMODEL_GETSTYLE
prompt ==========================================
prompt
create or replace procedure iqms_new.proc_takemodel_getstyle
(
 v_styleId in  number,
 v_screenResolution in  varchar2,
 v_dateTypeId number,
 orgId number,
 deviceNo varchar2,
 p_cursor out sys_refcursor
)
is
   iRecCount INTEGER;
   i_sql varchar2(4000);
   i_styleId varchar2(50) := v_styleId;
   i_screenResolution varchar2(50) := v_screenResolution;
   i_dateTypeId varchar2(50) := v_dateTypeId;
   i_orgid varchar2(50) := orgId;
   i_deviceNo varchar2(50) := deviceNo;
begin

      i_sql := 'select c.stylevalue from bc_takemodel b
      inner join bc_modelStyle c on(b.styleid=c.styleid)
      where b.styleid =: v_styleId  and c.screenresolution= :v_screenResolution
      and c.datetypeid=: v_dateTypeId and b.org_id=:orgId and b.device_no=: deviceNo';

      OPEN p_cursor FOR i_sql using i_styleId,i_screenResolution,i_dateTypeId,i_orgid,i_deviceNo;

end proc_takemodel_getstyle;
/
prompt
prompt Creating procedure proc_DEVUPGRADEPROCESS_addall
prompt ==========================================
prompt
CREATE OR REPLACE PROCEDURE proc_DEVUPGRADEPROCESS_addall
(
 patchId varchar2,
 ReturnCode OUT varchar2
)
AS

patchName varchar2(100);
dbFlag varchar2(2);
cursor v_deviceNo is
select d.device_no from bsc_device d;
v_no v_deviceNo%rowtype;
BEGIN


 

 -- 查询版本的名称和是否包含数据(dbFlag  1-有数据库   0-没有数据)
 select v.patch_name,v.db_flag into patchName,dbFlag from bc_patchversion v where v.id = patchId;
 for v_no in v_deviceNo loop
    --插入
   insert into BSC_DEVUPGRADE_PROCESS (
      id,
      device_no,
      patch_id,
      optDate,
      status
   ) values (
     SEQ_UPGRADEPROCESS.NEXTVAL,
     v_no.device_no,
     patchId,
     sysdate,
      '0' --是否已经下发成功
   );
  end loop;
   

   -- 将信息更新到设备表中
   update bsc_device d set d.last_ver=patchId,d.last_vername=patchName,d.extend1 = dbFlag ;

   ReturnCode:='0';

 --异常处理
 -- exception
   --   when others then
     --  ReturnCode:='1'; --数据库异常
END proc_DEVUPGRADEPROCESS_addall;
/


prompt
prompt Creating procedure PROC_TAKEMODEL_SAVECONFIG
prompt ============================================
prompt
create or replace procedure iqms_new.proc_takemodel_saveconfig
(
v_styleId in number,
v_styleName in varchar2,
v_styleType in varchar2,
v_screenResolution in varchar2,
v_dateTypeId in varchar2,
--v_styleValue in varchar2,
v_def in varchar2,
orgId in varchar2,
deviceNo in varchar2,
ReturnCode out varchar2
 )
is
 iRecCount INTEGER;
 def_flag INTEGER;
 iStyleName varchar2(50);
 iStyleValue INTEGER;
begin
   --查询指定id的名称
   select b.stylename into iStyleName from bc_takemodel b where b.styleid = v_styleId and b.org_id= orgId and b.device_no=deviceNo;

   if iStyleName = v_styleName then  --名称没有改变时
       if v_def = 1 then --当为默认模板时，其他将被修改为否
           update bc_takemodel b set b.def = 0 where b.org_id =orgId and b.device_no =deviceNo ;

           update bc_takemodel b set
                 b.stylename = v_styleName,
                 b.def = v_def
           where b.styleid = v_styleId ;

           --查询表中是否已有该样式，若有则做更新操作，如无则做新增操作
           select count(1) into iStyleValue from bc_modelStyle c where c.org_id=orgId and c.device_no= deviceNo
           and c.STYLE_ID = v_styleId and c.datetype_id= v_dateTypeId and c.screen_resolution=v_screenResolution ;

           if iStyleValue >0 then
               update bc_modelStyle c set
                      c.DATETYPE_ID = v_dateTypeId,
                      --c.STYLEVALUE = v_styleValue,
                      c.SCREEN_RESOLUTION = v_screenResolution
               where c.ORG_ID = orgId and c.DEVICE_NO = deviceNo and c.STYLE_ID = v_styleId
               and c.datetype_id= v_dateTypeId and c.screen_resolution=v_screenResolution;
           else
               insert into bc_modelStyle c (
                  c.ORG_ID,
                  c.DEVICE_NO,
                  c.STYLE_ID,
                  c.DATETYPE_ID,
                  --c.STYLEVALUE,
                  c.SCREEN_RESOLUTION
               )values(
                  orgId,
                  deviceNo,
                  v_styleId，
                  v_dateTypeId，
                  --v_styleValue，
                  v_screenResolution
               );
           end if;
           ReturnCode:='0';
     else
           update bc_takemodel b set
                   b.stylename = v_styleName,
                   b.def = v_def
           where b.styleid = v_styleId ;

           select count(1) into iStyleValue from bc_modelStyle c where c.org_id=orgId and c.device_no= deviceNo
           and c.STYLE_ID = v_styleId and c.datetype_id= v_dateTypeId and c.screen_resolution=v_screenResolution ;

           if iStyleValue >0 then
                 update bc_modelStyle c set
                        c.DATETYPE_ID = v_dateTypeId,
                        --c.STYLEVALUE = v_styleValue,
                        c.SCREEN_RESOLUTION = v_screenResolution
                 where c.ORG_ID = orgId and c.DEVICE_NO = deviceNo and c.STYLE_ID = v_styleId
                 and c.datetype_id= v_dateTypeId and c.screen_resolution=v_screenResolution;
           else
                 insert into bc_modelStyle c (
                    c.ORG_ID,
                    c.DEVICE_NO,
                    c.STYLE_ID,
                    c.DATETYPE_ID,
                   -- c.STYLEVALUE,
                    c.SCREEN_RESOLUTION
                 )values(
                    orgId,
                    deviceNo,
                    v_styleId，
                    v_dateTypeId，
                  --  v_styleValue，
                    v_screenResolution
                 );
           end if;
           ReturnCode:='0';
     end if ;
   else      --名称改变时
       select count(1) into iRecCount from bc_takemodel b where b.stylename = v_styleName and b.org_id= orgId and b.device_no=deviceNo;
       if iRecCount > 0 then
           ReturnCode:='2';
       else
           if v_def = 1 then --当为默认模板时，其他将被修改为否
               update bc_takemodel b set b.def = 0 where b.org_id =orgId and b.device_no =deviceNo ;

               update bc_takemodel b set
                     b.stylename = v_styleName,
                     b.def = v_def
               where b.styleid = v_styleId ;

               --查询表中是否已有该样式，若有则做更新操作，如无则做新增操作
               select count(1) into iStyleValue from bc_modelStyle c where c.org_id=orgId and c.device_no= deviceNo
               and c.STYLE_ID = v_styleId and c.datetype_id= v_dateTypeId and c.screen_resolution=v_screenResolution ;

               if iStyleValue >0 then
                   update bc_modelStyle c set
                          c.DATETYPE_ID = v_dateTypeId,
                         -- c.STYLEVALUE = v_styleValue,
                          c.SCREEN_RESOLUTION = v_screenResolution
                   where c.ORG_ID = orgId and c.DEVICE_NO = deviceNo and c.STYLE_ID = v_styleId
                   and c.datetype_id= v_dateTypeId and c.screen_resolution=v_screenResolution;
               else
                   insert into bc_modelStyle c (
                      c.ORG_ID,
                      c.DEVICE_NO,
                      c.STYLE_ID,
                      c.DATETYPE_ID,
                      --c.STYLEVALUE,
                      c.SCREEN_RESOLUTION
                   )values(
                      orgId,
                      deviceNo,
                      v_styleId，
                      v_dateTypeId，
                     -- v_styleValue，
                      v_screenResolution
                   );
               end if;
               ReturnCode:='0';
          else
               update bc_takemodel b set
                       b.stylename = v_styleName,
                       b.def = v_def
               where b.styleid = v_styleId ;

               select count(1) into iStyleValue from bc_modelStyle c where c.org_id=orgId and c.device_no= deviceNo
               and c.STYLE_ID = v_styleId and c.datetype_id= v_dateTypeId and c.screen_resolution=v_screenResolution ;

               if iStyleValue >0 then
                     update bc_modelStyle c set
                            c.DATETYPE_ID = v_dateTypeId,
                            --c.STYLEVALUE = v_styleValue,
                            c.SCREEN_RESOLUTION = v_screenResolution
                     where c.ORG_ID = orgId and c.DEVICE_NO = deviceNo and c.STYLE_ID = v_styleId
                     and c.datetype_id= v_dateTypeId and c.screen_resolution=v_screenResolution;
               else
                     insert into bc_modelStyle c (
                        c.ORG_ID,
                        c.DEVICE_NO,
                        c.STYLE_ID,
                        c.DATETYPE_ID,
                        --c.STYLEVALUE,
                        c.SCREEN_RESOLUTION
                     )values(
                        orgId,
                        deviceNo,
                        v_styleId，
                        v_dateTypeId，
                        --v_styleValue，
                        v_screenResolution
                     );
               end if;
               ReturnCode:='0';
          end if ;
       end if ;
   end if ;

   --异常处理
   -- exception
     --   when others then
       --  ReturnCode:='1'; --数据库异常
end proc_takemodel_saveconfig;
/

prompt
prompt Creating procedure PROC_TELLERSYNC
prompt ==================================
prompt
CREATE OR REPLACE PROCEDURE iqms_new.proc_tellersync
(
 orgId varchar2,
 workId varchar2,
 tellerName varchar2 ,
 tellerSex varchar2 ,
 tellerStatus varchar2 ,
 callerPwd varchar2,
 ReturnCode OUT varchar2
)
AS
iRecCount INTEGER;
BEGIN

 --查询柜员是否存在
 select count(1) into iRecCount from bc_teller t where t.work_id  = workId;

 if iRecCount > 0 then -- 柜员存在（更新柜员）
    update bc_teller t set t.org_id = orgId,t.caller_pwd=callerPwd,t.name_=tellerName,t.sex=tellerSex,t.status='1' where t.work_id = workId;
    ReturnCode:='0';
 else
   --插入
   insert into bc_teller t (
      WORK_ID,
      ORG_ID,
      CALLER_PWD,
      NAME_,
      SEX,
      STATUS
   ) values (
     workId,
     orgId,
     callerPwd,
     tellerName,
     tellerSex,
     '1'
   );
   ReturnCode:='0';
 end if;
 --异常处理
 -- exception
   --   when others then
     --  ReturnCode:='1'; --数据库异常
END proc_tellersync;
/

prompt
prompt Creating procedure PROC_TELLERS_QUERY
prompt =====================================
prompt
create or replace procedure iqms_new.proc_tellers_query (
orgId varchar2,

p_cursor out sys_refcursor)
as
   v_sql varchar2(4000);


begin


 --bc_teller 生成tellers.json
 v_sql := 'select b.work_id, b.caller_pwd,
b.name_,case b.sex when ''0'' then ''1''
else ''0'' end sex,
''inserted'' saveStatus
from
bc_teller b
where b.org_id =:orgId  ';
 OPEN p_cursor FOR v_sql using orgId;




end proc_tellers_query;
/

prompt
prompt Creating procedure PROC_TICKETFORM_ADD
prompt ======================================
prompt
create or replace procedure iqms_new.proc_ticketform_add
(
 tktTmpId varchar2,
 tktTmpName  varchar2,
 v_def  number,
 tktFormatId  varchar2,
 v_tktFormat  varchar2,
 v_orgId varchar2,
 v_deviceNo varchar2,
 ReturnCode OUT varchar2
)
is
 iRecCount INTEGER;
 defFlag INTEGER;

begin
   --查询要增加的记录是否存在
   select count(1) into iRecCount from bc_ticketform b where b.tkttmp_name = tktTmpName
   and b.device_no = v_deviceNo;

   if iRecCount > 0 then
     ReturnCode:='2'; --该号码模板已经存在
     return;
   end if;

   -- 新增的模板是默认模板，更新此网点，此设备的其他模板为不是默认模板
   if v_def = 1 then
       update bc_ticketform b set b.def = 0 where b.org_id = v_orgId and b.device_no = v_deviceNo;
    end if;

   -- 增加数据
     insert into bc_ticketform t (
         TKTTMP_ID,
         TKTTMP_NAME,
         DEF,
         TKTFORMAT_ID,
         TKTFORMAT,
         TKTTMP_STYLE,
         org_id,
         device_no
     ) values (
         SEQ_BCTICKETFORM.NEXTVAL,
         tktTmpName,
         v_def,
         tktFormatId,
         v_tktFormat,
         null,
         v_orgId,
         v_deviceNo
     );
     --如是默认 模板 择 客户等级 未绑定模板的绑定
    if v_def = 1 then
       update bsc_cust_level c set
       c.ticket_template = (select t.tkttmp_id from bc_ticketform t
       where t.org_id = v_orgId
       and t.device_no = v_deviceNo)
       where c.org_id = v_orgId and c.device_no = v_deviceNo
       and (c.ticket_template is null or c.ticket_template ='0');
    end if;
     ReturnCode:='0';


   --异常处理
   -- exception
     --   when others then
       --  ReturnCode:='1'; --数据库异常

end proc_ticketform_add;
/

prompt
prompt Creating procedure PROC_TICKETFORM_DELETE
prompt =========================================
prompt
create or replace procedure iqms_new.proc_ticketform_delete
(
 tktTmpId in varchar2,
 v_orgId varchar2,
 v_deviceNo varchar2,
 ReturnCode out varchar2
)
is
v_def number;
iRecCount INTEGER;
begin
  --查询是否为默认模板
  select b.def into v_def from bc_ticketform b where b.tkttmp_id = tktTmpId;
  if v_def=1 then
    ReturnCode:='1';--默认不可删
   return;
   end if;

   delete from bc_ticketform b where b.tkttmp_id = tktTmpId ;
   --给绑定删除模板的客户等级绑定默认模板，无默认则不绑定
   update bsc_cust_level c set c.ticket_template = (select b.tkttmp_id from bc_ticketform b
   where b.device_no = v_deviceNo and b.def = 1) where c.ticket_template = tktTmpId;




   ReturnCode:='0';

   --异常处理
   -- exception
    --   when others then
     --  ReturnCode:='1'; --数据库异常
end proc_ticketform_delete;
/

prompt
prompt Creating procedure PROC_TICKETFORM_NAVSAVE
prompt ==========================================
prompt
create or replace procedure iqms_new.proc_ticketform_navsave
(
 tktTmpId varchar2,
 tktTmpName  varchar2,
 v_def  number,
 tktFormatId  varchar2,
 v_tktFormat  varchar2,
 v_tktTmpStyle  varchar2,
 v_orgId varchar2,
 v_deviceNo varchar2,
 v_tktTmpIdRet OUT varchar2,
 ReturnCode OUT varchar2
)
is
 iRecCount INTEGER;
 v_tktTmpId INTEGER;
begin
  --1、查询要增加的记录是否存在
  if tktTmpId is null then
   select count(1) into iRecCount from bc_ticketform b where b.tkttmp_name = tktTmpName
   and b.device_no = v_deviceNo;
  else
     select count(1) into iRecCount from bc_ticketform b where b.tkttmp_name = tktTmpName and b.tkttmp_id <> tktTmpId
   and b.device_no = v_deviceNo;

  end if;

   if iRecCount > 0 then
     ReturnCode:='2'; --该号码模板已经存在
     return;
   end if;


   -- 设置所有模板为非默认模板
   update bc_ticketform b set b.def = 0 where b.org_id = v_orgId and b.device_no = v_deviceNo;


  -- 2、增加模板
  if tktTmpId is null then   --  增加模板
     v_tktTmpId := SEQ_BCTICKETFORM.NEXTVAL;  -- 模板不存在就生成一个模板id
     insert into bc_ticketform t (
         TKTTMP_ID,
         TKTTMP_NAME,
         DEF,
         TKTFORMAT_ID,
         TKTFORMAT,
         TKTTMP_STYLE,
         org_id,
         device_no
     ) values (
         v_tktTmpId,
         tktTmpName,
         1,
         tktFormatId,
         v_tktFormat,
         v_tktTmpStyle,
         v_orgId,
         v_deviceNo
     );
  else  -- 更新模板
     v_tktTmpId := tktTmpId;
     update bc_ticketform b set
                   b.tkttmp_name = tktTmpName,
                   b.def = 1,
                   b.tktformat_id = tktFormatId,
                   b.tktformat = v_tktFormat,
                   b.tkttmp_style = v_tktTmpStyle
             where b.tkttmp_id = tktTmpId ;
  end if;

  v_tktTmpIdRet := v_tktTmpId;

    -- 客户等级 未绑定模板的绑定
   update bsc_cust_level c set
     c.ticket_template = v_tktTmpId
     where c.org_id = v_orgId and c.device_no = v_deviceNo
     and c.ticket_template is null;

   ReturnCode:='0';

   proc_deviceupdateflag(v_deviceNo,'0');


   --异常处理
   -- exception
     --   when others then
       --  ReturnCode:='1'; --数据库异常
end proc_ticketform_navsave;
/

prompt
prompt Creating procedure PROC_TICKETFORM_SAVE
prompt =======================================
prompt
create or replace procedure iqms_new.proc_ticketform_save
(
 tktTmpId varchar2,
 tktTmpName  varchar2,
 v_def  number,
 tktFormatId  varchar2,
 v_tktFormat  varchar2,
 v_tktTmpStyle  varchar2,
 v_orgId varchar2,
 v_deviceNo varchar2,
 ReturnCode OUT varchar2
)
is
 iRecCount INTEGER;
 def_flag INTEGER;
 v_tktTmpName varchar2(50);
begin

   -- 查模板名称重复
  select count(1) into iRecCount  from bc_ticketform b where b.org_id = v_orgId and b.device_no = v_deviceNo and  b.tkttmp_name =  tktTmpName and  b.tkttmp_id <> tktTmpId ;
  if iRecCount > 0 then
     ReturnCode:='2';
     return ;
  end if;

  -- 如果此记录时默认模板，更新设备下的所有模板为非默认模板
  if v_def = 1 then

     update bc_ticketform b set b.def = 0 where b.org_id = v_orgId and b.device_no = v_deviceNo;

     update bsc_cust_level c set
       c.ticket_template = tktTmpId
       where c.org_id = v_orgId and c.device_no = v_deviceNo
       and (c.ticket_template is null or c.ticket_template ='');

  end if;

  -- 更新号票模板记录
  update bc_ticketform b set
                   b.tkttmp_name = tktTmpName,
                   b.def = v_def,
                   b.tktformat_id = tktFormatId,
                   b.tktformat = v_tktFormat,
                   b.tkttmp_style = v_tktTmpStyle
             where b.tkttmp_id = tktTmpId ;


   ReturnCode:='0';

   proc_deviceupdateflag(v_deviceNo,'0');


   --异常处理
   -- exception
     --   when others then
       --  ReturnCode:='1'; --数据库异常
end proc_ticketform_save;
/

prompt
prompt Creating procedure PROC_TICKETFORM_UPDATE
prompt =========================================
prompt
CREATE OR REPLACE PROCEDURE iqms_new.proc_ticketform_update
(
 tktTmpId varchar2,
 tktTmpName  varchar2,
 v_def  number,
 tktFormatId  varchar2,
 v_tktFormat  varchar2,
 v_orgId varchar2,
 v_deviceNo varchar2,
 ReturnCode OUT varchar2
)
AS
 iRecCount INTEGER;
 def_flag INTEGER;
 v_tktTmpName varchar2(50);
BEGIN

  -- 查模板名称重复
  select count(1) into iRecCount  from bc_ticketform b where b.org_id = v_orgId and b.device_no = v_deviceNo and  b.tkttmp_name =  tktTmpName and  b.tkttmp_id <> tktTmpId ;
  if iRecCount > 0 then
     ReturnCode:='2';
     return ;
  end if;

  -- 如果此记录时默认模板，更新设备下的所有模板为非默认模板
  if v_def = 1 then

     update bc_ticketform b set b.def = 0 where b.org_id = v_orgId and b.device_no = v_deviceNo;

     update bsc_cust_level c set
       c.ticket_template = tktTmpId
       where c.org_id = v_orgId and c.device_no = v_deviceNo
       and (c.ticket_template is null or c.ticket_template ='');

  end if;

  -- 更新号票模板记录
  update bc_ticketform b set
                   b.tkttmp_name = tktTmpName,
                   b.def = v_def,
                   b.tktformat_id = tktFormatId,
                   b.tktformat = v_tktFormat
                   -- b.tkttmp_style = null
             where b.tkttmp_id = tktTmpId ;

   proc_deviceupdateflag(v_deviceNo,'0');
   ReturnCode:='0';

   --异常处理
   -- exception
     --   when others then
       --  ReturnCode:='1'; --数据库异常
END proc_ticketform_update;
/

prompt
prompt Creating procedure PROC_TICKET_COPY
prompt ===================================
prompt
CREATE OR REPLACE PROCEDURE iqms_new.proc_ticket_copy--应用到下级机构
(
 orgId varchar2,
 deviceNo varchar2,
 targetId varchar2,--目标orgId
 targetNo varchar2, --目标deviceNo
 ReturnCode OUT varchar2
)
AS
BEGIN
 if orgId != targetId or deviceNo != targetNo then
 --删除目标数据再插入
 delete from BC_TICKETFORM b where b.org_id = targetId and b.device_no = targetNo;

   --插入
   insert into BC_TICKETFORM (
      ORG_ID,
      DEVICE_NO,
      TKTTMP_ID,
      TKTTMP_NAME,
      DEF,
      TKTFORMAT_ID,
      TKTFORMAT,
      TKTTMP_STYLE
   ) select
     targetId,
     targetNo,
     SEQ_BCTICKETFORM.NEXTVAL,
     TKTTMP_NAME,
     DEF,
     w.tktformat_id,
     TKTFORMAT,
     TKTTMP_STYLE

    from BC_TICKETFORM w where w.org_id = orgId and w.device_no=deviceNo;
    proc_deviceupdateflag(deviceNo,'0');

   ReturnCode:='0';
end if;
 --异常处理
 -- exception
   --   when others then
     --  ReturnCode:='1'; --数据库异常
END proc_ticket_copy;
/

prompt
prompt Creating procedure PROC_TKTFORMATS_QUERY
prompt ========================================
prompt
create or replace procedure iqms_new.proc_tktFormats_query (--号票配置 业务下载
orgId varchar2,
deviceNo varchar2,
p_cursor out sys_refcursor)
as
   v_sql varchar2(4000);


begin


 --查询bsc_win_config 生成counters.json
 v_sql := 'select t.tkttmp_id    tktTmpId,
       t.tkttmp_name  tktTmpName,
       t.def,
       t.tktformat_id tktFormatId,
       n.tktformat    tktFormat,
       t.tkttmp_style print
  from bc_ticketform t
  left join bc_numberform n
    on (t.tktformat_id = n.tktformat_id)
 where t.org_id =:orgId and t.device_no =:deviceNo ';
 OPEN p_cursor FOR v_sql using orgId,deviceNo;




end proc_tktFormats_query;
/

prompt
prompt Creating procedure PROC_TREE_DEVICEPATCH
prompt ========================================
prompt
create or replace procedure iqms_new.proc_tree_devicepatch (
orgId in varchar2,  -- 机构id
patchId in number, --版本编号
p_cursor out sys_refcursor)
as
   v_sql varchar2(4000);
   v_orgId varchar2(20) :=orgId;
   v_patchId number:=patchId;

begin


  ---------------------------------------------------------1.按条件查询数据 start------------------------------------------------------------------

  v_sql := 'select * from ( select to_char(o.org_id) id,'''' device_No,to_char(o.parent_id) p_id,o.org_name dev_Name ,'''' is_Dev,
                               -1 currt_Ver, -1 last_Ver, '''' currt_Name, '''' last_Name from sys_org o
                         union all
                        select ''D''||d.device_no id,
                           d.device_no device_No,
                           to_char(d.org_id) p_id,
                           case when d.producer is not null then ''【''||d.producer || ''】'' || d.host_name else ''【null】''||d.host_name end dev_Name,
                           ''1'' is_Dev,
                           d.currt_ver currt_Ver,
                           d.last_ver last_Ver,
                           d.currt_vername currt_Name,
                           d.last_vername last_Name
                      from bsc_device d where  (d.last_ver is null or d.last_ver < '||v_patchId||' )) tmp start with  tmp.id = '''||v_orgId||''' connect by prior tmp.id = tmp.p_id';


    OPEN p_cursor FOR v_sql;

end proc_tree_devicepatch;
/

prompt
prompt Creating procedure PROC_TREE_FASTCOPY
prompt =====================================
prompt
create or replace procedure iqms_new.proc_tree_fastcopy (
orgId in varchar2,  -- 机构id
deviceNo in varchar2,
p_cursor out sys_refcursor)
as
   v_sql varchar2(4000);
   v_orgId varchar2(20) :=orgId;
   v_deviceno varchar2(20) :=deviceNo;
   v_screen varchar2(20);
begin

select d.screen_resolution into v_screen from bsc_device d where d.device_no = deviceNo;
  ---------------------------------------------------------1.按条件查询数据 start------------------------------------------------------------------

  v_sql := 'select * from view_devtree t where t.deviceno is null or (t.screen = '''||v_screen||'''
  and t.DEVICENO is not null and t.deviceno <> '''||v_deviceno||''')
  start with t.id='''||v_orgId||'''
  connect by prior t.id = t.pid
   ';


    OPEN p_cursor FOR v_sql;

end proc_tree_fastcopy;
/

prompt
prompt Creating procedure PROC_TREE_FORTICKET
prompt ======================================
prompt
create or replace procedure iqms_new.proc_tree_forticket (
orgId in varchar2,  -- 机构id

p_cursor out sys_refcursor)
as
   v_sql varchar2(4000);
   v_orgId varchar2(20) :=orgId;

begin


  ---------------------------------------------------------1.按条件查询数据 start------------------------------------------------------------------

  v_sql := 'select * from view_tickettree t
  start with t.id='''||v_orgId||'''
  connect by prior t.id = t.pid';


    OPEN p_cursor FOR v_sql;

end proc_tree_forticket;
/

prompt
prompt Creating procedure PROC_TREE_MENU_BUSINESS
prompt ==========================================
prompt
create or replace procedure iqms_new.proc_tree_menu_business (--网点业务 以菜单和业务为根节点的 组织树

p_cursor out sys_refcursor)
as
   v_sql varchar2(4000);


begin


  ---------------------------------------------------------1.按条件查询数据 start------------------------------------------------------------------
  v_sql := 'select * from ( select m.menu_id tree_id,''p1'' tree_pid,m.menu_name branch_name,m.menu_enname branchEname  from bc_menu m
                         union all
                        select b.business_id tree_id,

                           ''p2'' tree_pid,

                           b.business_name branch_name,
                           b.business_ename branchEname
                      from bc_businessmanage b ) tmp order by tmp.tree_id';



    OPEN p_cursor FOR v_sql ;

end proc_tree_menu_business;
/

prompt
prompt Creating procedure PROC_TREE_ORGDEVICE
prompt ======================================
prompt
create or replace procedure iqms_new.proc_tree_orgdevice (
orgId in varchar2,  -- 机构id

p_cursor out sys_refcursor)
as
   v_sql varchar2(4000);
   v_orgId varchar2(20) :=orgId;

begin


  ---------------------------------------------------------1.按条件查询数据 start------------------------------------------------------------------

  v_sql := 'select * from view_devtree t
  start with t.id='''||v_orgId||'''
  connect by prior t.id = t.pid';


    OPEN p_cursor FOR v_sql;

end proc_tree_orgdevice;
/

prompt
prompt Creating procedure PROC_TRXTODAY_BUS
prompt ====================================
prompt
create or replace procedure iqms_new.proc_trxtoday_bus(orgId    varchar2, --机构id
                                              p_cursor out sys_refcursor) as
  v_sql   varchar2(4000);
  v_orgId varchar2(50) := orgId;
begin

  ---------------------------------------------------------1.按条件查询数据 start------------------------------------------------------------------
if v_orgId = '0' then
  v_orgId := '1';
  end if;
  v_sql := 'select

       t.bus_id,
       b.business_name,
       count(1) busCount
  from trx_today t inner join  (select *
                 from sys_org o
                where o.deleted = 0
                start with o.org_id =:orgId
               connect by prior o.org_id = o.parent_id) s on (t.org_id = s.org_id)
  left join bc_businessmanage b
    on (t.bus_id = b.business_id)
    where to_char(t.trx_date, ''yyyy/mm/dd'') = to_char(sysdate,''yyyy/mm/dd'')
    group by t.bus_id,b.business_name order by busCount desc';

  --if v_orgId != 0 then
    --v_sql := v_sql ||
            -- '  where t.bus_id is not null and t.org_id =:orgId
            -- and to_char(t.trx_date, ''yyyy/mm/dd'') = to_char(sysdate,''yyyy/mm/dd'')
            -- group by t.bus_id,b.business_name order by busCount desc';

  --else
    --v_orgId := 0;
    --v_sql   := v_sql ||
               --' where t.bus_id is not null and t.org_id is null or t.org_id<>:orgId
               --and to_char(t.trx_date, ''yyyy/mm/dd'') = to_char(sysdate,''yyyy/mm/dd'')
              -- group by t.bus_id,b.business_name order by busCount desc';

 -- end if;
  -- dbms_output.put_line(v_sql);
  OPEN p_cursor FOR v_sql
    using v_orgId;

end proc_trxtoday_bus;
/

prompt
prompt Creating procedure PROC_TRXTODAY_PAGE
prompt =====================================
prompt
create or replace procedure iqms_new.proc_trxtoday_page (
orgId varchar2, --机构id

orderfield in varchar2,
ordertype in varchar2,
pagesize in number, pageno in number,totalrows out number,p_cursor out sys_refcursor)
as
   v_sql varchar2(4000);
   v_sql_page varchar2(4000);
   v_sql_condition varchar2(4000);
   v_sql_count varchar2(4000);
   v_begin number := (pageno-1)*pagesize+1;
   v_end number := pageno*pagesize;
   v_sort varchar2(50);
   v_orgId varchar2(50) := orgId;

begin
---------------------------------------------------------1.按条件查询数据 start------------------------------------------------------------------
--if v_orgId = '0' then
  --v_orgId := '1';
  --end if;
  v_sql_condition := 'select h.org_id,
       h.rowId rid,
       h.device_no,
       h.trx_date,
       h.flow_no,
       h.bus_id,
       h.bus_type,
       h.cust_type,
       h.pdj_level,
       h.ticket_type,
       h.ticket_no,
       h.cust_id,
       h.card_type,
       h.card_no,
       h.manager_no,
       h.trx_type,
       h.trx_status,
       h.print_time,
       h.call_time,
       h.begin_time,
       h.end_time,
       h.app_value,
       h.win_no,
       h.teller_no,
       h.recall_count,
       h.pause_begintime,
       h.pause_endtime,
       h.call_type,
       h.transfer_count,
       h.buz_flag,
       h.extend1,
       h.extend2,
       h.extend3,
       s.org_code,
      s.org_name,
       b.business_name,
      c.cust_name
  from trx_today h inner join  (select *
                 from sys_org o
                where o.deleted = 0
                start with o.org_id =:orgId
               connect by prior o.org_id = o.parent_id) s on (h.org_id = s.org_id)
               left join  BC_BUSINESSMANAGE b on (h.bus_id = b.business_id)
               left join bc_custtype c on (h.cust_type = c.cust_level)
               where to_char(h.trx_date, ''yyyy/mm/dd'') = to_char(sysdate, ''yyyy/mm/dd'')';


  --if v_orgId !=0 then
    -- v_sql_condition := v_sql_condition || ' and h.org_id =:orgId';
  -- else
    -- v_orgId := 0;
    -- v_sql_condition := v_sql_condition || ' and ( h.org_id  is null or h.org_id <>:orgId)';

  --end if;


  -------------------------------------------------2.包裹按条件查询的语句，进行分页 开始------------------------------------------------------------
  if (orderfield is null) then
      v_sort := 'org_code';
  else
      v_sort := orderfield||' '||ordertype;
  end if;

 --select result
 v_sql := 'select row_number() over ( order by '||v_sort||',rid) rnum,tt.org_id,tt.device_no,tt.trx_date,tt.flow_no,tt.bus_id,tt.bus_type,tt.cust_type,
tt.pdj_level,tt.ticket_type,tt.ticket_no,tt.cust_id,tt.card_type,tt.card_no,
tt.manager_no,tt.trx_type,tt.trx_status,tt.print_time,tt.call_time,tt.begin_time,
tt.end_time,tt.app_value,tt.win_no,tt.teller_no,tt.recall_count,tt.pause_begintime,
tt.pause_endtime,tt.call_type,tt.transfer_count,tt.buz_flag,tt.extend1,
tt.extend2,tt.extend3,tt.org_code,tt.org_name,tt.business_name,tt.cust_name
  from ('||v_sql_condition||') tt ';

   --select count
  v_sql_count := 'select count(1) from ('||v_sql||')';


------------------------------------------------------------3.判断是分页还是查询列表

   if pageno > 0  then
    v_sql_page := 'select * from ('||v_sql||') temp where temp.rnum >= :v_begin and temp.rnum <= :v_end';
     execute immediate v_sql_count into totalrows using v_orgId;
     OPEN p_cursor FOR v_sql_page using  v_orgId,v_begin,v_end;
  else
    totalrows:=0; --set default value
    v_sql_page := 'select * from ('||v_sql||') temp ';
    OPEN p_cursor FOR v_sql_page using  v_orgId;
  end if;

end proc_trxtoday_page;
/

prompt
prompt Creating procedure PROC_TRXTODAY_QUERY
prompt ======================================
prompt
create or replace procedure iqms_new.proc_trxtoday_query (
orgId varchar2, --机构id

p_cursor out sys_refcursor)
as
   v_sql varchar2(4000);
   v_orgId varchar2(50) := orgId;


begin
---------------------------------------------------------1.按条件查询数据 start------------------------------------------------------------------
if v_orgId = '0' then
  v_orgId := '1';
  end if;
v_sql := 'select count(1) total_count,
sum(case when t.trx_status = ''1'' then 1 else 0 end) wait_count,
sum(case when t.trx_status = ''3'' then 1 else 0 end) totalFinished,
sum(case when t.trx_status = ''2'' then 1 else 0 end) doing_count,
sum(case when t.cust_type in (select b.cust_level from bc_custtype b where b.vip_flag=''1'') then 1 else 0 end) vip_total_count,
sum(case when t.trx_status = ''1'' and t.cust_type in (select b.cust_level from bc_custtype b where b.vip_flag=''1'')
 then 1 else 0 end) vip_wait_count
from  trx_today t inner join  (select *
                 from sys_org o
                where o.deleted = 0
                start with o.org_id =:orgId
               connect by prior o.org_id = o.parent_id) s on (t.org_id = s.org_id)
 where
to_char(t.trx_date, ''yyyy/mm/dd'') =
to_char(sysdate,''yyyy/mm/dd'')';--总取号数，等候，正在办理,vip取号数,vip等候人数

 --if v_orgId !=0 then
     --v_sql := v_sql || ' and t.org_id =:orgId';


  -- else
   --  v_orgId := 0;
    -- v_sql := v_sql || ' and (t.org_id is null or t.org_id<>:orgId)';

 -- end if;

 OPEN p_cursor FOR v_sql using v_orgId;

end proc_trxtoday_query;
/

prompt
prompt Creating procedure PROC_TRXYESTERDAY_QUERY
prompt ==========================================
prompt
create or replace procedure iqms_new.proc_trxyesterday_query (
orgId varchar2, --机构id
p_cursor out sys_refcursor)
as
   v_sql varchar2(4000);
   v_orgId varchar2(50) := orgId;


begin
---------------------------------------------------------1.按条件查询数据 start------------------------------------------------------------------
if v_orgId = '0' then
  v_orgId := '1';
  end if;
 v_sql := 'select  count(1) yes_total_count,
sum(case when t.cust_type in
(select b.cust_level from bc_custtype b where b.vip_flag=''1'') then 1 else 0 end) yes_vip_total
 from trx_history t inner join  (select *
                 from sys_org o
                where o.deleted = 0
                start with o.org_id =:orgId
               connect by prior o.org_id = o.parent_id) s on (t.org_id = s.org_id)
               where to_char(t.trx_date,''yyyy-mm-dd'')=to_char(sysdate-1,''yyyy-mm-dd'')';--总取号数,vip取号数


 --if v_orgId !=0 then
    -- v_sql := v_sql || ' and t.org_id =:orgId';



   --else
    -- v_orgId := 0;
     --v_sql := v_sql || ' and (t.org_id is null or t.org_id<>:orgId)';



  --end if;

 OPEN p_cursor FOR v_sql using  v_orgId;

end proc_trxyesterday_query;
/

prompt
prompt Creating procedure PROC_WINCONFIG_SELECT
prompt ========================================
prompt
create or replace procedure iqms_new.proc_winconfig_select
(
orgId varchar2,
deviceNo varchar2,
p_cursor out sys_refcursor
)
as
   v_sql varchar2(4000);
   v_orgid varchar2(50) := orgId;
   v_deviceNo varchar2(50) := deviceNo;
begin

   if orgId is null or deviceNo is null then
       v_sql := 'select b.win_id,b.win_no from BSC_WIN_CONFIG b where b.is_start=1
                 order by to_number(b.win_no)';
       OPEN p_cursor FOR v_sql;
   else
       v_sql := 'select b.win_id,b.win_no from BSC_WIN_CONFIG b where b.is_start=1
                 and b.org_id =:orgId and b.device_no =:deviceNo order by to_number(b.win_no)';
       OPEN p_cursor FOR v_sql using v_orgid,v_deviceNo;
   end if;



end proc_winconfig_select;
/

prompt
prompt Creating procedure PROC_WINMONITOR
prompt ==================================
prompt
create or replace procedure iqms_new.proc_winmonitor (
orgId varchar2, --机构id

orderfield in varchar2,
ordertype in varchar2,
pagesize in number, pageno in number,totalrows out number,p_cursor out sys_refcursor)
as
   v_sql varchar2(4000);
   v_sql_page varchar2(4000);
   v_sql_condition varchar2(4000);
   v_sql_count varchar2(4000);
   v_begin number := (pageno-1)*pagesize+1;
   v_end number := pageno*pagesize;
   v_sort varchar2(50);
   v_orgId varchar2(50) := orgId;

begin
---------------------------------------------------------1.按条件查询数据 start------------------------------------------------------------------
if v_orgId = '0' then
  v_orgId := '1';
  end if;
  v_sql_condition := 'select t.rid,
       t.rnum,
       t.flowNoDone,
       t.app_value app,
       t.ORG_ID,
       t.DEVICE_NO,
       t.TRX_DATE,
       t.flowNo,
       t.BUS_ID,
       t.BUS_TYPE,
       t.CUST_TYPE,
       t.PDJ_LEVEL,
       t.TICKET_TYPE,
       t.TICKET_NO,
       t.CUST_ID,
       t.CARD_TYPE,
       t.CARD_NO,
       t.MANAGER_NO,
       t.TRX_TYPE,
       t.TRX_STATUS,
       t.PRINT_TIME,
       t.CALL_TIME,
       t.BEGIN_TIME,
       t.END_TIME,
       t.APP_VALUE,
       t.WIN_NO,
       t.TELLER_NO,
       t.RECALL_COUNT,
       t.PAUSE_BEGINTIME,
       t.PAUSE_ENDTIME,
       t.CALL_TYPE,
       t.TRANSFER_COUNT,
       t.BUZ_FLAG,
       t.EXTEND1,
       t.EXTEND2,
       t.EXTEND3,
       t.WIN_STATUS, s.org_code, s.org_name, b.business_name, c.cust_name
  from view_winmonitor t
  inner join (select o.org_code,o.org_name,o.org_id
                 from sys_org o
                where o.deleted = 0
                start with o.org_id = :orgId
               connect by prior o.org_id = o.parent_id) s
      on (t.ORG_ID = s.org_id)
      left join BC_BUSINESSMANAGE b
      on (t.bus_id = b.business_id)
      left join bc_custtype c
      on(t.cust_type = c.cust_level)';





  -------------------------------------------------2.包裹按条件查询的语句，进行分页 开始------------------------------------------------------------
  if (orderfield is null) then
      v_sort := 'org_code';
  else
      v_sort := orderfield||' '||ordertype;
  end if;

 --select result
 v_sql := 'select row_number() over ( order by '||v_sort||',rid) rnum1,tt.rnum,
       tt.flowNoDone,
       tt.APP_VALUE app,
       tt.ORG_ID,tt.DEVICE_NO,tt.TRX_DATE,tt.flowNo,tt.BUS_ID,tt.BUS_TYPE,tt.CUST_TYPE,tt.PDJ_LEVEL,tt.TICKET_TYPE,tt.TICKET_NO,tt.CUST_ID,tt.CARD_TYPE,tt.CARD_NO,tt.MANAGER_NO,tt.TRX_TYPE,tt.TRX_STATUS,tt.PRINT_TIME,tt.CALL_TIME,tt.BEGIN_TIME,tt.END_TIME,tt.APP_VALUE,tt.WIN_NO,tt.TELLER_NO,tt.RECALL_COUNT,tt.PAUSE_BEGINTIME,tt.PAUSE_ENDTIME,tt.CALL_TYPE,tt.TRANSFER_COUNT,tt.BUZ_FLAG,tt.EXTEND1,tt.EXTEND2,tt.EXTEND3,
  tt.WIN_STATUS,tt.org_code, tt.org_name, tt.business_name, tt.cust_name
  from ('||v_sql_condition||') tt ';

   --select count
  v_sql_count := 'select count(1) from ('||v_sql||')';


------------------------------------------------------------3.判断是分页还是查询列表

   if pageno > 0  then
    v_sql_page := 'select temp.flowNoDone,
    temp.app,
       temp.ORG_ID,temp.DEVICE_NO,temp.TRX_DATE,temp.flowNo,temp.BUS_ID,temp.BUS_TYPE,temp.CUST_TYPE,temp.PDJ_LEVEL,temp.TICKET_TYPE,temp.TICKET_NO,temp.CUST_ID,temp.CARD_TYPE,temp.CARD_NO,temp.MANAGER_NO,temp.TRX_TYPE,temp.TRX_STATUS,temp.PRINT_TIME,temp.CALL_TIME,temp.BEGIN_TIME,temp.END_TIME,temp.APP_VALUE,temp.WIN_NO,temp.TELLER_NO,temp.RECALL_COUNT,temp.PAUSE_BEGINTIME,temp.PAUSE_ENDTIME,temp.CALL_TYPE,temp.TRANSFER_COUNT,temp.BUZ_FLAG,temp.EXTEND1,temp.EXTEND2,temp.EXTEND3,
  temp.WIN_STATUS,temp.org_code, temp.org_name, temp.business_name, temp.cust_name

    from ('||v_sql||') temp where temp.rnum1 >= :v_begin and temp.rnum1 <= :v_end';
    execute immediate v_sql_count into totalrows using v_orgId;
     OPEN p_cursor FOR v_sql_page using  v_orgId,v_begin,v_end;
  else
    totalrows:=0; --set default value
    v_sql_page := 'select temp.* from ('||v_sql||') temp ';
     OPEN p_cursor FOR v_sql_page using  v_orgId;
  end if;

end proc_winmonitor;
/

prompt
prompt Creating procedure PROC_WINMONITOR_PAGE
prompt =======================================
prompt
create or replace procedure iqms_new.proc_winmonitor_page (
orgId varchar2, --机构id

orderfield in varchar2,
ordertype in varchar2,
pagesize in number, pageno in number,totalrows out number,p_cursor out sys_refcursor)
as
   v_sql varchar2(4000);
   v_sql_page varchar2(4000);
   v_sql_condition varchar2(4000);
   v_sql_count varchar2(4000);
   v_begin number := (pageno-1)*pagesize+1;
   v_end number := pageno*pagesize;
   v_sort varchar2(50);
   v_orgId varchar2(50) := orgId;

begin
---------------------------------------------------------1.按条件查询数据 start------------------------------------------------------------------
if v_orgId = '0' then
  v_orgId := '1';
  end if;
  v_sql_condition := 'select t.rid,
       t.rnum,
       t.flowNoDone,
       t.app_value app,
       t.ORG_ID,
       t.DEVICE_NO,
       t.TRX_DATE,
       t.flowNo,
       t.BUS_ID,
       t.BUS_TYPE,
       t.CUST_TYPE,
       t.PDJ_LEVEL,
       t.TICKET_TYPE,
       t.TICKET_NO,
       t.CUST_ID,
       t.CARD_TYPE,
       t.CARD_NO,
       t.MANAGER_NO,
       t.TRX_TYPE,
       t.TRX_STATUS,
       t.PRINT_TIME,
       t.CALL_TIME,
       t.BEGIN_TIME,
       t.END_TIME",
       t.APP_VALUE,
       t.WIN_NO,
       t.TELLER_NO,
       t.RECALL_COUNT,
       t.PAUSE_BEGINTIME,
       t.PAUSE_ENDTIME,
       t.CALL_TYPE,
       t.TRANSFER_COUNT,
       t.BUZ_FLAG,
       t.EXTEND1,
       t.EXTEND2,
       t.EXTEND3,
       t.WIN_STATUS, s.org_code, s.org_name, b.business_name, c.cust_name
  from view_winmonitor t
  inner join (select o.org_code,o.org_name,o.org_id
                 from sys_org o
                where o.deleted = 0
                start with o.org_id = :orgId
               connect by prior o.org_id = o.parent_id) s
      on (t.ORG_ID = s.org_id)
      left join BC_BUSINESSMANAGE b
      on (t.bus_id = b.business_id)
      left join bc_custtype c
      on(t.cust_type = c.cust_level)';





  -------------------------------------------------2.包裹按条件查询的语句，进行分页 开始------------------------------------------------------------
  if (orderfield is null) then
      v_sort := 'org_code';
  else
      v_sort := orderfield||' '||ordertype;
  end if;

 --select result
 v_sql := 'select row_number() over ( order by '||v_sort||',rid) rnum1,tt.rnum,
       tt.flowNoDone,
       tt.APP_VALUE app,
       tt.ORG_ID,tt.DEVICE_NO,tt.TRX_DATE,tt.flowNo,tt.BUS_ID,tt.BUS_TYPE,tt.CUST_TYPE,tt.PDJ_LEVEL,tt.TICKET_TYPE,tt.TICKET_NO,tt.CUST_ID,tt.CARD_TYPE,tt.CARD_NO,tt.MANAGER_NO,tt.TRX_TYPE,tt.TRX_STATUS,tt.PRINT_TIME,tt.CALL_TIME,tt.BEGIN_TIME,tt.END_TIME,tt.APP_VALUE,tt.WIN_NO,tt.TELLER_NO,tt.RECALL_COUNT,tt.PAUSE_BEGINTIME,tt.PAUSE_ENDTIME,tt.CALL_TYPE,tt.TRANSFER_COUNT,tt.BUZ_FLAG,tt.EXTEND1,tt.EXTEND2,tt.EXTEND3,
  tt.WIN_STATUS,tt.org_code, tt.org_name, tt.business_name, tt.cust_name
  from ('||v_sql_condition||') tt ';

   --select count
  v_sql_count := 'select count(1) from ('||v_sql||')';


------------------------------------------------------------3.判断是分页还是查询列表

   if pageno > 0  then
    v_sql_page := 'select temp.flowNoDone,
    temp.app,
       temp.ORG_ID,temp.DEVICE_NO,temp.TRX_DATE,temp.flowNo,temp.BUS_ID,temp.BUS_TYPE,temp.CUST_TYPE,temp.PDJ_LEVEL,temp.TICKET_TYPE,temp.TICKET_NO,temp.CUST_ID,temp.CARD_TYPE,temp.CARD_NO,temp.MANAGER_NO,temp.TRX_TYPE,temp.TRX_STATUS,temp.PRINT_TIME,temp.CALL_TIME,temp.BEGIN_TIME,temp.END_TIME,temp.APP_VALUE,temp.WIN_NO,temp.TELLER_NO,temp.RECALL_COUNT,temp.PAUSE_BEGINTIME,temp.PAUSE_ENDTIME,temp.CALL_TYPE,temp.TRANSFER_COUNT,temp.BUZ_FLAG,temp.EXTEND1,temp.EXTEND2,temp.EXTEND3,
  temp.WIN_STATUS,temp.org_code, temp.org_name, temp.business_name, temp.cust_name

    from ('||v_sql||') temp where temp.rnum1 >= :v_begin and temp.rnum1 <= :v_end';
    execute immediate v_sql_count into totalrows using v_orgId;
     OPEN p_cursor FOR v_sql_page using  v_orgId,v_begin,v_end;
  else
    totalrows:=0; --set default value
    v_sql_page := 'select temp.* from ('||v_sql||') temp ';
     OPEN p_cursor FOR v_sql_page using  v_orgId;
  end if;

end proc_winmonitor_page;
/

prompt
prompt Creating table BSC_SPECIALDATE
prompt ==============================
prompt
create table iqms_yt.BSC_SPECIALDATE
(
  device_no    VARCHAR2(50),
  special_date VARCHAR2(50),
  date_type    VARCHAR2(2)
)
tablespace IQMS_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 8K
    minextents 1
    maxextents unlimited
  );
comment on column iqms_yt.BSC_SPECIALDATE.device_no
  is '设备号';
comment on column iqms_yt.BSC_SPECIALDATE.special_date
  is '特殊日期';
comment on column iqms_yt.BSC_SPECIALDATE.date_type
  is '日期类型 1：平日 2：假日';

prompt
prompt Creating procedure PROC_BSCSPECIALDATE_ADD
prompt ==========================================
prompt
CREATE OR REPLACE PROCEDURE iqms_yt.proc_bscspecialdate_add
(
 deviceNo varchar2,
 specialDate varchar2,
 dateType varchar2,
 ReturnCode OUT varchar2
)
AS
iRecCount INTEGER;
BEGIN

 --查询要增加的记录是否存在
 select count(1) into iRecCount from bsc_specialdate t where  t.device_no = deviceNo
  and t.special_date = specialDate;


 if iRecCount > 0 then
   update bsc_specialdate t set
      t.DEVICE_NO =deviceNo,
      t.special_date =specialDate,
      t.date_type = dateType
      where t.device_no = deviceNo
      and t.special_date=specialDate;
      --更新设备状态
proc_deviceupdateflag(deviceNo,'0');
   ReturnCode:='0'; --已经存在
 else
   --插入
   insert into bsc_specialdate (
      DEVICE_NO,
      special_date,
      date_type
   ) values (
     deviceNo,
     specialDate,
     dateType
   );
   --更新设备状态
--update bsc_device b set b.extend1 = '1' where b.org_id = orgId
--and b.device_no = deviceNo;
proc_deviceupdateflag(deviceNo,'0');
   ReturnCode:='0';
 end if;
 --异常处理
 -- exception
   --   when others then
     --  ReturnCode:='1'; --数据库异常
END proc_bscspecialdate_add;
/

prompt
prompt Creating procedure PROC_BSCSPECIALDATE_COPY
prompt ===========================================
prompt
CREATE OR REPLACE PROCEDURE iqms_yt.proc_bscspecialdate_copy--应用到下级机构
(
 deviceNo varchar2,
 targetNo varchar2, --目标deviceNo
 ReturnCode OUT varchar2
)
AS
BEGIN
if deviceNo != targetNo then

 --删除目标数据再插入
 delete from bsc_specialdate b where b.device_no = targetNo;

   --插入
   insert into bsc_specialdate (
      DEVICE_NO,
      special_date,
      date_type
   ) select
     targetNo,
      special_date,
      date_type
    from bsc_specialdate w where w.device_no=deviceNo;
    proc_deviceupdateflag(deviceNo,'0');
   ReturnCode:='0';
end if;

END proc_bscspecialdate_copy;
/

prompt
prompt Creating procedure PROC_BSCSPECIALDATE_QUERY
prompt ============================================
prompt
create or replace procedure iqms_yt.proc_bscspecialdate_query (
deviceNo varchar2,
p_cursor out sys_refcursor)
as
   v_sql varchar2(4000);


begin


 --select result
 v_sql := 'select b.*

 from bsc_specialdate b
 where b.device_no =:deviceNo order by b.special_date' ;
 OPEN p_cursor FOR v_sql using deviceNo;



end proc_bscspecialdate_query;
/

prompt
prompt Creating procedure PROC_BSCSPECIALDATE_REMOVE
prompt =============================================
prompt
CREATE OR REPLACE PROCEDURE iqms_yt.proc_bscspecialdate_remove
(
 deviceNo varchar2,

 ReturnCode OUT varchar2
)
AS

BEGIN
 delete from  bsc_specialdate t  where  t.device_no = deviceNo ;

proc_deviceupdateflag(deviceNo,'0');
 ReturnCode:='0';
END proc_bscspecialdate_remove;
/

prompt
prompt Creating procedure PROC_SPECIALDATES_QUERY
prompt ==========================================
prompt
create or replace procedure iqms_yt.proc_specialdates_query (
deviceNo varchar2,
p_cursor out sys_refcursor)
as
   v_sql varchar2(4000);


begin


 -- 生成specialDates.json
 v_sql := 'select  bsc.special_date, bsc.date_type,''inserted'' saveStatus
from bsc_specialdate bsc
where bsc.device_no =:deviceNo';
 OPEN p_cursor FOR v_sql using deviceNo;




end proc_specialdates_query;
/
spool off
