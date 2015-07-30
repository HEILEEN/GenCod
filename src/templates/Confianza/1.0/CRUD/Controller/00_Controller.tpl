package com.confianza.webapp.controller.$AppName$.$Table0.loObjName$;

import javax.servlet.http.HttpServletRequest;

import org.springframework.http.HttpStatus;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseStatus;


import com.confianza.webapp.service.$AppName$.$Table0.loObjName$.$Table0.objName$Service;
import com.confianza.webapp.repository.$AppName$.$Table0.loObjName$.$Table0.ObjName$;

@Controller
@RequestMapping("/$Table0.objName$")
public class C$Table0.objName$ {

	@Autowired
	private $Table0.objName$Service $Table0.loObjName$Service;
	
	public C$Table0.objName$() {
		super();
	}
			
	@RequestMapping("/")
	public String index() {
		return "$AppName$/$Table0.loObjName$/$Table0.objName$";
	}
	
	@RequestMapping(value = "/{$Columns0:{ c |	$if(!Table0.nPk)$$if(c.Pk)$$c.loName$$endif$$endif$};separator=""$}.json", method = RequestMethod.GET, produces={"application/json; charset=ISO-8859-1"})
	@ResponseBody
	public String list(@PathVariable("$Columns0:{ c |	$if(!Table0.nPk)$$if(c.Pk)$$c.loName$$endif$$endif$};separator=""$") Long $Columns0:{ c |	$if(!Table0.nPk)$$if(c.Pk)$$c.loName$$endif$$endif$};separator=""$){
		
		return this.$Table0.loObjName$Service.list($Columns0:{ c |	$if(!Table0.nPk)$$if(c.Pk)$$c.loName$$endif$$endif$};separator=""$);
	}
	
	@RequestMapping(value = "/listAll.json",  method = RequestMethod.GET, produces={"application/json; charset=ISO-8859-1"})
	@ResponseBody
	public String listAll(@RequestParam("pageSize") int pageSize, @RequestParam("page") int page, @RequestParam("order") String order, @RequestParam(value ="filter", required=false) String filters){
	
		return this.$Table0.loObjName$Service.listAll(pageSize, page, order, filters);
	}
	
	@RequestMapping(value = "/update", method = RequestMethod.POST, produces={"application/json; charset=ISO-8859-1"})
	@ResponseStatus( HttpStatus.OK )
	@ResponseBody
	public String update(@RequestBody $Table0.ObjName$ $Table0.loObjName$, HttpServletRequest request){
	
		return this.$Table0.loObjName$Service.update($Table0.loObjName$);
	}
	
	@RequestMapping(value = "/delete", method = RequestMethod.POST, produces={"application/json; charset=ISO-8859-1"})
	@ResponseStatus( HttpStatus.OK )
	@ResponseBody
	public String delete(@RequestBody $Table0.ObjName$ $Table0.loObjName$, HttpServletRequest request){
	
		//$Table0.loObjName$.setesta("B");
		return this.$Table0.loObjName$Service.update($Table0.loObjName$);
	}
	
	@RequestMapping(value = "/insert", method = RequestMethod.POST, produces={"application/json; charset=ISO-8859-1"})
	@ResponseStatus( HttpStatus.CREATED )
	@ResponseBody
	public String insert(@RequestBody $Table0.objName$ $Table0.loObjName$, HttpServletRequest request){
		
		return this.$Table0.loObjName$Service.insert($Table0.loObjName$);		
	}
}
