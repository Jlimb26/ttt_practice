%%raw(`import './App.css';`)

//Component that represents an individual square for each board
@react.component
let make = (~value: int, ~chooseSquare, ~gameType) => {




  <div onClick=chooseSquare className={"square " ++ gameType}>{value->Belt.Int.toString->React.string}</div> 
}