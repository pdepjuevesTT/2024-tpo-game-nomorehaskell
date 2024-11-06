import player.*
import wollok.game.*

class PowerUp{
    var property position
    var property image
    var property snake = player

    method newPosition(){
        position = game.at(1.randomUpTo(15), 1.randomUpTo(15))
    }

    method addPowerUp() {}

    method grow() {}

    method decreaseSpeed(x) {}

    method gameOver() {}
}

class Food inherits PowerUp(image = "apple.png"){
    override method grow() {
        snake.addChild()
    }

    override method addPowerUp() {
        game.addVisual(new Food(position = self.position())) // no funciona, no agrega ningún objeto
    }
}

class Wall inherits PowerUp(image = "wall.png"){
    var property normalSpeed = 10000 // habria que crearla antes en el game principal, la velocidad que se usará en el onTick para moverse

    override method decreaseSpeed(dir) {
        game.schedule(normalSpeed/2, {player.move(dir)})
    }

    override method addPowerUp() {
        game.addVisual(new Wall(position = self.position())) // no funciona, no agrega ningún objeto
    }
}

class Ball8 inherits PowerUp(image = "ball8.png"){

    override method gameOver() {
        game.say(snake,"You lose!")
        game.stop()
    }

    override method addPowerUp() {
        game.addVisual(new Ball8(position = self.position())) // no funciona, no agrega ningún objeto
    }
}