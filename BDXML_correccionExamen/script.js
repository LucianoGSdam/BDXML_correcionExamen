var formElement=null;
var secret=50;
var campos = false;

var respuestasText = [];
var respuestasSelect = [];
var respuestasChecks = [];
var respuestasRadios = [];
var respuestasMultiple = [];


var preguntas = [];

//**ONLOAD**
window.onload = function(){

//Recibimos el XML de preguntas que nos devuelve PRUEBA.XQL 
var xhttp = new XMLHttpRequest();
xhttp.onreadystatechange = function() {
 if (this.readyState == 4 && this.status == 200) {
  gestionarXml(this);
 }
};
xhttp.open("GET", "prueba.xql", true);
xhttp.send();
 
 //Al apretar el botón CORREGIR
 formElement=document.getElementById('myform');
 formElement.onsubmit=function(){
    
    while(!campos){ 
    revisarExamen();
    }
 }
    return false; 
}

//**GESTIÓN de los datos recibidos en forma de XML**
function gestionarXml(dadesXml){
var xmlDoc = dadesXml.responseXML;

var x, i;
var n = 0;
var texts = 0;
var selects = 0;
var radios = 0;
var checks = 0;
var multiples = 0;
type = "";

for (i = 0; i < 10; i++){
x = xmlDoc.getElementsByTagName("question")[i];
type = x.getElementsByTagName("type")[0].childNodes[0].nodeValue;
var ide = xmlDoc.getElementsByTagName("question")[i].getAttribute("id");
    
    switch(type) {
        
    case "text":
        //Rellenamos title 
        var textContainer=document.getElementById('textContainer'+texts); 
        document.getElementById("preguntaText"+texts).innerHTML = x.getElementsByTagName("text")[0].childNodes[0].nodeValue;
        var input = document.createElement("input");
        input.type="text";
        input.name=ide;
        //input.id=id;
        //input.setAttribute("name", ide);
        textContainer.appendChild(input);
        
        texts++;
        break;
        
    case "select":
        var select = document.getElementById("select"+selects);
        var nopciones = x.getElementsByTagName('option').length; //cuantas opciones hay en el XML 
        
        document.getElementById("preguntaSelect"+selects).innerHTML = x.getElementsByTagName("text")[0].childNodes[0].nodeValue;
        
            //Bucle para rellenar todas las opciones de select
            for (j = 0; j < nopciones; j++) { 
                var option = document.createElement("option");
                option.text = x.getElementsByTagName('option')[j].childNodes[0].nodeValue;
                option.value=j+1;
                select.name=ide;
                select.options.add(option);
            }
        selects++;
        break;
        
    case "radio":
        var radioContainer=document.getElementById('radioContainer'+radios); 
        document.getElementById("preguntaRadio"+radios).innerHTML = x.getElementsByTagName("text")[0].childNodes[0].nodeValue;
        
        //Añadimos las opciones RADIO
        var nopciones = x.getElementsByTagName('option').length;
        for (j = 0; j < nopciones; j++) { 
            var input = document.createElement("input");
            var label = document.createElement("label");
            label.innerHTML = x.getElementsByTagName('option')[j].childNodes[0].nodeValue;
            label.setAttribute("for", "option_"+j);
            input.type="radio";
            input.name=ide;
            input.id="radio_"+j;
            input.value=j+1;
            radioContainer.appendChild(input);
            radioContainer.appendChild(label);
            radioContainer.appendChild(document.createElement("br"));
        }
        radios++;
        break;
        
    case "checkbox":
        var checkboxContainer=document.getElementById('checkboxContainer'+checks); 
        document.getElementById("preguntaCheck"+checks).innerHTML = x.getElementsByTagName("text")[0].childNodes[0].nodeValue;
        
        //Añadimos las opciones CHECKBOX
        var nopciones = x.getElementsByTagName('option').length;
        for (j = 0; j < nopciones; j++) { 
            var input = document.createElement("input");
            var label = document.createElement("label");
            label.innerHTML = x.getElementsByTagName('option')[j].childNodes[0].nodeValue;
            label.setAttribute("for", "option_"+j);
            input.type="checkbox";
            input.name=ide;
            input.id="check_"+j;
            input.value=j+1;
            checkboxContainer.appendChild(input);
            checkboxContainer.appendChild(label);
            checkboxContainer.appendChild(document.createElement("br"));
        }
        checks++;
        break;
        
    case "multiple":
        
        var select = document.getElementById("select"+selects);
        var nopciones = x.getElementsByTagName('option').length; //cuantas opciones hay en el XML 
        
        document.getElementById("preguntaMultiple"+multiples).innerHTML = x.getElementsByTagName("text")[0].childNodes[0].nodeValue;
        
            //Bucle para rellenar todas las opciones de select
            for (j = 0; j < nopciones; j++) { 
                var option = document.createElement("option");
                option.text = x.getElementsByTagName('option')[j].childNodes[0].nodeValue;
                option.value=j+1;
                option.name=ide;
                select.name=ide;
                select.options.add(option);
            }
        multiples++;
        selects++;
        break;
    
    default:
}

  
}
}

//**COMPROBACIÓN de campos vacíos
function revisarExamen(){
    var demo = formElement.elements.length;
    var valor;
    
    document.getElementById("prueba").innerHTML = demo;
     
     
    for(contador = 0; contador < demo; contador++){
        if(formElement.elements[contador].value===""){
            window.alert("Campo vacío");
            formElement.elements[contador].focus();
            campos = false;
            break;
        }else{
            campos = true;
        }
    }
}


function cogerRespuestas(){
    for(i=0;i<formElement.elements.length;i++){
        respuestas[i] = formElement.elements[i].value;
    }
    
}
 
