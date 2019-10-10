create or replace trigger "TRIGGER_TRX_TODAY" 
after insert or update
on TRX_TODAY
for each row
declare
  existcount number;
begin

   case
     when inserting then
        insert into TRX_HISTORY (
          ORG_ID,
          DEVICE_NO,
          TRX_DATE,
          FLOW_NO,
          bus_id,  --
          BUS_TYPE,
          cust_type, --
          PDJ_LEVEL,
          TICKET_TYPE,
          TICKET_NO,
          CUST_ID,
          CARD_TYPE,
          CARD_NO,
          MANAGER_NO,
          trx_type,  --
          TRX_STATUS,
          PRINT_TIME,
          CALL_TIME,
          BEGIN_TIME,
          END_TIME,
          APP_VALUE,
          WIN_NO,
          TELLER_NO,
          recall_count, --
          pause_begintime, --
          pause_endtime, --
          call_type, --
          transfer_count, --
          buz_flag, --
          EXTEND1,
          EXTEND2,
          EXTEND3
     ) values (
          :new.ORG_ID,
          :new.DEVICE_NO,
          :new.TRX_DATE,
          :new.FLOW_NO,
          :new.bus_id,
          :new.BUS_TYPE,
          :new.cust_type,
          :new.PDJ_LEVEL,
          :new.TICKET_TYPE,
          :new.TICKET_NO,
          :new.CUST_ID,
          :new.CARD_TYPE,
          :new.CARD_NO,
          :new.MANAGER_NO,
          :new.trx_type,
          :new.TRX_STATUS,
          :new.PRINT_TIME,
          :new.CALL_TIME,
          :new.BEGIN_TIME,
          :new.END_TIME,
          :new.APP_VALUE,
          :new.WIN_NO,
          :new.TELLER_NO,
          :new.recall_count, --
          :new.pause_begintime, --
          :new.pause_endtime, --
          :new.call_type, --
          :new.transfer_count, --
          :new.buz_flag, --
          :new.EXTEND1,
          :new.EXTEND2,
          :new.EXTEND3
     );
   when updating then
       update TRX_HISTORY t set t.bus_type=:new.BUS_TYPE,
                          t.bus_id = :new.bus_id,
                          t.cust_type=:new.cust_type,
                          t.pdj_level=:new.PDJ_LEVEL,
                          t.ticket_type=:new.TICKET_TYPE,
                          t.ticket_no=:new.TICKET_NO,
                          t.cust_id=:new.CUST_ID,
                          t.card_type=:new.CARD_TYPE,
                          t.card_no=:new.CARD_NO,
                          t.manager_no=:new.MANAGER_NO,
                          t.trx_type=:new.trx_type,
                          t.trx_status=:new.TRX_STATUS,
                          t.print_time=:new.PRINT_TIME,
                          t.call_time=:new.CALL_TIME,
                          t.begin_time=:new.BEGIN_TIME,
                          t.end_time=:new.END_TIME,
                          t.app_value=:new.APP_VALUE,
                          t.win_no=:new.WIN_NO,
                          t.teller_no=:new.TELLER_NO,
                          t.recall_count=:new.recall_count,
                          t.pause_begintime=:new.pause_begintime,
                          t.pause_endtime=:new.pause_endtime,
                          t.call_type=:new.call_type,
                          t.transfer_count=:new.transfer_count,
                          t.buz_flag=:new.buz_flag,
                          t.extend1=:new.EXTEND1,
                          t.extend2=:new.EXTEND2,
                          t.extend3=:new.EXTEND3
   where t.ORG_ID=:new.ORG_ID and t.DEVICE_NO=:new.DEVICE_NO and t.TRX_DATE=:new.TRX_DATE and t.FLOW_NO= :new.FLOW_NO;
 end case;
 exception
   when others then
     return;
end;
