<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<sec:authorize ifAnyGranted="ADMINISTRATOR_ADMINISTRATOR, $Table0.permission$_ALL, $Table0.permission$_READ">	
		
      <div ng-controller="$Table0.objName$Controller" ng-init="init()"><!-- Division grid maestro -->      	
        <div class="well well-sm">
			<sec:authorize ifAnyGranted="ADMINISTRATOR_ADMINISTRATOR,$Table0.permission$_ALL,$Table0.permission$_CREATE"><button type="button" class="btn btn-primary btn-sm" data-toggle="modal" data-target="#myModalNew" ng-click="createRecordForm()"> Nuevo <span class="glyphicon glyphicon-file"> </span></button></sec:authorize>
			<sec:authorize ifAnyGranted="ADMINISTRATOR_ADMINISTRATOR,$Table0.permission$_ALL,$Table0.permission$_UPDATE"><button type="button" class="btn btn-success btn-sm" data-toggle="modal" data-target="#myModalNew" ng-click="loadDatatoForm()"  > Editar <span class="glyphicon glyphicon-edit"> </span></button></sec:authorize>
			<sec:authorize ifAnyGranted="ADMINISTRATOR_ADMINISTRATOR,$Table0.permission$_ALL,$Table0.permission$_DELETE"><button type="button" class="btn btn-danger btn-sm" data-toggle="modal" data-target="#myModalNew" ng-click="deleteRecordForm()" > Borrar <span class="glyphicon glyphicon-trash"> </span></button></sec:authorize>
			<button type="button" class="btn btn-default btn-sm"><a href="#"> Ayuda <span class="glyphicon glyphicon-info-sign"> </span></a></button>	
		</div>
		<h3>{{ventanaTitulo}}</h3>
    	<custom-grid cols="columnDefs" selected-items="selectedItems" custom-options="gridOptions" evento="gridEvento" icons="iconForeesta" data-ng-if="directiveGrid"></custom-grid>
    	<!-- ventana modal -->
    	<!-- Modal New -->
		<div class="modal fade" id="myModalNew" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		  <div class="modal-dialog">
		    <div class="modal-content">
		      <div class="modal-header">
		        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
		        <h4 class="modal-title" id="myModalLabel">{{ventanaTitulo}}</h4>
		      </div>
		      <div class="modal-body">
		        <form name="formInsert" class="form-horizontal" role="form">
		$Columns0:
		{c|
			$if(!c.type.isFK)$
				$if(c.type.integer)$
					<div class="form-group">
						<label for="$c.loName$" class="col-sm-2 control-label">{{ whatClassIsIt("$c.loName$") }}</label>
						<div class="col-sm-10">
							<input type="number" name ="$c.loName$" id="$c.loName$" style="width:100%;" ng-model="$c.loName$" value="{{$c.loName$}}" ng-pattern="/^(0|\-?[1-9][0-9]*)\$/" ng-required="true" readonly="true">
						</div>
					</div>							
				$elseif(c.type.long)$
					<div class="form-group">
						<label for="$c.loName$" class="col-sm-2 control-label">{{ whatClassIsIt("$c.loName$") }}</label>
						<div class="col-sm-10">
							<input type="number" name ="$c.loName$" id="$c.loName$" style="width:100%;" ng-model="$c.loName$" value="{{$c.loName$}}" ng-pattern="/^(0|\-?[1-9][0-9]*)\$/" ng-required="true" data-ng-readonly="buttonDelete">
						</div>
					</div>
				$elseif(c.type.double)$
					<div class="form-group">
						<label for="$c.loName$" class="col-sm-2 control-label">{{ whatClassIsIt("$c.loName$") }}</label>
						<div class="col-sm-10">
							<input type="number" name ="$c.loName$" id="$c.loName$" style="width:100%;" ng-model="$c.loName$" readonly="readonly" value="{{$c.loName$}}" ng-pattern="/^(0|\-?{0,9}\.\d{1,9})\$/" step="any" ng-required="true" data-ng-readonly="buttonDelete">
						</div>
					</div>	
				$elseif(c.type.date)$
					<div class="form-group">
						<label for="$c.loName$" class="col-sm-2 control-label">{{ whatClassIsIt("$c.loName$") }}</label>
						<div class="col-sm-10">
							<input style="width:100%;" type="text" datepicker-popup="dd/MM/yyyy" ng-model="$c.loName$" is-open="campoDate" ng-click="campoDate=true" datepicker-options="dateOptions" date-disabled="disabled(date, mode)" ng-required="true" ui-date ui-date-format="dd/MM/yyyy" close-text="Cerrar" current-text="Hoy" clear-text="Limpiar" data-ng-readonly="buttonDelete"/>
						</div>
					</div>
				$else$
					<div class="form-group">
						<label for="$c.loName$" class="col-sm-2 control-label">{{ whatClassIsIt("$c.loName$") }}</label>
						<div class="col-sm-10">
							<input style="width:100%;" type="text" name ="{{$c.loName$}}" id="{{$c.loName$}}" ng-model="$c.loName$" ng-required="true" data-ng-readonly="buttonDelete">
						</div>
					</div>
				$endif$
			$else$
				<div class="form-group">
					<label for="$c.loName$" class="col-sm-2 control-label">{{ whatClassIsIt("$c.loName$") }}</label>
					<div class="col-sm-10">
						<input type="number" name ="$c.loName$" id="$c.loName$" style="width:100%;" ng-model="$c.loName$" readonly="readonly" value="{{$c.loName$}}" data-ng-readonly="buttonDelete">
					</div>
				</div>							
			$endif$ 
	};separator=""$				
	  			</form>
		      </div>
		      <div class="modal-footer">
		        <button type="button" class="btn btn-default" data-dismiss="modal">Cerrar</button>
		        <button type="button" class="btn btn-primary" ng-click="insertRecord()" ng-show="buttonNew">Registrar <span class="glyphicon glyphicon-floppy-disk"></span></button>
		        <button type="button" class="btn btn-success" ng-click="updateRecord()" ng-show="buttonEdit">Guardar Cambios <span class="glyphicon glyphicon-floppy-disk"></span></button>
		        <button type="button" class="btn btn-danger" ng-click="deleteRecord()" ng-show="buttonDelete">Borrar <span class="glyphicon glyphicon-trash"> </span></button>
		      </div>
		    </div>
		  </div>		  			
		</div>
		
		<custom-alert labelerror="Ninguno"></custom-alert>									
      </div>          	    	        
</sec:authorize>  