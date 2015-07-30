var FrmMainApp=angular.module('FrmMainApp');

FrmMainApp.controller('$Table0.objName$Controller', ['\$scope', '$Table0.objName$Service',function(\$scope, Service) {
    	//botones de los formularios modal
    	\$scope.buttonNew=false;
    	\$scope.buttonEdit=false;
    	\$scope.buttonDelete=false;    	
    	
    	//Funcion para inicializar los datos en la carga de la pagina
		\$scope.init = function() {
			Service.getI18n().then(function(dataResponse) {        	                                        	
        	 	
        	 	Service.setI18n(dataResponse.data);
        	 	
	        	columns=[ $Columns0:{ c | { field: "$c.loName$", displayName: getName(Service.getI18n(), "$c.loName$", "$Table0.tableName$"), visible: true } }; separator=";\n"$];
	            
	            \$scope.columnDefs=columns;
	            
	            \$scope.ventanaTitulo=getName(Service.getI18n(), "-", "$Table0.tableName$");
	            
	            \$scope.gridOptions = {  
	                	sortInfo:{ fields: ['usuacons'], directions: ['desc']},
	                	selectedItems: [],
	                    afterSelectionChange: function (rowItem, event) {
	                    	$Columns0:{ c| \$scope.$c.loName$ = rowItem.entity.$c.loName$; }; separator="\n "$   	                    	                    	   
	                    }
	                };
	            
	            //Si lleva un filtro basico la grid \$scope.basicSearchQuery=[{campo: 'usuatipo', tipo: "=", val1: 1, tipodato: "Number"} ];
	            
	            \$scope.directiveGrid=true;
	            
        	});        	        	
        	
		}	        
              
        function getName(i18n,colum,modulo){
	    	var log = [];
	    	angular.forEach(i18n, function(fila, index) {
	    		if(fila.etincamp==colum && fila.modunomb==modulo)  
	    			this.push(fila);
	   		}, log);
	    	
	    	return log[0].etinetiq;        	
	    }
        
        \$scope.whatClassIsIt= function(column){
        	var log = [];
        	
        	angular.forEach(\$scope.columnDefs, function(fila, index) {
        		if(fila.field==column)
        			this.push(fila);
       		}, log);
        	
        	return log[0].displayName;
        }                
               
       \$scope.createRecordForm= function(){
    	    \$scope.buttonNew=true;
			\$scope.buttonEdit=false;
			\$scope.buttonDelete=false;
			
			$Columns0:{ c| \$scope.$c.loName$ = ""; }; separator="\n"$        	
        }                
        
		\$scope.loadDatatoForm= function(){			
			
			if(\$scope.gridOptions.selectedItems.length>0){
				\$scope.buttonNew=false;
				\$scope.buttonEdit=true;
				\$scope.buttonDelete=false;					        	
			}
			else{
				\$scope.sendAlert("Favor seleccione una fila");
				\$('#myModalNew').modal('hide');		
			}	
        }                       
		
		\$scope.deleteRecordForm= function(){
			
			if(\$scope.gridOptions.selectedItems.length>0){
				\$scope.buttonNew=false;
				\$scope.buttonEdit=false;
				\$scope.buttonDelete=true;					        	
			}
			else{
				\$scope.sendAlert("Favor seleccione una fila");
				\$('#myModalNew').modal('hide');		
			}			
        }
		
		\$scope.insertRecord= function(){
			
			if($scope.validateData())	
				Service.insertRecord($Columns0:{ c| \$scope.$c.loName$}; separator=","$).then(function(dataResponse) {    
					if(dataResponse.data.error!=undefined)
						$scope.sendAlert(dataResponse.data.tituloError+': '+dataResponse.data.error);
			    	else{    	            
						row=dataResponse.data;
						
						$Columns0:{ c| \$scope.$c.loName$ = row.$c.loName$; }; separator="\n"$     
							
						\$scope.sendAlert("Se creo el registro correctamente");		
			        	\$('#myModalNew').modal('hide');
			        	\$scope.loadMyGrid();
			        }
		        }); 
		    else
				$scope.sendAlert("Faltan datos por diligenciar");    
        }
		
		\$scope.updateRecord= function(){
			
			if($scope.validateData())	
				Service.updateRecord($Columns0:{ c| \$scope.$c.loName$}; separator=","$).then(function(dataResponse) { 
					if(dataResponse.data.error!=undefined)
						$scope.sendAlert(dataResponse.data.tituloError+': '+dataResponse.data.error);
			    	else{       	            
						row=dataResponse.data;
						
						$Columns0:{ c| \$scope.$c.loName$ = row.$c.loName$; }; separator="\n"$
						
						\$scope.sendAlert("Se actualizo el registro correctamente");
						\$('#myModalNew').modal('hide');
			        	\$scope.loadMyGrid();
			        }
		        });
		    else
				$scope.sendAlert("Faltan datos por diligenciar");     
        }
		
		\$scope.deleteRecord= function(){
						
			Service.deleteRecord($Columns0:{ c| \$scope.$c.loName$}; separator=","$).then(function(dataResponse) { 
				if(dataResponse.data.error!=undefined)
					$scope.sendAlert(dataResponse.data.tituloError+': '+dataResponse.data.error);
			    else{         	            
					row=dataResponse.data;
					
					$Columns0:{ c| \$scope.$c.loName$ = row.$c.loName$; }; separator="\n"$
	
					\$scope.sendAlert("Se borro el registro correctamente");
					\$('#myModalNew').modal('hide');
		        	\$scope.loadMyGrid();
		        }
	        }); 
        }
        
        \$scope.\$on('gridEvento', function(event, pageSize, currentPage, order, searchQuery) {   
			\$scope.pageSize=pageSize;
			\$scope.currentPage=currentPage;
			\$scope.order=order;
			\$scope.searchQuery=searchQuery;
			if(\$scope.searchQuery==undefined)
			\$scope.searchQuery=[];
			
	    	if(\$scope.directiveGrid)
	    		\$scope.loadMyGrid();
	    });
		
		\$scope.loadMyGrid= function(){	
			
			Service.getData(\$scope.pageSize, \$scope.currentPage, \$scope.order, \$scope.searchQuery.concat(\$scope.basicSearchQuery)).then(function(dataResponse) {
	    		if(dataResponse.data.error!=undefined)
	    			\$scope.sendAlert(dataResponse.data.tituloError+': '+dataResponse.data.error);
	        	else 
	        		\$scope.\$broadcast('loadDataGrid',dataResponse.data.data, dataResponse.data.count, \$scope.pageSize, \$scope.currentPage);
	        });
		}
		
		\$scope.sendAlert = function(error){
			\$scope.\$broadcast('loadDataError', error);
		}
		
		\$scope.validateData= function(){			
			
			if(!formInsert.$valid)
				return false;
			$Columns0:{ c| else if(\$scope.$c.loName$==undefined || \$scope.$c.loName$.trim()=='')
				return false;}; separator="\n"$	
						
			return true;
		}				
    }            
    ])