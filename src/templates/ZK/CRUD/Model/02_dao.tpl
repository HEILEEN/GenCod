package model.$AppName$.$Table0.objName$;

$comments$

import java.util.Iterator;
import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;

import framework.common.Class.FilterContainer;
import framework.common.Class.GlobalVar;
import framework.common.Class.HBSession;
import framework.common.Const.Constantes;

public class $Table0.objName$DAO{
	private String tableName;
	private Class className;
	private HBSession session;
	
	public $Table0.objName$DAO(){
		this.session = (HBSession)GlobalVar.getVar(Constantes.CONST_HBSESSION);
		this.tableName = "$Table0.tableName$";
		this.className = $Table0.objName$.class;
	}
	
	public String getTableName(){
		return this.tableName;
	}
	
	@SuppressWarnings("unchecked")
	public Class getObjectClass(){
		return this.className;
	}	
	
	@SuppressWarnings("unchecked")
	public List<$Table0.objName$> selectAllWithLimit(int init, int max, FilterContainer filterContainer, String orderBy) throws Exception{
		
		List<$Table0.objName$> list;
		String filter = "";
		Object[] params = null;
		Object[] nameParams = null;
		
		if(filterContainer != null ){
			filter = " WHERE " + filterContainer.toString();
			params = filterContainer.getParams();
			nameParams = filterContainer.getNameParams();
		}
			
		if(orderBy != null && orderBy.length() > 0 )
			orderBy = " ORDER BY "+orderBy;
		else
			orderBy = "";
		
		String sql = String.format("from $Table0.objName$ %1\$s %2\$s ", filter, orderBy );
		//System.out.println("SQL ($Table0.objName$): " + sql);
				
		Session ses = this.session.getSessionFactory().openSession(  );
        ses.beginTransaction();
        
        Query query = ses.createQuery(sql);
        query.setFirstResult(init);
        query.setMaxResults(max);

        if(nameParams != null){
	        for(int i = 0; i<nameParams.length; i++){
	        	query.setParameter(nameParams[i].toString(), params[i]);
	        }
        }
        
        list = query.list();
        ses.getTransaction().commit();
        ses.close();
        
        return list;
	}	
	
	@SuppressWarnings("unchecked")
	public List<$Table0.objName$> selectAll() throws Exception{
		
		List<$Table0.objName$> list;
		
		Session ses = this.session.getSessionFactory().openSession(  );
        ses.beginTransaction();
        
        Query query = ses.createQuery("from $Table0.objName$ ");        
        list = query.list();
        ses.getTransaction().commit();
        ses.close();
        
        return list;
	}		
	
	@SuppressWarnings("unchecked")
	public int getCount(FilterContainer filterContainer) throws Exception{
		String filter = "";
		Object[] params = null;
		Object[] nameParams = null;
		
		if(filterContainer != null ){
			filter = " WHERE " + filterContainer.toString();
			params = filterContainer.getParams();
			nameParams = filterContainer.getNameParams();
		}
		
		Session ses = this.session.getSessionFactory().openSession(  );
        ses.beginTransaction();
        
        String sql = String.format("SELECT count(*) FROM $Table0.objName$ %1\$s ", filter );
        //System.out.println("SQL Count($Table0.objName$): " + sql);
        Query query = ses.createQuery(sql);

        if(nameParams != null){
	        for(int i = 0; i<nameParams.length; i++){
	        	query.setParameter(nameParams[i].toString(), params[i]);
	        }
        }
        
        Iterator it = query.list().iterator();
        Long ret = new Long(0);
        
        if(it != null)
	        if(it.hasNext()){
	        	ret = (Long)it.next();
	        }

        ses.getTransaction().commit();
        ses.close();
		
		return ret.intValue();		
	}	
	
	public void insert($Table0.objName$ p) throws Exception{
		Session ses = this.session.getSessionFactory().openSession(  );
        ses.beginTransaction();

        ses.save(p);
        ses.getTransaction().commit();
        ses.close();
	}
	
	public $Table0.objName$ load($ColumnsPk0:{ c |$c.type.ormType$ $c.loName$};separator=", "$) throws Exception{
		Session ses = this.session.getSessionFactory().openSession(  );
        ses.beginTransaction();

	$if(Table0.nPk)$
        $Table0.objName$Pk pk = new $Table0.objName$Pk();
        $ColumnsPk0:{ c |pk.set$c.upName$($c.loName$);};separator="\n"$
        
        $Table0.objName$ p = ($Table0.objName$)ses.load($Table0.objName$.class, pk);
    $else$
    	$Table0.objName$ p = ($Table0.objName$)ses.load($Table0.objName$.class, $ColumnsPk0:{ c |$c.loName$};separator=", "$);
    $endif$

        ses.getTransaction().commit();
        ses.close();
		return p;
	}
	
	public void update($Table0.objName$ p, $ColumnsPk0:{ c |$c.type.ormType$ $c.loName$};separator=", "$) throws Exception{
		
		Session ses = this.session.getSessionFactory().openSession(  );
        ses.beginTransaction();
        
    $if(Table0.nPk)$
        $Table0.objName$Pk pk = new $Table0.objName$Pk();
        $ColumnsPk0:{ c |pk.set$c.upName$($c.loName$);};separator="\n"$
        
        $Table0.objName$ lp = ($Table0.objName$)ses.load($Table0.objName$.class, pk);
    $else$
    	$Table0.objName$ lp = ($Table0.objName$)ses.load($Table0.objName$.class, $ColumnsPk0:{ c |$c.loName$};separator=", "$);
    $endif$
        
        p.assign(lp);
        ses.update(lp);

        ses.getTransaction().commit();
        ses.close();
	}
	
	public void delete($Table0.objName$ p) throws Exception{		
		Session ses = this.session.getSessionFactory().openSession(  );
        ses.beginTransaction();
        
        ses.delete(p);

        ses.getTransaction().commit();
        ses.close();
	}
}