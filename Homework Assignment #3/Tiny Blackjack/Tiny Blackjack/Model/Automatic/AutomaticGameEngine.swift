//
//  Dealer.swift
//  Tiny Blackjack
//
//  Created by Patrick Kalkman on 23/03/2019.
//  Copyright © 2019 SimpleTechture. All rights reserved.
//

import Foundation
import SwiftState

class AutomaticGameEngine: BlackjackProtocol {

    private var deck: Deck!
    private var players: [Player] = [Player]()
    private var dealer: Player!
    private var gameState: AutomaticGameStateMachine!
    private var blackjackView: BlackjackViewProtocol?
    private var currentPlayerIndex: Int = 0
    private var currentPlayer: Player!
    private var currentHand: Hand?
    private var currentPlayerHandIndex: Int = 0
    private var gameResultCalculator: GameResultCalculator
    private var numberOfPlayers: UInt8 = 0
    private var initialChipsGenerator: InitialChipsGenerator = InitialChipsGenerator()
    private var manualMode: Bool = false

    init(gameResultCalculator: GameResultCalculator, blackjackView: BlackjackViewProtocol?) {
        self.playResult = [HandResult]()
        self.gameResultCalculator = gameResultCalculator
        self.gameState = AutomaticGameStateMachine(gameEngine: self)
        self.blackjackView = blackjackView
    }
    
    func setManualMode() {
        manualMode = true
    }

    func getState() -> AutomaticGameStates {
        return gameState.machine.state
    }

    func triggerEvent(_ event: AutomaticGameEvents) {
        gameState.triggerEvent(event)
    }

    func addBet(chip: Chip) {
        currentPlayer.betChip(chipToBet: chip)
    }

    func removeBet(chip: Chip) {
        currentPlayer.removeBet(chipToRemove: chip)
    }

    func isLastChip(chip: Chip) -> Bool {
        return currentPlayer.wallet.isLastChip(chip)
    }

    func walletContains(_ chip: Chip) -> Bool {
        return currentPlayer.wallet.hasChip(chip)
    }

    func getPlayerWalletTotal() -> UInt {
        return currentPlayer.wallet.totalValue()
    }

    func getPlayerBetTotal() -> UInt {
        return currentPlayer.betWallets.reduce(0) { $0 + $1.totalValue() }
    }

    func getPlayerCard(playerIndex: Int, handIndex: Int, cardIndex: Int) -> Card {
        return players[playerIndex].getHand(handIndex: handIndex).getCard(cardIndex: cardIndex)
    }

    func getCurrentHand() -> Hand? {
        return currentHand
    }

    func getNextHand() -> Hand {
        return currentPlayer.getHand(handIndex: currentPlayerHandIndex + 1)
    }

    func getPreviousHand() -> Hand {
        return currentPlayer.getHand(handIndex: currentPlayerHandIndex - 1)
    }
    
    func playerHasNoMoreMoney() -> Bool {
        return players[0].wallet.totalValue() <= 0 
    }

    func getPlayerValueString() -> String {
        if let hand = currentHand {
            return getHandValueString(hand: hand)
        }
        return ""
    }

    func getDealerValueString() -> String {
        return getHandValueString(hand: dealer.getHand(handIndex: 0))
    }

    private func getHandValueString(hand: Hand) -> String {
        var valueString: String = String(hand.getValue())

        if hand.isBusted() {
            valueString += " (busted)"
        } else if hand.isBlackjack() {
            valueString += " (blackjack)"
        }

        return valueString
    }

    func getDealerCard(cardIndex: Int) -> Card {
        return dealer.getHand(handIndex: 0).getCard(cardIndex: cardIndex)
    }

    func start(numberOfPlayers: UInt8) {
        self.numberOfPlayers = numberOfPlayers
        triggerEvent(AutomaticGameEvents.start)
    }

    func restart() {
        dealer.clear()
        for player in players {
            player.clear()
        }
        
        if currentPlayer.wallet.totalValue() > 0 {
            triggerEvent(AutomaticGameEvents.nextRound)
        } else {
            players.removeAll()
            triggerEvent(AutomaticGameEvents.noMoreMoney)
        }
        
    }

    func start() {
        // Add the dealer
        dealer = Player(name: "Dealer", strategy: DealerStrategy(), isDealer: true, isHuman: false)
        // Add the players
        for playerNumber in 1...numberOfPlayers {
            let player: Player = Player(name: "Player \(playerNumber)", strategy: BasicStrategy(),
                isDealer: false, isHuman: true)
            player.addChipsToWallet(chipsToAdd: initialChipsGenerator.generateInitialChips())
            players.append(player)
        }

        triggerEvent(AutomaticGameEvents.shuffle)
    }

    func shuffle() {
        deck = Deck()
        deck.shuffle()
        triggerEvent(AutomaticGameEvents.shuffled)
    }

    func checkDeck() {
        if deck.count < 10 {
            deck = Deck()
            deck.shuffle()
        }
        triggerEvent( AutomaticGameEvents.checked)
    }

    func placeBets() {
    }

    func dealCards() {
        
        if manualMode {
            return
        }
        
        for cardCount in 1...2 {
            for player in players {
                player.add(handIndex: 0, card: deck.draw())
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
    }
    
    func dealtCards(playerIndex: Int, card1: Card, card2: Card) {
        players[playerIndex].add(handIndex: 0, card: card1)
        players[playerIndex].add(handIndex: 0, card: card2)
    }
    
    func dealtDealerCards(card: Card) {
        dealer.add(handIndex: 0, card: card)
    }

    func dealerBlackjackTest() {
        if dealer.getHand(handIndex: 0).isBlackjack() {
            dealer.getHand(handIndex: 0).setCardsFaceUp()
            triggerEvent(AutomaticGameEvents.dealerHasBlackjack)
        } else {
            triggerEvent(AutomaticGameEvents.dealerHasNoBlackjack)
        }
    }

    func showDealerBlackjack() {
        blackjackView?.showDealerHasBlackjack()
    }

    func placeBet() {
        if currentPlayerIndex < players.count {
            currentPlayer = players[currentPlayerIndex]
            if !currentPlayer.isHuman {
                currentPlayer.placeBets()
                triggerEvent(AutomaticGameEvents.playerBetPlaced)
            } else {
                // do nothing wait until signal from ui
            }
        } else {
            triggerEvent(AutomaticGameEvents.betsPlaced)
        }
    }

    func allBetsPlaced() {

    }

    func selectPlayer() {
        if currentPlayerIndex < players.count {
            currentPlayer = players[currentPlayerIndex]
            currentPlayerHandIndex = 0
            triggerEvent(AutomaticGameEvents.playerSelected)
        } else {
            triggerEvent(AutomaticGameEvents.allPlayersFinished)
            currentPlayerIndex = 0
            currentPlayerHandIndex = 0
        }
    }

    func selectHand(justSplitted: Bool) {
        print("CurrentPlayerHandIndex \(currentPlayerHandIndex)")
        if currentPlayerHandIndex < currentPlayer.numberOfHands() {

            currentHand = currentPlayer.getHand(handIndex: currentPlayerHandIndex)

            currentPlayerHandIndex += 1

            if currentPlayerHandIndex > 1 && !justSplitted {
                let previousHand: Hand = currentPlayer.getHand(handIndex: currentPlayerHandIndex - 2)
                blackjackView?.selectHand(cardIndex: 1, previousHand: previousHand, currentHand: currentHand)
            } else {
                blackjackView?.selectHand(cardIndex: 1, previousHand: nil, currentHand: nil)
            }

        } else {
            currentPlayerIndex += 1
            triggerEvent(AutomaticGameEvents.playerHandsFinished)
        }
    }

    func playerGetChoice() {
        if !currentPlayer.isHuman {
            guard let hand = currentHand else { return }

            let action: ProposedAction = currentPlayer.askAction(ownHand: hand,
                dealerHand: dealer.getHand(handIndex: 0))
            switch action {
            case ProposedAction.hit:
                triggerEvent(AutomaticGameEvents.hitPlayer)
            case ProposedAction.stand:
                triggerEvent(AutomaticGameEvents.standPlayer)
            case ProposedAction.split:
                triggerEvent(AutomaticGameEvents.splitPlayerHand)
            case ProposedAction.bust:
                triggerEvent(AutomaticGameEvents.bustPlayer)
            case ProposedAction.blackjack:
                triggerEvent(AutomaticGameEvents.playerHasBlackjack)
            case ProposedAction.doubleOrStand:
                triggerEvent(AutomaticGameEvents.doubleDownPlayer)
            case ProposedAction.doubleOrHit:
                triggerEvent(AutomaticGameEvents.doubleDownPlayer)
            default:
                triggerEvent(AutomaticGameEvents.standPlayer)
            }
        } else if isCurrentHandBlackjack() {
            triggerEvent(AutomaticGameEvents.playerHasBlackjack)
        } else if isCurrentHandBusted() {
            triggerEvent(AutomaticGameEvents.bustPlayer)
        } else if currentHandCanSplit() {
            blackjackView?.enableSplit()
        }
    }
    
    func getProposedAction() -> ProposedAction? {
        guard let hand = currentHand else { return nil }
        return currentPlayer.askAction(ownHand: hand, dealerHand: dealer.getHand(handIndex: 0))
    }

    func showSplittedHand() {
        blackjackView?.showSplittedHand()
    }

    func isCurrentHandBusted() -> Bool {
        if let hand = currentHand {
            return hand.isBusted()
        }
        return false
    }

    func isCurrentHandBlackjack() -> Bool {
        if let hand = currentHand {
            return hand.isBlackjack()
        }
        return false
    }

    func isDealerBusted() -> Bool {
        return dealer.getHand(handIndex: 0).isBusted()
    }

    func currentHandCanSplit() -> Bool {
        if let hand = currentHand {
            return hand.canSplit()
        }
        return false
    }

    func dealerGetChoice() {

        let opponent: (Player, Int) = getPlayerWithHighestScore()
        let hand: Hand = opponent.0.getHand(handIndex: opponent.1)

        dealer.getHand(handIndex: 0).setCardsFaceUp()

        let action: ProposedAction = dealer.askAction(handIndex: 0, dealerHand: hand)

        switch action {
        case ProposedAction.hit:
            triggerEvent(AutomaticGameEvents.hitDealer)
        case ProposedAction.stand:
            triggerEvent(AutomaticGameEvents.standDealer)
        case ProposedAction.bust:
            triggerEvent(AutomaticGameEvents.bustDealer)
        default:
            triggerEvent(AutomaticGameEvents.standDealer)
        }
    }

    func hitPlayer() {
        let card: Card = deck.draw()
        currentPlayer.add(handIndex: currentPlayerHandIndex - 1, card: card)
        blackjackView?.hitPlayer()
    }

    func playerDoubleDown() {
        // double the original bet
        let card: Card = deck.draw()
        currentPlayer.add(handIndex: currentPlayerHandIndex - 1, card: card)
        currentPlayerHandIndex += 1
        triggerEvent(AutomaticGameEvents.standPlayer)
    }

    func splitHand() {
        print("Splitting hand \(currentPlayerHandIndex - 1)")
        currentPlayer.split(handIndex: currentPlayerHandIndex - 1)
        currentPlayerHandIndex = currentPlayerHandIndex - 1
        currentHand = currentPlayer.getHand(handIndex: currentPlayerHandIndex)
        triggerEvent(AutomaticGameEvents.playerHandSplitted)
    }

    func hitDealer() {
        let card: Card = deck.draw()
        dealer.add(handIndex: 0, card: card)
        blackjackView?.hitDealer()
    }

    var playResult: [HandResult]

    func calculateResult() {
        playResult = gameResultCalculator.calculateAndShowResults(players: players, dealer: dealer)
        blackjackView?.calculateResult()
        triggerEvent(AutomaticGameEvents.resultsCalculated)
    }

    func getPlayResult() -> [HandResult] {
        return playResult
    }
    
    func getPlayResultMessage() -> String {
        switch playResult[0].result {
        case GameResult.DealerWins:
            return "The dealer wins"
        case GameResult.PlayerWins:
            return "You win!"
        case GameResult.Push:
            return "Push"
        case GameResult.PlayerWinsWithBlackjack:
            return "You win (Blackjack!)"
        }
    }

    func dealerStart() {
        blackjackView?.dealerStart()
        triggerEvent(AutomaticGameEvents.dealerChoose)
    }
    
    func noMoreMoney() {
        blackjackView?.noMoreMoney()
    }

    func distributeBets() {
        for handResult in playResult {
            print("hand result \(handResult)")
            switch handResult.result {
            case GameResult.DealerWins:
                // Just remove the bet from the bet wallet
                players[handResult.playerIndex].clearBet()
            case GameResult.PlayerWins:
                let chips: [Chip] = players[handResult.playerIndex].betWallets[handResult.handIndex].getAll()
                for _ in 1...2 {
                    for chip in chips {
                        players[handResult.playerIndex].wallet.add(chip)
                    }
                }
                players[handResult.playerIndex].clearBet()
            case GameResult.PlayerWinsWithBlackjack:
                // Blackjack pays 3 to 2
                let chips: [Chip] = players[handResult.playerIndex].betWallets[handResult.handIndex].getAll()
                for _ in 1...2 {
                    for chip in chips {
                        players[handResult.playerIndex].wallet.add(chip)
                    }
                }
                for chip in chips {
                    let lowerChips: [Chip] = getHalveChip(chip)
                    players[handResult.playerIndex].wallet.add(lowerChips)
                }

                players[handResult.playerIndex].clearBet()
                print("Total: \(players[handResult.playerIndex].wallet.totalValue())")
            case GameResult.Push:
                let chips: [Chip] = players[handResult.playerIndex].betWallets[handResult.handIndex].getAll()
                for chip in chips {
                    players[handResult.playerIndex].wallet.add(chip)
                }
                players[handResult.playerIndex].clearBet()
            }
        }
        blackjackView?.distributeBets()
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

    func getCurrentPlayerTotal() -> UInt {
        if let player = currentPlayer {
            return player.wallet.totalValue()
        }
        return 0
    }

    func getHalveChip(_ chip: Chip) -> [Chip] {
        var chips: [Chip] = [Chip]()

        switch chip {
        case Chip.darkBlue:
            chips.append(Chip.darkRed)
        case Chip.darkRed:
            chips.append(Chip.purple)
        case Chip.lightBlue:
            chips.append(Chip.pink)
        case Chip.lightRed:
            chips.append(Chip.lightRed)
        case Chip.pink:
            chips.append(Chip.lightRed)
            chips.append(Chip.lightRed)
            chips.append(Chip.lightRed)
        case Chip.purple:
            chips.append(Chip.lightBlue)
            chips.append(Chip.lightBlue)
            chips.append(Chip.lightRed)
            chips.append(Chip.lightRed)
            chips.append(Chip.lightRed)
        case Chip.unknown:
            print("Unknown type of chip")
        }

        return chips
    }

}
