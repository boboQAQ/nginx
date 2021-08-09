ALTER TABLE uiot_device
     ADD CONSTRAINT fk_uiot_device_template_id FOREIGN KEY (template_id) REFERENCES uiot_template (id);

ALTER TABLE uiot_template_message_router
    ADD COLUMN is_gateway_device BOOL DEFAULT FALSE;