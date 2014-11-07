package $Table0.package$.$Table0.objName$;

$comments$

import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.zkoss.lang.Strings;
import org.zkoss.zk.ui.Component;
import org.zkoss.zk.ui.Executions;
import org.zkoss.zk.ui.SuspendNotAllowedException;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.ForwardEvent;
import org.zkoss.zk.ui.util.GenericAutowireComposer;
import org.zkoss.zul.FieldComparator;
import org.zkoss.zul.GroupsModel;
import org.zkoss.zul.ListModel;
import org.zkoss.zul.Listbox;
import org.zkoss.zul.Listcell;
import org.zkoss.zul.Listheader;
import org.zkoss.zul.Listitem;
import org.zkoss.zul.ListitemRenderer;
import org.zkoss.zul.Paging;
import org.zkoss.zul.Toolbarbutton;
import org.zkoss.zul.Window;
import org.zkoss.zul.api.Listhead;
import org.zkoss.zul.event.PagingEvent;

import model.$AppName$.$Table0.objName$.$Table0.objName$;
import model.$AppName$.$Table0.objName$.$Table0.objName$ListModel;

$Columns0:{ c |$if(c.isFK)$import model.$AppName$.$c.fkObjTable$.$c.fkObjTable$;
import model.$AppName$.$c.fkObjTable$.$c.fkObjTable$DAO; $endif$ }$
import framework.common.Class.GlobalVar;
import framework.common.Class.HBSession;
import framework.common.Class.Params;
import framework.common.Components.AListcell;
import framework.common.Const.Constantes;
import framework.security.Secure;

public class WndList$Table0.objName$Composer extends GenericAutowireComposer {

	private static final long serialVersionUID = -5241849166856683804L;	
	
	private int _pageSize;
	private int _startPageNumber = 0;
	private int _totalSize = 0;
	private boolean _needsTotalSizeUpdate = true;
	private String grupo;
	
	private Paging userPaging;
	private Window win$Table0.objName$;
	private Window winFilter;
	private WndEdit$Table0.objName$Controller winEdit;
	private Listbox lbList$Table0.objName$s;
	
	private Toolbarbutton btnNuevo;
	
	$Columns0:{c|private Listheader lh$c.upName$; };separator="\n"$ 
	
	$Table0.objName$ListModel model = null;
	
	private HBSession session; 
	
	public void doAfterCompose(Component comp) throws Exception {
		super.doAfterCompose(comp);
		win$Table0.objName$ = (Window)comp;
		
		btnNuevo = (Toolbarbutton)win$Table0.objName$.getFellow("btnNuevo");
		btnNuevo.setVisible(
			Secure.hashPermission(	"APP_$Table0.permission$_CREATE", 
									"APP_$Table0.permission$_ALL", 
									"ROLE_ADMINISTRATOR")
		);
		
		_pageSize = GlobalVar.getVarInt(Constantes.CONST_PAGING);
		
		/*
		 * Config hibernate session
		 */
		/*session = new HBSession((Params)GlobalVar.getVar("$Table0.connName$"));
		session.addAnnotatedClass($Table0.objName$.class);
		$Columns0:{ c |$if(c.isFK)$session.addAnnotatedClass($c.fkObjTable$.class); 
		$endif$}$
		session.buildSession();
		GlobalVar.setVar(Constantes.CONST_HBSESSION, session);*/
		
		class $Table0.objName$Renderer implements ListitemRenderer {
            public void render(Listitem li, Object data) {
                String style = GlobalVar.getVarStr(Constantes.CONST_LIST_STYLE);
                
                if( data instanceof $Table0.objName$ )
            	{
	                $Table0.objName$ p = ($Table0.objName$)data;
                	$Columns0:{ c | new AListcell(p.get$c.upName$(), style, li);}; separator="\n"$
                
                	li.addForward("onClick", win$Table0.objName$, "onBtnOkClick", p);
                }else{
            		if( data instanceof Integer ){
            			Listcell lc;
            			$Columns0:{ c | lc = new Listcell(""); lc.setParent(li); }; separator="\n"$
	            		lc.setLabel("Total: " + data.toString());
            		}else{
            			Listcell lc = new Listcell(data.toString());
	            		lc.setParent(li);
            		}
            	}
            }
        }
        ListitemRenderer $Table0.objName$Renderer = new $Table0.objName$Renderer();		
		lbList$Table0.objName$s.setItemRenderer($Table0.objName$Renderer);
		
		refreshModel(_startPageNumber);
		
		$Columns0:{ c | 
lh$c.upName$.setSortAscending(new FieldComparator("$c.loName$", true)); 
lh$c.upName$.setSortDescending(new FieldComparator("$c.loName$", false));
		}; separator="\n"$
		
		Listhead listhead = lbList$Table0.objName$s.getListhead();
		List list = listhead.getChildren();
 
		for (Object object : list) {
			if (object instanceof Listheader) {
				Listheader lheader = (Listheader) object;
 
				if (lheader.getSortAscending() != null || lheader.getSortDescending() != null) {
					lheader.addEventListener("onSort", new OnSortEventListener());
				}
			}
		}
		
		winEdit = (WndEdit$Table0.objName$Controller)Executions.createComponents("apps/$AppName$/$Table0.objName$/wndEdit$Table0.objName$.zul", win$Table0.objName$, null);
        winEdit.init();
        winEdit.setMaximizable(true);
        winEdit.setVisible(false);
        
        Map<String, Object> map = new HashMap<String, Object>();		
        map.put(Constantes.CONST_FILTER_CAMP, $Table0.objName$.getNames());
        map.put(Constantes.CONST_FILTER_NAME, "$Table0.objName$Filter");
        map.put(Constantes.CONST_FILTER_APPN, "$Table0.objName$");
		winFilter = (Window)Executions.createComponents("common/wndFilter.zul", win$Table0.objName$, map);
		winFilter.setVisible(false);	
	} 
	
	public void onUserPaging(ForwardEvent event){
		final PagingEvent pe = (PagingEvent) event.getOrigin();
		_startPageNumber = pe.getActivePage();
		refreshModel(_startPageNumber);
	}
	
	private void refreshModel(int activePage){
		userPaging.setPageSize(_pageSize);		
		model = new $Table0.objName$ListModel(session, activePage, _pageSize);
		
		if(_needsTotalSizeUpdate) {
			_totalSize = model.getTotalSize();
			_needsTotalSizeUpdate = false;
		}
		
		userPaging.setTotalSize(_totalSize);
		if(this.grupo == null)
			lbList$Table0.objName$s.setModel((ListModel)model);
		else
			lbList$Table0.objName$s.setModel((GroupsModel)model);
	}	
	
	public void onBtnBuscarClick(Event event) throws SuspendNotAllowedException, InterruptedException{
		winFilter.doModal();
		
		_startPageNumber = 0;
		_needsTotalSizeUpdate = true;
		refreshModel(_startPageNumber);
	}
	
	public void onBtnOkClick(Event event) throws SuspendNotAllowedException, InterruptedException {        
        winEdit.set$Table0.objName$(($Table0.objName$)event.getData());
		winEdit.setVisible(true);
		winEdit.doModal();
    }
	
	public void onBtnNuevoClick(Event event) throws SuspendNotAllowedException, InterruptedException {        
        lbList$Table0.objName$s.setSelectedIndex(-1);
		winEdit.set$Table0.objName$(null);
		winEdit.setVisible(true);
		winEdit.doModal();
		
		refreshModel(_startPageNumber);
    }
	
	public void onBtnGroupByClick(Event event){
		this.grupo = (String)event.getData();
		GlobalVar.setVar("$Table0.objName$GroupBy", this.grupo);
		//System.out.println("GRUPO: " + this.grupo);
		refreshModel(_startPageNumber);
	}

	public final class OnSortEventListener implements EventListener {
		@Override
		public void onEvent(Event event) throws Exception {
			final Listheader lh = (Listheader) event.getTarget();
			final String sortDirection = lh.getSortDirection();
			String orderBy = "";
			
			if ("ascending".equals(sortDirection)) {
				final Comparator cmpr = lh.getSortDescending();
				if (cmpr instanceof FieldComparator) {
					orderBy = ((FieldComparator) cmpr).getOrderBy();
				}

				GlobalVar.setVar("$Table0.objName$OrderBy", orderBy);
			} else if ("descending".equals(sortDirection) || "natural".equals(sortDirection) || Strings.isBlank(sortDirection)) {
				final Comparator cmpr = lh.getSortAscending();
				if (cmpr instanceof FieldComparator) {
					orderBy = ((FieldComparator) cmpr).getOrderBy();
				}
				
				GlobalVar.setVar("$Table0.objName$OrderBy", orderBy);
			}
 
			refreshModel(_startPageNumber);
		}
	}
}