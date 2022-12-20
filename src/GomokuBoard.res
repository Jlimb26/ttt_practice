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
let diag1 = Belt_Array.make(15, 0);
let diag2 = Belt_Array.make(29, 0);
let diag3 = Belt_Array.make(15, 0);

let instruction = "Goal at least 5 in a row"

@react.component
let make = (~gameType, ~player, ~setPlayer, ~incrementScore) => {
  let (board, setBoard) = React.useState(_ => initialBoardState);
  let (result, setResult) = React.useState(_ => Empty)


  let checkWinner = (newBoard, currPlayer, stride, direction) => {
    Belt_Array.forEachWithIndex(newBoard, (i, value) => {
      if (stride(i) < 0) {
        direction[0] = direction[0]
      } else if (direction[stride(i)] >= 5) {
        direction[stride(i)] = direction[stride(i)]
      } else if (value == currPlayer) {
        direction[stride(i)] = direction[stride(i)] + 1
      } else {
        direction[stride(i)] = 0
      }
    })
    Js.Array.find(x => x >= 5, direction) == Some(5)
  }

  let checkOveralWin = (newBoard) => {
    checkWinner(newBoard, player, (x) => x / 15, horizontals) || 
    checkWinner(newBoard, player, (x) => mod(x, 15), verticals) ||
    checkWinner(newBoard, player, (x) => mod(x, 15) - x/15, diag1) ||
    checkWinner(newBoard, player, (x) => mod(x, 15) + x/15, diag2) ||
    checkWinner(newBoard, player, (x) => -mod(x, 15) + x/15, diag3)
  }

  let resetCheckers = () => {
    Belt_Array.forEachWithIndex(horizontals, (i, val) => horizontals[i] = 0)
    Belt_Array.forEachWithIndex(verticals, (i, val) => verticals[i] = 0)
    Belt_Array.forEachWithIndex(diag1, (i, val) => diag1[i] = 0)
    Belt_Array.forEachWithIndex(diag2, (i, val) => diag2[i] = 0)
    Belt_Array.forEachWithIndex(diag3, (i, val) => diag3[i] = 0)
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

    if (checkOveralWin(newBoard)){
      incrementScore(player)
      setBoard(_ => initialBoardState)
      resetCheckers();
    }

  }

  // let resetBoard = () => {
  //   setBoard(_ => initialBoardState)
  // }


  React.useEffect1(() => {
    Some(() => {
      Js.Console.log("Horizontal")
      Js.Console.log(horizontals)
      Js.Console.log("Vertical")
      Js.Console.log(verticals)
      Js.Console.log("d1")
      Js.Console.log(diag1)
  })
  }, [board])


  <div> 
    <BoardResult value=result gameType=gameType/>
    <div className="gomuku_board"> 
        {board -> Belt.Array.mapWithIndex((i, val) => {
          <Square value=val chooseSquare={_ => chooseSquare(i)} gameType=gameType/>
            // <MathSquare value={-mod(i, 15) + i/15} chooseSquare={_ => chooseSquare(i)} gameType=gameType/>
        })->React.array}
    </div>
  </div>
}