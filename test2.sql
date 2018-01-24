SELECT  
user.user_id
, site.site_id
, site_area.site_area_id
, site_area.name as area_name
, COALESCE( t3.design_id, ( SELECT t5.site_area_design_1_id 
                                          FROM  site_area_design_1 t5 
                                          WHERE t5.site_area_id=site_area.site_area_id 
                                          LIMIT 1)) AS design_id
, t3.cpm
FROM site_area 
JOIN site  ON site_area.parent_id =  site.site_id
JOIN user ON user.user_id = site.user_id
LEFT JOIN (  SELECT  t2.site_area_id, t2.design_id, t2.cpm
             FROM (
                 SELECT t1.site_area_id, t1.design_id, sum(`partner_gain`)/sum(`view_count`) *1000 AS cpm
                 FROM stat_design_cache t1
                 GROUP BY t1.design_id
                 ORDER BY cpm desc) t2
             GROUP BY t2.site_area_id
           ) t3 ON t3.site_area_id = site_area.site_area_id
ORDER BY  site_area.site_area_id;
Итого:
user_id	site_id	site_area_id	area_name			design_id	cpm
71378	142778	382965		block_15_			NULL		NULL		любой 384244
71618	142901	383508		block_9_			373498		0.000000000000
72042	143087	383589		block_14_			380053		0.574886535552
72042	143087	383590		block_6_			373356		0.031177593022
72042	143087	383592		block_12_			373378		0.263069139966
71618	142901	384030		block_20_			381097		0.032119914347
72042	143087	387289		block_12_			383766		0.000000000000
71618	142901	393976		block_29_			NULL		NULL		любой 383242
71618	142901	396272		block_34_			384890		0.118980971078
79881	150271	515978		Боковой с баннерами		395415		0.038337351466
79881	151424	516033		Рассказы c баннерами		395441		0.081894986199
82021	152110	517358		Над контентом			387472		1.777019559528
64266	155425	526366		160x600				390654		0.000000000000
46987	156307	526396		240x400				390677		3.616816512370
402	334	534732		Articles2.0			393974		2.570274068869
66984	162574	541087		blok2				395991		2.809709372098
66984	180779	557822		blok2 [копия от 09.01.2015 01:05]400914		1.481467228251
9331	9536	562669		990х90new			403869		0.772315653299
103558	191359	566509		726x270				407367		2.026134463567

