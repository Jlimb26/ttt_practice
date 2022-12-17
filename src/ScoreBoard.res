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
        <span className={"score x-score " ++ xTurn}>{{"X - " ++ {xScore}->Belt.Int.toString}->React.string}</span>
        <span className={"score o-score " ++ oTurn}>{{"O - " ++ {oScore}->Belt.Int.toString}->React.string}</span>
    </div>
    
 }