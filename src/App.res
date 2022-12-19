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

let initialBoardState = Belt_Array.make(9, Empty)

@react.component
let make = () => {
  let (gameType, setGameType) = React.useState(_ => "Basic")
  let (scores, setScores) = React.useState(_ => {xScore: 0, oScore: 0})
  let (xScore, setXscore) = React.useState(_ => 0)
  let (oScore, setOscore) = React.useState(_ => 0)
  let (player, setPlayer) = React.useState(_ => X) //X begins the game, but we can always change this

  let incrementScore = (player) => {
    switch player {
      | X => setXscore(_ => xScore + 1);
      | O => setOscore(_ => oScore + 1);
      | Empty => Js.log("Should not be reached")
    }
  }

  let display = switch gameType {
    | "Basic" => <Board gameType=gameType player=player setPlayer=setPlayer scores=scores setScores=setScores/>
    | "Ultimate" => <UltimateBoard gameType=gameType player=player setPlayer=setPlayer scores=scores setScores=setScores/>
    | "Wild" => <Wild gameType=gameType player=player setPlayer=setPlayer incrementScore=incrementScore/>
    | "Inverse" => <InverseBoard gameType=gameType player=player setPlayer=setPlayer xScore=xScore setXscore=setXscore oScore=oScore setOscore=setOscore/>
    | "Gomoku" => <Gomoku gameType=gameType player=player setPlayer=setPlayer incrementScore=incrementScore/>
    | _ => <Board gameType=gameType player=player setPlayer=setPlayer scores=scores setScores=setScores/>
  
  }

  let updateGame = (gType) => {
    setGameType(_ => gType)
  }

  let xPlaying = switch player {
    | X => true 
    | O => false
    | _ => false 
  }

  // let forfeit = () => {
  //   Js.Console.log(switch player {
  //     | X => "Player O won!"
  //     | O => "Player X won!"
  //     | Empty => "Draw"
  //   })
  // }


  <div className="App">
    <ScoreBoard xScore={xScore} oScore={oScore} xPlaying={xPlaying} />
    <div className="Buttons">
      <div className="Button" onClick={_ => updateGame("Basic")}>{"Basic"->React.string}</div> 
      <div className="Button" onClick={_ => updateGame("Ultimate")}>{"Ultimate"->React.string}</div> 
      <div className="Button" onClick={_ => updateGame("Inverse")}>{"Inverse"->React.string}</div> 
      <div className="Button" onClick={_ => updateGame("Wild")}>{"Wild"->React.string}</div>
      <div className="Button" onClick={_ => updateGame("Gomoku")}>{"Gomoku"->React.string}</div> 
      <div className="Button" onClick={_ => updateGame("Notako")}>{"Notako"->React.string}</div> 
    </div> 
    <div className=gameType>
      display
    </div>
  </div>
}
