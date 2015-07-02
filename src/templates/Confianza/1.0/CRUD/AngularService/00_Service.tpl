var FrmMainApp=angular.module('FrmMainApp');

FrmMainApp.service('$Table0.objName$Service', function(\$http) {	    	
    	this.id=0;
		this.I18n;
    	
    	this.getData = function(pageSize, page, order, filter) {    		    		
    		return \$http({
    	        method: 'GET',
    	        url:  WEB_SERVER+'$Table0.objName$/listAll.json',
    	        params: {pageSize: pageSize, page: page, order: order, filter: filter }
    	     });
    	 }
    	
    	this.getI18n = function() {    		    		
    		return \$http({
    	        method: 'GET',
    	        url: WEB_SERVER+'FrmI18n/listModulo.json',
    	        params: {modulo: '$Table0.permission$' }
    	     });
    	 }
    	
    	this.setI18n = function(I18n) {
            this.I18n = I18n;
    	};
    	
    	this.insertRecord = function($Columns0:{ c| $c.loName$}; separator=","$) {    	
    		
    		data = {$Columns0:{ c| $c.loName$ : $c.loName$}; separator=", "$};
    		
    		return \$http({
    	        method: 'POST',
    	        url: WEB_SERVER+'$Table0.objName$/insert',
    	        data: data
    	     });
    	 }
    	
		this.updateRecord = function($Columns0:{ c| $c.loName$}; separator=","$) {    	
    		
			data = {$Columns0:{ c| $c.loName$ : $c.loName$}; separator=", "$};
    		
			return \$http({
    	        method: 'POST',
    	        url: WEB_SERVER+'$Table0.objName$/update',
    	        data: data
    	     });
    	 }
		
		this.deleteRecord = function($Columns0:{ c| $c.loName$}; separator=","$) {    	
    		
    		data = {$Columns0:{ c| $c.loName$ : $c.loName$}; separator=", "$};
    		
    		return \$http({
    	        method: 'POST',
    	        url: WEB_SERVER+'$Table0.objName$/delete',
    	        data: data
    	     });
    	 }
				
    });    	