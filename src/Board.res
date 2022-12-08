%%raw(`import './App.css';`)
@module("./logo.svg") external logo: string = "default"

open Square

let patterns = [
  [0, 1, 2],
  [3, 4, 5],
  [6, 7, 8],
  [0, 3, 6],
  [1, 4, 7],
  [2, 5, 8],
  [0, 4, 8],
  [2, 4, 6]
]

let initialBoardState = Belt_Array.make(9, Empty)

@react.component
let make = () => {
  let (board, setBoard) = React.useState(_ => initialBoardState);
  let (player, setPlayer) = React.useState(_ => X);
  let (result, setResult) = React.useState(_ => Empty)

  let checkWin = () => {
    Belt_Array.forEach(patterns, (currPattern) => {
      let firstPlayer = board[currPattern[0]]
      if Belt_Array.every(currPattern, (x) => board[x] == firstPlayer) && firstPlayer != Empty {
        setResult(_ => firstPlayer)
        Js.Console.log("Someone won!")
      }
    })
  }

  let chooseSquare = (square) => {
    let newBoard = Belt_Array.mapWithIndex(board, (i, val) => {
      if (i == square && val == Empty) {
        player
      } 
      else {
        val
      }
    })
    setBoard(_ => newBoard)
    if (player == X) {
      setPlayer(_ => O)
    } else {
      setPlayer(_ => X)
    }
  }


  React.useEffect1(() => {
    Some(() => {
      Js.Console.log("Board state changed")
      Js.Console.log(board)
  })
  }, [board])


  React.useEffect1(() => {
    Some(() => {
      Js.Console.log("Checking for a win")
      checkWin()
    })
  }, [board])



  <div className="App"> 
    <BoardResult value=result />
    <div className="board"> 
        <Square value=board[0] chooseSquare={_ => chooseSquare(0)} />
        <Square value=board[1] chooseSquare={_ => chooseSquare(1)} />
        <Square value=board[2] chooseSquare={_ => chooseSquare(2)} />

        <Square value=board[3] chooseSquare={_ => chooseSquare(3)} />
        <Square value=board[4] chooseSquare={_ => chooseSquare(4)} />
        <Square value=board[5] chooseSquare={_ => chooseSquare(5)} />

        <Square value=board[6] chooseSquare={_ => chooseSquare(6)} />
        <Square value=board[7] chooseSquare={_ => chooseSquare(7)} />
        <Square value=board[8] chooseSquare={_ => chooseSquare(8)} />
    </div>
  </div>
}
