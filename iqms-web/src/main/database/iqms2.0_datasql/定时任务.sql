 declare 
 job number;
begin
  sys.dbms_job.submit(job,
                      'proc_cleartrxtoday;',
                      to_date('24-02-2018 01:00:00', 'dd-mm-yyyy hh24:mi:ss'),
                      'TRUNC(sysdate) + 1 +1/ (24)');
  commit;
end;