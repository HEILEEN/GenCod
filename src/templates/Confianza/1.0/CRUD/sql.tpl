DECLARE 
   Consecutivomodulo Number;
   Consecutivomodulorope Number;
   Consecutivoi18n Number;
   ConsecutivoAplicacion Number;
   
    --obtener el codigo que se usara en una tabla, inmediatamente se incrementa en 1 para el siguiente uso
    Function getPk(sbPkId in varchar2) return number is
            NUPKID number;
    BEGIN
            UPDATE FRM_PKID SET PKIDVALU = PKIDVALU WHERE PKIDNOMB = sbpkid;                        
            SELECT PKIDVALU INTO NUPKID FROM FRM_PKID WHERE PKIDNOMB = sbpkid;
            UPDATE FRM_PKID SET PKIDVALU = PKIDVALU + 1 WHERE PKIDNOMB = sbpkid;            
            RETURN NUPKID;
    END; 
  
Begin

	--Cambie el codigo de la aplicacion 
	ConsecutivoAplicacion := 1;
	
    --this part insert the modulo
    Consecutivomodulo := getPk('FRM_MODULO_PK');
    Insert Into Frm_Modulo (Moducons, Moduapli, Modunomb, Modunemo, Modudurl)Values (Consecutivomodulo, ConsecutivoAplicacion, '$Table0.tableName$', '$Table0.objName$', '$Table0.objName$');	
    
    --This part insert into modurope the roles that can execute the accion or service
    Consecutivomodulorope := getPk('FRM_MODUROPE_PK');--ALL                       
    Insert Into Frm_Modurope (Morocons, Moromodu, Mororope)Values (Consecutivomodulorope, Consecutivomodulo, 1);	                       
    Consecutivomodulorope := getPk('FRM_MODUROPE_PK');--CREATE                       
    Insert Into Frm_Modurope (Morocons, Moromodu, Mororope)Values (Consecutivomodulorope, Consecutivomodulo, 2);	                                                
    Consecutivomodulorope := getPk('FRM_MODUROPE_PK'); --DELETE                      
    Insert Into Frm_Modurope (Morocons, Moromodu, Mororope)Values (Consecutivomodulorope, Consecutivomodulo, 3); 
    Consecutivomodulorope := getPk('FRM_MODUROPE_PK');--READ                       
    Insert Into Frm_Modurope (Morocons, Moromodu, Mororope)Values (Consecutivomodulorope, Consecutivomodulo, 4);                              
    Consecutivomodulorope := getPk('FRM_MODUROPE_PK');--UPDATE                       
    Insert Into Frm_Modurope (Morocons, Moromodu, Mororope)Values (Consecutivomodulorope, Consecutivomodulo, 6);   
                             
    --this part insert the i18n for the forms in the front end
    Consecutivomodulorope := getPk('FRM_I18N_PK');
    Insert Into FRM_I18N (ETINCONS,ETINMODU,ETINCAMP,ETINETIQ) VALUES (Consecutivomodulorope,Consecutivomodulo,'-','$Object0$');
    $Columns0:{c|Consecutivomodulorope := getPk('FRM_I18N_PK'); INSERT INTO FRM_I18N (ETINCONS, ETINMODU, ETINCAMP, ETINETIQ)VALUES(Consecutivomodulorope, Consecutivomodulo, '$c.loName$', 'i18n_$c.loName$'); }; separator="\n"$
END;
/