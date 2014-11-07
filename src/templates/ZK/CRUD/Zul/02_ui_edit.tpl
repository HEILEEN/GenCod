<?taglib uri="http://www.zkoss.org/dsp/web/core" prefix="c" ?>
<!--
$comments$
-->
<window title="Editar \${c:l('$Table0.objName$')}" border="normal" position="center, center" width="400px" id="wndEdit$Table0.objName$"
	use="$Table0.package$.$Table0.objName$.WndEdit$Table0.objName$Controller"
	apply="$Table0.package$.$Table0.objName$.WndEdit$Table0.objName$Composer"
	xmlns:a="http://www.zkoss.org/2005/zk/annotation">
	<grid>
		<rows>
		$Columns0:
{c|$if(!c.type.isFK)$
$if(c.type.integer)$
<row>\${c:l('$Table0.objName$.$c.upName$')}<a:bind value="dbObject.$c.upName$"/><intbox id="txt$c.upName$" constraint="no negative" /></row>
$elseif(c.type.double)$ 
<row>\${c:l('$Table0.objName$.$c.upName$')}<a:bind value="dbObject.$c.upName$"/><doublebox id="txt$c.upName$" $if(!c.nullable)$constraint="no empty" $endif$ format="\${desktop.session.attributes.format_double}" /></row>
$elseif(c.type.long)$ 
<row>\${c:l('$Table0.objName$.$c.upName$')}<a:bind value="dbObject.$c.upName$"/><longbox id="txt$c.upName$" $if(!c.nullable)$constraint="no empty" $endif$/></row>
$elseif(c.type.date)$ 
<row>\${c:l('$Table0.objName$.$c.upName$')}<a:bind value="dbObject.$c.upName$"/><datebox id="txt$c.upName$" $if(!c.nullable)$constraint="no empty" $endif$format="\${desktop.session.attributes.format_datetime}" /></row>
$else$ 
<row>\${c:l('$Table0.objName$.$c.upName$')}<a:bind value="dbObject.$c.upName$"/><textbox id="txt$c.upName$" $if(!c.nullable)$constraint="no empty" $endif$/></row>
$endif$
$else$
	<row>\${c:l('$Table0.objName$.$c.upName$')} 
		<a:bind selectedItem="dbObject.$c.upName$"/>
 		<combobox id="cb$c.upName$" constraint="strict">
		 	<comboitem forEach="\${wndEdit$Table0.objName$.$c.loName$s}" label="\${each.$c.fkObjColumnLo$}" 
 					   description="\${each.$c.fkObjColumnLo$}" value="\${each.$c.fkObjColumnLo$}" 
 					   id="cb$c.upName$\${each.$c.fkObjColumnLo$}" />
		</combobox>
 	</row>
$endif$}$
		</rows> 
	</grid>
	<tablelayout columns="2" width="100%" style="padding:4px;">
		<tablechildren>
			<panel border="none">
				<panelchildren>
					<button label="Borrar" id="btnDelete" forward="onClick=wndEdit$Table0.objName$.onSource2" width="80" />
				</panelchildren>	
			</panel>
		</tablechildren>
		<tablechildren>
			<panel border="none">
				<panelchildren>
					<div align="right">
					<button label="Guardar" id="btnSave" forward="onClick=wndEdit$Table0.objName$.onSource1" width="80" />
					<button label="Cancelar" id="btnCancel" forward="onClick=wndEdit$Table0.objName$.onSource3" width="80" />
					</div>
				</panelchildren>
			</panel>
		</tablechildren>
	</tablelayout>
</window>