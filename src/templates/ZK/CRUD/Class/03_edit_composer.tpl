package $Table0.package$.$Table0.objName$;

$comments$

import org.zkoss.zk.ui.Component;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.util.GenericAutowireComposer;
//import org.zkoss.zul.api.Button;
import org.zkoss.zul.Datebox;
import org.zkoss.zul.Doublebox;
import org.zkoss.zul.Longbox;
import org.zkoss.zul.Combobox;
import org.zkoss.zul.Listitem;
import org.zkoss.zul.Messagebox;
import org.zkoss.zul.api.Button;
import org.zkoss.zul.api.Textbox;

import model.$AppName$.$Table0.objName$.$Table0.objName$;
import model.$AppName$.$Table0.objName$.$Table0.objName$DAO;

$Columns0:{ c |$if(c.isFK)$import model.$AppName$.$c.fkObjTable$.$c.fkObjTable$;
import model.$AppName$.$c.fkObjTable$.$c.fkObjTable$DAO; $endif$ }$
import framework.security.Secure;
import framework.common.Components.AListcell;

public class WndEdit$Table0.objName$Composer extends GenericAutowireComposer {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;	
	//private Button btnOk;
	private WndEdit$Table0.objName$Controller win$Table0.objName$;
	private Button btnDelete;
	private Button btnSave;
	
	$Columns0:{c|$if(!c.isFK)$
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
		$endif$ 
$else$
private Combobox cb$c.upName$;
$endif$}$
		
	private $Table0.objName$ p;
	
	public void doAfterCompose(Component window) {
		win$Table0.objName$ = (WndEdit$Table0.objName$Controller)window;
		btnDelete = (Button)win$Table0.objName$.getFellow("btnDelete");
		btnSave = (Button)win$Table0.objName$.getFellow("btnSave");	
		$Columns0:{c| $if(!c.isFK)$
$if(c.type.integer)$txt$c.upName$ = (Intbox)win$Table0.objName$.getFellow("txt$c.upName$");
$elseif(c.type.double)$ 
txt$c.upName$ = (Doublebox)win$Table0.objName$.getFellow("txt$c.upName$");
$elseif(c.type.long)$ 
txt$c.upName$ = (Longbox)win$Table0.objName$.getFellow("txt$c.upName$");
$elseif(c.type.date)$ 
txt$c.upName$ = (Datebox)win$Table0.objName$.getFellow("txt$c.upName$");
$else$ 
txt$c.upName$ = (Textbox)win$Table0.objName$.getFellow("txt$c.upName$");
$endif$$else$ 
cb$c.upName$ = (Combobox)win$Table0.objName$.getFellow("cb$c.upName$"); $endif$}$
    	
		win$Table0.objName$.addEventListener("onSource1", new EventListener() {
			public void onEvent(Event event) throws Exception {
				onSave(event);
			}
		});
    	
    	win$Table0.objName$.addEventListener("onSource2", new EventListener() {
			public void onEvent(Event event) throws Exception {
				onDelete(event);
			}
		});
    	
    	win$Table0.objName$.addEventListener("onSource3", new EventListener() {
			public void onEvent(Event event) throws Exception {
				onHide(event);
			}
		});
	}
	
	public void onHide(Event event){
		win$Table0.objName$.setVisible(false);
	}
	
	public void onSave(Event event) throws InterruptedException {
		if( ( Secure.hashPermission("APP_$Table0.permission$_CREATE") && win$Table0.objName$.isNew() ) ||
			  Secure.hashPermission("APP_$Table0.permission$_UPDATE","APP_$Table0.permission$_ALL","ROLE_ADMINISTRATOR") ){
			try {
				$Table0.objName$DAO pd = new $Table0.objName$DAO();
				$Table0.objName$ pn = new $Table0.objName$();
				
				p = win$Table0.objName$.get$Table0.objName$Base();
				//alert("DATA:" + p.getTbclave() +":"+ p.getTbcodigo() + ":" + p.getDbTbvalint());
				win$Table0.objName$.saveAll();
				pn = win$Table0.objName$.get$Table0.objName$();
				
				if(!win$Table0.objName$.isNew())
				{
					//alert("DATA:" + pn.getTbclave() +":"+ pn.getTbcodigo() + ":" + pn.getDbTbvalint());
					pd.update(pn, $ColumnsPk0:{ pk | p.get$pk.upName$() }; separator=","$);
					pn.assign(p);
					
					Listitem i$Table0.objName$ = win$Table0.objName$.get$Table0.objName$Listitem();
					if(i$Table0.objName$ != null){				
						int i=0;
					
						$Columns0:{c| ((AListcell)i$Table0.objName$.getChildren().get(i++)).setLabel(pn.get$c.upName$());}; separator="\n"$
					}
					win$Table0.objName$.save();
				}else{
					pd.insert(pn);
					pn.assign(p);
					win$Table0.objName$.save();
				}
				
				alert("Guardado.");
				onHide(event);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				try {
					Messagebox.show("Error: " + e.getMessage(), "Error", Messagebox.OK, Messagebox.ERROR);
				} catch (InterruptedException e1) {
					// TODO Auto-generated catch block
					e1.printStackTrace();
				}
			}
		}else{
			Messagebox.show("No tienes permisos.", "Error", Messagebox.OK, Messagebox.ERROR);
		}
    }
	
	public void onDelete(Event event) throws InterruptedException {
		if(Secure.hashPermission("APP_$Table0.permission$_DELETE","APP_$Table0.permission$_ALL","ROLE_ADMINISTRATOR")){
			int res = Messagebox.show("Realmente desea realizar esta operación?", "Pregunta", Messagebox.YES | Messagebox.NO, Messagebox.QUESTION);
			if(res == Messagebox.YES){
				try {
					$Table0.objName$DAO pd = new $Table0.objName$DAO();
					pd.delete(win$Table0.objName$.get$Table0.objName$());					
					win$Table0.objName$.remove$Table0.objName$Listitem();
					
					alert("Item borrado.");
					onHide(event);
				} catch (Exception e) {
					// TODO Auto-generated catch block
					try {
						Messagebox.show("Error: " + e.getMessage(), "Error", Messagebox.OK, Messagebox.ERROR);
					} catch (InterruptedException e1) {
						// TODO Auto-generated catch block
						e1.printStackTrace();
					}
				}
			}
		}else{
			Messagebox.show("No tienes permisos.", "Error", Messagebox.OK, Messagebox.ERROR);
		}
    }
}
