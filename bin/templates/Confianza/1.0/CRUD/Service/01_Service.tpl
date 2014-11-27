package com.confianza.webapp.service.$AppName$.$Table0.loObjName$;

$comments$

import java.util.List;
import com.confianza.webapp.repository.$AppName$.$Table0.loObjName$.$Table0.objName$;

public interface $Table0.objName$Service{
	
	public $Table0.objName$ list(Long id);
	
	public List<$Table0.objName$> listAll(int pageSize, int page);	
	
	public $Table0.objName$ update(Long id);
	
	public void delete(Long id);
	
	public $Table0.objName$ insert($Table0.objName$ $Table0.loObjName$);
	
	public int getCount();
	
}