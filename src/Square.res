%%raw(`import './App.css';`)

//Represents an individual square 
type square = 
  | X
  | O
  | Empty 

//Component that represents an individual square for each board
@react.component
let make = (~value: square, ~chooseSquare, ~gameType) => {

  //Fills each indivdual square with an X, O, or nothing value
  let fill = switch value { 
    | X => "X"
    | O => "O"
    | Empty => ""
  }

  //Handles styling for the squares
  let style = switch value {
    | X => "square x "
    | O => "square o "
    | Empty => "square "
  }

  <div onClick=chooseSquare className={style ++ gameType}>{fill->React.string}</div> 
}