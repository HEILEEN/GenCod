package com.confianza.webapp.controller.$AppName$.$Table0.loObjName$;

import java.util.List;
import com.google.gson.Gson;

import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.PathVariable;
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
		
		return gson.toJson(this.$Table0.loObjName$Service.list($Columns0:{ c |	$if(!Table0.nPk)$$if(c.Pk)$$c.loName$$endif$$endif$};separator=""$));
	}
	
	@RequestMapping(value = "/listAll.json", method = RequestMethod.GET, produces={"application/json"})
	@ResponseBody
	public String listAll(){
	
		return gson.toJson(this.$Table0.loObjName$Service.listAll());
	}
	
	@RequestMapping(value = "/{$Columns0:{ c |	$if(!Table0.nPk)$$if(c.Pk)$$c.loName$$endif$$endif$};separator=""$}", method = RequestMethod.PUT)
	@ResponseStatus( HttpStatus.OK )
	@ResponseBody
	public $Table0.objName$ update(@PathVariable("$Columns0:{ c |	$if(!Table0.nPk)$$if(c.Pk)$$c.loName$$endif$$endif$};separator=""$") Long $Columns0:{ c |	$if(!Table0.nPk)$$if(c.Pk)$$c.loName$$endif$$endif$};separator=""$, HttpServletRequest request){
	
		HttpSession session = request.getSession();
		FrmSesion frmSesion = (FrmSesion) session.getAttribute("frmSesion");
		
		return this.$Table0.loObjName$Service.update($Columns0:{ c |	$if(!Table0.nPk)$$if(c.Pk)$$c.loName$$endif$$endif$};separator=""$);
	}
	
	@RequestMapping(value = "/{$Columns0:{ c |	$if(!Table0.nPk)$$if(c.Pk)$$c.loName$$endif$$endif$};separator=""$}.json", method = RequestMethod.DELETE)
	@ResponseStatus( HttpStatus.OK )
	@ResponseBody
	public void delete(@PathVariable("$Columns0:{ c |	$if(!Table0.nPk)$$if(c.Pk)$$c.loName$$endif$$endif$};separator=""$") Long $Columns0:{ c |	$if(!Table0.nPk)$$if(c.Pk)$$c.loName$$endif$$endif$};separator=""$, HttpServletRequest request){
	
		HttpSession session = request.getSession();
		FrmSesion frmSesion = (FrmSesion) session.getAttribute("frmSesion");
		
		this.$Table0.loObjName$Service.delete($Columns0:{ c |	$if(!Table0.nPk)$$if(c.Pk)$$c.loName$$endif$$endif$};separator=""$);
	}
	
	@RequestMapping(method = RequestMethod.POST, produces={"application/json"})
	@ResponseStatus( HttpStatus.CREATED )
	@ResponseBody
	public String insert(@RequestBody $Table0.objName$ $Table0.loObjName$, HttpServletRequest request){
		
		HttpSession session = request.getSession();
		FrmSesion frmSesion = (FrmSesion) session.getAttribute("frmSesion");
		
		return gson.toJson(this.$Table0.loObjName$Service.insert($Table0.loObjName$));
	}
}
