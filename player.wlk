import wollok.game.*

object player inherits Body(position = game.origin()){
  var property dir = "east"

  override method image() = "head-" + dir + ".png"

  override method move(newDir) {
    
    self.changeDirection(newDir)
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