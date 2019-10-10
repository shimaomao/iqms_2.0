create tablespace IQMS_DATA
logging  
datafile 'D:/IQMS_DATA.DBF' 
size 50m  
autoextend on   
next 50m maxsize 20480m  
extent management local;

create tablespace  IQMS_INDEX
logging  
datafile 'D:/IQMS_INDEX.DBF' 
size 50m  
autoextend on   
next 50m maxsize 20480m  
extent management local;

create temporary tablespace  IQMS_TEMP
tempfile 'D:/IQMS_TEMP.DBF' 
size 50m  
autoextend on   
next 50m maxsize 5120m  
extent management local;


