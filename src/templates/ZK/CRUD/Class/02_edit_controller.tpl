package $Table0.package$.$Table0.objName$;

import org.zkoss.zkplus.databind.AnnotateDataBinder;
import org.zkoss.zul.Button;
import org.zkoss.zul.Combobox;
import org.zkoss.zul.Listbox;
import org.zkoss.zul.Listitem;
import org.zkoss.zul.Window;
import java.util.List;

import model.$AppName$.$Table0.objName$.$Table0.objName$;

import framework.security.Secure;

$Columns0:{ c |$if(c.isFK)$import model.$AppName$.$c.fkObjTable$.$c.fkObjTable$;
import model.$AppName$.$c.fkObjTable$.$c.fkObjTable$DAO; $endif$ }$

public class WndEdit$Table0.objName$Controller extends Window {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;	
	/*private Button btnOk;
	private Window win$Table0.objName$;*/
	private Button btnDelete;
	private Button btnSave;
	private Listbox lbList;
	
	/*
	$Columns0:{ c |$if(!c.isFK)$
$if(c.type.integer)$
private Intbox txt$c.upName$;
$elseif(c.type.double)$ 
private Doublebox txt$c.upName$;
$elseif(c.type.long)$ 
private Longbox txt$c.upName$;
$elseif(c.type.date)$ 
private Datebox txt$c.upName$;
$else$ 
private Textbox txt$c.upName$;
$endif$$else$
private Combobox cb$c.upName$;
$endif$}$
	*/
	 
	private boolean bNew;
	private $Table0.objName$ p;
	private $Table0.objName$ pOri;
	private AnnotateDataBinder binder;
	private String bindName = "dbObject"; 
	
	public WndEdit$Table0.objName$Controller(){
		super();
		this.p = null;
	}
	
	public void init(){
		lbList = (Listbox)this.getParent().getFellow("lbList$Table0.objName$s");
		btnDelete = (Button)this.getFellow("btnDelete");
		btnSave = (Button)this.getFellow("btnSave");
		
		binder = new AnnotateDataBinder(this);
	    binder.bindBean(bindName, p);
	    binder.loadAll();
	}
	
	public void set$Table0.objName$($Table0.objName$ p){	
		if(p == null){
			bNew = true;
			p = new $Table0.objName$();
		}else{
			bNew = false;
		}
		
		btnDelete.setVisible(
				Secure.hashPermission(	"APP_$Table0.permission$_DELETE", 
										"APP_$Table0.permission$_ALL", 
										"ROLE_ADMINISTRATOR")
		);
			
		btnSave.setVisible( this.isNew() ||
				Secure.hashPermission(	"APP_$Table0.permission$_UPDATE", 
										"APP_$Table0.permission$_ALL", 
										"ROLE_ADMINISTRATOR")
		);
		
		this.pOri = p;	
		this.p = p.createCopy();	
		binder.bindBean(bindName, this.p);
	    binder.loadAll();
	}
$Columns0:{c|$if(c.isFK)$
	public List<$c.fkObjTable$> get$c.upName$s() throws Exception{
		return new $c.fkObjTable$DAO().selectAll();
	}$endif$}$
	
	public void save(){
		bNew = false;		
		this.p.assign(this.pOri);
	}
	
	public void saveAll(){
		binder.saveAll();
	}
	
	public Listitem get$Table0.objName$Listitem(){
		if( !isNew() ){			
			return lbList.getSelectedItem();			
		}		
		return null;
	}
	
	public void remove$Table0.objName$Listitem(){
		lbList.removeChild(lbList.getSelectedItem());
	}
	
	public boolean isNew(){
		return this.bNew;
	}
	
	public $Table0.objName$ get$Table0.objName$(){
		return this.p;
	}
	
	public $Table0.objName$ get$Table0.objName$Base(){
		return this.pOri;
	}
}
