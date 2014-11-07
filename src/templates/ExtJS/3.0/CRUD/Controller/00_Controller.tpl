package gcontrollers.$AppName$.$Table0.loObjName$;

import java.util.List;

import model.$AppName$.$Table0.loObjName$.$Table0.objName$;
import model.$AppName$.$Table0.loObjName$.$Table0.objName$DAO;
$Columns0:{ c |$if(c.isFK)$ 
import model.$AppName$.$c.loFkObjTable$.$c.fkObjTable$;
import model.$AppName$.$c.loFkObjTable$.$c.fkObjTable$DAO; $endif$ }$

import framework.common.apps.ActionAnnotation;
import framework.common.apps.Controller;
import framework.common.db.HibernateUtil;
import framework.common.parametros.Variables;
import framework.common.ui.ExtJS.GridFilter;

public class C$Table0.objName$ extends Controller {
	public C$Table0.objName$() throws Exception{
		super();
		setHBSession( HibernateUtil.getHBSession("jdbc/MySqlDB") );
	}
	
	@ActionAnnotation(action=true, permisions={"APP_$Table0.permission$_ALL", "APP_$Table0.permission$_READ", "ROLE_ADMINISTRATOR"})
	public void listAll() throws Exception{
		
		int start = getParamInteger("start", 0);
		int limit = Variables.getInt("CONST_MAX_ROWS", 50); //getParamInt("limit", Variables.getInt("CONST_MAX_ROWS", 50));
		String sort = getParam("sort", null);
		String dir = getParam("dir","ASC");
		
		GridFilter filter = new GridFilter(request);
		
		$Table0.objName$DAO btd = new $Table0.objName$DAO( );
		int total = btd.getCount(filter);		
		List<$Table0.objName$> all =  btd.selectAllWithLimit(start, limit, filter, sort + " " + dir);
		
		doOut("success", true);
		doOut("results", total);
		doOut("rows", all);		
		doResponse();
		
        all.clear();
	}
	
	$Columns0:{c|$if(c.isFK)$
@ActionAnnotation(action=true, permisions = {"APP_$Table0.permission$_ALL", "APP_$Table0.permission$_READ", "ROLE_ADMINISTRATOR"})
public void list$c.upName$s() throws Exception{
	List<$c.fkObjTable$> lst = new $c.fkObjTable$DAO().selectAll(); 
	
	doOut("success", true);
	doOut("results", lst.size());
	doOut("rows", lst);		
	doResponse();
}$endif$}$
	
	@ActionAnnotation(action=true, permisions={"APP_$Table0.permission$_ALL", "APP_$Table0.permission$_READ", "ROLE_ADMINISTRATOR"})
	public void load() throws Exception{
		$ColumnsPk0:{ c |$c.type.ormType$ $c.loName$ = getParam$c.type.ormType$("$c.loName$", null); };separator="\n"$
		
		$Table0.objName$DAO btd = new $Table0.objName$DAO( );		
		$Table0.objName$ bt =  btd.load($ColumnsPk0:{ c |$c.loName$ };separator=", "$);
		
		if( bt != null ){
			doOut("success", true);
			doOut("data", bt );		
			doResponse();	
		}else{
			doResponseError("El registro no existe.");
		}
	}
	
	@ActionAnnotation(action=true, permisions={"APP_$Table0.permission$_ALL", "APP_$Table0.permission$_UPDATE", "ROLE_ADMINISTRATOR"})
	public void save() throws Exception{
		
		$Table0.objName$DAO btd = new $Table0.objName$DAO( );		
		$Table0.objName$ bt = new $Table0.objName$();
		
		$Columns0:{ c | bt.set$c.upName$(getParam$c.type.ormType$("$c.loName$", null)); };separator="\n"$
		
		btd.update(bt, $ColumnsPk0:{ c | bt.get$c.upName$() };separator=", "$);
		
		doOut("success", true);
		doOut("results", 1);
		doOut("rows", new $Table0.objName$[]{ bt });		
        doResponse();
	}
	
	@ActionAnnotation(action=true, permisions={"APP_$Table0.permission$_ALL", "APP_$Table0.permission$_CREATE", "ROLE_ADMINISTRATOR"})
	public void insert() throws Exception{
		
		$Table0.objName$DAO btd = new $Table0.objName$DAO( );		
		$Table0.objName$ bt = new $Table0.objName$();
		
		$Columns0:{ c | bt.set$c.upName$(getParam$c.type.ormType$("$c.loName$", null)); };separator="\n"$
		
		btd.insert(bt);
		
		doOut("success", true);
		doOut("results", 1);
		doOut("rows", new $Table0.objName$[]{ bt });		
        doResponse();
	}
	
	@ActionAnnotation(action=true, permisions={"APP_$Table0.permission$_ALL", "APP_$Table0.permission$_DELETE", "ROLE_ADMINISTRATOR"})
	public void delete() throws Exception{

		$Table0.objName$DAO btd = new $Table0.objName$DAO( );		
		$Table0.objName$ bt = new $Table0.objName$();
		
		$Columns0:{ c | bt.set$c.upName$(getParam$c.type.ormType$("$c.loName$", null)); };separator="\n"$
		
		btd.delete(bt);
		
		doResponse(true);
	}
}
