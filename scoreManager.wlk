import gameConfig.*
object score {
    var scorePlayer1 = 0
    var scorePlayer2 = 0

    const winScore = 14

    method startScore(dosJugadores) {
        scorePlayer1 = 0
        scorePlayer2 = 0
        self.resetscore()

        self.drawPlayer1Score()

        if(dosJugadores) {
            self.drawPlayer2Score()
        }
    }

    method addScore(score, numPlayer) {
        if(numPlayer == 1)
            self.addPlayer1Score(score)
        else
            self.addPlayer2Score(score)
    }

    method addPlayer1Score(score) {
        scorePlayer1 += score

        // Controla el numero del contador
        unidadesPlayer1.addScore(score)
        const unidades = unidadesPlayer1.num()

        if(unidades >= 9) {
            unidadesPlayer1.num(0)
            decenasPlayer1.addScore(1)
        }

        // Comprueba si gano
        if(scorePlayer1 >= winScore)
            gameState.winGame(1)
    }

    method addPlayer2Score(score) {
        scorePlayer2 += score

        // Controla el numero del contador
        unidadesPlayer2.addScore(score)
        const unidades = unidadesPlayer2.num()

        if(unidades >= 9) {
            unidadesPlayer2.num(0)
            decenasPlayer2.addScore(1)
        }

        // Comprueba si gano
        if(scorePlayer2 >= winScore)
            gameState.winGame(2)
    }

    method resetscore() {
        unidadesPlayer1.num(0)
        decenasPlayer1.num(0)
        unidadesPlayer2.num(0)
        decenasPlayer2.num(0)
    }

    method drawPlayer1Score() {
        game.addVisual(cartel1Player1)
        game.addVisual(cartel2Player1)

        game.addVisual(unidadesPlayer1)
        game.addVisual(decenasPlayer1)
    }

    method drawPlayer2Score() {
        game.addVisual(cartel1Player2)
        game.addVisual(cartel2Player2)

        game.addVisual(unidadesPlayer2)
        game.addVisual(decenasPlayer2)
    }
}



object unidadesPlayer1 {
    var property num = 0
    method addScore(score) {num += score}
    method image() = num.toString() + ".png"
    method position() = game.at(5, 13)
}
object decenasPlayer1 {
    var property num = 0
    method addScore(score) {num += score}
    method image() = num.toString() + ".png"
    method position() = game.at(4, 13)
}

object unidadesPlayer2 {
    var property num = 0
    method addScore(score) {num += score}
    method image() = num.toString() + ".png"
    method position() = game.at(11, 13)
}
object decenasPlayer2 {
    var property num = 0
    method addScore(score) {num += score}
    method image() = num.toString() + ".png"
    method position() = game.at(10, 13)
}


// Carteles fijos de puntuacion
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