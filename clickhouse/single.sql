CREATE DATABASE IF NOT EXISTS iot_stack;
CREATE DATABASE IF NOT EXISTS iot_stack_view;

CREATE TABLE IF NOT EXISTS iot_stack.message_log (
    product_sn String,
    device_sn String,
    message_id String,
    status Enum8('succeed'=1, 'failed'=2),
    reason String,
    topic String,
    direction Enum8('uplink'=1, 'downlink'=2),
    module String,
    payload String,
    content String,
    timestamp DateTime64(9),
    INDEX inx_msg (message_id) TYPE bloom_filter() GRANULARITY 5
) ENGINE=MergeTree() ORDER BY (product_sn, device_sn, timestamp) PARTITION BY toYYYYMMDD(timestamp)
TTL toDateTime(timestamp) + INTERVAL 3 MONTH DELETE;

CREATE TABLE IF NOT EXISTS iot_stack.action_log (
    product_sn String,
    device_sn String,
    action String,
    message_id String,
    status String,
    topic String,
    reason String,
    timestamp DateTime64(9),
    INDEX inx_msg (message_id) TYPE bloom_filter() GRANULARITY 5
) ENGINE=MergeTree() ORDER BY (product_sn, device_sn, timestamp) PARTITION BY toYYYYMMDD(timestamp)
TTL toDateTime(timestamp) + INTERVAL 3 MONTH DELETE;

CREATE TABLE IF NOT EXISTS iot_stack.uplink (
    project_id UInt64,
    product_sn String,
    count Int,
    timestamp DateTime
) ENGINE=MergeTree() ORDER BY (project_id, product_sn, timestamp) PARTITION BY toYYYYMMDD(timestamp)
TTL timestamp + INTERVAL 3 MONTH DELETE;

CREATE TABLE IF NOT EXISTS iot_stack.downlink (
    project_id UInt64,
    product_sn String,
    count Int,
    timestamp DateTime
) ENGINE=MergeTree() ORDER BY (project_id, product_sn, timestamp) PARTITION BY toYYYYMMDD(timestamp)
TTL timestamp + INTERVAL 3 MONTH DELETE;

CREATE TABLE IF NOT EXISTS iot_stack.product_online_device (
    product_sn String,
    count Int,
    timestamp DateTime
) ENGINE=MergeTree() ORDER BY (product_sn, timestamp) PARTITION BY toYYYYMMDD(timestamp)
TTL timestamp + INTERVAL 3 MONTH DELETE;

CREATE TABLE IF NOT EXISTS iot_stack.project_online_device (
    project_id UInt64,
    count Int,
    timestamp DateTime
) ENGINE=MergeTree() ORDER BY (project_id, timestamp) PARTITION BY toYYYYMMDD(timestamp)
TTL timestamp + INTERVAL 3 MONTH DELETE;


CREATE TABLE IF NOT EXISTS iot_stack.operation_log (
    project_name String,
    type String,
    message_id String,
    object String,
    user String,
    content String,
    description String,
    timestamp DateTime64(9),
    INDEX inx_msg (message_id) TYPE bloom_filter() GRANULARITY 5
) ENGINE=MergeTree() ORDER BY (project_name, type, timestamp) PARTITION BY toYYYYMMDD(timestamp)
      TTL toDateTime(timestamp) + INTERVAL 3 MONTH DELETE;

