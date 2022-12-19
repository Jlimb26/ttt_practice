%%raw(`import './App.css';`)
@module("./logo.svg") external logo: string = "default"

@@warning("-27")
@@warning("-26")

open Square

type choice = 
  | Order
  | Chaos
  | Neither

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

let initialBoardState = Belt_Array.make(36, Empty)

@react.component
let make = (~gameType, ~player, ~setPlayer, ~incrementScore, ~passState=?, ~val=0) => {
  let (board, setBoard) = React.useState(_ => initialBoardState);
  let (result, setResult) = React.useState(_ => Empty)
  let (option, setOption) = React.useState(_ => Empty)
  let (p1Alignment, setP1Alignment) = React.useState(_ => Neither)

  // let resetBoard = () => {
  //   setBoard(_ => initialBoardState)
  // }

  //Checks win for a given 3x3 board
  //If the optional passState function parameter exists (is a Some), this will also update the parent with this win.
  let checkWin = (newBoard) => {
    Belt_Array.forEach(patterns, (currPattern) => {
      let firstPlayer = newBoard[currPattern[0]]
      
      if Belt_Array.every(currPattern, (x) => newBoard[x] == firstPlayer) && firstPlayer != Empty {
        Js.Console.log("Someone won!")
        setResult(_ => firstPlayer);

        switch passState {
          | None => Js.log();
          | Some(fun) => fun(val, player);
        }
      }
    })
  }

  //Handles updating a square to X or O
  let chooseSquare = (square) => {
    //Checks if this is a valid click
    let newBoard = Belt_Array.mapWithIndex(board, (i, val) => {
      if (i == square && val == Empty) { player } 
      else { val }
    })

    //Updates next player if a valid move was made
    if (newBoard != board) {
      if (player == X) {
        setPlayer(_ => O)
      } else {
        setPlayer(_ => X)
      }
    }

    //Checks if a player has won the game
    checkWin(newBoard);
    setBoard(_ => newBoard);
  }

  let xClicked = switch option {
        | X => "clicked"
        | _ => ""
    }

    let oClicked = switch option {
        | O => "clicked"
        | _ => ""
    }

    let alignmentSelected = switch p1Alignment {
        | Order | Chaos => "display_nothing"
        | Neither => ""
    }

  //Rendering info for the winner (BoardResult), as well as each individual square.
  <div> 
    <div className={"alignment_cover " ++ alignmentSelected}>{"Hi"->React.string}</div>
    <div className={"select_alignment " ++ alignmentSelected}>
        <div className="alignment_text">{"Select Your Alignment"->React.string}</div>
        <div className="alignment_buttons">
            <button onClick={_ => setP1Alignment(_ => Chaos)} className="chaos aButton">{"CHAOS"->React.string}</button>
            <button onClick={_ => setP1Alignment(_ => Order)} className="order aButton">{"ORDER"->React.string}</button>
        </div>
    </div> 
    <div className="o_a_board"> 
        {board -> Belt.Array.mapWithIndex((i, val) => {
            <Square value=val chooseSquare={_ => chooseSquare(i)} gameType=gameType/>
        })->React.array}
    </div>
    <div className="moveOptions o_c">
            <button className={"x-option " ++ xClicked} onClick=(_ => setOption(_ => X))>{"X"->React.string}</button>
            <button className={"o-option " ++ oClicked}onClick={_ => setOption(_ => O)}>{"O"->React.string}</button>
    </div> 
  </div>
}