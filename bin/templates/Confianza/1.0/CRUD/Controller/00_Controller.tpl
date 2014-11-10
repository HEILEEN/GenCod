package com.confianza.webapp.controller.$AppName$.$Table0.loObjName$;

import java.util.List;
import javax.servlet.http.HttpServletRequest;
import org.springframework.http.HttpStatus;
import org.springframework.ui.Model;
import org.springframework.stereotype.Controller;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;
 
import com.confianza.webapp.service.$AppName$.$Table0.loObjName$.$Table0.objName$Service;
import com.confianza.webapp.repository.$AppName$.$Table0.loObjName$.$Table0.ObjName$;

@Controller
@RequestMapping("/$Table0.objName$")
public class C$Table0.objName$ {

	private $Table0.objName$Service $Table0.loObjName$Service;
	
	@Autowired
	public C$Table0.objName$($Table0.objName$Service $Table0.loObjName$Service) {
		this.$Table0.loObjName$Service = $Table0.loObjName$Service;
	}
	
	@RequestMapping(value = "/{id}", method = RequestMethod.GET)
	@ResponseBody
	public $Table0.objName$ list(Long id){
		
		return this.$Table0.loObjName$Service.list(id);
	}
	
	@RequestMapping(method = RequestMethod.GET)
	@ResponseBody
	public List<$Table0.objName$> listAll(){
	
		return this.$Table0.loObjName$Service.listAll();
	}
	
	@RequestMapping(value = "/{id}", method = RequestMethod.PUT)
	@ResponseStatus( HttpStatus.OK )
	@ResponseBody
	public $Table0.objName$ update(Long id){
		return this.$Table0.loObjName$Service.update(id);
	}
	
	@RequestMapping(value = "/{id}", method = RequestMethod.DELETE)
	@ResponseStatus( HttpStatus.OK )
	@ResponseBody
	public void delete(Long id){
		this.$Table0.loObjName$Service.delete(id);
	}
	
	@RequestMapping(method = RequestMethod.POST)
	@ResponseStatus( HttpStatus.CREATED )
	@ResponseBody
	public $Table0.objName$ insert(@RequestBody $Table0.objName$ $Table0.loObjName$){
		return this.$Table0.loObjName$Service.insert($Table0.loObjName$);
	}
}
