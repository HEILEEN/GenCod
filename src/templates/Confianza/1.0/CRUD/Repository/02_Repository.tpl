package com.confianza.webapp.repository.$AppName$.$Table0.loObjName$;

$comments$

import java.util.List;

public interface $Table0.objName$Repository {
	
	public $Table0.objName$ list(Long id);
	
	public List<$Table0.objName$> listAll(int init, int limit);	
	
	public $Table0.objName$ update($Table0.objName$ $Table0.loObjName$);
	
	public void delete($Table0.objName$ $Table0.loObjName$);
	
	public $Table0.objName$ insert($Table0.objName$ $Table0.loObjName$);
	
	public int getCount();
}