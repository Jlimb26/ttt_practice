%%raw(`import './App.css';`)
@module("./logo.svg") external logo: string = "default"

@@warning("-27")
@@warning("-26")

open Square

type choice = 
  | Order
  | Chaos
  | Neither

let initialBoardState = Belt_Array.make(36, Empty)

let horizontals = Belt_Array.make(6, 0);
let verticals = Belt_Array.make(6, 0);
let diag1 = Belt_Array.make(6, 0);
let diag2 = Belt_Array.make(11, 0);
let diag3 = Belt_Array.make(6, 0);

@react.component
let make = (~gameType, ~player, ~setPlayer, ~incrementScore, ~passState=?, ~val=0, ~xScore, ~oScore, ~xPlaying) => {
  let (board, setBoard) = React.useState(_ => initialBoardState);
  let (result, setResult) = React.useState(_ => Empty)
  let (option, setOption) = React.useState(_ => X)
  let (p1Alignment, setP1Alignment) = React.useState(_ => Neither)

  let p2AlignmentString = switch p1Alignment {
    | Order => "Chaos"
    | Chaos => "Order"
    | Neither => "Neither"
  }

  let p1AlignmentString = switch p1Alignment {
    | Order => "Order"
    | Chaos => "Chaos"
    | Neither => "Neither"
  }

  // let resetBoard = () => {
  //   setBoard(_ => initialBoardState)
  // }


  

  let checkWinner = (newBoard, currPlayer, stride, direction) => {
    Belt_Array.forEachWithIndex(newBoard, (i, value) => {
      if (stride(i) < 0) {
        direction[0] = direction[0]
      } else if (direction[stride(i)] >= 5) {
        direction[stride(i)] = direction[stride(i)]
      } else if (value == currPlayer) {
        direction[stride(i)] = direction[stride(i)] + 1
      } else {
        direction[stride(i)] = 0
      }
    })
    Js.Array.find(x => x >= 5, direction) == Some(5)
  }

  let checkOveralOrderWin = (newBoard) => {
    checkWinner(newBoard, player, (x) => x / 6, horizontals) || 
    checkWinner(newBoard, player, (x) => mod(x, 6), verticals) ||
    checkWinner(newBoard, player, (x) => mod(x, 6) - x/6, diag1) ||
    checkWinner(newBoard, player, (x) => mod(x, 6) + x/6, diag2) ||
    checkWinner(newBoard, player, (x) => -mod(x, 6) + x/6, diag3)
  }

  let checkChaosWin = (newBoard) => {
    Belt_Array.every(newBoard, (val) => val != Empty)
  }

  let resetCheckers = () => {
    Belt_Array.forEachWithIndex(horizontals, (i, val) => horizontals[i] = 0)
    Belt_Array.forEachWithIndex(verticals, (i, val) => verticals[i] = 0)
    Belt_Array.forEachWithIndex(diag1, (i, val) => diag1[i] = 0)
    Belt_Array.forEachWithIndex(diag2, (i, val) => diag2[i] = 0)
    Belt_Array.forEachWithIndex(diag3, (i, val) => diag3[i] = 0)
  }

  let checkEitherWin = (newBoard) => {
    if (checkOveralOrderWin(newBoard)) {
      if (p1Alignment == Order) {
        incrementScore(X)
      } else {
        incrementScore(O)
      }
      resetCheckers()
      setBoard(_ => initialBoardState)
    } else if (checkChaosWin(newBoard)) {
      if (p1Alignment == Order) {
        incrementScore(O)
      } else {
        incrementScore(X)
      }
      resetCheckers()
      setBoard(_ => initialBoardState)
    }
  }

  //Handles updating a square to X or O
  let chooseSquare = (square) => {
    //Checks if this is a valid click
    let newBoard = Belt_Array.mapWithIndex(board, (i, val) => {
      if (i == square && val == Empty) { option } 
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
    
    setBoard(_ => newBoard);
    checkEitherWin(newBoard)
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
            // <MathSquare value={mod(i, 6) + i/6} chooseSquare={_ => chooseSquare(i)} gameType=gameType/>
        })->React.array}
    </div>
    <div className="moveOptions o_c">
      <button className={"x-option " ++ xClicked} onClick=(_ => setOption(_ => X))>{"X"->React.string}</button>
      <button className={"o-option " ++ oClicked}onClick={_ => setOption(_ => O)}>{"O"->React.string}</button>
    </div> 
  </div>
}