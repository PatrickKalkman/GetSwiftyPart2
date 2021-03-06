//
//  BasicStrategyViewController.swift
//  Tiny Blackjack
//
//  Created by Patrick Kalkman on 14/04/2019.
//  Copyright © 2019 SimpleTechture. All rights reserved.
//

import Foundation
import UIKit
import SwiftySound

class BasicStrategyViewController: BlackjackViewControllerBase, BlackjackViewProtocol {
    
    private let cardToImageNameMapper: CardToImageNameMapper = CardToImageNameMapper()
    private let soundManager: SoundManager = SoundManager()
    private let proposedActionNotification: ProposedActionNotification = ProposedActionNotification()
    private let imageCardFaceDown: UIImage = UIImage(named: Constants.Assets.FacedownCard)!
    private var gameEngine: AutomaticGameEngine!
    private var dealerCardIndex: Int = 1
    private var playerCardIndex: Int = 2
    
    private var addedCards: [UIImageView] = [UIImageView]()
    
    private var dealerCard2ImageView: UIImageView!
    
    @IBOutlet weak var deckCard: UIImageView!
    @IBOutlet weak var dealButton: BorderButton!
    @IBOutlet weak var splitButton: BorderButton!
    @IBOutlet weak var standButton: BorderButton!
    @IBOutlet weak var hitButton: BorderButton!
    @IBOutlet weak var playerValueLabel: UILabel!
    @IBOutlet weak var dealerValueLabel: UILabel!
    @IBOutlet weak var restartButton: BorderButton!
    @IBOutlet weak var playResultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTitle("LEARN BASIC STRATEGY")
        self.organizeUiBasedOnState(state: AutomaticGameStates.started)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        gameEngine = AutomaticGameEngine(gameResultCalculator: GameResultCalculator(), blackjackView: self)

        soundManager.prepare()
        gameEngine.start(numberOfPlayers: 1)
    }
    
    @IBAction func deal(_ sender: Any) {
        soundManager.playShuffle(completion: { _ in
            self.gameEngine.triggerEvent(AutomaticGameEvents.betsPlaced)
            self.gameEngine.triggerEvent(AutomaticGameEvents.dealCards)
        })
    }
    
    @IBAction func restartGame(_ sender: UIButton) {
        playerCardIndex = 2
        dealerCardIndex = 1
        
        for subview in addedCards {
            subview.removeFromSuperview()
        }
        
        restartButton.hideWithAnimation(hidden: true)
        self.organizeUiBasedOnState(state: AutomaticGameStates.started)
        self.gameEngine.restart()
        self.deal(sender)
    }
    
    @IBAction func hitPlayer(_ sender: Any) {
        showLearningMessage(userAction: ProposedAction.hit)
        gameEngine.triggerEvent(AutomaticGameEvents.hitPlayer)
    }
    
    @IBAction func standPlayer(_ sender: Any) {
        showLearningMessage(userAction: ProposedAction.stand)
        gameEngine.triggerEvent(AutomaticGameEvents.standPlayer)
    }
    
    @IBAction func splitPlayer(_ sender: Any) {
        showLearningMessage(userAction: ProposedAction.split)
        gameEngine.triggerEvent(AutomaticGameEvents.splitPlayerHand)
    }
    
    func showLearningMessage(userAction: ProposedAction) {
        if let basicStrategyProposedAction: ProposedAction = gameEngine.getProposedAction() {
            proposedActionNotification.showMessage(userAction: userAction, proposedAction: basicStrategyProposedAction)
        }
    }
    
    func organizeUiBasedOnState(state: AutomaticGameStates) {
        switch state {
        case AutomaticGameStates.started:
            self.dealButton.hideWithAnimation(hidden: false)
            self.restartButton.hideWithAnimation(hidden: true)
            playResultLabel.hideWithAnimation(hidden: true)
            playerValueLabel.hideWithAnimation(hidden: true)
            dealerValueLabel.hideWithAnimation(hidden: true)
        case AutomaticGameStates.dealCards:
            playerValueLabel.hideWithAnimation(hidden: true)
            dealerValueLabel.hideWithAnimation(hidden: true)
            dealButton.hideWithAnimation(hidden: true)
            splitButton.hideWithAnimation(hidden: true)
            hitButton.hideWithAnimation(hidden: false)
            standButton.hideWithAnimation(hidden: false)
            restartButton.hideWithAnimation(hidden: true)
            playResultLabel.hideWithAnimation(hidden: true)
            self.setTitle("")
        case AutomaticGameStates.distributeBets:
            dealButton.hideWithAnimation(hidden: true)
            splitButton.hideWithAnimation(hidden: true)
            hitButton.hideWithAnimation(hidden: true)
            standButton.hideWithAnimation(hidden: true)
            restartButton.hideWithAnimation(hidden: false)
            playResultLabel.hideWithAnimation(hidden: false)
            self.navigationItem.title = ""
        default:
            dealButton.isHidden = true
        }
    }
    
    func start() {
    }
    
    func shuffle() {
    }
    
    func placeBets() {
    }
    
    func enableSplit() {
        splitButton.hideWithAnimation(hidden: false)
    }
    
    func dealCards() {
        
        // The game engine already has dealt the cards
        // Here we instruct the UI to show the dealing of the first cards using animation
        self.dealButton.hideWithAnimation(hidden: true)
        self.organizeUiBasedOnState(state: AutomaticGameStates.dealCards)
        
        let player1Card1ImageView: UIImageView = getNewCardFromDeckFaceDown()
        let card1: Card = gameEngine.getPlayerCard(playerIndex: 0, handIndex: 0, cardIndex: 0)
        player1Card1ImageView.tag = card1.index
        let imageCardFaceUp: UIImage = getCardImage(card1)
        
        let player1Card2ImageView: UIImageView = getNewCardFromDeckFaceDown()
        let card2: Card = self.gameEngine.getPlayerCard(playerIndex: 0, handIndex: 0, cardIndex: 1)
        player1Card2ImageView.tag = card2.index
        let imageCard2FaceUp: UIImage = getCardImage(card2)
        
        UIImageView.animate(withDuration: Constants.Animation.DealCardDuraction, delay: 0, options: .curveEaseInOut, animations: {
            player1Card1ImageView.setOrigin(Constants.Positions.FirstPlayerCard)
        }, completion: { _ in
            
            UIImageView.transition(with: player1Card1ImageView, duration: Constants.Animation.FlipCardDuration,
                                   options: .transitionFlipFromLeft, animations: { player1Card1ImageView.image = imageCardFaceUp },
                                   completion: { _ in
                                    
                                    self.soundManager.playCard()

                                    let dealerCard1ImageView: UIImageView = self.getNewCardFromDeckFaceDown()
                                    let dealerCard1FaceUp: UIImage = self.getCardImage(self.gameEngine.getDealerCard(cardIndex: 0))
                                    
                                    UIImageView.animate(withDuration: Constants.Animation.DealCardDuraction, delay: 0, options: .curveEaseInOut, animations: {
                                        dealerCard1ImageView.setOrigin(Constants.Positions.FirstDealerCard)
                                    }, completion: { _ in
                                        
                                        self.soundManager.playCard()
                                        UIImageView.transition(with: dealerCard1ImageView, duration: Constants.Animation.FlipCardDuration, options: .transitionFlipFromLeft,
                                                               animations: { dealerCard1ImageView.image = dealerCard1FaceUp },
                                                               completion: { _ in
                                                                
                                                                UIImageView.animate(withDuration: Constants.Animation.DealCardDuraction, delay: 0, options: .curveEaseInOut, animations: {
                                                                    player1Card2ImageView.setOrigin(Constants.Positions.SecondPlayerCard)
                                                                }, completion: { _ in
                                                                    self.soundManager.playCard()
                                                                    UIImageView.transition(with: player1Card2ImageView,
                                                                                           duration: Constants.Animation.FlipCardDuration, options: .transitionFlipFromLeft,
                                                                                           animations: { player1Card2ImageView.image = imageCard2FaceUp },
                                                                                           completion: { _ in
                                                                                            
                                                                                            self.dealerCard2ImageView = self.getNewCardFromDeckFaceDown()
                                                                                            
                                                                                            UIImageView.animate(withDuration: Constants.Animation.DealCardDuraction, delay: 0.1, options: .curveEaseInOut, animations: {
                                                                                                self.dealerCard2ImageView.setOrigin(Constants.Positions.SecondDealerCard)
                                                                                            }, completion: { _ in
                                                                                                
                                                                                                self.gameEngine.triggerEvent(AutomaticGameEvents.dealt)
                                                                                                self.showAndRefreshValues()
                                                                                            })
                                                                    })
                                                                })
                                        })
                                    })
            })
        })
    }
    
    func showSplittedHand() {
        
        // Hand is already splitted, show the splitted hand
        let nextHand = gameEngine.getNextHand()
        moveHand(handToMove: nextHand, xMove: 0, yMove: 210, completion: { _ in
            let currentHand = self.gameEngine.getCurrentHand()
            self.moveHand(handToMove: currentHand, xMove: -40, yMove: 0, completion: { _ in
                self.gameEngine.triggerEvent(AutomaticGameEvents.playerShowSplittedHandFinished)
                self.organizeUiBasedOnState(state: AutomaticGameStates.dealCards)
                self.playerCardIndex = 1
            })
        })
    }
    
    func noMoreMoney() {
    }
    
    func dealerBlackjackTest() {
    }
    
    func selectPlayer() {
    }
    
    func calculateResult() {
        dealerValueLabel.fadeTransition(0.6)
        dealerValueLabel.text = self.gameEngine.getDealerValueString()
        playResultLabel.fadeTransition(0.6)
        playResultLabel.text = gameEngine.getPlayResultMessage()
    }
    
    func selectHand(cardIndex: Int, previousHand: Hand?, currentHand: Hand?) {
        
        // Move previous hand to side spot and move current to main spot
        self.moveHand(handToMove: previousHand, xMove: -360, yMove: -130, completion: { _ in
            self.playerCardIndex = cardIndex
            self.showAndRefreshValues()
        })
        
        moveHand(handToMove: currentHand, xMove: 0, yMove: -210)
        self.gameEngine.triggerEvent(AutomaticGameEvents.playerHandSelected)
    }
    
    func playerGetChoice() {
    }

    func dealerStart() {
        let dealerCardFaceUp: UIImage = getCardImage(self.gameEngine.getDealerCard(cardIndex: dealerCardIndex))
        self.soundManager.playCard()
        UIImageView.transition(with: dealerCard2ImageView, duration: Constants.Animation.FlipCardDuration,
                               options: .transitionFlipFromLeft, animations: { self.dealerCard2ImageView.image = dealerCardFaceUp },
                               completion: { _ in
                                self.dealerCardIndex += 1
                                self.showAndRefreshValues()
                                self.gameEngine.triggerEvent(AutomaticGameEvents.turnDealerCardFaceUp)
        })
    }
    
    func showDealerHasBlackjack() {
        let dealerCardFaceUp: UIImage = getCardImage(self.gameEngine.getDealerCard(cardIndex: dealerCardIndex))
        
        UIImageView.transition(with: dealerCard2ImageView, duration: Constants.Animation.FlipCardDuration,
                               options: .transitionFlipFromLeft, animations: { self.dealerCard2ImageView.image = dealerCardFaceUp },
                               completion: { _ in
                                self.showAndRefreshValues()
                                self.gameEngine.triggerEvent(AutomaticGameEvents.dealerHasBlackjackIsShown)
        })
    }
    
    func dealerGetChoice() {
    }
    
    func hitPlayer() {
        guard let currentHand = gameEngine.getCurrentHand() else { return }
        
        let newCard: Card = currentHand.getCard(cardIndex: playerCardIndex)
        let imageCardFaceUp: UIImage = getCardImage(newCard)
        let playerCardImageView: UIImageView = getNewCardFromDeckFaceDown()
        playerCardImageView.tag = newCard.index
        
        UIImageView.animate(withDuration: Constants.Animation.DealCardDuraction, delay: 0, options: .curveEaseInOut, animations: {
            playerCardImageView.frame.origin.y = Constants.Positions.FirstCardY
            playerCardImageView.frame.origin.x = CGFloat(Constants.Positions.FirstCardX + CGFloat(self.playerCardIndex) * Constants.Positions.CardXDifference)
        }, completion: { _ in
            self.soundManager.playCard()
            UIImageView.transition(with: playerCardImageView, duration: Constants.Animation.FlipCardDuration, options: .transitionFlipFromLeft,
                                   animations: { playerCardImageView.image = imageCardFaceUp }, completion: { _ in
                                    
                                    self.playerCardIndex += 1
                                    self.showAndRefreshValues()
                                    self.gameEngine.triggerEvent(AutomaticGameEvents.playerChoose)
            })
            
        })
    }
    
    func playerDoubleDown() {
    }
    
    func splitHand() {
    }
    
    func hitDealer() {
        let imageCardFaceUp: UIImage = getCardImage(gameEngine.getDealerCard(cardIndex: dealerCardIndex))
        let dealerCardImageView: UIImageView = getNewCardFromDeckFaceDown()
        
        UIImageView.animate(withDuration: Constants.Animation.DealCardDuraction, delay: 0, options: .curveEaseInOut, animations: {
            dealerCardImageView.frame.origin.y = 80
            dealerCardImageView.frame.origin.x = CGFloat(400 + self.dealerCardIndex * 40)
        }, completion: { _ in
            self.soundManager.playCard()
            UIImageView.transition(with: dealerCardImageView, duration: Constants.Animation.FlipCardDuration,
                                   options: .transitionFlipFromLeft, animations: { dealerCardImageView.image = imageCardFaceUp },
                                   completion: { _ in
                                    self.dealerCardIndex += 1
                                    self.showAndRefreshValues()
                                    self.gameEngine.triggerEvent(AutomaticGameEvents.dealerChoose)
                                    
            })
            
        })
    }
    
    func distributeBets() {
        organizeUiBasedOnState(state: AutomaticGameStates.distributeBets)
    }
    
    func getNewCardFromDeckFaceDown() -> UIImageView {
        let cardImageView: UIImageView = UIImageView(image: imageCardFaceDown)
        cardImageView.frame = CGRect(x: deckCard.frame.origin.x, y: deckCard.frame.origin.y, width: deckCard.frame.size.width, height: deckCard.frame.size.height)
        addedCards.append(cardImageView)
        view.addSubview(cardImageView)
        return cardImageView
    }
    
    func getCardImage(_ card: Card) -> UIImage {
        let imageName: String = cardToImageNameMapper.map(card)
        return UIImage(named: imageName)!
    }
    
    func showAndRefreshValues() {
        self.playerValueLabel.fadeTransition(0.6)
        self.playerValueLabel.text = self.gameEngine.getPlayerValueString()
        self.dealerValueLabel.fadeTransition(0.6)
        self.dealerValueLabel.text = self.gameEngine.getDealerValueString()
        self.playerValueLabel.hideWithAnimation(hidden: false)
        self.dealerValueLabel.hideWithAnimation(hidden: false)
    }
    
    func moveHand(handToMove: Hand?, xMove: CGFloat, yMove: CGFloat, completion: ((Bool) -> Void)? = nil) {
        if let hand = handToMove {
            let cardViewIndex: [Int] = hand.getAllCardsIndex()
            
            for cardIndex in cardViewIndex {
                if let cardImage = view.viewWithTag(cardIndex) as? UIImageView {
                    UIImageView.animate(withDuration: Constants.Animation.SplitMoveCardDuration, delay: 0, options: .curveEaseInOut, animations: {
                        cardImage.moveXY(xMove, yMove)
                    }, completion: { input in
                        if let complete = completion {
                            complete(input)
                        }
                    })
                }
            }
        }
    }

}
