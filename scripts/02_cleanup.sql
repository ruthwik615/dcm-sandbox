-- 02_cleanup.sql  (run when finished; PURGE is irreversible)

USE ROLE dcm_developer;

EXECUTE DCM PROJECT dcm_sandbox.projects.sample_qa  PURGE;
EXECUTE DCM PROJECT dcm_sandbox.projects.sample_dev PURGE;

DROP DCM PROJECT IF EXISTS dcm_sandbox.projects.sample_qa;
DROP DCM PROJECT IF EXISTS dcm_sandbox.projects.sample_dev;

-- Optional: remove the host database and role
-- DROP DATABASE IF EXISTS dcm_sandbox;
-- USE ROLE ACCOUNTADMIN;
-- DROP ROLE IF EXISTS dcm_developer;
