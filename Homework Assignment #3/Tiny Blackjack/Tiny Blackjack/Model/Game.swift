//
//  Dealer.swift
//  Tiny Blackjack
//
//  Created by Patrick Kalkman on 23/03/2019.
//  Copyright © 2019 SimpleTechture. All rights reserved.
//

import Foundation
import SwiftState

class Game: BlackjackProtocol {

    private var deck: Deck!
    private var players: [Player] = [Player]()
    private var dealer: Player!
    private var gameState: GameStateMachine!
    private var currentPlayerIndex: Int = 0
    private var currentPlayer: Player!
    private var currentPlayerHandIndex: Int = 0
    var numberOfPlayers: UInt8 = 3

    init() {
        self.gameState = GameStateMachine(gameEngine: self)
    }
    
    func getState() -> GameStates {
        return gameState.machine.state
    }

    func triggerEvent(_ event: GameEvents) {
        gameState.triggerEvent(event)
    }

    func start() {
        dealer = Player(name: "Dealer", hand: Hand(), strategy: DealerStrategy(), isDealer: true)
        for playerNumber in 1...numberOfPlayers {
            players.append(Player(name: "Player \(playerNumber)", hand: Hand(), strategy: SimpleStrategy(), isDealer: false))
        }

        triggerEvent(GameEvents.shuffle)
    }

    func shuffle() {
        deck = Deck()
        deck.shuffle()
        triggerEvent(GameEvents.shuffled)
    }

    func checkDeck() {
        if deck.count < 10 {
            deck = Deck()
            deck.shuffle()
        }
        triggerEvent(GameEvents.checked)
    }
    
    func placeBets() {
        for player in players {
            player.placeBets()
        }
        triggerEvent(GameEvents.betsPlaced)
    }
    
    func dealCards() {
        for cardCount in 1...2 {
            for player in players {
                let card: Card = deck.draw()
                player.add(handIndex: 0, card: card)
            }
            let card: Card = deck.draw()
            if cardCount == 2 {
                card.turnFaceDown()
            }
            dealer.add(handIndex: 0, card: card)
        }
        triggerEvent(GameEvents.dealt)
    }
    
    func dealerBlackjackTest() {
        if dealer.getHand(handIndex: 0).isBlackjack() {
            triggerEvent(GameEvents.dealerHasBlackjack)
        } else {
            triggerEvent(GameEvents.dealerHasNoBlackjack)
        }
    }

    func selectPlayer() {
        if currentPlayerIndex < players.count {
            currentPlayer = players[currentPlayerIndex]
            currentPlayerHandIndex = 0
            triggerEvent(GameEvents.playerSelected)
        } else {
            triggerEvent(GameEvents.allPlayersFinished)
        }
    }

    var selectedHand: Hand!
    
    func selectHand() {
        if currentPlayerHandIndex < currentPlayer.numberOfHands() {
            selectedHand = currentPlayer.getHand(handIndex: currentPlayerHandIndex)
            currentPlayerHandIndex += 1
            triggerEvent(GameEvents.playerHandSelected)
        } else {
            currentPlayerIndex += 1
            triggerEvent(GameEvents.playerHandsFinished)
        }
    }
    
    func playerGetChoice() {
        let action: ProposedAction = currentPlayer.askAction(ownHand: selectedHand,
                                                             dealerHand: dealer.getHand(handIndex: 0))
        
        switch action {
        case ProposedAction.hit:
            triggerEvent(GameEvents.hitPlayer)
        case ProposedAction.stand:
             triggerEvent(GameEvents.standPlayer)
        case ProposedAction.split:
            triggerEvent(GameEvents.splitPlayerHand)
        case ProposedAction.bust:
            triggerEvent(GameEvents.bustPlayer)
        case ProposedAction.blackjack:
            triggerEvent(GameEvents.playerHasBlackjack)
        case ProposedAction.double:
            triggerEvent(GameEvents.doublePlayer)
        default:
            triggerEvent(GameEvents.standPlayer)
        }
    }

    func dealerGetChoice() {
        
        let opponent: (Player, Int) = getPlayerWithHighestScore()
        let hand: Hand = opponent.0.getHand(handIndex: opponent.1)
        
        dealer.getHand(handIndex: 0).setCardsFaceUp()
        
        let action: ProposedAction = dealer.askAction(handIndex: 0, dealerHand: hand)
        
        switch action {
        case ProposedAction.hit:
            triggerEvent(GameEvents.hitDealer)
        case ProposedAction.stand:
            triggerEvent(GameEvents.standDealer)
        case ProposedAction.bust:
            triggerEvent(GameEvents.bustDealer)
        default:
            triggerEvent(GameEvents.standDealer)
        }
    }

    func hitPlayer() {
        let card: Card = deck.draw()
        currentPlayer.add(handIndex: currentPlayerHandIndex - 1, card: card)
        triggerEvent(GameEvents.playerChoose)
    }

    func splitHand() {
        currentPlayer.split(handIndex: currentPlayerHandIndex)
        triggerEvent(GameEvents.splitPlayerHand)
    }

    func hitDealer() {
        let card: Card = deck.draw()
        dealer.add(handIndex: 0, card: card)
        triggerEvent(GameEvents.dealerChoose)
    }
    
    func calculateResult() {

        for player in players {
            for handIndex in 0...player.numberOfHands() - 1 {
                let playerValue: UInt8 = player.getHand(handIndex: handIndex).getValue()
                let dealerValue: UInt8 = dealer.getHand(handIndex: 0).getValue()
                
                print("\(player.name) value: \(playerValue) hand: \(player.getState())")
                print("\(dealer.name) value: \(dealerValue) hand: \(dealer.getState())")
                
                if dealer.isBusted(handIndex: 0) {
                    print("\(player.name) wins")
                }
                
                if player.isBusted(handIndex: handIndex) {
                    print("\(dealer.name) wins")
                }
                
                if dealerValue > playerValue {
                     print("\(dealer.name) wins")
                }
                
                if dealerValue == playerValue {
                    print("Push")
                }
            }
        }
        triggerEvent(GameEvents.resultsCalculated)
    }
    
    func distributeBets() {
    }
    
    func getPlayerWithHighestScore() -> (Player, Int) {
        var highestValue: UInt8 = 0
        var highestPlayer: Player = players[0]
        var highestHandIndex: Int = 0
        for player in players {
            for handIndex in 0...player.numberOfHands() - 1 {
                let value: UInt8 = player.getHand(handIndex: handIndex).getValue()
                if value > highestValue && value <= 21 {
                    highestValue = value
                    highestPlayer = player
                    highestHandIndex = handIndex
                }
            }
        }
        return (highestPlayer, highestHandIndex)
    }
    
}
