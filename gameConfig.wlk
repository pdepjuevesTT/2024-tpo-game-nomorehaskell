import player.*
import game.*
import items.*


object config {
    method mapSize() = 14
    var dosJugadores = true

    method initGame() {
        game.title("Epic Snake")
        game.height(self.mapSize())
        game.width(self.mapSize())

        game.cellSize(32)
        game.boardGround("background.png")

        self.loadWalls()

        const player1 = new Player(dir="west", position= game.at(11,11), number=1)
        self.initPlayer1(player1)

        if(dosJugadores) {
            const player2 = new Player(dir="east", position= game.at(2,2), number=2)
            self.initPlayer2(player2)
        }
    }

    method initPlayer1(player1) {
        game.addVisual(player1)

        keyboard.down().onPressDo {player1.changeDirection("south")}
        keyboard.up().onPressDo {player1.changeDirection("north")}
        keyboard.right().onPressDo {player1.changeDirection("east")}
        keyboard.left().onPressDo {player1.changeDirection("west")}

        game.onTick(400, "movePlayer1", {player1.move("")})

        self.initPlayerCollision(player1)
    }

    method initPlayer2(player2) {
        game.addVisual(player2)

        keyboard.s().onPressDo {player2.changeDirection("south")}
        keyboard.w().onPressDo {player2.changeDirection("north")}
        keyboard.d().onPressDo {player2.changeDirection("east")}
        keyboard.a().onPressDo {player2.changeDirection("west")}

        game.onTick(400, "movePlayer2", {player2.move("")})

        self.initPlayerCollision(player2)
    }

    method initPlayerCollision(currentPlayer) {
        game.whenCollideDo(currentPlayer, { elemento =>
            game.removeVisual(elemento)

            const tag = elemento.tag()
            if(tag == "food") // food.spawn() no funciona por un error interno de Wollok, por lo que se usa este metodo alternativo
                game.schedule(500, {game.addVisual(new Food())})
            if(tag == "body")
                gameState.loseGame()

            elemento.efect(currentPlayer)
            game.schedule(500, {elemento.spawn()})
        })
    }

    method loadWalls() {
        const muros = [0,1,2,3,4,5,6,7,8,9,10,11,12]
        const max = self.mapSize() - 1
        muros.forEach({ pos =>
            game.addVisual(new Wall(position= game.at(0, pos)))
            game.addVisual(new Wall(position= game.at(max, pos+1)))
            game.addVisual(new Wall(position= game.at(pos+1, 0)))
            game.addVisual(new Wall(position= game.at(pos, max)))
        })
    }
}

object gameState {
    
    method loseGame() {
        game.stop()
    }
}