CREATE USER iqms_new IDENTIFIED BY iqms_new DEFAULT TABLESPACE IQMS_DATA TEMPORARY TABLESPACE IQMS_TEMP;

grant connect,resource,dba to iqms_new;

grant create session to iqms_new;