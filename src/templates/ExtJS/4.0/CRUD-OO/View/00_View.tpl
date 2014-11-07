<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=iso-8859-1" %>
<%@ page import="framework.common.ui.i18n.I18n" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<html>
<head>
	<% 
		I18n i18n = new I18n("$Table0.objName$"); 
		String lib_path = "../../../"; 
		String ext_path = "../../../lib/version/extjs/4.0.2a/";
		String extux_path = "../../../lib/version/extjs/4.0.2a/examples/ux/";
	%>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
	<title>$Table0.permission$</title>
	
	<link rel="stylesheet" type="text/css" href="<% out.print(ext_path); %>resources/css/ext-all.css" />	
	<link rel="stylesheet" type="text/css" href="<% out.print(lib_path); %>rc/css/base.css" />
	<link rel="stylesheet" type="text/css" href="<% out.print(extux_path); %>css/LiveSearchGridPanel.css" /> 
    <link rel="stylesheet" type="text/css" href="<% out.print(extux_path); %>statusbar/css/statusbar.css" /> 
	
	<script type="text/javascript" src="<% out.print(ext_path); %>bootstrap.js"></script>
	<script type="text/javascript" src="<% out.print(extux_path); %>semos/form/DateTimeField.js"></script>
	<script type="text/javascript" src="<% out.print(lib_path); %>lib/factories.js"></script>
	<script type="text/javascript" src="<% out.print(lib_path); %>lib/globalvar.jsp"></script>
	<script type="text/javascript" src="<% out.print(lib_path); %>lib/common.js"></script>
	<script type="text/javascript" src="<% out.print(lib_path); %>lib/util.js"></script>
	
	<script type="text/javascript" src="<% out.print(lib_path); %>lib/jsop.js"></script>
	<script type="text/javascript" src="<% out.print(lib_path); %>lib/akc.js"></script>
	
	<sec:authorize ifAnyGranted="ROLE_ADMINISTRATOR,APP_$Table0.permission$_ALL,APP_$Table0.permission$_READ">
	<script type="text/javascript">
		var URL_BASE = '<% out.print(lib_path); %>servlet/ServletLoader';
		var UX_PATH = '<% out.print(ext_path); %>examples/ux/';
		
		$Columns0:{ c |var I18N_$c.upperName$ = '<%= i18n.getI18n("$c.upName$") %>'; };separator="\n"$
		
		var rCreate = false;
		var rDelete = false;
		var rUpdate = false;
		var rRead = false;
		var rAll = false;
		
		<sec:authorize ifAnyGranted="ROLE_ADMINISTRATOR,APP_$Table0.permission$_ALL">rAll = true;</sec:authorize>
		<sec:authorize ifNotGranted="ROLE_ADMINISTRATOR,APP_$Table0.permission$_ALL">
			<sec:authorize ifAllGranted="APP_$Table0.permission$_CREATE">rCreate = true;</sec:authorize>
			<sec:authorize ifAllGranted="APP_$Table0.permission$_UPDATE">rUpdate = true;</sec:authorize>
			<sec:authorize ifAllGranted="APP_$Table0.permission$_DELETE">rDelete = true;</sec:authorize>
			<sec:authorize ifAllGranted="APP_$Table0.permission$_READ">rRead = true;</sec:authorize>
		</sec:authorize>
	</script>
	
	<script type="text/javascript">
	
	/*
	 * DEFINE MODELO PARA Q PUEDA SER REUSADO
	 */
	JSOP.define('$Table0.objName$.Data', akc.js.data.ModelBase, {
		$Columns0:{ c |$if(c.isFK)$modelFK$c.fkObjTable$: 'fk$c.fkObjTable$', 
		$endif$}$
		$Columns0:{ c |$if(c.isFK)$storeFK$c.fkObjTable$: null, 
		$endif$}$
		
	    initDataModel: function(\$super){
	    
	    	\$super('$Table0.objName$', URL_BASE + '?app=$AppName$&module=$Table0.loObjName$.C$Table0.objName$&action=', {
	            extend: 'Ext.data.Model',
			$if(Table0.nPk)$
				// idProperty: '<COLUMNA>', // Se debe definir la columna ya q es una llave compuesta 
			$else$
				idProperty: $ColumnsPk0:{ c |'$c.loName$',};separator="\n "$
			$endif$
	            fields: [
					$Columns0:
{c|$if(c.type.integer)$
{name: '$c.loName$', mapping: '$c.loName$', type: 'int'}
$elseif(c.type.double)$
{name: '$c.loName$', mapping: '$c.loName$', type: 'float' }$elseif(c.type.long)$
{name: '$c.loName$', mapping: '$c.loName$', type: 'float' }$elseif(c.type.date)$
{name: '$c.loName$', mapping: '$c.loName$', type: 'date', dateFormat: CONST_FMT_DATETIME}
$else$
{name: '$c.loName$', mapping: '$c.loName$', type: 'string'}
$endif$}; separator=",\n"$
	            ]    
	        });
	        
	    	this.storeBase = Ext.create('Ext.data.Store', ConfigFactory.store.factoryBaseProxy(this.modelBaseName, this.url));			
			$Columns0:{ c |$if(c.isFK)$

Ext.define(this.modelFK$c.fkObjTable$, {
	extend: 'Ext.data.Model',
    fields: ['$c.fkObjColumnLo$']
}); 
this.storeFK$c.fkObjTable$ = Ext.create('Ext.data.Store', ConfigFactory.store.factoryBaseFkProxy(this.modelFK$c.fkObjTable$, this.url + "list$c.upName$s"));
$endif$}$
	    }
	});
	
	/*
	 * DEFINE COMPONENTES GRAFICOS PARA USUARIO FINAL
	 */
	JSOP.define('$Table0.objName$.App', akc.js.app.AppBase, {	    
	    initDataGrid: function(\$super){
	    	var filters = [
						$Columns0:
{c|$if(c.type.integer)$
{dataIndex: '$c.loName$', type: 'int'}
$elseif(c.type.double)$
{dataIndex: '$c.loName$', type: 'float' }$elseif(c.type.long)$
{dataIndex: '$c.loName$', type: 'float' }$elseif(c.type.date)$
{dataIndex: '$c.loName$', type: 'date', dateFormat: CONST_FMT_DATETIME}
$else$
{dataIndex: '$c.loName$', type: 'string'}
$endif$}; separator=",\n"$
	                	],
	            columns = [
					Ext.create('Ext.grid.RowNumberer' /*, {locked: true}*/),
					$Columns0:{c|$if(c.type.date)$
{dataIndex: '$c.loName$', sortable: true, width: 100, header: I18N_$c.upperName$, renderer: Ext.util.Format.dateRenderer(CONST_FMT_DATETIME) } $else$
{dataIndex: '$c.loName$', sortable: true, width: 100, header: I18N_$c.upperName$}
$endif$}; separator=",\n"$
	            		];	
	    	
	    	\$super(columns, filters);
	    },
		
		initFormBase: function(\$super){
	    	\$super([
				$Columns0:{c|$if(!c.type.isFK)$$if(c.type.integer)${ xtype: 'numberfield', fieldLabel: I18N_$c.upperName$, name: '$c.loName$', $if(!c.nullable)$ allowBlank: false,$endif$ allowDecimals: false }$elseif(c.type.double)${ xtype: 'numberfield', fieldLabel: I18N_$c.upperName$, $if(!c.nullable)$ allowBlank: false,$endif$ name: '$c.loName$' }$elseif(c.type.long)${ xtype: 'numberfield', fieldLabel: I18N_$c.upperName$, name: '$c.loName$', $if(!c.nullable)$ allowBlank: false,$endif$ allowDecimals: false }$elseif(c.type.date)${ xtype: 'datetimefield', fieldLabel: I18N_$c.upperName$, name: '$c.loName$', $if(!c.nullable)$ allowBlank: false,$endif$ dateCfg: { format: CONST_FMT_DATE }, timeCfg: { format: CONST_FMT_TIME } }$else${ xtype: 'textfield', fieldLabel: I18N_$c.upperName$, $if(!c.nullable)$ allowBlank: false,$endif$ name: '$c.loName$' }$endif$$else${
	xtype: 'combo',
	name: '$c.loName$',
	hiddenName: '$c.loName$',
	store: this.dataModel.storeFK$c.fkObjTable$,
	valueField: '$c.fkObjColumnLo$',					
	displayField:'$c.fkObjColumnLo$',
	fieldLabel: I18N_$c.upperName$,
	typeAhead: true,
	mode: 'local',
	forceSelection: true,
	triggerAction: 'all',
	emptyText:'Seleccione un valor ...',
	selectOnFocus:true,										
	width: 120
}$endif$}; separator=",\n"$
	        ]);
	    },
		
		onAddClick: function(\$super){
	        \$super({
	        	$Columns0:{c|$if(c.type.integer)$$c.loName$: 0$elseif(c.type.double)$
$c.loName$: 0$elseif(c.type.long)$
$c.loName$: 0$elseif(c.type.date)$
$c.loName$: null$else$
$c.loName$: null$endif$}; separator=",\n"$
	        });
	    }
	});
	
	</script>
	</sec:authorize>
	
	<script type="text/javascript">
		/*
		 * Carga de librerias
		 */
		Ext.Loader.setConfig({enabled: true});
	    Ext.Loader.setPath('Ext.ux', UX_PATH);
	    Ext.require([
	        'Ext.grid.*',
	        'Ext.data.*',
	        'Ext.util.*',
	        'Ext.state.*',
	        'Ext.toolbar.Paging',
	        'Ext.tip.QuickTipManager',
	        'Ext.ux.grid.FiltersFeature',
	        'Ext.ux.LiveSearchGridPanel2'
	    ]);
	    
	    /*
	     * Inicializacion de la aplicacion
	     */
	    Ext.onReady(function(){
	    	Ext.QuickTips.init();
	    	
	        var app = new $Table0.objName$.App();
	        app.initComponent();
	        
	        Ext.create('Ext.container.Viewport', {
	            layout: 'border',
	            boder: false,
	            items: [ app.getComponent() ]
	        });
	    });
	</script>
	</script>
</head>
<body>
	<div id="contenido">
	</div>
</body>
</html>