%%raw(`import './App.css';`)

open Square

 @react.component
 let make = (~value: square) => {
    let fill = switch value { 
        | X => "X"
        | O => "O"
        | Empty => ""
    }
    <div className="board_result">{fill->React.string}</div> 
 }