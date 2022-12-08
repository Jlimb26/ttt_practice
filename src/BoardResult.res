%%raw(`import './App.css';`)

open Square

 @react.component
 let make = (~value: square) => {
    let fill = switch value { 
        | X => "X"
        | O => "O"
        | Empty => ""
    }
    
    let style = switch value {
        | X | O => "display_result"
        | Empty => "display_nothing"
    }

    <div className=style>{fill->React.string}</div> 
 }