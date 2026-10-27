# DCM sandbox (personal Snowflake account)

Tests Snowflake DCM Projects with one sample table, deployed to two
"environments" inside a single account: DEV and QA.

| | DEV | QA |
|---|---|---|
| Project object | DCM_SANDBOX.PROJECTS.SAMPLE_DEV | DCM_SANDBOX.PROJECTS.SAMPLE_QA |
| Table lands in | DCM_SAMPLE_DEV.REF.SAMPLE_TABLE | DCM_SAMPLE_QA.REF.SAMPLE_TABLE |

## Layout

    manifest.yml                    targets + templating (env_suffix)
    sources/definitions/sample.sql  the DEFINE statements
    scripts/01_setup.sql            one-time roles, host database, project objects
    scripts/02_cleanup.sql          tear everything down

## Steps

1. Create a Snowflake account (trial is fine) and log into Snowsight as ACCOUNTADMIN.
2. Run `scripts/01_setup.sql`. Copy the `account_identifier` value it returns.
3. Edit `manifest.yml`: replace `MYORG-MYACCOUNT` in both targets with that value.
4. Push this folder to your own GitHub repo (public is simplest).
5. In Snowsight: Projects > Workspaces > Create > Git repository. Enter your repo URL
   and create an API integration for GitHub when asked. Refresh the browser if the
   project objects do not appear.
6. Open the project, select target DCM_DEV, run Plan (expect only CREATE statements),
   then Deploy. Check that DCM_SAMPLE_DEV exists.
7. Switch target to DCM_QA, Plan, Deploy. Check that DCM_SAMPLE_QA exists.
8. Pilot ideas: add a column in sample.sql, re-plan, and read the ALTER in the plan;
   try a deployment alias; open a PR on a test branch and deploy from it.
9. When done, run `scripts/02_cleanup.sql`.

## Notes

- Both targets use the same account here. For a real two-account setup, give each
  target its own account_identifier and create the project objects in each account.
- Removing a DEFINE statement and deploying drops the object, so read the plan first.
- DCM availability on trial accounts is unconfirmed; if CREATE DCM PROJECT fails, note the error.
