select p.partno,
       p.ata_chapter,
       p.mat_class,
       p.mat_type,
       p.description as partno_description,
       ps_RU.remarks as partno_descriptio_ru
from part p
     left join part_special ps_RU on p.partno = ps_RU.partno 
                                     and ps_RU.special = 'RU'