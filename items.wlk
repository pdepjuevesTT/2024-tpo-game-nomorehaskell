import scoreManager.*
import player.*
import wollok.game.*
import gameConfig.*


class PowerUp{
    var property image

    var property position = game.at(1.randomUpTo(mapSize - 2), 1.randomUpTo(mapSize - 2))

    const mapSize = game.width()

    method spawn() {}
    method efect(player) {}

    method tag() = "item"
}

class Food inherits PowerUp(image = "apple.png"){
    override method tag() = "food"

    override method efect(player) {
        player.addChild()
    }

    // food.spawn() no funciona por un error interno de Wollok, por lo que se usa un metodo alternativo
}

class Wall inherits PowerUp(image = "wall.png"){
    override method efect(player) {
        const num = player.number()
        gameState.loseGame(num)
    }
}

class Ball8 inherits PowerUp(image = "ball8.png"){
    override method efect(player) {
        const num = player.number()
        if(num == 1) {
            score.addScore(1, 1)
            score.addScore(-1, 2)
        }
        else {
            score.addScore(1, 2)
            score.addScore(-1, 1)
        }
    }

    override method spawn(){
        const newItem = new Ball8()
        game.schedule(1000, {game.addVisual(newItem)})
    }
}