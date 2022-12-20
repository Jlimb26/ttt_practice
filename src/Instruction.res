%%raw(`import './App.css';`)

//Component that represents an individual square for each board
@react.component
let make = (~content) => {

  //Fills each indivdual square with an X, O, or nothing value
  <div className="instruction">
    <div className = "instruction content">{content->React.string}</div>
  </div> 
}