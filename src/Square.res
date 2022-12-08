%%raw(`import './App.css';`)
type square = 
    | X
    | O
    | Empty 
 
 @react.component
 let make = (~value: square, ~chooseSquare) => {
    let fill = switch value { 
        | X => "X"
        | O => "O"
        | Empty => ""
    }
    
    let style = switch value {
        | X | O => "square clicked"
        | Empty => "square"
    }

    <div onClick=chooseSquare className=style>{fill->React.string}</div> 
 }