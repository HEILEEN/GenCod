package model.$AppName$.$Table0.loObjName$;

$comments$

import framework.common.db.HBSession;
import framework.common.db.dao.BaseDAO;

public class $Table0.objName$DAO extends BaseDAO<$Table0.objName$, $if(Table0.nPk)$$Table0.objName$Pk$else$$ColumnsPk0:{ c |$c.type.ormType$};separator=", "$$endif$>{
	public $Table0.objName$DAO(HBSession session) throws Exception{
		super(session, "$Table0.tableName$", "$Table0.objName$");
	}
	
	public $Table0.objName$DAO() throws Exception{
		super("$ConnName$", "$Table0.tableName$", "$Table0.objName$");
	}
}