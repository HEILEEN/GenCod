package com.confianza.webapp.service.$AppName$.$Table0.loObjName$;

$comments$

import java.util.List;
import com.confianza.webapp.repository.$AppName$.$Table0.loObjName$.$Table0.objName$;

public interface $Table0.objName$Service{
	
	public String list(Long id);
	
	public String listAll(int pageSize, int page, String order, String stringFilters);	
	
	public String insert($Table0.objName$ $Table0.loObjName$);
	
	public String update($Table0.objName$ $Table0.loObjName$);
	
	public void delete($Table0.objName$ $Table0.loObjName$);	
	
	public int getCount(List<Filter> filters);
	
}