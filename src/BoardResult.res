%%raw(`import './App.css';`)

open Square

 @react.component
 let make = (~value: square, ~gameType) => {
    let fill = switch value { 
        | X => "X"
        | O => "O"
        | Empty => ""
    }
    
    let style = switch value {
        | X => "display_result x "
        | O => "display_result o "
        | Empty => "display_nothing "
    }

    <div className={style ++ gameType}>{fill->React.string}</div> 
 }