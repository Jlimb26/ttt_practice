%%raw(`import './App.css';`)
@module("./logo.svg") external logo: string = "default"

@@warning("-27")
@@warning("-26")

open Square

type score = {
  mutable xScore: int,
  mutable oScore: int
}

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

let gomoku_instruction = "Get 5 in a row"
let inverse_instruction = "Try not to get 3 in a row"
let basic_instruction = "Get 3 in a row"
let ultimate_instruction = "Try to win 3 boards in a row to win"
let oc_instruction = "Order wants to get 5 in a row, chaos wants to prevent that"
let wild_instruction = "Whoever completes the 3 in a row wins"

let initialBoardState = Belt_Array.make(9, Empty)

@react.component
let make = () => {
  let (gameType, setGameType) = React.useState(_ => "Basic")
  let (xScore, setXscore) = React.useState(_ => 0)
  let (oScore, setOscore) = React.useState(_ => 0)
  let (player, setPlayer) = React.useState(_ => X) //X begins the game, but we can always change this

  let instruction_content = switch gameType {
    | "Basic" => basic_instruction
    | "Inverse" => inverse_instruction
    | "Gomoku" => gomoku_instruction
    | "Ultimate" => ultimate_instruction
    | "O&C" => oc_instruction
    | "Wild" => wild_instruction
    | _ => "No instructions available"
  }

  let incrementScore = (player) => {
    switch player {
      | X => setXscore(_ => xScore + 1);
      | O => setOscore(_ => oScore + 1);
      | Empty => Js.log("Should not be reached")
    }
  }

  let xPlaying = switch player {
    | X => true 
    | O => false
    | _ => false 
  }

  let display = switch gameType {
    | "Basic" => <BasicBoard gameType=gameType player=player setPlayer=setPlayer incrementScore=incrementScore/>
    | "Ultimate" => <UltimateBoard gameType=gameType player=player setPlayer=setPlayer incrementScore=incrementScore/>
    | "Wild" => <WildBoard gameType=gameType player=player setPlayer=setPlayer incrementScore=incrementScore/>
    | "Inverse" => <InverseBoard gameType=gameType player=player setPlayer=setPlayer xScore=xScore setXscore=setXscore oScore=oScore setOscore=setOscore/>
    | "Gomoku" => <GomokuBoard gameType=gameType player=player setPlayer=setPlayer incrementScore=incrementScore/>
    | "O&C" => <OCBoard gameType=gameType player=player setPlayer=setPlayer incrementScore=incrementScore xScore={xScore} oScore={oScore} xPlaying={xPlaying}/>
    | _ => <Board gameType=gameType player=player setPlayer=setPlayer incrementScore=incrementScore/>
  }

  let updateGame = (gType) => {
    setGameType(_ => gType)
  }

  // let forfeit = () => {
  //   Js.Console.log(switch player {
  //     | X => "Player O won!"
  //     | O => "Player X won!"
  //     | Empty => "Draw"
  //   })
  // }


  <div className={"App " ++ gameType}>
    <ScoreBoard xScore={xScore} oScore={oScore} xPlaying={xPlaying} p1Name={"P1"} p2Name={"P2"}/>
    <div className="Title">{gameType->React.string}</div>
    <div className="Buttons">
      <div className="Button" onClick={_ => updateGame("Basic")}>{"Basic"->React.string}</div> 
      <div className="Button" onClick={_ => updateGame("Ultimate")}>{"Ultimate"->React.string}</div> 
      <div className="Button" onClick={_ => updateGame("Inverse")}>{"Inverse"->React.string}</div> 
      <div className="Button" onClick={_ => updateGame("Wild")}>{"Wild"->React.string}</div>
      <div className="Button" onClick={_ => updateGame("Gomoku")}>{"Gomoku"->React.string}</div> 
      <div className="Button" onClick={_ => updateGame("O&C")}>{"O&C"->React.string}</div> 
    </div> 
    <div className=gameType>
      display
    </div>
    <Instruction content=instruction_content /> 
  </div>
}
