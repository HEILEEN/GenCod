package model.$AppName$.$Table0.loObjName$;

$comments$

import java.util.Iterator;
import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Hibernate;

import framework.common.db.HBSession;
import framework.common.db.HibernateUtil;
import framework.common.ui.ExtJS.GridFilter;

/**
	 * Modelo del negocio de la tabla
	 * 
	 * @value tableName = es el nombre de la tabla
	 * @value className = es el nombre de la clase a la cual corresponde la tabla especificada en tableName
	 * @value session   = es el nombre de la sesion de hibernate que se maneja
	 *
 */	
public class $Table0.objName$DAO{
	private String tableName;
	private Class className;
	private HBSession session;
	
	/**
	 * Constructor de la clase
	 * 	
	 * @param session   = es el nombre de la sesion de hibernate con la que se quiere manejar el DAO
	 * @throws Exception
     */	
	public $Table0.objName$DAO(HBSession session){
		this.session = session;
		this.tableName = "$Table0.tableName$";
		this.className = $Table0.objName$.class;
	}
	
	/**
	 * Constructor de la clase vacio toma por defecto la sesion $ConnName$
	 * 	
	 * @throws Exception
     */	
	public $Table0.objName$DAO() throws Exception{
		this.session = HibernateUtil.getHBSession("$ConnName$");
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
	
	/**
	 * Metodo para consultar los registros de la tabla: $Table0.objName$. Teniendo en cuenta los limites dados
	 * 	
	 * @param init    =limite inferior del rango de la lista de registros a mostrar en la consulta
	 * @param max     =limite superior del rango de la lista de registros a mostrar en la consulta
	 * @param orderBy =atributo por el cual se debe ordenar la consulta y direccion del ordenamiento de la consulta
	 * @param gf      =filtros por las cuales el usuario quiere realizar cierta busqueda en ciertos campos
	 *
	 * @return list   =Coleccion de objetos del tipo $Table0.objName$
	 * @throws Exception
     */	
	@SuppressWarnings("unchecked")
	public List<$Table0.objName$> selectAllWithLimit(int init, int max, GridFilter gf, String orderBy) throws Exception{
		
		List<$Table0.objName$> list;
		String filter = "";
		List<Object[]> params = null;
		
		if( gf != null && gf.hasFilter() ){
			filter = " WHERE " + gf.getSentencias();
			params = gf.getParametros();
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
        if( max!=-1){
        	query.setMaxResults(max);
        }	

        if( params != null && params.size() > 0 ){
	        for( Object[] parametro: params ){
	        	query.setParameter(parametro[0].toString(), parametro[1]);
	        }
        }
        
        list = query.list();
        ses.getTransaction().commit();
        ses.close();
        
        return list;
	}	
	
	/**
	 * Metodo para consultar todos los registros de la tabla: $Table0.objName$.
	 * 		 
	 * @return list   =Coleccion de objetos del tipo $Table0.objName$
	 * @throws Exception
     */	
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
	
	/**
	 * Metodo para consultar la cantidad de registros de la tabla: $Table0.objName$.
	 * 	
	 * @param gf        =palabras por las cuales el usuario quiere realizar cierta busqueda en ciertos campos
	 *
	 * @return contador =conteo de los resultados de la busqueda, de acuerdo con la consulta dada
	 * @throws Exception
     */	
	@SuppressWarnings("unchecked")
	public int getCount(GridFilter gf) throws Exception{
		String filter = "";
		List<Object[]> params = null;
		
		if( gf != null && gf.hasFilter() ){
			filter = " WHERE " + gf.getSentencias();
			params = gf.getParametros();
		}
		
		Session ses = this.session.getSessionFactory().openSession(  );
        ses.beginTransaction();
        
        String sql = String.format("SELECT count(*) FROM $Table0.objName$ %1\$s ", filter );
        //System.out.println("SQL Count($Table0.objName$): " + sql);
        Query query = ses.createQuery(sql);

        if( params != null && params.size() > 0 ){
	        for( Object[] parametro: params ){
	        	query.setParameter(parametro[0].toString(), parametro[1]);
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
	
	/**
	 * Metodo para consultar la cantidad de registros de la tabla: $Table0.objName$. Dado un sql 
	 * 	
	 * @param gf            = filtros por las cuales el usuario quiere realizar cierta busqueda en ciertos campos
	 * @param sql           = cadena de caracteres que contiene la consulta
	 * @param misparametros = parametros propios a añadir a la consulta de 2 posiciones la 0(Debe ser el nombre del parametro segun como esta en la consulta) y la posicion 1(Debe ser el valor de ese parametro)
	 *
	 * @return contador     = conteo de los resultados de la busqueda, de acuerdo con el filtro dado
	 *
	 * @throws Exception
     */	
	@SuppressWarnings("unchecked")
	public int sqlCount(GridFilter gf,String miSql,List<String[]> misparametros) throws Exception{
		String filter = "";
		List<Object[]> params = null;
		
		if( gf != null && gf.hasFilter() ){
			filter = " WHERE " + gf.getSentencias();
			params = gf.getParametros();
		}
		
		Session ses = this.session.getSessionFactory().openSession(  );
        ses.beginTransaction();
        
        String sql = String.format("SELECT count(*) maximo FROM ("+miSql+") test "+ filter );
        //System.out.println("SQL Count($Table0.objName$): " + sql);
        Query query = ses.createSQLQuery(sql).addScalar("maximo",Hibernate.LONG);   

        if( params != null && params.size() > 0 ){
	        for( Object[] parametro: params ){
	        	query.setParameter(parametro[0].toString(), parametro[1]);
	        }
        }
        if( misparametros != null && misparametros.size() > 0 ){
	        for( String[] parametro:misparametros ){
	        	query.setParameter(parametro[0], parametro[1]);
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
	
	/**
	 * Metodo para ingresar un nuevo registro en la base de datos
	 * 	
	 * @param p        =objeto de la clase $Table0.objName$, que contiene los nuevos datos a ingresar
	 *
	 * @throws Exception
     */	
	public void insert($Table0.objName$ p) throws Exception{
		Session ses = this.session.getSessionFactory().openSession(  );
        ses.beginTransaction();

        ses.save(p);
        ses.getTransaction().commit();
        ses.close();
	}
	
	/**
	 * Metodo para buscar un objeto de la clase $Table0.objName$
	 * 	
	 * @param $ColumnsPk0:{ c |$c.type.ormType$ $c.loName$};separator=", "$=consecutivo de la llave primaria por el cual van a buscar el objeto 
	 *
	 * @return p = retorna un objeto de la clase $Table0.objName$ que contiene los datos guardados
	 * @throws Exception
     */	
	public $Table0.objName$ load($ColumnsPk0:{ c |$c.type.ormType$ $c.loName$};separator=", "$) throws Exception{
		Session ses = this.session.getSessionFactory().openSession(  );
        ses.beginTransaction();

	$if(Table0.nPk)$
        $Table0.objName$Pk pk = new $Table0.objName$Pk();
        $ColumnsPk0:{ c |pk.set$c.upName$($c.loName$);};separator="\n"$
        
        $Table0.objName$ p = ($Table0.objName$)ses.get($Table0.objName$.class, pk);
    $else$
    	$Table0.objName$ p = ($Table0.objName$)ses.get($Table0.objName$.class, $ColumnsPk0:{ c |$c.loName$};separator=", "$);
    $endif$

        ses.getTransaction().commit();
        ses.close();
		return p;
	}
	
	/**
	 * Metodo para actualizar los datos de un objeto tipo $Table0.objName$
	 * 	
	 * @param p=objeto de la clase $Table0.objName$ que contiene los nuevos datos
	 * @param $ColumnsPk0:{ c |$c.type.ormType$ $c.loName$};separator=", "$=consecutivo de la llave primaria por el cual van a modificar el objeto  
	 *
	 * @throws Exception
     */	
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
	
	/**
	 * Metodo para borrar definitivamente un archivo de la base de datos
	 * 	
	 * @param p=objeto de la clase $Table0.objName$ que contiene los datos a eliminar
	 *
	 * @throws Exception
     */	
	public void delete($Table0.objName$ p) throws Exception{		
		Session ses = this.session.getSessionFactory().openSession(  );
        ses.beginTransaction();
        
        ses.delete(p);

        ses.getTransaction().commit();
        ses.close();
	}
}