%%raw(`import './App.css';`)

 @react.component
 let make = (~xScore, ~oScore, ~xPlaying) => {

    let xTurn = switch xPlaying {
        | true => ""
        | _ => "inactive"
    }

    let oTurn = switch xPlaying {
        | true => "inactive"
        | _ => ""
    }

    <div className="scoreboard">
        <span className={"score x-score " ++ xTurn}>{{"P1 - " ++ {xScore}->Belt.Int.toString}->React.string}</span>
        <span className={"score o-score " ++ oTurn}>{{"P2 - " ++ {oScore}->Belt.Int.toString}->React.string}</span>
    </div>
    
 }