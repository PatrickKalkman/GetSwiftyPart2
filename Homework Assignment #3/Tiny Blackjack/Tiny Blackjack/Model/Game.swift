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
    private var dealer: Player = Player(hand: Hand(), strategy: SimpleStrategy())
    private var gameState: GameState = GameState()

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
        let player: Player = players[currentPlayerIndex]
        var action: ProposedAction = player.askAction(dealerHand: dealer.hand)
        while action != ProposedAction.stand && action != ProposedAction.surrender && player.state != PlayerState.busted {
            
            if action == ProposedAction.hit && player.state != PlayerState.busted {
                let card = deck.draw()
                player.add(card: card)
                print("Player got a \(card.showState())")
            }
            
            if (!player.isBusted()) {
                action = player.askAction(dealerHand: dealer.hand)
            }
            else {
                player.setState(PlayerState.busted)
            }
        }
        
        currentPlayerIndex += 1
        if currentPlayerIndex > players.count - 1 {
            currentPlayerIndex = 0
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
        dealerCard2.setInvisible()
        dealer.add(card: dealerCard2)
    }

    private func addPlayers(_ numberOfPlayersToAdd: UInt8) {
        for _ in 1...numberOfPlayersToAdd {
            players.append(Player(hand: Hand(), strategy: SimpleStrategy()))
        }
    }

    func showState() {
        print("Game state: \(gameState.getState()) players: \(numberOfPlayers)")
        print("dealer: ")
        dealer.showState()
        var playerIndex: UInt8 = 1
        for player in players {
            print("player: \(playerIndex)")
            player.showState()
            playerIndex += 1
        }
    }
}
