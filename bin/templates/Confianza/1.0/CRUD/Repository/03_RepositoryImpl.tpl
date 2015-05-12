package com.confianza.webapp.repository.$AppName$.$Table0.loObjName$;

$comments$

import java.util.List;
import java.util.Iterator;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

@Repository
public class $Table0.objName$RepositoryImpl implements $Table0.objName$Repository{
	
	@Autowired
	private SessionFactory sessionFactory;  	
	
	public SessionFactory getSessionFactory() {
		return sessionFactory;
	}

	public void setSessionFactory(SessionFactory sessionFactory) {
		this.sessionFactory = sessionFactory;
	}
	
	public Session getSession() {
		return sessionFactory.getCurrentSession();
	}
	
	/**
	 * Metodo de consulta para los registros de la tabla $Table0.objName$ por id
	 * @value id = id de la llave primaria a consultar el registro
	 * @return $Table0.objName$ = objeto de la case $Table0.objName$ que contiene los datos encontrados dado el id
	 * @throws Exception
	 */
	@Override
	@Transactional
	public $Table0.objName$ list(Long id){
		try{
			String sql = "select "+$Table0.objName$.getColumnNames()
					   + "from $Table0.tableName$ "
					   + "where $Columns0:{ c |	$if(!Table0.nPk)$$if(c.Pk)$$c.loName$$endif$$endif$};separator=""$ = :id ";
						
			Query query = getSession().createSQLQuery(sql)
						 .addEntity($Table0.objName$.class)					
					     .setParameter("id", id);
			return ($Table0.objName$)query.uniqueResult();
		}catch(Exception e){
			e.printStackTrace();
			return null;
		}
	}
	
	/**
	 * Metodo de consulta para los registros de la tabla $Table0.objName$
	 * @return $Table0.objName$ = coleccion de objetos de la case $Table0.objName$ que contiene los datos encontrados
	 * @throws Exception
	 */
	@Override
	@Transactional
	public List<$Table0.objName$> listAll(int init, int limit){
		try{
			String sql = "select "+$Table0.objName$.getColumnNames()
					   + "from $Table0.tableName$ ";
						
			Query query = getSession().createSQLQuery(sql)
						 .addEntity($Table0.objName$.class);
						 
			if(init==0 && limit!=0){
				query.setFirstResult(init);			
				query.setMaxResults(limit);
			}
					     
			return query.list();
		}catch(Exception e){
			e.printStackTrace();
			return null;
		}
	}	
	
	/**
	 * Metodo de consulta para el conteo de los registros de la tabla $Table0.objName$
	 * @return int = cantidad de registros encontrados
	 * @throws Exception
	 */
	@Override
	@Transactional
	public int getCount(){
		try{
			String sql = "select count(*) "
					   + "from $Table0.objName$ ";
						
			Query query = getSession().createQuery(sql);
	        
			Iterator it = query.list().iterator();
	        Long ret = new Long(0);
	        
	        if (it != null)
		        if (it.hasNext()){
		        	ret = (Long) it.next();
		        }
	        
			return ret.intValue();
		}catch(Exception e){
			e.printStackTrace();
			return 0;
		}
	}
	
	/**
	 * Metodo para actualizar los datos de un registro de la tabla $Table0.objName$ por id
	 * @value id = id de la llave primaria a consultar el registro
	 * @return $Table0.objName$ = objeto de la case $Table0.objName$ que contiene los datos encontrados dado el id
	 * @throws Exception
	 */
	@Override
	@Transactional
	public $Table0.objName$ update($Table0.objName$ $Table0.loObjName$){
		getSession().update($Table0.loObjName$);
		return $Table0.loObjName$;
	}
	
	/**
	 * Metodo para borrar un registro de la tabla $Table0.objName$ por id
	 * @value id = id de la llave primaria a consultar el registro
	 * @return $Table0.objName$ = objeto de la case $Table0.objName$ que contiene los datos encontrados dado el id
	 * @throws Exception
	 */
	@Override
	@Transactional
	public void delete($Table0.objName$ $Table0.loObjName$){
		
	}
	
	/**
	 * Metodo para ingresar un registro de la tabla $Table0.objName$
	 $Columns0:{ c |* @value $c.loName$}; separator="\n"$
	 * @return $Table0.objName$ = objeto de la case $Table0.objName$ que contiene los datos ingresados
	 * @throws Exception
	 */
	@Override
	@Transactional
	public $Table0.objName$ insert($Table0.objName$ $Table0.loObjName$){
		getSession().save($Table0.loObjName$);	
		return $Table0.loObjName$;
	}
}