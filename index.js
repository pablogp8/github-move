const express =require('express');
const app=express();

////modelo para el compilador
const parser=require('./compi1');

const fs= require('fs');

function exec (input){
    return parser.parse(input);
}

////funcion de recorrido de arrays
function recorrido(arreglo){
    arreglo.forEach(function(element,indice) {
        
        if(Array.isArray(element)){
            console.log("--**********--");
            recorrido(element);
            console.log("**********");
        }else{
            console.log(indice+" "+element+" "+Array.isArray(element));
        }
    }, this);
}

let data=fs.readFileSync("./Entradas/entrada2.gcc",'utf-8');
//console.log(data);

var tewnty=exec(data);
//console.log(JSON.stringify(tewnty,undefined,1));

/*
var prueba1=['Prueb',['otro',78,['mas']],32];
/////////////////fin forma compilador

/*
prueba1.splice(0,1,"Hello");
console.log(prueba1);
console.log(prueba1.length);
*/

//recorrido(tewnty);
//console.log(tewnty[0]);
let personas=[
    {
        id:1,
        nombre:"Pablo",
        tipog:"G-Coach"
    },
    {
        id:2,
        nombre:"Paola",
        tipog:"A-Coach"    
    },
    {
        id:3,
        nombre:"Tino",
        tipog:"A-Coach"
    },
    {
        id:4,
        nombre:"Maya",
        tipog:"G-Coach"
    }
]

app.set('view engine',"hbs")

app.get('/',(req, res)=>{
    res.render(
        'template',
        {titulo:'Handlebars', mensaje:"Pab| handlebars", personas:personas}
    )
});

app.get('/pagina2',(req, res)=>{
    res.render(
        'pagina2',
        {titulo:'Pagina2', mensaje:"Nueva Leccion"}
    )
});

app.get('/leccion',(req, res)=>{
    res.render(
        'leccion',
        {titulo:'Handlebars', mensaje:"Pab| handlebars"+req.query.idLeccion}
    )
});

app.post('/pagina2',(req, res)=>{
    
    res.send('hola ! '+req.method)
});
/*
app.listen(3000,()=>{
    console.log('corriendo en el puerto 3000')
});*/