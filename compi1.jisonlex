
id                          [a-zA-Z]("_"|[a-zA-Z0-9])*

%%
\s+                  /* skip whitespace */
"/*"[^"*/"]*"*/"     console.log("COMENTARIO: "+yytext); 
\"[^\"]*\"           console.log("CADENA: "+ yytext); return "CADENA"
"'"[^"'"]"'"         console.log("CARACTER: "+ yytext); return "CARACTER"   
[0-9]+("."[0-9]+)?\b console.log("numero: " +yytext); return "NUMERO"
"+="                 console.log("Signo: " +yytext);  return "ASUM"
"*="                 console.log("Signo: " +yytext);  return "AMULTI"
"-="                 console.log("Signo: " +yytext);  return "AMENOS"
"/="                 console.log("Signo: " +yytext);  return "ADIVI"
"*"                  console.log("Signo: " +yytext); return "MULTI"
"/"                  console.log("Signo: " +yytext); return "DIVI"
"^"                  console.log("Signo: " +yytext); return "POT"
"++"                 console.log("Signo: " +yytext);  return "AUMEN"
"--"                 console.log("Signo: " +yytext);  return "DISM"
"->"                 console.log("Signo: " +yytext);  return "PPUNTE"
"-"                  console.log("Signo: " +yytext); return "MENOS"
"+"                  console.log("Signo: " +yytext); return "MAS"
"("                  console.log("Signo: " +yytext);  return "APAREN"
")"                  console.log("Signo: " +yytext);  return "CPAREN"
"["                  console.log("Signo: " +yytext);  return "ACORCH"
"]"                  console.log("Signo: " +yytext);  return "CCORCH"
"{"                  console.log("Signo: " +yytext);  return "ALLAVE"
"}"                  console.log("Signo: " +yytext);  return "CLLAVE"
">="                 console.log("Signo: " +yytext);  return "MAYIGL"
"<="                 console.log("Signo: " +yytext);  return "MENIGL"
">"                  console.log("Signo: " +yytext);  return "MAYOR"
"<"                  console.log("Signo: " +yytext);  return "MENOR"
"=="                 console.log("Signo: " +yytext);  return "IGL"
"!="                 console.log("Signo: " +yytext);  return "DIFE"
"="                  console.log("Signo: " +yytext);  return "ASIG"
"||"                 console.log("Signo: " +yytext);  return "OOR"
"&&"                 console.log("Signo: " +yytext);  return "OAND"
"??"                 console.log("Signo: " +yytext);  return "OXOR"
"!"                  console.log("Signo: " +yytext);  return "ONOT"
";"                  console.log("Signo: " +yytext);  return "PCOMA"
","                  console.log("Signo: " +yytext);  return "COMA"
"."                  console.log("Signo: " +yytext);  return "PUNTO"
":"                  console.log("Signo: " +yytext);  return "DPUNTO"
"entero"             console.log("palabra: " +yytext);  return "TENTE"
"decimal"            console.log("palabra: " +yytext);  return "TDECI"
"caracter"           console.log("palabra: " +yytext);  return "TCARAC"
"booleano"           console.log("palabra: " +yytext);  return "TBOOL"
"tamanio"            console.log("palabra: " +yytext);  return "TAMN"
"concatenar"         console.log("palabra: " +yytext);  return "CONCAT"
"convertirAcadena"   console.log("palabra: " +yytext);  return "CONVCAD"
"convertirAentero"   console.log("palabra: " +yytext);  return "CONVENT"
"imprimir"           console.log("palabra: " +yytext);  return "IMPR"
"clase"              console.log("palabra: " +yytext);  return "CLASS"
"este"               console.log("palabra: " +yytext);  return "ESTE"
"privado"            console.log("palabra: " +yytext);  return "PRIV"
"publico"            console.log("palabra: " +yytext);  return "PUBL"
"protegido"          console.log("palabra: " +yytext);  return "PROTE"
"importar"           console.log("palabra: " +yytext);  return "IMPOR"
"hereda_de"          console.log("palabra: " +yytext);  return "HERENC"
"vacio"              console.log("palabra: " +yytext);  return "VACIO"
"retornar"           console.log("palabra: " +yytext);  return "RETORNA"
"principal"          console.log("palabra: " +yytext);  return "PRINCIPAL"
"nuevo"              console.log("palabra: " +yytext);  return "NUEVO"
"nada"               console.log("palabra: " +yytext);  return "NADA"
"romper"             console.log("palabra: " +yytext);  return "ROMPE"
"continuar"          console.log("palabra: " +yytext);  return "CONTINUA"
"Estructura"         console.log("palabra: " +yytext);  return "ESTRUCTUR"
"crearPuntero"       console.log("palabra: " +yytext);  return "CREAP"
"obtenerDireccion"   console.log("palabra: " +yytext);  return "OBTDIR"
"reservarMemoria"    console.log("palabra: " +yytext);  return "RESERMEM"
"consultarTamanio"   console.log("palabra: " +yytext);  return "CONSULTAM"
"destruirPuntero"    console.log("palabra: " +yytext);  return "DESTPUNT"
"funcion"            console.log("palabra: " +yytext);  return "FUNSC"
"Lista"              console.log("palabra: " +yytext);  return "LISTT"
"insertar"           console.log("palabra: " +yytext);  return "INSRT"
"obtener"            console.log("palabra: " +yytext);  return "OBTNR"
"buscar"             console.log("palabra: " +yytext);  return "BSQR"
"Pila"               console.log("palabra: " +yytext);  return "PILA"
"Apilar"             console.log("palabra: " +yytext);  return "APILAR"
"Desapilar"          console.log("palabra: " +yytext);  return "DAPILAR"
"Encolar"            console.log("palabra: " +yytext);  return "ENCOLAR"
"Desencolar"         console.log("palabra: " +yytext);  return "DENCOLAR"
"Cola"               console.log("palabra: " +yytext);  return "COLA"
"Si"                 console.log("palabra: " +yytext);  return "CSI"
"Es_verdadero"       console.log("palabra: " +yytext);  return "EVERDAD"
"Es_falso"           console.log("palabra: " +yytext);  return "EFALSO"
"Fin-si"             console.log("palabra: " +yytext);  return "FSI"
"Evaluar_si"         console.log("palabra: " +yytext);  return "EVALUARS"
"Es_igual_a"         console.log("palabra: " +yytext);  return "ESIGLA"
"defecto"            console.log("palabra: " +yytext);  return "DFCT"
"Repetir_Mientras"   console.log("palabra: " +yytext);  return "REPMNT"
"hacer"              console.log("palabra: " +yytext);  return "HACER"
"mientras"           console.log("palabra: " +yytext);  return "MNTRAS"
"Ciclo_doble_condicion"   console.log("palabra: " +yytext);  return "CICLODC"
"Repetir"            console.log("palabra: " +yytext);  return "REPTIR"
"hasta_que"          console.log("palabra: " +yytext);  return "HASTAQ"
"Repetir_contando"   console.log("palabra: " +yytext);  return "REPCONT"
"variable"           console.log("palabra: " +yytext);  return "VARIBL"
"desde"              console.log("palabra: " +yytext);  return "DSD"
"hasta"              console.log("palabra: " +yytext);  return "HSTA"
"Enciclar"           console.log("palabra: " +yytext);  return "ENCICLAR"
"Contador"           console.log("palabra: " +yytext);  return "CONTADOR"
"Leer_Teclado"       console.log("palabra: " +yytext);  return "LEERT"
"@Sobrescribir"      console.log("palabra: " +yytext);  return "OVERWRIT"
{id}                 console.log("identificador: " +yytext); return "ID"
<<EOF>>              return "EOF"
.                    return "INVALID"

