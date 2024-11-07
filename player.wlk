import wollok.game.*

object player inherits Body(position = game.at(1,1)){
  var property dir = "east"

  override method image() = "head_" + dir + ".png"

  override method move(x) {
    prevPosition = position

    var newX = position.x()
    var newY = position.y()

    if(dir == "south") newY -= 1
    if(dir == "north") newY += 1
    if(dir == "east") newX += 1
    if(dir == "west") newX -= 1

    position = game.at(newX, newY)

    if(hasChild)
      childBody.move(prevPosition)
  }

  method changeDirection(newDir) {
    dir = newDir
  }
}

class Body {
  var property position
  var property prevPosition = position

  var property childBody = null
  var property hasChild = false

  method image() = "body.png"

  method move(newPos) {
    prevPosition = position
    position = newPos
    if(hasChild)
      childBody.move(prevPosition)
  }

  method addChild() {
    if(hasChild)
      childBody.addChild()
    else    
      childBody = new Body(position= prevPosition)
      game.addVisual(childBody)
      hasChild = true
  }
}