select l.description as l_description,
       vm.description  as vm_description,
       od_h.order_type,
       od_h.orderno,
       ord.recdetailno_i,
       ord.partno as ord_partno,
       h.historyno_i ,
       to_date('1971-12-31','YYYY-MM-DD') + h.created_date as h_created_date,
       h.partno,
       h.mat_class,
       h.serialno ,
       h.batchno ,
       h."condition" ,
       h.qty as h_qty,
       ord.ext_qty,
       p.projectno ,
       p.description as project_description
from od_rec_detail ord 
     join part on part.partno = ord.partno 
     join od_header od_h on od_h.orderno =  ord.orderno  
     join history h on h.recdetailno_i = ord.recdetailno_i 
                       and h.orderno  = ord.orderno 
                       and h."location" !='TREE' 
     join voucher_mode vm on vm.vm = h.vm
     join "location" l on l."location" = h."location" 
                          and h.store = l.store 
                          and h.station = l.station
     left join project p on p.projectno_i = h.projectno_i
where 1=1
      and od_h.order_type in ('P','R')
      and part.tool <> 'Y'
      and part.mat_type <> 'T'
      and ord.owner in ('S7TE', 'S7TE_MOW', 'S7TE_Z', 'SBI', 'SBI_HOLD', 'SBI_EXT')
      and  to_date('1971-12-31','YYYY-MM-DD') + ord.created_date >= to_date('{date_minus_2_y}','YYYY-MM-DD')
      and  to_date('1971-12-31','YYYY-MM-DD') + ord.created_date <  to_date('{date}','YYYY-MM-DD')
      ---and  ord.partno in (select ps.partno
	  ---	           		  from part_special ps
	  ---			          where ps.special = 'HBS')"""
     