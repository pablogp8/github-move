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
                        }
                    }else{
                        $$ = ['Identifica',{},$1,$2];
                    }
                }}
    ;

constructo
    :constructo2 CPAREN constructo1
    ;

constructo2
    : listparam1
    |listallam2
    |
    ;
constructo1
    : PCOMA
    | ALLAVE bodyfun CLLAVE
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
    |APAREN constructo
    |PCOMA {$$="1";}
    |estrpun expc2 asigna PCOMA
    ;

estrpun
    :PUNTO
    |PPUNTE
    ;    

declara3
    :funciones
    |asignapr1 PCOMA {{$$=['Asigna',{},$1];}}
    | PCOMA {$$="1";}
    ;    
/**********************/
asigna
    :ASIG e {$$=$2;}
    |{$$={};}
    ;

defarre
    :defarre ACORCH e CCORCH
    |ACORCH e CCORCH
    ;

  /***************************-****************************/    
 /*********************crear punteros***********************/
  /********************************************************/

puntcre
    : CREAP APAREN puntcre2 COMA ID CPAREN asigna PCOMA
    ;

puntcre2
    :tipodat
    |ID
    ;

destrupunt
    :DESTPUNT APAREN ID CPAREN PCOMA
    ;

  /***************************-****************************/    
 /***********Asignacion de Variables y arreglos*************/
  /********************************************************/


asignapr1
    :ASIG asignapr3 {{$$ = ['VALOR',{},$2];}}
    |aop
    |defarre asignapr2
    |aumdism
    ;

asignapr3
    :e {$$=$1}
    |NUEVO e
    | nadda
    ;

asignapr2
    :ASIG asignapr3
    |
    ;

aumdism
    :AUMEN
    |DISM
    ;

aop
    : ASUM NUMERO 
    | AMULTI NUMERO 
    | AMENOS NUMERO 
    | ADIVI NUMERO 
    ;

  /***************************-****************************/    
 /*********POSIBILIDADES simples de variables|vec|**********/
  /********************************************************/

expc
    :ID expc1 {$$=yytext; }
    | CADENA {var tt=yytext.replace("\"","");$$=tt.replace("\"","");}
    | CARACTER {var tt=yytext.replace("'","");$$=tt.replace("'","");}
    |classes1
    |funci
    ;

expc1
    :PUNTO expc2
    |APAREN listallam CPAREN
    |{$$="";}
    ;
/*cambio de ID por e*/

expc2
    : TAMN
    |ID expc1
    |INSRT APAREN e CPAREN
    |OBTNR APAREN NUMERO CPAREN
    |BSQR APAREN e CPAREN
    |APILAR APAREN e CPAREN
    |DAPILAR APAREN CPAREN
    |ENCOLAR APAREN e CPAREN
    |DENCOLAR APAREN CPAREN
    ;

  /***************************-****************************/    
 /****************FUNCIONES PERSONALIZADAS******************/
  /********************************************************/

/*cambios de funci2 por e en linea 1 y 4*/
funci
    :CONCAT APAREN ID COMA funci2 cncat CPAREN 
    |CONVCAD APAREN e CPAREN 
    |CONVENT APAREN e CPAREN
    |IMPR APAREN funci2 CPAREN
    |OBTDIR APAREN ID CPAREN
    |RESERMEM APAREN e CPAREN
    |CONSULTAM APAREN ID CPAREN 
    ;

funci2 
    : e
    ;

cncat
    : COMA e
    |
    ;

  /***************************-****************************/    
 /*******************Clases y Funciones*********************/
  /********************************************************/

importacion
    : importacion IMPOR APAREN CADENA CPAREN PCOMA
    | 
    ;

classes
    : importacion classes2
    ;

classes2
    :CLASS ID hern ALLAVE bodclas CLLAVE
    |PRINCIPAL APAREN CPAREN ALLAVE bodclas CLLAVE
    ;

hern:HERENC ID
    |
    ;

bodclas
    : bodclas visible declara
    | bodclas declara2
    | bodclas OVERWRIT visible declara
    | bodclas funci PCOMA
    | bodclas estrut
    | bodclas puntcre
    | bodclas destrupunt
    | bodclas strdat
    | bodclas sentscontr
    |
    ;

listallam: listallam2
    |
    ;

listallam2
    : listallam2 COMA posid2 listallameste posid
    | listallameste posid
    ;
listallameste
    :e
    ;

posid
    :ID 
    |
    ;

posid2
    :tipodat
    |
    ;


classes1
    : ESTE PUNTO ID 
    ;

visible
    :PUBL
    |PRIV
    |PROTE
    |
    ;

  /***************************-****************************/    
 /*********************Clase principal**********************/
  /********************************************************/


  /***************************-****************************/    
 /************************Funciones*************************/
  /********************************************************/
funciones
    : APAREN listparam CPAREN ALLAVE bodyfun CLLAVE
    ;

listparam
    :listparam1
    |
    ;
/*CAMBIO DE tipodat por tipfun*/
listparam1
    : listparam1 COMA tipfun ID listparam3
    |tipfun ID listparam3
    ;

tipfun
    :tipodat
    |FUNSC
    ;

listparam3
    :ACORCH e CCORCH
    |
    ;

bodyfun
    : bodyfun ESTE PUNTO ID asignapr1 PCOMA
    | bodyfun ID asignapr1 PCOMA
    | bodyfun funci PCOMA
    | bodyfun RETORNA e PCOMA
    |
    ; 

nadda
    :NADA
    |ALLAVE nadda2 CLLAVE
    ;

/*nadda2*/
    /*: CADENA*/
    /*|CARACTER*/
    /*;*/

nadda2
    :nadda2 COMA nadda2op
    |e
    |ALLAVE nadda2 CLLAVE
    ;

nadda2op
    :ALLAVE nadda2 CLLAVE
    |e
    ;

  /***************************-****************************/    
 /************************ESTRUCTURA************************/
  /********************************************************/    

estrut
    :ESTRUCTUR ID ACORCH bodestrut CCORCH PCOMA
    ;

bodestrut
    :declara
    |declara2
    | bodestrut declara
    |bodestrut declara2
    ;

  /***************************-****************************/    
 /******************ESTRUCTURAS DE DATOS********************/
  /********************************************************/ 

strdat
    :LISTT ID ASIG NUEVO LISTT APAREN puntcre2 CPAREN PCOMA
    |PILA ID ASIG NUEVO PILA APAREN puntcre2 CPAREN PCOMA
    |COLA ID ASIG NUEVO COLA APAREN puntcre2 CPAREN PCOMA
    ;


  /***************************-****************************/    
 /******************SENTENCIAS DE CONTROL*******************/
  /********************************************************/ 

sentscontr
    :CSI APAREN e CPAREN sentifV sentiff FSI
    |EVALUARS APAREN e CPAREN ALLAVE bodeval defeval CLLAVE
    |REPMNT APAREN e CPAREN ALLAVE CLLAVE
    |HACER ALLAVE CLLAVE MNTRAS APAREN e CPAREN PCOMA
    |CICLODC APAREN e COMA e CPAREN ALLAVE CLLAVE
    |REPTIR ALLAVE CLLAVE HASTAQ APAREN e CPAREN PCOMA
    |REPCONT APAREN bodrepcon CPAREN ALLAVE CLLAVE
    |ENCICLAR ID ALLAVE CLLAVE
    |CONTADOR APAREN e CPAREN ALLAVE CLLAVE
    |LEERT APAREN e COMA ID CPAREN PCOMA
    ;

sentifV
    :EVERDAD ALLAVE CLLAVE
    ;

sentiff
    :EFALSO ALLAVE CLLAVE
    |
    ;

bodeval
    : ESIGLA e DPUNTO 
    |bodeval ESIGLA e DPUNTO
    ;

defeval
    :DFCT DPUNTO 
    ;

bodrepcon
    :VARIBL DPUNTO ID PCOMA DSD DPUNTO e PCOMA HSTA DPUNTO e
    ;
