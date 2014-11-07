package $package_name.$object_name;

public class $object_name{
	
#foreach( $property in $object_atributes_name_l )
	#set( $count = $velocityCount - 1 )
    $object_atributes_type.get($count) $property;
#end

	public $object_name(){
	}

	public $object_name($object_atributes_name_l,object_atributes_type:{ n,t | $t$ $n$ }; separator=","$){
		$object_atributes_name_u,object_atributes_name_l:{ u,n | set$u$($n$); }; separator="\n"$
	}
	
$object_atributes_name_u,object_atributes_name_l,object_atributes_type:{ u,n,t |
	public void set$u$($t$ $n$){
		this.$n$ = $n$;
	} 
	
	public $t$ get$u$(){
		return this.$n$;
	}}; separator="\n"$
}