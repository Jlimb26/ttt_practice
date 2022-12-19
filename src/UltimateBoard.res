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

let initialUltimateState = Belt_Array.make(9, Empty)
let initialBoardStates = Belt_Array.make(9, Empty)

@react.component
let make = (~gameType, ~player, ~setPlayer, ~incrementScore, ~winningPlayer=?) => {
  let (ultBoard, setUltBoard) = React.useState(_ => initialUltimateState);
  let (boards, setBoards) = React.useState(_ => initialBoardStates);

  let resetUltBoard = () => {
    // Js.Console.log(ultBoard);
    setBoards(_ => initialBoardStates);
    setUltBoard(_ => initialUltimateState);
  }

  let checkWin = (ultBoard) => {
    Belt_Array.forEach(patterns, (currPattern) => {
      let firstPlayer = ultBoard[currPattern[0]]
      if Belt_Array.every(currPattern, (x) => ultBoard[x] == firstPlayer) && firstPlayer != Empty {
        incrementScore(firstPlayer);

        Js.Console.log("Someone won the ultimate TTT Game!")
        resetUltBoard();
      }
    })
  }

  let changeBoardState = (thisi, givenPlayer) => {
    let newBoard = Belt_Array.mapWithIndex(ultBoard, (i, val) => {
      if (i == thisi && val == Empty) {
        givenPlayer
      } 
      else {
        val
      }
    })
    setUltBoard(_ => newBoard);
    // Js.log("setting ult board")
    // Js.log(newBoard);
    checkWin(newBoard);
  }

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