%%raw(`import './App.css';`)
@module("./logo.svg") external logo: string = "default"

open Square

let initialBoardState = Belt_Array.make(9, Empty)

@react.component
let make = () => {
  let (board, setBoard) = React.useState(_ => initialBoardState);
  let (player, setPlayer) = React.useState(_ => X);

  let chooseSquare = (index) => {
    setBoard(_ => Belt_Array.mapWithIndex(board, (i, val) => ({
      if (i == index && val == Empty) { 
        // switchPlayer();
        X 
       }
      else { val }
    })
    ))
  }

  <div className="App"> 
    <div className="board"> 
      <div className="row"> 
        <Square value=board[0] chooseSquare={_ => chooseSquare(0)} />
        <Square value=board[1] chooseSquare={_ => chooseSquare(1)} />
        <Square value=board[2] chooseSquare={_ => chooseSquare(2)} />
      </div>
      <div className="row"> 
        <Square value=board[3] chooseSquare={_ => chooseSquare(3)} />
        <Square value=board[4] chooseSquare={_ => chooseSquare(4)} />
        <Square value=board[5] chooseSquare={_ => chooseSquare(5)} />
      </div>
      <div className="row"> 
        <Square value=board[6] chooseSquare={_ => chooseSquare(6)} />
        <Square value=board[7] chooseSquare={_ => chooseSquare(7)} />
        <Square value=board[8] chooseSquare={_ => chooseSquare(8)} />
      </div>
    </div>
  </div>
}
