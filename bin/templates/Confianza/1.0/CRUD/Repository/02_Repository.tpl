package com.confianza.webapp.repository.$AppName$.$Table0.loObjName$;

$comments$

import java.util.List;

public interface $Table0.objName$Repository {
	
	public $Table0.objName$ list(Long id);
	
	public List<$Table0.objName$> listAll(int init, int limit);	
	
	public $Table0.objName$ update(Long id);
	
	public void delete(Long id);
	
	public void insert($Table0.objName$ $Table0.loObjName$);
	
	public int getCount();
}