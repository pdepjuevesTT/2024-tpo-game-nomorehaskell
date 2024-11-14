import player.*
import game.*
import items.*


object config {
    var dosJugadores = false
    var gameIsRunning = false

    var property player1 = 0
    var property player2 = 0

    method basicConfig() {
        game.title("Epic Snake")
        game.height(14)
        game.width(14)

        game.cellSize(32)
        game.boardGround("background.png")
    }

    method startMenu() {
        gameIsRunning = false

        keyboard.num1().onPressDo {
            if(!gameIsRunning) {
                gameIsRunning = true
                dosJugadores = false
                self.initGame()
            }
        }
        keyboard.num2().onPressDo {
            if(!gameIsRunning) {
                gameIsRunning = true
                dosJugadores = true
                self.initGame()
            }
        }
    }

    method endMenu() {
        keyboard.r().onPressDo {
            const visuals = game.allVisuals()
            visuals.forEach({visual => game.removeVisual(visual)})
            // Mueve los jugadores viejos fuera del tablero para evitar problemas con la deteccion de coliciones del motor
            player1.position(game.at(30, 30))
            player2.position(game.at(31, 31))

            self.startMenu()
        }
        
    }

    method initGame() {
        gameMaps.loadLevel(dosJugadores)

        player1 = new Player(dir="west", position= game.at(11,11), number=1)
        player2 = new Player(dir="north", position= game.at(2,2), number=2)

        playerConfig.initPlayer1(player1)

        if(dosJugadores) {
            playerConfig.initPlayer2(player2)
        }
    }

    
}

object gameState {
    method loseGame() {
        game.removeTickEvent("movePlayer1")
        game.removeTickEvent("movePlayer2")
        config.endMenu()
    }
}

object playerConfig {
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
}

object gameMaps {
    method loadLevel(dosJugadores) {
        self.loadWalls()

        const nro = 0.randomUpTo(2).round()

        if(!dosJugadores) {
            if(nro == 0) self.spLevel1()
            if(nro == 1) self.spLevel2()
            if(nro == 2) self.spLevel3()
        }
        else {
            if(nro == 0) self.mpLevel1()
            if(nro == 1) self.mpLevel2()
            if(nro == 2) self.mpLevel3()
        }
    }

    // Niveles Single Player

    method spLevel1() {
        const apples = [1,2,3,4,5,6,7,8,9,10,12]
        apples.forEach({ pos =>
            game.addVisual(new Food(position= game.at(pos, pos)))
        })
    }
    method spLevel2() {
        game.addVisual(new Food(position= game.at(6,6)))
        game.addVisual(new Food(position= game.at(6,7)))
        game.addVisual(new Food(position= game.at(7,6)))
        game.addVisual(new Food(position= game.at(7,7)))

        const muros = [5,6,7,8]
        muros.forEach({ pos =>
            game.addVisual(new Wall(position= game.at(5, pos)))
            game.addVisual(new Wall(position= game.at(8, pos)))
        })
    }
    method spLevel3() {
        const apples = [4,6,7,9]
        apples.forEach({ pos =>
            game.addVisual(new Food(position= game.at(3, pos)))
            game.addVisual(new Food(position= game.at(10, pos)))
        })

        const muros = [3,5,8,10]
        muros.forEach({ pos =>
            game.addVisual(new Wall(position= game.at(3, pos)))
            game.addVisual(new Wall(position= game.at(10, pos)))
        })
    }

    // Niveles Multi Player

    method mpLevel1() {
        const apples = [1,3,4,5,6,7,8,9,10,12]
        apples.forEach({ pos =>
            game.addVisual(new Food(position= game.at(pos, pos)))
        })

        game.addVisual(new Ball8(position= game.at(1, 12)))
    }
    method mpLevel2() {
        game.addVisual(new Food(position= game.at(6,6)))
        game.addVisual(new Food(position= game.at(6,7)))
        game.addVisual(new Food(position= game.at(7,6)))
        game.addVisual(new Food(position= game.at(7,7)))

        const muros = [5,6,7,8]
        muros.forEach({ pos =>
            game.addVisual(new Wall(position= game.at(5, pos)))
            game.addVisual(new Wall(position= game.at(8, pos)))
        })

        game.addVisual(new Ball8(position= game.at(1, 12)))
    }
    method mpLevel3() {
        const apples = [4,6,7,9]
        apples.forEach({ pos =>
            game.addVisual(new Food(position= game.at(3, pos)))
            game.addVisual(new Food(position= game.at(10, pos)))
        })

        const muros = [3,5,8,10]
        muros.forEach({ pos =>
            game.addVisual(new Wall(position= game.at(3, pos)))
            game.addVisual(new Wall(position= game.at(10, pos)))
        })

        game.addVisual(new Ball8(position= game.at(1, 12)))
    }

    // Carga los muros limite del mapa
    method loadWalls() {
        const muros = [0,1,2,3,4,5,6,7,8,9,10,11,12]
        const max = game.width() - 1
        muros.forEach({ pos =>
            game.addVisual(new Wall(position= game.at(0, pos)))
            game.addVisual(new Wall(position= game.at(max, pos+1)))
            game.addVisual(new Wall(position= game.at(pos+1, 0)))
            game.addVisual(new Wall(position= game.at(pos, max)))
        })
    }
}