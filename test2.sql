SELECT  user.user_id, site.site_id, site_area.site_area_id, t3.design_id 
FROM site_area 
JOIN site  ON site_area.parent_id =  site.site_id
JOIN user ON user.user_id = site.user_id
LEFT JOIN (  SELECT  t2.site_area_id, t2.design_id
             FROM (
                 SELECT t1.site_area_id, t1.design_id, sum( `partner_gain` ) / sum( `view_count` ) *1000 AS result
                 FROM stat_design_cache t1
                 GROUP BY t1.design_id
                 ORDER BY result desc) t2
             GROUP BY t2.site_area_id
           ) t3 ON t3.site_area_id = site_area.site_area_id
ORDER BY  site_area.site_area_id;

Итого:
user_id 	site_id 	site_area_id 	design_id
71378 	142778 	382965 	NULL
71618 	142901 	383508 	373810
72042 	143087 	383589 	380053
72042 	143087 	383590 	373356
72042 	143087 	383592 	373378
71618 	142901 	384030 	381097
72042 	143087 	387289 	383632
71618 	142901 	393976 	NULL
71618 	142901 	396272 	384890
79881 	150271 	515978 	395415
79881 	151424 	516033 	395441
82021 	152110 	517358 	387472
64266 	155425 	526366 	390654
46987 	156307 	526396 	390677
402 	    334 	534732 	393974
66984 	162574 	541087 	395991
66984 	180779 	557822 	400914
9331   	9536 	562669 	403869
103558 	191359 	566509 	407367
