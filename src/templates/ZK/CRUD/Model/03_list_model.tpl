package model.$AppName$.$Table0.objName$;

$comments$

import java.util.ArrayList;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;

import org.zkoss.zk.ui.Sessions;
import org.zkoss.zul.ListModelExt;
import org.zkoss.zul.event.GroupsDataListener;

import framework.common.Class.AbstractPagingListModel;
import framework.common.Class.FilterContainer;
import framework.common.Class.GlobalVar;
import framework.common.Class.HBSession;

public class $Table0.objName$ListModel extends AbstractPagingListModel<$Table0.objName$> implements ListModelExt {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private HashMap<Object, List<Object>> grupos;
	private List<Object> gruposIndex;
	private List<$Table0.objName$> list;
	private String cGrupo;
	private HBSession session;
	
	public $Table0.objName$ListModel(HBSession session, int startPageNumber, int pageSize) {
		super(startPageNumber, pageSize);
		this.session = session;
	}
	
	public $Table0.objName$ListModel(HBSession session, int startPageNumber, int pageSize, String grupo) {
		super(startPageNumber, pageSize);
		this.session = session;
		this.cGrupo = grupo;
	}
	
	@Override
	protected List<$Table0.objName$> getPageData(int itemStartNumber, int pageSize) {		
		try {
			$Table0.objName$DAO pd = new $Table0.objName$DAO();
			
			FilterContainer filterContainer = (FilterContainer)Sessions.getCurrent().getAttribute("$Table0.objName$Filter");		
			String order = GlobalVar.getVarStr("$Table0.objName$OrderBy");		
			String group = GlobalVar.getVarStr("$Table0.objName$GroupBy");
			
			list = pd.selectAllWithLimit(itemStartNumber, pageSize, filterContainer, order);
			this.cGrupo = group;
			//System.out.println("PAGING ($Table0.objName$): " + itemStartNumber + ", " + pageSize + " :" + this.cGrupo);
			
			if(this.cGrupo != null){
				this.cGrupo = this.cGrupo.trim();
				initGroups();				
			}
				
			return list;
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}		
		
		return null;
	}

	@Override
	public int getTotalSize() {
		int t = 0;
		
		try {
			$Table0.objName$DAO pd = new $Table0.objName$DAO();
			FilterContainer filterContainer = (FilterContainer)Sessions.getCurrent().getAttribute("$Table0.objName$Filter");	
			t = pd.getCount(filterContainer);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}		
		
		return t;
	}

	@SuppressWarnings("unchecked")
	@Override
	public void sort(Comparator cmpr, boolean ascending) {
		// TODO Auto-generated method stub
		
	}/*
	 * Codigo para grupos
	 * @see org.zkoss.zul.GroupsModel#addGroupsDataListener(org.zkoss.zul.event.GroupsDataListener)
	 */
	
	private void ClearGroups(){
		if( gruposIndex != null )
			gruposIndex.clear();
		
		if( grupos != null ){
			for(Object key: grupos.keySet()){
				grupos.get(key).clear();
			}
			
			grupos.clear();
		}
	}
	
	private void initGroups(){
		ClearGroups(); // Limpiar grupos		

		Object ob = null;
		this.grupos = new HashMap<Object, List<Object>>();
		this.gruposIndex = new ArrayList<Object>();
		
		for($Table0.objName$ bt : this.list){
			//System.out.println("Paso GRUPO: " + this.cGrupo );
			
		$Columns0:{ c |	if( this.cGrupo.contentEquals("$c.name$") ){
				ob = bt.get$c.upName$();
				//System.out.println("Paso Tipo: " + this.cGrupo);
			}}; separator="else "$
			
			// -------------------------------------------
			if( ob == null )
				ob = "[NULL]";
			//System.out.println("Paso: " + ob.toString() + ", " + bt.toString());
			
			if( !this.grupos.containsKey(ob) ){
				this.grupos.put(ob, new ArrayList<Object>());
				this.gruposIndex.add(ob);
			}
			
			this.grupos.get(ob).add(bt);
		}
	}
	
	@Override
	public void addGroupsDataListener(GroupsDataListener l) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public Object getChild(int groupIndex, int index) {
		// TODO Auto-generated method stub
		return this.grupos.get(this.gruposIndex.get(groupIndex)).get(index);
	}

	@Override
	public int getChildCount(int groupIndex) {
		// TODO Auto-generated method stub
		return this.grupos.get(this.gruposIndex.get(groupIndex)).size();
	}

	@Override
	public Object getGroup(int groupIndex) {
		// TODO Auto-generated method stub
		return this.gruposIndex.get(groupIndex);
	}

	@Override
	public int getGroupCount() {
		// TODO Auto-generated method stub
		if(this.gruposIndex != null)
			return this.gruposIndex.size();
		return 0;
	}

	@Override
	public Object getGroupfoot(int groupIndex) {
		// TODO Auto-generated method stub
		return new Integer(this.grupos.get(this.gruposIndex.get(groupIndex)).size());
	}

	@Override
	public boolean hasGroupfoot(int groupIndex) {
		// TODO Auto-generated method stub
		return true;
	}

	@Override
	public void removeGroupsDataListener(GroupsDataListener l) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void group(Comparator cmpr, boolean ascending, int colIndex) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void sort(Comparator cmpr, boolean ascending, int colIndex) {
		// TODO Auto-generated method stub
		
	}
}