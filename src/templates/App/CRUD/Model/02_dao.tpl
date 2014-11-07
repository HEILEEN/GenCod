package com.model.$AppName$.$Table0.loObjName$;

$comments$

import com.lib.db.base.BaseDAO;

public class $Table0.objName$DAO extends BaseDAO{
	public $Table0.objName$DAO() throws Exception{
		super($Table0.objName$.class, "$Table0.tableName$");
	}
	
	public $if(Table0.nPk)$$Table0.objName$Pk $else$$ColumnsPk0:{ c |$c.type.ormType$};separator=", "$$endif$ insert($Table0.objName$ p) throws Exception{
		return ($if(Table0.nPk)$$Table0.objName$Pk $else$$ColumnsPk0:{ c |$c.type.ormType$};separator=", "$$endif$) super.insert(p);
	}
	
	public $Table0.objName$ load($if(Table0.nPk)$ $Table0.objName$Pk pk $else$ $ColumnsPk0:{ c |$c.type.ormType$ $c.loName$};separator=", "$ $endif$) throws Exception{
		return ($Table0.objName$)super.load($if(Table0.nPk)$ pk $else$ $ColumnsPk0:{ c |$c.loName$};separator=", "$ $endif$);
	}
	
	public void update($Table0.objName$ p, $if(Table0.nPk)$ $Table0.objName$Pk pk $else$ $ColumnsPk0:{ c |$c.type.ormType$ $c.loName$};separator=", "$ $endif$) throws Exception{
		super.update(p, $if(Table0.nPk)$ pk $else$ $ColumnsPk0:{ c |$c.loName$};separator=", "$ $endif$);
	}
	
	public void delete($Table0.objName$ p) throws Exception{		
		super.delete(p);
	}
}