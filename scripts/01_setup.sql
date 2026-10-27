-- 01_setup.sql  (run ONCE in a Snowsight worksheet, outside the DCM project folder)

-- 1. Find your account identifier for manifest.yml (ORGNAME-ACCOUNTNAME)
USE ROLE ACCOUNTADMIN;
SELECT CURRENT_ORGANIZATION_NAME() || '-' || CURRENT_ACCOUNT_NAME() AS account_identifier,
       CURRENT_USER() AS user_name;

-- 2. Developer role with the account-level privileges the project needs
CREATE ROLE IF NOT EXISTS dcm_developer;
SET user_name = (SELECT CURRENT_USER());
GRANT ROLE dcm_developer TO USER IDENTIFIER($user_name);

GRANT CREATE DATABASE  ON ACCOUNT TO ROLE dcm_developer;
GRANT CREATE WAREHOUSE ON ACCOUNT TO ROLE dcm_developer;

-- 3. Host database/schema for the DCM project objects, plus one project per environment
USE ROLE dcm_developer;

CREATE DATABASE IF NOT EXISTS dcm_sandbox;
CREATE SCHEMA   IF NOT EXISTS dcm_sandbox.projects;

CREATE DCM PROJECT IF NOT EXISTS dcm_sandbox.projects.sample_dev
    COMMENT = 'DCM sandbox - DEV';
CREATE DCM PROJECT IF NOT EXISTS dcm_sandbox.projects.sample_qa
    COMMENT = 'DCM sandbox - QA';

-- Refresh the browser afterwards so Snowsight shows the new project objects.
