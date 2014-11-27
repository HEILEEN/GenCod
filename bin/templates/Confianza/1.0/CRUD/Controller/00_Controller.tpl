package com.confianza.webapp.controller.$AppName$.$Table0.loObjName$;

import java.util.List;
import java.util.HashMap;
import com.google.gson.Gson;

import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;

import com.confianza.webapp.service.$AppName$.$Table0.loObjName$.$Table0.objName$Service;
import com.confianza.webapp.repository.$AppName$.$Table0.loObjName$.$Table0.ObjName$;
import com.confianza.webapp.repository.framework.frmsesion.FrmSesion;

@Controller
@EnableWebMvc
@RequestMapping("/$Table0.objName$")
public class C$Table0.objName$ {

	private $Table0.objName$Service $Table0.loObjName$Service;
	
	@Autowired
	Gson gson;
	
	public C$Table0.objName$() {
		super();
	}
	
	@Autowired
	public C$Table0.objName$($Table0.objName$Service $Table0.loObjName$Service) {
		this.$Table0.loObjName$Service = $Table0.loObjName$Service;
	}
	
	@RequestMapping("/")
	public String index(Model model) {
		return "$AppName$/$Table0.loObjName$/$Table0.objName$";
	}
	
	@RequestMapping(value = "/{$Columns0:{ c |	$if(!Table0.nPk)$$if(c.Pk)$$c.loName$$endif$$endif$};separator=""$}.json", method = RequestMethod.GET, produces={"application/json"})
	@ResponseBody
	public String list(@PathVariable("$Columns0:{ c |	$if(!Table0.nPk)$$if(c.Pk)$$c.loName$$endif$$endif$};separator=""$") Long $Columns0:{ c |	$if(!Table0.nPk)$$if(c.Pk)$$c.loName$$endif$$endif$};separator=""$){
		
		try{
			return gson.toJson(this.$Table0.loObjName$Service.list($Columns0:{ c |	$if(!Table0.nPk)$$if(c.Pk)$$c.loName$$endif$$endif$};separator=""$));
		}catch(AccessDeniedException e){
			return "Acceso denegado";
		}
	}
	
	@RequestMapping(value = "/listAll.json", params = {"page","pageSize"},  method = RequestMethod.GET, produces={"application/json"})
	@ResponseBody
	public String listAll(@RequestParam("pageSize") int pageSize, @RequestParam("page") int page){
	
		try{
			List<$Table0.ObjName$> listAll=this.$Table0.loObjName$Service.listAll(pageSize, page);
			
			Map<String, Object> result = new HashMap<String, Object>();
			result.put("data", listAll);
			result.put("count", this.$Table0.loObjName$Service.getCount());
			
			return gson.toJson(result);
		}catch(AccessDeniedException e){
			return "Acceso denegado";
		}
	}
	
	@RequestMapping(value = "/update", method = RequestMethod.POST, produces={"application/json"})
	@ResponseStatus( HttpStatus.OK )
	@ResponseBody
	public $Table0.objName$ update(@RequestBody $Table0.ObjName$ $Table0.loObjName$, HttpServletRequest request){
	
		try{		
			return gson.toJson(this.$Table0.loObjName$Service.update($Table0.loObjName$) );
		}catch(AccessDeniedException e){
			return "Acceso denegado";
		}
	}
	
	@RequestMapping(value = "/delete", method = RequestMethod.POST, produces={"application/json"})
	@ResponseStatus( HttpStatus.OK )
	@ResponseBody
	public void delete(@RequestBody $Table0.ObjName$ $Table0.loObjName$, HttpServletRequest request){
	
		try{
			this.$Table0.loObjName$Service.delete($Columns0:{ c |	$if(!Table0.nPk)$$if(c.Pk)$$c.loName$$endif$$endif$};separator=""$);
			return "Borrado";
		}catch(AccessDeniedException e){
			return "Acceso denegado";
		}
	}
	
	@RequestMapping(value = "/insert", method = RequestMethod.POST, produces={"application/json"})
	@ResponseStatus( HttpStatus.CREATED )
	@ResponseBody
	public String insert(@RequestBody $Table0.objName$ $Table0.loObjName$, HttpServletRequest request){
		
		try{
			return gson.toJson(this.$Table0.loObjName$Service.insert($Table0.loObjName$));
		}catch(AccessDeniedException e){
			return "Acceso denegado";
		}
	}
}
