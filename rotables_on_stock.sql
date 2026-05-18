select r.partno ,
       r.serialno ,
       r."condition"  ,
       r."owner" ,
       to_date('1971-12-31','YYYY-MM-DD') + r.del_date as del_date,
       to_date('1971-12-31','YYYY-MM-DD') + r.created_date  as created_date,
       r.ac_registr ,
       r."location" ,
       l.description 
from rotables r 
     left join "location" l on l.locationno_i = r.locationno_i