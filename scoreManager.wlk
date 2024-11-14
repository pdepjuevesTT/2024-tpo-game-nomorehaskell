object score {
    method startScore(dosJugadores) {
        
        game.addVisual(cartel1Player1)
        game.addVisual(cartel2Player1)

        game.addVisual(unidadesPlayer1)
        game.addVisual(decenasPlayer1)

        if(dosJugadores) {
            game.addVisual(cartel1Player2)
            game.addVisual(cartel2Player2)

            game.addVisual(unidadesPlayer2)
            game.addVisual(decenasPlayer2)
        }
    }

}

object unidadesPlayer1 {
    var property num = 0
    method image() = num.toString() + ".png"
    method position() = game.at(5, 13)
}
object decenasPlayer1 {
    var property num = 0
    method image() = num.toString() + ".png"
    method position() = game.at(4, 13)
}

object unidadesPlayer2 {
    var property num = 0
    method image() = num.toString() + ".png"
    method position() = game.at(11, 13)
}
object decenasPlayer2 {
    var property num = 0
    method image() = num.toString() + ".png"
    method position() = game.at(10, 13)
}

object cartel1Player1 {
    method image() = "Puntos_j1_left.png"
    method position() = game.at(2, 13)
}
object cartel2Player1 {
    method image() = "Puntos_j1_right.png"
    method position() = game.at(3, 13)
}

object cartel1Player2 {
    method image() = "Puntos_j2_left.png"
    method position() = game.at(8, 13)
}
object cartel2Player2 {
    method image() = "Puntos_j2_right.png"
    method position() = game.at(9, 13)
}