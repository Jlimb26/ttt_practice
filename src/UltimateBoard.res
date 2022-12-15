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

@react.component
let make = (~gameType) => {
    <div className="ultimate_board">
        <Board gameType=gameType/>
        <Board gameType=gameType/>
        <Board gameType=gameType/>
        <Board gameType=gameType/>
        <Board gameType=gameType/>
        <Board gameType=gameType/>
        <Board gameType=gameType/>
        <Board gameType=gameType/>
        <Board gameType=gameType/>
    </div>
}