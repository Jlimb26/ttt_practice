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
let make = (~gameType, ~player, ~setPlayer, ~incrementScore, ~passState=?, ~val=0) => {
  let (board, setBoard) = React.useState(_ => initialBoardState);
  let (result, setResult) = React.useState(_ => Empty)

  //Checks win for a given 3x3 board
  //If the optional passState function parameter exists (is a Some), this will also update the parent with this win.
  let checkWin = (newBoard) => {
    Belt_Array.forEach(patterns, (currPattern) => {
      let firstPlayer = newBoard[currPattern[0]]
      
      if Belt_Array.every(currPattern, (x) => newBoard[x] == firstPlayer) && firstPlayer != Empty {
        Js.Console.log("Someone won!")
        setResult(_ => firstPlayer);

        switch passState {
          | None => Js.log("No passState");
          | Some(fun) => Js.log("Running Pass state"); fun(val, player);
        }
      }
    })
  }

  //Handles updating a square to X or O
  let chooseSquare = (square) => {
    //Checks if this is a valid click
    let newBoard = Belt_Array.mapWithIndex(board, (i, val) => {
      if (i == square && val == Empty) { player } 
      else { val }
    })

    //Updates next player if a valid move was made
    if (newBoard != board) {
      if (player == X) {
        setPlayer(_ => O)
      } else {
        setPlayer(_ => X)
      }
    }

    //Checks if a player has won the game
    checkWin(newBoard);
    setBoard(_ => newBoard);
  }

  // let resetBoard = () => {
  //   setBoard(_ => initialBoardState)
  // }


  // React.useEffect1(() => {
  //   Some(() => {
  //     Js.Console.log("Board state changed")
  //     Js.Console.log(board)
  // })
  // }, [board])


  // React.useEffect1(() => {
  //   Some(() => {
  //     Js.Console.log("Checking for a win")
  //     checkWin()
  //   })
  // }, [board])


  //Rendering info for the winner (BoardResult), as well as each individual square.
  <div> 
    <BoardResult value=result gameType=gameType/>
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
