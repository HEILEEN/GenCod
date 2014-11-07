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
	Ext.define('$Table0.objName$.Data', {
		modelBaseName: '$Table0.objName$',
	    storeBase: null,
	    url: URL_BASE + '?app=$AppName$&module=$Table0.loObjName$.C$Table0.objName$&action=',
		$Columns0:{ c |$if(c.isFK)$modelFK$c.fkObjTable$: 'fk$c.fkObjTable$', 
		$endif$}$
		$Columns0:{ c |$if(c.isFK)$storeFK$c.fkObjTable$: null, 
		$endif$}$
		
	    initDataModel: function(){
	    	Ext.define(this.modelBaseName, {
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
	Ext.define('$Table0.objName$.App', {
	    dataModel: null,
	    
	    activeRecordEdit: false,
	    gridBase: null,
	    gridEditing: null,
	    windowBase: null,
	    formBase: null,
	    activeRecord: null,
	    mainWindow: null,
	    
	    initComponent: function(){
	    	this.initDataModel();
	    	this.initDataGrid();
	        this.initFormBase();
	        this.initFormWindow();
	        
	        mainWindow = new Api.common.Main();
	    },
	    
	    getComponent: function(){
	    	return this.gridBase;
	    },
	    
	    initDataModel: function(){
	    	this.dataModel = new $Table0.objName$.Data();
	    	this.dataModel.initDataModel();
	    },
	    
	    initDataGrid: function(){
	    	this.gridEditing = Ext.create('Ext.grid.plugin.CellEditing');
	    	
	    	this.gridBase = Ext.create('Ext.ux.LiveSearchGridPanel2', {
	            region: 'center',
	            border: false,
	            store: this.dataModel.storeBase,
	            plugins: [ this.gridEditing ],
	            dockedItems: [{
	                dock: 'top',
	                xtype: 'toolbar',
	                items: ConfigFactory.grid.factoryBaseToolBarButtons(this, this.onAddClick, this.onEditClick, this.onDeleteClick)
	            }, { 
	            	xtype: 'pagingtoolbar',
	                dock: 'bottom',
	                store: this.dataModel.storeBase
	            }],
	            features: [{
	                ftype: 'filters',
	                encode: true,
	                filters: [
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
	                ]
	            }, {
	                id: 'group',
	                ftype: 'groupingsummary',
	                groupHeaderTpl: '{name}',
	                hideGroupedHeader: false
	            }],
	            columns: [
					Ext.create('Ext.grid.RowNumberer' /*, {locked: true}*/),
					$Columns0:{c|$if(c.type.date)$
{dataIndex: '$c.loName$', sortable: true, width: 100, header: I18N_$c.upperName$, renderer: Ext.util.Format.dateRenderer(CONST_FMT_DATETIME) } $else$
{dataIndex: '$c.loName$', sortable: true, width: 100, header: I18N_$c.upperName$}
$endif$}; separator=",\n"$
	            ],
	            viewConfig: {
	                listeners: {
	                	scope: this,
	                	itemdblclick: function(view, record, item, index, e, options) {
	                		this.setActiveRecord(record);
	                    }
	                }
	            }
	        });	
	    	
	    	this.gridBase.getSelectionModel().on('selectionchange', function(selModel, selections){
	    		this.gridBase.down('#btnDelete').setDisabled(selections.length === 0);
	    		this.gridBase.down('#btnEdit').setDisabled(selections.length === 0);
	    	}, this);
	    },
		
		initFormBase: function(){
	    	this.formBase = Ext.create('Ext.form.Panel', {
	            bodyPadding: 5,
	            border: false,
	    		defaultType: 'textfield',
	            fieldDefaults: {
					labelAlign: 'left',
					labelWidth: 100,
	                anchor: '98%'	                
	            },
	            items: [
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
	            ]
	    	});
	    },
	    
	    initFormWindow: function(){
	    	this.windowBase = Ext.create('widget.window', ConfigFactory.form.factoryBaseWindow(this, 'Editar', this.formBase, this.onSaveClick));
	    	
	    	this.windowBase.on('hide', this.onHideWindow, this);
	    },
	    
	    /*
	     *  EVENTOS
	     */
	    
	    setActiveRecord: function(record){
	        this.activeRecord = record;
	        this.formBase.getForm().loadRecord(record);
	        this.windowBase.show();
	    },
	    
	    onHideWindow: function(window, config){
	    	if( this.activeRecordEdit ){
	    		this.activeRecord.cancelEdit();
	    		this.activeRecord = null;
	    		this.activeRecordEdit = false;
	    	}
	    },
		
		onAddClick: function(){
	        var record = new $Table0.objName$({
	        	$Columns0:{c|$if(c.type.integer)$$c.loName$: 0$elseif(c.type.double)$
$c.loName$: 0$elseif(c.type.long)$
$c.loName$: 0$elseif(c.type.date)$
$c.loName$: null$else$
$c.loName$: null$endif$}; separator=",\n"$
	        });
	        
	        this.gridEditing.cancelEdit();
	        this.activeRecordEdit = true;
	        this.setActiveRecord(record);
	    },
	    
	    onEditClick: function(){
	    	var selection = this.gridBase.getView().getSelectionModel().getSelection()[0];
	        if (selection) {
	        	this.setActiveRecord(selection);
	        }
	    },
	    
	    onDeleteClick: function(){
	        var selection = this.gridBase.getView().getSelectionModel().getSelection()[0];
	        if (selection) {
	        	Ext.MessageBox.show({ 
					title:'Pregunta?',
		            msg: 'Esta seguro de borrar este registro ?',
		            buttons: Ext.MessageBox.YESNO,		            
		            icon: Ext.MessageBox.QUESTION,
		            scope: this,
		            fn: function(btn){
		            	if( btn == 'yes' ){
		            		var record = this.gridBase.getView().getSelectionModel().getSelection()[0]
		            		this.dataModel.storeBase.remove(record);
		            	}
		            }
		        });
	        }
	    },

	    onSaveClick: function(){	    	
	        var active = this.activeRecord,
	            form = this.formBase.getForm();

	        if (!active) {
	            return;
	        }
	        
	        if (form.isValid()) {
	            form.updateRecord(active);
	            
	            if( this.activeRecordEdit )
	            	this.dataModel.storeBase.insert(0, this.activeRecord);
	            
	            this.activeRecordEdit = false;
	            this.windowBase.hide();
	        }
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