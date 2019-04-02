//
//  Dealer.swift
//  Tiny Blackjack
//
//  Created by Patrick Kalkman on 23/03/2019.
//  Copyright © 2019 SimpleTechture. All rights reserved.
//

import Foundation
import SwiftState

class GameEngine: BlackjackProtocol {

    private var deck: Deck!
    private var players: [Player] = [Player]()
    private var dealer: Player!
    private var gameState: GameStateMachine!
    private var blackjackView: BlackjackViewProtocol?
    private var currentPlayerIndex: Int = 0
    private var currentPlayer: Player!
    private var currentHand: Hand!
    private var currentPlayerHandIndex: Int = 0
    private var gameResultCalculator: GameResultCalculator
    private var numberOfPlayers: UInt8 = 0
    

    init(gameResultCalculator: GameResultCalculator, blackjackView: BlackjackViewProtocol?) {
        self.gameResultCalculator = gameResultCalculator
        self.gameState = GameStateMachine(gameEngine: self)
        self.blackjackView = blackjackView
        
    }

    func getState() -> GameStates {
        return gameState.machine.state
    }

    func triggerEvent(_ event: GameEvents) {
        gameState.triggerEvent(event)
    }
    
    func getPlayerCard(playerIndex: Int, handIndex: Int, cardIndex: Int) -> Card {
        return players[playerIndex].getHand(handIndex: handIndex).getCard(cardIndex: cardIndex)
    }
    
    func getPlayerValue(playerIndex: Int, handIndex: Int) -> UInt8 {
        return players[playerIndex].getHand(handIndex: handIndex).getValue()
    }
    
    func getDealerValue() -> UInt8 {
        return dealer.getHand(handIndex: 0).getValue()
    }
    
    func getDealerCard(cardIndex: Int) -> Card {
        return dealer.getHand(handIndex: 0).getCard(cardIndex: cardIndex)
    }
    
    func start(numberOfPlayers: UInt8) {
        self.numberOfPlayers = numberOfPlayers
        triggerEvent(GameEvents.start)
    }
    
    func restart() {
        dealer.clear()
        for player in players {
            player.clear()
        }
        triggerEvent(GameEvents.nextRound)
    }

    func start() {
        // Add the dealer
        dealer = Player(name: "Dealer", strategy: DealerStrategy(), isDealer: true, isHuman: false)
        // Add the players
        for playerNumber in 1...numberOfPlayers {
            players.append(Player(name: "Player \(playerNumber)", strategy: SimpleStrategy(),
                                  isDealer: false, isHuman: true))
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
        if let view = blackjackView {
            view.dealCards()
        }
        triggerEvent(GameEvents.dealt)
    }

    func dealerBlackjackTest() {
        if dealer.getHand(handIndex: 0).isBlackjack() {
            dealer.getHand(handIndex: 0).setCardsFaceUp()
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


    func selectHand() {
        if currentPlayerHandIndex < currentPlayer.numberOfHands() {
            currentHand = currentPlayer.getHand(handIndex: currentPlayerHandIndex)
            currentPlayerHandIndex += 1
            triggerEvent(GameEvents.playerHandSelected)
        } else {
            currentPlayerIndex += 1
            triggerEvent(GameEvents.playerHandsFinished)
        }
    }
    
    let waitUntilUserInput = DispatchSemaphore(value: 1)

    func playerGetChoice() {
        if !currentPlayer.isHuman {
            let action: ProposedAction = currentPlayer.askAction(ownHand: currentHand,
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
                triggerEvent(GameEvents.doubleDownPlayer)
            default:
                triggerEvent(GameEvents.standPlayer)
            }
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
        blackjackView?.hitPlayer()
        triggerEvent(GameEvents.playerChoose)
    }

    func playerDoubleDown() {
        // double the original bet
        let card: Card = deck.draw()
        currentPlayer.add(handIndex: currentPlayerHandIndex - 1, card: card)
        currentPlayerHandIndex += 1
        triggerEvent(GameEvents.standPlayer)
    }

    func splitHand() {
        // double the bet on the new hand
        currentPlayer.split(handIndex: currentPlayerHandIndex - 1)
        currentPlayerHandIndex = 0
        triggerEvent(GameEvents.playerHandSplitted)
    }

    func hitDealer() {
        let card: Card = deck.draw()
        dealer.add(handIndex: 0, card: card)
        blackjackView?.hitDealer()
        triggerEvent(GameEvents.dealerChoose)
    }

    func calculateResult() {
        gameResultCalculator.calculateAndShowResults(players: players, dealer: dealer)
        triggerEvent(GameEvents.resultsCalculated)
    }
    
    func dealerStart() {
        blackjackView?.dealerStart()
        triggerEvent(GameEvents.dealerChoose)
    }

    func distributeBets() {
        blackjackView?.distributeBets()
        // TODO
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
