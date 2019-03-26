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
    private var dealer: Player = Player(name: "dealer", hand: Hand(), strategy: DealerStrategy())
    
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

        if currentPlayerIndex < players.count {
            gameState.setState(stateToSet: GameStates.playingPlayer)

            let player: Player = players[currentPlayerIndex]
            var action: ProposedAction = player.askAction(dealerHand: dealer.hand)
            while action != ProposedAction.stand &&
                action != ProposedAction.surrender &&
                player.state != PlayerState.busted &&
                action != ProposedAction.blackjack {

                    if action == ProposedAction.hit {
                        let card = deck.draw()
                        player.add(card: card)
                        print("\(player.name) draw \(card.showState())")
                    }

                    if (!player.isBusted()) {
                        action = player.askAction(dealerHand: dealer.hand)
                    } else {
                        print("\(player.name) is busted")
                        player.setState(PlayerState.busted)
                    }
            }

            currentPlayerIndex += 1
        } else {
            gameState.setState(stateToSet: GameStates.playingDealer)
            print("dealers turns second card face up")
            dealer.hand.setCardsFaceUp()
            dealer.showState()
            
            var action: ProposedAction = dealer.askAction(dealerHand: players[0].hand)
            while action != ProposedAction.stand &&
                action != ProposedAction.surrender &&
                dealer.state != PlayerState.busted &&
                action != ProposedAction.blackjack {

                    if action == ProposedAction.hit {
                        let card = deck.draw()
                        dealer.add(card: card)
                        print("\(dealer.name) draw \(card.showState())")
                    }

                    if (!dealer.isBusted()) {
                        action = dealer.askAction(dealerHand: dealer.hand)
                    } else {
                        print("\(dealer.name) is busted")
                        dealer.setState(PlayerState.busted)
                    }
            }
            
            gameState.setState(stateToSet: GameStates.finished)
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
            players.append(Player(name: "Player \(playerNumber)", hand: Hand(), strategy: SimpleStrategy()))
        }
    }

    func showState() {
        print("Game state: \(gameState.getState()) players: \(numberOfPlayers)")
        print("dealer: ")
        dealer.showState()
        var playerIndex: UInt8 = 1
        for player in players {
            print("player: \(player.name)")
            player.showState()
            playerIndex += 1
        }
    }
}
