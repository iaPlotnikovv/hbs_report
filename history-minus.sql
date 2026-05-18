select vm.description  as vm_description,
       h.partno,
       h.historyno_i ,
       to_date('1971-12-31','YYYY-MM-DD') + h.created_date as h_created_date,
       h.mat_class,
       h.serialno ,
       h.batchno ,
       h."condition" ,
       h.qty as h_qty,
       h."owner"
from history h
     join part on part.partno = h.partno 
     join voucher_mode vm on vm.vm = h.vm
where 1=1
      and part.tool = 'N'
      and (vm.description in ('CANCEL RECEIVING',
			                  'SCRAP OF CUSTOMER PART',
			                  'SCRAP',
			                  'ROTABLE DELETED',
                              'RETURN DELIVERY',
                              'EXCHANGED',
                              'MODIFIED')
           or  (vm.description='OWNER CHANGE' 
                and (h."owner" not in ('S7TE', 'S7TE_MOW', 'S7TE_Z', 'SBI', 'SBI_HOLD', 'SBI_EXT'))))
      and  to_date('1971-12-31','YYYY-MM-DD') + h.created_date >= to_date('{date_minus_2_y}','YYYY-MM-DD')
      and  to_date('1971-12-31','YYYY-MM-DD') + h.created_date <  to_date('{date}','YYYY-MM-DD')
order by h.historyno_i

