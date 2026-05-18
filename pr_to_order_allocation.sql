select od_h.orderno,
       pr.part_requestno_i,
       pf.availability_status,
       od_d.detailno_i ,
       od_h.state,
       od_h.ext_state,
       od_h.status,
       od_h.order_status,
       to_date('1971-12-31','YYYY-MM-DD') + wp_h.start_date as wp_h_start_date,
       to_date('1971-12-31','YYYY-MM-DD') + wp_h.end_date as wp_h_end_date, 
       to_date('1971-12-31','YYYY-MM-DD') + pf.expected_date  as pf_expected_date,
       to_date('1971-12-31','YYYY-MM-DD') + pf.valid_due_date as pf_valid_due_date,
       al.link_type,
       al.qty as al_qty, 
       wp_h.ac_registr as wp_h_ac_registr,
       a.ac_typ,
       a.ac_model,
       a.owner as ac_owner,
       wp_h.projectno as wp_h_projectno,
       wp_h.wpno,
       wa.wpno_i ,
       wh.ac_registr as wh_ac_registr,
       to_date('1971-12-31','YYYY-MM-DD') + wh.issue_date  as wh_issue_date,
       wh."type" as wo_type,
       wh.event_type as wo_event_type,
       pf.event_perfno_i,
       pf.display_event_type,
       pf.event_display,
       pf.part_special_types ,
       pf.receiver ,
       pf.receiver_type ,
       pr.partno as pr_partno,
       pr.percentage,
       pr.qty as pr_qty
from od_detail od_d 
     join od_header od_h on od_h.orderno_i  = od_d.orderno_i   
     join allocation_link al on al.ref_key = od_d.detailno_i  
     join part_request_2 pr on pr.part_requestno_i = al.source_key 
     join part_forecast pf on pf.part_requestno_i  =  pr.part_requestno_i
     left join wo_header wh on wh.event_perfno_i = pf.event_perfno_i
     left join wp_assignment wa  on wa.event_perfno_i = pf.event_perfno_i
     left join wp_header wp_h on wp_h.wpno_i = wa.wpno_i
     left join aircraft a on a.ac_registr = wp_h.ac_registr 
where 1=1 
      and al.source_type = 'PARTRQST'    
      and al.ref_type = 'ORDER_DE' 
      and pr.status = 0
      and pr.externally_provisioned = 'N'
      and pf.availability_status = 'O'
      and od_h.ext_state= 'D'