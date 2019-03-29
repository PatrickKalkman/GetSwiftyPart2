//
//  Dealer.swift
//  Tiny Blackjack
//
//  Created by Patrick Kalkman on 23/03/2019.
//  Copyright © 2019 SimpleTechture. All rights reserved.
//

import Foundation
import SwiftState

class Game : BlackjackProtocol {

    private let deck: Deck
    private var players: [Player] = [Player]()
    private var dealer: Player!
    private var gameState: GameStateMachine!

    init(_ deck: Deck) {
        self.deck = deck
        self.gameState = GameStateMachine(gameEngine: self)
    }
    
    func triggerEvent(_ event: GameEvents) {
        gameState.triggerEvent(event)
    }
    
    func start(_ context: Machine<GameStates, GameEvents>.Context) {
    }
    
    func shuffle(_ context: Machine<GameStates, GameEvents>.Context) {
    }
    
    func checkDeck(_ context: Machine<GameStates, GameEvents>.Context) {

    }
    
    func placeBets(_ context: Machine<GameStates, GameEvents>.Context) {

    }
    
    func dealCards(_ context: Machine<GameStates, GameEvents>.Context) {

    }
    
    func dealerBlackjackTest(_ context: Machine<GameStates, GameEvents>.Context) {

    }
    
    func selectPlayer(_ context: Machine<GameStates, GameEvents>.Context) {

    }
    
    func calculateResult(_ context: Machine<GameStates, GameEvents>.Context) {

    }
    
    func selectHand(_ context: Machine<GameStates, GameEvents>.Context) {

    }
    
    func playerGetChoice(_ context: Machine<GameStates, GameEvents>.Context) {

    }
    
    func dealerGetChoice(_ context: Machine<GameStates, GameEvents>.Context) {

    }
    
    func hitPlayer(_ context: Machine<GameStates, GameEvents>.Context) {

    }
    
    func splitHand(_ context: Machine<GameStates, GameEvents>.Context) {

    }
    
    func hitDealer(_ context: Machine<GameStates, GameEvents>.Context) {

    }
    
    func distributeBets(_ context: Machine<GameStates, GameEvents>.Context) {

    }
    
    
}









//
//
//
//
//var numberOfPlayers: Int {
//    return players.count
//}
//
//init(_ deck: Deck) {
//    self.deck = deck
//    self.gameState = GameStateMachine(gameEngine: self)
//}
//
//func start(numberOfPlayers: UInt8) {
//    gameState.blackjackStateMachine <-! .start
//}
//
//var currentPlayerIndex: Int = 0
////
////    func playRound() {
////
////        let player: Player = getPlayer()
////        let opponent: Player = getOpponent()
////
////        var action: ProposedAction = player.askAction(handIndex: 0, dealerHand: opponent.getHand(handIndex: 0))
////
////        while action != ProposedAction.stand && action != ProposedAction.surrender &&
////              !player.getHand(handIndex: 0).isBusted() && action != ProposedAction.blackjack {
////
////                if action == ProposedAction.hit {
////                    player.add(handIndex: 0, card: deck.draw())
////                    print("\(player.name) -> hit -> \(player.getHand(handIndex: 0).getState())")
////                }
////
////                if !player.isBusted(handIndex: 0) {
////                    action = player.askAction(handIndex: 0, dealerHand: opponent.getHand(handIndex: 0))
////                }
////                print("Playing another round \(gameState)")
////        }
////
////        if !player.isBusted(handIndex: 0) {
////            print("\(player.name) -> \(action)")
////        }
////
////        if player.isDealer {
////            gameState.setState(stateToSet: GameStates.finished)
////        }
////
////        currentPlayerIndex += 1
////    }
//
//private func getPlayer() -> Player {
//    if currentPlayerIndex >= players.count {
//        dealer.getHand(handIndex: 0).setCardsFaceUp()
//        return dealer
//    } else {
//        return players[currentPlayerIndex]
//    }
//}
//
//private func getOpponent() -> Player {
//    if currentPlayerIndex >= players.count {
//        return players[0]
//    } else {
//        return dealer
//    }
//}
//
////    private func start() {
////        gameState.setState(stateToSet: GameStates.started)
////        // The game is started by dealing every player 2 cards
////        for _ in 1...2 {
////            for player in players {
////                let card = deck.draw()
////                player.add(handIndex: 0, card: card)
////            }
////        }
////        dealer.add(handIndex: 0, card: deck.draw())
////        let dealerCard2: Card = deck.draw()
////        dealerCard2.turnFaceDown()
////        dealer.add(handIndex: 0, card: dealerCard2)
////    }
////
////    private func addPlayers(_ numberOfPlayersToAdd: UInt8) {
////        for playerNumber in 1...numberOfPlayersToAdd {
////            players.append(Player(name: "Player \(playerNumber)", hand: Hand(),
////                strategy: SimpleStrategy(), isDealer: false))
////        }
////    }
//
//func showState() {
//    print("Game state: \(gameState.blackjackStateMachine.state)")
//    print(dealer.getState())
//    var playerIndex: UInt8 = 1
//    for player in players {
//        print(player.getState())
//        playerIndex += 1
//    }
//}
//
//func result() -> GameResult {
//
//    let player: Player = players[0]
//
//    let playerValue: UInt8 = player.getHand(handIndex: 0).getValue()
//    let dealerValue: UInt8 = dealer.getHand(handIndex: 0).getValue()
//
//    print("\(player.name) value: \(playerValue) hand: \(player.getState())")
//    print("\(dealer.name) value: \(dealerValue) hand: \(dealer.getState())")
//
//    if dealer.isBusted(handIndex: 0) {
//        return GameResult.playerWins
//    }
//
//    if player.isBusted(handIndex: 0) {
//        return GameResult.dealerWins
//    }
//
//    if dealerValue > playerValue {
//        return GameResult.dealerWins
//    }
//
//    if dealerValue == playerValue {
//        return GameResult.push
//    }
//
//    return GameResult.playerWins
//}
