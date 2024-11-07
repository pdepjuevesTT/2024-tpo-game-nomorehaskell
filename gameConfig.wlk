import player.*
import game.*

object config {
    method mapSize() = 14

    method initGame() {
        game.title("Epic Snake")
        game.height(self.mapSize())
        game.width(self.mapSize())

        game.cellSize(32)
        game.boardGround("background.png")
    }

    method initPlayer1(player1) {
        game.addVisual(player1)

        keyboard.down().onPressDo {player1.changeDirection("south")}
        keyboard.up().onPressDo {player1.changeDirection("north")}
        keyboard.right().onPressDo {player1.changeDirection("east")}
        keyboard.left().onPressDo {player1.changeDirection("west")}

        game.onTick(400, "mitick", {player1.move("")})
    }

}

object gameState {
    
    method loseGame(visual) {
        game.say(visual, "You lose!")
        game.stop()
    }
}

object positionCreator {
  const mapSize = config.mapSize()
  method position() = game.at(0.randomUpTo(mapSize - 1), 0.randomUpTo(mapSize - 1)) 

}