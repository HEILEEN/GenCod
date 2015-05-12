package com.confianza.webapp.repository.$AppName$.$Table0.loObjName$;

$comments$

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.TableGenerator;

$if(Table0.nPk)$import javax.persistence.IdClass;$endif$

@Entity
@Table(name = "$Table0.tableName$")
$if(Table0.nPk)$
@IdClass($Table0.objName$Pk.class) 
$endif$

public class $Table0.objName$ {
	$Columns0:{ c | $if(!Table0.nPk)$$if(c.Pk)$@Id 
// Habilite este codigo para generar automaticamente la llave primaria esta depende de una tabla
@TableGenerator(name = "$Table0.tableName$_GEN", //<= nombre de la tabla con el cual se va a identificar la llave
                 table = "FRM_PKID",              //<= Este string define la tabla dond se almacenan el consecutivo
                 pkColumnName="PKIDNOMB",         //<= NOMBRE DE LA LLAVE PRIMARIA DE LA TABLA    
                 valueColumnName="PKIDVALU",      //<= Valor del consecutivo en el que va la llave primaria
                 pkColumnValue="$Table0.tableName$_PK", 
                 initialValue = 1,                //<= Valor inicial de la llave primario
                 allocationSize = 1)              //<= Valor a buscar por medio de la llave primaria
@GeneratedValue(strategy = GenerationType.TABLE, generator = "$Table0.tableName$_GEN") $endif$$endif$ 
@Column(name = "$c.name$")
protected $c.type.ormType$ $c.loName$; }; separator="\n"$

	public $Table0.objName$(){
	
	}
$Columns0:{ c |
	$if(Table0.nPk)$$if(c.Pk)$@Id $endif$$endif$	public $c.type.ormType$ get$c.upName$(){
		return $c.loName$;
	}
	
	public void set$c.upName$($c.type.ormType$ $c.loName$){
		this.$c.loName$ = $c.loName$;
	}};separator="\n"$


	static public String[] getNames(){
		return new String[]{ $Columns0:{c|"$c.loName$"}; separator=", "$ };
	}		
	
	static public String getColumnNames(){
		return " $Columns0:{ c| $c.name$}; separator=", "$ ";
	}
	
	public String toString(){
		return $Columns0:{ c | " $c.name$: "+ this.$c.loName$ }; separator="\n\t\t\t+"$;
	}
}