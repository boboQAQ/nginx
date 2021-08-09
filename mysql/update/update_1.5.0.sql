USE iot_stack;

ALTER TABLE uiot_user_project
    MODIFY user_id INT UNSIGNED NOT NULL;
ALTER TABLE uiot_user_project
    MODIFY project_id INT UNSIGNED NOT NULL;
ALTER TABLE uiot_user_project
    ADD CONSTRAINT fk_uiot_user_project_user_id FOREIGN KEY (user_id) REFERENCES uiot_user (id);
ALTER TABLE uiot_user_project
    ADD CONSTRAINT fk_uiot_user_project_project_id FOREIGN KEY (project_id) REFERENCES uiot_project (id);

ALTER TABLE uiot_product
    MODIFY project_id INT UNSIGNED NOT NULL;
ALTER TABLE uiot_product
    ADD CONSTRAINT fk_uiot_product_project_id FOREIGN KEY (project_id) REFERENCES uiot_project (id);

ALTER TABLE uiot_topic
    MODIFY product_id INT UNSIGNED NOT NULL;
ALTER TABLE uiot_topic
    ADD CONSTRAINT fk_uiot_topic_product_id FOREIGN KEY (product_id) REFERENCES uiot_product (id);

ALTER TABLE uiot_device
    MODIFY product_id INT UNSIGNED NOT NULL;
ALTER TABLE uiot_device
    ADD CONSTRAINT fk_uiot_device_product_id FOREIGN KEY (product_id) REFERENCES uiot_product (id);

ALTER TABLE uiot_edge_subdev
    MODIFY gateway_id INT UNSIGNED NOT NULL;
ALTER TABLE uiot_edge_subdev
    MODIFY subdev_id INT UNSIGNED NOT NULL;
ALTER TABLE uiot_edge_subdev
    ADD CONSTRAINT fk_uiot_edge_subdev_gateway_id FOREIGN KEY (gateway_id) REFERENCES uiot_device (id);
ALTER TABLE uiot_edge_subdev
    ADD CONSTRAINT fk_uiot_edge_subdev_subdev_id FOREIGN KEY (subdev_id) REFERENCES uiot_device (id);

ALTER TABLE uiot_rule
    MODIFY project_id INT UNSIGNED NOT NULL;
ALTER TABLE uiot_rule
    ADD CONSTRAINT fk_uiot_rule_project_id FOREIGN KEY (project_id) REFERENCES uiot_project (id);
ALTER TABLE uiot_rule
    ADD CONSTRAINT fk_uiot_rule_product_sn FOREIGN KEY (product_sn) REFERENCES uiot_product (product_sn);

ALTER TABLE uiot_rule_action
    MODIFY rule_id INT UNSIGNED NOT NULL;
ALTER TABLE uiot_rule_action
    ADD CONSTRAINT fk_uiot_rule_action_rule_id FOREIGN KEY (rule_id) REFERENCES uiot_rule (id);

ALTER TABLE uiot_function
    MODIFY project_id INT UNSIGNED NOT NULL;
ALTER TABLE uiot_function
    ADD CONSTRAINT fk_uiot_function_project_id FOREIGN KEY (project_id) REFERENCES uiot_project (id);

ALTER TABLE uiot_edge_function
    ADD CONSTRAINT fk_uiot_edge_function_function_id FOREIGN KEY (function_id) REFERENCES uiot_function (id);
ALTER TABLE uiot_edge_function
    ADD CONSTRAINT fk_uiot_edge_function_gateway_id FOREIGN KEY (gateway_id) REFERENCES uiot_device (id);

ALTER TABLE uiot_driver
    MODIFY project_id INT UNSIGNED NOT NULL;
ALTER TABLE uiot_driver
    ADD CONSTRAINT fk_uiot_driver_project_id FOREIGN KEY (project_id) REFERENCES uiot_project (id);

ALTER TABLE uiot_edge_driver
    MODIFY gateway_id INT UNSIGNED NOT NULL;
ALTER TABLE uiot_edge_driver
    ADD CONSTRAINT fk_uiot_edge_driver_driver_id FOREIGN KEY (driver_id) REFERENCES uiot_driver (id);
ALTER TABLE uiot_edge_driver
    ADD CONSTRAINT fk_uiot_edge_driver_gateway_id FOREIGN KEY (gateway_id) REFERENCES uiot_device (id);

ALTER TABLE uiot_driver_subdev
    MODIFY edge_driver_id INT UNSIGNED NOT NULL;
ALTER TABLE uiot_driver_subdev
    MODIFY subdev_id INT UNSIGNED NOT NULL;
ALTER TABLE uiot_driver_subdev
    ADD CONSTRAINT fk_uiot_driver_subdev_edge_driver_id FOREIGN KEY (edge_driver_id) REFERENCES uiot_edge_driver (id);
ALTER TABLE uiot_driver_subdev
    ADD CONSTRAINT fk_uiot_driver_subdev_subdev_id FOREIGN KEY (subdev_id) REFERENCES uiot_device (id);

ALTER TABLE uiot_edge_deployment
    MODIFY gateway_id INT UNSIGNED NOT NULL;
ALTER TABLE uiot_edge_deployment
    ADD CONSTRAINT fk_uiot_edge_deployment_gateway_id FOREIGN KEY (gateway_id) REFERENCES uiot_device (id);

ALTER TABLE uiot_edge_config
    MODIFY gateway_id INT UNSIGNED NOT NULL;
ALTER TABLE uiot_edge_config
    ADD CONSTRAINT fk_uiot_edge_config_gateway_id FOREIGN KEY (gateway_id) REFERENCES uiot_device (id);

ALTER TABLE uiot_edge_monitor
    MODIFY gateway_id INT UNSIGNED NOT NULL;
ALTER TABLE uiot_edge_monitor
    ADD CONSTRAINT fk_uiot_edge_monitor_gateway_id FOREIGN KEY (gateway_id) REFERENCES uiot_device (id);

ALTER TABLE uiot_message_router
    MODIFY product_id INT UNSIGNED NOT NULL;
ALTER TABLE uiot_message_router
    MODIFY device_id INT UNSIGNED NOT NULL;
ALTER TABLE uiot_message_router
    ADD CONSTRAINT fk_uiot_message_router_product_id FOREIGN KEY (product_id) REFERENCES uiot_product (id);
ALTER TABLE uiot_message_router
    ADD CONSTRAINT fk_uiot_message_router_device_id FOREIGN KEY (device_id) REFERENCES uiot_device (id);

ALTER TABLE product_script
    MODIFY product_id INT UNSIGNED NOT NULL;
ALTER TABLE product_script
    ADD CONSTRAINT fk_product_script_product_id FOREIGN KEY (product_id) REFERENCES uiot_product (id);

ALTER TABLE uiot_application
    MODIFY project_id INT UNSIGNED NOT NULL;
ALTER TABLE uiot_application
    ADD CONSTRAINT fk_uiot_application_product_id FOREIGN KEY (project_id) REFERENCES uiot_project (id);

ALTER TABLE uiot_edge_application
    MODIFY gateway_id INT UNSIGNED NOT NULL;
ALTER TABLE uiot_edge_application
    ADD CONSTRAINT fk_uiot_edge_application_gateway_id FOREIGN KEY (gateway_id) REFERENCES uiot_device (id);
ALTER TABLE uiot_edge_application
    ADD CONSTRAINT fk_uiot_edge_application_application_id FOREIGN KEY (application_id) REFERENCES uiot_application (id);

ALTER TABLE uiot_driver_version
    ADD CONSTRAINT fk_uiot_driver_version_driver_id FOREIGN KEY (driver_id) REFERENCES uiot_driver (id);

ALTER TABLE uiot_application_version
    ADD CONSTRAINT fk_uiot_application_version_application_id FOREIGN KEY (application_id) REFERENCES uiot_application (id);

ALTER TABLE uiot_ota_device_version
    MODIFY device_id INT UNSIGNED NOT NULL;
ALTER TABLE uiot_ota_device_version
    MODIFY product_id INT UNSIGNED NOT NULL;
ALTER TABLE uiot_ota_device_version
    ADD CONSTRAINT fk_uiot_ota_device_version_device_id FOREIGN KEY (device_id) REFERENCES uiot_device (id);
ALTER TABLE uiot_ota_device_version
    ADD CONSTRAINT fk_uiot_ota_device_version_product_id FOREIGN KEY (product_id) REFERENCES uiot_product (id);

ALTER TABLE uiot_ota_module
    MODIFY product_id INT UNSIGNED NOT NULL;
ALTER TABLE uiot_ota_module
    ADD CONSTRAINT fk_uiot_ota_module_product_id FOREIGN KEY (product_id) REFERENCES uiot_product (id);

ALTER TABLE uiot_ota_firmware
    ADD CONSTRAINT fk_uiot_ota_firmware_module_id FOREIGN KEY (module_id) REFERENCES uiot_ota_module (id);

ALTER TABLE uiot_ota_task
    ADD CONSTRAINT fk_uiot_ota_task_module_id FOREIGN KEY (module_id) REFERENCES uiot_ota_module (id);

ALTER TABLE uiot_ota_task_device
    MODIFY device_id INT UNSIGNED NOT NULL;
ALTER TABLE uiot_ota_task_device
    ADD CONSTRAINT fk_uiot_ota_task_device_task_id FOREIGN KEY (task_id) REFERENCES uiot_ota_task (id);
ALTER TABLE uiot_ota_task_device
    ADD CONSTRAINT fk_uiot_ota_task_device_device_id FOREIGN KEY (device_id) REFERENCES uiot_device (id);

ALTER TABLE uiot_view
    MODIFY product_id INT UNSIGNED NOT NULL;
ALTER TABLE uiot_view
    MODIFY project_id INT UNSIGNED NOT NULL;
ALTER TABLE uiot_view
    ADD CONSTRAINT fk_uiot_view_product_id FOREIGN KEY (product_id) REFERENCES uiot_product (id);
ALTER TABLE uiot_view
    ADD CONSTRAINT fk_uiot_view_project_id FOREIGN KEY (project_id) REFERENCES uiot_project (id);

ALTER TABLE uiot_view_data
    ADD CONSTRAINT fk_uiot_view_data_view_id FOREIGN KEY (view_id) REFERENCES uiot_view (id);

ALTER TABLE uiot_edge_ipc
    MODIFY product_id INT UNSIGNED NOT NULL;
ALTER TABLE uiot_edge_ipc
    MODIFY gateway_id INT UNSIGNED NOT NULL;
ALTER TABLE uiot_edge_ipc
    ADD CONSTRAINT fk_uiot_edge_ipc_product_id FOREIGN KEY (product_id) REFERENCES uiot_product (id);
ALTER TABLE uiot_edge_ipc
    ADD CONSTRAINT fk_uiot_edge_ipc_gateway_id FOREIGN KEY (gateway_id) REFERENCES uiot_device (id);

ALTER TABLE uiot_screen
    MODIFY project_id INT UNSIGNED NOT NULL;
ALTER TABLE uiot_screen
    ADD CONSTRAINT fk_uiot_screen_project_id FOREIGN KEY (project_id) REFERENCES uiot_project (id);

ALTER TABLE uiot_screen_ipc
    MODIFY project_id INT UNSIGNED NOT NULL;
ALTER TABLE uiot_screen_ipc
    ADD CONSTRAINT fk_uiot_screen_ipc_project_id FOREIGN KEY (project_id) REFERENCES uiot_project (id);
ALTER TABLE uiot_screen_ipc
    ADD CONSTRAINT fk_uiot_screen_ipc_screen_id FOREIGN KEY (screen_id) REFERENCES uiot_screen (id);
ALTER TABLE uiot_screen_ipc
    ADD CONSTRAINT fk_uiot_screen_ipc_edge_ipc_id FOREIGN KEY (edge_ipc_id) REFERENCES uiot_edge_ipc (id);

ALTER TABLE uiot_edge_subdev
    ADD COLUMN alias VARCHAR(64) NULL;
ALTER TABLE uiot_edge_subdev
    ADD UNIQUE uni_uiot_edge_subdev_gateway_id_alias (gateway_id, alias);

CREATE TABLE IF NOT EXISTS uiot_template
(
    id                 INT UNSIGNED AUTO_INCREMENT,
    product_id         INT UNSIGNED  NOT NULL,
    name               CHAR(32)      NOT NULL,
    description        VARCHAR(1024) NOT NULL DEFAULT '',
    created_time       BIGINT                 DEFAULT 0,
    last_modified_time BIGINT                 DEFAULT 0,
    source_product_sn  CHAR(16)      NOT NULL,
    source_device_sn   CHAR(64)      NOT NULL,
    PRIMARY KEY (id),
    UNIQUE (product_id, name)
) ENGINE = InnoDB
  AUTO_INCREMENT = 1;

ALTER TABLE uiot_template
    ADD CONSTRAINT fk_uiot_template_product_id FOREIGN KEY (product_id) REFERENCES uiot_product (id);

CREATE TABLE IF NOT EXISTS uiot_template_alias
(
    id                 INT UNSIGNED AUTO_INCREMENT,
    template_id        INT UNSIGNED  NOT NULL,
    sub_dev_product_id INT UNSIGNED  NOT NULL,
    sub_dev_alias      CHAR(32)      NOT NULL,
    description        VARCHAR(1024) NOT NULL DEFAULT '',
    PRIMARY KEY (id),
    UNIQUE (template_id, sub_dev_product_id, sub_dev_alias)
) ENGINE = InnoDB
  AUTO_INCREMENT = 1;

ALTER TABLE uiot_template_alias
    ADD CONSTRAINT fk_uiot_template_alias_template_id FOREIGN KEY (template_id) REFERENCES uiot_template (id);
ALTER TABLE uiot_template_alias
    ADD CONSTRAINT fk_uiot_template_alias_sub_dev_product_id FOREIGN KEY (sub_dev_product_id) REFERENCES uiot_product (id);

CREATE TABLE IF NOT EXISTS uiot_template_driver
(
    id               INT UNSIGNED AUTO_INCREMENT,
    driver_id        INT          NOT NULL,
    template_id      INT UNSIGNED NOT NULL,
    version          CHAR(32)     NOT NULL,
    config           TEXT,
    container_config TEXT,
    PRIMARY KEY (id),
    UNIQUE (template_id, driver_id)
) ENGINE = InnoDB
  AUTO_INCREMENT = 1;

ALTER TABLE uiot_template_driver
    ADD CONSTRAINT fk_uiot_template_driver_driver_id FOREIGN KEY (driver_id) REFERENCES uiot_driver (id);
ALTER TABLE uiot_template_driver
    ADD CONSTRAINT fk_uiot_template_driver_template_id FOREIGN KEY (template_id) REFERENCES uiot_template (id);

CREATE TABLE IF NOT EXISTS uiot_template_driver_alias 
(
    id                 INT UNSIGNED AUTO_INCREMENT,
    template_driver_id INT UNSIGNED NOT NULL,
    template_alias_id  INT UNSIGNED NULL,
    config             TEXT,
    PRIMARY KEY (id),
    UNIQUE (template_driver_id, template_alias_id)
) ENGINE = InnoDB
  AUTO_INCREMENT = 1;

ALTER TABLE uiot_template_driver_alias
    ADD CONSTRAINT fk_uiot_template_driver_alias_template_driver_id FOREIGN KEY (template_driver_id) REFERENCES uiot_template_driver (id);
ALTER TABLE uiot_template_driver_alias
    ADD CONSTRAINT fk_uiot_template_driver_alias_id FOREIGN KEY (template_alias_id) REFERENCES uiot_template_alias (id);

CREATE TABLE IF NOT EXISTS uiot_template_function 
(
    id              INT UNSIGNED AUTO_INCREMENT,
    function_id     INT UNSIGNED NOT NULL,
    template_id     INT UNSIGNED NOT NULL,
    function_config TEXT,
    cron            VARCHAR(64)  NOT NULL DEFAULT '',
    cron_enable     BOOL         NOT NULL DEFAULT FALSE,
    PRIMARY KEY (id),
    UNIQUE (function_id, template_id)
) ENGINE = InnoDB
  AUTO_INCREMENT = 1;

ALTER TABLE uiot_template_function
    ADD CONSTRAINT fk_uiot_template_function_function_id FOREIGN KEY (function_id) REFERENCES uiot_function (id);
ALTER TABLE uiot_template_function
    ADD CONSTRAINT fk_uiot_template_function_template_id FOREIGN KEY (template_id) REFERENCES uiot_template (id);

CREATE TABLE IF NOT EXISTS uiot_template_application 
(
    id               INT UNSIGNED AUTO_INCREMENT,
    application_id   INT          NOT NULL,
    version          CHAR(32)     NOT NULL,
    template_id      INT UNSIGNED NOT NULL,
    config           TEXT,
    container_config TEXT,
    env_config       TEXT,
    PRIMARY KEY (id),
    UNIQUE (template_id, application_id)
) ENGINE = InnoDB
  AUTO_INCREMENT = 1;

ALTER TABLE uiot_template_application
    ADD CONSTRAINT fk_uiot_template_application_application_id FOREIGN KEY (application_id) REFERENCES uiot_application (id);
ALTER TABLE uiot_template_application
    ADD CONSTRAINT fk_uiot_template_application_template_id FOREIGN KEY (template_id) REFERENCES uiot_template (id);

CREATE TABLE IF NOT EXISTS uiot_template_message_router
(
    id                int(10) unsigned NOT NULL AUTO_INCREMENT,
    template_id       INT UNSIGNED     NOT NULL,
    product_sn        char(16)         NOT NULL,
    device_sn         char(64)         NOT NULL,
    router_name       varchar(100)     NOT NULL,
    description       varchar(100) DEFAULT '',
    src_type          varchar(20)      NOT NULL,
    src_id            varchar(32)  DEFAULT '',
    dest_type         varchar(20)      NOT NULL,
    dest_id           varchar(32)  DEFAULT '',
    is_cached         tinyint(1)   DEFAULT '0',
    is_parser         tinyint(1)   DEFAULT '0',
    filter_topic      varchar(100)     NOT NULL,
    topic_suffix      varchar(100)     NOT NULL,
    filter_topic_type varchar(10)      NOT NULL,
    PRIMARY KEY (id),
    UNIQUE (template_id, router_name)
) ENGINE = InnoDB
  AUTO_INCREMENT = 1;

ALTER TABLE uiot_template_message_router
    ADD CONSTRAINT fk_uiot_template_message_router_template_id FOREIGN KEY (template_id) REFERENCES uiot_template (id);
ALTER TABLE uiot_template_message_router
    ADD CONSTRAINT fk_uiot_template_message_router_product_sn FOREIGN KEY (product_sn) REFERENCES uiot_product (product_sn);

ALTER TABLE uiot_device
    ADD COLUMN template_id INT UNSIGNED NULL;

ALTER TABLE uiot_message_router ADD COLUMN is_parser tinyint(1) DEFAULT '0';
UPDATE uiot_config SET config = 'IiIiCuiuvuWkh+S4iuaKpUlvVOW5s+WPsOaVsOaNruetm+mAieekuuS+iwoxLiDlrZDorr7lpIflvoDlh73mlbDorqHnrpflj5HpgIHkuIDkuKoganNvbiDmtojmga/vvIzmoLzlvI/lpoLkuIsKewogICAgImlkIjogMTIzNDU2LAogICAgImNlbHNpdXMiOiAxMjAKfQrooajnpLogaWQg5Li6IDEyMzQ1Nu+8jOa4qeW6puS4uiAxMjAg5pGE5rCP5bqmCjIuIOWHveaVsOiuoeeul+agueaNruadoeS7tuetm+mAieaVsOaNru+8jOWunuS+i+S4reeahOetm+mAieadoeS7tuS4ugpjZWxzaXVzID4gMTAwCjMuIOWwhuaRhOawj+W6pui9rOaNouS4uuWNjuawj+W6pgpjZWxzaXVzIC0+IGZhaHJlbmhlaXQKNC4g5rOo5oSP77yM5raI5oGv5rWB6L2s6ZyA6KaB6YWN572u55u45bqU55qE5raI5oGv6Lev55SxCiIiIgoKCmltcG9ydCBqc29uCmltcG9ydCBsb2dnaW5nCiMgaW1wb3J0IHJlcXVlc3RzICMg55So5LqOaHR0cOiuv+mXruWklumDqOivt+axggoKCmRlZiBoYW5kbGVyKGV2ZW50LCBjb250ZXh0KToKICAgIHNkayA9IGNvbnRleHRbJ3NkayddCiAgICB0cnk6CiAgICAgICAgc2RrLmxvZ2dlci5pbmZvKCJmdW5jdGlvbiBjb25maWc6IHt9Ii5mb3JtYXQoc2RrLmNvbmZpZykpICMgY29udGV4dFsnc2RrJ10uY29uZmlnIOeUqOS6juiOt+WPluWHveaVsOeahOmFjee9ruS/oeaBrwogICAgICAgICMg6K6w5b2V5b2T5YmN5Ye95pWw6LCD55So55qE5qyh5pWwCiAgICAgICAgc2RrLnJlZGlzX2NsaWVudC5pbmNyKCJjb3VudCIpCiAgICAgICAgIyDml6Xlv5fovpPlh7rvvIzlj6/pgJrov4fmnKzlnLB3ZWJwcm90YWzov5vooYzmn6XnnIsKICAgICAgICBzZGsubG9nZ2VyLmluZm8oImZ1bmN0aW9uIGNhbGxlZCB7fSB0aW1lcyIuZm9ybWF0KHNkay5yZWRpc19jbGllbnQuZ2V0KCJjb3VudCIpLmRlY29kZSgpKSkKCiAgICAgICAgIyBjb250ZXh0WydzZGsnXS5wcm9kdWN0X3NuIOeUqOS6juiOt+WPlue9keWFs+S6p+WTgeW6j+WIl+WPtwogICAgICAgICMgY29udGV4dFsnc2RrJ10uZGV2aWNlX3NuIOeUqOS6juiOt+WPlue9keWFs+iuvuWkh+W6j+WIl+WPtwoKICAgICAgICAjIOiOt+WPlua2iOaBryB0b3BpYwogICAgICAgIGxvY2FsX3RvcGljID0gZXZlbnRbInRvcGljIl0KICAgICAgICAjIHBheWxvYWQg5Li6IGJ5dGVzIOexu+Wei++8jOmcgOino+eggeS4uuWtl+espuS4sgogICAgICAgIG1zZyA9IGpzb24ubG9hZHMoZXZlbnRbInBheWxvYWQiXS5kZWNvZGUoJ3V0Zi04JykpCgogICAgICAgIGlmIG1zZ1siY2Vsc2l1cyJdID4gMTAwOgogICAgICAgICAgICAjIGNsb3VkX3RvcGljIOWPr+S7jiBsb2NhbF90b3BpYyDnu4/ov4foh6rlrprkuYnnmoTovazmjaLlvpfliLAKICAgICAgICAgICAgY2xvdWRfdG9waWMgPSBsb2NhbF90b3BpYyArICIvdG9fY2xvdWQiCiAgICAgICAgICAgICMg6L2s5o2i5Li65Y2O5rCP5rip5qCHCiAgICAgICAgICAgIG1zZ1siZmFocmVuaGVpdCJdID0gbXNnWyJjZWxzaXVzIl0gKiAxLjggKyAzMgogICAgICAgICAgICBwYXlsb2FkID0ganNvbi5kdW1wcyhtc2cpLmVuY29kZSgndXRmLTgnKQogICAgICAgICAgICAjIOWQkeaMh+WumiB0b3BpYyDlj5HpgIHmtojmga8KICAgICAgICAgICAgc2RrLnB1Ymxpc2goY2xvdWRfdG9waWMsIHBheWxvYWQpCiAgICAgICAgICAgICMg5Y+R6YCB5raI5oGv5Yiw5pys5ZywbmF0cwogICAgICAgICAgICBzZGsucHVibGlzaF9uYXRzX21zZygibmF0c190b3BpY19zYW1wbGUiLCBwYXlsb2FkKQoKICAgIGV4Y2VwdCBFeGNlcHRpb246CiAgICAgICAgbG9nZ2luZy5leGNlcHRpb24oY29udGV4dCk=' WHERE name = 'function_code';

INSERT IGNORE INTO `uiot_system_topic` (`topic`, `topic_suffix`,`permission`, `module`, `topic_description`, `topic_usage`, `is_display`, `rule_engine_permission`, `is_open`) VALUES
('/$system/${ProductSN}/${DeviceSN}/config/request','config/request', 'sub', 6, '下发config配置到设备', 'config request', 1, '-', 0),
('/$system/${ProductSN}/${DeviceSN}/config/response','config/response', 'pub', 6, '设备config设置的回复', 'config response', 1, 'sub', 0);
ALTER TABLE uiot_edge_config ADD COLUMN max_count INT NOT NULL;
ALTER TABLE uiot_edge_config ADD COLUMN max_duration INT NOT NULL;

INSERT INTO uiot_config (name, config) SELECT 'view_clickhouse_address', '' WHERE NOT EXISTS (SELECT id FROM uiot_config WHERE name = 'view_clickhouse_address');
INSERT INTO uiot_config (name, config) SELECT 'view_clickhouse_database', '' WHERE NOT EXISTS (SELECT id FROM uiot_config WHERE name = 'view_clickhouse_database');
INSERT INTO uiot_config (name, config) SELECT 'view_clickhouse_cluster', '' WHERE NOT EXISTS (SELECT id FROM uiot_config WHERE name = 'view_clickhouse_cluster');
INSERT INTO uiot_config (name, config) SELECT 'view_clickhouse_expire', '' WHERE NOT EXISTS (SELECT id FROM uiot_config WHERE name = 'view_clickhouse_expire');
INSERT INTO uiot_config (name, config) SELECT 'view_clickhouse_engine', '' WHERE NOT EXISTS (SELECT id FROM uiot_config WHERE name = 'view_clickhouse_engine');

DELETE from uiot_cmd WHERE version = '1.1';

ALTER TABLE uiot_rule MODIFY COLUMN sql_select text;

CREATE TABLE IF NOT EXISTS hw_serial_upload (
    id            INT UNSIGNED AUTO_INCREMENT,
    hw_serial     VARCHAR(128) NOT NULL,
    upload_time   BIGINT       DEFAULT 0,
    PRIMARY KEY (id),
    UNIQUE (hw_serial),
    UNIQUE (upload_time)
) ENGINE=InnoDB;
