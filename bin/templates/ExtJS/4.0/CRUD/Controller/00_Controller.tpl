package gcontrollers.$AppName$.$Table0.loObjName$;

import java.lang.reflect.Type;

import com.google.gson.reflect.TypeToken;

import framework.common.apps.ActionAnnotation;
import framework.common.apps.impl.BasicREST;
import framework.common.apps.impl.Ext4Controller;

import model.$AppName$.$Table0.loObjName$.$Table0.objName$;
import model.$AppName$.$Table0.loObjName$.$Table0.objName$DAO;
$Columns0:{ c |$if(c.isFK)$ 
import model.$AppName$.$c.loFkObjTable$.$c.fkObjTable$;
import model.$AppName$.$c.loFkObjTable$.$c.fkObjTable$DAO; $endif$ }$

public class C$Table0.objName$  extends Ext4Controller<$Table0.objName$, $if(Table0.nPk)$$Table0.objName$Pk$else$$ColumnsPk0:{ c |$c.type.ormType$};separator=", "$$endif$, $Table0.objName$DAO>  {
	public C$Table0.objName$() throws Exception{
		super(new $Table0.objName$DAO(), "$ConnName$");
	}
	
	@ActionAnnotation(action=true, permisions={"APP_$Table0.permission$_ALL", "APP_$Table0.permission$_READ", "ROLE_ADMINISTRATOR"})
	public void listAll() throws Exception{
		super.listAll();
	}
	
	$Columns0:{c|$if(c.isFK)$
@ActionAnnotation(action=true, permisions = {"APP_$Table0.permission$_ALL", "APP_$Table0.permission$_READ", "ROLE_ADMINISTRATOR"})
public void list$c.upName$s() throws Exception{
	List<$c.fkObjTable$> lst = new $c.fkObjTable$DAO().selectAll(); 
	
	doOut("success", true);
	doOut("total", lst.size());
	doOut("data", lst);		
	doResponse();
}$endif$}$
	
	@ActionAnnotation(action=true, permisions={"APP_$Table0.permission$_ALL", "APP_$Table0.permission$_READ", "ROLE_ADMINISTRATOR"})
	public void load() throws Exception{
		super.load();
	}
	
	@ActionAnnotation(action=true, permisions={"APP_$Table0.permission$_ALL", "APP_$Table0.permission$_UPDATE", "ROLE_ADMINISTRATOR"})
	public void save() throws Exception{
		super.save();
	}
	
	@ActionAnnotation(action=true, permisions={"APP_$Table0.permission$_ALL", "APP_$Table0.permission$_CREATE", "ROLE_ADMINISTRATOR"})
	public void insert() throws Exception{
		super.insert();
	}
	
	@ActionAnnotation(action=true, permisions={"APP_$Table0.permission$_ALL", "APP_$Table0.permission$_DELETE", "ROLE_ADMINISTRATOR"})
	public void delete() throws Exception{
		super.delete();
	}
	
	@Override
	public $Table0.objName$ getObjectFromRequest() throws Exception{
		String sdata = readFromREST();
		
		BasicREST<$Table0.objName$> data;
		Type type = (Type) new TypeToken<BasicREST<$Table0.objName$>>() {}.getType();
		data = this.gson.fromJson(sdata, type);
		
		$Table0.objName$ ret = data.getData();
		
		return ret;
	}

	@Override
	public $if(Table0.nPk)$$Table0.objName$Pk$else$$ColumnsPk0:{ c |$c.type.ormType$};separator=", "$$endif$ getPkFromRequest() {
		$ColumnsPk0:{ c |$c.type.ormType$ $c.loName$ = getParam$c.type.ormType$("$c.loName$", null); };separator="\n"$
	$if(Table0.nPk)$
		return new $Table0.objName$Pk($ColumnsPk0:{ c |$c.loName$};separator=", "$);
	$else$
		return $ColumnsPk0:{ c |$c.loName$;};separator="\n "$
	$endif$
	}
}
