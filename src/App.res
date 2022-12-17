%%raw(`import './App.css';`)
@module("./logo.svg") external logo: string = "default"

open Square

type score = {
  xScore: int,
  oScore: int
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

let initialBoardState = Belt_Array.make(9, Empty)

@react.component
let make = () => {
  let (gameType, setGameType) = React.useState(_ => "Basic")
  let (scores, setScores) = React.useState(_ => {oScore: 0, xScore: 0})
  let (player, setPlayer) = React.useState(_ => X) //X begins the game, but we can always change this

  let display = switch gameType {
    | "Basic" => <Board gameType=gameType player=player setPlayer=setPlayer/>
    | "Ultimate" => <UltimateBoard gameType=gameType player=player setPlayer=setPlayer/>
    | _ => <Board gameType=gameType player=player setPlayer=setPlayer/>
  
  }

  let updateGame = (gType) => {
    setGameType(_ => gType)
  }


  <div className="App">
    <div className="Buttons">
      <div className="Button" onClick={_ => updateGame("Basic")}>{"Basic"->React.string}</div> 
      <div className="Button" onClick={_ => updateGame("Ultimate")}>{"Ultimate"->React.string}</div> 
      <div className="Button" onClick={_ => updateGame("Ultimate")}>{"Inverse"->React.string}</div> 
      <div className="Button" onClick={_ => updateGame("Ultimate")}>{"SOS"->React.string}</div> 
    </div> 
    <div className=gameType>
      display
    </div>
  </div>
}
