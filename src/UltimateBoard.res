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

let initialBoardStates2 = Belt_Array.make(9, Belt_Array.make(9, Empty))

//Initial States for both the individual boards and ult board for resets
let initialUltimateState = Belt_Array.make(9, Empty)
let initialBoardStates = Belt_Array.make(9, Empty)

@react.component
let make = (~gameType, ~player, ~setPlayer, ~incrementScore, ~winningPlayer=?) => {
  let (ultBoard, setUltBoard) = React.useState(_ => initialUltimateState);
  let (boards, setBoards) = React.useState(_ => initialBoardStates);
  let (result, setResult) = React.useState(_ => Empty);

  //Resets the ultimate board
  let resetUltBoard = () => {
    Js.Console.log("Trying to reset")
    setBoards(_ => initialBoardStates);
    setUltBoard(_ => initialUltimateState);
    Js.Console.log(initialBoardStates);
    Js.Console.log(initialUltimateState);
  }

  //Iterates through the ultBoard array, checking if the patterns match for the overall board result
  //Increments score if a player won the game
  let checkWin = (ultBoard) => {
    Belt_Array.forEach(patterns, (currPattern) => {
      let firstPlayer = ultBoard[currPattern[0]]
      if Belt_Array.every(currPattern, (x) => ultBoard[x] == firstPlayer) && firstPlayer != Empty {
        incrementScore(firstPlayer);
        setResult(_ => firstPlayer);
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

  //Rendering info for this Ultimate board of 3x3 tic-tac-toe Boards
  <div className="ultimate_board">
    <BoardResult value=result gameType="Overall_ultimate" />
      {Belt_Array.mapWithIndex((initialBoardStates2), (i, val) => {
        <Board gameType=gameType player=player setPlayer=setPlayer incrementScore=incrementScore passState=changeBoardState val=i />
      })->React.array}
  </div>
}