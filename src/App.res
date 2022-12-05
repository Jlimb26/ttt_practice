%%raw(`import './App.css';`)
@module("./logo.svg") external logo: string = "default"

open Square

let initialBoardState = Belt_Array.make(9, Empty)

@react.component
let make = () => {
  let (board, setBoard) = React.useState(_ => initialBoardState)
  let (player, setPlayer) = React.useState(_ => "X")

  <div className="App"> 
    <div className="board"> 
      <div className="row"> 
        <Square value=board[0] chooseSquare={_ => setBoard} />
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
