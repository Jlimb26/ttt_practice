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

//Wrapper class for Board, implements the win condition for basic board
@react.component
let make = (~gameType, ~player, ~setPlayer, ~incrementScore) => {

  // let resetBoard = () => {
  //   setBoard(_ => initialBoardState)
  // }

  let changeWin = (_, player) => {
    incrementScore(player);
  }


  //Rendering info for the winner (BoardResult), as well as each individual square.
    <div className={"board " ++ gameType}> 
      <Board gameType=gameType player=player setPlayer=setPlayer incrementScore=incrementScore
        passState=changeWin />
    </div>
}
