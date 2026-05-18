select part.ata_chapter,
       project.projectno ,
       project.description as project_description,
       project.project_type ,
       project.state as project_state,
       stshv.partno in (select ps.partno
	      		        from part_special ps
	  			        where ps.special = 'HBS') as HBS_flag,
       stshv.*
from s7te_dw.s7te_stock_history_v stshv 
     join part on part.partno = stshv.partno 
     left join project on project.projectno_i = stshv.projectno_i 
where stshv.stock_day =  to_date('{date}','YYYY-MM-DD')
      and stshv.tool <> 'Y'
      and stshv.mat_type <> 'T'
      and stshv.mat_type <> 'N'
      and stshv.owner in ('SBI', 'SBI_HOLD', 'SBI_EXT')
      and stshv.condition != 'US'
      and stshv.special_contract is NULL
      ---and stshv.partno in (select ps.partno
	  ---    		          from part_special ps
	  ---			          where ps.special = 'HBS')