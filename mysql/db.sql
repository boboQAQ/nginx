CREATE database IF NOT EXISTS iot_stack DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE iot_stack;

CREATE TABLE IF NOT EXISTS uiot_project(
    id INT UNSIGNED AUTO_INCREMENT,
    project_name VARCHAR(64) NOT NULL,
    description VARCHAR(100) DEFAULT '',
    created_time BIGINT DEFAULT 0,
    can_delete  BOOL NOT NULL DEFAULT TRUE,
    PRIMARY KEY(id),
    UNIQUE(project_name)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS uiot_user(
    id INT UNSIGNED AUTO_INCREMENT,
    username VARCHAR(64) NOT NULL,
    password VARCHAR(64) NOT NULL,
    email VARCHAR(32) NOT NULL,
    admin BOOL NOT NULL DEFAULT FALSE,
    status BOOL NOT NULL DEFAULT FALSE,
    description VARCHAR(1024) DEFAULT '',
    created_time BIGINT DEFAULT 0,
    updated_time BIGINT DEFAULT 0,
    last_login_time BIGINT DEFAULT 0,
    project_name VARCHAR(64) NOT NULL,
    PRIMARY KEY(id),
    UNIQUE(email),
    UNIQUE(username)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS uiot_user_project(
    id INT UNSIGNED AUTO_INCREMENT,
    user_id INT NOT NULL,
    project_id INT NOT NULL,
    PRIMARY KEY(id),
    UNIQUE(user_id, project_id)
) ENGINE=InnoDB;

INSERT INTO uiot_project (project_name, description, can_delete, created_time) SELECT 'default','default',false,REPLACE(unix_timestamp(current_timestamp(3)), '.','') WHERE NOT EXISTS (SELECT id FROM uiot_project WHERE project_name = 'default');

INSERT INTO uiot_user (username, password, email, admin, status,project_name, description, created_time, updated_time) SELECT 'admin','iotstack','admin@stack.cn',true,true,'default','admin', REPLACE(unix_timestamp(current_timestamp(3)), '.',''),REPLACE(unix_timestamp(current_timestamp(3)), '.','') WHERE NOT EXISTS (SELECT id FROM uiot_user WHERE username = 'admin');

INSERT INTO uiot_user_project (user_id, project_id) SELECT (SELECT id FROM uiot_project WHERE project_name = 'default'), (SELECT id FROM uiot_user WHERE username = 'admin') WHERE NOT EXISTS (SELECT id FROM uiot_user_project WHERE user_id = (SELECT id FROM uiot_user WHERE username = 'admin') AND project_id = (SELECT id FROM uiot_project WHERE project_name = 'default'));

CREATE TABLE IF NOT EXISTS uiot_product(
    id INT UNSIGNED AUTO_INCREMENT,
    project_id INT NOT NULL,
    product_sn CHAR(16) NOT NULL,
    product_name VARCHAR(64) NOT NULL,
    product_type VARCHAR(64) NOT NULL,
    product_password VARCHAR(32) NOT NULL,
    description VARCHAR(1024) DEFAULT '',
    published BOOL NOT NULL DEFAULT FALSE,
    pre_register BOOL NOT NULL DEFAULT FALSE,
    dynamic_register BOOL NOT NULL DEFAULT FALSE,
    created_time BIGINT DEFAULT 0 ,
    PRIMARY KEY(id),
    UNIQUE(product_sn),
    UNIQUE(project_id, product_name)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS uiot_topic(
    id INT UNSIGNED AUTO_INCREMENT,
    product_id INT NOT NULL,
    device_identifier VARCHAR(64) NOT NULL,
    topic_suffix VARCHAR(255) NOT NULL,
    topic VARCHAR(255) NOT NULL,
    permission VARCHAR(32) NOT NULL DEFAULT 'pub',
    description VARCHAR(1024) DEFAULT '',
    PRIMARY KEY(id),
    UNIQUE(product_id, topic)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS uiot_system_topic (
    id INT UNSIGNED AUTO_INCREMENT,
    topic varchar(200) NOT NULL,
    topic_suffix VARCHAR(255) NOT NULL,
    permission varchar(32) DEFAULT 'pub',
    module int(11) DEFAULT '0',
    topic_description varchar(1024) DEFAULT '',
    topic_usage varchar(32) DEFAULT '',
    is_display tinyint(1) DEFAULT '0',
    rule_engine_permission varchar(6) DEFAULT 'sub',
    is_open tinyint(1) NOT NULL DEFAULT '1',
    PRIMARY KEY(id),
    UNIQUE(topic),
    UNIQUE(module,topic_usage)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT IGNORE INTO `uiot_system_topic` (`topic`, `topic_suffix`,`permission`, `module`, `topic_description`, `topic_usage`, `is_display`, `rule_engine_permission`, `is_open`) VALUES
('/$system/${ProductSN}/${DeviceSN}/password','password', 'pub', 1, 'device password dispatch topic', 'password', 0, '-', 1),
('/$system/${ProductSN}/${DeviceSN}/password_reply','password_reply','sub', 1, 'device password dispatch topic', 'password_reply', 0, '-', 1),
('/$system/${ProductSN}/${DeviceSN}/device/status','device/status', '-', 5, '设备状态变化(仅供规则引擎订阅)', 'device_status', 1, 'sub', 0),
('/$system/${ProductSN}/${DeviceSN}/subdev/register', 'subdev/register','pub', 6, '子设备动态注册（上行）', 'subdev_register', 0, '-', 0),
('/$system/${ProductSN}/${DeviceSN}/subdev/register_reply','subdev/register_reply', 'sub', 6, '子设备动态注册（下行）', 'subdev_register_reply', 0, '-', 0),
('/$system/${ProductSN}/${DeviceSN}/subdev/topo/add', 'subdev/topo/add','pub', 6, '添加设备拓扑关系（上行）', 'subdev_topo_add', 0, '-', 0),
('/$system/${ProductSN}/${DeviceSN}/subdev/topo/add_reply','subdev/topo/add_reply', 'sub', 6, '添加设备拓扑关系（下行）', 'subdev_topo_add_reply', 0, '-', 0),
('/$system/${ProductSN}/${DeviceSN}/subdev/topo/delete','subdev/topo/delete', 'pub', 6, '删除设备拓扑关系（上行）', 'subdev_topo_delete', 0, '-', 0),
('/$system/${ProductSN}/${DeviceSN}/subdev/topo/delete_reply','subdev/topo/delete_reply', 'sub', 6, '删除设备拓扑关系（下行）', 'subdev_topo_delete_reply', 0, '-', 0),
('/$system/${ProductSN}/${DeviceSN}/subdev/topo/get','subdev/topo/get', 'pub', 6, '获取设备拓扑关系（上行）', 'subdev_topo_get', 0, '-', 0),
('/$system/${ProductSN}/${DeviceSN}/subdev/topo/get_reply', 'subdev/topo/get_reply','sub', 6, '获取设备拓扑关系（下行）', 'subdev_topo_get_reply', 0, '-', 0),
('/$system/${ProductSN}/${DeviceSN}/subdev/topo/found','subdev/topo/found', 'pub', 6, '发现设备(上行)', 'device_status', 0, 'sub', 0),
('/$system/${ProductSN}/${DeviceSN}/subdev/topo/found_reply', 'subdev/topo/found_reply','sub', 6, '发现设备(下行)', 'subdev_topo_found_reply', 0, 'pub', 0),
('/$system/${ProductSN}/${DeviceSN}/subdev/topo/notify/add', 'subdev/topo/notify/add','sub', 6, '通知设备拓扑添加(下行)', 'subdev_topo_notify', 0, '-', 0),
('/$system/${ProductSN}/${DeviceSN}/subdev/login','subdev/login', 'pub', 6, '通知上线(上行)', 'subdev_login', 0, '-', 0),
('/$system/${ProductSN}/${DeviceSN}/subdev/logout','subdev/logout', 'pub', 6, '通知下线(上行)', 'subdev_logout', 0, '-', 0),
('/$system/${ProductSN}/${DeviceSN}/subdev/disable','subdev/disable', 'sub', 6, '设备禁用(下行)', 'subdev_disable', 0, '-', 0),
('/$system/${ProductSN}/${DeviceSN}/subdev/enable','subdev/enable', 'sub', 6, '设备启用(下行)', 'subdev_enable', 0, '-', 0),
('/$system/${ProductSN}/${DeviceSN}/subdev/delete','subdev/delete', 'sub', 6, '设备删除(下行)', 'subdev_delete', 0, '-', 0),
('/$system/${ProductSN}/${DeviceSN}/subdev/login_reply','subdev/login_reply', 'sub', 6, '通知上线(下行)', 'subdev_login_reply', 0, '-', 0),
('/$system/${ProductSN}/${DeviceSN}/subdev/logout_reply','subdev/logout_reply', 'sub', 6, '通知下线(下行)', 'subdev_logout_reply', 0, '-', 0),
('/$system/${ProductSN}/${DeviceSN}/subdev/topo/notify/delete','subdev/topo/notify/delete', 'sub', 6, '通知设备拓扑删除(下行)', 'subdev_topo_notify_delete', 0, '-', 0),
('/$system/${ProductSN}/${DeviceSN}/subdev/topo/sync', 'subdev/topo/sync','pub', 6, '同步设备拓扑关系（上行）', 'subdev_topo_sync', 0, '-', 0),
('/$system/${ProductSN}/${DeviceSN}/subdev/topo/sync_reply','subdev/topo/sync_reply', 'sub', 6, '同步设备拓扑关系（下行）', 'subdev_topo_sync_reply', 0, '-', 0),
('/$system/${ProductSN}/${DeviceSN}/deployment/upstream','deployment/upstream', 'pub', 7, '边缘部署管理（上行）', 'upstream', 0, '-', 1),
('/$system/${ProductSN}/${DeviceSN}/deployment/downstream','deployment/downstream', 'sub', 7, '边缘部署管理（下行）', 'downstream', 0, '-', 1),
('/$system/${ProductSN}/${DeviceSN}/monitor/upstream','monitor/upstream', 'pub', 8, 'device monitor upload topic', 'monitor', 0, '-', 1),
('/$system/${ProductSN}/${DeviceSN}/validate','validate', 'pub', 0, '网关设备校验硬件序列号(上行)', 'device_validate_upstream', 0, '-', 0),
('/$system/${ProductSN}/${DeviceSN}/validate_reply','validate_reply', 'sub', 0, '网关设备校验硬件序列号(下行)', 'device_validate_downstream', 0, '-', 0),
('/$system/${ProductSN}/${DeviceSN}/rrpc/request/+','rrpc/request/+', 'sub', 6, '下发RRPC请求到设备', 'rrpc request', 1, '-', 0),
('/$system/${ProductSN}/${DeviceSN}/rrpc/response/+','rrpc/response/+', 'pub', 6, '设备对RRPC的回复', 'rrpc response', 1, 'sub', 0);

CREATE TABLE IF NOT EXISTS uiot_device(
    id INT UNSIGNED AUTO_INCREMENT,
    product_id INT NOT NULL,
    device_sn VARCHAR(64) NOT NULL,
    password VARCHAR(128) NOT NULL,
    description VARCHAR(1024) DEFAULT '',
    online_status VARCHAR(64) NOT NULL DEFAULT 'inactivated',
    created_time BIGINT DEFAULT 0 ,
    last_online_time BIGINT DEFAULT 0,
    last_offline_time BIGINT DEFAULT 0,
    active_time BIGINT DEFAULT 0,
    enabled BOOL NOT NULL DEFAULT TRUE,
    node_id VARCHAR(64) NOT NULL DEFAULT '',
    encrypted VARCHAR(128) NOT NULL,
    remote_ssh BOOL NOT NULL DEFAULT TRUE,
    remote_port INT DEFAULT 0,
    PRIMARY KEY(id),
    UNIQUE(product_id, device_sn)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS uiot_edge_subdev(
    id INT  UNSIGNED AUTO_INCREMENT,
    gateway_id INT NOT NULL,
    subdev_id INT NOT NULL,
    created_time BIGINT DEFAULT 0 ,
    PRIMARY KEY(id),
    UNIQUE(gateway_id, subdev_id)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS uiot_rule(
    id INT UNSIGNED AUTO_INCREMENT,
    project_id INT NOT NULL,
    product_sn CHAR(16),
    device_sn VARCHAR(64),
    rule_name VARCHAR(32) NOT NULL,
    rule_description VARCHAR(1024) DEFAULT '',
    data_type ENUM('json', 'binary') DEFAULT 'json',
    rule_status ENUM('disabled', 'running') DEFAULT 'disabled',
    create_time BIGINT(20),
    sql_select VARCHAR(2048) DEFAULT '',
    short_topic VARCHAR(300) DEFAULT '',
    sql_where VARCHAR(1024) DEFAULT '',
    topic_type ENUM('sys', 'user') DEFAULT 'user',
    PRIMARY KEY (id),
    UNIQUE (product_sn, rule_name)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS uiot_rule_action(
    id INT UNSIGNED AUTO_INCREMENT,
    rule_id INT NOT NULL,
    action_type ENUM('mongodb', 'kafka', 'tsdb', 'republish', 'mysql', 'http', 'pgsql', 'clickhouse') NOT NULL,
    action_config text,
    updated_time bigint(20),
    PRIMARY KEY (id)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS uiot_function(
    id                 INT UNSIGNED AUTO_INCREMENT,
    project_id INT NOT NULL,
    name               CHAR(32)      NOT NULL,
    runtime            CHAR(16)      NOT NULL,
    handler            CHAR(64)      NOT NULL,
    description        VARCHAR(1024) NOT NULL DEFAULT '',
    created_time       BIGINT                 DEFAULT 0,
    last_modified_time BIGINT                 DEFAULT 0,
    code_url           text,
    function_code      text,
    code_checksum      CHAR(64)      NOT NULL DEFAULT '',
    code_size          INT UNSIGNED  NOT NULL DEFAULT 0,
    config             TEXT,
    PRIMARY KEY (id),
    UNIQUE (project_id, name)
) ENGINE=InnoDB auto_increment = 100000;

CREATE TABLE IF NOT EXISTS uiot_edge_function(
    id              INT UNSIGNED AUTO_INCREMENT,
    function_id     INT UNSIGNED NOT NULL,
    gateway_id      INT UNSIGNED NOT NULL,
    function_config TEXT,
    status          BOOL        NOT NULL DEFAULT FALSE,
    cron            VARCHAR(64) NOT NULL DEFAULT '',
    cron_enable     BOOL        NOT NULL DEFAULT FALSE,
    online_status   VARCHAR(64) NOT NULL DEFAULT '-',
    PRIMARY KEY (id),
    UNIQUE (function_id, gateway_id)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS uiot_driver
(
    id              INTEGER PRIMARY KEY AUTO_INCREMENT,
    project_id      INT NOT NULL,
    driver_uuid     CHAR(32)      NOT NULL,
    driver_name     CHAR(100)     NOT NULL,
    driver_type     CHAR(100)     NOT NULL,
    protocol        CHAR(64)      NOT NULL,
    language        CHAR(64)      NOT NULL,
    min_version     CHAR(64)      NOT NULL,
    cpu_type        CHAR(64)      NOT NULL,
    description     VARCHAR(1024) NOT NULL DEFAULT '',
    created_time    BIGINT                 DEFAULT 0,
    UNIQUE (driver_uuid),
    UNIQUE (project_id, driver_name, protocol, cpu_type)
);

CREATE TABLE IF NOT EXISTS uiot_edge_driver
(
    id                          INT UNSIGNED AUTO_INCREMENT,
    driver_id                   INT NOT NULL,
    gateway_id                  INT NOT NULL,
    edge_driver_uuid            CHAR(32) NOT NULL,
    version                     CHAR(32) NOT NULL,
    bind_time                   BIGINT DEFAULT 0,
    online_status               VARCHAR(64) NOT NULL DEFAULT 'unreported',
    config                      TEXT,
    container_config            TEXT,
    PRIMARY KEY (id),
    UNIQUE (edge_driver_uuid),
    UNIQUE (gateway_id, driver_id)
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS uiot_driver_subdev
(
    id             INT UNSIGNED AUTO_INCREMENT,
    edge_driver_id INT NOT NULL,
    subdev_id      INT NOT NULL,
    bind_time      BIGINT DEFAULT 0,
    config         TEXT,
    PRIMARY KEY (id),
    UNIQUE (edge_driver_id, subdev_id)
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS uiot_edge_deployment
(
    id                  INT UNSIGNED AUTO_INCREMENT,
    gateway_id          INT NOT NULL,
    status              CHAR(16) DEFAULT '',
    create_time         BIGINT   DEFAULT 0,
    last_modified_time  BIGINT   DEFAULT 0,
    log                 TEXT,
    PRIMARY KEY (id),
    INDEX (gateway_id)
) ENGINE = InnoDB auto_increment = 10000000;

CREATE TABLE IF NOT EXISTS uiot_edge_config(
    id INT UNSIGNED AUTO_INCREMENT,
    gateway_id INT NOT NULL,
    cpu_arch VARCHAR(64) NOT NULL,
    os VARCHAR(64) NOT NULL,
    software_version VARCHAR(64) NOT NULL,
    mode VARCHAR(64) NOT NULL,
    edge_password VARCHAR(64) NOT NULL DEFAULT 'iotstack',
    PRIMARY KEY(id),
    UNIQUE(gateway_id)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS uiot_edge_monitor(
    id INT UNSIGNED AUTO_INCREMENT,
    gateway_id INT NOT NULL,
    cpu_usage DOUBLE,
    disk_usage DOUBLE,
    memory_usage DOUBLE,
    PRIMARY KEY(id),
    UNIQUE(gateway_id)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS uiot_message_router (
  id int(10) unsigned NOT NULL AUTO_INCREMENT,
  product_sn char(16) NOT NULL,
  device_sn char(64) NOT NULL,
  product_id INT NOT NULL,
  device_id INT NOT NULL,
  router_name varchar(100) NOT NULL,
  description varchar(100) DEFAULT '',
  src_type varchar(20) NOT NULL,
  src_id varchar(32) DEFAULT '',
  dest_type varchar(20) NOT NULL,
  dest_id varchar(32) DEFAULT '',
  is_cached tinyint(1) DEFAULT '0',
  is_enabled tinyint(1) DEFAULT '1',
  filter_topic varchar(100) NOT NULL,
  topic_suffix varchar(100) NOT NULL,
  create_time bigint(20) NOT NULL,
  deploy_time bigint(20) DEFAULT '0',
  filter_topic_type varchar(10) NOT NULL,
  PRIMARY KEY (id),
  UNIQUE KEY product_sn (product_id,device_id,router_name)
) ENGINE=InnoDB AUTO_INCREMENT=403 ;

CREATE TABLE IF NOT EXISTS uiot_config(
    id              INT UNSIGNED AUTO_INCREMENT,
    name            VARCHAR(64) NOT NULL,
    config          TEXT,
    PRIMARY KEY (id),
    UNIQUE(name)
) ENGINE=InnoDB;

INSERT INTO uiot_config (name, config) SELECT 'function_code', 'IiIiCuiuvuWkh+S4iuaKpUlvVOW5s+WPsOaVsOaNruetm+mAieekuuS+iwoxLiDlrZDorr7lpIflvoDlh73mlbDorqHnrpflj5HpgIHkuIDkuKoganNvbiDmtojmga/vvIzmoLzlvI/lpoLkuIsKewogICAgImlkIjogMTIzNDU2LAogICAgImNlbHNpdXMiOiAxMjAKfQrooajnpLogaWQg5Li6IDEyMzQ1Nu+8jOa4qeW6puS4uiAxMjAg5pGE5rCP5bqmCjIuIOWHveaVsOiuoeeul+agueaNruadoeS7tuetm+mAieaVsOaNru+8jOWunuS+i+S4reeahOetm+mAieadoeS7tuS4ugpjZWxzaXVzID4gMTAwCjMuIOWwhuaRhOawj+W6pui9rOaNouS4uuWNjuawj+W6pgpjZWxzaXVzIC0+IGZhaHJlbmhlaXQKNC4g5rOo5oSP77yM5raI5oGv5rWB6L2s6ZyA6KaB6YWN572u55u45bqU55qE5raI5oGv6Lev55SxCiIiIgoKCmltcG9ydCBqc29uCmltcG9ydCBsb2dnaW5nCiMgaW1wb3J0IHJlcXVlc3RzICMg55So5LqOaHR0cOiuv+mXruWklumDqOivt+axggoKCmRlZiBoYW5kbGVyKGV2ZW50LCBjb250ZXh0KToKICAgIHNkayA9IGNvbnRleHRbJ3NkayddCiAgICB0cnk6CiAgICAgICAgc2RrLmxvZ2dlci5pbmZvKCJmdW5jdGlvbiBjb25maWc6IHt9Ii5mb3JtYXQoc2RrLmNvbmZpZykpICMgY29udGV4dFsnc2RrJ10uY29uZmlnIOeUqOS6juiOt+WPluWHveaVsOeahOmFjee9ruS/oeaBrwogICAgICAgICMg6K6w5b2V5b2T5YmN5Ye95pWw6LCD55So55qE5qyh5pWwCiAgICAgICAgc2RrLnJlZGlzX2NsaWVudC5pbmNyKCJjb3VudCIpCiAgICAgICAgIyDml6Xlv5fovpPlh7rvvIzlj6/pgJrov4fmnKzlnLB3ZWJwcm90YWzov5vooYzmn6XnnIsKICAgICAgICBzZGsubG9nZ2VyLmluZm8oImZ1bmN0aW9uIGNhbGxlZCB7fSB0aW1lcyIuZm9ybWF0KHNkay5yZWRpc19jbGllbnQuZ2V0KCJjb3VudCIpLmRlY29kZSgpKSkKCiAgICAgICAgIyBjb250ZXh0WydzZGsnXS5wcm9kdWN0X3NuIOeUqOS6juiOt+WPlue9keWFs+S6p+WTgeW6j+WIl+WPtwogICAgICAgICMgY29udGV4dFsnc2RrJ10uZGV2aWNlX3NuIOeUqOS6juiOt+WPlue9keWFs+iuvuWkh+W6j+WIl+WPtwoKICAgICAgICAjIOiOt+WPlua2iOaBryB0b3BpYwogICAgICAgIGxvY2FsX3RvcGljID0gZXZlbnRbInRvcGljIl0KICAgICAgICAjIHBheWxvYWQg5Li6IGJ5dGVzIOexu+Wei++8jOmcgOino+eggeS4uuWtl+espuS4sgogICAgICAgIG1zZyA9IGpzb24ubG9hZHMoZXZlbnRbInBheWxvYWQiXS5kZWNvZGUoJ3V0Zi04JykpCgogICAgICAgIGlmIG1zZ1siY2Vsc2l1cyJdID4gMTAwOgogICAgICAgICAgICAjIGNsb3VkX3RvcGljIOWPr+S7jiBsb2NhbF90b3BpYyDnu4/ov4foh6rlrprkuYnnmoTovazmjaLlvpfliLAKICAgICAgICAgICAgY2xvdWRfdG9waWMgPSBsb2NhbF90b3BpYyArICIvdG9fY2xvdWQiCiAgICAgICAgICAgICMg6L2s5o2i5Li65Y2O5rCP5rip5qCHCiAgICAgICAgICAgIG1zZ1siZmFocmVuaGVpdCJdID0gbXNnWyJjZWxzaXVzIl0gKiAxLjggKyAzMgogICAgICAgICAgICBwYXlsb2FkID0ganNvbi5kdW1wcyhtc2cpLmVuY29kZSgndXRmLTgnKQogICAgICAgICAgICAjIOWQkeaMh+WumiB0b3BpYyDlj5HpgIHmtojmga8KICAgICAgICAgICAgc2RrLnB1Ymxpc2goY2xvdWRfdG9waWMsIHBheWxvYWQpCgogICAgZXhjZXB0IEV4Y2VwdGlvbjoKICAgICAgICBsb2dnaW5nLmV4Y2VwdGlvbihjb250ZXh0KQ==' WHERE NOT EXISTS (SELECT id FROM uiot_config WHERE name = 'function_code');
INSERT INTO uiot_config (name, config) SELECT 'script_parser', 'LyoqCiAqIOWFpeWPgu+8mnRvcGljICAg5a2X56ym5Liy77yM6K6+5aSH5LiK5oql5raI5oGv55qEdG9waWMgICAgIAogKiDlhaXlj4LvvJpyYXdEYXRhIGJ5dGVbXeaVsOe7hCAgICAgICAgICAgICAgICAgIOS4jeiDveS4uuepugogKiDlh7rlj4LvvJpqc29uT2JqIEpTT07lr7nosaEgICAgICAgICAgICAgICAgICAgIOS4jeiDveS4uuepugogKi8KZnVuY3Rpb24gcmF3RGF0YVRvSlNPTih0b3BpYywgcmF3RGF0YSkgewogICAgdmFyIGpzb25PYmogPSB7fTsKICAgIHJldHVybiBqc29uT2JqOwp9' WHERE NOT EXISTS (SELECT id FROM uiot_config WHERE name = 'script_parser');

CREATE TABLE IF NOT EXISTS downloadCmd_template (
  id int(10) unsigned NOT NULL AUTO_INCREMENT,
  os char(32) NOT NULL,
  cmd varchar(500) NOT NULL,
  mode char(32) NOT NULL DEFAULT 'native',
  version char(100) NOT NULL DEFAULT '1.0',
  memory char(100) NOT NULL DEFAULT '128M',
  ram char(100) NOT NULL DEFAULT '256M',
  PRIMARY KEY (id),
  UNIQUE KEY version (version,os,mode)
) ENGINE=InnoDB AUTO_INCREMENT=13;

INSERT IGNORE INTO downloadCmd_template (os, cmd, version, memory, ram, mode) VALUES('linux', 'wget -O iot_edge_process.sh $URL/public/edge/$Version/iot_edge_process.sh && chmod +x iot_edge_process.sh && ./iot_edge_process.sh --install $CPUArch $Version && ./iot_edge_process.sh --config $ProductSN $DeviceSN $DevicePD $EdgePD && ./iot_edge_process.sh --start','1.0','>= 128M','>= 128M','native');

# INSERT IGNORE INTO downloadCmd_template (os, cmd, version, memory, ram, mode) VALUES('linux', 'wget -O ucloud_iot_edge_docker.sh $URL/public/edge/$Version/ucloud_iot_edge_docker.sh && chmod +x ucloud_iot_edge_docker.sh && ./ucloud_iot_edge_docker.sh --install $CPUArch $Version && ./ucloud_iot_edge_docker.sh --config $ProductSN $DeviceSN $DevicePD $EdgePD && ./ucloud_iot_edge_docker.sh --start','1.0','>= 2G','>= 2G','docker');

CREATE TABLE IF NOT EXISTS product_script (
    id            INT UNSIGNED AUTO_INCREMENT,
    product_id    INT NOT NULL,
    lang          ENUM('javascript','python'),
    script        TEXT,
    draft_lang    ENUM('javascript','python'),
    draft_script  TEXT,
    PRIMARY KEY (id),
    INDEX (product_id)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS uiot_cluster(
    id              INT UNSIGNED AUTO_INCREMENT,
    host_uuid       VARCHAR(64) NOT NULL,
    encrypted       VARCHAR(128) NOT NULL,
    PRIMARY KEY (id),
    UNIQUE(host_uuid)
) ENGINE=InnoDB;


DROP FUNCTION IF EXISTS rand_str;
DELIMITER $$
CREATE FUNCTION rand_str(n INT)
RETURNS VARCHAR(255)
BEGIN
DECLARE chars_str varchar(100) DEFAULT 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
DECLARE return_str varchar(255) DEFAULT '';
DECLARE i INT DEFAULT 0;
WHILE i < n DO
SET return_str = concat(return_str,substring(chars_str , FLOOR(1 + RAND()*62 ),1));
SET i = i +1;
END WHILE;
RETURN return_str;
END 
$$
DELIMITER ;


INSERT INTO uiot_config (name, config) SELECT 'user_jwt_key', rand_str(100) WHERE NOT EXISTS (SELECT id FROM uiot_config WHERE name = 'user_jwt_key');

INSERT INTO uiot_config (name, config) SELECT 'file_jwt_key', rand_str(100) WHERE NOT EXISTS (SELECT id FROM uiot_config WHERE name = 'file_jwt_key');

INSERT INTO uiot_config (name, config) SELECT 'modbus_driver_config', 'eyJjaGFubmVsIjp7InR0eVVTQjAiOnsicG9ydCI6Ii9kZXYvdHR5VVNCMCIsImJhdWRyYXRlIjo5NjAwLCJtZXRob2QiOiJzZXJpYWwiLCJmb3JtYXQiOiJydHUiLCJ0aW1lb3V0IjoxLCJwZXJpb2QiOjUsInRpbWVfd2FpdCI6MC4yfX0sImRodDIwIjp7InJlYWQiOlt7ImFjdGlvbiI6IjA0SCIsImFkZHJlc3MiOiIweDAwMDEiLCJudW1iZXIiOjIsInByb3BfbGlzdCI6W3sibmFtZSI6ImRhdGEudGVtcGVyYXR1cmUiLCJ0eXBlIjoiaW50IiwiY291bnQiOjEsInNjYWxlIjowLjEsIm9mZnNldCI6MH0seyJuYW1lIjoiZGF0YS5odW1pZGl0eSIsInR5cGUiOiJpbnQiLCJjb3VudCI6MSwic2NhbGUiOjAuMSwib2Zmc2V0IjowfV19XSwid3JpdGUiOnsiZGF0YS50ZW1wZXJhdHVyZV9maXgiOnsiYWN0aW9uIjoiMDZIIiwiYWRkcmVzcyI6IjB4MDEwMyJ9LCJkYXRhLmh1bWlkaXR5X2ZpeCI6eyJhY3Rpb24iOiIwNkgiLCJhZGRyZXNzIjoiMHgwMTA0In0sImRhdGEudGVtcF9odW1pX2ZpeCI6eyJhY3Rpb24iOiIxMEgiLCJhZGRyZXNzIjoiMHgwMTAzIn19LCJ0aW1lc3RhbXAiOnRydWUsInRvcGljIjoiL3t9L3t9L3VwbG9hZCIsIm1vZGUiOiJjeWNsZSJ9fQ==' WHERE NOT EXISTS (SELECT id FROM uiot_config WHERE name = 'modbus_driver_config');

INSERT INTO uiot_config (name, config) SELECT 'modbus_driver_subdev_config', 'eyJjaGFubmVsIjoidHR5VVNCMCIsImNvbmZpZyI6ImRodDIwIiwic2xhdmVfYWRkcmVzcyI6MX0=' WHERE NOT EXISTS (SELECT id FROM uiot_config WHERE name = 'modbus_driver_subdev_config');


CREATE TABLE IF NOT EXISTS uiot_application
(
    id                  INTEGER PRIMARY KEY AUTO_INCREMENT,
    project_id          INT NOT NULL,
    name                CHAR(100)     NOT NULL,
    type                CHAR(100)     NOT NULL,
    language            CHAR(64)      NOT NULL,
    min_version         CHAR(64)      NOT NULL,
    cpu_type            CHAR(64)      NOT NULL,
    description         VARCHAR(1024) NOT NULL DEFAULT '',
    created_time        BIGINT                 DEFAULT 0,
    config              TEXT,
    container_config    TEXT,
    env_config          TEXT,
    UNIQUE (name, project_id)
);

CREATE TABLE IF NOT EXISTS uiot_edge_application
(
    id                          INT UNSIGNED AUTO_INCREMENT,
    application_id              INT NOT NULL,
    version                     CHAR(32) NOT NULL,
    gateway_id                  INT NOT NULL,
    bind_time                   BIGINT DEFAULT 0,
    online_status               VARCHAR(64) NOT NULL DEFAULT 'unreported',
    config                      TEXT,
    container_config            TEXT,
    env_config                  TEXT,
    PRIMARY KEY (id),
    UNIQUE (gateway_id, application_id)
) ENGINE = InnoDB;


-- INSERT INTO uiot_config (name, config) SELECT 'enterprise_logo', '/common/iot.png' WHERE NOT EXISTS (SELECT id FROM uiot_config WHERE name = 'enterprise_logo');

-- INSERT INTO uiot_config (name, config) SELECT 'enterprise_name', 'IoT Stcak' WHERE NOT EXISTS (SELECT id FROM uiot_config WHERE name = 'enterprise_name');


--  version 1.1 -----
CREATE TABLE IF NOT EXISTS uiot_cmd (
  id int(10) unsigned NOT NULL AUTO_INCREMENT,
  os char(32) NOT NULL,
  cpu char(32) NOT NULL,
  cmd varchar(500) NOT NULL,
  mode char(32) NOT NULL DEFAULT 'native',
  version char(100) NOT NULL DEFAULT '1.0',
  memory char(100) NOT NULL DEFAULT '128M',
  ram char(100) NOT NULL DEFAULT '256M',
  PRIMARY KEY (id),
  UNIQUE KEY version (version, os, cpu, mode)
) ENGINE=InnoDB AUTO_INCREMENT=13;


INSERT IGNORE INTO uiot_cmd (os, cpu, cmd, version, memory, ram, mode) VALUES('linux','X86_64', 'iot_edge_process.sh','1.1','>= 128M','>= 128M','native');

INSERT IGNORE INTO uiot_cmd (os, cpu, cmd, version, memory, ram, mode) VALUES('linux','ARMv8_64', 'iot_edge_process.sh','1.1','>= 128M','>= 128M','native');

INSERT IGNORE INTO uiot_cmd (os, cpu, cmd, version, memory, ram, mode) VALUES('linux','ARMv7', 'iot_edge_process.sh','1.1','>= 128M','>= 128M','native');


INSERT IGNORE INTO uiot_cmd (os, cpu, cmd, version, memory, ram, mode) VALUES('linux', 'X86_64', 'iot_edge_docker.sh', '1.1', '>= 1024M','>= 1024M','docker');

INSERT IGNORE INTO uiot_cmd (os, cpu, cmd, version, memory, ram, mode) VALUES('linux', 'ARMv8_64', 'iot_edge_docker.sh', '1.1', '>= 1024M','>= 1024M','docker');

update uiot_application set type='file' where type='user';

INSERT INTO uiot_config (name, config) SELECT 'hardware_validate_token', 'U5CtxvE56YkKBu2Uueo5BsoyvbhZDP1LHlHj7Wp4tDecFqWakKm7w' WHERE NOT EXISTS (SELECT id FROM uiot_config WHERE name = 'hardware_validate_token');

ALTER TABLE uiot_device ADD COLUMN hw_serial VARCHAR(128) DEFAULT '';
ALTER TABLE uiot_device ADD UNIQUE(hw_serial, id);


CREATE TABLE IF NOT EXISTS uiot_driver_version
(
    id                 INTEGER PRIMARY KEY AUTO_INCREMENT,
    driver_id          INT NOT NULL,
    version            CHAR(64)      NOT NULL,
    description        VARCHAR(1024) NOT NULL DEFAULT '',
    created_time       BIGINT                 DEFAULT 0,
    md5                CHAR(255)     NOT NULL DEFAULT '',
    config             TEXT,
    container_config   TEXT,
    sub_dev_config     TEXT,
    download_url       TEXT,
    UNIQUE (driver_id, version)
);


CREATE TABLE IF NOT EXISTS uiot_application_version
(
    id                 INTEGER PRIMARY KEY AUTO_INCREMENT,
    application_id     INT NOT NULL,
    type               CHAR(100)     NOT NULL,
    version            CHAR(64)      NOT NULL,
    description        VARCHAR(1024) NOT NULL DEFAULT '',
    created_time       BIGINT                 DEFAULT 0,
    md5                CHAR(255)     NOT NULL DEFAULT '',
    config             TEXT,
    container_config   TEXT,
    env_config         TEXT,
    address            TEXT,
    UNIQUE (application_id, version)
);

-- ALTER TABLE uiot_message_router ADD COLUMN is_enabled tinyint(1) DEFAULT '1';

-- start 1.3

ALTER TABLE uiot_rule_action MODIFY action_type ENUM('mongodb', 'kafka', 'tsdb', 'republish', 'mysql', 'http', 'pgsql', 'clickhouse') NOT NULL;

ALTER TABLE uiot_device ADD COLUMN session_id VARCHAR(128) DEFAULT '';

CREATE TABLE IF NOT EXISTS uiot_ota_device_version
(
    id INT PRIMARY KEY AUTO_INCREMENT,
    device_id INT NOT NULL,
    product_id INT NOT NULL,
    module CHAR(64) NOT NULL DEFAULT 'default',
    version CHAR(64) NOT NULL DEFAULT '-',  -- 不使用FirmwareID是因为固件可能被删除
    target_version CHAR(64) NOT NULL DEFAULT '',
    upgrade_status ENUM('init','pushing', 'pushed', 'upgrading', 'success', 'fail', 'cancel') DEFAULT 'init',
    update_time BIGINT DEFAULT 0,
    task_id INT NOT NULL DEFAULT 0,
    UNIQUE (device_id, module),
    KEY (device_id, task_id)
) AUTO_INCREMENT = 1;

CREATE TABLE IF NOT EXISTS uiot_ota_module(
    id INT PRIMARY KEY AUTO_INCREMENT,
    product_id INT NOT NULL,
    name CHAR(64) NOT NULL DEFAULT 'default',
    description VARCHAR(1024) NOT NULL DEFAULT '',
    create_time BIGINT DEFAULT 0,
    UNIQUE(product_id, name)
) AUTO_INCREMENT = 1;

CREATE TABLE IF NOT EXISTS uiot_ota_firmware
(
    id INT PRIMARY KEY AUTO_INCREMENT,
    module_id INT NOT NULL,
    version CHAR(64) NOT NULL,
    address VARCHAR(1024) NOT NULL,
    type ENUM('upload', 'address'),
    md5 CHAR(32) DEFAULT '', -- empty while type is address
    size INT DEFAULT 0, -- zero while type is address
    description VARCHAR(1024) NOT NULL DEFAULT '',
    create_time BIGINT NOT NULL,
    UNIQUE (module_id, version)
) AUTO_INCREMENT = 1;

CREATE TABLE IF NOT EXISTS uiot_ota_task
(
    id INT PRIMARY KEY AUTO_INCREMENT,
    name CHAR(64) NOT NULL DEFAULT '',
    type ENUM('version', 'device'),
    module_id INT NOT NULL,
    version CHAR(64) NOT NULL, -- 不使用FirmwareID是因为固件可能被删除
    firmware_id INT NOT NULL,
    speed INT DEFAULT 0, -- 0 means push notify message to all
    create_time BIGINT DEFAULT 0,
    description VARCHAR(1024) NOT NULL DEFAULT ''
) AUTO_INCREMENT = 1;

CREATE TABLE IF NOT EXISTS uiot_ota_task_device
(
    id INT PRIMARY KEY AUTO_INCREMENT,
    module_id INT NOT NULL,
    task_id INT NOT NULL,
    device_id INT NOT NULL,
    original_version CHAR(64) NOT NULL DEFAULT '-',
    status ENUM('init','pushing', 'pushed', 'upgrading', 'success', 'fail', 'cancel') DEFAULT 'init',
    update_time BIGINT DEFAULT 0,
    UNIQUE (task_id, device_id),
    INDEX (module_id)
) AUTO_INCREMENT = 1;

insert into uiot_ota_module (product_id,create_time) select id,created_time from uiot_product;

CREATE TABLE IF NOT EXISTS uiot_view
(
    id INT PRIMARY KEY AUTO_INCREMENT,
    product_id INT NOT NULL,
    project_id INT NOT NULL,
    product_sn VARCHAR(64) NOT NULL,
    product_name VARCHAR(64) NOT NULL,
    view_name VARCHAR(64) NOT NULL,
    description VARCHAR(1024) DEFAULT '',
    created_time BIGINT DEFAULT 0 ,
    UNIQUE (project_id, view_name),
    INDEX (product_id)
) AUTO_INCREMENT = 1;

CREATE TABLE IF NOT EXISTS uiot_view_data
(
    id INT PRIMARY KEY AUTO_INCREMENT,
    view_id INT NOT NULL,
    data_name CHAR(64) NOT NULL,
    description VARCHAR(1024) NOT NULL DEFAULT '',
    identifier CHAR(64)      NOT NULL,
    data_type ENUM('int32', 'float32', 'float64', 'bool', 'string', 'date', 'enum') NOT NULL,
    is_default tinyint(1) DEFAULT '0',
    configuration  text
) AUTO_INCREMENT = 1;

INSERT IGNORE INTO uiot_ota_module (product_id,create_time) select id,created_time from uiot_product;
INSERT IGNORE INTO uiot_ota_device_version (device_id, product_id) select id, product_id from uiot_device;

CREATE TABLE IF NOT EXISTS uiot_edge_ipc
(
    id INT PRIMARY KEY AUTO_INCREMENT,
    product_id INT NOT NULL,
    gateway_id  INT NOT NULL,
    name CHAR(64) NOT NULL DEFAULT '',
    identify CHAR(64) NOT NULL,
    rtsp CHAR(128) NOT NULL, 
    status BOOL NOT NULL DEFAULT TRUE,
    created_time BIGINT DEFAULT 0,
    description VARCHAR(1024) NOT NULL DEFAULT '',
    UNIQUE (gateway_id, name),
    UNIQUE (gateway_id, identify)
) AUTO_INCREMENT = 1;


CREATE TABLE IF NOT EXISTS uiot_screen
(
    id INT PRIMARY KEY AUTO_INCREMENT,
    project_id INT NOT NULL,
    name CHAR(64) NOT NULL DEFAULT '',
    created_time BIGINT DEFAULT 0,
    screen_count INT NOT NULL,
    default_play CHAR(32) NOT NULL,
    description VARCHAR(1024) NOT NULL DEFAULT '',
    UNIQUE (project_id, name)
) AUTO_INCREMENT = 1;


CREATE TABLE IF NOT EXISTS uiot_screen_ipc
(
    id INT PRIMARY KEY AUTO_INCREMENT,
    project_id INT NOT NULL,
    screen_id INT NOT NULL,
    edge_ipc_id INT NOT NULL,
    ipc_index INT NOT NULL,
    UNIQUE (screen_id, edge_ipc_id)
) AUTO_INCREMENT = 1;

ALTER TABLE uiot_rule_action MODIFY action_type ENUM('mongodb', 'kafka', 'tsdb', 'republish', 'mysql', 'http', 'pgsql', 'clickhouse', 'view') NOT NULL;

INSERT IGNORE INTO `uiot_system_topic` (`topic`, `topic_suffix`,`permission`, `module`, `topic_description`, `topic_usage`, `is_display`, `rule_engine_permission`, `is_open`) VALUES
('/$system/${ProductSN}/${DeviceSN}/ota/upstream','ota/upstream', 'pub', 6, 'ota上行消息', 'ota upstream', 1, '-', 0),
('/$system/${ProductSN}/${DeviceSN}/ota/downstream','ota/downstream', 'sub', 6, 'ota下行消息', 'ota downstream', 1, '-', 0);


INSERT IGNORE INTO uiot_cmd (os, cpu, cmd, version, memory, ram, mode) VALUES('linux','X86_64', 'iot_edge_process.sh','1.2','>= 128M','>= 128M','native');

INSERT IGNORE INTO uiot_cmd (os, cpu, cmd, version, memory, ram, mode) VALUES('linux','ARMv8_64', 'iot_edge_process.sh','1.2','>= 128M','>= 128M','native');

INSERT IGNORE INTO uiot_cmd (os, cpu, cmd, version, memory, ram, mode) VALUES('linux','ARMv7', 'iot_edge_process.sh','1.2','>= 128M','>= 128M','native');


INSERT IGNORE INTO uiot_cmd (os, cpu, cmd, version, memory, ram, mode) VALUES('linux', 'X86_64', 'iot_edge_docker.sh', '1.2', '>= 1024M','>= 1024M','docker');

INSERT IGNORE INTO uiot_cmd (os, cpu, cmd, version, memory, ram, mode) VALUES('linux', 'ARMv8_64', 'iot_edge_docker.sh', '1.2', '>= 1024M','>= 1024M','docker');

ALTER TABLE uiot_device drop COLUMN session_id;


INSERT IGNORE INTO `uiot_system_topic` (`topic`, `topic_suffix`,`permission`, `module`, `topic_description`, `topic_usage`, `is_display`, `rule_engine_permission`, `is_open`) VALUES
('/$system/${ProductSN}/${DeviceSN}/ipc/request','ipc/request', 'sub', 6, 'ipc下行消息', 'ipc request', 1, '-', 0),
('/$system/${ProductSN}/${DeviceSN}/ipc/reply','ipc/reply', 'pub', 6, 'ipc上行消息', 'ipc reply', 1, '-', 0);

ALTER TABLE uiot_view_data MODIFY data_type ENUM('int32', 'float32', 'float64', 'bool', 'string', 'dateTime', 'enum') NOT NULL;
