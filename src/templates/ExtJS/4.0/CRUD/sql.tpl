/*
 * REGISTRO DEL MODULO
 */ 
INSERT INTO bas_modulo 
	(MODUNOMB, MODUNEMO, MODUTITL, MODUICON, MODUURI, MODUAPPS, MODUESTA, MODUCLJS)VALUES
	('$Table0.objName$', '$Table0.objName$', 'App $Table0.objName$', '/rc/img/app.png', 
	 'app/$AppName$/$Table0.loObjName$/$Table0.objName$.jsp', '<APPLICATION>', 'A', null);	

/*
 * PERMISOS PARA EL MODULO
 */
INSERT INTO bas_modurope
	(MOROROPE, MOROMODU) VALUES	('ALL', '$Table0.objName$');
	
INSERT INTO bas_modurope
	(MOROROPE, MOROMODU) VALUES	('CREATE', '$Table0.objName$');
	
INSERT INTO bas_modurope
	(MOROROPE, MOROMODU) VALUES	('READ', '$Table0.objName$');
	
INSERT INTO bas_modurope
	(MOROROPE, MOROMODU) VALUES	('DELETE', '$Table0.objName$');
	
INSERT INTO bas_modurope
	(MOROROPE, MOROMODU) VALUES	('UPDATE', '$Table0.objName$');

/*
 * REGISTRO EN EL ARBOL
 */
INSERT INTO bas_arbol
    (ARBOCODI, ARBOPADR, ARBONAME, ARBOICON, ARBOMODU, ARBOPOS, ARBOESTA)
    VALUES
    (-1, 0, '$Table0.objName$', null, '$Table0.objName$', 0, 'A' );
	
-- Para llave primaria autogenerada
--INSERT INTO <PREFIJO_TABLA>_pkid
--	(PKID, PKIDVALU) VALUES	('$Table0.tableName$_PK', 0);


-- Soporte multi lenguaje
INSERT INTO bas_i18n (I18NMODU, I18NCAMP, I18NTEXT)VALUES('$Table0.objName$', '-', 'i18n_$Table0.objName$');

$Columns0:{c|INSERT INTO bas_i18n (I18NMODU, I18NCAMP, I18NTEXT)VALUES('$Table0.objName$', '$c.upName$', 'i18n_$c.upName$'); }; separator="\n"$

-- soporte Clases para Hibernate
INSERT INTO bas_class (CLASCODI, CLASNAME)VALUES('$Table0.objName$', 'model.$AppName$.$Table0.loObjName$.$Table0.objName$');
INSERT INTO bas_conxclas (COCLCONX, COCLCLAS)VALUES('$ConnName$', '$Table0.objName$');
