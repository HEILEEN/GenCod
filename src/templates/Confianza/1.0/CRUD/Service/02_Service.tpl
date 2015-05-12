package com.confianza.webapp.service.$AppName$.$Table0.loObjName$;

$comments$

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.security.RolesAllowed;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.google.gson.Gson;
import com.confianza.webapp.repository.$AppName$.$Table0.loObjName$.$Table0.objName$;
import com.confianza.webapp.repository.$AppName$.$Table0.loObjName$.$Table0.objName$Repository;

@Service
public class $Table0.objName$ServiceImpl implements $Table0.objName$Service{
	
	@Autowired
	private $Table0.objName$Repository $Table0.loObjName$Repository;
	
	@Autowired
	Gson gson;
	
	/**
	 * @return the $Table0.loObjName$Repository
	 */
	public $Table0.objName$Repository get$Table0.objName$Repository() {
		return $Table0.loObjName$Repository;
	}

	/**
	 * @param $Table0.loObjName$Repository the $Table0.loObjName$Repository to set
	 */
	public void set$Table0.objName$Repository($Table0.objName$Repository $Table0.loObjName$Repository) {
		this.$Table0.loObjName$Repository = $Table0.loObjName$Repository;
	}
	
	@Override
	@RolesAllowed({"ADMINISTRATOR_ADMINISTRATOR", "APP_$Table0.permission$__ALL", "APP_$Table0.permission$__READ"})
	public String list(Long id){
		$Table0.objName$ listAll=$Table0.loObjName$Repository.list(id);
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("data", listAll);
		result.put("count", this.getCount());
		
		return gson.toJson(result);	
	}
	
	@Override
	@RolesAllowed({"ADMINISTRATOR_ADMINISTRATOR", "APP_$Table0.permission$__ALL", "APP_$Table0.permission$__READ"})
	public String listAll(int pageSize, int page){
	
		int limit=pageSize;
		int init=(pageSize*page)-(pageSize);
		
		List<$Table0.objName$> listAll=$Table0.loObjName$Repository.listAll(init, limit);
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("data", listAll);
		result.put("count", this.getCount());
		
		return gson.toJson(result);	
	}	
	
	@Override
	public int getCount(){
				
		return $Table0.loObjName$Repository.getCount();
	}
	
	@Override
	@RolesAllowed({"ADMINISTRATOR_ADMINISTRATOR", "APP_$Table0.permission$__ALL", "APP_$Table0.permission$__UPDATE"})
	public String update($Table0.objName$ $Table0.loObjName$){
		return gson.toJson($Table0.loObjName$Repository.update($Table0.loObjName$));
	}
	
	@Override
	@RolesAllowed({"ADMINISTRATOR_ADMINISTRATOR", "APP_$Table0.permission$__ALL", "APP_$Table0.permission$__DELETE"})
	public void delete($Table0.objName$ $Table0.loObjName$){
		$Table0.loObjName$Repository.delete($Table0.loObjName$);
	}
	
	@Override
	@RolesAllowed({"ADMINISTRATOR_ADMINISTRATOR", "APP_$Table0.permission$__ALL", "APP_$Table0.permission$__CREATE"})
	public String insert($Table0.objName$ $Table0.loObjName$){
		return gson.toJson($Table0.loObjName$Repository.insert($Table0.loObjName$));
	}
	
}