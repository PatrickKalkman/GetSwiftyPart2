//
//  Dealer.swift
//  Tiny Blackjack
//
//  Created by Patrick Kalkman on 23/03/2019.
//  Copyright © 2019 SimpleTechture. All rights reserved.
//

import Foundation

class Game {

    private let deck: Deck
    private var players: [Player] = [Player]()
    private var dealer: Player = Player(name: "Dealer", hand: Hand(), strategy: DealerStrategy(), isDealer: true)

    var gameState: GameState = GameState()

    var numberOfPlayers: Int {
        return players.count
    }

    init(_ deck: Deck) {
        self.deck = deck
    }

    func start(numberOfPlayers: UInt8) throws {
        if gameState.getState() == GameStates.waitingUntilStart {
            addPlayers(numberOfPlayers)
            start()
        } else {
            throw GameError.cannotStartStartedGame
        }
    }

    var currentPlayerIndex: Int = 0

    func playNextRound() {

        let player: Player = getPlayer()

        var action: ProposedAction
        if player.isDealer {
            player.hand.setCardsFaceUp()
            gameState.setState(stateToSet: GameStates.playingDealer)
            action = player.askAction(dealerHand: players[0].hand)
        } else {
            gameState.setState(stateToSet: GameStates.playingPlayer)
            action = player.askAction(dealerHand: dealer.hand)
        }

        while action != ProposedAction.stand && action != ProposedAction.surrender &&
              !player.hand.isBusted() && action != ProposedAction.blackjack {

                if action == ProposedAction.hit {
                    player.add(card: deck.draw())
                    print("\(player.name) -> hit -> \(player.hand.getState())")
                }

                if !player.isBusted() {
                    if !player.isDealer {
                        action = player.askAction(dealerHand: dealer.hand)
                    } else {
                        action = dealer.askAction(dealerHand: players[0].hand)
                    }
                }
                print("Playing another round \(gameState)")
        }
        if !player.isBusted() {
            print("\(player.name) -> \(action)")
        }

        if player.isDealer {
            gameState.setState(stateToSet: GameStates.finished)
        }
        currentPlayerIndex += 1

    }

    private func getPlayer() -> Player {
        if currentPlayerIndex >= players.count {
            return dealer
        } else {
            return players[currentPlayerIndex]
        }
    }

    private func start() {
        gameState.setState(stateToSet: GameStates.started)
        // The game is started by dealing every player 2 cards
        for _ in 1...2 {
            for player in players {
                let card = deck.draw()
                player.add(card: card)
            }
        }
        dealer.add(card: deck.draw())
        let dealerCard2: Card = deck.draw()
        dealerCard2.turnFaceDown()
        dealer.add(card: dealerCard2)
    }

    private func addPlayers(_ numberOfPlayersToAdd: UInt8) {
        for playerNumber in 1...numberOfPlayersToAdd {
            players.append(Player(name: "Player \(playerNumber)", hand: Hand(),
                strategy: SimpleStrategy(), isDealer: false))
        }
    }

    func showState() {
        print("Game state: \(gameState.getState())")
        print(dealer.showState())
        var playerIndex: UInt8 = 1
        for player in players {
            print(player.showState())
            playerIndex += 1
        }
    }

    func result() -> GameResult {

        let player: Player = players[0]

        let playerValue: UInt8 = player.hand.getValue()
        let dealerValue: UInt8 = dealer.hand.getValue()

        print("\(player.name) value: \(playerValue) hand: \(player.hand.getState())")
        print("\(dealer.name) value: \(dealerValue) hand: \(dealer.hand.getState())")

        if dealer.isBusted() {
            return GameResult.playerWins
        }

        if player.isBusted() {
            return GameResult.dealerWins
        }

        if dealerValue > playerValue {
            return GameResult.dealerWins
        }

        if dealerValue == playerValue {
            return GameResult.push
        }

        return GameResult.playerWins
    }

}
