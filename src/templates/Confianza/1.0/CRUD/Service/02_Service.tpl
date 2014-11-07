package com.confianza.webapp.service.$AppName$.$Table0.loObjName$;

$comments$

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;

import com.confianza.webapp.repository.$AppName$.$Table0.loObjName$.$Table0.objName$;
import com.confianza.webapp.repository.$AppName$.$Table0.loObjName$.$Table0.objName$Repository;

public class $Table0.objName$ServiceImpl implements $Table0.objName$Service{
	
	@Autowired
	private $Table0.objName$Repository $Table0.loObjName$Repository;
	
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
	public $Table0.objName$ list(Long id){
		return $Table0.loObjName$Repository.list(id);
	}
	
	@Override
	public List<$Table0.objName$> listAll(){
		return $Table0.loObjName$Repository.listAll();
	}	
	
	@Override
	public $Table0.objName$ update(Long id){
		return $Table0.loObjName$Repository.update(id);
	}
	
	@Override
	public void delete(Long id){
		$Table0.loObjName$Repository.delete(id);
	}
	
	@Override
	public $Table0.objName$ insert($Table0.objName$ $Table0.loObjName$){
		return $Table0.loObjName$Repository.insert($Table0.loObjName$);
	}
	
}