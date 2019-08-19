import { Elm } from './src/Main.elm'
import floors from './floorList.csv'

Elm.Main.init({
  node: document.querySelector('main'),
  flags: floors
});
