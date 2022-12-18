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

let initialBoardState = Belt_Array.make(225, Empty)

let horizontals = Belt_Array.make(15, 0);
let verticals = Belt_Array.make(15, 0);

@react.component
let make = (~gameType, ~player, ~setPlayer, ~scores, ~setScores) => {
  let (board, setBoard) = React.useState(_ => initialBoardState);
  let (result, setResult) = React.useState(_ => Empty)
  

  let checkHorizontalWinner = (newBoard, currPlayer) => {
    Belt_Array.forEachWithIndex(newBoard, (i, value) => {
      if (horizontals[i / 15] >= 5) {
        horizontals[i / 15] = horizontals[i / 15]
      } else if (value == currPlayer) {
        horizontals[i / 15] = horizontals[i / 15] + 1 
        Js.Console.log(horizontals[i / 15])
      } else {
        horizontals[i / 15] = 0
      }
    })
    Js.Array.find(x => x >= 5, horizontals) == Some(5)
  }

  let checkVerticalWinner = (newBoard, currPlayer) => {
    Belt_Array.forEachWithIndex(newBoard, (i, value) => {
      if (verticals[mod(i, 15)] >= 5) {
        verticals[mod(i, 15)] = verticals[mod(i, 15)]
      } else if (value == currPlayer) {
        verticals[mod(i, 15)] = verticals[mod(i, 15)] + 1
      } else {
        verticals[mod(i, 15)] = 0
      }
    })
    Js.Array.find(x => x >= 5, verticals) == Some(5)
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

    if (newBoard != board) {
      if (player == X) {
        setPlayer(_ => O)
      } else {
        setPlayer(_ => X)
      }
    }

    setBoard(_ => newBoard)

    if (checkHorizontalWinner(newBoard, player) || checkVerticalWinner(newBoard, player)) {
      // if (player == X) {
      //   setScores(_ => {scores.xScore + 1, scores.oScore})
      // } else {
      //   setScores(_ => {xScore: xScore, yScore: yScore + 1})
      // }
      setBoard(_ => initialBoardState)
    }

  }

  // let resetBoard = () => {
  //   setBoard(_ => initialBoardState)
  // }


  React.useEffect1(() => {
    Some(() => {
      Js.Console.log("Horizontal")
      Js.Console.log(horizontals)
      Js.Console.log("Result")
      Js.Console.log(result)
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