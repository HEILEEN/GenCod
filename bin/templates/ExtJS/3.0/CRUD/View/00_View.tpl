/*
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ page import="framework.common.ui.i18n.I18n" %>
<% I18n i18n = new I18n("$Table0.objName$"); %>
 
<sec:authorize ifAnyGranted="ROLE_ADMINISTRATOR,APP_$Table0.permission$_ALL,APP_$Table0.permission$_READ"> // */

function $AppName$_$Table0.objName$() {
	var rec = null;
	
	$Columns0:{ c |var I18N_$c.upperName$ = '<%= i18n.getI18n("$c.upName$") %>'; };separator="\n"$
	
	var dsReader = null;
	var dsGrid = null;
	// DS FK para el form
	$Columns0:{ c |$if(c.isFK)$var ds$c.fkObjTable$ = null;
$endif$}$

	var tPanel = null;
	var grid = null;
	var editForm = null;
	var wndEditForm = null;
	var btnSave = null;
	
	var isNew = false;
	var isLoaded = false;
	
	var rCreate = false;
	var rDelete = false;
	var rUpdate = false;
	var rRead = false;
	var rAll = false;
	var bChanged = false;
	
	var mode = null;	
	var GRID = 1;
	var EDIT = 2;	
	
	var sGridTitle = 'Listado [ $Table0.objName$ ]';	

	return{
		getWinEdit: function(){
			return wndEditForm;
		},
		
		hasChanged: function(){
			return this.bChanged;
		},
		
		initSecurity: function(){
			/*<sec:authorize ifAnyGranted="ROLE_ADMINISTRATOR,APP_$Table0.permission$_ALL">rAll = true;</sec:authorize>
			<sec:authorize ifNotGranted="ROLE_ADMINISTRATOR,APP_$Table0.permission$_ALL">
				<sec:authorize ifAllGranted="APP_$Table0.permission$_CREATE">rCreate = true;</sec:authorize>
				<sec:authorize ifAllGranted="APP_$Table0.permission$_UPDATE">rUpdate = true;</sec:authorize>
				<sec:authorize ifAllGranted="APP_$Table0.permission$_DELETE">rDelete = true;</sec:authorize>
				<sec:authorize ifAllGranted="APP_$Table0.permission$_READ">rRead = true;</sec:authorize>
			</sec:authorize> // */
			rAll = true;
		},
		
		initDatasources: function(){
			var dsProxy = new Ext.data.HttpProxy({
				url: 'servlet/ServletLoader',
				method: 'POST'
			});
			
			dsReader = new Ext.data.JsonReader({
					root: 'rows',
					totalProperty: 'results',
					successProperty: 'success',
					remoteSort:true
				}, [
					$Columns0:
{c|$if(c.type.integer)$ 
{name: '$c.loName$', type: 'int', mapping: '$c.loName$'}
$elseif(c.type.double)$ 
{name: '$c.loName$', type: 'float', mapping: '$c.loName$'}
$elseif(c.type.long)$ 
{name: '$c.loName$', type: 'float', mapping: '$c.loName$'}
$elseif(c.type.date)$ 
{name: '$c.loName$', type: 'date', mapping: '$c.loName$', dateFormat: CONST_FMT_DATETIME}
$else$ 
{name: '$c.loName$', type: 'string', mapping: '$c.loName$'} 
$endif$}; separator=","$				]
			);
			
			var load = ( this.mode == GRID ) ? true:false;
			
			dsGrid = new Ext.data.GroupingStore({
				reader: dsReader,			
				proxy: dsProxy,
				//sortInfo: { field: '<campo>', direction: 'DESC' },
				//groupField: 	'<campo>',
				//remoteGroup:	true,
				baseParams:		{app: '$AppName$', module: "$Table0.loObjName$.C$Table0.objName$", action: "listAll"},
				remoteSort: 	true
			});
				
			// SET DEFAULT ORDER BY 
			/*if( load == true ){
				dsGrid.setDefaultSort('<campo>', 'asc');
			}*/

			$Columns0:{ c |$if(c.isFK)$ds$c.fkObjTable$ = new Ext.data.Store({
	reader: new Ext.data.JsonReader({
		fields: ['$c.fkObjColumnLo$'], // agregue la columna que debe mostrar el combo
		root: 'rows'
	}),
	proxy: dsProxy,
	baseParams:	{app: '$AppName$', module: "$Table0.loObjName$.C$Table0.objName$", action: "list$c.upName$s"}
	//autoLoad: true
});
$endif$}$
		},
		
		initUIGrid: function(){
			grid = new Ext.grid.GridPanel({
		    	width:'100%',
				border: false, 
				
				store: dsGrid,
				loadMask: true,
				forceFit:true,
				region: 'center',
				//title:sGridTitle,
				
				columns: [
					new Ext.grid.RowNumberer(),					
					$Columns0:{ c | {header: I18N_$c.upperName$, dataIndex: '$c.loName$', sortable:true} };separator=", \n"$
					//if date formated use: , renderer: Ext.util.Format.dateRenderer('d/m/Y')} //, hidden:true}
				],
				
				tbar: [{
			        text: 'Nuevo',
			        iconCls: 'icon-add',
			        disabled: !(rAll || rCreate),
			        scope: this,
			        handler: this.onInsert
			    }, '-'],
				
				view: new Ext.grid.GroupingView({
		            forceFit:true,
		            groupTextTpl: '{text} ({[values.rs.length]} {[values.rs.length > 1 ? "Items" : "Item"]})'
		        }),				
				
				bbar: new Ext.PagingToolbar({
					pageSize: CONST_MAX_ROWS,
					store: dsGrid,
					displayInfo: true,
			        displayMsg: 'Mostrando, {0} - {1} de {2}',
			        emptyMsg: "No hay registros"
				}),
				
				plugins:[
					new Ext.ux.grid.GridFilters({
						encode: true,
						filters:[
							$Columns0:
{c|$if(c.type.integer)$ 
{type: 'int',  dataIndex: '$c.loName$'}
$elseif(c.type.double)$ 
{type: 'float',  dataIndex: '$c.loName$'}
$elseif(c.type.long)$ 
{type: 'float',  dataIndex: '$c.loName$'}
$elseif(c.type.date)$ 
{type: 'date',  dataIndex: '$c.loName$'}
$else$ 
{type: 'string',  dataIndex: '$c.loName$'}
$endif$}; separator=","$
						]
					}),
					
					new Ext.ux.grid.Search({
						iconCls:'icon-zoom'
						//,readonlyIndexes:['note']
						//,disableIndexes:['tbvalint', 'tbvalfec']
						,minChars:3
						,autoFocus:true
						,mode: 'local'
					})
				]
			});
		},
			
		initUIWindow: function(){
			editForm = new Ext.form.FormPanel({
				url: 'servlet/ServletLoader',
				reader: ( this.mode == GRID ) ? dsReader : null,
				frame: true,
				autoHeight: true,
				bodyStyle:'padding:5px',
				border: false,
				baseCls: 'x-plain',
				trackResetOnLoad: true,
				defaults: {
		            anchor: '94%',
		            //allowBlank: false,
		            selectOnFocus: true,
		            msgTarget: 'side'
		        },
		        items: [ $Columns0:
{c|$if(!c.type.isFK)$
$if(c.type.integer)$ 				{
					xtype: 'numberfield',
					fieldLabel: I18N_$c.upperName$,
					name: '$c.loName$', $if(!c.nullable)$ 
					allowBlank: false,$endif$
					allowDecimals: false
				}
$elseif(c.type.double)$ 				{
					xtype: 'numberfield',
					fieldLabel: I18N_$c.upperName$, $if(!c.nullable)$ 
					allowBlank: false,$endif$
					name: '$c.loName$'
				}
$elseif(c.type.long)$ 				{
					xtype: 'numberfield',
					fieldLabel: I18N_$c.upperName$,
					name: '$c.loName$', $if(!c.nullable)$ 
					allowBlank: false,$endif$
					allowDecimals: false
				}
$elseif(c.type.date)$				{
					xtype: 'xdatetime',
					fieldLabel: I18N_$c.upperName$, $if(!c.nullable)$ 
					allowBlank: false,$endif$
					name: '$c.loName$'
					,hiddenFormat: CONST_FMT_DATETIME //,
					,timeFormat: CONST_FMT_TIME
					,timeConfig: {
				         altFormats: CONST_FMT_TIME
				        ,allowBlank:true    
				    }
				    ,dateFormat: CONST_FMT_DATE
				    ,dateConfig: {
				         altFormats:CONST_FMT_DATE
				        ,allowBlank:true    
				    }
				}
$else$				{
					xtype: 'textfield',
					fieldLabel: I18N_$c.upperName$, $if(!c.nullable)$ 
					allowBlank: false,$endif$
					name: '$c.loName$'
				}
$endif$$else$				{
					xtype: 'combo',
					name: '$c.loName$',
					hiddenName: '$c.loName$',
					store: ds$c.fkObjTable$,
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
				}
$endif$ 
}; separator=","$				]
			}); // */
			
			btnSave = new Ext.Button({
		        text: 'Guardar',
		        iconCls: 'icon-save',
				scope: this,
				handler: this.onSave
		    });			
			
			wndEditForm = new Ext.Window({
				title: '<%= i18n.getI18n("-") %>',
				iconCls: 'icon-form-edit',
				closable: true,
				modal: true,
				width: 450,
				layout: 'fit',
				closeAction: 'hide',
				plain:true,
				items: [editForm],
				buttons: [{
					text: 'Borrar',
					iconCls: 'icon-delete',
					disabled: !(rAll || rDelete),
					scope: this,
					handler: this.onDelete
				}, btnSave, {
					text: 'Cancelar',
					scope: this,
					handler: this.onCancel
				}]
			});
		},
		
		initUIPanel: function(){
			tPanel = new Ext.Panel({
				closable: true,
		    	width:'100%',
		    	height:'100%',
		    	layout:'fit',
		    	title:sGridTitle,
		    	html: CONST_CLICKLOAD_MSG,
		    	style: {cursor:'pointer'},
		    	listeners: {
		    		scope: this,
			        render: function(p) {
			            p.getEl().on('click', this.load, this);
			        },
			        single: true  // Remove the listener after first invocation
			    }
			});
		},
		
		initEventEventHandlers: function(){
			if( this.mode == GRID ){
				dsGrid.on('exception', function(proxy, type, action, options, response, arg) {
					if (type == 'remote') {
						Ext.App.msg('Grid Error Message', 'Remote exception');
					}else if (type == 'response') {
						if( response.status == 200 ){
							Ext.App.msg('Grid Error Message', "Error en peticion al servidor por favor verifique que su sesion no ha terminado.");
						}else{
							Ext.App.msg('Grid Error Message', "Error no definido.");
						}
					}
				});
				
				grid.on('rowclick', function(_grid, rowIndex, e){ 
					this.rec = _grid.store.getAt(rowIndex);
				}, this);
				
				grid.on('rowdblclick', function(_grid, rowIndex, e){ 
					this.onRowdblclick(_grid, rowIndex, e); 
				}, this);
			}
			
			wndEditForm.on('beforeshow', function(el){ 
				this.onBeforeshow(el); 
			}, this);
		},
	
		initComponent: function(bLoad){
			this.mode = GRID;
			
			this.initSecurity();
			this.initDatasources();
			this.initUIGrid();
			this.initUIWindow();
			this.initUIPanel();
			this.initEventEventHandlers();
			
			if( bLoad || bLoad == null )
				this.load();
				
			return tPanel;
		},
		
		initEditComponent: function(bLoad){
			this.mode = EDIT;
			
			this.initSecurity();
			this.initDatasources();
			this.initUIWindow();
			this.createRecord();	
			
			if( bLoad || bLoad == null )
				this.load();		
			
			return wndEditForm;
		},
		
		createRecord: function(){
			this.rec = new dsGrid.recordType({
				$Columns0:
{c|$if(c.type.integer)$ 
$c.loName$: 0
$elseif(c.type.double)$ 
$c.loName$: 0
$elseif(c.type.long)$ 
$c.loName$: 0
$elseif(c.type.date)$ 
$c.loName$: null
$else$ 
$c.loName$: null $endif$}; separator=","$
			});
						
			isNew = true;
		},
		
		LoadRecord: function($ColumnsPk0:{ c |_$c.loName$};separator=", "$){
			wndEditForm.show();
			
			if( $ColumnsPk0:{ c |_$c.loName$ != null};separator=" && "$ ){
				isNew = false;
						
				editForm.getForm().load({
					clientValidation: true,
					method: 'POST',
					params:{ app: '$AppName$', module: "$Table0.loObjName$.C$Table0.objName$", action: "load", $ColumnsPk0:{ c |$c.loName$: _$c.loName$};separator=", "$ },
					scope: this,
					success: function(form, action){
						editForm.getForm().updateRecord(this.rec);
					},
					failure: function(form, action) {
					
						if( action.result.success == false ){							
							wndEditForm.setDisabled( true );
				        	Ext.MessageBox.show({ 
								title:'Error !',
					            msg: action.result.errors[0].errormsg,
					            buttons: Ext.MessageBox.OK,          
					            icon: Ext.MessageBox.ERROR,
					            scope: this,
					            fn: function(btn){
					            	wndEditForm.hide();
					            }
					        });
						}				        
				        
				        switch (action.failureType) {
							case Ext.form.Action.CLIENT_INVALID:
								Ext.Msg.alert('Error', 'Los datos proporcionados son invalidos');
								break;            
							case Ext.form.Action.CONNECT_FAILURE:                
								Ext.Msg.alert('Error', 'Ajax communication failed');                
								break;            
							case Ext.form.Action.SERVER_INVALID:               
								Ext.Msg.alert('Error', action.result.errors[0].errormsg);       
						}				        
				    }
				});
			}else{
				this.createRecord();				
			}			
		},
		
		load: function(){
			if( !isLoaded ){
				if( this.mode == GRID ){
					isLoaded = true;
		            tPanel.add(grid);
		            tPanel.doLayout();
		            
		            dsGrid.load();
		        }
		        
	            $Columns0:{ c |$if(c.isFK)$ds$c.fkObjTable$.load();$endif$}; separator="\n"$
			}
		},
		
		setGridTitle: function(title){
			sGridTitle = title;
		},
		
		/*
		 *  Doble click sobre la grilla 
		 */
		onRowdblclick: function(_grid, rowIndex, e){		
			isNew = false;
			this.rec = _grid.store.getAt(rowIndex);			
			wndEditForm.show();
		},
		
		/*
		 * Evento que se ejecuta despues de mostrar
		 */ 
		onBeforeshow: function(el){
			this.bChanged = false;
			btnSave.disabled = !(rAll || (rCreate && isNew) || rUpdate);
			this.rec.beginEdit();
			editForm.getForm().loadRecord(this.rec);
		},
		
		/*
		 * Evento inserta registro
		 */
		onInsert: function(){
			this.createRecord();
	        grid.store.insert(0, this.rec);
	        grid.getSelectionModel().selectFirstRow();
	        grid.getView().focusRow(0);
	        wndEditForm.show();	
		},
		
		/*
		 * Evento guarda registro
		 */
		onSave: function(){
			var mAction = isNew ? 'insert' : 'save';
			
			editForm.getForm().submit({
				clientValidation: true,
				method: 'POST',
				params:{app: '$AppName$', module: "$Table0.loObjName$.C$Table0.objName$", action: mAction},
				scope: this,			
				success: function(f,action){			
					editForm.getForm().updateRecord(this.rec);
					
					//this.rec.set('<campo>', action.result.rows[0].<campo>); 
					this.rec.endEdit();
					this.rec.commit();
					isNew = false;
					this.bChanged = true;
					wndEditForm.hide();
					//Ext.App.msg('Aviso', 'Objeto Guardado');
				},
				failure: function(form, action) {				        
					switch (action.failureType) {
						case Ext.form.Action.CLIENT_INVALID:
							Ext.Msg.alert('Error', 'Los datos proporcionados son invalidos');
							break;            
						case Ext.form.Action.CONNECT_FAILURE:                
							Ext.Msg.alert('Error', 'Ajax communication failed');                
							break;            
						case Ext.form.Action.SERVER_INVALID:               
							Ext.Msg.alert('Error', action.result.errors[0].errormsg);       
					}    
				}
			});
		},
		
		/*
		 * Evento eliminar registro
		 */
		onDelete: function(){
			if( this.mode == GRID )
				this.rec = grid.getSelectionModel().getSelected();			
			
			if( this.rec != null ){
				Ext.MessageBox.show({ 
					title:'Pregunta?',
		            msg: 'Esta seguro de borrar este registro ?',
		            buttons: Ext.MessageBox.YESNO,		            
		            icon: Ext.MessageBox.QUESTION,
		            scope: this,
		            fn: function(btn){
		            	if( btn == 'yes' ){
			            	editForm.getForm().submit({
								method: 'POST',
								params:{app: '$AppName$', module: "$Table0.loObjName$.C$Table0.objName$", action: "delete"},		
								scope: this,		
								success: function(f,a){
									dsGrid.remove(this.rec);
									this.bChanged = true;
									wndEditForm.hide();						
								},
								failure: function(form, action) {				        
									switch (action.failureType) {
										case Ext.form.Action.CLIENT_INVALID:
											Ext.Msg.alert('Error', 'Los datos proporcionados son invalidos');
											break;            
										case Ext.form.Action.CONNECT_FAILURE:                
											Ext.Msg.alert('Error', 'Ajax communication failed');                
											break;            
										case Ext.form.Action.SERVER_INVALID:               
											Ext.Msg.alert('Error', action.result.errors[0].errormsg);       
									}    
								}
							});
		            	}
		            }
		        });				
			}else{
				Ext.App.msgError('    Error           ', 'Se debe seleccionar un registro.' );
			}
		},
		
		/*
		 * Evento cancelar
		 */
		onCancel: function(){
		 	wndEditForm.hide();
		 	
		 	if( isNew ){
				this.rec.cancelEdit();
				dsGrid.remove(this.rec);
		 	}
		}
	}	
};
/*
</sec:authorize>
<sec:authorize ifNotGranted="ROLE_ADMINISTRATOR,APP_$Table0.permission$_ALL,APP_$Table0.permission$_READ">
function $AppName$_$Table0.objName$() {	
	return{
		initComponent: function(bLoad){
			Ext.App.msg('Error Message', "Error no tienes acceso.");			
		},
		
		initEditComponent: function(endFunction){
			Ext.App.msg('Error Message', "Error no tienes acceso.");
		}
	}
};
</sec:authorize> // */