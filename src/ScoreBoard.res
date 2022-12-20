%%raw(`import './App.css';`)

 @react.component
 let make = (~xScore, ~oScore, ~xPlaying, ~p1Name, ~p2Name) => {

    let xTurn = switch xPlaying {
        | true => ""
        | _ => "inactive"
    }

    let oTurn = switch xPlaying {
        | true => "inactive"
        | _ => ""
    }

    <div className="scoreboard">
        <span className={"score x-score " ++ xTurn}>{{p1Name ++ " - " ++ {xScore}->Belt.Int.toString}->React.string}</span>
        <span className={"score o-score " ++ oTurn}>{{p2Name ++ " - " ++ {oScore}->Belt.Int.toString}->React.string}</span>
    </div>
    
 }