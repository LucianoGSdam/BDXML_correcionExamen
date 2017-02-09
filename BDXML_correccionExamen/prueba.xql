xquery version "3.0";

declare function local:random($max as xs:integer) as xs:integer
{
    let $r := ceiling(util:random() * $max) cast as xs:integer
    return (
        session:set-attribute("random", $r),
        session:set-attribute("guesses", 0),
        $r
    )
};

    <questions>
{      
    
    let $n:= (local:random(8))  
    for $pregunta in doc("preguntas_grupo.xml")/questions/question
  
    return if ($pregunta/type="select")then
    <question id="{$pregunta/@id}">
        {$pregunta/type}
        {$pregunta/text}
        {$pregunta/option[1]}
        {$pregunta/option[2]}
        {$pregunta/option[3]}
        {$pregunta/option[4]}
    </question>
        
    else if ($pregunta/type="text")then
    <question id="{$pregunta/@id}">
        {$pregunta/type}
        {$pregunta/text}
    </question>
        
    else if ($pregunta/type='radio') then
    <question id="{$pregunta/@id}">
        {$pregunta/type}
        {$pregunta/text}
        {$pregunta/option[1]}
        {$pregunta/option[2]}
        {$pregunta/option[3]}
        {$pregunta/option[4]}
    </question>
      
    else if ($pregunta/type='checkbox') then
    <question id="{$pregunta/@id}">
        {$pregunta/type}
        {$pregunta/text}
        {$pregunta/option[1]}
        {$pregunta/option[2]}
        {$pregunta/option[3]}
        {$pregunta/option[4]}
    </question>
            
    else
    <question id="{$pregunta/@id}">
        {$pregunta/type}
        {$pregunta/text}
        {$pregunta/option[1]}
        {$pregunta/option[2]}
        {$pregunta/option[3]}
        {$pregunta/option[4]}
    </question>
    }   
</questions>

