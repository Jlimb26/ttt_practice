%%raw(`import './App.css';`)
type square = 
    | X
    | O
    | Empty 
 
 @react.component
 let make = (~value: square, ~chooseSquare, ~gameType) => {

    let fill = switch value { 
        | X => "X"
        | O => "O"
        | Empty => ""
    }
    
    let style = switch value {
        | X => "square x "
        | O => "square o "
        | Empty => "square "
    }
    <div onClick=chooseSquare className={style ++ gameType}>{fill->React.string}</div> 
 }