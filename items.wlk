import player.*
import wollok.game.*
import gameConfig.*


class PowerUp{
    var property position = game.at(0.randomUpTo(mapSize - 1), 0.randomUpTo(mapSize - 1))
    var property image
    var property snake = player

    const mapSize = config.mapSize()

    method spawn() {}
    method efect() {}

    method tag() = "item"
}

class Food inherits PowerUp(image = "apple.png"){
    override method tag() = "food"

    override method efect() { // TODO NO ANDA BIEN
        snake.addChild()
    }

    override method spawn(){
        const newItem = new Food()
        game.addVisual(newItem)
    }
}

class Wall inherits PowerUp(image = "wall.png"){ // TODO
    override method efect() {
        gameState.loseGame(player)
    }

    override method spawn(){
        const newItem = new Wall()
        game.addVisual(newItem)
    }
}

class Ball8 inherits PowerUp(image = "ball8.png"){
    override method efect() {
        //gameState.loseGame(player)
    }

    override method spawn(){
        const newItem = new Ball8()
        game.addVisual(newItem)
    }
}