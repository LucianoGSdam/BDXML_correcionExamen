xquery version "3.0";
declare option exist:serialize "method=xhtml media-type=text/html indent=yes";

let $unused := ""


let $tipotexto :=for  $tipotexto in doc('preguntas_grupo.xml')/questions/question[type="text"] 
    for $par in request:get-parameter-names()
 return
 if($par = $tipotexto/@id) then
     
    <question id="{$tipotexto/@id}">{$tipotexto/text}{$tipotexto/answer}
    {if ($tipotexto/answer = request:get-parameter($par, ''))then
       <correct>correcta</correct>
    else
       <correct>incorrecta</correct>
    }
    </question>
 else
  $unused
  
let $tiposelect :=for $tiposelect in doc('preguntas_grupo.xml')/questions/question[type="select"] 
    for $par in request:get-parameter-names()
 return
 if($par = $tiposelect/@id) then
    <question id="{$tiposelect/@id}">{$tiposelect/text}{$tiposelect/option}{$tiposelect/answer}
    {if ($tiposelect/answer = request:get-parameter($par, ''))then
        <correct>correcta</correct>
     else
        <correct>incorrecta</correct>
    }
    </question>
 else
  $unused
  
let $tiporadio :=for  $tiporadio in doc('preguntas_grupo.xml')/questions/question[type="radio"] 
    for $par in request:get-parameter-names()
 return
 if($par = $tiporadio/@id) then
    <question id="{$tiporadio/@id}">{$tiporadio/text}{$tiporadio/option}{$tiporadio/answer}
    {for $var in request:get-parameter($par, '') 
    return if($var = $tiporadio/answer)then
        <correct>correcto</correct>
        
    else
         <correct>incorrecto</correct>    
    }
    </question>
 else
  $unused
  
let $tipocheck :=for  $tipocheck in doc('preguntas_grupo.xml')/questions/question[type="checkbox"] 
    for $par in request:get-parameter-names()
 return
 if($par = $tipocheck/@id) then
    <question id="{$tipocheck/@id}">{$tipocheck/text}{$tipocheck/option}{$tipocheck/answer}
    {for $var in request:get-parameter($par, '') 
    return if($var = $tipocheck/answer[0])then
        <correct>correcto</correct>
    else if($var = $tipocheck/answer[1])then
         <correct>correcto</correct> 
    else
        <correct>incorrecto</correct>
    }
    </question>
 else
  $unused

let $tipomultiple :=for  $tipomultiple in doc('preguntas_grupo.xml')/questions/question[type="multiple"] 
    for $par in request:get-parameter-names()
 return
 if($par = $tipomultiple/@id) then
    <question id="{$tipomultiple/@id}">{$tipomultiple/text}{$tipomultiple/option}{$tipomultiple/answer}
    {for $var in request:get-parameter($par, '') 
    return if($var = $tipomultiple/answer[0])then
        <correct>correcto</correct>
    else if($var = $tipomultiple/answer[1])then
         <correct>correcto</correct> 
    else
        <correct>incorrecto</correct>
    }
    </question>
 else
  $unused
  
  let $questions := <questions>{$tipotexto}{$tiposelect}{$tiporadio}{$tipocheck}{$tipomultiple}</questions>
  
  return transform:transform($questions, doc("respuestas.xsl"), ())