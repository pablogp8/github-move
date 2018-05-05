%{
    function prependChild(node, child){
      node.splice(2,0,child); 
      return node;
    }
%}

/* operator associations and precedence */

%left MAS MENOS
%left MULTI DIVI
%left POT 
%left IGL DIFE
%left MENOR MAYOR
%left MENIGL MAYIGL
$left ONOT
%left OAND OOR OXOR


%% /* language grammar */

expressions
    : lisexp EOF{typeof console !== 'undefined' ? console.log(JSON.stringify($1)) : print($1);
        return $1;}
    ;
    

lisexp
    : lisexp expressions2
        {$$ = prependChild($1, $2);}
    |expressions2
        {{ $$=['expresion',{},$1];}}
    ;


 expressions2
    :declara { $$=$1; }
    |declara2{$$=$1} 
    |funci PCOMA { $$= $1; }
    |classes { $$= $1; }  
    |estrut { $$= $1; }
    |puntcre { $$= $1; }
    |destrupunt { $$= $1; }
    |strdat { $$= $1; }
    |sentscontr { $$= $1; }   
    ;

  /***************************-****************************/    
 /*****************Listado de expresiones*******************/
  /********************************************************/

e
    : e MAS e {{$$ = ['SUMA',{},$1,$3];}}   
    | e MENOS e {{$$ = ['RES',{},$1,$3];}}
    | e MULTI e {{$$ = ['MULTIP',{},$1,$3];}}
    | e DIVI e {{$$ = ['DIVI',{},$1,$3];}}
    | e MAYIGL e {{$$ = ['MAYIGL',{},$1,$3];}}
    | e MENIGL e {{$$ = ['MENIGL',{},$1,$3];}}
    | e MAYOR e {{$$ = ['MAYOR',{},$1,$3];}}
    | e MENOR e {{$$ = ['MENOR',{},$1,$3];}}
    | e IGL e {{$$ = ['IGL',{},$1,$3];}}
    | e DIFE e {{$$ = ['DIFE',{},$1,$3];}}
    | e OOR e {{$$ = ['OOR',{},$1,$3];}}
    | e OAND e {{$$ = ['OAND',{},$1,$3];}}
    | e OXOR e {{$$ = ['OXOR',{},$1,$3];}}
    | ONOT e {{$$ = ['ONOT',{},$2];}}
    | APAREN e CPAREN {$$ = $2;}
    | NUMERO {$$ = Number(yytext);}
    | expc {$$=$1;}
    ;

  /***************************-****************************/    
 /**********Declaracion de Variables y arreglos*************/
  /********************************************************/

declara
    :tipodat declara2 {{$$ = ['Declaracion',{},$1,$2];}}
    ;

declara2
    :ID declara1 {{
                    if(Array.isArray($2)){
                        if($2[0]==='Declaracion'){
                            $$=['Declaracion',{},$1,['Identifica',{},$2[1],$2[2]]];
                        }else if($2[0]==='Asigna'){
                             $$ = ['Identifica',{},$1,$2];
                        }else if($2[0]=='DEFARREGLO'){
                            $$=['Identifica',{},$1,$2];
                        }else{
                            $$=prependChild($2,$1);
                        }
                    }else{
                        $$ = ['Identifica',{},$1,$2];
                    }
                }}
    ;

constructo
    :constructo2 CPAREN constructo1 {$$=prependChild($1,$3)}
    ;

constructo2
    : listparam1{{$$=['DECLARAFUN',{},$1];}}
    |listallam2{$$=$1}
    |{$$=['VACIO',{},{}];}
    ;
constructo1
    : PCOMA{$$='1'}
    | ALLAVE bodyfun CLLAVE {$$=$2}
    ;

tipodat
    :TENTE{$$=yytext;}
    |TDECI{$$=yytext;}
    |TCARAC{$$=yytext;}
    |TBOOL{$$=yytext;}
    |VACIO{$$=yytext;}
    ;
/****************cambio*/
declara1
    :asignapr1 PCOMA {{$$=['Asigna',{},$1];}}
    |ID declara3 {{$$=['Declaracion',$1,$2];}}
    |APAREN constructo{$$=$2}
    |PCOMA {$$="1";}
    |estrpun expc2 asigna PCOMA
    |defarre asignapr2 PCOMA{{$$=['DEFARREGLO',{},$1,$2];}}
    ;

estrpun
    :PUNTO{$$='PUNTO'}
    |PPUNTE{$$='ASIPUNT'}
    ;    

declara3
    :funciones{$$=$1}
    |asignapr1 PCOMA {{$$=['Asigna',{},$1];}}
    | PCOMA {$$='1';}
    |defarre asignapr2 PCOMA{{$$=['DEFARREGLO',{},$1,$2];}}
    ;    
/**********************/
asigna
    :ASIG e {$$=$2;}
    |{$$='1';}
    ;

defarre
    :defarre ACORCH e CCORCH{$$=prependChild($1,$3);}
    |ACORCH e CCORCH{{$$=['ARREGLO',{},$2];}}
    ;

  /***************************-****************************/    
 /*********************crear punteros***********************/
  /********************************************************/

puntcre
    : CREAP APAREN puntcre2 COMA ID CPAREN asigna PCOMA {{$$=['CREAPUN',$3,$5,$7];}}
    ;

puntcre2
    :tipodat{$$=$1;}
    |ID{$$=yytext;}
    ;

destrupunt
    :DESTPUNT APAREN ID CPAREN PCOMA {{$$=['DESTRPUN',$3];}}
    ;

  /***************************-****************************/    
 /***********Asignacion de Variables y arreglos*************/
  /********************************************************/

/*de aca la saque l******/
asignapr1
    :ASIG asignapr3 {{$$ = ['VALOR',{},$2];}}
    |aop {$$=$1}    
    |aumdism {$$=$1}
    ;

asignapr3
    :e {$$=$1}
    |NUEVO e {{$$=['NUEVO',$2];}}
    | nadda{$$=$1}
    ;

asignapr2
    :ASIG asignapr3 {{$$ = ['VALOR',{},$2];}}
    |{$$='1';}
    ;

aumdism
    :AUMEN {$$='INCREMENTA';}
    |DISM  {$$='DECREMENTA';}
    ;

aop
    : ASUM NUMERO {{$$=['SUMCORTA',{},$2];}}
    | AMULTI NUMERO {{$$=['MULTCORTA',{},$2];}}
    | AMENOS NUMERO {{$$=['RESCORTA',{},$2];}}
    | ADIVI NUMERO {{$$=['DIVICORTA',{},$2];}}
    ;

  /***************************-****************************/    
 /*********POSIBILIDADES simples de variables|vec|**********/
  /********************************************************/

expc
    :ID expc1 {$$=yytext; }
    | CADENA {var tt=yytext.replace("\"","");$$=tt.replace("\"","");}
    | CARACTER {var tt=yytext.replace("'","");$$=tt.replace("'","");}
    |classes1{$$=$1}
    |funci{$$=$1}
    ;

expc1
    :PUNTO expc2 {{$$=['METODO',{},$2];}}
    |APAREN listallam CPAREN {{$$=['FUNCION',{},$2];}}
    |{$$="";}
    ;
/*cambio de ID por e*/

expc2
    : TAMN {{$$=['TAMANIO',{}];}}
    |ID expc1 {{$$=['METODO',{},$1,$2];}}
    |INSRT APAREN e CPAREN {{$$=['INSERTAR',{},$3];}}
    |OBTNR APAREN NUMERO CPAREN {{$$=['OBTENER',{},$3];}}
    |BSQR APAREN e CPAREN {{$$=['BUSCAR',{},$3];}}
    |APILAR APAREN e CPAREN {{$$=['APILAR',{},$3];}}
    |DAPILAR APAREN CPAREN {{$$=['DESAPILAR',{}];}}
    |ENCOLAR APAREN e CPAREN {{$$=['ENCOLAR',{},$3];}}
    |DENCOLAR APAREN CPAREN {{$$=['DESENCOLAR',{}];}}
    ;

  /***************************-****************************/    
 /****************FUNCIONES PERSONALIZADAS******************/
  /********************************************************/

/*cambios de funci2 por e en linea 1 y 4*/
funci
    :CONCAT APAREN ID COMA funci2 cncat CPAREN {{$$=['CONCATENA',{},$3,$5,$6];}}
    |CONVCAD APAREN e CPAREN {{$$=['CONVCADENA',{},$3];}}
    |CONVENT APAREN e CPAREN {{$$=['CONVENTERO',{},$3];}}
    |IMPR APAREN funci2 CPAREN {{$$=['IMPRIMIR',{},$3];}}
    |OBTDIR APAREN ID CPAREN {{$$=['OBTENERDIR',{},$3];}}
    |RESERMEM APAREN e CPAREN {{$$=['RESMEMORIA',{},$3];}}
    |CONSULTAM APAREN ID CPAREN  {{$$=['CONSULTAM',{},$3];}}
    ;

funci2 
    : e{$$=$1;}
    ;

cncat
    : COMA e {$$=$1;}
    |{$$='1';}
    ;

  /***************************-****************************/    
 /*******************Clases y Funciones*********************/
  /********************************************************/

importacion
    : importacion IMPOR APAREN CADENA CPAREN PCOMA {var tt=$4.replace("\"",""); $$=prependChild($1,tt.replace("\"",""));}
    | {{$$=['IMPORTA',{},'1'];}}
    ;

classes
    : importacion classes2 {{$$=['CLASE',$1,$2[1],$2[2],$2[3]];}}
    ;

classes2
    :CLASS ID hern ALLAVE bodclas CLLAVE {{$$=['DECLASE',$2,$3,$5];}} 
    |PRINCIPAL APAREN CPAREN ALLAVE bodclas CLLAVE{{$$=['MAIN',$5];}}
    ;

hern:HERENC ID{$$=$2;}
    | {$$='1';}
    ;

bodclas
    : bodclas visible declara {{$3.splice(1,1,$2);$$=prependChild($1,$3);}}
    | bodclas declara2{{$$=prependChild($1,$2);}}
    | bodclas OVERWRIT visible declara
    | bodclas funci PCOMA {{$$=prependChild($1,$2);}}
    | bodclas estrut {{$$=prependChild($1,$2);}}
    | bodclas puntcre {{$$=prependChild($1,$2);}}
    | bodclas destrupunt {{$$=prependChild($1,$2);}}
    | bodclas strdat {{$$=prependChild($1,$2);}}
    | bodclas sentscontr {{$$=prependChild($1,$2);}}
    | {{$$=['CUERPOCLASS',{}];}}
    ;

listallam: listallam2{$$=$1;}
    |{$$='1';}
    ;

listallam2
    : listallam2 COMA posid2 listallameste posid{{
                                if($3==='1'){
                                    if($5==='1'){
                                        $$=prependChild($1,$4);
                                    }else{
                                        var tem=[$4,$5];
                                        $$=prependChild($1,tem);
                                    }
                                }else{
                                    var tem=[$3,$4];
                                    $$=prependChild($1,tem);
                                }
                            }}
    | listallameste posid {{if($2==='1'){
                           $$=['Parametros',{},$1]; 
                        }else{
                            $$=['Parametros',{},[$1,$2]];
                        }
                    }}
    ;

listallameste
    :e {$$=$1;}
    ;

posid
    :ID {$$=$1;}
    |{$$='1';}
    ;

posid2
    :tipodat{$$=$1;}
    |{$$='1';}
    ;


classes1
    : ESTE PUNTO ID {{$$=['ESTE',{},$3]}}
    ;

visible
    :PUBL
    |PRIV
    |PROTE
    |{$$='Publico';}
    ;

  /***************************-****************************/    
 /*********************Clase principal**********************/
  /********************************************************/


  /***************************-****************************/    
 /************************Funciones*************************/
  /********************************************************/
funciones
    : APAREN listparam CPAREN ALLAVE bodyfun CLLAVE{{$$=['FUNCION',$2,$5];}}
    ;

listparam
    :listparam1{$$=$1;}
    |{$$='1';}
    ;

/*CAMBIO DE tipodat por tipfun*/
listparam1
    : listparam1 COMA tipfun ID listparam3{{
                        var tem=[$3,['Identifica',{},$4,$5]];
                        $$=prependChild($1,tem);
                        }}
    |tipfun ID listparam3 {{
                    var tem=['Identifica',{},$2,$3];
                    $$=['Parametros',{},[$1,tem]];}}
    ;

tipfun
    :tipodat{$$=$1;}
    |FUNSC{$$=$1;}
    ;

listparam3
    :ACORCH e CCORCH {$$=['ARREGLO',{},$2];}
    |{$$='1';}
    ;

bodyfun
    : bodyfun ESTE PUNTO ID asignapr12 PCOMA{{var tem=['ESTE',$4,$5];$$=prependChild($1,tem);}}
    | bodyfun ID asignapr12 PCOMA{{var tem=['Asigna',{},$2,$3];$$=prependChild($1,tem);}}
    | bodyfun funci PCOMA {{$$=prependChild($1,$2);}}
    | bodyfun RETORNA e PCOMA {{var tem=['RETORNA',$3];$$=prependChild($1,tem);}}
    | {{$$=['CUERPOFUN',{}];}}
    ; 
asignapr12
    :asignapr1{$$=$1}
    |defarre asignapr2 {{$$=['DEFARREGLO',{},$1,$2];}}
    ;

nadda
    :NADA {$$='NADA'}
    |ALLAVE nadda2 CLLAVE{{$$=['VALARREGLO',{},$2];}}
    ;

nadda2
    :nadda2 COMA nadda2op {$$=prependChild($1,$2);}
    |e{{$$=['VALOR',{},$1];}}
    |ALLAVE nadda2 CLLAVE {{$$=['VALARREGLO',{},$2];}}
    ;

nadda2op
    :ALLAVE nadda2 CLLAVE {{$$=['VALARREGLO',{},$2];}}
    |e{$$=$1}
    ;

  /***************************-****************************/    
 /************************ESTRUCTURA************************/
  /********************************************************/    

estrut
    :ESTRUCTUR ID ACORCH bodestrut CCORCH PCOMA{{$$=['ESTRUCTURA',$2,$4];}}
    ;

bodestrut
    :declara {{$$=['CUERPOESTR',{},$1];}}
    |declara2 {{$$=['CUERPOESTR',{},$1];}}
    |bodestrut declara {{$$=prependChild($1,$2);}}
    |bodestrut declara2 {{$$=prependChild($1,$2);}}
    ;

  /***************************-****************************/    
 /******************ESTRUCTURAS DE DATOS********************/
  /********************************************************/ 

strdat
    :LISTT ID ASIG NUEVO LISTT APAREN puntcre2 CPAREN PCOMA {{$$=['LISTA',$2,$7];}}
    |PILA ID ASIG NUEVO PILA APAREN puntcre2 CPAREN PCOMA {{$$=['PILA',$2,$7];}}
    |COLA ID ASIG NUEVO COLA APAREN puntcre2 CPAREN PCOMA {{$$=['COLA',$2,$7];}}
    ;


  /***************************-****************************/    
 /******************SENTENCIAS DE CONTROL*******************/
  /********************************************************/ 

sentscontr
    :CSI APAREN e CPAREN sentifV sentiff FSI {{$$=['SI',$3,$5,$6];}}
    |EVALUARS APAREN e CPAREN ALLAVE bodeval defeval CLLAVE {{$$=['EVALUARSI',$3,$6,$7];}}
    |REPMNT APAREN e CPAREN ALLAVE CLLAVE {{$$=['REPETIRMNT',$3,$6];}}
    |HACER ALLAVE CLLAVE MNTRAS APAREN e CPAREN PCOMA {{$$=['HACER',$7,$3];}}
    |CICLODC APAREN e COMA e CPAREN ALLAVE CLLAVE {{$$=['CICLODC',$3,$5,$8];}}
    |REPTIR ALLAVE CLLAVE HASTAQ APAREN e CPAREN PCOMA {{$$=['REPETIR',$7,$3];}}
    |REPCONT APAREN bodrepcon CPAREN ALLAVE CLLAVE {{$$=['REPCONT',$3,$6];}}
    |ENCICLAR ID ALLAVE CLLAVE {{$$=['ENCILCAR',$2,$4];}}
    |CONTADOR APAREN e CPAREN ALLAVE CLLAVE {{$$=['CONTADOR',$3,$6];}}
    |LEERT APAREN e COMA ID CPAREN PCOMA {{$$=['LEERT',$3,$5];}}
    ;

sentifV
    :EVERDAD ALLAVE CLLAVE {$$=$3;}
    ;

sentiff
    :EFALSO ALLAVE CLLAVE {$$=$3;}
    |{$$='1';}
    ;

bodeval
    : ESIGLA e DPUNTO {{$$=['EVALUAR',{},[$2,'Cuerpo']];}}
    |bodeval ESIGLA e DPUNTO {{var tem=[$3,'Cuerpo']; $$=prependChild($1,tem);}}
    ;

defeval
    :DFCT DPUNTO {{$$=['PORDEF','Cuerpo'];}}
    ;

bodrepcon
    :VARIBL DPUNTO ID PCOMA DSD DPUNTO e PCOMA HSTA DPUNTO e {{$$=[$3,$7,$11];}}
    ;
