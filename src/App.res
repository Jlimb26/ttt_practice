%%raw(`import './App.css';`)
@module("./logo.svg") external logo: string = "default"

open Square

let initialState = Belt_Array.make(9, Empty)

@react.component
let make = () => {
  let (board, setBoard) = React.useState(_ => initialState)
  <div className="App"> 
    <div className="board"> 
      <div className="row"> 
        <Square value=board[0] chooseSquare={_ => Js.Console.log(0)} />
        <Square value=board[0] chooseSquare={_ => Js.Console.log(0)} />
        <Square value=board[0] chooseSquare={_ => Js.Console.log(0)} />
      </div>
      <div className="row"> 
        <Square value=board[0] chooseSquare={_ => Js.Console.log(0)} />
        <Square value=board[0] chooseSquare={_ => Js.Console.log(0)} />
        <Square value=board[0] chooseSquare={_ => Js.Console.log(0)} />
      </div>
      <div className="row"> 
        <Square value=board[0] chooseSquare={_ => Js.Console.log(0)} />
        <Square value=board[0] chooseSquare={_ => Js.Console.log(0)} />
        <Square value=board[0] chooseSquare={_ => Js.Console.log(0)} />
      </div>
    </div>
  </div>
}
