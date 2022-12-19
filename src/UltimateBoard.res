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

//Initial States for both the individual boards and ult board for resets
let initialUltimateState = Belt_Array.make(9, Empty)
let initialBoardStates = Belt_Array.make(9, Empty)

@react.component
let make = (~gameType, ~player, ~setPlayer, ~incrementScore, ~winningPlayer=?) => {
  let (ultBoard, setUltBoard) = React.useState(_ => initialUltimateState);
  let (boards, setBoards) = React.useState(_ => initialBoardStates);

  //Resets the ultimate board
  let resetUltBoard = () => {
    setBoards(_ => initialBoardStates);
    setUltBoard(_ => initialUltimateState);
  }

  //Iterates through the ultBoard array, checking if the patterns match for the overall board result
  //Increments score if a player won the game
  let checkWin = (ultBoard) => {
    Belt_Array.forEach(patterns, (currPattern) => {
      let firstPlayer = ultBoard[currPattern[0]]
      if Belt_Array.every(currPattern, (x) => ultBoard[x] == firstPlayer) && firstPlayer != Empty {
        incrementScore(firstPlayer);
        resetUltBoard();
      }
    })
  }

  //Updates the ultimate board state when a player wins one of the 3x3 squares
  //Then checks if a player won this updated board
  let changeBoardState = (thisi, givenPlayer) => {
    let newBoard = Belt_Array.mapWithIndex(ultBoard, (i, val) => {
      if (i == thisi && val == Empty) { givenPlayer } 
      else { val }
    })

    setUltBoard(_ => newBoard);
    checkWin(newBoard);
  }

  //Rendering info for this board
  <div className="ultimate_board">
      <Board gameType=gameType player=player setPlayer=setPlayer incrementScore=incrementScore
        passState=changeBoardState val=0 />
      <Board gameType=gameType player=player setPlayer=setPlayer incrementScore=incrementScore
        passState=changeBoardState val=1 />
      <Board gameType=gameType player=player setPlayer=setPlayer incrementScore=incrementScore
        passState=changeBoardState val=2 />
      <Board gameType=gameType player=player setPlayer=setPlayer incrementScore=incrementScore
        passState=changeBoardState val=3 />
      <Board gameType=gameType player=player setPlayer=setPlayer incrementScore=incrementScore
        passState=changeBoardState val=4 />
      <Board gameType=gameType player=player setPlayer=setPlayer incrementScore=incrementScore
        passState=changeBoardState val=5 />
      <Board gameType=gameType player=player setPlayer=setPlayer incrementScore=incrementScore
        passState=changeBoardState val=6 />
      <Board gameType=gameType player=player setPlayer=setPlayer incrementScore=incrementScore
        passState=changeBoardState val=7 />
      <Board gameType=gameType player=player setPlayer=setPlayer incrementScore=incrementScore
        passState=changeBoardState val=8 />
  </div>
}