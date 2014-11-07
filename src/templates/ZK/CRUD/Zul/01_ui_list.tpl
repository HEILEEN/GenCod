<?page title="Auto Generated .zul"?>
<?init class="org.zkoss.zkplus.databind.AnnotateDataBinderInit" arg0="./win$Table0.objName$" ?>
<?taglib uri="http://www.zkoss.org/dsp/web/core" prefix="c" ?>
<!--
$comments$
-->
<window id="win$Table0.objName$" title="Listado" border="normal" width="90%" height="500px" sizable="true"  
	apply="$Table0.package$.$Table0.objName$.WndList$Table0.objName$Composer">
	<caption image="\${desktop.session.attributes.rcimg}/app.png" label="\${c:l('$Table0.objName$')}"/>
	<toolbar>
		<hbox>
			<div style="padding-top:3px;">
				<toolbarbutton id="btnNuevo" label="Nuevo" forward="onClick=onBtnNuevoClick" 
							image="\${desktop.session.attributes.rcimg}/new.png" style="padding:4px; background-color:transparent;" />
				<toolbarbutton id="btnBuscar" label="Buscar" forward="onClick=onBtnBuscarClick" 
							image="\${desktop.session.attributes.rcimg}/find.png" style="padding:4px; background-color:transparent;" />
			</div>			
		</hbox>		
	</toolbar>		
	<borderlayout style="border: none;">
		<north style="border: none;"><paging id="userPaging" forward="onPaging=onUserPaging" detailed="true" />	</north>
		<center flex="true" autoscroll="true" style="border: none;">
			<listbox vflex="true" id="lbList$Table0.objName$s" fixedLayout="false" height="100%">
				<listhead sizable="true" context="editPopup">
					$Columns0:{ c | <listheader label="\${c:l('$Table0.objName$.$c.upName$')}" id="lh$c.upName$" /> }; separator="\n"$
				</listhead>
			</listbox>
		</center>
		<south style="border: none;"><div style="padding:2px;">-</div></south>
	</borderlayout>
	<menupopup id="editPopup">
		<menuitem label="Desagrupar" forward="onClick=onBtnGroupByClick" />
		<menuseparator />
		<menu label="Agrupar">
			<menupopup>
				$Columns0:{ c |<menuitem label="\${c:l('$Table0.objName$.$c.upName$')}" forward="onClick=onBtnGroupByClick($c.name$)" />}; separator="\n"$
			</menupopup>
		</menu>
	</menupopup>
</window>