# [Tic-Tac-Toe Galore!](https://tictactoe-galore.netlify.app)

This project, written entirely in ReScript, contains the code for our tic-tac-toe galore game! The application itself consists of a variety different tic-tac-toe games, including traditional tic-tac-toe, ultimate tic-tac-toe, inverse tic-tac-toe, and so on.

## Requirements
This project requires node.js, npm, Yarn, and ReScript. ReScript is an npm package, and will automatically be installed with npm.

### Node.js and npm:

To install node.js and npm, refer to the following website: [Installing Node.js and NPM](https://docs.npmjs.com/downloading-and-installing-node-js-and-npm), as the installation process differs depending on the OS.

### Yarn:

We can now use npm to install Yarn. In the app folder, run the following command to do a global install of yarn (you may have to give npm sudo permissions):

```shell
npm install --global yarn
```


### ReScript and Node Modules

After this process, run the following in the top-level (root) project folder to install the rest of the dependencies, including ReScript:

```shell
npm install 
```

## Deployment

This application is currently deployed on heroku at the following link: [Tic-Tac-Toe-Galore](https://tictactoe-galore.netlify.app)

To run the rescript compiler, you can run one of the following:

```shell
cd src/
yarn re:start 
#or
npm run re:script
```

While this is running, run the following code in a separate terminal to start the app:

```shell
cd src/
npm start
```

This will run the project at localhost on default port 3000; [http://localhost:3000](http://localhost:3000).



### `npm test`

Launches the test runner in the interactive watch mode.\
See the section about [running tests](https://facebook.github.io/create-react-app/docs/running-tests) for more information.
