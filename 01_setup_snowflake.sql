USE ROLE ACCOUNTADMIN;

CREATE WAREHOUSE IF NOT EXISTS DEVELOPER WAREHOUSE_SIZE = XSMALL, AUTO_SUSPEND = 300, AUTO_RESUME= TRUE;


-- Separate database for git repository
CREATE DATABASE IF NOT EXISTS RAW;


-- API integration is needed for GitHub integration
CREATE OR REPLACE API INTEGRATION git_api_integration
  API_PROVIDER = git_https_api
  API_ALLOWED_PREFIXES = ('https://github.com/dominion21')
  ALLOWED_AUTHENTICATION_SECRETS = (git_secret)
  ENABLED = TRUE;


-- Git repository object is similar to external stage
CREATE OR REPLACE GIT REPOSITORY tutorial   --alter GIT REPOSITORY git_repo rename to tutorial;
  API_INTEGRATION = git_api_integration
  GIT_CREDENTIALS = git_secret
  ORIGIN = 'https://github.com/dominion21/tutorial'; -- INSERT URL OF FORKED REPO HERE


CREATE OR REPLACE DATABASE RAW_PROD;


-- To monitor data pipeline's completion
CREATE OR REPLACE NOTIFICATION INTEGRATION email_integration
  TYPE=EMAIL
  ENABLED=TRUE;


-- Database level objects
CREATE SCHEMA IF NOT EXISTS bronze;
CREATE SCHEMA IF NOT EXISTS silver;
CREATE SCHEMA IF NOT EXISTS gold;


-- Schema level objects
CREATE OR REPLACE FILE FORMAT bronze.json_format TYPE = 'json';
CREATE OR REPLACE STAGE bronze.raw;


-- Copy file from GitHub to internal stage
copy files into @bronze.raw from @tutorial/branches/main/effy2017_rv.json;
