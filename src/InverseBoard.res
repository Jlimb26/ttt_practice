%%raw(`import './App.css';`)
@module("./logo.svg") external logo: string = "default"

@@warning("-27")
@@warning("-26")

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
let make = (~gameType, ~player, ~setPlayer, ~xScore, ~setXscore, ~oScore, ~setOscore) => {
  let (board, setBoard) = React.useState(_ => initialBoardState);
  // let (player, setPlayer) = React.useState(_ => X);

  let checkWin = (newBoard) => {
    Belt_Array.forEach(patterns, (currPattern) => {
      let firstPlayer = newBoard[currPattern[0]]
      if Belt_Array.every(currPattern, (x) => newBoard[x] == firstPlayer) && firstPlayer != Empty {
        if (firstPlayer == X) {
            setOscore(_ => oScore + 1)
        } else {
            setXscore(_ => xScore + 1)
        }
        setBoard(_ => initialBoardState)
      }
    })
  }

  let checkTie = (newBoard) => {
    if (Belt_Array.every(newBoard, (val) => val != Empty)) {
      setBoard(_ => initialBoardState)
    }
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
    checkWin(newBoard)
    checkTie(newBoard)
    if (player == X) {
      setPlayer(_ => O)
    } else {
      setPlayer(_ => X)
    }
  }

  // let resetBoard = () => {
  //   setBoard(_ => initialBoardState)
  // }


  React.useEffect1(() => {
    Some(() => {
      Js.Console.log("Board state changed")
      Js.Console.log(board)
  })
  }, [board])




  <div> 
    <div className={"board " ++ gameType}> 
        <Square value=board[0] chooseSquare={_ => chooseSquare(0)} gameType=gameType/>
        <Square value=board[1] chooseSquare={_ => chooseSquare(1)} gameType=gameType/>
        <Square value=board[2] chooseSquare={_ => chooseSquare(2)} gameType=gameType/>

        <Square value=board[3] chooseSquare={_ => chooseSquare(3)} gameType=gameType/>
        <Square value=board[4] chooseSquare={_ => chooseSquare(4)} gameType=gameType/>
        <Square value=board[5] chooseSquare={_ => chooseSquare(5)} gameType=gameType/>

        <Square value=board[6] chooseSquare={_ => chooseSquare(6)} gameType=gameType/>
        <Square value=board[7] chooseSquare={_ => chooseSquare(7)} gameType=gameType/>
        <Square value=board[8] chooseSquare={_ => chooseSquare(8)} gameType=gameType/>
    </div>
  </div>
}