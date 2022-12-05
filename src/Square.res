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
    <div className="square">{fill->React.string}</div> 
 }