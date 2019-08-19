import { Elm } from './src/Main.elm'
import floors from './list.csv'

Elm.Main.init({
  node: document.querySelector('main'),
  flags: floors
});
