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

let initialBoardState = Belt_Array.make(225, Empty)

@react.component
let make = (~gameType, ~player, ~setPlayer) => {
  let (board, setBoard) = React.useState(_ => initialBoardState);
  // let (player, setPlayer) = React.useState(_ => X);
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

  // let resetBoard = () => {
  //   setBoard(_ => initialBoardState)
  // }


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



  <div> 
    <BoardResult value=result gameType=gameType/>
    <div className="gomuku_board"> 
        {board -> Belt.Array.mapWithIndex((i, val) => {
            <Square value=val chooseSquare={_ => chooseSquare(i)} gameType=gameType/>
        })->React.array}
    </div>
  </div>
}