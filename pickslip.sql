select part.mat_class ,
       pb.*
from pickslip_booked pb 
     join part on part.partno = pb.partno 
where pb.is_consumption = 'Y'
      and (to_date('1971-12-31','YYYY-MM-DD') + pb.created_date ) >= to_date('{date_minus_2_y}','YYYY-MM-DD')
      and (to_date('1971-12-31','YYYY-MM-DD') + pb.created_date ) <  to_date('{date}','YYYY-MM-DD')
      and pb.owner in  ('S7TE', 'S7TE_MOW', 'S7TE_Z', 'SBI', 'SBI_HOLD', 'SBI_EXT')
      and (pb.qty_booked - pb.qty_canceled )>0
      ---and pb.partno in (select ps.partno
	  ---	    		    from part_special ps
	  ---			        where ps.special = 'HBS')"""