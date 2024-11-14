import player.*
import wollok.game.*
import gameConfig.*


class PowerUp{
    var property image

    var property position = self.findEmptyPos()

    method findEmptyPos() {
        var pos = game.at(1.randomUpTo(mapSize - 2), 1.randomUpTo(mapSize - 2))
        return pos
    }

    const mapSize = game.width()

    method spawn() {}
    method efect(player) {}

    method tag() = "item"
}

class Food inherits PowerUp(image = "apple.png"){
    override method tag() = "food"

    override method efect(player) { // TODO NO ANDA BIEN
        player.addChild()
    }

    // food.spawn() no funciona por un error interno de Wollok, por lo que se usa un metodo alternativo
}

class Wall inherits PowerUp(image = "wall.png"){ // TODO
    override method efect(player) {
        gameState.loseGame()
    }
}

class Ball8 inherits PowerUp(image = "ball8.png"){
    override method efect(player) {
        //gameState.loseGame()
    }

    override method spawn(){
        const newItem = new Ball8()
        game.addVisual(newItem)
    }
}