$if(Table0.nPk)$
package model.$AppName$.$Table0.loObjName$;

$comments$

import java.util.Date;
import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Embeddable;

@Embeddable
public class $Table0.objName$Pk implements Serializable{
	$ColumnsPk0:{ c | 
@Column(name = "$c.name$")
private $c.type.ormType$ $c.loName$; }; separator="\n"$

	public $Table0.objName$Pk(){
	
	}
	
	public $Table0.objName$Pk($ColumnsPk0:{ c |$c.type.ormType$ $c.loName$};separator=", "$){
		$ColumnsPk0:{ c |this.$c.loName$ = $c.loName$;};separator=" \n"$
	}

$ColumnsPk0:{ c |
	public $c.type.ormType$ get$c.upName$(){
		return $c.loName$;
	}
	
	public void set$c.upName$($c.type.ormType$ $c.loName$){
		this.$c.loName$ = $c.loName$;
	}};separator="\n"$
}
$else$
//Por favor elimine este archivo
$endif$