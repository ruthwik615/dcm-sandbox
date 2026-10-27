DEFINE DATABASE dcm_sample{{env_suffix}};

DEFINE SCHEMA dcm_sample{{env_suffix}}.ref;

DEFINE TABLE dcm_sample{{env_suffix}}.ref.sample_table (
    id NUMBER(38,0) COMMENT 'Row identifier',
    name VARCHAR(100) COMMENT 'Sample name'
);
