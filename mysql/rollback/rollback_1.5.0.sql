ALTER TABLE uiot_edge_subdev ADD UNIQUE CONSTRAINT uni_uiot_edge_subdev_gateway_id_alias (gateway_id, alias);
ALTER TABLE uiot_edge_subdev DROP COLUMN alias;
ALTER TABLE uiot_edge_subdev DROP UNIQUE uni_uiot_edge_subdev_gateway_id_alias;

ALTER TABLE uiot_user_project DROP FOREIGN KEY fk_uiot_user_project_user_id;
ALTER TABLE uiot_user_project DROP FOREIGN KEY fk_uiot_user_project_project_id;

ALTER TABLE uiot_product DROP FOREIGN KEY fk_uiot_product_project_id;

ALTER TABLE uiot_topic DROP FOREIGN KEY fk_uiot_topic_product_id;

ALTER TABLE uiot_device DROP FOREIGN KEY fk_uiot_device_product_id;

ALTER TABLE uiot_edge_subdev DROP FOREIGN KEY fk_uiot_edge_subdev_gateway_id;
ALTER TABLE uiot_edge_subdev DROP FOREIGN KEY fk_uiot_edge_subdev_subdev_id;

ALTER TABLE uiot_rule DROP FOREIGN KEY fk_uiot_rule_project_id;
ALTER TABLE uiot_rule DROP FOREIGN KEY fk_uiot_rule_product_sn;

ALTER TABLE uiot_rule_action DROP FOREIGN KEY fk_uiot_rule_action_rule_id;

ALTER TABLE uiot_function DROP FOREIGN KEY fk_uiot_function_project_id;

ALTER TABLE uiot_edge_function DROP FOREIGN KEY fk_uiot_edge_function_function_id;
ALTER TABLE uiot_edge_function DROP FOREIGN KEY fk_uiot_edge_function_gateway_id;

ALTER TABLE uiot_driver DROP FOREIGN KEY fk_uiot_driver_project_id;

ALTER TABLE uiot_edge_driver DROP FOREIGN KEY fk_uiot_edge_driver_driver_id;
ALTER TABLE uiot_edge_driver DROP FOREIGN KEY fk_uiot_edge_driver_gateway_id;

ALTER TABLE uiot_driver_subdev DROP FOREIGN KEY fk_uiot_driver_subdev_edge_driver_id;
ALTER TABLE uiot_driver_subdev DROP FOREIGN KEY fk_uiot_driver_subdev_subdev_id;

ALTER TABLE uiot_edge_deployment DROP FOREIGN KEY fk_uiot_edge_deployment_gateway_id;

ALTER TABLE uiot_edge_config DROP FOREIGN KEY fk_uiot_edge_config_gateway_id;

ALTER TABLE uiot_edge_monitor DROP FOREIGN KEY fk_uiot_edge_monitor_gateway_id;

ALTER TABLE uiot_message_router DROP FOREIGN KEY fk_uiot_message_router_product_id;
ALTER TABLE uiot_message_router DROP FOREIGN KEY fk_uiot_message_router_device_id;

ALTER TABLE product_script DROP FOREIGN KEY fk_product_script_product_id;

ALTER TABLE uiot_application DROP FOREIGN KEY fk_uiot_application_product_id;

ALTER TABLE uiot_edge_application DROP FOREIGN KEY fk_uiot_edge_application_gateway_id;
ALTER TABLE uiot_edge_application DROP FOREIGN KEY fk_uiot_edge_application_application_id;

ALTER TABLE uiot_driver_version DROP FOREIGN KEY fk_uiot_driver_version_driver_id;

ALTER TABLE uiot_application_version DROP FOREIGN KEY fk_uiot_application_version_application_id;

ALTER TABLE uiot_ota_device_version DROP FOREIGN KEY fk_uiot_ota_device_version_device_id;
ALTER TABLE uiot_ota_device_version DROP FOREIGN KEY fk_uiot_ota_device_version_product_id;

ALTER TABLE uiot_ota_module DROP FOREIGN KEY fk_uiot_ota_module_product_id;

ALTER TABLE uiot_ota_firmware DROP FOREIGN KEY fk_uiot_ota_firmware_module_id;

ALTER TABLE uiot_ota_task DROP FOREIGN KEY fk_uiot_ota_task_module_id;

ALTER TABLE uiot_ota_task_device DROP FOREIGN KEY fk_uiot_ota_task_device_task_id;
ALTER TABLE uiot_ota_task_device DROP FOREIGN KEY fk_uiot_ota_task_device_device_id;

ALTER TABLE uiot_view DROP FOREIGN KEY fk_uiot_view_product_id;
ALTER TABLE uiot_view DROP FOREIGN KEY fk_uiot_view_project_id;

ALTER TABLE uiot_view_data DROP FOREIGN KEY fk_uiot_view_data_view_id;

ALTER TABLE uiot_edge_ipc DROP FOREIGN KEY fk_uiot_edge_ipc_product_id;
ALTER TABLE uiot_edge_ipc DROP FOREIGN KEY fk_uiot_edge_ipc_gateway_id;

ALTER TABLE uiot_screen DROP FOREIGN KEY fk_uiot_screen_project_id;

ALTER TABLE uiot_screen_ipc DROP FOREIGN KEY fk_uiot_screen_ipc_project_id;
ALTER TABLE uiot_screen_ipc DROP FOREIGN KEY fk_uiot_screen_ipc_screen_id;
ALTER TABLE uiot_screen_ipc DROP FOREIGN KEY fk_uiot_screen_ipc_edge_ipc_id;

